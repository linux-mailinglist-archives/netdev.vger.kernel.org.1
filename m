Return-Path: <netdev+bounces-90810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66518B0446
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 10:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13DDE1C229A7
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 08:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6D7158A04;
	Wed, 24 Apr 2024 08:25:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC93158A37
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947119; cv=none; b=FTf3cNiE1lfWCO0YZBWSevHDwhBTg7WWdxJw8aZNtCrGwVCV97W6n7OMx7voWGoRBjXnXqlLD5bzCZJjWvEjyuYTvMmdAS7D2+CUIcqZYAWjtuPm4svB4mmSUfCBqdbjWPlmrnq9D/S2SHhPyQsTKk7KoIhZQGmBmwcL2hvmBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947119; c=relaxed/simple;
	bh=NeIENiopGqRCJKXoxGR47faLpfIOQmosSOdAybtLZ1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfyW0p66W+iJz30BtC4OtBHGNhy3sHPVwU9a+9r9ym1KyNPFT/NUW50UQJGfs0YzjbUvsv6NTPQMC0mUPYFYX43B8mm44GBd0IR6aqqE3mQOt/8Zp+usQUCiL4xeZvFL5EN2bTqZSeU04nkb8VbrCVFymy7fSU+Dd4muF+hUHLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzXw4-0004x8-5q; Wed, 24 Apr 2024 10:25:00 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rzXw3-00E2rV-Ic; Wed, 24 Apr 2024 10:24:59 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 23B652BEC37;
	Wed, 24 Apr 2024 08:24:59 +0000 (UTC)
Date: Wed, 24 Apr 2024 10:24:58 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Thomas Kopp <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux@ew.tq-group.com, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH 1/4] can: mcp251xfd: stop timestamp before sending chip
 to sleep
Message-ID: <20240424-fast-sandy-jackrabbit-d289a0-mkl@pengutronix.de>
References: <20240417-mcp251xfd-gpio-feature-v1-0-bc0c61fd0c80@ew.tq-group.com>
 <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rqbw5j2wn4qgc634"
Content-Disposition: inline
In-Reply-To: <20240417-mcp251xfd-gpio-feature-v1-1-bc0c61fd0c80@ew.tq-group.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org


--rqbw5j2wn4qgc634
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.04.2024 15:43:54, Gregor Herburger wrote:
> MCP2518FD exits Low-Power Mode (LPM) when CS is asserted. When chip
> is send to sleep and the timestamp workqueue is not stopped chip is
> waked by SPI transfer of mcp251xfd_timestamp_read.
>=20
> So before sending chip to sleep stop timestamp otherwise the
> mcp251xfd_timestamp_read callback would wake chip up.
>=20
> Also there are error paths in mcp251xfd_chip_start where workqueue has
> not been initialized but mcp251xfd_chip_stop is called. So check for
> initialized func before canceling delayed_work.

Can you move the mcp251xfd_timestamp_init() (which starts the
timestamping worker) into mcp251xfd_chip_start() to keep things
symmetrical? I think then you don't need to check for "work->func" in
mcp251xfd_timestamp_stop().

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--rqbw5j2wn4qgc634
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmYowdcACgkQKDiiPnot
vG/p/Qf/TnaEbLVI0x6Nv/Y79Ua6wtUkcJzzxBEoGz9HPhHdw/dLMVrLdK9WGHwu
wQFssYbY/vrV+ro2S120SzM69VfAKZY49Ouee0bq5C1zrxqjJRpO1Axj7lV8kCX8
x2LUUxnbL1Ga1NWJLR+Z+y4nBY/LZotSIGohDemQhScfL5cAGkz/ZyoU58rt6zxM
stvz8zMtJQmkprU6LH3MWr8MT25hj3T9OW9WAkjlqT30VCfuYvsRYqmJw+MsNIPd
iqoMDYIYZyHKqTBfciDfEhZVPJzLQQtn0H5EBfG+yq8GH8QE4MvPuOWCd371+Sil
XomSJ6I2QI5SFbGP/Wh3KfwoMXnEtQ==
=GzL3
-----END PGP SIGNATURE-----

--rqbw5j2wn4qgc634--

