Return-Path: <netdev+bounces-205367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58C6AFE583
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E921887728
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABA289811;
	Wed,  9 Jul 2025 10:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="c4xztTZu"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01072289809;
	Wed,  9 Jul 2025 10:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056099; cv=none; b=rBVi9ZnAiIdfIjPZJBk5jRSB5PIchtim2cWjh7T4sOcZG6ahLl0bWRiBFsmz9sfQespjITwT3PaKBQq4kmUHGSapB08fQD1Bmhj+xeQETuxA4izIIZJzyk9vCmJPGzHSsbEvVX1h3TFVedM1ZTpEV5jELvBFw1kz8+mp6DcTmh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056099; c=relaxed/simple;
	bh=es2bSzdV9IWpvgGFtHgvwYGWojC9fZkC/kNW3Hp+Xvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VIlZlA3A+wL1671dv3A17JztMvhLtnPCnAFvD0sC1YKdaoLXm/3hxM833KDd0k3P1dAMltO7eo0W8DRgBrVzv7nFZJ4X4awyjdQyf6ocJuXxbDMcmRI68v3XUHr2MYCD+3rKTdpp6Zet2frY5FR6kv45f7rpyj0PqmrtC8F81Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=c4xztTZu; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 57904103972A7;
	Wed,  9 Jul 2025 12:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1752056094; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ArIGCW5Bhq1y2eO/gihtnGd36bGdErSTiYHxyyM2NBo=;
	b=c4xztTZuzEmC1w0jFD5JIzskfaeJ9Kuw87IZn0mEp30P3ef4cAo0RNNUPFV8mF+tj7sc1l
	wC9uo6NzlEdIuVz8mVxbe6R1lsU70LUPb1CWeYW15Xguh+joIfcph1z/aboaqKC32Aney0
	EaYFAyGCbgrSIenh5ltO4KiGVIx9pZIngqSLRyjxdaa04TgiDkuCtVzdrdlFD69x+/4rAB
	0hMiMOsv10s8YTYMvV4ZkjmuoV3GuCnLcRHBdIZEGNfUGjaB5ss7PkkN+0Vsr8Syd6KUqf
	g5NtmhCPPUBtGNpiuuxEXrFh9nVZYPnIzyS18FC1Ag+rKDVf+3i3NFCx7D0bQw==
Date: Wed, 9 Jul 2025 12:14:47 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v14 04/12] net: mtip: The L2 switch driver for imx287
Message-ID: <20250709121447.7cc2cd19@wsk>
In-Reply-To: <b68a06a1-076a-4345-bbb4-7dda1cd73591@redhat.com>
References: <20250701114957.2492486-1-lukma@denx.de>
	<20250701114957.2492486-5-lukma@denx.de>
	<b68a06a1-076a-4345-bbb4-7dda1cd73591@redhat.com>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zvP9KrePMHi5Vk1C5hBLMkR";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/zvP9KrePMHi5Vk1C5hBLMkR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

> On 7/1/25 1:49 PM, Lukasz Majewski wrote:
> > +static int mtip_sw_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *np =3D pdev->dev.of_node;
> > +	const struct mtip_devinfo *dev_info;
> > +	struct switch_enet_private *fep;
> > +	int ret;
> > +
> > +	fep =3D devm_kzalloc(&pdev->dev, sizeof(*fep), GFP_KERNEL);
> > +	if (!fep)
> > +		return -ENOMEM;
> > +
> > +	dev_info =3D of_device_get_match_data(&pdev->dev);
> > +	if (dev_info)
> > +		fep->quirks =3D dev_info->quirks;
> > +
> > +	fep->pdev =3D pdev;
> > +	platform_set_drvdata(pdev, fep);
> > +
> > +	fep->enet_addr =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(fep->enet_addr))
> > +		return PTR_ERR(fep->enet_addr);
> > +
> > +	fep->irq =3D platform_get_irq_byname(pdev, "enet_switch");
> > +	if (fep->irq < 0)
> > +		return fep->irq;
> > +
> > +	ret =3D mtip_parse_of(fep, np);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "OF parse error\n");
> > +
> > +	/* Create an Ethernet device instance.
> > +	 * The switch lookup address memory starts at 0x800FC000
> > +	 */
> > +	fep->hwp_enet =3D fep->enet_addr;
> > +	fep->hwp =3D fep->enet_addr + ENET_SWI_PHYS_ADDR_OFFSET;
> > +	fep->hwentry =3D (struct mtip_addr_table __iomem *)
> > +		(fep->hwp + MCF_ESW_LOOKUP_MEM_OFFSET);
> > +
> > +	ret =3D devm_regulator_get_enable_optional(&pdev->dev,
> > "phy");
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret,
> > +				     "Unable to get and enable
> > 'phy'\n"); +
> > +	fep->clk_ipg =3D devm_clk_get_enabled(&pdev->dev, "ipg");
> > +	if (IS_ERR(fep->clk_ipg))
> > +		return dev_err_probe(&pdev->dev,
> > PTR_ERR(fep->clk_ipg),
> > +				     "Unable to acquire 'ipg'
> > clock\n"); +
> > +	fep->clk_ahb =3D devm_clk_get_enabled(&pdev->dev, "ahb");
> > +	if (IS_ERR(fep->clk_ahb))
> > +		return dev_err_probe(&pdev->dev,
> > PTR_ERR(fep->clk_ahb),
> > +				     "Unable to acquire 'ahb'
> > clock\n"); +
> > +	fep->clk_enet_out =3D
> > devm_clk_get_optional_enabled(&pdev->dev,
> > +
> > "enet_out");
> > +	if (IS_ERR(fep->clk_enet_out))
> > +		return dev_err_probe(&pdev->dev,
> > PTR_ERR(fep->clk_enet_out),
> > +				     "Unable to acquire 'enet_out'
> > clock\n"); +
> > +	/* setup MII interface for external switch ports */
> > +	mtip_enet_init(fep, 1);
> > +	mtip_enet_init(fep, 2);
> > +
> > +	spin_lock_init(&fep->learn_lock);
> > +	spin_lock_init(&fep->hw_lock);
> > +	spin_lock_init(&fep->mii_lock); =20
>=20
> `mii_lock` is apparently unused in the whole series.

Thanks for spotting it.

Indeed this shall have been removed when I added support for MII
operations' polling.

>=20
> /P
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH, Managing Director: Johanna Denk,
Tabea Lutz HRB 165235 Munich, Office: Kirchenstr.5, D-82194
Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/zvP9KrePMHi5Vk1C5hBLMkR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhuQRcACgkQAR8vZIA0
zr1dEwf+IV70eUIk6GwhBJxy3PxgfnLpjKQlItzlkVVtQfjTSQmIlMCucw9/SW04
2xsHcqT7V5sFWnhAViFyOtG0dRiaNToW8GdvWqwc9N4LKHYn3AkFUHmfD3lRXlqy
Ajwsjuv4q+2yGBlQ1Uzb7/MqnWQTtk82SBhyZXtxpCO5PhQ5qiKdUD/HHyFTkpNw
gpAqRHHk3WLxz9wCg4Kj8O/exiyLsqoiH7gNuQAAvx7OvnGaAt2O8hToAbfBdOzN
cw1od/9oksCZqf8YKXx99bE5lVfg3s+njPD7a0c7cAFIGPlARPoVjDg/2/DYEY0H
zc8GeKgDX8nsKtenNU09INlXdabZzg==
=lGVH
-----END PGP SIGNATURE-----

--Sig_/zvP9KrePMHi5Vk1C5hBLMkR--

