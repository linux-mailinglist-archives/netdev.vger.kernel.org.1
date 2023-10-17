Return-Path: <netdev+bounces-41746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F67CBCFC
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22D9B21049
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7649E381CB;
	Tue, 17 Oct 2023 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv8hN+5j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453B930D1D;
	Tue, 17 Oct 2023 08:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A87AC433C7;
	Tue, 17 Oct 2023 08:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697529620;
	bh=dDKPWob3NTMe7C9SlY1gR19DUsq4sN8SeXQP0UXWyaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tv8hN+5jlJ0ofhkcuyLjePs3+5j6h6eiQJYCA82U2nTd8vNgQEcUrhJ/e35LA22Ay
	 aiyYXEGCK+GDNB4BN7Gj/hK49XhXmB2ebQJITOd0Rz83VHTgynZlzTaQHy5KsHcgDd
	 dYO4dv1dcQXaiTYw23PgvEoCHMQWpGOmyd7o93nJn49CIkt98rgKnNxVHaW2ZBk+n6
	 reD/irVj5bxCHcmm0CDfxf25qKZgOgQ+gWBhSEMtaDdYik/RU73ytegEKWgbwxpBud
	 Bx4YmIESFh/B6BtaysceZjBDq054CwtYevuveEio/GfQV4lWIKe61g+XK4dIOd7ico
	 jTvlG8mLzdUaQ==
Date: Tue, 17 Oct 2023 09:00:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Ante Knezic <ante.knezic@helmholz.de>
Cc: andrew@lunn.ch, conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
	netdev@vger.kernel.org, olteanv@gmail.com, pabeni@redhat.com,
	robh+dt@kernel.org, woojung.huh@microchip.com
Subject: Re: [PATCH net-next 2/2] dt-bindings: net: microchip,ksz: document
 microchip,rmii-clk-internal
Message-ID: <20231017-generous-botanical-28436c5ba13a@spud>
References: <20231012-unicorn-rambling-55dc66b78f2f@spud>
 <20231016075349.18792-1-ante.knezic@helmholz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RTdQAc1dJT5nSWZw"
Content-Disposition: inline
In-Reply-To: <20231016075349.18792-1-ante.knezic@helmholz.de>


--RTdQAc1dJT5nSWZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 09:53:49AM +0200, Ante Knezic wrote:
> On Thu, 12 Oct 2023 16:18:09 +0100, Conor Dooley wrote:
> > On Thu, Oct 12, 2023 at 12:55:56PM +0200, Ante Knezic wrote:
> > > Add documentation for selecting reference rmii clock on KSZ88X3 devic=
es
> > >=20
> > > Signed-off-by: Ante Knezic <ante.knezic@helmholz.de>
> > > ---
> > >  .../devicetree/bindings/net/dsa/microchip,ksz.yaml    | 19 +++++++++=
++++++++++
> > >  1 file changed, 19 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.=
yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > index 41014f5c01c4..eaa347b04db1 100644
> > > --- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
> > > @@ -72,6 +72,25 @@ properties:
> > >    interrupts:
> > >      maxItems: 1
> > > =20
> > > +  microchip,rmii-clk-internal:
> > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > +    description:
> > > +      Set if the RMII reference clock is provided internally. Otherw=
ise
> > > +      reference clock should be provided externally.
> >=20
> > I regret not asking this on the previous iteration - how come you need a
> > custom property? In the externally provided case would there not be a
> > clocks property pointing to the RMII reference clock, that would be
> > absent when provided by the itnernal reference?

> In both cases (external and internal), the KSZ88X3 is actually providing =
the
> RMII reference clock.
> Difference is only will the clock be routed as external
> copper track (pin REFCLKO -> pin REFCLKI), or will it be routed internall=
y.

The switch always provides it's own external reference, wut? Why would
anyone actually bother doing this instead of just using the internal
reference?

> So, this should not affect the clock relation between the uC and the swit=
ch
> device?

> This property has no effect if KSZ88X3 is not providing the reference clo=
ck.

This appears to contradict with the above, unless I am misunderstanding
something.

> Maybe I should provide more info in the commit message of both patches as=
 well?

What I would have expected to see is that when the reference clock is
provided externally that there would be a clocks property in the DT
node, pointing at that external clock & when there was not, then
no property. Likely that ship has already said, as I don't see clocks
present in the current binding. How does the driver get the frequency of
the RMII reference clock when an external reference is provided?

--RTdQAc1dJT5nSWZw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZS4/DwAKCRB4tDGHoIJi
0rFQAP9m8VpRBlP7rWXT1ZHoFPq6+eLOQwYnPTJprqcCty2+fAEA1o0kvyUPI69W
wXbdny+DrsOyb/DSpvy1L3OvYkdJ/gg=
=xLsw
-----END PGP SIGNATURE-----

--RTdQAc1dJT5nSWZw--

