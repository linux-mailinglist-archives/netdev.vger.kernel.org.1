Return-Path: <netdev+bounces-168934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB81A41950
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 10:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E1B3A50C5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA51B041E;
	Mon, 24 Feb 2025 09:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SIFP+mS5"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83D12CDBE;
	Mon, 24 Feb 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389907; cv=none; b=FH6psJFm3s6VZwdS6z2UxBsI9KIcPQzzte85rCqjLSnlkzKAO0yGo2FTjVGy37CJxguByDHLrinSR8XEWrui5QMxGFUWRXx9owPH2VitV70qY0RRzyREjziz9XKfZ+TS0Ug5rxWhPbuWPwYS8VUEaMhAobX9osVfAAs4r/Pnzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389907; c=relaxed/simple;
	bh=Y45OZf5AEVqbMLHC2vetp5A95pNeIRg/N3EqYrtFEj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKs40XrH1wdLUZ4qstn2WIJwUlumXiTqUUd1q///a3Bv+oYHObo9nikZ7VPz1VdhrXV8xkJvL7i3B38eAGEJTfytwsTs3GkkrWupmFK0BXctr/2KXj3maV7fwWQUX2heBgu81Cks0RzE+AQzj1/2YUvy3ljb5nC4zccAgUz9DJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SIFP+mS5; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DC571F764;
	Mon, 24 Feb 2025 09:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740389897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8U5EMMWlFDym6d2qg1LTT9H9US9Iiqf+zo1LbUZs+SQ=;
	b=SIFP+mS5sChUesjRmTYG6lyyKcqt01GNDyNN6oB3oI+9J9I7EykFplii+zPokEJVKrb+Fv
	ECI+OoafKYZhwK4dcpBpThrzdJyHTkUnsw7VKeLBb1ZUctViSrhI/eB5YvhDJuXEZl5VI4
	+q0IyvzuqaLQrKn0TH8IMLM5ON66QyUKEohR6MFpgQgKStc7vIU5g5I4klVHW44JFxU4QF
	QIoHHqI1aONLT4S/SLbEStHAAuiZHk+LI913EYDXT61Aq3zwgiDsXAcyyLhK/W/Dvg0OA6
	Ucz2FC+jFWZzbNXuWqiQf4W8mDqPGtYuYFa9vB1D42RJW1QbcqcYn9XZ3VYT5w==
Date: Mon, 24 Feb 2025 10:38:14 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: =?UTF-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Florian
 Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Simon Horman <horms@kernel.org>, Romain
 Gantois <romain.gantois@bootlin.com>, Antoine Tenart <atenart@kernel.org>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: phy: sfp: Add single-byte SMBus SFP
 access
Message-ID: <20250224103814.7d60bfbd@fedora>
In-Reply-To: <87r03otsmm.fsf@miraculix.mork.no>
References: <20250223172848.1098621-1-maxime.chevallier@bootlin.com>
	<87r03otsmm.fsf@miraculix.mork.no>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeegfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeftddujeeliefhkeegkeehueekkeeivdejjeevtefhffduuddujeevueeihfehgeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepsghjohhrnhesmhhorhhkrdhnohdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesg
 hhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Bj=C3=B8rn,

On Sun, 23 Feb 2025 19:37:05 +0100
Bj=C3=B8rn Mork <bjorn@mork.no> wrote:

