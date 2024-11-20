Return-Path: <netdev+bounces-146540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8089D415C
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6530D281A89
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 17:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2B4158845;
	Wed, 20 Nov 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSFv0Y6h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5C15539A;
	Wed, 20 Nov 2024 17:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124802; cv=none; b=ixlhay8UuaRd6RnzeDHiE9r/69wdjEmaTvwJe2PZqNUWkbBUOSUQqvubabG0A2gmZ/NfEsvzwz88LLPELTme6nYLD5tWQVfeSwYAiaPFXVQCWjKQ9aXpRu3PlvSt7EPuGgbgIcjOqp77LLD4gC6SXa7NLZ3HWFY0O9/NBB7HHQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124802; c=relaxed/simple;
	bh=IWeGbqt/aP9Z+v83QQBIzJ9NOFn4vM22aA07hXlz+O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqEyKZSfhh7wFA4qE7MD/A2lKn1xO/S2hx7TmCj8kr07Xx4JMZzB62ZMMS6gjvg2XbDF0G14FGLfU+cvqp/tM0PPiiWMg5SsCbvvyJKd+Pp9ueilYFcTno5Lb34HmBo3TI4XkLL4uufEUD0gNHuMS3gzpQPuKHff9WQVBZlYIdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSFv0Y6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABC3C4CECD;
	Wed, 20 Nov 2024 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732124802;
	bh=IWeGbqt/aP9Z+v83QQBIzJ9NOFn4vM22aA07hXlz+O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSFv0Y6h9roeAEtyMm+CahvnA61YwGAfn2GL1NT6D5Dol5PpgWDvHpEbkANV3/JS/
	 ZbfUsCr+U68Z+/PZC7eKpcFv775sS6FOx/XsHpm/+39eIIV19kE0W8Luw+h4i73eT5
	 Lbne7PV83ScJaDjpPtFIi3t2SZtQaOWF22TFNOsrmE+FwH7nggerTsaXyU9DWRVg/s
	 yxA3ZQtGLdEkguak8xMiO3MDDI9zhMTPeXza9nWg50o965QZ9m6h9i2qA5HbSAuj+b
	 0kB/AmTtpUvV1jkUS6SwZignCm1uf/9pcsrV2hv8iuGx5R0bB2XxCUxDQsSDf51484
	 M7rNnaCLHdYhQ==
Date: Wed, 20 Nov 2024 17:46:36 +0000
From: Conor Dooley <conor@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Russell King <linux@armlinux.org.uk>, jacob.e.keller@intel.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v2 8/8] dt-bindings: net: sparx5: document RGMII
 MAC delays
Message-ID: <20241120-decrease-wired-f6f21af817ce@spud>
References: <20241113-sparx5-lan969x-switch-driver-4-v2-0-0db98ac096d1@microchip.com>
 <20241113-sparx5-lan969x-switch-driver-4-v2-8-0db98ac096d1@microchip.com>
 <20241114-liquefy-chasing-a85e284f14b9@spud>
 <20241118105025.hjtji5cnl75rcrb4@DEN-DL-M70577>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2zHSNTjBPABr97aC"
Content-Disposition: inline
In-Reply-To: <20241118105025.hjtji5cnl75rcrb4@DEN-DL-M70577>


--2zHSNTjBPABr97aC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 10:50:25AM +0000, Daniel Machon wrote:
> Hi Conor,
>=20
> > > The lan969x switch device supports two RGMII port interfaces that can=
 be
> > > configured for MAC level rx and tx delays.
> > >=20
> > > Document two new properties {rx,tx}-internal-delay-ps. Make them
> > > required properties, if the phy-mode is one of: rgmii, rgmii_id,
> > > rgmii-rxid or rgmii-txid. Also specify accepted values.
> > >=20
> > > Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> > > ---
> > >  .../bindings/net/microchip,sparx5-switch.yaml        | 20 ++++++++++=
++++++++++
> > >  1 file changed, 20 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-s=
witch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.=
yaml
> > > index dedfad526666..a3f2b70c5c77 100644
> > > --- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.y=
aml
> > > +++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.y=
aml
> > > @@ -129,6 +129,26 @@ properties:
> > >              minimum: 0
> > >              maximum: 383
> > > =20
> > > +        allOf:
> > > +          - if:
> > > +              properties:
> > > +                phy-mode:
> > > +                  contains:
> > > +                    enum:
> > > +                      - rgmii
> > > +                      - rgmii-rxid
> > > +                      - rgmii-txid
> > > +                      - rgmii-id
> > > +            then:
> > > +              properties:
> > > +                rx-internal-delay-ps:
> > > +                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> > > +                tx-internal-delay-ps:
> > > +                  enum: [0, 1000, 1700, 2000, 2500, 3000, 3300]
> >=20
> > Properties should be define at the top level and constrained in the
> > if/then parts. Please move the property definitions out, and just leave
> > the required: bit here.
> >=20
> > > +              required:
> > > +                - rx-internal-delay-ps
> > > +                - tx-internal-delay-ps
> >=20
> > You've got no else, so these properties are valid even for !rgmii?
> >=20
> > > +
> > >          required:
> > >            - reg
> > >            - phys
> >=20
> > Additionally, please move the conditional bits below the required
> > property list.
> >=20
> > Cheers,
> > Conor.
>=20
> I will be getting rid of the 'required' constraints in v3. What I hear
> you say, is that the two {rx,tx}-internal-delay-ps properties (incl.
> their enum values) should be moved out of the if/else and to the
> top-level - can you confirm this?

> Is specifying the values
> a property can take not considered a constraint?

Actually, in this case the property isn't even defined (per
ethernet-controller.yaml) if the phy-mode wasn't an rgmii one, so what
you had here was probably fine. Ordinarily, that's not the case, so you'd
have been setting constraints for only rgmii phy-modes and no
constraints at all for non-rgmii phy-modes.



--2zHSNTjBPABr97aC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZz4gfAAKCRB4tDGHoIJi
0u2lAQD4xPN6l1CFgILsMQlm4WvjtBORrt9dFeneTtKWr3k3AgD/e6O6OVSW6HTS
wF4lBPCGhNRpUc4Ab2cECyQ2ZBI8cgQ=
=fiLn
-----END PGP SIGNATURE-----

--2zHSNTjBPABr97aC--

