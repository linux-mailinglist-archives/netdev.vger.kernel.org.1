Return-Path: <netdev+bounces-242707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C2BC93DE9
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 13:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63B013A757F
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 12:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121830E0EE;
	Sat, 29 Nov 2025 12:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDE12773CB
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764420734; cv=none; b=gglcRqiI7IwGco8kY/RH3EWT70auGUdbVvmz4h8raty7WRbKP8C/6ylbdckUCQBi9oaHSvmjnueH2S8Srx59/GPfWpbpquPAeKZh2fDnafoQskHndS7gkPoYDdjM7m6JsHWm1YucNw0pD5ZGYIFftKDEGDN7p5STy783YUTqwPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764420734; c=relaxed/simple;
	bh=fOuIlTv1gtjpnsCFbHp98bHkI0ZQx+i6e9ZMFSefnww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkL6jP3n9wBNvo+cO1D3O98JoMmUIIpYnyIPCpnDtErNAPSS7Ce0QmjiiQDrs9m2kjcbRCpfHZRwg8mhuoy4iFKPeJIhhYe5JNX4N72ZxTjiMrEWyi/sjccEEFAY3CRuyA6+MbhRsHgYI0PM8r2lT1HornCncpT5YWcaqo2wjQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vPKQk-0006gN-6R; Sat, 29 Nov 2025 13:52:02 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vPKQj-0037Tf-2D;
	Sat, 29 Nov 2025 13:52:01 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BF40C4AAB56;
	Sat, 29 Nov 2025 12:52:00 +0000 (UTC)
Date: Sat, 29 Nov 2025 13:51:59 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>, 
	kernel test robot <lkp@intel.com>
Subject: Re: [can-next v3] can: Kconfig: select CAN driver infrastructure by
 default
Message-ID: <20251129-ultraviolet-sponge-of-focus-e788eb-mkl@pengutronix.de>
References: <20251129090500.17484-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rqvn6t3zcabgito2"
Content-Disposition: inline
In-Reply-To: <20251129090500.17484-1-socketcan@hartkopp.net>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--rqvn6t3zcabgito2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [can-next v3] can: Kconfig: select CAN driver infrastructure by
 default
MIME-Version: 1.0

On 29.11.2025 10:05:00, Oliver Hartkopp wrote:
> The CAN bus support enabled with CONFIG_CAN provides a socket-based
> access to CAN interfaces. With the introduction of the latest CAN protocol
> CAN XL additional configuration status information needs to be exposed to
> the network layer than formerly provided by standard Linux network driver=
s.
>
> This requires the CAN driver infrastructure to be selected by default.
> As the CAN network layer can only operate on CAN interfaces anyway all
> distributions and common default configs enable at least one CAN driver.
>
> So selecting CONFIG_CAN_DEV when CONFIG_CAN is selected by the user has
> no effect on established configurations but solves potential build issues
> when CONFIG_CAN[_XXX]=3Dy is set together with CANFIG_CAN_DEV=3Dm
>
> Fixes: 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
> Reported-by: Vincent Mailhol <mailhol@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511282325.uVQFRTkA-lkp@i=
ntel.com/
> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Added to linux-can-next and included in my latest PR.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rqvn6t3zcabgito2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmkq7GkACgkQDHRl3/mQ
kZwVIgf/U6hH6EBGWAkpXtQyPBiqWwbs4Kvl3nGedvQOXDTmSay7SALOTJDqxFJp
fWXVOGRLWNJAn2yX3H0Kp7zSXXEUyOJTLcUVW9hRGeiPSvq5db89ONtzSW1AnLWX
QSOnOPXjvcHW+QLH9pslmwJgrqQQCm+mUbprEDnk4dtDemOPSnO+swQiQnJlMEH+
sgNtYsoRxfA7uL6cqWO3rQcOjM9dlS/POXDEwvxQID29FqIlHZqdkSHhKrhzLY9H
O9E8IqiYE3lRGYT9ZJo2bnfc+jgN/V5ZtLgVr7OF81gtWDT+so2ku7d+Glv4dKcC
sTiI6Zdn7gOd8a4AkPLRwkuQrlm4IQ==
=gEw5
-----END PGP SIGNATURE-----

--rqvn6t3zcabgito2--

