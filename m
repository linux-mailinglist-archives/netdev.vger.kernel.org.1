Return-Path: <netdev+bounces-167229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD1AA393D6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 08:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0404616EF80
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734F1B85E4;
	Tue, 18 Feb 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWgr0778"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C1F7482;
	Tue, 18 Feb 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739864233; cv=none; b=Uf1UZp6Zwb8YnIG6k2kYg4yduUCOFkW8/mPY/jD+2kJ0gLIt+5e1xXpliwMmVELXfLLocgzAzoRf3fuNNL+rDdj+VLYtA9SMAD3y/oUxEJm6/r7q5onDYX5BhME7IQdo7onbEqeG+90SAdG9xsFVjHc5Vkt5cpKdpxYKKG9mSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739864233; c=relaxed/simple;
	bh=rHPdrQ2R4tIc9vjiIZ/Zr4xqp3jsk+xgImcAQGo2rqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgCZnPU74lhB2xs4uWylVMR8XBGryW5JLltFlU1AaV0WmmiB2xAK9IpCZeX4qsN+Lbs2oY8lq5YXPZI1EVdmIF6LKCi2gHf+2Qh6D73MoQ5aY1W4k4CAXt+ZZD3zZIDe/yBbhUMcp4Ot85c2U7j5h52gGw1lMHX4R8hKvYPUDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWgr0778; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0903AC4CEE2;
	Tue, 18 Feb 2025 07:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739864232;
	bh=rHPdrQ2R4tIc9vjiIZ/Zr4xqp3jsk+xgImcAQGo2rqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EWgr0778EQEcAmFbQlNT+nT/KNYZ4SKqJCtyez4pOLFV/1CyA+H4jbh2/8GzXpxmZ
	 DSETZ78SCIhcwM/TzPSV695GL4T/7p4N+gs3bfWzLZvYHwU+D/KtTAdB8mRlVKqRmy
	 dCJDNcp0QrgjM8NXLLp9558+VXlHGG281dDwe1jkP7+0baHL48O3bI1QAdl4hYm2Zr
	 Z5vB4WYwjJJhdNmM9OTO12kvY4xK1clkZap3ZXjPQBRTWPE14/EI65IIpODmCL1PVh
	 jTX6JbbRD6KLa2iCfx9DID3jGOtQpawzwklNLTUGFFW/GM+85Km67CVrgDEj51623m
	 /3cclq2Kyl5vg==
Date: Tue, 18 Feb 2025 08:37:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, =?utf-8?Q?Fern=C3=A1ndez?= Rojas <noltari@gmail.com>, 
	Jonas Gorski <jonas.gorski@gmail.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/5] net: phy: bcm63xx: add support for BCM63268 GPHY
Message-ID: <20250218-lumpy-arrogant-orangutan-adeec8@krzk-bin>
References: <20250218013653.229234-1-kylehendrydev@gmail.com>
 <20250218013653.229234-2-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250218013653.229234-2-kylehendrydev@gmail.com>

On Mon, Feb 17, 2025 at 05:36:40PM -0800, Kyle Hendry wrote:
> This patch adds support for the internal gigabit PHY on the

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> BCM63268 SoC. The PHY has a low power mode that has can be
> enabled/disabled through the GPHY control register. The
> register is passed in through the device tree, and the
> relevant bits are set in the suspend and resume functions.
> 

...

> +int bcm63268_gphy_resume(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = bcm63268_gphy_set(phydev, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = genphy_resume(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +int bcm63268_gphy_suspend(struct phy_device *phydev)

Why these are not static? Where is EXPORT_SYMBOL and kerneldoc?

> +{
> +	int ret;
> +
> +	ret = genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret = bcm63268_gphy_set(phydev, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int bcm63268_gphy_probe(struct phy_device *phydev)
> +{
> +	struct device_node *np = dev_of_node(&phydev->mdio.bus->dev);
> +	struct mdio_device *mdio = &phydev->mdio;
> +	struct device *dev = &mdio->dev;
> +	struct bcm_gphy_priv *priv;
> +	struct regmap *regmap;
> +	int err;
> +
> +	err = devm_phy_package_join(dev, phydev, 0, 0);
> +	if (err)
> +		return err;
> +
> +	priv = devm_kzalloc(dev, sizeof(struct bcm_gphy_priv), GFP_KERNEL);

sizeof(*)

> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv = priv;
> +
> +	regmap = syscon_regmap_lookup_by_phandle(np, "brcm,gphy-ctrl");

No. ABI break without any explanation in commit msg.

Best regards,
Krzysztof


