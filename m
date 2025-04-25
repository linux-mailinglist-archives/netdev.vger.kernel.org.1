Return-Path: <netdev+bounces-185848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2C4A9BE5C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCAE54651C1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DEB22B8B2;
	Fri, 25 Apr 2025 06:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Hw/Oj/IO"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016AF22B595;
	Fri, 25 Apr 2025 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561181; cv=none; b=LAt4q1ecx+kYB2/CQbngScoio8c71I/VXc07qIlAARndoJIoMm7l8uAryock3zG8O6sKe9fXj4yBBT8WTmtidRHRr72IXY47iuZAqXYGnKk9APAek19HATGmW92SyA/5MeJx/VUTjxv9GXMubO7WDwoXxqbv1RKZt218KTR0AxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561181; c=relaxed/simple;
	bh=VtArZyvh3OJVlev1TuT+mhv7J+r5VPbKR7V2yD85l78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gg5i2UAmLpvUY2lTOCx3fmiooSJVfwy/C//MLXY6waPtJLsLuEo8qNMBebU2AAewxx7j8TXeehreFk4Im9ne//DvbfGHt+s/o7pyq/oU90NVZOzTg/LyTgE4ULq2GpT8Qw6CGEQAZUvSOqwEvR3RRk8QhdO5eskzTJxB8rk35o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Hw/Oj/IO; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26943102E13D0;
	Fri, 25 Apr 2025 08:06:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1745561170; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ef+EBezQpcy3FcBFm+eU7MkGtMSmPuuasBxJN60QVdI=;
	b=Hw/Oj/IO4Av7kOb3s35NwLPns3+xpbMuJVuqH+xEDaSFwjxveKEzr7E6GkEmGAbQ6i35dM
	xfOtt+ma5ftYQe0YIuzr79f1lSRMvhwmHrJ1MKL1Op+VIQRjqdCRHl+OHvEnjjOZFJ+2Wa
	LtflvHzHZfua9V3s/vsxEA9p/kxptvSAfc7b76Z9sg6Ev2gHQTqPZMgpYWon2RLzLaBCt2
	4eoUgjaLQqtWm1M1X9UOXtMvYvlshLvuIQD/NRGIjBf/RLx1pizmf2RUTYAxUobIlbDqLt
	ch/aX+sPqLBv6lvEWY1nDorOB4GpeiZ3MwqBpoZ7xZCUbBWY95Mbz5LJzCAHiQ==
Date: Fri, 25 Apr 2025 08:05:56 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [net-next v7 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250425080556.138922a8@wsk>
In-Reply-To: <0bf77ef6-d884-44d2-8ecc-a530fee215d1@kernel.org>
References: <20250423072911.3513073-1-lukma@denx.de>
	<20250423072911.3513073-5-lukma@denx.de>
	<20250424181110.2734cd0b@kernel.org>
	<0bf77ef6-d884-44d2-8ecc-a530fee215d1@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8.TKQ2DIg4Q.iOHILDMF3JC";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/8.TKQ2DIg4Q.iOHILDMF3JC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof, Jakub,

> On 25/04/2025 03:11, Jakub Kicinski wrote:
> > On Wed, 23 Apr 2025 09:29:08 +0200 Lukasz Majewski wrote: =20
> >> This patch series provides support for More Than IP L2 switch
> >> embedded in the imx287 SoC.
> >>
> >> This is a two port switch (placed between uDMA[01] and
> >> MAC-NET[01]), which can be used for offloading the network traffic.
> >>
> >> It can be used interchangeably with current FEC driver - to be more
> >> specific: one can use either of it, depending on the requirements.
> >>
> >> The biggest difference is the usage of DMA - when FEC is used,
> >> separate DMAs are available for each ENET-MAC block.
> >> However, with switch enabled - only the DMA0 is used to
> >> send/receive data to/form switch (and then switch sends them to
> >> respecitive ports). =20
> >=20
> > Lots of sparse warnings and build issues here, at least on x86.
> >=20
> > Could you make sure it's clean with an allmodconfig config,=20
> > something like:
> >=20
> > make C=3D1 W=3D1 drivers/net/ethernet/freescale/mtipsw/  =20
>=20
> ... and W=3D1 with clang as well.
>=20

The sparse warnings are because of struct switch_t casting and register
access with this paradigm (as it is done with other drivers).

What is the advise here from the community?

> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/8.TKQ2DIg4Q.iOHILDMF3JC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgLJkQACgkQAR8vZIA0
zr03Fgf+KfcqvqXrwV6oo9XJVMdSNQIoB0p4NlpvVAe5aBxAydJI1xm3RrEZXNPB
TrcywFHW7nVupYx2HApaLOvpgBFWEK0WbXSfc2EbwtFXWaaUQ+HGbpV4jAmvHbul
RWNftPG+5U26bQE9B6hrXU7Ceve1/wAscafs+U677XofK1RyE33ZOZYsuUsKbVgo
duYePABd2Vo4o97byc0pHVPqCmjhfPA0ID+Arzs+7aGx2ym7JqZUjRjmbADnmKg3
7dRtO0/LmgzGdP9i4B7AvcYeHox7iUjmmqp9yXfbqyagRKcsOKqguUVviqtSjwmP
AlDFyZxoEjM8RW9Jw2Lyzwycn6MhzA==
=ESLF
-----END PGP SIGNATURE-----

--Sig_/8.TKQ2DIg4Q.iOHILDMF3JC--

