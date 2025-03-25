Return-Path: <netdev+bounces-177524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0FCA70723
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 17:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C9E162B6F
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976E225D8E1;
	Tue, 25 Mar 2025 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Mx9V1M2R"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3AE1804A;
	Tue, 25 Mar 2025 16:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920736; cv=none; b=Q/ePmmdhvve2Une1WC90StqYxe5TCPKVN6+sbPPBOEIPyn92wNxxrXJmsyWoMAQIc3vF45DfU1mHfZVnXXdxN+/tPnRV81dhypze85b/Gkd3b9YQXZUkwAg6TTteiTPRZcFAjWlfSrZRDrey58DnJJZlrD4ll2sMEtKyLFT5ll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920736; c=relaxed/simple;
	bh=O2RYwhhNpo4HJ9P1BbPYVxFqvXi2CGF1yEc0iU7Kue4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mwlaNb4VyMsdrOBMuOXCpivnqJe0MHkGQC3ja9Kj14fPK6FtHbkUlZ3K3EUQtpJlnUdUNfjTA6k9Y5I27n3PdqJ+p5t78ipaU/gO0Hx+hd2KmjBNR9ZPdOXgUnTny31fX8cyHu2Y2vxKrmshfPznaEV2nRWQPuORZSJBskjkqR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Mx9V1M2R; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CC6E102F66E4;
	Tue, 25 Mar 2025 17:38:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742920731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Jz4ZxvZa2//kqp9AQ5gwaJHWi0QoseUW2iD6QSxnqM0=;
	b=Mx9V1M2RDAHcCHYsF8U3Er1w6YAozoeRBum4o/Jk96hSAGjxxWt2iV40fscfPeqsJHo6Di
	u9dsm6pmuRZkf/pw29kBLDLswwWYtyYtG94xRSfEqIeBy/w9K0BKtxx+YeIfmsQAHG69un
	SfeR2CJ7oe/UiV7asnifMttl6+H85s9ktnMa5PiNr17mtuW49h7b9xc90kcFni48Bfr+xq
	QsJcWeLEYWg4e3/shtRuORJ4HOLyRNtr1bDnAt8VrR1xjcD9QHGDKg5QKBdg+esmIywldg
	RpRhVdjkt6ZwlizYx2wG6jCdXIi+H7p3hOkv+Ucnw9XXKer7t/vvQdJQzS0j4g==
Date: Tue, 25 Mar 2025 17:38:46 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, davem@davemloft.net,
 Andrew Lunn <andrew+netdev@lunn.ch>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 5/5] net: mtip: The L2 switch driver for imx287
Message-ID: <20250325173846.4c7db33c@wsk>
In-Reply-To: <0a908dc7-55eb-4e23-8452-7b7d2e0f4289@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-6-lukma@denx.de>
	<32d93a90-3601-4094-8054-2737a57acbc7@kernel.org>
	<20250325142810.0aa07912@wsk>
	<0a908dc7-55eb-4e23-8452-7b7d2e0f4289@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B6bYGrpWKAySBj=BE3Lc1nK";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/B6bYGrpWKAySBj=BE3Lc1nK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > > > +config FEC_MTIP_L2SW
> > > > +	tristate "MoreThanIP L2 switch support to FEC driver"
> > > > +	depends on OF
> > > > +	depends on NET_SWITCHDEV
> > > > +	depends on BRIDGE
> > > > +	depends on ARCH_MXS || ARCH_MXC   =20
> > >=20
> > > Missing compile test =20
> >=20
> > Could you be more specific? =20
>=20
> config FEC
>         tristate "FEC ethernet controller (of ColdFire and some i.MX
> CPUs)" depends on (M523x || M527x || M5272 || M528x || M520x || M532x
> || \ ARCH_MXC || ARCH_S32 || SOC_IMX28 || COMPILE_TEST)
>=20
> || COMPILE_TEST

^^^^^^^^^^^^^^^^^^ - ach ... this "compile test" :-)

