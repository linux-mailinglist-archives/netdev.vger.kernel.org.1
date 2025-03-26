Return-Path: <netdev+bounces-177733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597FA717B4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072001891715
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF31EB5DD;
	Wed, 26 Mar 2025 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MHOQwHpi"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD91DD87D;
	Wed, 26 Mar 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996607; cv=none; b=AzbsFZMiTbbUWFNtmoFEob54PlLgyly2h4C6W00SpH0I3HPrMHfrUb/E/Nsd/J/I5XNb+40kQe+6kPx7+oDX26BUBvu0J4zF8YFA5pjnio8v74dCro4Xt7tgJ1CqVL07tQ4Sd1IciswGHiOCFXrF3cZ1u29hFviomJ7F5q1Jx80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996607; c=relaxed/simple;
	bh=rsQJ5LC/bSdyiKQG9gXUm29k+4ZRN5zoxDpj5nrX4ps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rp18xzhU6h+lKc47tFOjp5sKgiOblYmKIshvRy8gBjXOSqGc8k771bMpYzOdXKRJnyLrgUF7xvVpnoQ7PE23e4kskmzJ1hx0urXI4PFZKJ+rDi00zxdi7ZwSucFKPQDkOl/4NColM9dWzTPAEzDZw9nGHyZH7jX2WG4YgPkSUgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MHOQwHpi; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8B9CC1026C8B4;
	Wed, 26 Mar 2025 14:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742996602; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=3h4Wq9WQJYYYEPwbk70jEgO+x7vy4tSco2GJpE6NQEM=;
	b=MHOQwHpiBpSfJOp1+TFl4lGaw2nxTj8fOT9IVNMcOVvh6ENcLyeCIzVV7qqg9l0ZVft3jc
	vDObYEXPYrZCh4w/zF3SwarxuHvqrOoiGrO2uVWWte1gmJkzFx6dM/g19UuBZPRLIEEZMx
	vH7zi0byyTafmd9BZOsMwcs/xw6DOKDfe4tXL/nvmfRiasLyDpD+3GWEpj47ofjbPjj8jO
	sZDUMfdMO7/kRU3tNCf7Kl5FN4zaVCR2/ZIgX24MQYHF0f99iHQB2G0ZtG00xFc7td0qPk
	IEYvCaJftTKslzcAuoXdysSbsw3boD+qS5D6CD2BtY+wLNgzbP1iM70Dfb6oLg==
Date: Wed, 26 Mar 2025 14:43:16 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20250326144316.2ca252f7@wsk>
In-Reply-To: <2ccab52d-5ed1-4257-a8f1-328c76127ebe@lunn.ch>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-3-lukma@denx.de>
	<2ccab52d-5ed1-4257-a8f1-328c76127ebe@lunn.ch>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hdQ30b6hV96Q+u6lViERlzE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/hdQ30b6hV96Q+u6lViERlzE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> > +  phy-reset-gpios:
> > +    deprecated: true
> > +    description:
> > +      Should specify the gpio for phy reset. =20
>=20
> It seem odd that a new binding has deprecated properties. Maybe add a
> comment in the commit message as to why they are there. I assume this
> is because you are re-using part of the FEC code as is, and it
> implements them?
>=20

In the case of MTIP L2 switch, the reset gpio line (in my case, but
also on e.g. imx28-evk, and vf610) is single for both PHYs.

I could move the reset to mdio child nodes, but this would be
problematic, as asserting reset on one PHY would reset the second one.

That is why there is a single 'phy-reset-gpios' property for the switch
driver.

I do believe that for FEC it may be deprecated, but for the HW
configurations I'm aware of it fits best.=20

> 	   Andrew
>=20


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/hdQ30b6hV96Q+u6lViERlzE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfkBHQACgkQAR8vZIA0
zr239QgA3MSVrlumXuhEjcoCf8W+hg3avvIWRw4daEsO50k/ugQTmv9/4bqbfj6k
BtxEPPhyiOephpxS8XHQF9E/202BBMl3f3llgZHLDlxi1ufU76syBEElHKoIe9RQ
I+5tNr/r4B7xTT1FB27AYmCGPzg1C157biYYyJQcqARQdHBIUp6yhNuNPEup4Jpx
2rcD0nNQtlgV/7jQJDToUyXCyIiZB/+vJ9saevLSPthW+l2QvraOVqWNdoQc9687
cWetCOL7cfuxTZ2Sp9BplA0w+rBi6wUvLEsYzaq96H91HAwrpGZ+prcT/eZQgfUk
o1FdUJU4MbTZK1uZV4BLgLOLFWDgbQ==
=SJGV
-----END PGP SIGNATURE-----

--Sig_/hdQ30b6hV96Q+u6lViERlzE--

