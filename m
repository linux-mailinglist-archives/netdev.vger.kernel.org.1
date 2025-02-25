Return-Path: <netdev+bounces-169378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C398BA439DC
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630857AAF51
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A4B26138C;
	Tue, 25 Feb 2025 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HK3/pkvQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97F2770B;
	Tue, 25 Feb 2025 09:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476298; cv=none; b=oA6g9XO1E9MxYJ7Aw2xZ+8Cyhkvo1hfNvI4d3XDNAvC2G7DmJg+hiDLpT0CjD/0yGvqZpLJH9HhkJtoKZPo9g4CnpB1Jj07KSLapoxLAaLuADrb4ymh3yrlKI8XF9XibN6XNt4K5PQCqTn7PzNLpJTOYxge60dSZPFL71RZGNUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476298; c=relaxed/simple;
	bh=KOoru/UvM5K/f5JN6eTxK6IWzYJgPBeHvrjFH+jOpOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ3ielaSXMjcvRurahYJSDRdhf8huglCqrzDds9H4trIE7ec73BTBZSexmTA92YsxBOwHkss7cxxsguMsxXLA68HBwdO2NPoNk1ckt8WE3yP1uw5J2+/cE9T7aA/CxsK5B5TYiHLKz7hlMTu8RfylYPSix/IzWHUP8Rjo5ByHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HK3/pkvQ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 600024427A;
	Tue, 25 Feb 2025 09:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740476294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cLaYPj5f0Xs15lU0/MmHpF+ePqgHzxkdSGZO99S/riM=;
	b=HK3/pkvQCXh4EvM47VppHUM/fN4OOUDgSH+BCI6umBBl56Ie70o5ZIDCn9Rex1VLBbd6Nv
	aoAqxO9BftN/DDMajrXpOUv+vyJJ/fL19pknSOBOii4OmICT/jd717uJbTHcjGi+dmKVX8
	avMvare7yTcSS4pUbXMCPTmSAg78uAYE1sjgVGfwav8dtKHBBC3pnTA7ApxZvitUSKjBi/
	ugjHCT2i4pIvhySxk5d+aEydQgt7StUt+7V7zYwfmD+VsOeF/2Ztw735gsc0feXnPwTWFP
	LcfzK4U1P+Jkdx0JxQpy3TB6bhUZr8fYFEuX7iXSwsV1OSwHHrWYbEJG68wfAw==
Date: Tue, 25 Feb 2025 10:38:12 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/7] net: phy: aquantia: add essential
 functions to aqr105 driver
Message-ID: <20250225103812.7e436d17@fedora.home>
In-Reply-To: <d944c0bd-a652-4bfe-b6e8-c264f5b36562@gmx.net>
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
	<20250222-tn9510-v3a-v5-4-99365047e309@gmx.net>
	<20250223113232.3092a990@fedora.home>
	<d944c0bd-a652-4bfe-b6e8-c264f5b36562@gmx.net>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekudefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopehhfhguvghvvghlsehgmhigrdhnvghtpdhrtghpthhtohepuggvvhhnuhhllhdohhhfuggvvhgvlhdrghhmgidrnhgvtheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnn
 hdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Sun, 23 Feb 2025 23:26:49 +0100
Hans-Frieder Vogt <hfdevel@gmx.net> wrote:

> Hi Maxime,
>=20
> On 23.02.2025 11.32, Maxime Chevallier wrote:
> > Hi,
> >
> > On Sat, 22 Feb 2025 10:49:31 +0100
> > Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
> > wrote:
> > =20
> >> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> >>
> >> This patch makes functions that were provided for aqr107 applicable to
> >> aqr105, or replaces generic functions with specific ones. Since the aq=
r105
> >> was introduced before NBASE-T was defined (or 802.3bz), there are a nu=
mber
> >> of vendor specific registers involved in the definition of the
> >> advertisement, in auto-negotiation and in the setting of the speed. The
> >> functions have been written following the downstream driver for TN4010
> >> cards with aqr105 PHY, and use code from aqr107 functions wherever it
> >> seemed to make sense.
> >>
> >> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> >> ---
> >>   drivers/net/phy/aquantia/aquantia_main.c | 242 +++++++++++++++++++++=
+++++++++-
> >>   1 file changed, 240 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/ph=
y/aquantia/aquantia_main.c
> >> index 86b0e63de5d88fa1050919a8826bdbec4bbcf8ba..38c6cf7814da1fb9a4e715=
f242249eee15a3cc85 100644
> >> --- a/drivers/net/phy/aquantia/aquantia_main.c
> >> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> >> @@ -33,6 +33,9 @@
> >>   #define PHY_ID_AQR115C	0x31c31c33
> >>   #define PHY_ID_AQR813	0x31c31cb2
> >>
> >> +#define MDIO_AN_10GBT_CTRL_ADV_LTIM		BIT(0) =20
> > This is a standard C45 definition, from :
> > 45.2.7.10.15 10GBASE-T LD loop timing ability (7.32.0)
> >
> > So if you need this advertising capability, you should add that in the
> > generic definitions for C45 registers in include/uapi/linux/mdio.h =20
> Thanks. Wasn't aware this being a standard definition.
>=20
> Wouldn't the definition
> #define ADVERTISE_XNP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(12)
> then need to go to include/uapi/linux/mii.h accordingly?

Looks like this is indeed part of the standard now, in=20

28.2.4.1.3 Auto-Negotiation advertisement register (Register 4), so it seems
to be the right move to modify ADVERTISE_RESV into  ADVERTISE_XNP.

> There, bit 12 is currently named ADVERTISE_RESV and commented as unused
> (which it obviously is not, because it is used in
> drivers/net/ethernet/sfc/falcon/mdio_10g.c

One note is that this driver uses the C45 MMD 7 AN register layout :

45.2.7.1 AN control register (Register 7.0)

in which the eXtended Next Page bit is BIT(13).

That actually leads to an interesting point, as it appears the at803x.c
driver mixes both, which looks incorrect to me :

	/* Ar803x extended next page bit is enabled by default. Cisco
	 * multigig switches read this bit and attempt to negotiate 10Gbps
	 * rates even if the next page bit is disabled. This is incorrect
	 * behaviour but we still need to accommodate it. XNP is only needed
	 * for 10Gbps support, so disable XNP.
	 */
	return phy_modify(phydev, MII_ADVERTISE, MDIO_AN_CTRL1_XNP, 0);

In such case, BIT(13) fot MII_ADVERTISE is ADVERTISE_RFAULT, if my
understanding of the spec is correct.

> I think, for now, I will just do the same as in the falcon driver and
> use ADVERTISE_RESV instead. Then it may be renamed later in all places.

Make sure you use the BIT(12) in your case indeed, looks to be the
right way in that case.=20

> >
> > That being said, as it looks this is the first driver using this
> > feature, do you actually need to advertise Loop Timing ability here ?
> > I guess it comes from the vendor driver ? =20
> you are right. The code just tries to replicate the vendor code.
> However, I have now tested the driver without this flag and haven't
> noticed any unusual behavior. So, I guess, it works indeed without.
> I'll remove the flag in the next revision of the patch.

So in that case, no need to define MDIO_AN_10GBT_CTRL_ADV_LTIM at all :)

Thanks,

Maxime


