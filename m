Return-Path: <netdev+bounces-138564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCD29AE218
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1DF282212
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF8E1BD4FD;
	Thu, 24 Oct 2024 10:05:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE231C07D9
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764345; cv=none; b=peyKg6427NLwDJXhABGHEcJY0mLlNe86yHF7HkW11wPzl+iG1USrXwPtUbB8oT6FrXGj2w/16nfQ8H4jZUi9HVYVnLRX8d9WWzZMDGJSYOLVFeMLVVzEehsNsxiOxK+O2t93RYUcItQmmN/ks8yie0+6URPUegITZ55xLGR06ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764345; c=relaxed/simple;
	bh=hmCSYP6v8HOdxPC7VV4gDFeb9FzJmHEBakjWrcevsSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=af1U6v9ETsgnDBpGcXhvUYwg99RR+dCUh4MWhWtDZTJGANco6AhRafNT8B6cXgqY2tAd3HLsYIIS94GLY+HdgYPp6C5Z5o+mUgoSuUJmfwu5p1SUXtAe0m88srHWsRL+JH5snYl4aSv6X2VuW3OezyKrsAYyYb2JUfLBDn1FlCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3uil-0001QP-Q3; Thu, 24 Oct 2024 12:05:35 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3uil-000BIE-1l;
	Thu, 24 Oct 2024 12:05:35 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 4484735D9A2;
	Thu, 24 Oct 2024 10:05:35 +0000 (UTC)
Date: Thu, 24 Oct 2024 12:05:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 4/9] can: Add Nuvoton NCT6694 CAN support
Message-ID: <20241024-bald-orthodox-bloodhound-0ce66c-mkl@pengutronix.de>
References: <20241024085922.133071-1-tmyu0@nuvoton.com>
 <20241024085922.133071-5-tmyu0@nuvoton.com>
 <20241024-fluffy-fearless-wapiti-d48c1a-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fza2wtvhypzli2lz"
Content-Disposition: inline
In-Reply-To: <20241024-fluffy-fearless-wapiti-d48c1a-mkl@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--fza2wtvhypzli2lz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/9] can: Add Nuvoton NCT6694 CAN support
MIME-Version: 1.0

On 24.10.2024 12:03:34, Marc Kleine-Budde wrote:
> Trimming Cc a bit
>=20
> On 24.10.2024 16:59:17, Ming Yu wrote:
> > +static struct platform_driver nct6694_canfd_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D DRVNAME,
> > +	},
> > +	.probe		=3D nct6694_canfd_probe,
> > +	.remove		=3D nct6694_canfd_remove,
> > +};
> > +
> > +static int __init nct6694_init(void)
> > +{
> > +	int err;
> > +
> > +	err =3D platform_driver_register(&nct6694_canfd_driver);
> > +	if (!err) {
>             ^^^^
> > +		if (err)
>                     ^^^
>=20
> This look wrong.
>=20
> > +			platform_driver_unregister(&nct6694_canfd_driver);
>=20
> Why do you want to unregister if registering fails?

This is a pattern that repeats over all platform driver :/

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--fza2wtvhypzli2lz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcaG+wACgkQKDiiPnot
vG/XFwgAhTdMLoMZT1cfNlctXJc2pJWIjQL8HgKy0DKzsJ4kyP8cMczGadV8yDiH
KSbsx7rdVDoklmS+a6OaEzUMV8rckwHdwsGvitzOTcs9wkQDmr1wMFwdqxQCzAzu
YZdMHh8ZoaU7GXe5DeJkGI5Yky/9FSrhBEnsowS2420WfJRXSo389TPTgiSaRdnp
0mDAoeBsyotBhEZ5LSfHu9cSlva4OYUVxE5VUXV7s4Im4W4giQ0LlI0SejbhbUDw
EbqRAZhB+8Ot5Utz/ZBowLb05moVShlV3DtcKSip1bUDnUXjl5RDRSgJRSS4SyI3
fp/q4Bu9N6avLmBn393gLiBrTOGX4w==
=j0Qe
-----END PGP SIGNATURE-----

--fza2wtvhypzli2lz--

