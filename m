Return-Path: <netdev+bounces-136054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184BA9A0245
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74CFAB213BD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0ED1B0F14;
	Wed, 16 Oct 2024 07:19:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58391B07D4
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063144; cv=none; b=SK09YVTzckUSHEMvM0yPfe30K7eEa4L/P7RtPfU9C5Tppj71Ugm6qx2dQ9mlxFmYj/QiP5as5IpFjtKMkKCuf32PyastYhigeAuQDCkl+VVrnhTKRgH7xzCKWwdqaB0+oJOPdcbN6jlYo+uVGX8TWNRLeJRcI3g0dt6SGmHBwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063144; c=relaxed/simple;
	bh=Ho5hRgkoHaDJ09OEyH7e46Yif/V/JZhDZuMMNX8r+YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsglQoxX9/F49j6GYT96LkO+40TsFaFcAabBb6Xjr0xbPn1mbulUjglglbQLhgXg20UacvW3LhWssixiBkUrhX/eBQCOA2mjneGDcZ6zXfjWqasQl7prRh7TWGne7FW8jHqGZt5+naEm0IA5xGa/X6tgxIiKICmxFvXBB3np7WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0yJ0-0007jg-4y; Wed, 16 Oct 2024 09:18:50 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t0yIy-002DO4-7X; Wed, 16 Oct 2024 09:18:48 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E3141353E8B;
	Wed, 16 Oct 2024 07:18:47 +0000 (UTC)
Date: Wed, 16 Oct 2024 09:18:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuni1840@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	socketcan@hartkopp.net
Subject: Re: [PATCH v2 net-next 10/11] can: gw: Use rtnl_register_many().
Message-ID: <20241016-ostrich-of-perpetual-whirlwind-9a5b8d-mkl@pengutronix.de>
References: <20241015-ochre-gaur-of-whirlwind-d6e892-mkl@pengutronix.de>
 <20241015174031.17958-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s65w3nk65l2ukrpg"
Content-Disposition: inline
In-Reply-To: <20241015174031.17958-1-kuniyu@amazon.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--s65w3nk65l2ukrpg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15.10.2024 10:40:31, Kuniyuki Iwashima wrote:
> From: Marc Kleine-Budde <mkl@pengutronix.de>
> Date: Tue, 15 Oct 2024 08:23:27 +0200
> > On 14.10.2024 13:18:27, Kuniyuki Iwashima wrote:
> > > We will remove rtnl_register_module() in favour of rtnl_register_many=
().
> > >=20
> > > rtnl_register_many() will unwind the previous successful registrations
> > > on failure and simplify module error handling.
> > >=20
> > > Let's use rtnl_register_many() instead.
> > >=20
> > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> >=20
> > Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >=20
> > Who is going to take this patch?
>=20
> It will be netdev maintainers because the last patch in this series
> depends on this change.

That's fine with me.

> I'll add a note below "---" next time for such a case.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s65w3nk65l2ukrpg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcPaNUACgkQKDiiPnot
vG/kHwf/cs93+0DUYmXLGNuCul2xEqM/gaS9ud+R/Pp5N7nebPH76OS1pQFNrNJZ
5QMssb/JndFcsvssYGyL+EMIW8+uQXKBE8T0kMOJxAW7BPguEnsjZ5/qzoHJjSfg
ycERQduPB6hlFRKK7l+lOq70GWcd+aNcRg3fqOaT2LF6jHZK8NvvKlGJuhnY5too
+lS/8JcCqUJHKY++qB+XCquzgWs03hkQmaZSlpOk+T0sdv+4agLXR+p/MX6Y3303
feXmNZfUGuj7S1YPeUu8Lpr0GJ6WULi6sSGx/mtwB3nUMWz4grYdkMSOivDmpBrD
o23AQuZQrD0kzIQISrQU5xXziF4eNg==
=10/9
-----END PGP SIGNATURE-----

--s65w3nk65l2ukrpg--

