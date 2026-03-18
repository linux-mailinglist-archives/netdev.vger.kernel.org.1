Return-Path: <netdev+bounces-269042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMXTOUO1umlWawIAu9opvQ
	(envelope-from <netdev+bounces-269042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:22:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 420472BCFD3
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2DB86301DDCF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 14:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18903DA7C5;
	Wed, 18 Mar 2026 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="H16M+Rej"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C183DA5CC;
	Wed, 18 Mar 2026 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843608; cv=none; b=G+rSrnRRuKQHhUZUWGA84t9xkv17c2iJAr6pNxvh4Gf6b4uwQxQyN+XuthgpIR6T43V3XbxKhUBaeqAkAE6Gs/07ZAgteSwsBRChof9ATvsB4FIrDmvqfT+75yJTzvkhzHFSqoI7EVSgDxxo9bFDurjFNEZ+VKmUU1EZVeHbNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843608; c=relaxed/simple;
	bh=BqBrdDaqvEVGkSXucMRZcRJIAhtH92n+qMPBpXu6a4w=;
	h=Message-ID:Subject:From:To:CC:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W2TE7kYxGUDQPYoky8SqhVTYcdv5gZRvLm7twBcOimqp7bnYsgXdJT9OXDtfRGkinfCyb+ZC1rX8EZFtFOr0YH0nvyjv7vU6E+BF+apCdpeW3hZd8Fa5pjADy3VsxmFjoS7v+IQwv6buhWVEPN0yXQIaymLbN9wPFuf7KTYqc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=H16M+Rej; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1773843604; x=1805379604;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=BqBrdDaqvEVGkSXucMRZcRJIAhtH92n+qMPBpXu6a4w=;
  b=H16M+RejOZdpBUNMM5AkEQ+gBaG9JbHzojJqWN9ZG1Goc9KwT83MlXnR
   9UY2TXvs4Xw10mQY79y7usjbZK1KHhrAW1NWkf4+cCxninDl20nH2wcwI
   FOIpbYBaW/+lGRAPxYOQ2K7KtESSYnTwq/zPCC6x6CssF53AWGJDplaSq
   GIaDDTCre38QciPKvaD5MbEWfZ5gDEUD0SmP2SKi4wM+3TxIQ1kIfJbGm
   bUXy5NjFPG2gPZW2W9MOXtjNF6rbSvY8xB6dLHViicr24cLXmVWF6xcSp
   WoloqQebj1P/Ce4WVR6XCexcoh1xGa/jWxJNw+xJ7Hj2sTgWTMb9lT0C1
   g==;
X-CSE-ConnectionGUID: XiHSOhC7SXiYlK8XQwA8wQ==
X-CSE-MsgGUID: /QxNaOfUSaavQN/Eay9f2w==
X-IronPort-AV: E=Sophos;i="6.23,127,1770620400"; 
   d="scan'208";a="55259797"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 07:20:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 18 Mar 2026 07:19:24 -0700
Received: from DEN-DL-M77643.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 18 Mar 2026 07:19:21 -0700
Message-ID: <207c7a47e0802dd4c34ba90f2532dc2e0c3f7f05.camel@microchip.com>
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
From: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, <UNGLinuxDriver@microchip.com>, "Vladimir
 Oltean" <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>, "Russell
 King" <linux@armlinux.org.uk>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
Date: Wed, 18 Mar 2026 15:19:20 +0100
In-Reply-To: <20260306-pointless-purr-210540d4dc64@spud>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
	 <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
	 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
	 <20260303-mosaic-debate-90cf8c8bbb33@spud>
	 <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
	 <20260305-reliant-parchment-0ff685a9c78e@spud>
	 <7b62ace495084794336b19a9685d6b14ea3981a0.camel@microchip.com>
	 <20260306-pointless-purr-210540d4dc64@spud>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269042-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jensemil.schulzostergaard@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,0.0.0.1:email,0.0.0.0:email]
X-Rspamd-Queue-Id: 420472BCFD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Conor,

