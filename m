Return-Path: <netdev+bounces-90827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062A08B0586
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B673B28CF5E
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA465158D82;
	Wed, 24 Apr 2024 09:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30615158A39
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949824; cv=none; b=GuQzVxdjAUks4poaPM4cubWVqLboQF+sdW/wiNBjS/IxwctccXvUyKLYsDrFnEunITT5v8z4C1CwYzmop2ThVrooYDNK4g63ZuVfaG9/HI57WWT68XF8nXdNKe9hvhREllHFRv9xaZUSQmA82B2eKoEz95Xz/U6ExCAYCE4tg0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949824; c=relaxed/simple;
	bh=8vA4orOaKDY+zHUQW1/tzx26tBDxJUvA8wUGfkL9DPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKdiZjRIElrJ8c6JYHe99afMHgi4BZz4lbjrejTRYKnRwlUkAyU71+5AW/oMPOWwh7jZR8IfrkGeX+0ly99VEpheOIWsL4tfNJY0txZyHXVhqzvDTjTFeZbN7/vCxDuLO1E1bjZfHMXtMOdMJAL9IPbMeUhDatKKEYe2i3NLETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzYdj-0006Hi-91; Wed, 24 Apr 2024 11:10:07 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzYdh-00E3JN-HA; Wed, 24 Apr 2024 11:10:05 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 186472BECA6;
	Wed, 24 Apr 2024 09:10:05 +0000 (UTC)
Date: Wed, 24 Apr 2024 11:10:04 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH 3/4] can: mcp251xfd: add gpio functionality
Message-ID: <20240424-witty-vicugna-of-purring-7bffcc-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-3-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="farp7erk7y3aax3q"
Content-Disposition: inline
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-3-bc0c61fd0c80@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--farp7erk7y3aax3q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.04.2024 15:43:56, Gregor Herburger wrote:
> The mcp251xfd devices allow two pins to be configured as gpio. Add this
> functionality to driver.

Fails to build if CONFIG_GPIOLIB is not enabled.

|   CC [M]  drivers/net/can/spi/mcp251xfd/mcp251xfd-core.o
| drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c: In function =E2=80=98mcp2=
51fdx_gpio_setup=E2=80=99:
| drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c:1877:39: error: =E2=80=98s=
truct mcp251xfd_priv=E2=80=99 has no member named =E2=80=98gc=E2=80=99; did=
 you mean =E2=80=98cc=E2=80=99?
|  1877 |         struct gpio_chip *gc =3D &priv->gc;
|       |                                       ^~
|       |                                       cc

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--farp7erk7y3aax3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYozGkACgkQKDiiPnot
vG9J1wf/do8Juj8Orh5bVD09ULKiTACR0iSR2akIljO+FR51Sj5s88bF3DJUn3xV
ipozlNXXytRTXvW6K535zzoaX9Qs6slTyDKZjubYt/foqQ3KssuOZudP45iaIuWG
47N6tvdqDN8pEvBdhKwOWl1FJygZ4CskxX3hDMgF/jgc8JqL+5Y6z8vGqf6DssEV
3Mr1R9jpbVdQn8FUmp3262pK2p352LicKK3MUIKVMxmEfZ1LYaZXqvJwme2lFL6d
jXglkz5U3mLhY0rxlh8++tbwv+a1VNt4kDZGwLt7PaTm2rd/qC0ku/KC/yZHr/fe
VGuS8MVt9UCBMQiFyAu85AVHRVAEww==
=jzV9
-----END PGP SIGNATURE-----

--farp7erk7y3aax3q--

