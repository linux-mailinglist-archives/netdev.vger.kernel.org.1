Return-Path: <netdev+bounces-165082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB9A3057A
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 09:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C58188B19D
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2DA1EEA37;
	Tue, 11 Feb 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nKLX3de0"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7101922E7
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261725; cv=none; b=MdLXk6G0r+uGO8Z3yafL/bgKtheRxPfDDLhjcFe6zYTtXajv638Achctr7UHJ9sbjbBlbAVVrCjcOtN5IRStca/zz5RP1Ey3NPWJYeTZ+5pCHUExpKIcJkZZYv+0XrRPWvGVyMadjvQ8lvstwmTvGl57Pe1top7aF2TMV65jJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261725; c=relaxed/simple;
	bh=rjdIQEYlZdOAaWMDalwxHV435B5Q2LTgg06zvqrwOmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cl9VsfU54HKyTNhz1QkumIrg2k5boKVclan8OzSRcF0TIVnTp3L2w6vrFQ59s7HX/d6vKU0Vfl5cxNiK9BQIegJJF9MKRVxd77gPfJ1c5wq0GbtV3sZLMIxCOja89Jwjb2ZIij6Nlp4tRfulDzausDQEyz2BLfS60gASIzhyu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nKLX3de0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1EA21442FD;
	Tue, 11 Feb 2025 08:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739261720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9ICIc2tHJNQXL43Nm1ltNdAEKKkMBQM1HN7ctpn74w=;
	b=nKLX3de0d0HIIzHbm+CIp52F9ue5vYVCTzvvHdDxneSpqrhIL5elf4QqQiKNEzcx/bOJST
	7+fAaYfqFEyucRQsniuJrgqyJy9YliBom1a9dam1MS8g+sS9lhb89rPwX65EUhwBu/x0Rj
	GI5cdcHpK2R1HVRWguC21DwYLEz9um7ZUPKyVsAZsQbpTnsBfJXhS9xse/CbBuM6/Vl4YP
	BgDC+fF5gB1k9oageil87XBMus6NuJMuRoQ/pwTFtbsY6pQvKRxJmAUV+u0BsMI2zzZdem
	HOWcXP/KT+0AVZO3Zzh9DGlhNy+gRHNLO6+y51P/mXAfMYb2fX3UOp7YWU972w==
Date: Tue, 11 Feb 2025 09:15:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Bo-Cun Chen <bc-bocun.chen@mediatek.com>, Chad Monroe
 <chad.monroe@adtran.com>, John Crispin <john@phrozen.org>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Vladimir Oltean <olteanv@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 "Chester A. Unal" <chester.a.unal@arinc9.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger
 <matthias.bgg@gmail.com>, netdev@vger.kernel.org
Subject: Re: upstream Linux support for Ethernet combo ports via external
 mux
Message-ID: <20250211091507.59238fc1@fedora-1.home>
In-Reply-To: <Z6qHi1bQZEnYUDp7@makrotopia.org>
References: <Z6qHi1bQZEnYUDp7@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekheegieejkeetfffhleehteffgefhfffhueefieefffejfeethfevudetudeuueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegttgeftgemgeelfhegmeefieehheemsgehjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemtggtfegtmeeglehfgeemfeeiheehmegsheejgedphhgvlhhopehfvgguohhrrgdquddrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepuggrnhhivghlsehmrghkrhhothhophhirgdrohhrghdprhgtphhtthhopegstgdqsghotghunhdrtghhvghnsehmvgguihgrthgvkhdrtghom
 hdprhgtphhtthhopegthhgrugdrmhhonhhrohgvsegrughtrhgrnhdrtghomhdprhgtphhtthhopehjohhhnhesphhhrhhoiigvnhdrohhrghdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepohhlthgvrghnvhesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Daniel,

On Mon, 10 Feb 2025 23:11:07 +0000
Daniel Golle <daniel@makrotopia.org> wrote:

> Hi,
>=20
> Looking for ways to support a passive SerDes mux in vanilla Linux I
> found Maxime's slides "Multi-port and Multi-PHY Ethernet interfaces"[1].

I'm actively working on getting this exact case supported. The MUX I
have is an RGMII MUX, but gpio-driven just as in your case :) I'll make
sure to CC: you in the next iterations

> The case I want to support is probably quite common nowadays but isn't
> covered there nor implemented in Linux.
>=20
>  +----------------------------+
>  |            SoC             |
>  |    +-----------------+     |
>  |    |       MAC       |     |
>  |    +----+-------+----+     |
>  |         |  PCS  |   +------+
>  |         +---=3D---+   | GPIO |
>  +-------------=3D-------+---=3D--+
>               |            |
>            +---=3D---+       |
>            |  Mux  <-------+
>            +-=3D---=3D-+
>              |   |
>             /     \
>      +-----=3D-+   +-=3D-----+
>      |  PHY  |   |  SFP  |
>      +-------+   +-------+

The work in question is here :

https://lore.kernel.org/netdev/20250210095542.721bf967@fedora-1.home/

Preliminary work was merged here :

https://lore.kernel.org/netdev/20240821151009.1681151-1-maxime.chevallier@b=
ootlin.com/

To summarize the whole process :

I started with a use-case similar as yours, but instead of PHY - SFP
combo I have a PHY-PHY combo. That's fairly analoguous to what you have
(say you plug a copper SFP on the cage, you now have 2 parallel PHYs
behind the MAC)

So the first step was the intrduction of phy_link_topology to allow
tracking PHYs attached to a MAC, even if they aren't directly on the
active datapath (the PHY isolated by the MUX). That was clearly a
pre-requisite for any kind of muxing.

