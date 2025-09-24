Return-Path: <netdev+bounces-225970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A006FB9A0F7
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 15:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9163A90BA
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 13:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8447E30146F;
	Wed, 24 Sep 2025 13:38:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B1E1A0BD6
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 13:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758721112; cv=none; b=auJXL/AIuE0OHXvuyoJ4b1pVLZhNXdwMQZ5ochQ9pHiknY4NJ2cD+C7Ra1rxYHXBnMeek0degqwuIkRoX2pn5+w1QtcCemSUgiO0Q7OdULKUwzhbdoBkUh0hda6nyfwWbCMVmuidQbYrmWR1+JcI7zLWQyUsTAiYJ8wDsVCgDwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758721112; c=relaxed/simple;
	bh=L5JNymcfPqzpAddpRiJ15HX6g7YKwfE/PMYWggsg+1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrXBoWX4Rm2/qSIiRKoyhyngZBsmbK8kR5xfOJb/y0Q2ofAVPojHpvrkVkfhWN2spOylbLldGlo3oz5yEWJuxrXh9BeijY7BmG+ncYBG6NrwI51Q3yxHphYq1Lp24jNLkTjKifkEeA/AGruGomDMLh7gOQhpbaXoVxfm9C3VIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1PhC-0002p0-5e; Wed, 24 Sep 2025 15:38:10 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1PhA-000GNX-0F;
	Wed, 24 Sep 2025 15:38:08 +0200
Received: from pengutronix.de (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A74B5478D78;
	Wed, 24 Sep 2025 13:38:07 +0000 (UTC)
Date: Wed, 24 Sep 2025 15:38:07 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, syzbot@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, syzbot ci <syzbot+ci284feacb80736eb0@syzkaller.appspotmail.com>, 
	biju.das.jz@bp.renesas.com, davem@davemloft.net, geert@glider.be, kernel@pengutronix.de, 
	kuba@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	stefan.maetje@esd.eu, stephane.grosjean@hms-networks.com, zhao.xichao@vivo.com
Subject: Re: [syzbot ci] Re: pull-request: can-next 2025-09-24
Message-ID: <20250924-energetic-unnatural-stork-544e82-mkl@pengutronix.de>
References: <68d3e6ce.a70a0220.4f78.0028.GAE@google.com>
 <c952c748-4ae7-4ab9-8fd0-3e284a017273@hartkopp.net>
 <651d24b9-fe26-4e6f-a144-22c5997eeafb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7g5edpfajfgtpol"
Content-Disposition: inline
In-Reply-To: <651d24b9-fe26-4e6f-a144-22c5997eeafb@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--e7g5edpfajfgtpol
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [syzbot ci] Re: pull-request: can-next 2025-09-24
MIME-Version: 1.0

On 24.09.2025 22:31:28, Vincent Mailhol wrote:
> @Marc, once I finish testing, can I just send you a diff patch and ask to=
 squash
> it in:
>=20
>   [PATCH net-next 27/48] can: populate the minimum and maximum MTU values
>=20
> ?

ACK

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e7g5edpfajfgtpol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjT9DsACgkQDHRl3/mQ
kZxQlQgAht0+q8BipwUjx+4dSTZqKpvYr+rCmq3a0xNtIr3ID5cSB7Ell4sFBGqp
3e8Wu1/fa791XIATrVPF5JBU+fr/fuRYTn1v9uaLfIQEwARxfzKj7IujkqaJb0bz
ieVW3ghn9iynD7sdOJ7ObHMwu2GyiNNoLDqaf1//zB6KIlApIAmqDZCOO9BIo4i5
BvEQs9wK0FYPYZd08dy0PTbFj9ejDaYhOdfRC6r5CXUYSvUqMRKE0JlkXpVmh7xK
//lGvJ1bEiQNnVQLqefrOy4Hvhbzfx9q2x44knutP5qgQVY30G0/aev5xv4ogjx2
/clZfTFrHD7fVGsr0NsM0FCbYxfY2w==
=4IEG
-----END PGP SIGNATURE-----

--e7g5edpfajfgtpol--

