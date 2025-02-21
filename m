Return-Path: <netdev+bounces-168333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30515A3E948
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E5168BE1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA52E17996;
	Fri, 21 Feb 2025 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uugcRkVn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2D4111AD;
	Fri, 21 Feb 2025 00:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740098586; cv=none; b=RcFhZrbkKLHuQ5FF6cI3wSm7aZJ+Px3fkAK9gRnWk8uipUGFlhduVeN+ZiSu4mPV1D9EnmvVr+o0BIK6SMdkn+SifdYA/d91xfS+duw3emF3xvAJUzge8U0Haz9vQm9l0sX3IfaqM3sRBYFvRCwMiBfcwzp4XGf0V5lOyUcn4sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740098586; c=relaxed/simple;
	bh=bm2GNuKGMArYHLkZLSEyyyMPgZwaWoxFlavWYuhtoj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQQTf31fL1SNdPUSynqWoveYM8wJyXooec3zxcioy3F00JczmadqOt0QrWOgNlUEYxeo6KrXcdsRsJlY/Jb8DkpXMKSslpHw8GJBErWJUmQLWS5Qm4jFW4wHPzKbfpDfJwb7a3ZT02DHL3gR+oXVfn9t3yad9br3LTk+58UbZW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uugcRkVn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3A3C4CED1;
	Fri, 21 Feb 2025 00:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740098585;
	bh=bm2GNuKGMArYHLkZLSEyyyMPgZwaWoxFlavWYuhtoj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uugcRkVnLwQkRhbGgTXV/hLlI185z08gAjHXyNJbPeglFEXhuueIgQQ3LV1zqhmQA
	 g+AildRnhupzButH8I6FVqr/dmOz1EQwxBGhz3E7xfe8t4kSrcVYxMiuADuOc+QoBb
	 M3muPr/qDDDYFZTVWwcthvLuul00/Uvn/9F56zlaNphLeX05sbDbazo9ygxG93IyXS
	 N0xzKFZNmuejYq3FWpUsKDefdhzxFlkTPaDbnQ3ABagj8h0Byjh54TSNL1hqLhxkmH
	 V7DAeZdFWkV/U0SJLAvCIxX8aB53upMHM9yJHRQ2MNWpQma3CqsnexNGkLtj08s+Jt
	 vQrIDBigM1nOw==
Date: Thu, 20 Feb 2025 16:43:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 04/12] net: pse-pd: Add support for PSE
 power domains
Message-ID: <20250220164304.10dd2ef8@kernel.org>
In-Reply-To: <20250218-feature_poe_port_prio-v5-4-3da486e5fd64@bootlin.com>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-4-3da486e5fd64@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 17:19:08 +0100 Kory Maincent wrote:
> +	ret = pse_register_pw_ds(pcdev);
> +
> +	if (ret)
> +		return ret;

nit: unnecessary empty line

