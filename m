Return-Path: <netdev+bounces-116866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6242994BE42
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF26AB24833
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3578318DF67;
	Thu,  8 Aug 2024 13:12:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663C18CC0F
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122721; cv=none; b=gNiDnUE+xI3S8i9IyKpODMeixpnfC0zlH+DAfxv1yuuWOj2jxkBUJUt3He1D8eoV2kz9Q8GxfsFjHggP+bjL8SLixNJSTSOKiE44fXYAZWs8vZfgShIJLWU0NoQ3YjTvSAM7bcQhkniojy03GnWRXNdDst23ywm055foxlIhflc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122721; c=relaxed/simple;
	bh=ORzPHVPKGLPHY2vJXbiktUt8Hp2pFCkHIRqmRPTgtnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvUXckFCEmJhhmwKhEtTR2Txq6v7g+PbAXRnnluqhVRN4lPt7POKnEW6fe5OIwR8DBgXisHVNAQP/xtmizP4oir3uoV3Y6tmcWMfvl/T8CORf8WdKMh8Fb5/EzNQKj+aTnm2QgWviN0++xq3bl4+mN79IxdlXAxoz9CuG+S5NU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sc2vl-0001BD-T3; Thu, 08 Aug 2024 15:11:49 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sc2vl-005R2i-DZ; Thu, 08 Aug 2024 15:11:49 +0200
Received: from pengutronix.de (p5de45302.dip0.t-ipconnect.de [93.228.83.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 133CE3198F4;
	Thu, 08 Aug 2024 13:11:49 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:11:48 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] phy: Add Open Alliance helpers for the
 PHY framework
Message-ID: <20240808-abstract-affable-tuatara-4ab55a-mkl@pengutronix.de>
References: <20240808130833.2083875-1-o.rempel@pengutronix.de>
 <20240808130833.2083875-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="grqbxbweaehct3d6"
Content-Disposition: inline
In-Reply-To: <20240808130833.2083875-2-o.rempel@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--grqbxbweaehct3d6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08.08.2024 15:08:32, Oleksij Rempel wrote:
> Introduce helper functions specific to Open Alliance diagnostics,
> integrating them into the PHY framework. Currently, these helpers
> are limited to 1000BaseT1 specific TDR functionality.
>=20
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/Makefile                |  2 +-
>  drivers/net/phy/open_alliance_helpers.c | 70 +++++++++++++++++++++++++
>  include/linux/open_alliance_helpers.h   | 47 +++++++++++++++++
>  3 files changed, 118 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/phy/open_alliance_helpers.c
>  create mode 100644 include/linux/open_alliance_helpers.h
>=20
> diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
> index 202ed7f450da6..8a46a04af01a5 100644
> --- a/drivers/net/phy/Makefile
> +++ b/drivers/net/phy/Makefile
> @@ -2,7 +2,7 @@
>  # Makefile for Linux PHY drivers
> =20
>  libphy-y			:=3D phy.o phy-c45.o phy-core.o phy_device.o \
> -				   linkmode.o
> +				   linkmode.o open_alliance_helpers.o
>  mdio-bus-y			+=3D mdio_bus.o mdio_device.o
> =20
>  ifdef CONFIG_MDIO_DEVICE
> diff --git a/drivers/net/phy/open_alliance_helpers.c b/drivers/net/phy/op=
en_alliance_helpers.c
> new file mode 100644
> index 0000000000000..eac1004c065ae
> --- /dev/null
> +++ b/drivers/net/phy/open_alliance_helpers.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * open_alliance_helpers.c - OPEN Alliance specific PHY diagnostic helpe=
rs
> + *
> + * This file contains helper functions for implementing advanced diagnos=
tic
> + * features as specified by the OPEN Alliance for automotive Ethernet PH=
Ys.
> + * These helpers include functionality for Time Delay Reflection (TDR), =
dynamic
> + * channel quality assessment, and other PHY diagnostics.
> + *
> + * For more information on the specifications, refer to the OPEN Alliance
> + * documentation: https://opensig.org/automotive-ethernet-specifications/
> + */
> +
> +#include <linux/ethtool_netlink.h>
> +#include <linux/open_alliance_helpers.h>
> +
> +/**
> + * oa_1000bt1_get_ethtool_cable_result_code - Convert TDR status to etht=
ool
> + *					      result code
> + * @reg_value: Value read from the TDR register
> + *
> + * This function takes a register value from the HDD.TDR register and co=
nverts
> + * the TDR status to the corresponding ethtool cable test result code.
> + *
> + * Return: The appropriate ethtool result code based on the TDR status
> + */
> +int oa_1000bt1_get_ethtool_cable_result_code(u16 reg_value)
> +{
> +	u8 tdr_status =3D (reg_value & OA_1000BT1_HDD_TDR_STATUS_MASK) >> 4;
> +	u8 dist_val =3D (reg_value & OA_1000BT1_HDD_TDR_DISTANCE_MASK) >> 8;

can you make use of FIELD_GET() here and in the other functions?

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--grqbxbweaehct3d6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAma0xBEACgkQKDiiPnot
vG8jKgf/c8gCG2Uo98J9/izj5O2Cc6IUgNmhpsM/nOYt1y7fpPrBSVyAAJLGRWeh
xvUXxFhxIBzyODAIvd7tsjn5vJ0ifHB2ktUHQgsa+L/qrUJzBZqGTG8Q7vR/aDp6
UYsEUYCSQepKCf1etwY/y6nYro5C/hx4RJPk8M3aUhisL5jKsF0kdxfgRlou3IZE
xwy6lkUGHINTHr0/vZVIC9VMT9abmuLzvgo2tW7fuZ4Vd0nd+gnFEIGf1M5/6wpq
PiPeqb0RjjCF4TCI4iEu9RDpJaauhbgJMfHbSes3y4k4F1XZUm+kYBjcwvUx76oo
wKJt2cgfaUHluy9NamMNG4hQwF4pFQ==
=z3G6
-----END PGP SIGNATURE-----

--grqbxbweaehct3d6--

