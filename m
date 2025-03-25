Return-Path: <netdev+bounces-177350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 740E0A6FADE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587F516E0F9
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B252566F2;
	Tue, 25 Mar 2025 12:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="QLKfZA5h"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66D6A937;
	Tue, 25 Mar 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904967; cv=none; b=gyb8KpQJ74g70iF5bKVYxbmfPYPMDcfLwEfZokBQNcKuaO0+bBSswI2zO0F8xr5Isiro7MAV1VB9vLiUROdsTJJaPGyjBc8EVHai8VSKoCrAckqocF4lWg6kCqLLzRK0Nz0MPaLLn6/wS6tp0nLc7AshSLWuhci/LMMZ0qEJciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904967; c=relaxed/simple;
	bh=DguLGhX9kEpLPrUx76M1TNbQPbRQ0+l3RX/mmVVOTNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIZsaasSGpx0k5wy/Yj+ZvqfRCavEFVg8yg1qIeBhHLogmLqucSHOouicRPGM8AcBk+eLDTNd+++2OloLMTFPpR1GkbgDXFPKrHV5QubAIGKQ5zDfj5ArGAXA1GsnYKGQ2mptoxirngpz+pSGjmzdpM51NowrynzwEs8cEQxkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=QLKfZA5h; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33CA1102EBA49;
	Tue, 25 Mar 2025 13:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742904959; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Vw2aTZfKC8jL612WLeYf7YLLLB/WaqDvcUQ/QnVchBI=;
	b=QLKfZA5hesyp7HKxl4wfAMJm/Eqm1iLloGyqwHdqYMYlU7JKUzljQH8FAvHiekj/fZ6IR6
	nWKratYium4fr/hJiKgEkRw1BgDOPWdBf1mO7j/4sAsa2hiyK/Xx/axqfzxis7vnBd/H5S
	5y8AiWj2Y+HsXX9uAAvp9KOSh4kka192Y9gxL/WN7nEJuwjRk2VgYYHTRHbFYSldPxP+2z
	mvAZ1uGOg9Q2J+ddFJwrtxvLss3h17U1pd4acNFApe8ZIguAvv299V6369chRQffdhDxD2
	Y9jN1ZDdRTvPJFGOhfnFIarSWpqVyc038v5zuXHEGRL+L8mO3lp7l43jL+F7kw==
Date: Tue, 25 Mar 2025 13:15:57 +0100
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
Subject: Re: [PATCH 1/5] MAINTAINERS: Add myself as the MTIP L2 switch
 maintainer (IMX SoCs: imx287)
Message-ID: <20250325131557.275f7c5c@wsk>
In-Reply-To: <e7d3f22f-4576-448a-a77e-644cd21c9a16@kernel.org>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-2-lukma@denx.de>
	<e7d3f22f-4576-448a-a77e-644cd21c9a16@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/24q=A/Ak_cTLWFZ0Fb5BUSM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/24q=A/Ak_cTLWFZ0Fb5BUSM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 25/03/2025 12:57, Lukasz Majewski wrote:
> > Add myself as a maintainer for this particular network driver.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 5959513a7359..255edd825fa1 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9270,6 +9270,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/i2c/i2c-mpc.yaml
> >  F:	drivers/i2c/busses/i2c-mpc.c
> > =20
> > +FREESCALE MTIP ETHERNET SWITCH DRIVER
> > +M:	Lukasz Majewski <lukma@denx.de>
> > +L:	netdev@vger.kernel.org
> > +S:	Maintained
> > +F:
> > Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> > +F:	drivers/net/ethernet/freescale/mtipsw/* =20
>=20
> You need to re-order the patches, there are no such files yet, so this
> causes warnings.

This shall be probably squashed with the patch adding mtipl2sw* files.

>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/24q=A/Ak_cTLWFZ0Fb5BUSM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfinn0ACgkQAR8vZIA0
zr1emQf/fXhcxk4JMbU6x8ViPUfMGnNtieJNZbqixCSsbi5ttFkxRK5g2HwuGSNG
wRfDDxs+yMejO2q2ZRPnboRHMmp0cPs7BBdLsw0cs81BEMqTQN5/IvymAf7sjUST
JXRupMGgghbwq8fkESm2wYzRQE43AvpLM1bbykl+akDt7AVLhqJwHKWk9/NZYcPz
+64fDpsM2Il0oUU2oe5B4SHry4OE33So1s0VyUanuWZxANZnBRvTeh9RA42bviuK
ehdZQVGt2Hi3ZAi5l7WP3GRwzNAzDAK297M4koxXXNKY7JsIGrUTRsLw4ha63gX9
3hia1jZ/itQzBJ+iqsKLdzEN7qHZUg==
=rHL2
-----END PGP SIGNATURE-----

--Sig_/24q=A/Ak_cTLWFZ0Fb5BUSM--

