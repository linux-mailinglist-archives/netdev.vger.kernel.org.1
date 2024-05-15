Return-Path: <netdev+bounces-96485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 734218C621D
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A41991C20DC5
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242C147F53;
	Wed, 15 May 2024 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FBeDfTHu"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39F3D966;
	Wed, 15 May 2024 07:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759467; cv=none; b=N9MjnMtXQ2fMEE5UL/J4PEz8SLgjOQOba2s+Y5MMgKjjvayB5UvW0SmpAFNLB2bVv2oun2SsNzDQy7RstEng0InnTTQc4z7VEG3ZgjOUABTI8BBPBaEb+XXBCMY2Tlo8NLj/D1ioHQXmsh+kE6bgCNnWhr8AoJRWjjhtT5FR7gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759467; c=relaxed/simple;
	bh=2Ra2KzvAOrYGHzfBiCx3fJH4YdQUFj7/c4fPwFegBvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVHvjiHhZvh3vliXW2gkowrDHnksKSyaT+GpUBmHWFtGWPGv2QwQBRXAZ9L0/OnYL+nsYUBqVw7yRXl1CS4/RZsE8ZcKxHaJYau/oEAAUUHIrW1HPLrOe+GvznGDPG11PLQzxhpypghE8TMBkBYGrEmpzieE/ru334ccSnlFSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FBeDfTHu; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: lukma@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 25DEE8817B;
	Wed, 15 May 2024 09:50:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715759460;
	bh=Ut7zCC++fvkmhRkRtm0kIKlPKyPQE/wa4b3WctClYC0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FBeDfTHunEQaZwYEM62M0gIUY7ppCx+1BveYVUZLakJDHow3GHaN0Z6EsxZwfHgKd
	 Bgr1Dpi+Inwj/RvWmPIVh9Xsv0CK2HBNwzxGGMqQdvGVTylym2wlWwVuzjO57x+DXW
	 HrqFQ62GzaUSct92pYhjCshGSXge8snJvCNelKdjdTHUOm5a0JDT6ywUU4QLraGLsG
	 /5DOKi8ajNG5AsV5p54y0GYOjN9AX5ffPZmdxsmGzO2DUcOr07ugBRxA7iXXost4by
	 wy2ZaT6e3kYSuAXqk02BGyA6AP6UOiDdYy17Jtxv2vCWnr+tuSwA4sYiGTnrDsJOxZ
	 4/CNjKvSV1ypQ==
Date: Wed, 15 May 2024 09:50:35 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Ravi
 Gunasekaran <r-gunasekaran@ti.com>, Simon Horman <horms@kernel.org>, Nikita
 Zhandarovich <n.zhandarovich@fintech.ru>, Murali Karicheri
 <m-karicheri2@ti.com>, Arvid Brodin <Arvid.Brodin@xdin.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 Casper Andersson <casper.casan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Setup and delete proxy prune timer only when
 RedBox is enabled
Message-ID: <20240515095035.1c6a8e47@wsk>
In-Reply-To: <20240515071448.Vf_t99dI@linutronix.de>
References: <20240514091306.229444-1-lukma@denx.de>
	<20240515064139.-B-_Hf0_@linutronix.de>
	<20240515090904.477c6b5f@wsk>
	<20240515071448.Vf_t99dI@linutronix.de>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=iNR8my_p0HXF67qrEs5xe0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

--Sig_/=iNR8my_p0HXF67qrEs5xe0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

> On 2024-05-15 09:09:04 [+0200], Lukasz Majewski wrote:
> > Hi Sebastian, =20
> Hi Lukasz,
>=20
> > My concern is only with resource allocation - when RedBox is not
> > enabled the resources for this particular, not used timer are
> > allocated anyway. =20
>=20
> timer_setup() does not allocate any resources. The initialisation is
> pure static assignment. The timer subsystem does not look at this
> timer until mod_timer() is invoked (or something similar).

Thanks for the clarification.

Considering the above - please just drop this patch.

>=20
> > If this can be omitted - then we can drop the patch.
> >=20
> > Best regards,
> >=20
> > Lukasz Majewski =20
>=20
> Sebastian




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/=iNR8my_p0HXF67qrEs5xe0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmZEaUsACgkQAR8vZIA0
zr28cAf/c81TJAjvacDjJZwGsTLd9w7jFwu4PZCY5cfl+cd73FlQSoNiMk/DdRrL
CSOoMxmFXrIT5dn0E9tAZpbphGaAjf8tJdH5E04RVTwiwNx2EgjOj7ePVvo5SX9P
p2JRFNhr0ZMg+AfeX6ybhWpPsgumbDyfbUlCV+DZYskMV0Ir71PKY5bC7tRGl/cV
XQC6F97d3pJFDAezcDoBLN5fQ7jp62/ZDVFoaztJkd0Vj5BTjI4eN/VoEvpxTu5m
EHi1HVUc3v9R0h6vHwpLvyMViIDXWGsCR3XUE+Aeebaz8SspUKVMTBSUv/CapekN
gUDt8jO3skZCNXRpgbxK+oZZFAu1Fg==
=tCGb
-----END PGP SIGNATURE-----

--Sig_/=iNR8my_p0HXF67qrEs5xe0--

