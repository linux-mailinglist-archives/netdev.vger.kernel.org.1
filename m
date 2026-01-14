Return-Path: <netdev+bounces-249765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A8D1D5AC
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 10:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DA0C4302CA0A
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 09:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECF638735D;
	Wed, 14 Jan 2026 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqZV4UYo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3062387342;
	Wed, 14 Jan 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381275; cv=none; b=T12QC+RV7U45PsOMjO4bIvPHYsztyUs5PLJ+YgEwUJnmJ5kvXnOZGoijX/jO2PclBu5PvcFEO5UDlxZwPgPgsOM/BvZTA+PNpMbrLmEkBuX6xG8OciBQmzzaKEw+Lm1StwNszclFbuV2q6Z5zy6sAisIYOekp8ktqSecuFclI54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381275; c=relaxed/simple;
	bh=VC3Dyy9rRZ0VzDKLm0/8sTI7TgiSnm3oReBYKX7dvy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPEN2aAX8mafUEmr0zj58k5H05c7M0vB0H4n2VRmHEByqeauWftX3PV1aEul4kgLsf6uByjc1v9Yo4J6IzawGirZ7syQ0D9cwk6idUSknfiJ396eYPtOqUfeCd4RwlsfYRS9UBd8GpW+l7ibgByndQ+leOaSgWwqiBzd8EnWPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqZV4UYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8111EC4CEF7;
	Wed, 14 Jan 2026 09:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768381275;
	bh=VC3Dyy9rRZ0VzDKLm0/8sTI7TgiSnm3oReBYKX7dvy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqZV4UYoIrRR8OPjBi9jP1ZFUFpxC/VFAkyQFMKS1HufwAX7yzxDvnfX59j4kwxRC
	 FSqJJwk+fOakasNtFUktQkbBGkVu/9r7j/PJtK5c0KAhuu603PAtbRXlZJIZ2fst+C
	 JjSg0WnFcjP0dg99OP6tQUP7w754s7Ch/KVDcy2FXV0RYNft7Wvkx6tG1xHlKzdZl7
	 hPT9F8dEmCeK50mjXZdfhjogeh7XePQcLN7hOzR79blIHLT1fRLz2kzlGM7aBeU3hE
	 TNsQOBvXkur8ZZoeBoRc+AhNsv9BaWYDoMPiuD9xSrUmIiqAr8Xm0iBkBZIIW0OZRz
	 GYydL0IPLJY9g==
Date: Wed, 14 Jan 2026 10:01:12 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add
 EN7581-7996 support
Message-ID: <aWdbWN6HS0fRqeDk@lore-desk>
References: <20260113-airoha-npu-firmware-name-v2-0-28cb3d230206@kernel.org>
 <20260113-airoha-npu-firmware-name-v2-1-28cb3d230206@kernel.org>
 <20260114-heretic-optimal-seahorse-bb094d@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8Bo5O693e36+5lb1"
Content-Disposition: inline
In-Reply-To: <20260114-heretic-optimal-seahorse-bb094d@quoll>


--8Bo5O693e36+5lb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jan 13, 2026 at 09:20:27AM +0100, Lorenzo Bianconi wrote:
> > Introduce en7581-npu-7996 compatible string in order to enable MT76 NPU
> > offloading for MT7996 (Eagle) chipset since it requires different
> > binaries with respect to the ones used for MT7992 on the EN7581 SoC.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..96b2525527c14f60754885c=
1362b9603349a6353 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > @@ -18,6 +18,7 @@ properties:
> >    compatible:
> >      enum:
> >        - airoha,en7581-npu
> > +      - airoha,en7581-npu-7996
>=20
> This does not warrant new compatible. There is some misunderstanding and
> previous discussion asked you to use proper compatible, not invent fake
> one for non-existing hardware.  Either you have en7996-npu or
> en7581-npu. Not some mixture.

Hi Krzysztof,

We need to specify which fw binaries the airoha NPU module should load
according to the MT76 WiFi chipset is running on the board (since the NPU
firmware images are not the same for all the different WiFi chipsets).
We have two possible combinations:
- EN7581 NPU + MT7996 (Eagle)
- EN7581 NPU + MT7992 (Kite)

Please note the airoha NPU module is always the same (this is why is just
added the -7996 suffix in the compatible string). IIUC you are suggesting
to use the 'airoha,en7996-npu' compatible string, right?

Regards,
Lorenzo

>=20
>=20
> Best regards,
> Krzysztof
>=20

--8Bo5O693e36+5lb1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWdbWAAKCRA6cBh0uS2t
rGmHAP95f/tsbA2Rhzx7wbJr9rMQoWI5S7e4n6hZj3izqRbdZAD+PvEnl+omt91+
XqShavZHMb0vQr5jAsI2MD5uobYNcA4=
=Z9AG
-----END PGP SIGNATURE-----

--8Bo5O693e36+5lb1--

