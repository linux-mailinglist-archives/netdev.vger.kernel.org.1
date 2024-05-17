Return-Path: <netdev+bounces-97001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 316338C89D7
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 18:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E050C28145E
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 16:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89512F5B9;
	Fri, 17 May 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFoIR7KR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C7E12F590;
	Fri, 17 May 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962402; cv=none; b=qNuj13kod1exsCEYF5d37+iyDPBV//Zb6aA8B4JNCffAgLNIsc6fUWvqPKDa0Ezc3I36QfQlyhcuvx62dkWzhylIe6zhBq4PW7Uz15tSS5jEcUfQWV2fYswsAYkGNz2queDtNVAKALT61hbH4bpgQmJmJoxDJx0cvEGjmsirjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962402; c=relaxed/simple;
	bh=ICSuALralONr7kJQzKhG274c4+ph6F3+25Wuza/oO2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTCCg9Ry6qMjd3rL1wHpu//KBc6NJetPU7RQEvSlq1jmr4jlEwKVcyn5Gn2cC7z4mtuZrxlcIX4bKJpR4GGPsoTD8diFquIT4WyZ4yhWyo1gMQwtB7ptRCkE3zZYKLgVupM96YE/c9LWu3HUIySBoX4qNDpHVOxliM6lN97bHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFoIR7KR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAFCC2BD10;
	Fri, 17 May 2024 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715962402;
	bh=ICSuALralONr7kJQzKhG274c4+ph6F3+25Wuza/oO2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFoIR7KRkbmjQKWHqKULt+xaWzADVuwz1jnopsqvHT1edGXvl9yEUKGCqNiKOCV1O
	 AHdWSUm2XJCYFRYUhb3J/pJIfHMn5okiiDgT+iqaxmd4nurKGZMU7rkMUP1taqQQpk
	 MeR1OHDEVvc/M3idQsIdi/sxln/cdiUbqIe2yP1Q7JP6QSzSUDaPUu4nlAQGfFNkE0
	 eCfhRiTaO4mhckirHCx8WLeBexMYjbgeozI74VDf5jPUewRgHaH2LsdtSqUN8ELhyw
	 xS9XvNfH7BfFahA2mgHkxWAOY31hJ5Hmlh64sNbEjPTaM7aLhtY4H9j0XOuXKNjpf7
	 Cq7UcAuUa7mSQ==
Date: Fri, 17 May 2024 17:13:18 +0100
From: Conor Dooley <conor@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Leon M. Busch-George" <leon@georgemail.de>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	netdev@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/2] net: add option to ignore 'local-mac-address'
 property
Message-ID: <20240517-unscrew-handsfree-c0fe02c67b3d@spud>
References: <20240517123909.680686-1-leon@georgemail.de>
 <7471f037-f396-4924-8c8d-e704507de361@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="syXz7LoxvHfxfo9F"
Content-Disposition: inline
In-Reply-To: <7471f037-f396-4924-8c8d-e704507de361@lunn.ch>


--syXz7LoxvHfxfo9F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 04:07:08PM +0200, Andrew Lunn wrote:
> On Fri, May 17, 2024 at 02:39:07PM +0200, Leon M. Busch-George wrote:
> > From: "Leon M. Busch-George" <leon@georgemail.eu>
> >=20
> > Here is the definition of a mac that looks like its address would be
> > loaded from nvmem:
> >=20
> >   mac@0 {
> >     compatible =3D "mediatek,eth-mac";
> >     reg =3D <0>;
> >     phy-mode =3D "2500base-x";
> >     phy-handle =3D <&rtl8221b_phy>;
> >=20
> >     nvmem-cell-names =3D "mac-address";
> >     nvmem-cells =3D <&macaddr_bdinfo_de00 1>; /* this is ignored */
> >   };
> >=20
> > Because the boot program inserts a 'local-mac-address', which is prefer=
red
> > over other detection methods, the definition using nvmem is ignored.
> > By itself, that is only a mild annoyance when dealing with device trees.
> > After all, the 'local-mac-address' property exists primarily to pass MAC
> > addresses to the kernel.
> >=20
> > But it is also possible for this address to be randomly generated (on e=
ach
> > boot), which turns an annoyance into a hindrance. In such a case, it is=
 no
> > longer possible to set the correct address from the device tree. This
> > behaviour has been observed on two types of MT7981B devices from differ=
ent
> > vendors (Cudy M3000, Yuncore AX835).
> >=20
> > Restore the ability to set addresses through the device tree by adding =
an
> > option to ignore the 'local-mac-address' property.
>=20
> I'm not convinced you are fixing the right thing here.
>=20
> To me, this is the bootloader which is broken. You should be fixing
> the bootloader.

IMO this is firmly in the "setting software policy" category of
properties and is therefore not really welcome.
If we can patch the DT provided to the kernel with this property, how
come the bootloader cannot be changed to stop patching the random MAC
address in the first place?

> One concession might be, does the bootloader correctly generate a
> random MAC address? i.e. does it have the locally administered bit
> set? If that bit is set, and there are other sources of a MAC address,
> then it seems worth while checking them to see if there is a better
> MAC address available, which as global scope.




--syXz7LoxvHfxfo9F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkeCHgAKCRB4tDGHoIJi
0nHIAP9WXb0rgLLootsDiFqRA/r9hX7kOLemZyOd1p/31X5MLAEA2r1bG9NuPoPt
41X9+HADkEF2fV3CIzvt/MmkmleYYAA=
=/BwA
-----END PGP SIGNATURE-----

--syXz7LoxvHfxfo9F--

