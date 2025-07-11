Return-Path: <netdev+bounces-206094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C404B016A4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32473B441C9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 08:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE52217736;
	Fri, 11 Jul 2025 08:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702A198A11
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 08:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223389; cv=none; b=J81794Hzcu7u3rlR6V4j/bMCgDJGT9CLy9Uc/MEjBtvj61vy25DJULjm1aGOUPLVrOqDMqs1DbnBqVAWoAkiAJk0QcHvsBxmWv4zP1KWmvW+oGHxOraTApKpI3/xL2CPRMBDy10nob22DGlLEx3XgSZIWZcMl2N7MmZ6imMdC5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223389; c=relaxed/simple;
	bh=GLKg4hxHIQOYQz1RKZDca+U4/t5Jxsm+KDsKRpJstT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsY7hYTdgEClaV2Z3xrre/G1pTxz7sDUIZ6oHbc2ht5douzW92LmWTYwHU2D34YYDdL2mLZzz49Alni+3WBzi0NfBxzVhnY7kfsO+I463JHrtaeVM8fafEkBsYzmiII78HTiwyL/W644rqV9z30qEhNYcnyBHTT8Ph58Zg393D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ua9LM-0003aQ-1b; Fri, 11 Jul 2025 10:42:56 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ua9LJ-007tKb-23;
	Fri, 11 Jul 2025 10:42:53 +0200
Received: from pengutronix.de (p5b1645f7.dip0.t-ipconnect.de [91.22.69.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 415B443C6CF;
	Fri, 11 Jul 2025 08:42:53 +0000 (UTC)
Date: Fri, 11 Jul 2025 10:42:52 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, lst@pengutronix.de
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
Message-ID: <20250711-copper-dragonfly-of-realization-f92247-mkl@pengutronix.de>
References: <20250515083100.2653102-1-o.rempel@pengutronix.de>
 <20250516184510.2b84fab4@kernel.org>
 <aFU9o5F4RG3QVygb@pengutronix.de>
 <20250621064600.035b83b3@kernel.org>
 <aFk-Za778Bk38Dxn@pengutronix.de>
 <20250623101920.69d5c731@kernel.org>
 <aFphGj_57XnwyhW1@pengutronix.de>
 <20250624090953.1b6d28e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n6h2cplsjmr3qres"
Content-Disposition: inline
In-Reply-To: <20250624090953.1b6d28e6@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--n6h2cplsjmr3qres
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v4 0/4] net: selftest: improve test string
 formatting and checksum handling
MIME-Version: 1.0

On 24.06.2025 09:09:53, Jakub Kicinski wrote:
> > Receive Path Checksum Scenarios

[...]

> > * Hardware Verifies and Reports All Frames (Ideal Linux Behavior)
> >     * The hardware is configured not to drop packets with bad checksums.
> >       It verifies the checksum of each packet and reports the result (g=
ood
> >       or bad) in a status field on the DMA descriptor.
> >     * Expected driver behavior: The driver must read the status for eve=
ry
> >       packet.
> >         * If the hardware reports the checksum is good, the driver shou=
ld set
> >           the packet's state to `CHECKSUM_UNNECESSARY`.
> >         * If the hardware reports the checksum is bad, the driver shoul=
d set
> >           the packet's state to `CHECKSUM_NONE` and still pass it to the
> >           kernel.

While discussing things internally, one question came up:

Is passing packets with known bad checksums to the networking stack with
CHECKSUM_NONE, so that the checksum is recalculated in software a
potential DoS vector?

Our reasoning is as follows: Consider a system that is designed for a
certain bandwidth of network traffic and relies on the hardware to do
the checksum calculation. How much does the CPU load rise if all
checksum calculation can be force to take place on the CPU by sending
packets with broken checksums?

Is there a way to tell the network stack that the hardware/driver has
already performed the checksum calculation and that it is incorrect?

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--n6h2cplsjmr3qres
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmhwzokACgkQDHRl3/mQ
kZz2UggArcu/3uexYM3D+dRqZeqVaOXbGS98e0ZbuQh5KQbMxO/dp7VSXvNXUfJ6
lJii1xvWoGQS/NQG1FlYyAASPgvDqLHdzyuTWf508qlOPV0GjVQKlNCgxX188ZvW
V6sNez0oAdEq/sCSSCXRy5U0h6Xuvq8lTD3Mo2JRXXBJGJvMN3N5/q67tfuEssei
F67dSdL4qQBAeLSpIEDNv6TXKK0mHbE+S4+iyZ4Hqz07fPkRCb1YJZcud4NwSnn3
j+Cd23kmLrq8n39E4ktbpU22osewaiyaHm4iASzuySqMOEnY7XGguAYGW5GZmHYt
qNrthUA2pThU7fmoneGDAnjI8AFkkg==
=XtMB
-----END PGP SIGNATURE-----

--n6h2cplsjmr3qres--

