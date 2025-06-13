Return-Path: <netdev+bounces-197348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B900AD8330
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436833B7291
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1141C25A341;
	Fri, 13 Jun 2025 06:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36F7253958
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 06:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795761; cv=none; b=t5XHtLmB2djlGJQFOf8YygvM5yLYTu6vGMfbUKBs65mfKEdK1vw5pOsJH2DqYSjOinx6KhvqM62Uh4qH5KQRvYk2+9JG/TRKiEVTAd9Zc2a40e9e9c9apHCOPLLgH0odTuUqmjUCYFZA5a4qQCVCzE9z1dBXlPpEDSiiRgCDhwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795761; c=relaxed/simple;
	bh=pfabPYrH590QkZNWCjJCN9mikHn6aDw/cOSboVgm6C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bh5toZBXn/LzjK/JIfTw3tyhalVeVdeZPC8X7y+OfhrQYKO2IcFcCYPOpa7ykGJZiBBnBG8DEYYJ2avaXjjzAL8DDSQt/y9feIhwf3dZBGY1vR743G3PoqMaG1KjutTzmO1QjNnaxUZmHeVmcs4rUQluU/FcW8FknZKJFAejV+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPxnu-000536-V5; Fri, 13 Jun 2025 08:22:18 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uPxnt-003FE8-2P;
	Fri, 13 Jun 2025 08:22:17 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 607D9426CE3;
	Fri, 13 Jun 2025 06:22:17 +0000 (UTC)
Date: Fri, 13 Jun 2025 08:22:16 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Wei Fang <wei.fang@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: RE: [PATCH net-next v2 00/10] net: fec: cleanups, update quirk,
 update IRQ naming
Message-ID: <20250613-light-convivial-sawfish-04e008-mkl@pengutronix.de>
References: <20250612-fec-cleanups-v2-0-ae7c36df185e@pengutronix.de>
 <20250612-nostalgic-elk-of-vigor-fc7df7-mkl@pengutronix.de>
 <PAXPR04MB8510C523E90B33C2CD15DAEF8877A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3gti35dwvq4i22l6"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510C523E90B33C2CD15DAEF8877A@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--3gti35dwvq4i22l6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: RE: [PATCH net-next v2 00/10] net: fec: cleanups, update quirk,
 update IRQ naming
MIME-Version: 1.0

On 13.06.2025 06:19:32, Wei Fang wrote:
> > On 12.06.2025 16:15:53, Marc Kleine-Budde wrote:
> > > This series first cleans up the fec driver a bit (typos, obsolete
> > > comments, add missing header files, rename struct, replace magic
> > > number by defines).
> > >
> > > The next 2 patches update the order of IRQs in the driver and gives
> > > them names that reflect their function.
> >=20
> > Doh! These 2 patches have been removed, I'll send an updated series tom=
orrow.
> >=20
>=20
> "update IRQ naming" needs to be removed from the subject as well.

ACK, it's already updated in my cover letter.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--3gti35dwvq4i22l6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhLw5UACgkQDHRl3/mQ
kZyyjwf+M9Kq6yICdtKGZf7U1bvemrZCbWOvshb+rI9PV++6WC8qD/UdbfsGidGg
feYiVWHnac6D2zdvRAtHD8LLhIxMZDnuCR3oa8titVAbNPHtgIfzoDEklDmunT6j
IvVJTevazK4yb1q55n9l4+TSo7TqzzBa/cUR4xj/xb56MPK4Zyii1i3UEFRbpWQB
bEHvFJt9YHacN3KeiUhHZQOoBT+nCoMNZ0CQ4lRg892lEXaGj5DnEqtdhToKUcze
j+4ovzD6FvWXtpqQg68MRBZI00OJcdrWQyVTqqwhJ1ERoOWdFUeNoIKdF3oplMbB
ex0qrIrbaJEQHb+4YkC4xQWvFuhkKw==
=vJnJ
-----END PGP SIGNATURE-----

--3gti35dwvq4i22l6--

