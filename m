Return-Path: <netdev+bounces-149781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 337219E7686
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDCBC284758
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 16:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41E81F63F6;
	Fri,  6 Dec 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKFuZvVH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B5F20626A;
	Fri,  6 Dec 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733504228; cv=none; b=VzB+G6M6Bl6+hJpSB0lOQLAqmYKCDjDXwCDwKWgCZKJRR1UYYqTwjdFDRaucEly8mJ9sthzWVJoHxm97NMEH2iENbIQImTL7xqsKHItIOVrMPUT/99ontUHkorGRdb6S/NfPM7HlXVkacZ/EP7Iazo3YPNmGvlYmq1RyTZlBEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733504228; c=relaxed/simple;
	bh=IlbyNXzPNPA3XWALgOApHSlRf9t/sdvMEQkGLZZhe2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CitnWBkA92pwdC5v6Arui2jxAEjF8tWyjKfbxHVntunQ7QU1SH1bD4jbeyr4ZoJRt9tnac72V8jxNXd4J7G9sCsC3OPP6l28mvkdUsLutnKnxvYoZXzUQ+8eihV8iPh1GUiDm0c8DeoRN1CsQwafLYNIvhIQoo3k7k3XwqHsO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKFuZvVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63A8C4CED1;
	Fri,  6 Dec 2024 16:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733504228;
	bh=IlbyNXzPNPA3XWALgOApHSlRf9t/sdvMEQkGLZZhe2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKFuZvVHuFHoCSNTrhMzKMGPYetsabsJvzKRQduJkh2nmwUv2hWQ4m3yXQLJ1/fnZ
	 L1o7TBpt6IpSo0pXNvUwIyjEcNlG5VaKfVgVX/sS8BoYVTsioyQygrbznr86Gw8aX+
	 rADfDYdzNjthGrzunUaadGx2yVOLtHeXbLbGA+JrTz6vhIYemmRmuGWcaOtrPyawxu
	 kgnnG9ceBfSJKzjHgJg5wRhOaO/Era+tKF8MZ7xLPr1vtpjXiUJq+IcWTCRjA6B1zF
	 WyGZlhzMo2s7+CXpIbGsRYq+CHT5ciGpfYoH1xzP/PL346ARbkbrCHaxnHKYYYQiMP
	 2KyT+RG/0Pfwg==
Date: Fri, 6 Dec 2024 16:57:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v1 1/5] dt-bindings: net: Add TI DP83TD510 10BaseT1L PHY
Message-ID: <20241206-wrought-jailbreak-52cc4a21a713@spud>
References: <20241205125640.1253996-1-o.rempel@pengutronix.de>
 <20241205125640.1253996-2-o.rempel@pengutronix.de>
 <20241205-immortal-sneak-8c5a348a8563@spud>
 <Z1KxZmRekrYGSdd4@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1+XZodfQGimtFoRM"
Content-Disposition: inline
In-Reply-To: <Z1KxZmRekrYGSdd4@pengutronix.de>


--1+XZodfQGimtFoRM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 09:10:14AM +0100, Oleksij Rempel wrote:
> On Thu, Dec 05, 2024 at 05:18:59PM +0000, Conor Dooley wrote:
> > On Thu, Dec 05, 2024 at 01:56:36PM +0100, Oleksij Rempel wrote:
> > > Introduce devicetree binding for the Texas Instruments DP83TD510
> > > Ultra Low Power 802.3cg 10Base-T1L Single Pair Ethernet PHY.
> > >=20
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
> > >  .../devicetree/bindings/net/ti,dp83td510.yaml | 35 +++++++++++++++++=
++
> > >  1 file changed, 35 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/ti,dp83td51=
0.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/ti,dp83td510.yaml =
b/Documentation/devicetree/bindings/net/ti,dp83td510.yaml
> > > new file mode 100644
> > > index 000000000000..cf13e86a4017
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/net/ti,dp83td510.yaml
> > > @@ -0,0 +1,35 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/net/ti,dp83td510.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI DP83TD510 10BaseT1L PHY
> > > +
> > > +maintainers:
> > > +  - Oleksij Rempel <o.rempel@pengutronix.de>
> > > +
> > > +description:
> > > +  DP83TD510E Ultra Low Power 802.3cg 10Base-T1L 10M Single Pair Ethe=
rnet PHY
> > > +
> > > +allOf:
> > > +  - $ref: ethernet-phy.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - ethernet-phy-id2000.0181
> >=20
> > There's nothing specific here, can someone remind me why the generic
> > binding is not enough?
>=20
> The missing binding was blamed by checkpatch. Haw should I proceed with t=
his
> patch?

Does dtbs_check complain when you use it in a dts? What you have here
matches against the pattern ^ethernet-phy-id[a-f0-9]{4}\\.[a-f0-9]{4}$
so I think it won't. checkpatch might be too dumb to evaluate the regex?

--1+XZodfQGimtFoRM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1Ms3QAKCRB4tDGHoIJi
0lUpAP9+qqmvW19GgRq0c+lbiZOY7fIICF4B/h1qoUeHagDQTQD/fDngZjYfswC5
hPbbjp55rWg5MrwOXxr3+f02ruaodws=
=XnGn
-----END PGP SIGNATURE-----

--1+XZodfQGimtFoRM--

