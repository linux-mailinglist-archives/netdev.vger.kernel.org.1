Return-Path: <netdev+bounces-138563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2419AE201
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D5041C227F2
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 10:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021421BDAB9;
	Thu, 24 Oct 2024 10:03:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117C11ABEB1
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764222; cv=none; b=q98jExE22Rnpfrt5HLt3IrF4oasI+yqcrBxEgk9gasG3QKHnT41NAtyPQ76uO3ZVN/J7D7CLE+2LXz/Iq/2wN4V+n0BeB08AJmuCWt+qBY4LwaFSE1adhelwlJq594JqnQkkAtZ4T3WXLYzKox77hBEU7PsZmYenY7aBHZogLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764222; c=relaxed/simple;
	bh=myoolysdgU0gz/pb02aIGoH0W0F2n3V7nL0Qsp0uN/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZfUh4unZs0iw3NbDzjjoPr0G9HQh4oosITmu+9OeaJUNMwW4E3gEuZUGjR4d36mmnkKVR7iJlQxSfaUz0dMTIg5uTO8xu+FmeI2kYkEnnsM84dk9CJDGeQSvbI6XdyfIT/rPpQwMu8JEOCj1e5yQ9Cgs+/VgwKRcHcprDO+/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3ugp-00014h-BL; Thu, 24 Oct 2024 12:03:35 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t3ugo-000BES-2w;
	Thu, 24 Oct 2024 12:03:34 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 995E635D99A;
	Thu, 24 Oct 2024 10:03:34 +0000 (UTC)
Date: Thu, 24 Oct 2024 12:03:34 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Ming Yu <a0282524688@gmail.com>
Cc: tmyu0@nuvoton.com, lee@kernel.org, mailhol.vincent@wanadoo.fr, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 4/9] can: Add Nuvoton NCT6694 CAN support
Message-ID: <20241024-fluffy-fearless-wapiti-d48c1a-mkl@pengutronix.de>
References: <20241024085922.133071-1-tmyu0@nuvoton.com>
 <20241024085922.133071-5-tmyu0@nuvoton.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmiv6v6zzxwztmyt"
Content-Disposition: inline
In-Reply-To: <20241024085922.133071-5-tmyu0@nuvoton.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--gmiv6v6zzxwztmyt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 4/9] can: Add Nuvoton NCT6694 CAN support
MIME-Version: 1.0

Trimming Cc a bit

On 24.10.2024 16:59:17, Ming Yu wrote:
> +static struct platform_driver nct6694_canfd_driver =3D {
> +	.driver =3D {
> +		.name	=3D DRVNAME,
> +	},
> +	.probe		=3D nct6694_canfd_probe,
> +	.remove		=3D nct6694_canfd_remove,
> +};
> +
> +static int __init nct6694_init(void)
> +{
> +	int err;
> +
> +	err =3D platform_driver_register(&nct6694_canfd_driver);
> +	if (!err) {
            ^^^^
> +		if (err)
                    ^^^

This look wrong.

> +			platform_driver_unregister(&nct6694_canfd_driver);

Why do you want to unregister if registering fails?

> +	}
> +
> +	return err;
> +}
> +subsys_initcall(nct6694_init);
> +
> +static void __exit nct6694_exit(void)
> +{
> +	platform_driver_unregister(&nct6694_canfd_driver);
> +}
> +module_exit(nct6694_exit);

Can you use

| module_platform_driver(nct6694_canfd_driver);

?

> +
> +MODULE_DESCRIPTION("USB-CAN FD driver for NCT6694");
> +MODULE_AUTHOR("Ming Yu <tmyu0@nuvoton.com>");
> +MODULE_LICENSE("GPL");
> --=20
> 2.34.1

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--gmiv6v6zzxwztmyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcaG3MACgkQKDiiPnot
vG+Xtwf/ZTOqKueEri4uzmL7gDRE5iMiGRYrKSV53/6KplyptklGnWhO92GTfw+v
xM5GClo4cmm6ECAM9HMqYLjCrBF1A1wVuR2kFbsnAjtubeBbTPHaf0iJi0fdbS5S
+6G18SifkZklG3eOsYR0TlyazSns7RZ0bY4KdTlGTsG89ymZ5hNIdudOCqgqDbmZ
l8FDrDT4Mj/5SGnBJzQDOly4xDI6vUDwu3cUtHndCsJ25XtbsDBsYKtSKORPqDb2
NlIMQzibK2yZI6/UediHy0WsutUxaVpJSILNMNZLx6GH+LYMgdIbyX01Pd9vOF2a
JqDBlxaVTrBtjIm6ggKlIeq24kaz0A==
=n9KL
-----END PGP SIGNATURE-----

--gmiv6v6zzxwztmyt--

