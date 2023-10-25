Return-Path: <netdev+bounces-44246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9C67D74AC
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 21:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B2B1C20C61
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 19:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7952731A8C;
	Wed, 25 Oct 2023 19:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vhoh9PTM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A4931A8A
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 19:48:33 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A1BAE5
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:48:31 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a877e0f0d8so11282327b3.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698263310; x=1698868110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuPONpaYSj8+kIK6QOLesnpaht6g5us12lHkxqLvfTI=;
        b=Vhoh9PTMR8G1l2fbhCV4dy52NLg0DDJuk8py1/bhyZbLFRai3oACLOv+IIrJqnH00B
         E80tkfedfgX6lfc3kQIadGTeGSyy1wR5T50A9y0SWQy8lpB1U8nnsugrB+Gy8jw2sgNz
         dIdsP76SDvIAY+Q27zlAXWpvcKzI/hkXyL+ZC2WFI1NRUuboc+0buFGnWM6X/qkyJZjI
         0Wp3ZQ0to6jJKzoKxt8v6SDSS8w+ETklWfSQ+wF7H7vPis8dz8FNJ/aDIXNGBgdHkmJn
         oLXNwC7fsUAlk2legzQpj5iWs0w0ceSdhpFbxBjArIyaopsjsv0UMHQtx2lzUCzJRtQ9
         TSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263310; x=1698868110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuPONpaYSj8+kIK6QOLesnpaht6g5us12lHkxqLvfTI=;
        b=HOdkVjWwMsFoaY8Z4UVNbJ/xolcpUw9r05QuE/TvrRzxGP/CcRka/8/xYi78ZbJrs3
         K2i3EN5fex8lkUVvTL5+p49Zmwa8dX1n/oHGEYJ5VQg/wFk6hB7+s4bgBbqpD/Q7vKze
         QG6onZY0089SE/xCTSPJPFtElc/O6Ko5uxXRJPrzYvxQ0wVltWHLZoyU5IXbWXLHFXCa
         LDV7Pl0uAUT22x2fQLttxQQNWBIWAWXVufMpc/Mk8oLTwUIimjfWwt5aCEtT0GbRg9OS
         i0d4P2otr1WvQYFeWmTrrb4XMy8PVwt+4b92ZIQ4DKYbYzRhkvYucry53sYNAH33r5PW
         jqeQ==
X-Gm-Message-State: AOJu0YwcJyrCKZnKtLTVwlF6Vhjw1spqZD3O6sZ0xWhzkLtfBPiZsvuf
	tbOER4IjJcSzZLA6WXc6q8mrVKi833oXdV26zWk+Nw==
X-Google-Smtp-Source: AGHT+IGYiHKJ4+S6f0jGG5my0gZTVjFK1TF8NFx8hvc99MsF3aYNaFzVLRXJH3nrdkQiCqQIlfv1eTen4TSzN6hSyUA=
X-Received: by 2002:a81:79d1:0:b0:5a7:af51:fa39 with SMTP id
 u200-20020a8179d1000000b005a7af51fa39mr1023019ywc.8.1698263310551; Wed, 25
 Oct 2023 12:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024-marvell-88e6152-wan-led-v7-0-2869347697d1@linaro.org>
 <20231024-marvell-88e6152-wan-led-v7-5-2869347697d1@linaro.org> <20231024182842.flxrg3hjm3scnhjo@skbuf>
In-Reply-To: <20231024182842.flxrg3hjm3scnhjo@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 25 Oct 2023 21:48:18 +0200
Message-ID: <CACRpkdb-4GPnVegc+OqyPaZN2rNCkgmNL4qjf-LGnnz27+EBbg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 5/7] ARM64: dts: marvell: Fix some common
 switch mistakes
To: Vladimir Oltean <olteanv@gmail.com>
Cc: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Enrico Mioso <mrkiko.rs@gmail.com>, Robert Marko <robert.marko@sartura.hr>, 
	Russell King <linux@armlinux.org.uk>, Chris Packham <chris.packham@alliedtelesis.co.nz>, 
	Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vladimir,

