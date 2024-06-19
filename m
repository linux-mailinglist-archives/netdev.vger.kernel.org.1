Return-Path: <netdev+bounces-104745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66C90E3DB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 08:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE18284670
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3D06F315;
	Wed, 19 Jun 2024 06:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4g0GHT3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2FB6F2EF;
	Wed, 19 Jun 2024 06:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718780287; cv=none; b=BcveU60WEU+orR84zjmLC9IxM3lPWKm0NTNYAOyHWSMigID9+dcM1n3JyJ3mPrnaGmHgPAfxKK4JzN9T+IanjwqKmxgadvGV5sv0PkD9JgK0giqWABVlX7gsJkdczN7B81bU2DdOD0u97rxl2pgP/MCg177tKmUstJ2Ns2Zm12o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718780287; c=relaxed/simple;
	bh=cW5Ge63fweS/szTsICcadN5NAWgmIOD+EQ6sg9xkUmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+gqQ4qn3IM0D5/abzwLYq88SuxCzp8e3exf8p/2sHeK41H/3gcWDTkJeQYJdeQc2MSgN+h85IYRLbAr2vvYMuDNQpLFXt9ZDoHmOdZzpWgRUKOfwqB2yeRmkgEEVIuTcTl+O/36Zrcf3xrBGmVntmu1UCPgmpAWwu4AAasYBg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4g0GHT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D406C32786;
	Wed, 19 Jun 2024 06:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718780286;
	bh=cW5Ge63fweS/szTsICcadN5NAWgmIOD+EQ6sg9xkUmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S4g0GHT3ZsPHYWl6TJwuiw7nJbxsDZqNYo8UgKbQgnQ/Jo87Jrir/RrXx17vvyey/
	 fTEF3D0jvoZP6gjBGVpzVmLXJdN35fzEZzMp/GvTjfAEL36PV0Wa+AKZw80mhN1a35
	 9CA1CYe1rpLcVejOA/s9nEaLzG9rbcK0MhUa/py9m6yrOgzF/9j+ODhDRMN8IdTvJL
	 NoWqY9BSrFnJt8WVB1UM3iUHAuTRYveZOVR0GdlLsyBtS8GA0NvnqYa3yz+Ol3o++O
	 VN6tv9U1hiFqIdQiVgfv0Uly+nrk527mr14OtPx4d8p6Sb+kuX2BS5bIh9uZ6LHn4q
	 V+xUOc6cfWoPw==
Date: Wed, 19 Jun 2024 08:58:02 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	catalin.marinas@arm.com, will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, linux-clk@vger.kernel.org,
	rkannoth@marvell.com, sgoutham@marvell.com, andrew@lunn.ch
Subject: Re: [PATCH v2 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <ZnKBegrGA6OhIiJF@lore-desk>
References: <cover.1718696209.git.lorenzo@kernel.org>
 <ae8ac05a56f479286bc748fb930c5643a2fbde10.1718696209.git.lorenzo@kernel.org>
 <20240618-subpar-absentee-c3a43a1a9f5e@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2kmjxWM4m0yk+HFF"
Content-Disposition: inline
In-Reply-To: <20240618-subpar-absentee-c3a43a1a9f5e@spud>


--2kmjxWM4m0yk+HFF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, Jun 18, 2024 at 09:49:02AM +0200, Lorenzo Bianconi wrote:
> > Introduce device-tree binding documentation for Airoha EN7581 ethernet
> > mac controller.
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > ---
> > This patch is based on the following one not applied yet on clk tree:
> > dt-bindings: clock: airoha: Add reset support to EN7581 clock binding
> > https://patchwork.kernel.org/project/linux-clk/patch/ac557b6f4029cb3428=
d4c0ed1582d0c602481fb6.1718282056.git.lorenzo@kernel.org/
> > ---
> >  .../bindings/net/airoha,en7581.yaml           | 106 ++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/airoha,en7581=
=2Eyaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/airoha,en7581.yaml b=
/Documentation/devicetree/bindings/net/airoha,en7581.yaml
> > new file mode 100644
> > index 000000000000..09e7b5eed3ae
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/airoha,en7581.yaml
>=20
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - airoha,en7581-eth
>=20
> Actually, one other thing - filename matching compatible please.
>=20

ack, I will fix in v3.

Rregards,
Lorenzo

--2kmjxWM4m0yk+HFF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZnKBegAKCRA6cBh0uS2t
rDkzAQCSUyqP7whqaj7oEagB3ButpOBwscMnJyiOHEWp+cB8ggD/XunfV68Xzv2N
V66QJyDhZ4NOVLG1liVApntm0FihUAo=
=5J4A
-----END PGP SIGNATURE-----

--2kmjxWM4m0yk+HFF--

