Return-Path: <netdev+bounces-181287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D15A8448B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F084519E67F1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 13:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1432857DA;
	Thu, 10 Apr 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3zKMaKu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696D92853F3;
	Thu, 10 Apr 2025 13:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291091; cv=none; b=nzH5qiF1ykEzaW1gD18cOcrMKAug3kz5KE9TrcYzaeJglZVaoMLssEw3QYKhBA0WFu71Nuh+m6GISu/7+bXS/+pBks/pTfsnOjbdif38MxF7PgNSS2I8GHKqf+UgG9KdaG7HZERYqg5l6BTTwUyBr29Vmxu6o0MUVlB4yuT5GbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291091; c=relaxed/simple;
	bh=gx2DUG/jwsMiaaO0LRs0o3B6e5mCvWlXA/E8dDzVJpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pydUamUHHUa7FNJFUo3p4i061cI3vNcVsh6A27Ic/xiWe7MFNLQlWKZi61svQGhIeh6GdL4RBsmXupQuUpGbGdYzcxxMXACPUlb9G/YoY0+JbXvqWXoW+OvK/EoxJ+s8lA+mRa/cfCIKCMqR76zE2bCaXuswMwFbLFg43VfRSn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3zKMaKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A4FC4CEEA;
	Thu, 10 Apr 2025 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744291090;
	bh=gx2DUG/jwsMiaaO0LRs0o3B6e5mCvWlXA/E8dDzVJpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3zKMaKulC/cjqRu5cQOAQ2qTDh1GM7tQdMs+jKt96d+nA8BH5Mb6iNc3QIDyUhUr
	 HfsbS6gwVuY9QJteNBdLJnj6xYuUgi0XkoqQOOOOOsOiaoXgysTnhvzAoHTiKrHTL7
	 7o7aFah5/t+ndczLJODamuEH2Kp080fvmuobVjLXZ/+0gU2Gizf5lwqqiprCYyKLbQ
	 Ek5jMud1uadhbLanUrUnvdIfvzGpjc82Gnyl0xZTCsd3eOKH1KLp0DgGDYVmm7MUV2
	 TP4ArC310lJzN8WPi9UftgGpsfqomjHpkTJjYnFw7RGxpor0/9tZDTzlvZKhVI6EZb
	 bm4kru1memdUg==
Date: Thu, 10 Apr 2025 14:18:05 +0100
From: Conor Dooley <conor@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 02/14] dt-bindings: dpll: Add support for Microchip
 Azurite chip family
Message-ID: <20250410-puritan-flatbed-00bf339297c0@spud>
References: <20250409144250.206590-1-ivecera@redhat.com>
 <20250409144250.206590-3-ivecera@redhat.com>
 <20250410-skylark-of-silent-symmetry-afdec9@shite>
 <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i2F+52kfRwOYiwup"
Content-Disposition: inline
In-Reply-To: <1a78fc71-fcf6-446e-9ada-c14420f9c5fe@redhat.com>


--i2F+52kfRwOYiwup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 09:45:47AM +0200, Ivan Vecera wrote:
>=20
>=20
> On 10. 04. 25 9:06 dop., Krzysztof Kozlowski wrote:
> > On Wed, Apr 09, 2025 at 04:42:38PM GMT, Ivan Vecera wrote:
> > > Add DT bindings for Microchip Azurite DPLL chip family. These chips
> > > provides 2 independent DPLL channels, up to 10 differential or
> > > single-ended inputs and up to 20 differential or 20 single-ended outp=
uts.
> > > It can be connected via I2C or SPI busses.
> > >=20
> > > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > > ---
> > >   .../bindings/dpll/microchip,zl3073x-i2c.yaml  | 74 ++++++++++++++++=
++
> > >   .../bindings/dpll/microchip,zl3073x-spi.yaml  | 77 ++++++++++++++++=
+++
> >=20
> > No, you do not get two files. No such bindings were accepted since some
> > years.
> >=20
> > >   2 files changed, 151 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/dpll/microchip=
,zl3073x-i2c.yaml
> > >   create mode 100644 Documentation/devicetree/bindings/dpll/microchip=
,zl3073x-spi.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/dpll/microchip,zl3073x=
-i2c.yaml b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.ya=
ml
> > > new file mode 100644
> > > index 0000000000000..d9280988f9eb7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dpll/microchip,zl3073x-i2c.ya=
ml
> > > @@ -0,0 +1,74 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/dpll/microchip,zl3073x-i2c.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: I2C-attached Microchip Azurite DPLL device
> > > +
> > > +maintainers:
> > > +  - Ivan Vecera <ivecera@redhat.com>
> > > +
> > > +description:
> > > +  Microchip Azurite DPLL (ZL3073x) is a family of DPLL devices that
> > > +  provides 2 independent DPLL channels, up to 10 differential or
> > > +  single-ended inputs and up to 20 differential or 20 single-ended o=
utputs.
> > > +  It can be connected via multiple busses, one of them being I2C.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - microchip,zl3073x-i2c
> >=20
> > I already said: you have one compatible, not two. One.
>=20
> Ah, you mean something like:
> iio/accel/adi,adxl313.yaml
>=20
> Do you?
>=20
> > Also, still wildcard, so still a no.
>=20
> This is not wildcard, Microchip uses this to designate DPLL devices with =
the
> same characteristics.

That's the very definition of a wildcard, no? The x is matching against
several different devices. There's like 14 different parts matching
zl3073x, with varying numbers of outputs and channels. One compatible
for all of that hardly seems suitable.

>=20
> But I can use microchip,azurite, is it more appropriate?

No, I think that is worse actually.

--i2F+52kfRwOYiwup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ/fE/gAKCRB4tDGHoIJi
0sTZAQCBzUZkvY+I5FbJkjbLob1otnvEelxWwmfySDNLPHKyQAD/RmLcKN7+q+vW
T5Aq2D7NiMygDDHTogNi3h0xhh3rCgk=
=Ga7z
-----END PGP SIGNATURE-----

--i2F+52kfRwOYiwup--

