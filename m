Return-Path: <netdev+bounces-186426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0CA9F13E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D143A5A16EE
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D34326A0A0;
	Mon, 28 Apr 2025 12:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ADF266B67;
	Mon, 28 Apr 2025 12:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844291; cv=none; b=svVmoj4izGUr+sQ0CxUz0yIhx0qFXGOn/ktpzOM9WxQwaIb6VMEgUEbCqw/klfKcbXrUMDS4msrOjENlWSqNHpQvllZzbLTGHz1zb8YfRAMxuMKZq0i0q2Ve4vnwKnZR6t2OtS8gYEttoIdLZpN1uWHHlxz5ZS/qKmMaVZBzTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844291; c=relaxed/simple;
	bh=69u4x2iVX3CML3z65mNSFOpfvvJMY1UtVIYXajlF58c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSinGpThjptCgUMGjc9VGvf2q3u/HgMHfY6kkTXIQbnX7GtN7qwcxCQpeh71bT2rGqsIDnJRMFnqAGFw9C/h8Ce8PHkIr4MxpZhzGMWKVyFfiynVWkMP5Pe35pvtWTfBo3jrUM1OB5KWsK7ugbogz9dB6btQmdp1ISFYAFzXQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4285E1516;
	Mon, 28 Apr 2025 05:44:41 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B9463F66E;
	Mon, 28 Apr 2025 05:44:45 -0700 (PDT)
Date: Mon, 28 Apr 2025 13:44:35 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Yixun Lan <dlan@gentoo.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Corentin Labbe <clabbe.montjoie@gmail.com>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: sram: sunxi-sram: Add A523
 compatible
Message-ID: <20250428134435.76e19d29@donnerap.manchester.arm.com>
In-Reply-To: <20250428122156-GYA56330@gentoo>
References: <20250424-01-sun55i-emac0-v2-0-833f04d23e1d@gentoo.org>
	<20250424-01-sun55i-emac0-v2-1-833f04d23e1d@gentoo.org>
	<20250428-vegan-stoic-flamingo-1d1a2a@kuoka>
	<20250428122156-GYA56330@gentoo>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Apr 2025 12:21:56 +0000
Yixun Lan <dlan@gentoo.org> wrote:

> Hi Krzysztof,
>=20
> On 09:21 Mon 28 Apr     , Krzysztof Kozlowski wrote:
> > On Thu, Apr 24, 2025 at 06:08:39PM GMT, Yixun Lan wrote: =20
> > > The Allwinner A523 family of SoCs have their "system control" registe=
rs
> > > compatible to the A64 SoC, so add the new SoC specific compatible str=
ing.
> > >=20
> > > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > > Signed-off-by: Yixun Lan <dlan@gentoo.org>
> > > ---
> > >  .../devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml=
     | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a=
10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,s=
un4i-a10-system-control.yaml
> > > index a7236f7db4ec34d44c4e2268f76281ef8ed83189..e7f7cf72719ea884d48ff=
f69620467ff2834913b 100644
> > > --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-syst=
em-control.yaml
> > > +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-syst=
em-control.yaml
> > > @@ -50,6 +50,7 @@ properties:
> > >            - enum:
> > >                - allwinner,sun50i-a100-system-control
> > >                - allwinner,sun50i-h6-system-control
> > > +              - allwinner,sun55i-a523-system-control
> > >            - const: allwinner,sun50i-a64-system-control =20
> >=20
> > No update for the children (sram)?
> >  =20
> No, I don't think there is sub node for sram
> From address map of A527, there is total 4KB size space of
> this section which unlikely has sram available.

That's something else, though. This system controller here *also* contains
a register to switch access to SRAM blocks between the CPU and the devices.
The actual SRAM blocks are somewhere else (hence the empty ranges;
property), check the H616 for instance:
	syscon: syscon@3000000 {
		compatible =3D "allwinner,sun50i-h616-system-control";
		reg =3D <0x03000000 0x1000>;
		#address-cells =3D <1>;
		#size-cells =3D <1>;
		ranges;

		sram_c: sram@28000 {
			compatible =3D "mmio-sram";
			reg =3D <0x00028000 0x30000>;

Krzysztof, we haven't worked out the SRAM regions yet, we typically add
them only when we need them. I think the display engine is a prominent
user, and support for that is quite a bit out at the moment.

=46rom a compatibility standpoint it should be fine to leave this empty for
now, if I am not mistaken?

Cheers,
Andre

> but I do see some BROM/SRAM space from 0x0000 0000 - 0x0006 3FFF ..
> (which should not be relavant to this patch series..)
>=20