thanks for paging in the right maintainers to look at the respective boards=
,
much appreciated!

On Tue, Oct 24, 2023 at 8:28=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> I looked at U-Boot's ft_board_setup() from board/Marvell/mvebu_armada-37x=
x/board.c
> and it doesn't appear to do anything with the switch. But after the MOX p=
recedent
> (which is _still_ problematic, more below), I still think we are way too
> trigger-happy with this, and it would be good to ask someone who has the
> Espressobin to test.

Yeah that would be great.

> > -     /* switch nodes are enabled by U-Boot if modules are present */
> > +     /*
> > +      * NOTE: switch nodes are enabled by U-Boot if modules are presen=
t
> > +      * DO NOT change this node name (switch0@10) even if it is not fo=
llowing
> > +      * conventions! Deployed U-Boot binaries are explicitly looking f=
or
> > +      * this node in order to augment the device tree!
> > +      */
>
> Not "this node", but all switch nodes!
(...)
> It's funny that you add a comment TO NOT rename switch nodes, then you
> proceed to do just that.

Yeah it's a stupid mistake on my behalf. :( too sleepy or something.

I fixed it up, and put a small comment above each of them not
to change the node name.

> > -             ports {
> > +             ethernet-ports {
>
> U-Boot code does this, so you can't rename "ports":
>
>         /*
>          * now if there are more switches or a SFP module coming after,
>          * enable corresponding ports
>          */
>         if (id < peridot + topaz - 1) {
>                 res =3D fdt_status_okay_by_pathf(blob,
>                                                "%s/switch%i@%x/ports/port=
@a",
>                                                mdio_path, id, addr);
>         } else if (id =3D=3D peridot - 1 && !topaz && sfp) {
>                 res =3D fdt_status_okay_by_pathf(blob,
>                                                "%s/switch%i@%x/ports/port=
-sfp@a",
>                                                mdio_path, id, addr);
>         } else {
>                 res =3D 0;
>         }
>
> >                       #address-cells =3D <1>;
> >                       #size-cells =3D <0>;
> >
> > -                     port@1 {
> > +                     ethernet-port@1 {
>
> or "port@.*", or "port-sfp@a", for the same reason. Here and everywhere
> in this device tree. Basically only the ethernet-phy rename seems safe.

Fair, reverted it all.

> Having that said, we need to suppress these warnings for the Marvell
> schema only:
>
> arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dtb: switch0@10: $node=
name:0: 'switch0@10' does not match '^(ethernet-)?switch(@.*)?$'
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
> arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dtb: ethernet-switch@1=
2: ethernet-ports: 'port-sfp@a' does not match any of the regexes: '^(ether=
net-)?port@[0-9]+$', 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv=
88e6xxx.yaml#
>
> because someone _will_ fix them and break the boot in the process.

Really? I think you will stop them from doing that every single time ;)

Jokes aside, we certainly need a way to suppress this warning.

> Rob, Krzysztof, Conor, do you have any suggestion on how to achieve that?

What we can do easily is to override the $nodename requirement for
a certain compatible with one of those - if: constructions, but that would
unfortunately make us be lax on every other board as well.

What we want to achieve is:

1. Match on the top level compatible (under '/') with contains: const:
cznic,turris-mox

2. Then relax requirements on the switch nodes if that is true.

I assume I would have to go into
Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
and put hard requirement on node names from there. I'm not sure
this would work or that it's even possible, or desireable.

But...

We  *COULD* add a second over-specified compatible to the switch
node. Such as:

      switch0@10 {
                compatible =3D "marvell,turris-mox-mv88e6190-switch",
"marvell,mv88e6190";

(and the same for the 6085 version)

And use that to relax the requirement for that variant with an - if:
statemement.

This should work fine since U-Boot is only looking for nodenames, not
compatible strings. I think I will try this approach.

Yours,
Linus Walleij

