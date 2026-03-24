Return-Path: <netdev+bounces-270979-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHlfKo5pwmlScwQAu9opvQ
	(envelope-from <netdev+bounces-270979-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052A430687E
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 11:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C007A3104D91
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 10:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32290370D66;
	Tue, 24 Mar 2026 10:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BB0UKNIZ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777CF3E2775;
	Tue, 24 Mar 2026 10:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774348347; cv=none; b=gStQhRdfoKkH0OndmvgFPQ/F0Z5aitiDJ7ni68JEe++wOsZzDQEXIhNKlJ/NA/95uCmhm/3p/gT6LQpdCN+XoUZqIs6MIRelVbS1SAna1brVBL4Bh3tIsEU8qibpXK2RoDBbdR8u/qpucFdIU3rTYMQBqoL7QpKrE5H/U8Td4jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774348347; c=relaxed/simple;
	bh=CQHCAdf8uGas0cg4BwmpR1JPY+A4fttrJqzJLDbVt2Q=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjOTekV7GuI8HCI2+witYKcEw1Qn712yCSGV26NuymcagyU9nQo5xHS6q4wwETJLdPUIvScyClKmppDb+hkBhOfWdXteNDEueRR15PxtDg2tU9C0VepvzCuwlPkWm1J0lPOF9bvx6p59NQr7lNIPtGRfU2WUyQNlaor8LVRebXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BB0UKNIZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1774348344; x=1805884344;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=CQHCAdf8uGas0cg4BwmpR1JPY+A4fttrJqzJLDbVt2Q=;
  b=BB0UKNIZtHA1XS+xxNDJJhAuMCl4BwYoEi5J9OMSkYz7ioi0HwpO6mYB
   MWADRB6hd/0B6MOUbqOGTXkTmbEY43vFjO+ZJ3cMb066D+XQAsIhgtgLG
   cu1ttU0ec4pBPVCbjFCnh+tN924x7scgv27soXQisUcsgYRr1mnruBLKX
   C3F6+KQ4kcLGfBWGNhSnVqa7bQmzxBGIeZtc/gAbMsnYFFA/8o/xWhukO
   5YnxeEeGC/RIdqh9hn2uma5gdGrpoqOd++czRdxcvz0g1TzBW8zilDi2u
   ts/ettvvSKgnrDvjgFqI0nAgRkyjq3e5juVRMBKpNRYdd92OcX6F9OQ1+
   g==;
X-CSE-ConnectionGUID: YrPlzgaYSq6M6LEpxvgZJQ==
X-CSE-MsgGUID: d4z2A1QwQwqOtTFvX9alyQ==
X-IronPort-AV: E=Sophos;i="6.23,138,1770620400"; 
   d="scan'208";a="62812046"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2026 03:32:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 24 Mar 2026 03:31:51 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 24 Mar 2026 03:31:48 -0700
Message-ID: <a0947e239b006cf7c2a3e64057bd2fcd6edb836e.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Christian Marangi <ansuelsmth@gmail.com>, Conor Dooley <conor@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Tue, 24 Mar 2026 11:31:47 +0100
In-Reply-To: <69bae055.050a0220.3719be.bf31@mx.google.com>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
	 <20260303-mosaic-debate-90cf8c8bbb33@spud>
	 <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
	 <20260305-reliant-parchment-0ff685a9c78e@spud>
	 <7b62ace495084794336b19a9685d6b14ea3981a0.camel@microchip.com>
	 <20260306-pointless-purr-210540d4dc64@spud>
	 <207c7a47e0802dd4c34ba90f2532dc2e0c3f7f05.camel@microchip.com>
	 <20260318-visiting-tanning-7d1d6acff081@spud>
	 <20260318-placidly-domain-3ea82d265517@spud>
	 <69bae055.050a0220.3719be.bf31@mx.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270979-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.1:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Queue-Id: 052A430687E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-03-18 at 18:26 +0100, Christian Marangi wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Wed, Mar 18, 2026 at 05:20:03PM +0000, Conor Dooley wrote:
> > On Wed, Mar 18, 2026 at 05:18:42PM +0000, Conor Dooley wrote:
> > > Christian,
> > >=20
> > > On Wed, Mar 18, 2026 at 03:19:20PM +0100, Jens Emil Schulz Ostergaard=
 wrote:
> > > > Hi Conor,
> > > >=20
> > > > On Fri, 2026-03-06 at 15:20 +0000, Conor Dooley wrote:
> > > > > On Fri, Mar 06, 2026 at 04:08:01PM +0100, Jens Emil Schulz Osterg=
aard wrote:
> > > > > > On Thu, 2026-03-05 at 18:31 +0000, Conor Dooley wrote:
> > > > > > > On Thu, Mar 05, 2026 at 01:57:37PM +0100, Jens Emil Schulz Os=
tergaard wrote:
> > > > > > > > On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> > > > > > > > > On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wro=
te:
> > > > > > > > > > > +        properties:
> > > > > > > > > > > +          microchip,led-drive-mode:
> > > > > > > > > > > +            $ref: /schemas/types.yaml#/definitions/u=
int32
> > > > > > > > > > > +            description: |
> > > > > > > > > > > +              Set the LED drive mode for the copper =
PHY associated with
> > > > > > > > > > > +              this port.
> > > > > > > > > > > +
> > > > > > > > > > > +                0 - LED1 and LED2 in open-drain mode
> > > > > > > > > > > +                1 - LED1 in active drive mode (can b=
e used for single-LED
> > > > > > > > > > > +                    configurations requiring active =
drive)
> > > > > > > > > > > +                2 - Reserved
> > > > > > > > > > > +                3 - LED1 and LED2 in active drive mo=
de
> > > > > > > > > > > +            minimum: 0
> > > > > > > > > > > +            maximum: 3
> > > > > > > > > >=20
> > > > > > > > > > I doubt the DT Maintainers will accept that. This looks=
 a lot like a
> > > > > > > > > > value you write into a register. How are active drive a=
nd open-drain
> > > > > > > > > > described in other DT bindings? Is there something you =
can reuse?
> > > > > > > > >=20
> > > > > > > > > I had a quick look and I didn't see anything really that =
stood out to me
> > > > > > > > > that would be a drop-in replacement.
> > > > > > > > > I also tried looking in the datasheet for more informatio=
n on these
> > > > > > > > > modes, but I couldn't see anything obvious. For example, =
there were zero
> > > > > > > > > hits for "drain" in either LAN9645xS or LAN9645xF datashe=
ets.
> > > > > > > > >=20
> > > > > > > > > That said, yea you're right about DT maintainer feelings =
about it.
> > > > > > > > > There's a couple things I could suggest, but I'd like to =
know about what
> > > > > > > > > mode 1 means for LED2 first. If there's actually nothing =
similar, what
> > > > > > > > > about representing each led with a child node and having =
open-drain be
> > > > > > > > > the default with a property in the child for active-drive=
?
> > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > For 1, what happens to LED2? Not used at all?
> > > > > > > >=20
> > > > > > > > In mode 1 LED2 will be open-drain. This mode only makes sen=
se if you have
> > > > > > > > just 1 LED. With two LEDs mode 0 or mode 3 should be used.
> > > > > > >=20
> > > > > > > Could we then have child nodes for each led, and have a prope=
rty in each
> > > > > > > that sets the mode to either open-drain or active-drive? Or a=
m I just
> > > > > > > inserting complexity by asking for that?
> > > > > >=20
> > > > > > I think it sounds sensible, I will add this.
> > > > >=20
> > > > >=20
> > > > > You don't need a property for each, just make one mode the defaul=
t (prob
> > > > > open-drain given it's the 0 setting, but whatever is default out =
of
> > > > > reset for the part) and have the property for the other mode. Jus=
t
> > > > > some bool property like "microchip,active-drive" or whatever.
> > > >=20
> > > >=20
> > > > Based on your feedback I went with this under port properties:
> > > >=20
> > > >           leds:
> > > >             patternProperties:
> > > >               '^led@[a-f0-9]+$':
> > > >                 $ref: /schemas/leds/common.yaml#
> > > >=20
> > > >                 properties:
> > > >                   reg:
> > > >                     maxItems: 1
> > > >=20
> > > >                   microchip,active-drive:
> > > >                     type: boolean
> > > >                     description:
> > > >                       Set the LED output to active drive mode. The =
default
> > > >                       is open-drain.
> > > >=20
> > > >                 required:
> > > >                   - reg
> > > >=20
> > > >                 unevaluatedProperties: false
> > > >=20
> > > > and then the example has
> > > >=20
> > > >           port@1 {
> > > >             reg =3D <1>;
> > > >             phy-mode =3D "gmii";
> > > >             phy-handle =3D <&cuphy1>;
> > > >=20
> > > >             leds {
> > > >               #address-cells =3D <1>;
> > > >               #size-cells =3D <0>;
> > > >=20
> > > >               led@0 {
> > > >                 reg =3D <0>;
> > > >                 microchip,active-drive;
> > > >               };
> > > >=20
> > > >               led@1 {
> > > >                 reg =3D <1>;
> > > >                 microchip,active-drive;
> > > >               };
> > > >             };
> > > >           }
> > > >=20
> > > > However, this does not pass dt_binding_check because we pull in $re=
f: dsa-port.yaml,
> > > > which pulls in ethernet-controller.yaml.
> > > >=20
> > > > I believe the 'unevaluatedProperties: false' on LED nodes in ethern=
et-controller.yaml
> > > > prevents downstream bindings from adding vendor-specific LED proper=
ties.
> > > >=20
> > > > Is the right move removing unevaluatedProperties: false from the LE=
D node in
> > > > ethernet-controller.yaml, or is there a preferred way to extend per=
-port LEDs?
> > >=20
> > > The addition looks recent enough, should probably ask Christian why i=
t
> > > was done this way and if removing it makes sense. Christian?
> > >=20
> >=20
> > Ah shit, I autopiloted into sending. Actually +CC Christian this time.
>=20
> Hi, give me some time to experiment... AFAIK with my limited info on DT,
>=20
> unevaluatedProperties permits to add vendor property as long as they are
> well defined. If the dt_binding_check is failing, then it's probably
> because unevaluatedProperties is finding that in the expected LED node
> there is extra stuff in the SCHEMA example.
>=20
> But give me some time to experiment with some other SCHEMA.
>=20
> --
>         Ansuel


Hi, I will just remove the LED handling from this series, and handle it in =
a
different series, once this is settled.

Thanks,
Emil

