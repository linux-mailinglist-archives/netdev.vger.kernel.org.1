Return-Path: <netdev+bounces-110018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C664E92AAFD
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FAF283376
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6987414F9C7;
	Mon,  8 Jul 2024 21:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lsw4pn/m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5B12E75;
	Mon,  8 Jul 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473391; cv=none; b=BBTPx53NGJ9aNcytE7SE1oWhmInQlaLFfVE6E0WrD0uFU/airzePznZO3f8smNfAA96q1LJQkTuBXRi8tVR3rHdgV9VpdYUwcxEztHYrTmcGcdDgqJkfqb33C4ZRRt7ALKsQMMrYuaYnXZW++jNDOYL1gseVtVzOFVjF+xeDrVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473391; c=relaxed/simple;
	bh=MiCSvIEK0l/TjhKUxrz4JOVrP2CSGLGatDFwJW1Tdc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVtrnKwDpv1Dg/o9GAbCFhmbo87Uxjx/SJuo3ZiV6a81rl46+mcym4JPRL5idUVHdsdt6rtEWnVO9NcddCH9q6ZbGXvmO/AucPI0SIOA3oiFhuG7h2DqiU0rcE5ktrFlcv44tAiJ/XTL6d+Bv3+PcU7fVP5OoFkSvNohQNzAf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lsw4pn/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5C2C116B1;
	Mon,  8 Jul 2024 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720473390;
	bh=MiCSvIEK0l/TjhKUxrz4JOVrP2CSGLGatDFwJW1Tdc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lsw4pn/mmsF/guRcIjwA+5dZ0MJNt/aIikyJDaj99W6AZaGXGsFaCZ/z4+Vqx5pFO
	 kbf0N0hKKfz6s7//7iIDFzHfOpyaNS3e83HJ0fe8ufpKW4hjgrcRxDLTobrWfDsmi2
	 b0GUHYhBNKMUzU1MmTUM6MLYF8r3G6LRqhRUZKddj9wd/h4F0HdVq0/IDIIWf+zQ5R
	 SZ9FZ+GcWyEeb9LTZu1ZZvyP+vwD0oZuzrP4RpGHDSIQwnCx2K26MFQC+ViaUZACv1
	 vE13oqY+8lVEUT3Ldwe0yuBIAqtp5siQ+90gvFArXbdGH6/w+zdJHih9HAieeNLcmD
	 z2qtwg/qNjf6A==
Date: Mon, 8 Jul 2024 23:16:27 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, netdev@vger.kernel.org, nbd@nbd.name,
	lorenzo.bianconi83@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	conor@kernel.org, linux-arm-kernel@lists.infradead.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com, arnd@arndb.de, horms@kernel.org
Subject: Re: [PATCH v5 net-next 1/2] dt-bindings: net: airoha: Add EN7581
 ethernet controller
Message-ID: <ZoxXK-uGsX_9_Fn4@lore-desk>
References: <cover.1720079772.git.lorenzo@kernel.org>
 <48dde2595c6ff497a846183b117ac9704537b78c.1720079772.git.lorenzo@kernel.org>
 <20240708163708.GA3371750-robh@kernel.org>
 <Zowb18jXTOw5L2aT@lore-desk>
 <CAL_JsqJPe1=K7VimSWz+AH2h4fu_2WEud_rUw1dV=SE7pY3C6w@mail.gmail.com>
 <8f8a1ee1-8c6c-48d6-a794-286464c38712@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Cu2L8LuMZ/p8V+GH"
Content-Disposition: inline
In-Reply-To: <8f8a1ee1-8c6c-48d6-a794-286464c38712@lunn.ch>


--Cu2L8LuMZ/p8V+GH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > > eth0: ethernet@1fb50000 {
> > >         compatible =3D "airoha,en7581-eth";
> > >         reg =3D <0 0x1fb50000 0 0x2600>,
> > >               <0 0x1fb54000 0 0x2000>,
> > >               <0 0x1fb56000 0 0x2000>;
> > >         reg-names =3D "fe", "qdma0", "qdma1";
> > >
> > >         resets =3D <&scuclk EN7581_FE_RST>,
> > >                  <&scuclk EN7581_FE_PDMA_RST>,
> > >                  <&scuclk EN7581_FE_QDMA_RST>,
> > >                  <&scuclk EN7581_XSI_MAC_RST>,
> > >                  <&scuclk EN7581_DUAL_HSI0_MAC_RST>,
> > >                  <&scuclk EN7581_DUAL_HSI1_MAC_RST>,
> > >                  <&scuclk EN7581_HSI_MAC_RST>,
> > >                  <&scuclk EN7581_XFP_MAC_RST>;
> > >         reset-names =3D "fe", "pdma", "qdma", "xsi-mac",
> > >                       "hsi0-mac", "hsi1-mac", "hsi-mac",
> > >                       "xfp-mac";
> > >
> > >         interrupts =3D <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
> > >                      <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> > >
> > >         status =3D "disabled";
> > >
> > >         #address-cells =3D <1>;
> > >         #size-cells =3D <0>;
> > >
> > >         gdm1: mac@1 {
> > >                 compatible =3D "airoha,eth-mac";
> > >                 reg =3D <1>;
> > >                 phy-mode =3D "internal";
> > >                 status =3D "disabled";
> > >
> > >                 fixed-link {
> > >                         speed =3D <1000>;
> > >                         full-duplex;
> > >                         pause;
> > >                 };
> > >         };
> > > };
> > >
> > > I am using phy related binding for gdm1:mac@1 node.
>=20
> Hi Lorenzo

Hi Andrew,

>=20
> phy-mode is a MAC property, not a PHY property. Same for
> fixed-link. These are in ethernet-controller.yaml.

ack

>=20
> You sometimes have an network controller IP which has multiple MACs
> and some shared infrastructure. You would typically describe the
> shared infrastructure at the top level. The MACs are then listed as
> children, and they make use of ethernet-controller.yaml, and that is
> where all the network specific properties are placed. Is that what you
> are trying to do here?

yep, exactly. Here we have multiple mac nodes that represent the real
ethernet controllers (e.g. used as DSA cpu port). I will use the
ethernet-controller.yaml just for the mac childs.

Regards,
Lorenzo

>=20
>     Andrew

--Cu2L8LuMZ/p8V+GH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZoxXKgAKCRA6cBh0uS2t
rDwOAQCrVya7sfgRJqZGKdFPLB748PsT7YO1VxAuzpHbXbbveQD/Stiv17jgUWbv
jlIJtfQCPrAPQJ5j+1P+uhoEh/5bTAk=
=1oOg
-----END PGP SIGNATURE-----

--Cu2L8LuMZ/p8V+GH--

