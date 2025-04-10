Return-Path: <netdev+bounces-181155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C01A83E93
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EEA319E0921
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0839B256C81;
	Thu, 10 Apr 2025 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CI4cOCBP"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93181215F7F;
	Thu, 10 Apr 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744277041; cv=none; b=U4ggbGw0a0/KCFpm86skTsAk9cRX/jJ2DuiO2UQ5glgcWxQTCpRw2gmcPWiaiVJ9bKiAD0QjYhtIO3suIhYq0h2G+QkAzoS8LOeusaO8A6aGZ7r4hmYYlVALH4kxC1qzipJqCaFUSQhBjOD//L0ZBIeIy/lnV83B0sZTjubTNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744277041; c=relaxed/simple;
	bh=cr1XqsGW0Is9QsImdjqJUZfHSWRAI+91hWhEgPxCyMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKznoyHXyjydrDoBvB8up3xwj9+ACrAZ55xC8xEvDXRAUnAoo8r5ewTQTyz4JXiFd7ckn3trh3U00amG5/Mb5WBM4hAuaGHXjtRFfS2lQBHz+jcc+IvowT96cYLAmCzGw+hLVvylGxC5WCGlDrNbN0Kr67FYGU/xaSzMmg82cFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CI4cOCBP; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0309A1034EAEC;
	Thu, 10 Apr 2025 11:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744277036; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=azBeY/ABdzLCK2gCU3irIQ43T5ERKSG6fIfSiV5Z92s=;
	b=CI4cOCBPBMLylFiXGeRD7c3jrqxluWRjSNAlIVxYBRtfkxu65x+EH4XLY/RWNVQLhZosUf
	SNRanfj363p0NmPSjDBbtK4Aa0/DGdWK1QYocBqQRsROGf+9BoyW+6BUpmDG3PEKT72AzW
	Kt0PPuHmbSfEeymFfHcUdhia9ba74M+Bizo3HQVmUWtKhZT/AhaMEzY9AJ4/fJLJUAXNpY
	4VbjZzMTsHkVRJjxPHOrMpaKk7G7pLhyYiuIE6wCsNy8CwGb2UNE/d5gH5CO/Bw5ahhDaN
	a64VEcfrTUvWWIGW92YyCAn0cDiUW4xAL3k3/Y/X8EwEnICsbdvfcnGQmm3EIQ==
Date: Thu, 10 Apr 2025 11:23:50 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Stefan Wahren <wahrenst@gmx.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next v4 5/5] ARM: mxs_defconfig: Enable
 CONFIG_FEC_MTIP_L2SW to support MTIP L2 switch
Message-ID: <20250410112350.7dbb299c@wsk>
In-Reply-To: <ea8cc94c-b212-4ae2-8c5b-7697e9b358aa@kernel.org>
References: <20250407145157.3626463-1-lukma@denx.de>
	<20250407145157.3626463-6-lukma@denx.de>
	<c67ad9fa-6255-48e8-9537-2fceb0510127@gmx.net>
	<20250410090122.0e4cadef@wsk>
	<ea8cc94c-b212-4ae2-8c5b-7697e9b358aa@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r5tjFsU34eWBYPJ.iEWYDwo";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/r5tjFsU34eWBYPJ.iEWYDwo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 10/04/2025 09:01, Lukasz Majewski wrote:
> > Hi Stefan,
> >  =20
> >> Hi Lukasz,
> >>
> >> Am 07.04.25 um 16:51 schrieb Lukasz Majewski: =20
> >>> This patch enables support for More Than IP switch available on
> >>> some imx28[7] devices.
> >>>
> >>> Signed-off-by: Lukasz Majewski <lukma@denx.de>   =20
> >> thanks adding the driver to mxs_defconfig. Unfortunately it's not
> >> possible for reviewers to identify the relevant changes, =20
> >=20
> > Could you be more specific here?
> > As fair as I see - there is only 14 LOCs changed for review. =20
>=20
> Really, the comment was very specific. You make multiple independent,
> looking irrelevant changes to the file.
>=20
> >=20
> > Please also be aware that MTIP L2 switch driver has some
> > dependencies - on e.g. SWITCHDEV and BRIDGE, which had to be
> > enabled to allow the former one to be active.
> >  =20
> >> also the
> >> commit messages doesn't provide further information.
> >> =20
> >=20
> > What kind of extra information shall I provide? IMHO the patch is
> > self-explaining. =20
>=20
> For example explain why do you think GPIO_SYSFS should be dropped.
>=20
> >  =20
> >> In general there are two approaches to solves this:
> >> 1) prepend an additional patch which synchronizes mxs_defconfig
> >> with current mainline
> >> 2) manually create the relevant changes against mxs_defconfig
> >>
> >> The decision about the approaches is up to the maintainer. =20
> >=20
> > I took the linux-next's (or net-next) mxs defconfig (cp it to be
> > .config)
> >=20
> > Then run CROSS_COMPILE=3D ... make ARCH=3Darm menuconfig
> > Enabled all the relevant Kconfig options and run
> >=20
> > CROSS_COMPILE=3D ... make ARCH=3Darm savedefconfig
> > and copy defconfig to mxs_defconfig.
> > Then I used git to prepare the patch.
> >=20
> > Isn't the above procedure correct? =20
>=20
> No, it is not correct. Do not make any changes in the "Enabled all the
> relevant Kconfig options and run" step and check the result. Do you
> see difference in result file? If yes, then why such difference
> should be part of this commit?

Ok, I get your point. Then I shall prepare a separate, pre-patch.
Thanks for info.

>=20
> Best regards,
> Krzysztof


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/r5tjFsU34eWBYPJ.iEWYDwo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmf3jiYACgkQAR8vZIA0
zr2DEgf+KE3yYGEwlrYyU8JplEso25aCWU0x5ENkFsHPsIds+J9TLbxooFsu53fP
6Y2JsJPakI0iBlKqW55uuZWh20wPWTFpIoqAk77FautHOO3BcML3lov3upWRH273
RGVQEJHRGURV/Q2w2jGM6fNH7JjWZjNHRS6WqNZnRm4WedNh5o3MJobE60k/yNOn
0RFMSqPOegpWpEJQnSmcip2s66i50dy2ou8kqmUwpDX6OMwJP8sELshq2eJDgH2G
z/p9pXjh5tfkJw3KO/LUktGgHfCdsjhP4pK3WNaLpSIHEMd1kDEnrrbhaQwMyVwt
qfkJipgw2GEVOxmgaUF5g4GIJ92exQ==
=Cxw1
-----END PGP SIGNATURE-----

--Sig_/r5tjFsU34eWBYPJ.iEWYDwo--