> Maxime Chevallier <maxime.chevallier@bootlin.com> writes:
>=20
> > Hi everyone,
> >
> > Some PHYs such as the VSC8552 have embedded "Two-wire Interfaces" desig=
ned to
> > access SFP modules downstream. These controllers are actually SMBus con=
trollers
> > that can only perform single-byte accesses for read and write.
> >
> > This series adds support for accessing SFP modules through single-byte =
SMBus,
> > which could be relevant for other setups.
> >
> > The first patch deals with the SFP module access by itself, for address=
es 0x50
> > and 0x51.
> >
> > The second patch allows accessing embedded PHYs within the module with =
single-byte
> > SMBus, adding this in the mdio-i2c driver.
> >
> > As raw i2c transfers are always more efficient, we make sure that the s=
mbus accesses
> > are only used if we really have no other choices.
> >
> > This has been tested with the following modules (as reported upon modul=
e insertion)
> >
> > Fiber modules :
> >
> > 	UBNT             UF-MM-1G         rev      sn FT20051201212    dc 2005=
12
> > 	PROLABS          SFP-1GSXLC-T-C   rev A1   sn PR2109CA1080     dc 2206=
07
> > 	CISCOSOLIDOPTICS CWDM-SFP-1490    rev 1.0  sn SOSC49U0891      dc 1810=
08
> > 	CISCOSOLIDOPTICS CWDM-SFP-1470    rev 1.0  sn SOSC47U1175      dc 1906=
20
> > 	OEM              SFP-10G-SR       rev 02   sn CSSSRIC3174      dc 1812=
01
> > 	FINISAR CORP.    FTLF1217P2BTL-HA rev A    sn PA3A0L6          dc 2307=
16
> > 	OEM              ES8512-3LCD05    rev 10   sn ESC22SX296055    dc 2207=
22
> > 	SOURCEPHOTONICS  SPP10ESRCDFF     rev 10   sn E8G2017450       dc 1407=
15
> > 	CXR              SFP-STM1-MM-850  rev 0000 sn K719017031       dc 2007=
20
> >
> >  Copper modules
> >
> > 	OEM              SFT-7000-RJ45-AL rev 11.0 sn EB1902240862     dc 1903=
13
> > 	FINISAR CORP.    FCLF8521P2BTL    rev A    sn P1KBAPD          dc 1905=
08
> > 	CHAMPION ONE     1000SFPT         rev -    sn     GBC59750     dc 1911=
0401
> >
> > DAC :
> >
> > 	OEM              SFP-H10GB-CU1M   rev R    sn CSC200803140115  dc 2008=
27
> >
> > In all cases, read/write operations happened without errors, and the in=
ternal
> > PHY (if any) was always properly detected and accessible
> >
> > I haven't tested with any RollBall SFPs though, as I don't have any, an=
d I don't
> > have Copper modules with anything else than a Marvell 88e1111 inside. T=
he support
> > for the VSC8552 SMBus may follow at some point.
> >
> > Thanks,
> >
> > Maxime
> >
> > Maxime Chevallier (2):
> >   net: phy: sfp: Add support for SMBus module access
> >   net: mdio: mdio-i2c: Add support for single-byte SMBus operations
> >
> >  drivers/net/mdio/mdio-i2c.c | 79 ++++++++++++++++++++++++++++++++++++-
> >  drivers/net/phy/sfp.c       | 65 +++++++++++++++++++++++++++---
> >  2 files changed, 138 insertions(+), 6 deletions(-) =20
>=20
> Nice!  Don't know if you're aware, but OpenWrt have had patches for
> SMBus access to SFPs for some time:
>=20
> https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/patches=
-6.6/714-net-phy-sfp-add-support-for-SMBus.patch
> https://github.com/openwrt/openwrt/blob/main/target/linux/realtek/patches=
-6.6/712-net-phy-add-an-MDIO-SMBus-library.patch
>=20
> The reason they carry these is that they support Realtek rtl930x based
> switches.  The rtl930x SoCs include an 8 channel SMBus host which is
> typically connected to any SFP+ slots on the switch.
>=20
> There has been work going on for a while to bring the support for these
> SoCs to mainline, and the SMBus host driver is already here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/drivers/i2c/busses/i2c-rtl9300.c?id=3Dc366be720235301fdadf67e6f1ea6ff32669=
c074
>=20
> I assume DSA and ethernet eventually will follow, making SMBus SFP
> support necessary for this platform too.
>=20
> So thanks for doing this!

Good to know this is useful to you ! So there's at least 2 different
classes of products out there with SMBus that advertise that it's
"designed for SFP" ._.

> FWIW, I don't think the OpenWrt mdio patch works at all.  I've recently
> been playing with an 8 SFP+ port switch based on rtl9303, and have tried
> to fixup both the clause 22 support and add RollBall and clause 45.
> This is still a somewhat untested hack, and I was not planning on
> presenting it here as such, but since this discussion is open:
> https://github.com/openwrt/openwrt/pull/17950/commits/c40387104af62a06579=
7bc3e23dfb9f36e03851b
>=20
> Sorry for the format.  This is a patch for the patch already present in
> OpenWrt. Let me know if you want me to post the complete patched
> mdio-smbus.c for easier reading.
>=20
> The main point I wanted to make is that we also need RollBall and clause
> 45 over SMBus.  Maybe not today, but at some point.  Ideally, the code
> should be shared with the i2c implementation, but I found that very hard
> to do as it is.

I don't have anything to test that, and yeah that can be considered as
a second step, however I don't even know if this can work at all with
single byte accesses :(

Thanks,

Maxime

