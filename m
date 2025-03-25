Return-Path: <netdev+bounces-177405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF8FA7014A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A7568428D6
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDC826FD92;
	Tue, 25 Mar 2025 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Ph2VMeNV"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298226FA70;
	Tue, 25 Mar 2025 12:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906400; cv=none; b=IGAOU9wUJzf02MtuWdqOGojlP/GDjLLHYFGf7oKvncZJCZ/4mwAUCbnr1mS8eWKpOXsc2fIqwlN3+lA81bi+KbaoujfXVPk6YU962sxSNC+Gw2eD9hoaHDGDLtN7Vl0kuHp7YdQBnQq/htlK1yebzEq1H0ZUWJyAK8UQyXfOjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906400; c=relaxed/simple;
	bh=hMfpvuD8OHyHlBPGVhbZTTgGFI+xWrk3NeZsR5xWQWE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CByc54kgVIvPtzCb6ZxkoD9W8k4NrYzWGPSY40N+C5gHyxs0HukgJIx8Rh+HCwBJmGXVRuWjngfi4ng55fBhvF3zl9soOp8WZAyd2nLzjywQbBuN16qDwPcRUmN26emuDnSPhNka0+RQn0robvGhfjQ0ugDF0bi4mms5JZOKFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Ph2VMeNV; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F7EB10382F1B;
	Tue, 25 Mar 2025 13:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742906395; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=BlO6BNtBl1gk8zG3pRpzJ3qRY4omgmymjs/5E1n8HjU=;
	b=Ph2VMeNVjojq7TyvN7jh1Xvncyxwlz6NpBlppHNo9w5Iu/1wa4qn5QR39AYjxqjTAPqwxR
	TXeReWMOVxrLOSSlLiltJ2Wjjk18iMnCgzrRsVo1dHiPnSUCuiQMi9ACYt+WPA3/Fiyxtw
	n9Tj4We6m0IQSaocMpO8/8CbewGDOxAHdmHmQ01rfWsS3KFbnTDUJWFJz2JlxQ19Ualrew
	WRWDujnxrIt04pmWVl4zQWTf5IcXPwXu2uitdwbv7i7Bz2FqdYYnyuJSqHikLpGQTp5zub
	mFnyW726zYKT9VIcjgCpTN8yRITpCo620DY8AGB8iiOhG6lu66/pX0AXMfDzfQ==
Date: Tue, 25 Mar 2025 13:39:49 +0100
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
Message-ID: <20250325133949.7782a8a5@wsk>
In-Reply-To: <bf6d066c-f0dd-471a-bb61-9132476b515a@kernel.org>
References: <20250325115736.1732721-1-lukma@denx.de>
	<20250325115736.1732721-3-lukma@denx.de>
	<2bf73cc2-c79a-4a06-9c5f-174e3b846f1d@kernel.org>
	<20250325131507.692804cd@wsk>
	<bf6d066c-f0dd-471a-bb61-9132476b515a@kernel.org>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dA91ybGkb__gwOvzVaQYG_K";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3

--Sig_/dA91ybGkb__gwOvzVaQYG_K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

> On 25/03/2025 13:15, Lukasz Majewski wrote:
> > Hi Krzysztof,
> >  =20
> >> On 25/03/2025 12:57, Lukasz Majewski wrote: =20
> >>> This patch provides description of the MTIP L2 switch available in
> >>> some NXP's SOCs - imx287, vf610.
> >>>
> >>> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >>> ---
> >>>  .../bindings/net/fec,mtip-switch.yaml         | 160
> >>> ++++++++++++++++++   =20
> >>
> >> Use compatible as filename. =20
> >=20
> > I've followed the fsl,fec.yaml as an example. This file has
> > description for all the device tree sources from fec_main.c =20
>=20
>=20
> That's a 14 year old binding, so clear antipattern.

For some reason it is still there...

>=20
> >=20
> > I've considered adding the full name - e.g.
> > fec,imx287-mtip-switch.yaml but this driver could (and probably
> > will) be extended to vf610. =20
>=20
> Unless you add vf610 now, this should follow the compatible name.

Ok.

>=20
> >=20
> > So what is the advised way to go?
> >  =20
> >> =20
> >>>  1 file changed, 160 insertions(+)
> >>>  create mode 100644
> >>> Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> >>>
> >>> diff --git
> >>> a/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> >>> b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml new
> >>> file mode 100644 index 000000000000..cd85385e0f79 --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/net/fec,mtip-switch.yaml
> >>> @@ -0,0 +1,160 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/net/fsl,mtip-switch.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Freescale MTIP Level 2 (L2) switch
> >>> +
> >>> +maintainers:
> >>> +  - Lukasz Majewski <lukma@denx.de>
> >>> +   =20
> >>
> >> description? =20
> >=20
> > Ok.
> >  =20
> >> =20
> >>> +allOf:
> >>> +  - $ref: ethernet-controller.yaml#
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    oneOf:   =20
> >>
> >> Drop, you have only one variant. =20
> >=20
> > Ok, for imx287 this can be dropped, and then extended with vf610.
> >  =20
> >> =20
> >>> +      - enum:
> >>> +	  - imx287-mtip-switch   =20
> >>
> >> This wasn't tested. Except whitespace errors, above compatible does
> >> not have format of compatible. Please look at other NXP bindings.
> >>
> >> Missing blank line.
> >> =20
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 3   =20
> >>
> >> Need to list items instead.
> >> =20
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 4
> >>> +    description:
> >>> +      The "ipg", for MAC ipg_clk_s, ipg_clk_mac_s that are for
> >>> register accessing.
> >>> +      The "ahb", for MAC ipg_clk, ipg_clk_mac that are bus clock.
> >>> +      The "ptp"(option), for IEEE1588 timer clock that requires
> >>> the clock.
> >>> +      The "enet_out"(option), output clock for external device,
> >>> like supply clock
> >>> +      for PHY. The clock is required if PHY clock source from
> >>> SOC.=20
> >>
> >> Same problems. This binding does not look at all as any other
> >> binding. I finish review here, but the code has similar trivial
> >> issues all the way, including incorrect indentation. Start from
> >> well reviewed existing binding or example-schema. =20
> >=20
> > As I've stated above - this code is reduced copy of fsl,fec.yaml...
> > =20
>=20
> Don't take the worst, old code with all the anti-patterns we point out
> on each review, as an example.
>=20
> Take the most recent, well reviewed binding as an example. Or
> example-schema.

Ok.

>=20
> Best regards,
> Krzysztof


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/dA91ybGkb__gwOvzVaQYG_K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmfipBUACgkQAR8vZIA0
zr3d0wf/bxDkHq2CXcGN5WbTK8hga817FnMv0+WxVnrO7+RB2b0lrOdZaTXXcwb6
KM0DjW6hv1ZV/tY9uU1hNCnw3dYxia9dKKts3Xy7doPol9M31NkM9HUYpZ2gZPtR
Db9R7nCqrNZmh2h3jqbVB1lZBpR4B9mFilCVs6+3hMn3y5bQWu6hRNvq5K+oSc9D
d//uIGq7euZXpaAXxujJyYGQDEuJdmVf9lzktP6g9PCt/Tk799ulW7qe0RWcjfYl
E48J4AzVxR1rCs2gJqAsxN/cKsCsuLmerC057YamM8NKVuqa30xmt7UTPFjJ89wb
KjeIiOpkE56KfTAlW8new9bOhBT09A==
=AANv
-----END PGP SIGNATURE-----

--Sig_/dA91ybGkb__gwOvzVaQYG_K--