On Fri, 2026-03-06 at 15:20 +0000, Conor Dooley wrote:
> On Fri, Mar 06, 2026 at 04:08:01PM +0100, Jens Emil Schulz Ostergaard wro=
te:
> > On Thu, 2026-03-05 at 18:31 +0000, Conor Dooley wrote:
> > > On Thu, Mar 05, 2026 at 01:57:37PM +0100, Jens Emil Schulz Ostergaard=
 wrote:
> > > > On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> > > > > On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > > > > > +        properties:
> > > > > > > +          microchip,led-drive-mode:
> > > > > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +            description: |
> > > > > > > +              Set the LED drive mode for the copper PHY asso=
ciated with
> > > > > > > +              this port.
> > > > > > > +
> > > > > > > +                0 - LED1 and LED2 in open-drain mode
> > > > > > > +                1 - LED1 in active drive mode (can be used f=
or single-LED
> > > > > > > +                    configurations requiring active drive)
> > > > > > > +                2 - Reserved
> > > > > > > +                3 - LED1 and LED2 in active drive mode
> > > > > > > +            minimum: 0
> > > > > > > +            maximum: 3
> > > > > >=20
> > > > > > I doubt the DT Maintainers will accept that. This looks a lot l=
ike a
> > > > > > value you write into a register. How are active drive and open-=
drain
> > > > > > described in other DT bindings? Is there something you can reus=
e?
> > > > >=20
> > > > > I had a quick look and I didn't see anything really that stood ou=
t to me
> > > > > that would be a drop-in replacement.
> > > > > I also tried looking in the datasheet for more information on the=
se
> > > > > modes, but I couldn't see anything obvious. For example, there we=
re zero
> > > > > hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
> > > > >=20
> > > > > That said, yea you're right about DT maintainer feelings about it=
.
> > > > > There's a couple things I could suggest, but I'd like to know abo=
ut what
> > > > > mode 1 means for LED2 first. If there's actually nothing similar,=
 what
> > > > > about representing each led with a child node and having open-dra=
in be
> > > > > the default with a property in the child for active-drive?
> > > > >=20
> > > > > >=20
> > > > > > For 1, what happens to LED2? Not used at all?
> > > >=20
> > > > In mode 1 LED2 will be open-drain. This mode only makes sense if yo=
u have
> > > > just 1 LED. With two LEDs mode 0 or mode 3 should be used.
> > >=20
> > > Could we then have child nodes for each led, and have a property in e=
ach
> > > that sets the mode to either open-drain or active-drive? Or am I just
> > > inserting complexity by asking for that?
> >=20
> > I think it sounds sensible, I will add this.
>=20
>=20
> You don't need a property for each, just make one mode the default (prob
> open-drain given it's the 0 setting, but whatever is default out of
> reset for the part) and have the property for the other mode. Just
> some bool property like "microchip,active-drive" or whatever.


Based on your feedback I went with this under port properties:

          leds:
            patternProperties:
              '^led@[a-f0-9]+$':
                $ref: /schemas/leds/common.yaml#

                properties:
                  reg:
                    maxItems: 1

                  microchip,active-drive:
                    type: boolean
                    description:
                      Set the LED output to active drive mode. The default
                      is open-drain.

                required:
                  - reg

                unevaluatedProperties: false

and then the example has

          port@1 {
            reg =3D <1>;
            phy-mode =3D "gmii";
            phy-handle =3D <&cuphy1>;

            leds {
              #address-cells =3D <1>;
              #size-cells =3D <0>;

              led@0 {
                reg =3D <0>;
                microchip,active-drive;
              };

              led@1 {
                reg =3D <1>;
                microchip,active-drive;
              };
            };
          }

However, this does not pass dt_binding_check because we pull in $ref: dsa-p=
ort.yaml,
which pulls in ethernet-controller.yaml.

I believe the 'unevaluatedProperties: false' on LED nodes in ethernet-contr=
oller.yaml
prevents downstream bindings from adding vendor-specific LED properties.

Is the right move removing unevaluatedProperties: false from the LED node i=
n
ethernet-controller.yaml, or is there a preferred way to extend per-port LE=
Ds?

Thanks,
Emil


