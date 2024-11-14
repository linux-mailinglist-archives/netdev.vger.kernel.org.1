Return-Path: <netdev+bounces-144763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC37A9C863F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982CA281F7F
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554681F76D2;
	Thu, 14 Nov 2024 09:34:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C21DE3C6
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576880; cv=none; b=Phgevz87U+ohLBDJ2RKrrLdAieKrtIzgt0lZgUfbnpFyX8E4gS4e9W8AFEILY26JHIhMkJjRQigB2PNHCfK2YCVXKx+fW7zy42oFtdXRE5vSQWZawO0R/rItS/NDd5XqPWQIJJnv/cqYOP+S4k4771C8hCwc+cUz4KQ8iLXhqEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576880; c=relaxed/simple;
	bh=Ep2Su5oBhGjgb0pSOTBgiF7xjOlgictwKpVTYVK0Rhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4v47PCJeDcsLc/QA97AywRCmodiuDvMik38xUoEvsxEb1D0gguEr4ojI4QPUbh6gMPk+Xtto4y7vLUZxdmL4MvSOQfXp9kUKUeJ1cpkYU1XRTB6E2A17QGT7dxY+zRvi6tyF8W7mZJyE0m3dgcB7ATHT9RPTpOHRzxr1+f1kAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWF6-0002Ug-DO; Thu, 14 Nov 2024 10:34:24 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tBWF5-000igK-34;
	Thu, 14 Nov 2024 10:34:23 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A5DE4372F6B;
	Thu, 14 Nov 2024 09:34:23 +0000 (UTC)
Date: Thu, 14 Nov 2024 10:34:23 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] can: m_can: add deinit callback
Message-ID: <20241114-energetic-denim-chipmunk-577438-mkl@pengutronix.de>
References: <20241111-tcan-standby-v1-0-f9337ebaceea@geanix.com>
 <20241111-tcan-standby-v1-1-f9337ebaceea@geanix.com>
 <20241112144603.GR4507@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwtxbbvpewxw5dok"
Content-Disposition: inline
In-Reply-To: <20241112144603.GR4507@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--uwtxbbvpewxw5dok
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/3] can: m_can: add deinit callback
MIME-Version: 1.0

On 12.11.2024 14:46:03, Simon Horman wrote:
> On Mon, Nov 11, 2024 at 11:51:23AM +0100, Sean Nyekjaer wrote:
> > This is added in preparation for calling standby mode in the tcan4x5x
> > driver or other users of m_can.
> > For the tcan4x5x; If Vsup is 12V, standby mode will save 7-8mA, when
> > the interface is down.
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> >  drivers/net/can/m_can/m_can.c | 3 +++
> >  drivers/net/can/m_can/m_can.h | 1 +
> >  2 files changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
> > index a7b3bc439ae596527493a73d62b4b7a120ae4e49..a171ff860b7c6992846ae8d=
615640a40b623e0cb 100644
> > --- a/drivers/net/can/m_can/m_can.c
> > +++ b/drivers/net/can/m_can/m_can.c
> > @@ -1756,6 +1756,9 @@ static void m_can_stop(struct net_device *dev)
> > =20
> >  	/* set the state as STOPPED */
> >  	cdev->can.state =3D CAN_STATE_STOPPED;
> > +
> > +	if (cdev->ops->deinit)
> > +		cdev->ops->deinit(cdev);
>=20
> Hi Sean,
>=20
> Perhaps this implementation is in keeping with other m_can code, but
> I am wondering if either the return value of the callback be returned to
> the caller, or the return type of the callback be changed to void?
>=20
> Similarly for calls to callbacks in in patch 3/3.

please take care of errors/return values.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uwtxbbvpewxw5dok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmc1xBsACgkQKDiiPnot
vG86CAf/dBQJ55RQxeZaLkOXRdbsS2eEd2OaPcskq543AZQShvexfGzqSb+OCqIP
kthxyrv9z5ugmf65CBzUb1bx4jaDNGVZbor/UtSrSm4U7r5JhAYjwDDzHvZizQSG
sy45kU1p/Nz5c5uZy8M/GNgnhYRVaYwMYszLrDEgZKAbNyjRORkr9sV07zlmCmBX
5mk5Q0xr4VhDkNi/rKlh1AEmVNgQKdQYQKqML6TLYQ2+3QybfIqhg4xJJ+Ba1OSu
5EDSG042xP5N5lwTCF/CrBJSuMxJbnmV+FZCtwUkO4X0FU2UdiraqdQIIGMWLdsQ
3o1k/XdxaX8vY+0P7DWoTEp94tppwg==
=4AaC
-----END PGP SIGNATURE-----

--uwtxbbvpewxw5dok--

