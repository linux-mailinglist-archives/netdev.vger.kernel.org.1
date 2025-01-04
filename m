Return-Path: <netdev+bounces-155172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C4BA015A6
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0643A3A3710
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BEE1B9835;
	Sat,  4 Jan 2025 15:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HiAHyemJ"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B200E1A29A;
	Sat,  4 Jan 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736005870; cv=none; b=jjrejxJdGjxnghcvzkvDwqJ5futUYLem5tvstfGhL8MTuVBwIS4uXcWoxYLrqRt12FXkFS/KWiyUNARLhIvnO/W9b89+5nSIqS6PN3gOCYQptszOMBbxORza4TglsvtNsB8O8Sc7FWTFHh4NApsJfI1c6msw0kV66d+apky1y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736005870; c=relaxed/simple;
	bh=RBIiuiFjZTpxRCUCA5H5LFIQ0Ajl+f2tKs+OE9cWLZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWAyIhKj7eDLOW8BmaYXr2DcK8Nq+HUG+MJl6OKz0qlNX0OFk4XK3CyMzbJw5gUOimO+zS1EyqK14wmQ3o3ji6qqVvg2EyvkLVERRN8EBzbiLNLFiq3X70BNMohl9DXTJ4logdXReINK4aKZOYyCX3VtBEXIw2OAZiBIviy2XRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HiAHyemJ; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E907420007;
	Sat,  4 Jan 2025 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736005860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdrLJAwV4nIBlrY07hTVpRYLBsbrsfDT2gkvXgyc5eM=;
	b=HiAHyemJJP4vFqvfiO2it1UyZlzulAiw3Fmnwu3DL2oQ2rgbqV1WLf8KRJCNpMEWFL3Ynw
	n879o8G0EImFXOL4eWjFSJ07cS7u2U9YjMcdiJ892NgITYcROCm8Ysc7pRLDTgDuUtiRy3
	9lLUMuI5N+w6CnOY9PG4mlOxap+7KV266a7FGFpEosr2jPUGCq1VJQQeSMtaL9gLXk9XGF
	BDx0NQ1y2rhmR02Kpv4ZtHwNqLdtLSeNHg9rxpmBWq/Wa0haMWBHnb0YjS0YYUKPnPjpm2
	Wi6Y61z9UovLCzvcZG6cEWNZgkxXOjim84CRH4owkNGx7FvZPpGJ8mreZX69oQ==
Date: Sat, 4 Jan 2025 16:50:56 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v4 18/27] regulator: dt-bindings: Add
 regulator-power-budget property
Message-ID: <20250104165056.749da353@kmaincent-XPS-13-7390>
In-Reply-To: <mjtwntmupclvy2dvc66zxxob3py47lew47vq37hfi6v6pmbpne@nr62lnuilzya>
References: <20250103-feature_poe_port_prio-v4-0-dc91a3c0c187@bootlin.com>
	<20250103-feature_poe_port_prio-v4-18-dc91a3c0c187@bootlin.com>
	<mjtwntmupclvy2dvc66zxxob3py47lew47vq37hfi6v6pmbpne@nr62lnuilzya>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 4 Jan 2025 10:42:32 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Fri, Jan 03, 2025 at 10:13:07PM +0100, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > Introduce a new property to describe the power budget of the regulator.
> > This property will allow power management support for regulator consume=
rs
> > like PSE controllers, enabling them to make decisions based on the
> > available power capacity.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > ---
> >=20
> > Changes in v3:
> > - Add type.
> > - Add unit in the name.
> >=20
> > Changes in v2:
> > - new patch.
> > ---
> >  Documentation/devicetree/bindings/regulator/regulator.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/regulator/regulator.yaml
> > b/Documentation/devicetree/bindings/regulator/regulator.yaml index
> > 1ef380d1515e..c5a6b24ebe7b 100644 ---
> > a/Documentation/devicetree/bindings/regulator/regulator.yaml +++
> > b/Documentation/devicetree/bindings/regulator/regulator.yaml @@ -34,6
> > +34,11 @@ properties: regulator-input-current-limit-microamp:
> >      description: maximum input current regulator allows
> > =20
> > +  regulator-power-budget-miniwatt: =20
>=20
> What sort of quantity prefix is a "mini"? How much is a mini?

Oops, that is a brain fart sorry for this. Of course it is milliwatt.

>=20
> > +    description: power budget of the regulator
> > +    $ref: /schemas/types.yaml#/definitions/uint32 =20
>=20
> This should not be needed. Use proper unit from dtschema.

Ok, I was mistaken. There are bindings with this ref in this file, so I tho=
ught
it was needed. I will remove it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

