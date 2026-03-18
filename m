Return-Path: <netdev+bounces-269141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNVwIn/eumlScwIAu9opvQ
	(envelope-from <netdev+bounces-269141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:18:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC442C01A4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8500C30058E9
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6164E2D8768;
	Wed, 18 Mar 2026 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWSLGfkf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D891481DD;
	Wed, 18 Mar 2026 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854329; cv=none; b=OmNibWqv4/JJ5UCnXIu9//edzIWhKgNxJEsuasAaX8tjSqF24wV+XqC3DrHfEYbhhtoJT3r+qI8tEWkukEs/w83zBd4fG5jqG+fChUhJ6gRfO8eoHArG6zgWcKsJwr6jz4s9Pwqmj8XPe80yoWXFWBovb1toe1dXmggYFmnyxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854329; c=relaxed/simple;
	bh=IeS+fJBvanCUzNEq4cDDJvasRxfLqeM4K7W6+l7t124=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gzfzx+sjh+C8zLQhEIR8QwH5OF20j2MqBPRC62/+7OE/jmLOa+WYlZ4w2m4mqt489X/237E8j3A9KHvybz/a9sNBIsyxwNWKvEnh9tl5/DSetbG2XmXmbMY45DEzcXBPRRFx0Tf3DA7XJ42Y0tL3ZAb4Br/73M0WSvvKuGWhiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWSLGfkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB52C19421;
	Wed, 18 Mar 2026 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773854328;
	bh=IeS+fJBvanCUzNEq4cDDJvasRxfLqeM4K7W6+l7t124=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWSLGfkfn4kK9/Z3our/XVh29knLWUy+Y1AuC9cMf0xxYP8i+tUOgvUHkVCa77OHR
	 t2y6JaHao/ClOxz3qz4wLaBnVRYHbUXIdzsyInIvQTa9St8KJrHKbC1MiahHPefKnG
	 zYso9BJ0gY9RVNKgsRkJVjbR6wpiPXXUk5THD+snUDQu+wmO3EVoWFWN/Wxyx/aKwQ
	 91/1tfxboNZmF58QfIqpBQ5ZBWEj6fYta8aBQKVbZ/NpRy/nz19Mikf6kQEH6GkR37
	 N179wD55yjRH0J9wS2ShuoedxCqdJVzAqXMREvxxaOxs+bhmdz8UjijBKLpcDbdjNU
	 xyshD/EsbvAUw==
Date: Wed, 18 Mar 2026 17:18:42 +0000
From: Conor Dooley <conor@kernel.org>
To: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
Cc: Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
Message-ID: <20260318-visiting-tanning-7d1d6acff081@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
 <20260303-mosaic-debate-90cf8c8bbb33@spud>
 <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
 <20260305-reliant-parchment-0ff685a9c78e@spud>
 <7b62ace495084794336b19a9685d6b14ea3981a0.camel@microchip.com>
 <20260306-pointless-purr-210540d4dc64@spud>
 <207c7a47e0802dd4c34ba90f2532dc2e0c3f7f05.camel@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eZSKhplNaY5LqAw9"
Content-Disposition: inline
In-Reply-To: <207c7a47e0802dd4c34ba90f2532dc2e0c3f7f05.camel@microchip.com>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269141-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.939];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.1:email]
X-Rspamd-Queue-Id: 2CC442C01A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--eZSKhplNaY5LqAw9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Christian,

On Wed, Mar 18, 2026 at 03:19:20PM +0100, Jens Emil Schulz Ostergaard wrote:
> Hi Conor,
>=20
> On Fri, 2026-03-06 at 15:20 +0000, Conor Dooley wrote:
> > On Fri, Mar 06, 2026 at 04:08:01PM +0100, Jens Emil Schulz Ostergaard w=
rote:
> > > On Thu, 2026-03-05 at 18:31 +0000, Conor Dooley wrote:
> > > > On Thu, Mar 05, 2026 at 01:57:37PM +0100, Jens Emil Schulz Ostergaa=
rd wrote:
> > > > > On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> > > > > > On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > > > > > > +        properties:
> > > > > > > > +          microchip,led-drive-mode:
> > > > > > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > +            description: |
> > > > > > > > +              Set the LED drive mode for the copper PHY as=
sociated with
> > > > > > > > +              this port.
> > > > > > > > +
> > > > > > > > +                0 - LED1 and LED2 in open-drain mode
> > > > > > > > +                1 - LED1 in active drive mode (can be used=
 for single-LED
> > > > > > > > +                    configurations requiring active drive)
> > > > > > > > +                2 - Reserved
> > > > > > > > +                3 - LED1 and LED2 in active drive mode
> > > > > > > > +            minimum: 0
> > > > > > > > +            maximum: 3
> > > > > > >=20
> > > > > > > I doubt the DT Maintainers will accept that. This looks a lot=
 like a
