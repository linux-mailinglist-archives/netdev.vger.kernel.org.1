Return-Path: <netdev+bounces-199354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB252ADFE7D
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 09:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46FD18972B9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DEB2494F5;
	Thu, 19 Jun 2025 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ibtu6rhx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAA24889B
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317316; cv=none; b=kzzVIuNVbkQJXhDm/fA2aiXhLEfOVmItZ3MaevxwEDZLT2talvbw/ePAYBfDWSx2HKb5i47vbV+fiq8dSAY4S485d9mtL9m/EcXWhKc3sGJWroyrCkNjfvPpw3JTjkLdJExyPLcFmQFlMChTbPu+VhleSZn3DJOKLNrRoRazXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317316; c=relaxed/simple;
	bh=D1DwgAqZmnxOplufHqA6i8WfeSgxDtSaWAIcQaiVles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOB41AQzUJibdfHcIXWBWoXXuCiUeolnnm0vg2/7IFA1z93poGQZ3qHLu/ulUiZAsDrORmiFxiTe6Pu/PiBhGny7AaAT+Ny0FwdkoNI1Us3cEsejMzeFe2dyh+F0pPdLOkJRFu6S/EKUYg1RBCw+oCoszBBtBsDh53YY7gsb6b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ibtu6rhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAF0C4CEEA;
	Thu, 19 Jun 2025 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750317315;
	bh=D1DwgAqZmnxOplufHqA6i8WfeSgxDtSaWAIcQaiVles=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ibtu6rhxGmbpSKWTPfUH1/XbY7GRdQ8rxiUGWd+Gb57xX02+lP4VOAJsEJogF29KJ
	 rphv8a2wTnI6ORq/z//tcv2ttd7t4KShzvjIsM2a7IepYvVX0eiZQGwnIv6rTHmTiv
	 1JqreC7OBVInMWSYef7FhhBd9Qr6T6Api9V3rf6S4HYvQNF5VQQJaRxP1/jAaOGYfJ
	 U2YEfC6cgHqPmJ6dmsag1rjh1YcgrEEIXBqtOOailFKctgWkVS10YvkWoohsURT1Of
	 TgvMxoaBt3RarnJIOJtNGqcJyYBJ+7a2j7cPb+QVnvmVanypfsbxTnXWR5s4q6S8XJ
	 m9fbgVAmNczGw==
Date: Thu, 19 Jun 2025 09:15:13 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: airoha: Differentiate hwfd buffer size
 for QDMA0 and QDMA1
Message-ID: <aFO5Afg_s7ClEBfd@lore-desk>
References: <20250618-airoha-hw-num-desc-v3-0-18a6487cd75e@kernel.org>
 <20250618-airoha-hw-num-desc-v3-2-18a6487cd75e@kernel.org>
 <20250618163529.GS1699@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c7RPTkHoZWeVpev3"
Content-Disposition: inline
In-Reply-To: <20250618163529.GS1699@horms.kernel.org>


--c7RPTkHoZWeVpev3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 18, Simon Horman wrote:
> On Wed, Jun 18, 2025 at 09:48:05AM +0200, Lorenzo Bianconi wrote:
> > In oreder to reduce the required hwfd buffers queue size for QDMA1,
>=20
> nit: order
>=20
> > differentiate hwfd buffer size for QDMA0 and QDMA1 and use 2KB for QDMA0
> > and 1KB for QDMA1.
>=20
> I think this patch description could benefit from explaining the why.

ack, I will fix it in v4.

Regards,
Lorenzo

>=20
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> Code changes look good to me.
>=20
> ...

--c7RPTkHoZWeVpev3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaFO5AQAKCRA6cBh0uS2t
rIwBAP0RZ9PNUgbLCSYPqx4FhrZV1dpCiWEV5Lr9YWjupvgdswD9Fmkbo1+DKV4J
ctX+IDWkc3i4+9GPSn2QfWAqtbFJ4gQ=
=N1tC
-----END PGP SIGNATURE-----

--c7RPTkHoZWeVpev3--

