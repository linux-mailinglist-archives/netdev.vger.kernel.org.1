Return-Path: <netdev+bounces-169004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B5BA41F5E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB9E188AD0E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4E6221F2B;
	Mon, 24 Feb 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="boB2xRbE"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0770830;
	Mon, 24 Feb 2025 12:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400950; cv=none; b=l4nEJeQeJRLV2fRcaVFDb6nkJ3aHwR6srLWTD05CFnKqjSUxAwf/8DD06NLegYvFsj6qlm6Rb6Ef085xEPHLVseDMVrFVkUZh5ARwLNf9hqBAOMdiOs9/qYhCng9M7STWpUdN3s/Vr3HRAZDVou0xm4E61hCbeIq7A1sjN+ZPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400950; c=relaxed/simple;
	bh=+e46wEZt7RfRxQArYUoV6Ucx7yVGn4x2NTNd3fcYDQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ck0VvTMWSd8Nr9T/XTYpIlubKwQFW49z8MSJNHI2Y2eSP4ZjSgmZE+dGGi/N4PWbBSaNcf990YbWkE2vXnWZjMHdPfQKPZ0Us9l9T6e2o4hXL0AkRewS3RVJ/Vtt+9BGDIKo5Vy90CEs2n9Eb+16dElHB0BBGiuqlstWYJH7rEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=boB2xRbE; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7FB694421A;
	Mon, 24 Feb 2025 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740400945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4n1rdx2OTrFLTjZI10Rs7guVLntv94obbz/dLbtCoh0=;
	b=boB2xRbE6uvfUczb00uRATbcNQeX8WGtvPvkrj1Xw70jkiqfpkOBYVb9Htfgd4huA3cm0b
	tsimHlofYNZHW/ek7BDRPZGsvNw9XlHlWMIQQyHxuda3dxbqd2yWUj/rejSOjVdpuYshCD
	iTUXnf0YNTM/758gEXhy+PfSSSKc+Rhc/r0WySUlPBCOfFncIu3mtwX9ccnL+Fx2/laXKN
	mG5fnpLVeCZGveQKWTFFJMFNjtZrOw74Awdl0Da+Gk0IySE859MnngbFOw0WjBjky3jxsG
	GNW1m1gpgS1cQoXq3YDpAgRMSJxtaX4SxnEYnRjagAPmkA1tu3WthjCFckBHUA==
Date: Mon, 24 Feb 2025 13:42:22 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/12] net: pse-pd: pd692x0: Add support for
 controller and manager power supplies
Message-ID: <20250224134222.358b28d8@fedora>
In-Reply-To: <20250218-feature_poe_port_prio-v5-9-3da486e5fd64@bootlin.com>
References: <20250218-feature_poe_port_prio-v5-0-3da486e5fd64@bootlin.com>
	<20250218-feature_poe_port_prio-v5-9-3da486e5fd64@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeekudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmp
 dhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi K=C3=B6ry,

On Tue, 18 Feb 2025 17:19:13 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> Add support for managing the VDD and VDDA power supplies for the PD692x0
> PSE controller, as well as the VAUX5 and VAUX3P3 power supplies for the
> PD6920x PSE managers.
>=20
> Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> ---
>=20
> Changes in v5:
> - New patch
> ---
>  drivers/net/pse-pd/pd692x0.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
> index 44ded2aa6fca..c9fa60b314ce 100644
> --- a/drivers/net/pse-pd/pd692x0.c
> +++ b/drivers/net/pse-pd/pd692x0.c
> @@ -976,8 +976,10 @@ pd692x0_register_managers_regulator(struct pd692x0_p=
riv *priv,
>  	reg_name_len =3D strlen(dev_name(dev)) + 23;
> =20
>  	for (i =3D 0; i < nmanagers; i++) {
> +		static const char * const regulators[] =3D { "vaux5", "vaux3p3" };

Looks like the 'static' is not needed here :)

>  		struct regulator_dev *rdev;
>  		char *reg_name;
> +		int ret;
> =20
>  		reg_name =3D devm_kzalloc(dev, reg_name_len, GFP_KERNEL);
>  		if (!reg_name)
> @@ -988,6 +990,17 @@ pd692x0_register_managers_regulator(struct pd692x0_p=
riv *priv,
>  		if (IS_ERR(rdev))
>  			return PTR_ERR(rdev);
> =20
> +		/* VMAIN is described as main supply for the manager.
> +		 * Add other VAUX power supplies and link them to the
> +		 * virtual device rdev->dev.
> +		 */
> +		ret =3D devm_regulator_bulk_get_enable(&rdev->dev,
> +						     ARRAY_SIZE(regulators),
> +						     regulators);
> +		if (ret)
> +			return dev_err_probe(&rdev->dev, ret,
> +					     "Failed to enable regulators\n");
> +
>  		priv->manager_reg[i] =3D rdev;
>  	}
> =20
> @@ -1640,6 +1653,7 @@ static const struct fw_upload_ops pd692x0_fw_ops =
=3D {
> =20
>  static int pd692x0_i2c_probe(struct i2c_client *client)
>  {
> +	static const char * const regulators[] =3D { "vdd", "vdda" };

And here as well

Thanks,

Maxime