> > > > > > > value you write into a register. How are active drive and ope=
n-drain
> > > > > > > described in other DT bindings? Is there something you can re=
use?
> > > > > >=20
> > > > > > I had a quick look and I didn't see anything really that stood =
out to me
> > > > > > that would be a drop-in replacement.
> > > > > > I also tried looking in the datasheet for more information on t=
hese
> > > > > > modes, but I couldn't see anything obvious. For example, there =
were zero
> > > > > > hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
> > > > > >=20
> > > > > > That said, yea you're right about DT maintainer feelings about =
it.
> > > > > > There's a couple things I could suggest, but I'd like to know a=
bout what
> > > > > > mode 1 means for LED2 first. If there's actually nothing simila=
r, what
> > > > > > about representing each led with a child node and having open-d=
rain be
> > > > > > the default with a property in the child for active-drive?
> > > > > >=20
> > > > > > >=20
> > > > > > > For 1, what happens to LED2? Not used at all?
> > > > >=20
> > > > > In mode 1 LED2 will be open-drain. This mode only makes sense if =
you have
> > > > > just 1 LED. With two LEDs mode 0 or mode 3 should be used.
> > > >=20
> > > > Could we then have child nodes for each led, and have a property in=
 each
> > > > that sets the mode to either open-drain or active-drive? Or am I ju=
st
> > > > inserting complexity by asking for that?
> > >=20
> > > I think it sounds sensible, I will add this.
> >=20
> >=20
> > You don't need a property for each, just make one mode the default (prob
> > open-drain given it's the 0 setting, but whatever is default out of
> > reset for the part) and have the property for the other mode. Just
> > some bool property like "microchip,active-drive" or whatever.
>=20
>=20
> Based on your feedback I went with this under port properties:
>=20
>           leds:
>             patternProperties:
>               '^led@[a-f0-9]+$':
>                 $ref: /schemas/leds/common.yaml#
>=20
>                 properties:
>                   reg:
>                     maxItems: 1
>=20
>                   microchip,active-drive:
>                     type: boolean
>                     description:
>                       Set the LED output to active drive mode. The default
>                       is open-drain.
>=20
>                 required:
>                   - reg
>=20
>                 unevaluatedProperties: false
>=20
> and then the example has
>=20
>           port@1 {
>             reg =3D <1>;
>             phy-mode =3D "gmii";
>             phy-handle =3D <&cuphy1>;
>=20
>             leds {
>               #address-cells =3D <1>;
>               #size-cells =3D <0>;
>=20
>               led@0 {
>                 reg =3D <0>;
>                 microchip,active-drive;
>               };
>=20
>               led@1 {
>                 reg =3D <1>;
>                 microchip,active-drive;
>               };
>             };
>           }
>=20
> However, this does not pass dt_binding_check because we pull in $ref: dsa=
-port.yaml,
> which pulls in ethernet-controller.yaml.
>=20
> I believe the 'unevaluatedProperties: false' on LED nodes in ethernet-con=
troller.yaml
> prevents downstream bindings from adding vendor-specific LED properties.
>=20
> Is the right move removing unevaluatedProperties: false from the LED node=
 in
> ethernet-controller.yaml, or is there a preferred way to extend per-port =
LEDs?

The addition looks recent enough, should probably ask Christian why it
was done this way and if removing it makes sense. Christian?

Cheers,
Conor.

--eZSKhplNaY5LqAw9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabrecgAKCRB4tDGHoIJi
0o+pAPkBaKtrIAIxdnz1AU1GiCiuQGAVbePpR95Zkz8XhLpJ9QD/UcBKmEed8ZVm
muqyDHXqmzoNoXKyY0PVlvNo4vCs1A0=
=0LE6
-----END PGP SIGNATURE-----

--eZSKhplNaY5LqAw9--

