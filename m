Return-Path: <netdev+bounces-178255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA2EA75FE0
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 09:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559623A8ED6
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 07:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8401AD3E5;
	Mon, 31 Mar 2025 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bkhLB0um"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DAB148316;
	Mon, 31 Mar 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405586; cv=none; b=iVkmL9EgOD0KAP2y+kKk6H9nsszJFgGOb+xNEw6FmdNo4FIDQR14oP17VhfNYx9I9W6OEDYggQfU3twxlsXDNQhi7Vnoc8WtHv60nh2sPoaqPuHUzX9q4M7YqJTxUwYZ2oXvMHWNtB5iIFFWpUsW3Xu9ewZPkwAszgqRQnPTij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405586; c=relaxed/simple;
	bh=kLv4EqQgwdCrvSrr5EdhdhHZ0fV3NRImHOB9sTXjSBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEnqO2A04vJY8MWEGh7DtHW3JKo5o51gqKcabisY3A22KpHyQm+9s4FuaJpX295IC9runUb+Gt57CgJcOuwWVclWkTW7F6YvCIOGPPGHGt4MhDYycj60ud7a6qZRh2dQJH0I36KfknwKmpEXZ1KXNkXxoGSMQPm78j961cmHW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bkhLB0um; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0E28310252BE4;
	Mon, 31 Mar 2025 09:19:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1743405581; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=zHC+RUrju8uKC19QVlEvi9qbZzniETFM7Cs0X8sau98=;
	b=bkhLB0umV2e81WF2Xl3qKpOmUa/m+lCyAO1SLB+J/DjY3URF5h4HBKASO1E764K59F16w1
	9FXE1LwUK4wbsmZVn0NuYH/B03EWeD59CgoypJrleWWvnlpnNxtwVilL00I1zIo02gHV+n
	CHXyvOzfTgsA2Lqk444swNg+4KYlHhqM/vjf4XZ/FhwxNz8nB2azqF+0hlN1iqMNXb9kTU
	BoaLgH9lJMl0iQTZ8jY0nkjDBeZSDTTvkRJwPZ0MKuDVJVB/R1SeYehzf+kpeGyzSeLLxL
	+gh9/Wn1qrBHUuGBjqYH36qE3cxTegWmzsu1q4/eLg9h0f/fchMFOfoNZSH71A==
Date: Mon, 31 Mar 2025 09:19:26 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] dt-bindings: net: Add MTIP L2 switch description
Message-ID: <20250331091926.6f3dba38@wsk>
In-Reply-To: <d4c8de9b-e52c-480b-a3bf-e82979602477@kernel.org>
References: <20250328133544.4149716-1-lukma@denx.de>
	<20250328133544.4149716-2-lukma@denx.de>
	<e6f3e50f-8d97-4dbc-9de3-1d9a137ae09c@kernel.org>
	<20250329231004.4432831b@wsk>
	<564768c3-56f0-4236-86e6-00cacb7b6e7d@kernel.org>
	<20250330223630.4a0b23cc@wsk>
	<d4c8de9b-e52c-480b-a3bf-e82979602477@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_S/Kbz_Yl3YhS+ddHATqFlD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/_S/Kbz_Yl3YhS+ddHATqFlD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 30/03/2025 23:04, Lukasz Majewski wrote:
> > Hi Krzysztof,
> >  =20
> >> On 29/03/2025 23:10, Lukasz Majewski wrote: =20
> >>>>> +     =20
> >>>>
> >>>> If this is ethernet switch, why it does not reference
> >>>> ethernet-switch schema? or dsa.yaml or dsa/ethernet-ports? I am
> >>>> not sure which one should go here, but surprising to see none.
> >>>> =20
> >>>
> >>> It uses:
> >>> $ref:=C2=B7ethernet-controller.yaml#
> >>>
> >>> for "ports".
> >>>
> >>> Other crucial node is "mdio", which references $ref: mdio.yaml#
> >>> =20
> >>
> >> These are children, I am speaking about this device node. =20
> >=20
> > It looks like there is no such reference.
> >=20
> > I've checked the aforementioned ti,cpsw-switch.yaml,
> > microchip,lan966x-switch.yaml and
> > renesas,r8a779f0-ether-switch.yaml.
> >=20
> > Those only have $ref: for ethernet-port children node.
> >=20
> > The "outer" one doesn't have it.
> >=20
> >=20
> > Or am I missing something? =20
>=20
> There is ethernet-switch.yaml for non-DSA switches and there is DSA
> (using ethernet switch, btw). I don't know why these devices do not
> use it, I guess no one converted them after we split ethernet-switch
> out of DSA.

In net next there is:
Documentation/devicetree/bindings/net/dsa/dsa.yaml
Documentation/devicetree/bindings/net/mscc,vsc7514-switch.yaml

which uses
$ref: ethernet-switch.yaml#

I will add it in a similar way as it is in dsa.yaml.

>=20
> Best regards,
> Krzysztof




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/_S/Kbz_Yl3YhS+ddHATqFlD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfqQf4ACgkQAR8vZIA0
zr3YwAf/W+aAijdBzs/ijQ5WOVZ40ggbPOSDQyVVgE911O2jLoMAf5iA1mI+/PA5
y0NhWmAIJajXD/3tu6T2jL+/KGfOPptU0BfJ3W1J5jmGj/rO0VAcESegy115wfBq
Po6x6ouWXbUymQDWpnAQWp7iABOdYLcYZx1R8vsoGiqpmRbTSVg0gil/+XjcyPH7
v0B07w8aV4RD3iBnKqM6n0Y+nRWzSUR0ckDEy4bJAz0jJ5Dmf7XS/hlY5UCBVAAv
2J7dgIMLiAzgLub3niwGAtW2isR30sQC165/6f15tr8int/cM2w9Lhe05nr2EbJ5
aqmbze9vgtfJAKTyDqq51IBHO8SyDA==
=zeoN
-----END PGP SIGNATURE-----

--Sig_/_S/Kbz_Yl3YhS+ddHATqFlD--

