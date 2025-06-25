Return-Path: <netdev+bounces-200943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9ACAE7680
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A643A6C19
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 05:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C8E1DC198;
	Wed, 25 Jun 2025 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ljKibZbs"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59919E97A
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 05:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750830893; cv=none; b=SG/He2wa4E9AEyGJ+kQ7mHe9Q1uX7bxFjnOyVazldOhkyBDR/YlY273XnAxc/PopMYzG9hYB4xvPh4zw7++YxlUan4alh0MqkdSCuiKx1oxkqZ30kTbCADMg6b9uU8XqBrtq7nSXWlInr/SezOWZ/YwmcJ8JNU3NMTE+nyVABXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750830893; c=relaxed/simple;
	bh=+ThhVDgcKyNgoXR3ceM9CQSqps9gFTNIJ913NB9qqgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/xDu+iMofkQWk1PCv/oTZEl5nbVJeH6GsZfPHLpqsmhZR45LllP3wS9r6tZhY2BOUp6OdMnSmMQ8zLUyVicxH3Vlab2IqEY9+uzO5D3hcYmyhcSJY3PV0QSOljJjAXiZXeHtKgJorumz83/XGoUhVfH6dJO22DRnVWns/5i4R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ljKibZbs; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4BB7A442AB;
	Wed, 25 Jun 2025 05:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1750830882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CMuydz6q12WdBGr/1sWsW0i9wU6BbuOSaXxAZIu2KC8=;
	b=ljKibZbsew/qfRU2KmyqE7wpvi6Uo87YLY2r6QBtklZTCUydAqgM+eBVtAtdLRNWuBx71r
	dEYJoW2dnwJ9ruAkvgHFQhh3ea681N8eesCf5ipEjQYY1SvSZjJp+VOayIu0jXxSDCKFif
	biPSXlT4bw2+/D1FkWxiPwitTYTOaYI/7HPF8VMnGC5sdcn1N76K1K1H4djE2SBfvslYoZ
	jmhftPvC1STO1NE/kjS3u3e5KN1PDxxPHQ2PTjWIYZGYzYSd12Pto8Qu7ydOKmrslmKJSk
	o4E07Gp64BKZ5Jp+wzOaudhVH4xYYPc2HKpb7rSEmQA+ZbRVlELeoIBAu84Jkg==
Date: Wed, 25 Jun 2025 07:54:41 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "Russell King
 (Oracle)" <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Robert Hancock <robert.hancock@calian.com>, Tao Ren <rentao.bupt@gmail.com>
Subject: Re: Supporting SGMII to 100BaseFX SFP modules, with broadcom PHYs
Message-ID: <20250625075441.6036223d@fedora.home>
In-Reply-To: <24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com>
References: <20250624233922.45089b95@fedora.home>
	<24146e10-5e9c-42f5-9bbe-fe69ddb01d95@broadcom.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvudelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejudefjeekudffvdffledvtefhuddtfeelgeekleefieduffdvjeduieduteetkeenucffohhmrghinhepfhhsrdgtohhmnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehflhhorhhirghnrdhfrghinhgvlhhlihessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehvlhgrughimhhirhdrohhlthgvrghnsehngihprdgtohhmpdhrtghpthhtohepkhgrsggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosggvrhhtrdhhrghntghotghksegtrghlihgrnhdrtghomhdprhgtphhtthhopehrvghnthgrohdrsghuphhtsehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Florian,

On Tue, 24 Jun 2025 15:29:25 -0700
Florian Fainelli <florian.fainelli@broadcom.com> wrote:

> Howdy,
>=20
> On 6/24/25 14:39, Maxime Chevallier wrote:
> > Hello everyone,
> >=20
> > I'm reaching out to discuss an issue I've been facing with some SFP mod=
ules
> > that do SGMII to 100FX conversion.
> >=20
> > I'm using that on a product that has 1G-only SFP cage, where SGMII or 1=
000BaseX
> > are the only options, and that product needs to talk to a 100FX link pa=
rtner.
> >=20
> > The only way this can ever work is with a media-converter PHY within th=
e SFP,
> > and apparently such SFP exist :
> >=20
> > https://www.fs.com/fr/products/37770.html?attribute=3D19567&id=3D335755
> >=20
> > I've tried various SFP modules from FS, Prolabs and Phoenix Contact with
> > no luck. All these modules seem to integrate some variant of the
> > Broadcom BCM5641 PHYs.
> >=20
> > I know that netdev@ isn't about fixing my local issues, but in the odd =
chance anyone
> > has ever either used such a module successfully, or has some insight on=
 what is
> > going on with these Broadcom PHYs, I would appreciate a lot :) Any find=
ing or
> > patch we can come-up with will be upstreamed of course :)
> >=20
> > Any people with some experience on this PHY or this kind of module may =
be
> > able to shed some lights on the findings I was able to gather so far.
> >=20
> > All modules have the same internal PHY, which exposes itself as a BCM54=
61 :
> >=20
> > 	ID : 002060c1
> > =09
> > I know that because I was able to talk to the PHY using mdio over i2c, =
at
> > address 0x56 on the i2c bus. On some modules, the PHY doesn't reply at =
all,
> > on some it stalls the i2c bus if I try to do 16bits accesses (I have to=
 use 8 bits
> > accesses), and on some modules the regular 16bits accesses work...
> >=20
> > That alone makes me wonder if there's not some kind of firmware running=
 in
