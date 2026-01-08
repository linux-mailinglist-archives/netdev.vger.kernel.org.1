Return-Path: <netdev+bounces-248018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B75ED01E82
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 10:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1668307A54D
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 09:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9094F442211;
	Thu,  8 Jan 2026 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOLwTJ82"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181004421F1;
	Thu,  8 Jan 2026 09:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864502; cv=none; b=e0elXWjrliiCkvfNdjQTczt6hhED4w5ZyqT8r2WTHIB4vp0etOUuHI3Na1bO9co71LHjPk8VLVX+p7J2EJGKwZV+xHWMhQgrO9iN8rTnIcJzcObhFNt/yckFSbGzU70nEaRtWrfKpTQJW/CkBOWGtH2Cp/ZAfAnPTULZSBrZuL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864502; c=relaxed/simple;
	bh=CzOR5Mo+mYtepiOYY1ecX1LmQjainZbbcck/O7x/XDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5cL1bRhs8y8kvnWaaSIc/LtXfZ02J+Fo8u/lgoW8C4GVZhNmupUTC9pIQ8FJaZrKk4tmxzKKSMQ6xPrdta8e/dwGWMAqDk0pc3d+goyk1nesp0savLBes4gFiGL95rEF1i+UH0qjCmjkX408+d9uaiTRk1WaCMX75VQUWc8l7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOLwTJ82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB09C16AAE;
	Thu,  8 Jan 2026 09:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864500;
	bh=CzOR5Mo+mYtepiOYY1ecX1LmQjainZbbcck/O7x/XDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOLwTJ82cNAml2g2cb6dK9D7rQ2YvjF3kp/sdo+s/8MW3JPM/Fs5NPkkeCBBQ/9q+
	 FxS2bu7EZzZAI11eUgpGvOGa6gmMczcKD/oTQVtGwzrwl9hjT3cDmQJppyBnEnoqNW
	 qgu3aidAUq/1NXFjtzADRKx9wVlgOR74rYaVGV5740SrS42MrdypX0UWqB15pgB/Dv
	 HJ0EwXKOyqS7iZRf6b2w7VBT0hBLtawEyQOfRqxuuymoQioTSdIbqM0ZCwiDFym1Yh
	 rWUkGWL5JuDyLwI8DSfVxZfAuZbEM9RHRYPzvexHuIasiYoz4YZVpDDyyYByNJnGYr
	 zf7fYG89TNmJA==
Date: Thu, 8 Jan 2026 10:28:18 +0100
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
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: airoha: npu: Add BA
 memory region
Message-ID: <aV94sru3D6xX39du@lore-desk>
References: <20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org>
 <20260107-airoha-ba-memory-region-v2-1-d8195fc66731@kernel.org>
 <20260108-shaggy-smart-okapi-efd3b7@quoll>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gSaQBVJTSebgApU5"
Content-Disposition: inline
In-Reply-To: <20260108-shaggy-smart-okapi-efd3b7@quoll>


--gSaQBVJTSebgApU5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jan 07, 2026 at 09:29:34AM +0100, Lorenzo Bianconi wrote:
> > Introduce Block Ack memory region used by NPU MT7996 (Eagle) offloading.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  .../devicetree/bindings/net/airoha,en7581-npu.yaml   | 20 ++++++++++--=
--------
> >  1 file changed, 10 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > index 59c57f58116b568092446e6cfb7b6bd3f4f47b82..42bc0f2a42a91236c858241=
ca76aa0b0ddac8d54 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > @@ -42,14 +42,13 @@ properties:
> >        - description: wlan irq line5
> > =20
> >    memory-region:
> > -    oneOf:
> > -      - items:
> > -          - description: NPU firmware binary region
> > -      - items:
> > -          - description: NPU firmware binary region
> > -          - description: NPU wlan offload RX buffers region
> > -          - description: NPU wlan offload TX buffers region
> > -          - description: NPU wlan offload TX packet identifiers region
> > +    items:
> > +      - description: NPU firmware binary region
> > +      - description: NPU wlan offload RX buffers region
> > +      - description: NPU wlan offload TX buffers region
> > +      - description: NPU wlan offload TX packet identifiers region
> > +      - description: NPU wlan Block Ack buffers region
> > +    minItems: 1
> > =20
> >    memory-region-names:
>=20
> missing minItems here.

ack, I will fix it.

Regards,
Lorenzo

>=20
> Best regards,
> Krzysztof
>=20

--gSaQBVJTSebgApU5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaV94sgAKCRA6cBh0uS2t
rIlVAQCZgQxfdfODxTpxJs9Ji5KYlAl4J4HPbwd9W6YBJbAT6wEA7S2y5npM/cw/
AL+VbyT0J3hgG0gmMffWbDag5gofHwg=
=c8nu
-----END PGP SIGNATURE-----

--gSaQBVJTSebgApU5--

