Return-Path: <netdev+bounces-224850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1965B8AE72
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6BEF1697EA
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 18:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8BB25B31D;
	Fri, 19 Sep 2025 18:23:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB31D8DE1
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 18:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306180; cv=none; b=K13P+eea+1x9KktAp98QQiNGDHpKmFnDyZq91fsPeIyN2omFjSJBvc7ztiNisKdn7AovXqMZpC+CfzfieLJU9mkijjaCJMifeA6AM+fFJAHGejh7T8G065jpsA71q03ixTACWzyqmc0Od8UOS+GYp/zDugVsyMNQV99ymz30cVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306180; c=relaxed/simple;
	bh=DZ8XFw9x2SmaOy+WgNs8CcmxbYMcqYYvloKdZKt6ZCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwk1R3PJ7X9s1dk8fw4NLLAOS3Ia0j4RwKcggXcCBnJTf/kd6QFwDJKCqkxRth9LAL8CzTZi+hpTQMXKXU5CsIsyDuzqp+bPNs9XR1qMCfKStQPvTuJ4tqUxWUCVnM0rRsAcHc7ziusJdXAUNvCs1ALLcgxoZzVPQO5oYuS3FkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfks-00049K-AI; Fri, 19 Sep 2025 20:22:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uzfkr-0029FG-1f;
	Fri, 19 Sep 2025 20:22:45 +0200
Received: from pengutronix.de (ip-185-104-138-125.ptr.icomera.net [185.104.138.125])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 88CB0475182;
	Fri, 19 Sep 2025 18:22:44 +0000 (UTC)
Date: Fri, 19 Sep 2025 20:22:43 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stefan =?utf-8?B?TcOkdGpl?= <stefan.maetje@esd.eu>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
	Frank Jungclaus <frank.jungclaus@esd.eu>, linux-can@vger.kernel.org, socketcan@esd.eu, 
	Simon Horman <horms@kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/5] can: esd_usb: Fixes and improvements
Message-ID: <20250919-hypersonic-unselfish-squid-f759eb-mkl@pengutronix.de>
References: <20250821143422.3567029-1-stefan.maetje@esd.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvklkaqjk43lcdmo"
Content-Disposition: inline
In-Reply-To: <20250821143422.3567029-1-stefan.maetje@esd.eu>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--nvklkaqjk43lcdmo
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/5] can: esd_usb: Fixes and improvements
MIME-Version: 1.0

On 21.08.2025 16:34:17, Stefan M=C3=A4tje wrote:
> The forth patch makes some error messages also print the error
> code to achieve a higher significance. Removes also a duplicate
> message and makes the register / unregister messages symmetric.
>=20
> The fifth patch avoids emitting any error messages during the=20
> disconnect of CAN-USB devices or the driver unload.

Applied 4+5 to can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--nvklkaqjk43lcdmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEn/sM2K9nqF/8FWzzDHRl3/mQkZwFAmjNn24ACgkQDHRl3/mQ
kZzuPgf+KQOzu5FW+RiMlwF+RmapU3T5BBt7ITKbm3gJwP7wZICKvErEzfkGlAdu
f6sZhUGP5BH9hVuj3k43UdXVE9vLJvUzSP2jAb9BxdLmVJMC33bU2VjHXIQJrmBA
XPuoTxtMXyWS29zS/FtJ8p+RrdR7vIbIzwjdKAovJL0SUO/mlkOw7unulDzb5wyY
8QcgAPR629pSwNvOUJoG5GojWbKJmVls5Xmyyg4HH6/eI5RaYQlir2qcg1eb3yUC
XPE5Nr9sUDQS5msjVLfMpZ0G24UF33C5ot5jrhYQZHFcMLKlix6FPsjPRFfYM/u4
dSLoaiAMPGFDcb7FxoknJCcCtc8D6g==
=K+aW
-----END PGP SIGNATURE-----

--nvklkaqjk43lcdmo--

