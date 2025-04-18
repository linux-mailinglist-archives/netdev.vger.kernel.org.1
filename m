Return-Path: <netdev+bounces-184092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B36A9350B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5211D19E35C0
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054026F449;
	Fri, 18 Apr 2025 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EpGng0De"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238C26E162;
	Fri, 18 Apr 2025 09:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966950; cv=none; b=WIrDzQo09m503tpPFGW8YR8ZflUaC4S4Q6SMu4Xt2ZbzZ+VaD/aZGM8RmlLrxakq+dJjXm9MiplocC5nWsRZQvssrQ9eDllZ697VE1DnLjZ+NLTTUYJo0MyuS6xq+GtK499XtjHQtr+T1wIMjJ7hrzskcKFT0+kEr7L0gq4PV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966950; c=relaxed/simple;
	bh=JynCZgSX1XdUMyAxeKSpT+IEJlv5EBM+y7URuLCRBPU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaogGdBmtTLwKr8yjLUnIIK4Id+4HkQz7nhcNB4gT5LqtEcUuQj4AMjeb+1xUvd7G8nEfFCjfui9wQ5xacMLZHWV8ise3iVXrKpmenSwJ7W6CSwC1CuqrMfZVHEtcZIncgClZmRm4D6TyKWPloPTGhPx9/o0yF2agNR2K2NtEoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EpGng0De; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3953A102E6336;
	Fri, 18 Apr 2025 11:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1744966946; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Lyew1MxDu19C3OjjtiwDxB9nbZkc14Dt2w507Oz3TyY=;
	b=EpGng0DelcMIUsNvKPpsZEFgb8UNtpCfv4Zb/FiQckyHVaIepb7eyl2o8OM8GAVJyiF+Qu
	9fSCZkjBP2RC1PgEydrW6zJkarvFUtbUEHYMxhD/r3+KCUKfRCBNmUHD3GZOGyktFzwXUE
	u6l2HDekPay9dh4glCNgAtKITh5tVazdlB3rNbJ9ZOl3BQeYF2dh2D0WzEp2aUM3omyxxC
	nT92P13KW4i8+kHQt4XEN97GHuwUQmDnBuur1G/i+hbS0C9Fmi5g4lfYeAnfdfRmlmbbo8
	NQjeiRDZw2+wBczT8RX2Yj1xSSF7g4bnadwLkU0KYEPloYv4DZkDOmYWTb57Hw==
Date: Fri, 18 Apr 2025 11:02:23 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Simon Horman
 <horms@kernel.org>
Subject: Re: [net-next v6 4/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20250418110223.594f586f@wsk>
In-Reply-To: <38f36d00-e461-4fc5-a98b-9b2d94d93c69@gmx.net>
References: <20250418060716.3498031-1-lukma@denx.de>
	<20250418060716.3498031-5-lukma@denx.de>
	<38f36d00-e461-4fc5-a98b-9b2d94d93c69@gmx.net>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iP=CeZYpD+_6T=lMjmJSf8s";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/iP=CeZYpD+_6T=lMjmJSf8s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Am 18.04.25 um 08:07 schrieb Lukasz Majewski:
> > This patch series provides support for More Than IP L2 switch
> > embedded in the imx287 SoC.
> >
> > This is a two port switch (placed between uDMA[01] and MAC-NET[01]),
> > which can be used for offloading the network traffic.
> >
> > It can be used interchangeably with current FEC driver - to be more
> > specific: one can use either of it, depending on the requirements.
> >
> > The biggest difference is the usage of DMA - when FEC is used,
> > separate DMAs are available for each ENET-MAC block.
> > However, with switch enabled - only the DMA0 is used to
> > send/receive data to/form switch (and then switch sends them to
> > respecitive ports).
> >
> > Signed-off-by: Lukasz Majewski <lukma@denx.de> =20
> After changing the IRQ name part mention in patch 1, you can add
>=20
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
>=20

Shall I add RoB tag to all patches?

I will wait for ACK from at least Andrew and then reset the v7 with all
tags collected.

> Thanks




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/iP=CeZYpD+_6T=lMjmJSf8s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmgCFR8ACgkQAR8vZIA0
zr0z6Qf+OLTAcpxhxBxIYWQNZrcVuoJouHXGObXilKYz0taH+/2NJPlEVldKdt79
T+rTrMBKLCx6NFaUAujS63HHdli4yR7wfZsv5Ry2QTdN92nMuSnyeUOyITaBDwVA
wrfxapywH5KswGvbq0ZdINFP3MN8RjmFx46R6vkDxThOKDmqaOLYmXKWkaQ0Hfl+
V792yJjlhFn+LhNipqZ3c0k5aPEhX8qKnJaCuggj1A0BqZIsxrYKtwF0bXaNcmRm
EbJVY4AKMQGEcFNTXBJkDb3Xx9ODt6OotMibszn1VIXfSMRtyzfTRzxYTiC6ey7I
lntBmtTVZUzf2tBd8OqK9Yka8B27GA==
=iHKp
-----END PGP SIGNATURE-----

--Sig_/iP=CeZYpD+_6T=lMjmJSf8s--

