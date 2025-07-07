Return-Path: <netdev+bounces-204488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 614FBAFAD06
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637E67A5C78
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE7C27CB0A;
	Mon,  7 Jul 2025 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMaIBRWJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC11E5B88;
	Mon,  7 Jul 2025 07:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873104; cv=none; b=iuiWPQ9UT6KbAWOM4oRn0g0EhBVntml6xLS/1iPVWAA3vptVZUAenTEXlmKoOkbvO3nS1Z85hs8BHn7dd5xd2rbXnIgojfbfF9TxD9XNiRIvc9LoQd4Aarv3y7O8vpYe4wQRy+lp9FFX41bJCFbuNg3/l2pTo0s9DOUTA52SSiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873104; c=relaxed/simple;
	bh=46eFcGLsdRruwrd7qIW78WbO3QHQaWoFdR8SB3+A13o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOGvnTilD7UUTlTva3BhoEFOwrAitlhvp654C6f6A9M0mjh+jSIfiCPexRpwHI8iwa/zn6aYVHcXUP1pRziBCpH4amX3zdSq0+52uw8ypMO24b3U5PyHDbAfZaGdbLH5MrYDuRbX4bCdXfYLt86x9wrz0DJaxJp29v+NqB2kPdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMaIBRWJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1942CC4CEF1;
	Mon,  7 Jul 2025 07:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751873103;
	bh=46eFcGLsdRruwrd7qIW78WbO3QHQaWoFdR8SB3+A13o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sMaIBRWJbuqMJ2yNreEoBAkKva2OZkbYt+vqWO+gBU8hSsgbbEBiqLk9MaSzkT1/W
	 7b73V3gs3y2WBe1aiKHXL2FQt9xxZfUmRZhbfMzzm6nh+gmOgF4CaznOX8z2m+lMLc
	 VxsRBrChaLj3NjhhTwIGfUMYuZW1Eu6Tjb2YgwlQyrrHMeW28UsEU0NV2vW29mnauS
	 3uKpUiqDMEoPPg/LwkdrPBwIVZYuWRVNgK77bGbLbEMzHDpME+wF+OwUuTJeLgQ7E4
	 SOSZUFYhgrRGzeWRHtFCh3p7XwsLCYtvypsf9ASmrBPAt97YJPcYP4WumMV3+OHaNN
	 txFYPf2VItdvQ==
Date: Mon, 7 Jul 2025 09:25:00 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/7] dt-bindings: net: airoha: npu: Add
 memory regions used for wlan offload
Message-ID: <aGt2TFyD5-NPUoY4@lore-desk>
References: <20250705-airoha-en7581-wlan-offlaod-v2-0-3cf32785e381@kernel.org>
 <20250705-airoha-en7581-wlan-offlaod-v2-1-3cf32785e381@kernel.org>
 <20250707-topaz-pillbug-of-fame-859822@krzk-bin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e3pQYbwqGNuliQMT"
Content-Disposition: inline
In-Reply-To: <20250707-topaz-pillbug-of-fame-859822@krzk-bin>


--e3pQYbwqGNuliQMT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jul 07, Krzysztof Kozlowski wrote:
> On Sat, Jul 05, 2025 at 11:09:45PM +0200, Lorenzo Bianconi wrote:
> > Document memory regions used by Airoha EN7581 NPU for wlan traffic
> > offloading.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/net/airoha,en7581-npu.yaml   | 20 ++++++++++++=
++++----
> >  1 file changed, 16 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > index 76dd97c3fb4004674dc30a54c039c1cc19afedb3..db9269d1801bafa9be3b6c1=
99a9e30cd23f4aea9 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > @@ -41,15 +41,25 @@ properties:
> >        - description: wlan irq line5
> > =20
> >    memory-region:
> > -    maxItems: 1
> > -    description:
> > -      Memory used to store NPU firmware binary.
> > +    items:
> > +      - description: NPU firmware binary region
> > +      - description: NPU wlan offload RX buffers region
> > +      - description: NPU wlan offload TX buffers region
> > +      - description: NPU wlan offload TX packet identifiers region
> > +
> > +  memory-region-names:
> > +    items:
> > +      - const: binary
>=20
> Rather: firmware

ack, I will fix it.

>=20
> > +      - const: pkt
> > +      - const: tx-pkt
> > +      - const: tx-bufid
> > =20
> >  required:
> >    - compatible
> >    - reg
> >    - interrupts
> >    - memory-region
> > +  - memory-region-names
>=20
> That's ABI break.
>=20

ack, I will fix it.

Regards,
Lorenzo

> Best regards,
> Krzysztof
>=20

--e3pQYbwqGNuliQMT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaGt2TAAKCRA6cBh0uS2t
rL0dAQDG1PVfQDAI41H6UAq/YG3w4NGMDvYKFYsgeoSPL2kTYQD/WDbDbBpyfLSw
rZNTUbVkPrTPxy19YEn1NsgkFGkCBgg=
=Hdxr
-----END PGP SIGNATURE-----

--e3pQYbwqGNuliQMT--