> > there replying to mdio ? =20
>=20
> Unclear, but that ID is correct for the BCM5461 and its variants.
>=20
> >=20
> > Regarding what I can achieve with these, YMMV :
> >=20
> >   - I have a pair of Prolabs module with the ID "CISCO-PROLABS     GLC-=
GE-100FX-C".
> >=20
> >     These are the ones that can only do 8bits mdio accesses. When the P=
HY is
> >     left undriven by the kernel, and you plug it into an SGMII-able SFP=
 port, you
> >     get a nice loop of 'link is up / link is down / link is up / ...' r=
eported
> >     by the MAC (or PCS). Its eeprom doesn't even say that it's a 100fx =
module
> >     (id->base.e100_base_fx isn't set). It does say "Cisco compatible", =
maybe it's
> >     using some flavour of SGMII that I don't know about ?
> >    =20
> >   - I have a pair of FS modules with the ID "FS     SFP-GE-100FX". Thes=
e behave
> >     almost exactly as the ones above, but it can be accessed with 16-bi=
ts mdio
> >     transactions.
> >    =20
> >   - I have a "PHOENIX CONTACT    2891081" that simply doesn't work
> >  =20
> >   - And maybe the most promising of all, a pair of "PROLABS    SFP-GE-1=
00FX-C".
> >     These reply on 16bits mdio accesses, and when you plug them with th=
e PHY
> >     undriven by the kernel (so relying only on internal config and stra=
ps), I
> >     get link-up detected by the MAC through inband SGMII, and I can rec=
eive
> >     traffic ! TX doesn't work though :(
> >=20
> > On the MAC side, I tested with 3 different SoC, all using a different P=
CS :
> >   - A Turris Omnia, that uses mvneta and its PCS
> >   - A dwmac-socfpga board, using a Lynx / Altera TSE PCS to drive the S=
GMII
> >   - A KSZ9477 and its variant of DW XPCS.
> >=20
> > The behaviour is the same on all of them, so I'd say there's a very goo=
d chance
> > the modules are acting up. TBH I don't know much about sourcing SFPs, t=
hey
> > behave so differently that it may just be that I didn't find the exact =
reference
> > that for some reason happens to work ?
> >=20
> > The link-partner is a device that only does 100BaseX.
> >=20
> > On all of these modules, I've tried to either let the PHY completely un=
managed
> > by the kernel, no mdio transactions whatsoever and we leave the default=
 PHY
> > settings to their thing. As nothing worked, I've tried driving the PHY =
through
> > the kernel's broadcom.c driver, but that driver really doesn't support =
100FX so
> > it's also expected that this doesn't work. Unfortunately, I don't have
> > access to any documentation for that PHY...
> >=20
> > The driver does say, for a similar model :
> >=20
> > 	/* The PHY is strapped in RGMII-fiber mode when INTERF_SEL[1:0]
> > 	 * is 01b, and the link between PHY and its link partner can be
> > 	 * either 1000Base-X or 100Base-FX.
> > 	 * RGMII-1000Base-X is properly supported, but RGMII-100Base-FX
> > 	 * support is still missing as of now.
> > 	 */
> >=20
> > Not quite the same as our case as it's talking about RGMII, not SGMII, =
but
> > maybe the people who wrote that code know a bit more or have access to =
some
> > documentation ? I've tried to put these persons in CC :) =20
>=20
> Not sure if you can probe the various pins, but those that would be=20
> interesting to measure would be:
>=20
> LNKSPD[1] / INTF_SEL[0]
> LNKSPD[2] / INTF_SEL[1]
> RGMIIEN
> EN_10B/SD
>=20
> You can forcibly enable RGMII operation by writing to register 0x18,=20
> shadow 0b111 (MII_BCM54XX_AUXCTL_SHDWSEL_MISC) and setting bit 7=20
> (MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN).
>=20
>  > > In any case, should anyone want to give this a shot in the future,  =
=20
> I'm using the
> > following patch so that the SFP machinery can try to probe PHYs on these
> > non-copper modules - that patch needs splitting up and is more of a hac=
k than
> > anything else.
> >=20
> > Thanks a lot everyone, and sorry for the noise if this is misplaced, =20
>=20
> For 100BaseFX, the signal detection is configured in bit 5 of the shadow=
=20
> 0b01100 in the 0x1C register. You can use bcm_{read,write}_shadow() for=20
> that:
>=20
> 0 to use EN_10B/SD as CMOS/TTL signal detect (default)
> 1 to use SD_100FX=C2=B1 as PECL signal detect
>=20
> You can use either copper or SGMII interface for 100BaseFX and that will=
=20
> be configured this way:
>=20
> - in register 0x1C, shadow 0b10 (1000Base-T/100Base-TX/10Base-T Spare=20
> Control 1), set bit 4 to 1 to enable 100BaseFX
>=20
> - disable auto-negotiation with register 0x00 =3D 0x2100
>=20
> - set register 0x18 to 0x430 (bit 10 -> normal mode, bits 5:4 control=20
> the edge rate. 0b00 -> 4ns, 0b01 -> 5ns, 0b10 -> 3ns, 0b11 -> 0ns. This=20
> is the auxiliary control register (MII_BCM54XX_AUXCTL_SHDWSEL_AUXCTL).
>=20
> It's unclear from the datasheet whether 100BaseFX can work with RGMII.

Thank you so much ! I'm trying to achieve SGMII to 100FX, so I'll give
your instructions a try :) Thanks again for the quick answer, I'll let
you know how this goes,

Maxime

