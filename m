Return-Path: <netdev+bounces-191194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FB3ABA5F1
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53ABBA02FAC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C842343C6;
	Fri, 16 May 2025 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EDhrE9S1"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312EC6A8D2;
	Fri, 16 May 2025 22:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747434934; cv=none; b=iVCVRB17IEwBycAEVdc0b3NKfrXCRJifKOX+e2v1RDboQlogEYf18u/E/t79psV6P9SpLwCytanOIyOyyOHG2C1uJTtRUKJjpBMDvFf/z5SQnBFfNTLfsxGNdtrygNySPJXQQvNWPrvdlF06WYHtHuu/huvBePgZM7cCP9ngj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747434934; c=relaxed/simple;
	bh=cMw4UsOINRnDBGrLZw8A/tkg1qlBAC7P1rGGcrLjJuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCn1ZJC6mt1oYsv6P4XTYUrJ1sRmbPcWHh+wmU4PIOndzRyx+1K25YGwCUpXCChwQPAIWLSuh9TGeioiS6t902MyMus+n6nNQDIjjK3pqgh9LcTm48deEb2gX1h9h3jcklnNJRFH7eRUkocxol+ZUxvtLAAUwvcl86W8JhM3uQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EDhrE9S1; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4CF4143137;
	Fri, 16 May 2025 22:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747434929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypgk7XZohQ5Mo5azVnaHdOVehBPBVRry66ULOrpPDPI=;
	b=EDhrE9S15SmIv1BUv1fKwGYuyNZdoxIckQf2PeRoi/QD12Nx8TePdCSkb3j/KDPqYDInw4
	iLE6Rk0xxf676bV5/ZeUgtEoNaS1oEXBi68IuCQ2nrWcMA0urVB/v/MB6j7HGChsS9sD8+
	YhJ9+gAH82OPTs2ZcEvcDE98DTBv5e3TpjEzYqWxYyTZt+vM53s6s9blVF5TuJYzioAlkn
	UqN4S0jch6WZ4gUKBsIj/sOnYa2HPpvhqkrjdthaohCydHjva/X4JkjdUF/NpxGepU1UJd
	bdBHUCHL6XL5OXKlC40GG9GyE9kyZtGIhYZFIHf7hzfAiy/wwqMCqMM60tq2UA==
Date: Sat, 17 May 2025 00:35:25 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Piotr Kubik <piotr.kubik@adtran.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL]Re: [PATCH net-next 1/2] dt-bindings: net: pse-pd:
 Add bindings for Si3474 PSE controller
Message-ID: <20250517003525.2f6a5005@kmaincent-XPS-13-7390>
In-Reply-To: <dccd0e78-81c6-422c-9f8e-11d3e5d55715@adtran.com>
References: <bf9e5c77-512d-4efb-ad1d-f14120c4e06b@adtran.com>
	<259ad93b-9cc2-4b5d-8323-b427417af747@adtran.com>
	<f8eb7131-5a5d-47ec-8f3b-d30cdb1364b5@kernel.org>
	<dccd0e78-81c6-422c-9f8e-11d3e5d55715@adtran.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudefleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudeimeejtgemfegrtdehmegviegvvdemugelgehfmeegleehugemugdugeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduieemjegtmeefrgdtheemvgeivgdvmeguleegfhemgeelhegumeguudeggedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepphhiohhtrhdrkhhusghikhesrgguthhrrghnrdgtohhmpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehordhrvghmphgvl
 hesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 15 May 2025 15:20:40 +0000
Piotr Kubik <piotr.kubik@adtran.com> wrote:

> On 5/13/25 10:24, Krzysztof Kozlowski wrote:
> > On 13/05/2025 00:05, Piotr Kubik wrote: =20
> >> +
> >> +maintainers:
> >> +  - Piotr Kubik <piotr.kubik@adtran.com>
> >> +
> >> +allOf:
> >> +  - $ref: pse-controller.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - skyworks,si3474
> >> +
> >> +  reg-names:
> >> +    items:
> >> +      - const: main
> >> +      - const: slave =20
> >=20
> > s/slave/secondary/ (or whatever is there in recommended names in coding
> > style)
> >  =20
>=20
> Well I was thinking about it and decided to use 'slave' for at least two
> reasons:
> - si3474 datasheet calls the second part of IC (we configure it here) thi=
s way
> - description of i2c_new_ancillary_device() calls this device explicitly
> slave multiple times

