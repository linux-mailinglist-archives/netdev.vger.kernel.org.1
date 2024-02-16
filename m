Return-Path: <netdev+bounces-72285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104285771F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1D61F23479
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 07:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA517BC4;
	Fri, 16 Feb 2024 07:56:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F82A17BCC
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708070180; cv=none; b=mHwrkkOsLIEcJ+j4gFIfjL4Md0abOl4mNewlBlnaBVzvhbrc85HTVywpowGs61knXea91Lwg289oI1JTDJOSbDWWVIDYnFnO2AdPPmrUCOJe1FZlR+AMJ8ls0hFVCJqX1nt6kjg1mCD0KZ42ILDcsej/BIKyJvIitRxXDiq3fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708070180; c=relaxed/simple;
	bh=7Pa9RjFBb172HlPrKPKDBn4IiTBiyGH+Iyana8ZOtJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbMe8VI/rLyDAPpzY0uPZX8TN1wHYw6SIIfRUNYZoqzB/bw+4UUH+TPXNDXW5XpocaAmUoxD8Yan7T4S5glXsZTRyQZPWjGiZshi+4TR7gLHCVCcTV52vz916Ogy2INaVPF0eO992oxhFhIpKxjPcODDtL+ESQdKDUv2lGT1wJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rat4l-0003T5-D9; Fri, 16 Feb 2024 08:56:03 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rat4j-0012AD-TX; Fri, 16 Feb 2024 08:56:01 +0100
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7C63C29010B;
	Fri, 16 Feb 2024 07:56:01 +0000 (UTC)
Date: Fri, 16 Feb 2024 08:56:00 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Wolfgang Grandegger <wg@grandegger.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] can: m_can: remove redundant check for pm_clock_support
Message-ID: <20240216-panning-sesame-2bc66afeeb6a-mkl@pengutronix.de>
References: <20240104235723.46931-1-francesco@dolcini.it>
 <20240216074527.GA5457@francesco-nb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2pwjxutxb5pv4fzu"
Content-Disposition: inline
In-Reply-To: <20240216074527.GA5457@francesco-nb>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--2pwjxutxb5pv4fzu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.02.2024 08:45:27, Francesco Dolcini wrote:
> Hello Marc and Vincent,
>=20
> On Fri, Jan 05, 2024 at 12:57:23AM +0100, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> >=20
> > m_can_clk_start() already skip starting the clock when
> > clock support is disabled, remove the redundant check in
> > m_can_class_register().
> >=20
> > This also solves the imbalance with m_can_clk_stop() that is called
> > afterward in the same function before the return.
> >=20
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> Did you missed this? Or do you have some concern with it?

Somehow missed it in the last PR, but already part of the next PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--2pwjxutxb5pv4fzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmXPFQwACgkQKDiiPnot
vG/iDwgAmM9nBdYvm5wqDwxWU8iSl2Bdq2PS3zvmB+7XOu1iYOQ8vV9XTMv5pHrL
1GyKQSTbp0QZ/cVUOXzWa0PATlS9xKXetojJ6V2hFoN/9P0AHhkhVTU04dwsMyM4
NNQDWV2ENdaeKWpThVB9Yatx07lIXl5XOtmPxEqIR3LR59h1EpL2ODLXUADUU4Zu
NklAV0XUefT+TX3ckwq/14oZhVaUf+8rXWqUvAw4OpUENWwVqWdUamrZfBFfC9bw
lWKITH27Fa51hfZOgyW1EmZC2Tmq5h/T5ONJP9UXk0J4VH178BS6IEBSbeoZFfgN
FJAjp782wSr5d+UNawMUKyaiL+VDiw==
=VaPV
-----END PGP SIGNATURE-----

--2pwjxutxb5pv4fzu--

