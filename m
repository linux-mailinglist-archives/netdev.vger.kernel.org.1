Return-Path: <netdev+bounces-177446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAF9A703A2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B9E7A34DE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE52825A2C0;
	Tue, 25 Mar 2025 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="RDBIDrIm"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ABC2561C3;
	Tue, 25 Mar 2025 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912849; cv=none; b=qUjVfkgJw1Cq3VhFQ4dEHPbBX/llqCO7ijS+Kxr15wcCBkRV8w/LTDCtufm7GCPsL07zgaXu94AXNWXZwfgb1Gu5aDG30eqASen+UyXjMVEoQeFLi8+yF5N06B/kBRcwWr0A6SnpdwSK4R6fl/R+37nIwUUqlNPUurA/61ZmKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912849; c=relaxed/simple;
	bh=s62avkPOhLvhos9H7jBVW/rOZb45kpCRMFopOI7Upzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y9Kru5n9lp89+QWbMFX2HODZvxO+FL1DJnfTGefstG1tflYik/uSnCgKD6IpKLlQxh76GRGk9yOD8aXhwGhV487RPbRw8J1msH47ustbOrDSZZ6M3F5I317qxIua7QIBS6lrcf7iNIqzwhJzPdNXTnztbncok0f2sDTPBfp7xKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=RDBIDrIm; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A5B811029027E;
	Tue, 25 Mar 2025 15:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742912846; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=gSvf9PO2tqFZJOjUKNihe05fihUTdxiKCVGVrwqCb5M=;
	b=RDBIDrIm9ENcVGoDsRYP7G8NhrGNiZndKT7QocmSB7YMCPMHnr5kq9ESBuGGZOJkK8IBiH
	E8vQJNj+haMjKM8uMz8f1EaHszQ5qd7vajeem8EwUGnrbgLI1qr6se1Rwzamz8Ebr7f2pC
	qBYhog+vHqI+jmkXw8byuk1fF0zKXl1sKz5yQo0eprQB+H8ty9T8vx34oomS210b0ldtE4
	wYrBp2G1xSZUVNUctLdxhhmJLS5vAE72mDMvTfIPKQkQHT3T9iJZfzk3oKRdbLHaYWMuKR
	CH28TPU68Q3V8qZvaOy6syttfnkDCR0ohZeKR66koiT77+TjuparqLJcB8mqrw==
Date: Tue, 25 Mar 2025 15:27:21 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 davem@davemloft.net, Andrew Lunn <andrew+netdev@lunn.ch>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH 2/5] dt-bindings: net: Add MTIP L2 switch description
 (fec,mtip-switch.yaml)
Message-ID: <20250325152721.4aeb3761@wsk>
In-Reply-To: <7d3fbe0b-f566-4615-a5df-a8f3b4544c3b@kernel.org>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-3-lukma@denx.de>
	<2bf73cc2-c79a-4a06-9c5f-174e3b846f1d@kernel.org>
	<20250325131507.692804cd@wsk>
	<bf6d066c-f0dd-471a-bb61-9132476b515a@kernel.org>
	<20250325133949.7782a8a5@wsk>
	<7d3fbe0b-f566-4615-a5df-a8f3b4544c3b@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6lSmEnGq9ohM/ZV9=THLOqf";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/6lSmEnGq9ohM/ZV9=THLOqf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 25/03/2025 13:39, Lukasz Majewski wrote:
> > Hi Krzysztof,
> >  =20
> >> On 25/03/2025 13:15, Lukasz Majewski wrote: =20
> >>> Hi Krzysztof,
> >>>    =20
> >>>> On 25/03/2025 12:57, Lukasz Majewski wrote:   =20
> >>>>> This patch provides description of the MTIP L2 switch available
> >>>>> in some NXP's SOCs - imx287, vf610.
> >>>>>
> >>>>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>>>> ---
> >>>>>  .../bindings/net/fec,mtip-switch.yaml         | 160
> >>>>> ++++++++++++++++++     =20
> >>>>
> >>>> Use compatible as filename.   =20
> >>>
> >>> I've followed the fsl,fec.yaml as an example. This file has
> >>> description for all the device tree sources from fec_main.c   =20
> >>
> >>
> >> That's a 14 year old binding, so clear antipattern. =20
> >=20
> > For some reason it is still there... =20
>=20
> And it will be there for very long time. Bindings are not removed just
> because they are old, because they are an ABI. That's still not a
> reason to use something old as starting point.

It was unintentional - if I would know that fsl,fec.yaml is so old, I
would use another one as a starting point.

I will use more recent one to provide proper bindings for this driver.

>=20
> It's the same with drivers, although driver can be easier changed and
> old pattern can be dropped. You cannot easily drop old, anti-patterns
> from the binding.

Yes, I'm fully aware of the problem.

>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/6lSmEnGq9ohM/ZV9=THLOqf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfivUkACgkQAR8vZIA0
zr2Tqwf/SGk7rTkRbhWp18Uj5U62OiHZ4Z5IG6yCm/VVMS5W+g3WAdCQAmLkeIGF
XYksXNPNlSjajTtdymcLx3k6HtMaLAbwTcyRjveRkTIaj2qYZP/svvbnTaEsekE1
azzE5nMLIe4frACfzbht3MZ5jRGxM2g7n4tcs39tk8p+O7/trcg9Wv2YYy69zfFU
jeXjlAMkKuh2Sz0oyadV/K7OWB3CcLqxwcjYfUueEyk/iB7iuTl9Sq7kfS5R7sEb
1kMqu+9tNt8b2+ShhNycPDmwOI4juRWaT3pBvlZHrYAO5SISQ051HJv0H2jYARo1
Vv8/qfE4zOTZseWUfTp3GKXhZFDBAg==
=Loga
-----END PGP SIGNATURE-----

--Sig_/6lSmEnGq9ohM/ZV9=THLOqf--

