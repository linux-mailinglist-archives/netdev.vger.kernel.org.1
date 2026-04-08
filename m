Return-Path: <netdev+bounces-276575-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OvJEnFt1mkQFQgAu9opvQ
	(envelope-from <netdev+bounces-276575-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:00:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF613BDED6
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 17:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FAF23007365
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8AB3D3D03;
	Wed,  8 Apr 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="deW+ngqD"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460235DD1C;
	Wed,  8 Apr 2026 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775660398; cv=none; b=u78ea/a6rWDhTl6xRSHlxs/T/zqzVME4qudVwF0Zcp+HiK9QDBmlcVPqbvL6Aali07oGfk9nMSQUUfYbDcLsdlEgWKBShQ/6hifvjf+Q9zkcFrwkUyxWBLKYPc91heASpon19yFGxJyCy9xyRHn7EQBtLX6HoMfRLMXATwpkzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775660398; c=relaxed/simple;
	bh=ERVI9ZJyXyeSYfdT18Yg0S3+mLpg49FF8RNrnPyayK4=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BulQwav0NL7VR73huv0qkg+n7IPWv/d1AvlpyZvDW203nV4PolnNQYb+3qFqTTBieQQ6VKz9VTedJRPtv7ih18ut1XFDfwSn6xuB6bZjEJ2WUt/0sm/nkUV0r86YqAsJp9uMnWAYaqheSoo7ZWtaj/oBdvpLv6OKq/8SYwgEVfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=deW+ngqD; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1775660397; x=1807196397;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ERVI9ZJyXyeSYfdT18Yg0S3+mLpg49FF8RNrnPyayK4=;
  b=deW+ngqDqJQyTuPcXErU7GbktKNzLMtZO2A7IPFjE5fBbfqFtZdUV0Ws
   L0iYIkKJ2mCcXt3OeRf/1T5PhVfzf7dsKo5AxThU82mry+5pVgJPjNGvD
   ehzrUSPbj9CU0/kA89GkFYi5XztOktshUxMomZMBz+8Iu8FE5n2+yhXJg
   8xlKnV6gRQgeFEFT1wpg5DbvI3eOkvXo1N23orpCZc5AwpiadGRwbKRWM
   UnyhUxsmMvPv4Q7zBuGQyulNVZHjlUQIepvuCbPTFaYRzq72pp4XhYqlt
   2iUqD/22Vix065UGTO25rd+T4s6znAaWEq7IQdUkqPfrJhUD6rEPcgdgi
   A==;
X-CSE-ConnectionGUID: BQaSCvvjSASRO35GC95mcQ==
X-CSE-MsgGUID: k7AYJO6tTFKgcNT/VRb6Rw==
X-IronPort-AV: E=Sophos;i="6.23,167,1770620400"; 
   d="scan'208";a="63706481"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2026 07:59:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 8 Apr 2026 07:59:25 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 8 Apr 2026 07:59:22 -0700
Message-ID: <45b320d12e61bd3583301759060ec05b37c20a3c.camel@microchip.com>
Subject: Re: [PATCH net-next v2 2/9] dt-bindings: net: lan9645x: add
 LAN9645X switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Rob Herring <robh@kernel.org>
CC: <UNGLinuxDriver@microchip.com>, Andrew Lunn <andrew@lunn.ch>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Woojung
 Huh" <woojung.huh@microchip.com>, Russell King <linux@armlinux.org.uk>,
	"Steen Hegelund" <Steen.Hegelund@microchip.com>, Daniel Machon
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 8 Apr 2026 16:59:22 +0200
In-Reply-To: <20260407171854.GA2970003-robh@kernel.org>
References: <20260324-dsa_lan9645x_switch_driver_base-v2-0-f7504e3b0681@microchip.com>
	 <20260324-dsa_lan9645x_switch_driver_base-v2-2-f7504e3b0681@microchip.com>
	 <20260407171854.GA2970003-robh@kernel.org>
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
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-276575-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.3:email,0.0.0.2:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.1:email,microchip.com:dkim,microchip.com:email,microchip.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.7:email]
X-Rspamd-Queue-Id: 9EF613BDED6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 12:18 -0500, Rob Herring wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content is safe
>=20
> On Tue, Mar 24, 2026 at 11:46:45AM +0100, Jens Emil Schulz =C3=98stergaar=
d wrote:
> > Add bindings for LAN9645X switch. We use a fallback compatible for the
> > smallest SKU microchip,lan96455s-switch.
> >=20
> > Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> > Signed-off-by: Jens Emil Schulz =C3=98stergaard <jensemil.schulzosterga=
ard@microchip.com>
> > ---
> > Changes in v2:
> > - rename file to microchip,lan96455s-switch.yaml
> > - remove led vendor property
> > - add {rx,tx}-internal-delay-ps for rgmii delay
> > - remove labels from example
> > - remove container node from example
> > ---
> >  .../net/dsa/microchip,lan96455s-switch.yaml        | 119 +++++++++++++=
++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 120 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,lan964=
55s-switch.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,lan96=
455s-switch.yaml
> > new file mode 100644
> > index 000000000000..0282e25c05d4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-swi=
tch.yaml
> > @@ -0,0 +1,119 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/dsa/microchip,lan96455s-switch.=
yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip LAN9645x Ethernet switch
> > +
> > +maintainers:
> > +  - Jens Emil Schulz =C3=98stergaard <jensemil.schulzostergaard@microc=
hip.com>
> > +
> > +description: |
>=20
> Don't need '|'

