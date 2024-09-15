Return-Path: <netdev+bounces-128421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE79797BA
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737992819D4
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 16:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EDE1C8FA1;
	Sun, 15 Sep 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCYZmgeZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A407618B04;
	Sun, 15 Sep 2024 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726416396; cv=none; b=uq8oc1q3qOONZUWce4AsLPD6nAwnPdNAx43yfyFpf9Jnm0+uHw4BgvwokFiQV43LES3rTp3qB62W7qtxD/Of9WtWeQUTFvJ40fhbFLfcwc9X15iTjULM/P5gEQ6FGcraPADyR9e0daOIFD5GnJny216O4r9b5rRFcn0h02z4qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726416396; c=relaxed/simple;
	bh=IhXv+HEHL3ZRhBh/UywVQJpr8sRjPxDy0LBFr2Du4PY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqnCv2c7MpqvZschmU4hzMovowV8UsiJu5fw1AP6+JAdjBPLmVQrdyLZkdbRZhXuOqDCaqrCN8qfFyj5URUmno7pcJrcDmWd6WDDa5imc61kL2Ut23iWpesHP1DWcPLCeJrs1UV0lZY4R5R7LTgNf874GLMotZnifZ/pdd3uSGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCYZmgeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A816C4CEC3;
	Sun, 15 Sep 2024 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726416396;
	bh=IhXv+HEHL3ZRhBh/UywVQJpr8sRjPxDy0LBFr2Du4PY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCYZmgeZeIEv19u1rzfJZ2xLSLleFV5GFU5pDcyDCNCvO7FU+5IWeZv1c0eN3N370
	 BMsvb/tlXh+IRkYmJ3NAZ2AKMjh13EObA9L0kJufCHt1ewTD6B1KT+hEgIB+0U3YbW
	 FvqUB1DNqrxtymKH7tcwwXDqk9k+SYXtMbJK/K58zgD86QaHWTJAc2zo1qTM2yx+dT
	 78g0fR5bBQ63lJd5Ds3on+CeNP7op4IiKDpbwFrNbz8Z5ELESrwq9fARko2l9arsnf
	 ApO3DimFnf2FC04ASMeid1QrU1/uUBw4dDOYt7iit6FlAuqQK/DJ86gpAfSCSBOYP9
	 oO9SIHvEio8jA==
Date: Sun, 15 Sep 2024 18:06:30 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: phy: Support master-slave config
 via device tree
Message-ID: <20240915180630.613433aa@kernel.org>
In-Reply-To: <20240913084022.3343903-1-o.rempel@pengutronix.de>
References: <20240913084022.3343903-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 10:40:20 +0200 Oleksij Rempel wrote:
> This patch series adds support for configuring the master/slave role of
> PHYs via the device tree. A new `master-slave` property is introduced in
> the device tree bindings, allowing PHYs to be forced into either master
> or slave mode. This is particularly necessary for Single Pair Ethernet
> (SPE) PHYs (1000/100/10Base-T1), where hardware strap pins may not be
> available or correctly configured, but it is applicable to all PHY
> types.

I was hoping we'd see some acks here in time, but now Linus cut the 6.11
final so the 6.12 game is over now:
pw-bot: defer