=46rom all the feedback (among other, from Oleksji Rempel, Russell King,
Marek Beh=C3=B9n), it appears that this setup you have is not that unusual,
and also ressembles other setups such as :

        +-- SFP
MAC - PHY
        +-- RJ45

If we look at the big picture from the end-user's point of view,
there's no difference between a MAC connected to a dual-port PHY and a
MAC connected to a PHY + SFP through a MUX, it's just a NIC with 2
ports.

So where I'm at today is that I'm trying to get a "generic"
representation of front-facing ports accepted, that will be the kernel
objects used for configuration.

If user wants to enable the SFP port for example, if the SFP is behind
a MUX, the MUX will be cntrolled to set the correct output, and if the
SFP is behind a PHY, then the PHY driver will be in charge of the
mux'ing.

> So other than it was when SoCs didn't have built-in PCSs, now the SFP is
> not connected to the PHY, but there is an additional mux IC controlled
> by the SoC to connect the serialized MII either to the PHY (in case no
> SFP is inserted) or to the SFP (in case a module is inserted).
>=20
> MediaTek came up with a vendor-specific solution[2] for that which works
> well -- but obviously it would be much nicer to have generic, vendor-
> agnostic support for such setups in phylink, ideally based on the
> existing gpio-mux driver.
>=20
> So I imagine something like a generic phylink-mux, controlled by hooking
> to the module_insert and module_remove remove SFP ops (assuming the
> moddef0 signal is connected...).
>=20
> Before I get my hands dirty, please join my line of thought for one
> moment, so we can agree on a sketch:
>=20
> Does everyone agree that phylink would be the right place to do this?

As Andrew says, we can't really let phylink alone handle that. The
approach I have taken is to model the MUX as a dedicated driver, that
would have "parent" ops allowing to notify whatever is upstream of the
mux to know about state change :

> DT bindings could look like this (option A):
>  ...
>     mux: mux-controller {
>         compatible =3D "gpio-mux";
>         #mux-control-cells =3D <0>;
>=20
>         mux-gpios =3D <&pio 7 GPIO_ACTIVE_HIGH>;
>     };
>=20
>     mux0: mii-mux {
>         compatible =3D "mii-mux";
>         mux-controls =3D <&mux>;
>         #address-cells =3D <1>;
>         #size-cells =3D <0>;
>=20
>         channel@0 {
>             reg =3D <0>;
>             sfp =3D <&sfp0>;
>             managed =3D "in-band-status";
>             module-presence-controls-mux;
>         };
>=20
>         channel@1 {
>             reg =3D <1>;
>             phy-handle =3D <&phy0>;
>             phy-connection-type =3D "sgmii";
>         };
>     };
>   };
>=20
>   soc {
>       ethernet@12340000 {
>           mii-mux =3D <&mux0>;
>       };
>   };

I have some code written for that, and I have a very similar binding in
the end :

		eth1: ucc@2200 {
			far-id =3D <0 1 3 4 5 6 7>;
			device_type =3D "network";
			compatible =3D "ucc_geth", "cs,mia-far";
			cell-index =3D <3>;
			reg =3D <0x2200 0x200>;
			interrupts =3D <34>;
			interrupt-parent =3D <&qeic>;
			local-mac-address =3D [ 00 00 00 00 00 00 ];
			rx-clock-name =3D "clk12";
			tx-clock-name =3D "clk12";
			phy-mux-handle =3D <&phymux>;
			pio-handle =3D <&ucc3pio>;
			phy-connection-type =3D "rmii";
		};

		phymux: phymux@0 {
			compatible =3D "gpio-phy-mux";
			status =3D "okay";
			select-gpios =3D <&qe_pio_c 21 1>;

			phy-node@0 {
				phy-handle =3D <&phy2>;
				phy-mode =3D "rmii";
			};

			phy-node@1 {
				active-low;
				phy-handle =3D <&phy3>;
				phy-mode =3D "rmii";
			};
		};

The mux node can of course include SFP.

>=20
> or like this (option B):
>  ...
>     mux: mux-controller {
>         compatible =3D "gpio-mux";
>         #mux-control-cells =3D <0>;
>=20
>         mux-gpios =3D <&pio 7 GPIO_ACTIVE_HIGH>;
>     };
>   };
>=20
>   soc {
>       ethernet@12340000 {
>           sfp =3D <&sfp0>;
>           phy =3D <&phy0>;
>           phy-connection-type =3D "sgmii";
>           mux-controls =3D <&mux>;
>       };
>   };
>=20
>=20
> Obviously option A is more expressive, but also more complex, and I'm
> not 100% sure if all that complexity is really needed in practise.
> However, for "better safe than sorry" reasons I'd opt for option A,
> unless anyone comes up with a better idea.

Maybe we can sync our work, I'm all in to get more hands on this. The
current roadmap I have in mind is :

 - Get the port representation stable and accepted
 - Get muxing working for the "simple" case of PHY-driven muxes, which
includes a new netlink API, and muxing operations for front-facing ports
 - Get PHY muxes going, with a PHY mux framework and mux drivers
(gpio-driven, MMIO-register driven, completely passive muxes based on
PHY powerdown...)

I've made some attemps to get the phy mux support first, but we've
discussed that extensively with Andrew and Russell on that thread
here and the path forward would be to get that problem first from the
perspective of the ports :

https://lore.kernel.org/netdev/20241004161601.2932901-1-maxime.chevallier@b=
ootlin.com/

Thanks,

Maxime


