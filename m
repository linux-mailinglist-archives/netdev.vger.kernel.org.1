Return-Path: <netdev+bounces-227341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806EFBACBC3
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 13:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398D13B1DB2
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 11:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF026A0E7;
	Tue, 30 Sep 2025 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbM1X5UC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEF723D288;
	Tue, 30 Sep 2025 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759233414; cv=none; b=ejmjrwIiCqTsJpipXStLEFED6W0MMljdTPexU81g+UJLKuS8s+CH71klc+EW18YX3qzNhheXBPyzzcXpRN85eVAJ5OUSKFZtxhSGDRhebEcujswPRsbKc0/Kdok37gm6gmvo7w2phx0UqwTUrr/2MgyHYxzEZOshCdNYC1DsfIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759233414; c=relaxed/simple;
	bh=rVEH3heWQ9CYRYUOy9sPRsybw/cgSFigHuULmvEsgIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeASQwMLR/A+85yXFbIfcakcjMjioPUplYy8SW86TVZSNWR59/oN3BDKbhOgQPF2Adcp2hdnoOr0+2FsLOjDlFvRvP6KMyBhp1ZQfBPcCKOMlvIY20gjoMT36Omw3Zx1c/wc9eZGIGLzE3poWghB2fiDdabyp/M6T9kxJLJps7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbM1X5UC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15489C4CEF0;
	Tue, 30 Sep 2025 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759233413;
	bh=rVEH3heWQ9CYRYUOy9sPRsybw/cgSFigHuULmvEsgIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbM1X5UCOwCMtc5gSaozPLdjbuYKjdj4qoWN8L9+ohY6oyfmeWyC+g6oE7BVMp/GP
	 0yVOGQMN6ZNUKmTFTRzV69wY8e+Uv1IvFQa5YfQQb35b0fpLS5xQ5brgtvVIAxIM/i
	 Lbg/BXoROC9RqSox211SoamyQcuRRDIcvkVXFX3JBXBJfax2/oziZD5WC4BrBk5cY/
	 8nl5DLyBetQegq1ls234yG+v3EYB2gjdBYlAXTMjIY6EcLU9DHokO5fNT7gb1ZNLl8
	 ZZzL3gumC7yjdoDcwwPEZiWMr7L2O4IaiNCrKAMbdLeKe/It5OauunNzdZLxjFYLPU
	 7HnexeEs0je5A==
Date: Tue, 30 Sep 2025 13:56:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v2 1/3] dt-bindings: net: airoha: npu: Add
 AN7583 support
Message-ID: <aNvFgkV-8YCnnfaP@lore-desk>
References: <20250927-airoha-npu-7583-v2-0-e12fac5cce1f@kernel.org>
 <20250927-airoha-npu-7583-v2-1-e12fac5cce1f@kernel.org>
 <157578d3-c06f-4621-b707-ca4208d18807@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GI8sOrmB41LyVA3t"
Content-Disposition: inline
In-Reply-To: <157578d3-c06f-4621-b707-ca4208d18807@redhat.com>


--GI8sOrmB41LyVA3t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 9/27/25 4:03 PM, Lorenzo Bianconi wrote:
> > Introduce AN7583 NPU support to Airoha EN7581 NPU device-tree bindings.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581-npu.ya=
ml b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > index c7644e6586d329d8ec2f0a0d8d8e4f4490429dcc..59c57f58116b568092446e6=
cfb7b6bd3f4f47b82 100644
> > --- a/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581-npu.yaml
> > @@ -18,6 +18,7 @@ properties:
> >    compatible:
> >      enum:
> >        - airoha,en7581-npu
> > +      - airoha,an7583-npu
> > =20
> >    reg:
> >      maxItems: 1
> >=20
>=20
> This needs ack from the DT maintainer and we are finalizing the net-next
> PR right now. Let's defer this series to the next cycle, thanks!
>=20
> Paolo
>=20

ack, fine. I will repost during next cycle.

Regards,
Lorenzo

--GI8sOrmB41LyVA3t
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNvFggAKCRA6cBh0uS2t
rGOXAQD9aWmnKC+UFDiJtMtXqtAOebHLNu9HuxT+1kz7pSHUVgD/bEjQtex8chJk
Le7FZ5a+eHigvNV2TMN3TurtWfqGbgc=
=u+lc
-----END PGP SIGNATURE-----

--GI8sOrmB41LyVA3t--