It is better to avoid the usage of such word in new code. Secondary suits w=
ell
for replacement.

> >> +
> >> +  reg: =20
> >=20
> > First reg, then reg-names. Please follow other bindings/examples.
> >  =20
> >> +    maxItems: 2
> >> +
> >> +  channels:
> >> +    description: The Si3474 is a single-chip PoE PSE controller manag=
ing
> >> +      8 physical power delivery channels. Internally, it's structured
> >> +      into two logical "Quads".
> >> +      Quad 0 Manages physical channels ('ports' in datasheet) 0, 1, 2=
, 3
> >> +      Quad 1 Manages physical channels ('ports' in datasheet) 4, 5, 6=
, 7.
> >> +      This parameter describes the relationship between the logical a=
nd
> >> +      the physical power channels. =20
> >=20
> > How exactly this maps here logical and physical channels? You just
> > listed channels one after another... =20
>=20
> yes, here in this example it is 1 to 1 simple mapping, but in a real worl=
d,
> depending on hw connections, there is a possibility that=20
> e.g. "pse_pi0" will use "<&phys0_4>, <&phys0_5>" pairset for lan port 3.

But here you should describe the channels of the controller and the channel=
 has
no link to the relationship between logical and physical power channels. Th=
is
relationship rather is described in the "pairsets" parameter of PSE PI.

Maybe something like that:

The Si3474 is a single-chip PoE PSE controller managing 8 physical power
delivery channels. Internally, it's structured into two logical "Quads".
Quad 0 Manages physical channels ('ports' in datasheet) 0, 1, 2, 3
Quad 1 Manages physical channels ('ports' in datasheet) 4, 5, 6, 7.
This parameter defines the 8 physical delivery channels on the controller t=
hat
can be referenced by PSE PIs through their "pairsets" property. The actual =
port
matrix mapping is created when PSE PIs reference these channels in their
pairsets. For 4-pair operation, two channels from the same group (0-3 or 4-=
7)
must be referenced by a single PSE PI.

Similarly the description I used on the tps23881 is also not correct. I hav=
e to
change it.
=20
I didn't look into the datasheet, could we have parameters specific to a
quad? If that the case we maybe should have something like that:
          quad0: quad@0 {                                                =20
            reg =3D <0>;                                                   =
      =20
            #address-cells =3D <1>;                                        =
      =20
            #size-cells =3D <0>;                                           =
                                           =20
                                                                           =
    =20
            phys0: port@0 {                                                =
    =20
              reg =3D <0>;                                                 =
      =20
            };                                                             =
    =20
                                                                           =
    =20
            phys1: port@1 {                                                =
    =20
              reg =3D <1>;                                                 =
      =20
            };                                                             =
    =20
                                                                           =
    =20
            phys2: port@2 {                                                =
    =20
              reg =3D <2>;                                                 =
      =20
            };                                                             =
    =20
                                                                           =
    =20
            phys3: port@3 {                                                =
    =20
              reg =3D <3>;                                                 =
      =20
            };                                                             =
    =20
          };                                                               =
    =20
                                                                           =
    =20
          quad@1 {                                                         =
 =20
            reg =3D <1>;                                                   =
      =20
            #address-cells =3D <1>;                                        =
      =20
            #size-cells =3D <0>;                                           =
      =20
                                                                           =
    =20
            phys4: port@0 {                                                =
    =20
              reg =3D <0>;                                                 =
      =20
            };                                                             =
    =20
                                                                           =
    =20
            phys5: port@1 {                                                =
    =20
              reg =3D <1>;                                                 =
      =20
            };                                                             =
    =20
                                                                           =
    =20
            phys6: port@2 {                                                =
    =20
              reg =3D <2>;                                                 =
      =20
            };                                                             =
    =20
                                                                           =
    =20
            phys7: port@3 {                                                =
    =20
              reg =3D <3>;                                                 =
      =20
            };                                                             =
    =20
          };                                                               =
    =20
        };

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

