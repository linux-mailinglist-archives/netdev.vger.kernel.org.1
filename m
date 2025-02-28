Return-Path: <netdev+bounces-170613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF72EA49524
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40711895A81
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 09:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDB1256C8B;
	Fri, 28 Feb 2025 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VpEE74y8"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E091C5F35;
	Fri, 28 Feb 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735265; cv=none; b=ujXOmdXJloLX+rXboEUCdZvMlbo6RAcpRFcHuKJkkn2ChBegirT9PdoSv11BMX3F4rtBjxskFqWt+k0IRO+XyLIi1OdmI0Rej2wvYtozCIys3JkxV+Bp+c1o3XWYL9d0j5FPErW7QnJTStv2e01VnBo4Gc+b4BOLACtE42cYC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735265; c=relaxed/simple;
	bh=g9+9xUaUwrhPwRgGCZ7HZuFRaPu6I1eBAEeSfEt0wkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOL8ZFBF4jKCeSoejEHvMiHHD1VQpJZ4aLSYZFdQ7tzTiCs6QDLQPv93mbKuFfV8npNOmJGaT6vZsti5+Rk1znylTuYrIyGEugTENK7KDcYLvlbxfOsUqqYGAu6QZtIJLJkqn0iQBUgNjZQZmPvHTzoo0OBCY0WYovk7Ot49aL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VpEE74y8; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 63E9944352;
	Fri, 28 Feb 2025 09:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740735255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nTGwSCRIvTj2ZMWI4KC7YS0Lsjd/3Yc5HpwcAnYob8=;
	b=VpEE74y82YNYrxmUXzNnpeisG9EB8FmU8UiBYjfRFj2dufz1XpeE96XVOycCoSbOk2/wAI
	yQELqIDVAwpis+IsXtGUh0Nf5NVY8pFYnxMVVlm1TjrsHsWUjmXKWl7nkmnVu9gGl3uX62
	YSMQpJFGzCkLE6WxiNxzXTQgOtNNgV2yfjuS9geN/HlTS6qgoK5D+PUT7pEK3Gq8rhdL9j
	thELazOL7kA3kGVRqcBPvvdx4HL7o9g892aYwbRrSRLBBhXRw+gKWhhnU19tSVceQmjHNz
	7TTOgJEMn4TvCYzbP2BSiDGj8Nv7iX0HrQCkIVK4yXzJos+yqNAQESTWQPuvhw==
Date: Fri, 28 Feb 2025 10:34:11 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Kyle Hendry <kylehendrydev@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, noltari@gmail.com, jonas.gorski@gmail.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] net: phy: bcm63xx: add support for BCM63268 GPHY
Message-ID: <20250228103411.4c203261@kmaincent-XPS-13-7390>
In-Reply-To: <20250228002722.5619-2-kylehendrydev@gmail.com>
References: <20250228002722.5619-1-kylehendrydev@gmail.com>
	<20250228002722.5619-2-kylehendrydev@gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehkhihlvghhvghnughrhiguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtp
 hhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 27 Feb 2025 16:27:15 -0800
Kyle Hendry <kylehendrydev@gmail.com> wrote:

> Add support for the internal gigabit PHY on the BCM63268 SoC.
> Some of the PHY functionality is configured out of band through
> memory mapped registers. The GPHY control register contains bits
> which need to be written to enable/disable low power mode. The
> register is part of the SoC's GPIO controller, so accessing it
> is done through a phandle to that syscon.

...

> +static int bcm63268_gphy_resume(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret =3D bcm63268_gphy_set(phydev, true);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D genphy_resume(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

No need for the last check. You can simply do this:
	return genphy_resume(phydev);

> +}
> +
> +static int bcm63268_gphy_suspend(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret =3D genphy_suspend(phydev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D bcm63268_gphy_set(phydev, false);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Same here.

> +}
> +
> +static int bcm63268_gphy_probe(struct phy_device *phydev)
> +{
> +	struct mdio_device *mdio =3D &phydev->mdio;
> +	struct device *dev =3D &mdio->dev;
> +	struct reset_control *reset;
> +	struct bcm_gphy_priv *priv;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	phydev->priv =3D priv;
> +
> +	regmap =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> "brcm,gpio-ctrl");
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	priv->gpio_ctrl =3D regmap;
> +
> +	reset =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	ret =3D reset_control_reset(reset);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

Same here.



--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

