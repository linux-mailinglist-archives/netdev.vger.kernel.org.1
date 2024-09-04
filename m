Return-Path: <netdev+bounces-124972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB2C96B76D
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1F41C23E2A
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9850C1CCEE9;
	Wed,  4 Sep 2024 09:52:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEB51CCEE3
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725443569; cv=none; b=hvpN1gT1kkDv1j9u5SHzAHH2yMnCScCcbTsNIqjSk7yH4KLDba2VxDuMGAKyqnmSNPTlJwD9ivVV+rHXmQ5TDL56GpE6/6ScWYED+TB7WI0xILN1yXOCgqRoQsYD+CYKV6k3cswv4jIonv60w1DDtAjCkMx0hkgd6LWHJDL/kZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725443569; c=relaxed/simple;
	bh=G2gSgXAkWV8CXgpO/BiDwZliPz4H8EJfiHjcOwAJ5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSaBsBXJix1xwz5V74I5ABXYaw17112FAiALMyzsktO+rNYJ8rFQlRaQUaxP1k62qTQZwh5EEoPp7gm3u2kPCWSlBr7Hz9d9D7KEQK6i5BFEENxnlbM/YRe2AL3dbUJsgSA4pgB+a1kqjitSberilDVmli75DtQK/J59FySKzsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmgm-0001n1-US; Wed, 04 Sep 2024 11:52:36 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slmgm-005QGx-CB; Wed, 04 Sep 2024 11:52:36 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0A3DD3324C9;
	Wed, 04 Sep 2024 09:52:36 +0000 (UTC)
Date: Wed, 4 Sep 2024 11:52:35 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Simon Horman <horms@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: can: cc770: Simplify parsing DT properties
Message-ID: <20240904-gorgeous-peculiar-newt-067532-mkl@pengutronix.de>
References: <20240903135731.405635-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wfrzeulhkfopbkjv"
Content-Disposition: inline
In-Reply-To: <20240903135731.405635-1-robh@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--wfrzeulhkfopbkjv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.09.2024 08:57:30, Rob Herring (Arm) wrote:
> Use of the typed property accessors is preferred over of_get_property().
> The existing code doesn't work on little endian systems either. Replace
> the of_get_property() calls with of_property_read_bool() and
> of_property_read_u32().
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v2:
> - Use reverse xmas tree order
> - Fix slew unsigned comparison

Added to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--wfrzeulhkfopbkjv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbYLeAACgkQKDiiPnot
vG9EVwf+M/MpT+nMGdkIp1dv1myWb6N6DFUuGPOMbXFizmWl1BuO6PQQV5Z1TD4W
lVFvt/vhkDloG6x73nD9U2Jf5n8mp3HwVQJF3hfCLUFsQ3uGWI/4VTjksSRZ4L1H
whvUWgNyn4MSQ5hNHRyMEKdy+rw8lGPlwCVjxjqrd0izeJNKobQsoRlJSiEETcRj
hGGhNc+JRgbZIYcRO1ERKgA0hvWVroHyf5o/iN7d5eOJXmlVh+qpBK5i/Kq97Kxg
WDNcLogphNiJgssLhu8mAm9chrNZ6a/jiHgqa/c+MeTnbdQ4Th35VdSe85s8Jpe3
KdyKjJWkE0eYK5dj6VTLaGCmMqqIsg==
=GVdl
-----END PGP SIGNATURE-----

--wfrzeulhkfopbkjv--