(Not that I've posted the code not even compiling ... :-D)

>=20
> So that it also gets build on amd64, s390, powerpc etc. The code
> should cleanly build on all architectures. It if does not, it probably
> means the code is using the kernel abstractions wrong. Also, most
> developers build test on amd64, not arm, so if they are making tree
> wide changes, you want this driver to build on amd64 so such tree wide
> changes get build tested.
>=20
> > There have been attempts to upstream this driver since 2020...
> > The original code is from - v4.4 for vf610 and 2.6.35 for imx287.
> >=20
> > It has been then subsequently updated/rewritten for:
> >=20
> > - 4.19-cip
> > - 5.12 (two versions for switchdev and DSA)
> > - 6.6 LTS
> > - net-next.
> >=20
> > The pr_err() were probably added by me as replacement for
> > "printk(KERN_ERR". I can change them to dev_* or netdev_*. This
> > shall not be a problem. =20
>=20
> With Ethernet switches, you need to look at the context. Is it
> something specific to one interface? The netdev_err(). If it is global
> to the whole switch, then dev_err().

Ok.

>=20
> > > > +	pr_info("Ethernet Switch Version %s\n", VERSION);   =20
> > >=20
> > > Drivers use dev, not pr. Anyway drop. Drivers do not have
> > > versions and should be silent on success. =20
> >=20
> > As I've written above - there are several "versions" on this
> > particular driver. Hence the information. =20
>=20
> There is only one version in mainline, this version (maybe). Mainline
> does not care about other versions. Such version information is also
> useless, because once it is merged, it never changes. What you
> actually want to know is the kernel git hash, so you can find the
> exact sources. ethtool -I will return that, assuming your ethtool code
> is correct.

Ok. I will.

>=20
> > > > +	pr_info("Ethernet Switch HW rev 0x%x:0x%x\n",
> > > > +		MCF_MTIP_REVISION_CUSTOMER_REVISION(rev),
> > > > +		MCF_MTIP_REVISION_CORE_REVISION(rev));   =20
> > >=20
> > > Drop =20
> >=20
> > Ok. =20
>=20
> You can report this via ethtool -I. But i suggest you leave that for
> later patches.

I will remove it.

>=20
> > > > +	fep->reg_phy =3D devm_regulator_get(&pdev->dev, "phy");
> > > > +	if (!IS_ERR(fep->reg_phy)) {
> > > > +		ret =3D regulator_enable(fep->reg_phy);
> > > > +		if (ret) {
> > > > +			dev_err(&pdev->dev,
> > > > +				"Failed to enable phy
> > > > regulator: %d\n", ret);
> > > > +			goto failed_regulator;
> > > > +		}
> > > > +	} else {
> > > > +		if (PTR_ERR(fep->reg_phy) =3D=3D -EPROBE_DEFER) {
> > > > +			ret =3D -EPROBE_DEFER;
> > > > +			goto failed_regulator;
> > > > +		}
> > > > +		fep->reg_phy =3D NULL;   =20
> > >=20
> > > I don't understand this code. Do you want to re-implement
> > > get_optional? But why? =20
> >=20
> > Here the get_optional() shall be used. =20
>=20
> This is the problem with trying to use old code. It needs more work
> than just making it compile. It needs to be brought up to HEAD of
> mainline standard, which often nearly ends in a re-write.

But you cannot rewrite this code from scratch, as the IP block is not
so well documented, and there maybe are some issues that you are not
aware of.

Moreover, this code is already in production use, and you don't want to
be in situation when regression tests cannot be run.

>=20
> > > > +	fep->clk_ipg =3D devm_clk_get(&pdev->dev, "ipg");
> > > > +	if (IS_ERR(fep->clk_ipg))
> > > > +		fep->clk_ipg =3D NULL;   =20
> > >=20
> > > Why? =20
> >=20
> > I will update the code. =20
>=20
> FYI: NULL is a valid clock. But do you actually want _optional()?

Yes, I will use _optional() and _bulk_ if applicable.

>=20
> This is the sort of thing a 10 year old codebase will be missing, and
> you need to re-write. You might also be able to use the clk _bulk_
> API?

The goal is to have this driver upstreamed (finally), so the starting
point of further development would be in kernel.

>=20
> 	Andrew


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/B6bYGrpWKAySBj=BE3Lc1nK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfi3BYACgkQAR8vZIA0
zr0U6wgA3vXkBH+jCy2QZbpuVDHnkTY2IX0a2mxIgSyQ62yxZYUCdS4htowl2Z4j
fAorqb7sMqbSOpu5omBLDDrTaHyHjYRdzfHgvYznt8DfhZCgfuuCIgmcwkaWV7SR
tT7+04Qo/vfLDjHML8PkKKj41u6NsIExKL4KXzfuqTrEDaMBoMhaz6f2baQ8TCof
DolrM+4E+SlbJg++sYM4OXeEj5mMwvfMybdmlFPRlIZoiu0EYkmA3b28xdbwogYY
D9XMB052/7HJ1szx6fIwO4U6ucXzaD9a7I7rFRyuxSYCzhNFHgOyp8D5IgJyaSFV
AZbGCYSW3maHQFMpag97WHtvWRVG4w==
=yVa2
-----END PGP SIGNATURE-----

--Sig_/B6bYGrpWKAySBj=BE3Lc1nK--

