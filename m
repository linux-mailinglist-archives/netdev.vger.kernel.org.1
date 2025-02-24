Return-Path: <netdev+bounces-169207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EC8A42F71
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C98C3B1D70
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E961D5159;
	Mon, 24 Feb 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="inVCMONi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED8F1632C8;
	Mon, 24 Feb 2025 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740433672; cv=none; b=JPBoeeki4GmGa8Mzhn/6fDzxoodGo6TBquyfo7ezcHccy28+2sVToWNF90iapjlxzAvF7yMJf7Z3TFYKMzgq5BGJDx3cmFnLqGihW/QgG0QHWGaJkaP+8aVZIvHk/yStBhCPjjzLf1zC/Spt/NHJeaMl6yVg0BSmLKIqqk1cn4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740433672; c=relaxed/simple;
	bh=/cPxEnTLYXsaaucWazF7HgCjLVnxBn/DHB1hHwTB25g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBzQqu6eV9Z5tEKJ49It7c2sd3qSfSlxLAAyCocX26vAy9dcqEAs0g0OTC3cUSw/9OahonLNhCmIL+8bl4TaJTQS9ovOYohGHWl+8ja6mv5z9vZg0+8wyw6PtKScekMEOvVrESDGAI3a5kkmaTNOudPVsRjElunX4/g4HWpYmMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=inVCMONi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E6DC4CED6;
	Mon, 24 Feb 2025 21:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740433672;
	bh=/cPxEnTLYXsaaucWazF7HgCjLVnxBn/DHB1hHwTB25g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=inVCMONi+jMuKAn81hV6DVYa/3fvOsSOHt4VZz0rsCiYPJDKneDNSVzE4PS8Ayxxt
	 XdTgbBENGy+oTK3PMJmrVaDyKoLv6CXz5mHbIZQIbB8zvAb2Vlj4KvbBJJQrSofL8U
	 4YZeZDVuH7ozu4iJgW6YOz/0oCn+tbsacQIAboX/J7bPfmZxePZBEsafsZww+Xpvyv
	 M8g0NhiyNcfB+L0FtLe2piRdQPDI87vtgYbw5PQsQC69C6wDjo0XDvDH6bs55KjyXJ
	 yL7BMm4vNzsd3pi2YRXqWu7G1DuT8MmS+4yQmurNPKiPP1dnq7YFAVivaULdMAzKxP
	 iRGhFrzt9UwgA==
Date: Mon, 24 Feb 2025 13:47:50 -0800
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
Subject: Re: [PATCH net-next v5 02/12] net: pse-pd: Add support for
 reporting events
Message-ID: <20250224134750.5e502a4c@kernel.org>
In-Reply-To: <20250224133312.008291bc@kmaincent-XPS-13-7390>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-2-3da486e5fd64@bootlin.com>
	<20250220164201.469fdf6d@kernel.org>
	<20250224133312.008291bc@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Feb 2025 13:33:12 +0100 Kory Maincent wrote:
> > On Tue, 18 Feb 2025 17:19:06 +0100 Kory Maincent wrote:  
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > > 
> > > Add support for devm_pse_irq_helper() to register PSE interrupts. This aims
> > > to report events such as over-current or over-temperature conditions
> > > similarly to how the regulator API handles them but using a specific PSE
> > > ethtool netlink socket.    
> > 
> > I think you should CC HWMON ML on this.
> > Avoid any surprises.  
> 
> You mean regulator maintainers right?

Fair point, I'm not sure who's responsible for reporting over-current
on a regulator. My intuition would be HWMON, but no idea if it was ever
discussed. So maybe CC both lists?