I will remove this.

>=20
> > +  The LAN9645x switch is a multi-port Gigabit AVB/TSN Ethernet switch =
with
> > +  five integrated 10/100/1000Base-T PHYs. In addition to the integrate=
d PHYs,
> > +  it supports up to 2 RGMII/RMII, up to 2 BASE-X/SERDES/2.5GBASE-X and=
 one
> > +  Quad-SGMII interfaces.
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - enum:
> > +          - microchip,lan96455s-switch
> > +      - items:
> > +          - enum:
> > +              - microchip,lan96455f-switch
> > +              - microchip,lan96457f-switch
> > +              - microchip,lan96459f-switch
> > +              - microchip,lan96457s-switch
> > +              - microchip,lan96459s-switch
> > +          - const: microchip,lan96455s-switch
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +$ref: dsa.yaml#
>=20
> Since you don't have any custom properties (just constraints), this ref
> should be "dsa.yaml#/$defs/ethernet-ports".

Right, I will update the ref.

>=20
> > +
> > +patternProperties:
> > +  "^(ethernet-)?ports$":
>=20
> For a new binding, use the preferred name which is ethernet-ports. ports
> and port collide with the graph binding.
>=20

OK, I will use ethernet-ports and move it from patternProperties to propert=
ies.

> > +    type: object
> > +    additionalProperties: true
> > +    patternProperties:
> > +      "^(ethernet-)?port@[0-8]$":
>=20
> And 'ethernet-port'

I will change this and update the example.

>=20
> > +        type: object
> > +        description: Ethernet switch ports
> > +
> > +        $ref: dsa-port.yaml#
> > +
> > +        properties:
> > +          rx-internal-delay-ps:
> > +            const: 2000
> > +
> > +          tx-internal-delay-ps:
> > +            const: 2000
> > +
> > +        unevaluatedProperties: false
>=20
> Place this after the $ref.

I will move this.

>=20
> > +
> > +oneOf:
> > +  - required:
> > +      - ports
> > +  - required:
> > +      - ethernet-ports
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    ethernet-switch@4000 {
> > +        compatible =3D "microchip,lan96459f-switch", "microchip,lan964=
55s-switch";
> > +        reg =3D <0x4000 0x244>;
> > +
> > +        ethernet-ports {
> > +            #address-cells =3D <1>;
> > +            #size-cells =3D <0>;
> > +
> > +            port@0 {
> > +                reg =3D <0>;
> > +                phy-mode =3D "gmii";
> > +                phy-handle =3D <&cuphy0>;
> > +            };
> > +
> > +            port@1 {
> > +                reg =3D <1>;
> > +                phy-mode =3D "gmii";
> > +                phy-handle =3D <&cuphy1>;
> > +            };
> > +
> > +            port@2 {
> > +                reg =3D <2>;
> > +                phy-mode =3D "gmii";
> > +                phy-handle =3D <&cuphy2>;
> > +            };
> > +
> > +            port@3 {
> > +                reg =3D <3>;
> > +                phy-mode =3D "gmii";
> > +                phy-handle =3D <&cuphy3>;
> > +            };
> > +
> > +            port@7 {
> > +                reg =3D <7>;
> > +                phy-mode =3D "rgmii";
> > +                ethernet =3D <&cpu_host_port>;
> > +                rx-internal-delay-ps =3D <2000>;
> > +                tx-internal-delay-ps =3D <2000>;
> > +
> > +                fixed-link {
> > +                    speed =3D <1000>;
> > +                    full-duplex;
> > +                    pause;
> > +                };
> > +            };
> > +        };
> > +    };
> > +...
> > +
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7ae698067c41..8232da1b3951 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17278,6 +17278,7 @@ M:    Jens Emil Schulz =C3=98stergaard <jensemi=
l.schulzostergaard@microchip.com>
> >  M:   UNGLinuxDriver@microchip.com
> >  L:   netdev@vger.kernel.org
> >  S:   Maintained
> > +F:   Documentation/devicetree/bindings/net/dsa/microchip,lan96455s-swi=
tch.yaml
> >  F:   include/linux/dsa/lan9645x.h
> >  F:   net/dsa/tag_lan9645x.c
> >=20
> >=20
> > --
> > 2.52.0
> >=20


