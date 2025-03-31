Return-Path: <netdev+bounces-178254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99EAA75F4F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 09:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C69321889A2E
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 07:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436271C173C;
	Mon, 31 Mar 2025 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UD/4i0Ln"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063F61ADC7E;
	Mon, 31 Mar 2025 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743405304; cv=none; b=IqD3wXptnPNNYQXDgNH1F8gazotUfPX72lRmV6nya44GWqcDPSYTTzKziy5AOEAx6rvXActaeSNsp+XVMGeimzTz4mee4H1kWYHCDBgdPPlY4jtf/bExUc69Hw10T5WCuB2R6+A1mVYitU0x9BwYn0tTjKXPDjQRVMQCcc7iQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743405304; c=relaxed/simple;
	bh=Uo1xgeKoghCRWciMAGS2ED/77cFbbntvFOPvN5syNTU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ML+FUZl6CWAHJTeUbWGEqoN8Qx4VDbPcOb+vdB9NLW6vyQX0P0FL9hXpyxz6aB30gykkEDJhQRI7veHGRsYxC7NgcmBroxyw90Odv3bUW5IMvxiMhTgCAcdkTY4OOKH3wq7u2oIMbSm5al/98Q0U6MwJCYxSfKqC069x7eZOmQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UD/4i0Ln; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D5114433B;
	Mon, 31 Mar 2025 07:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743405292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRcbNpu8rD3LzgYT+z7vt6zQHONi+6JPiM+Bm4o7eMU=;
	b=UD/4i0LnyvYuXKD53LWq7//hkJEB9C/g3N6wfBGbEhVNnFXOvBtrjk2li/ub90l47Qb/bj
	C0Y6p2YaSyM4feqFTRzl+6XC+PtmXnjbXqdjRZrR97l39R8c9VAc+Gh89L1Ya58Ug2BUnw
	G+JiM/FAbv4/v6m38XvMsN3dPmuqz5BCDvjV4qAsbQPrmsp0dTKN1+zgqezSSD+yyE0JBm
	5z0/kGbahyI/mLXXFl6dimPtyzPDd2eLczgBab/lVxs9/nSdpVZxmhIm3AAg3sqSZK9g2K
	kQDArgMArfeJu2XAWOCZH3jXx+i2RAhmKMjU5WVB7jVJH6OVLMQxsf+I8ylW8g==
Date: Mon, 31 Mar 2025 09:14:49 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <20250331091449.155e14a4@fedora-2.home>
In-Reply-To: <CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	<20250307173611.129125-10-maxime.chevallier@bootlin.com>
	<8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
	<20250328090621.2d0b3665@fedora-2.home>
	<CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepkeehgeeijeekteffhfelheetffeghfffhfeufeeifeffjeeftefhveduteduueeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrqddvrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegrlhgvgigrnhguvghrrdguuhihtghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdpr
 hgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 28 Mar 2025 14:03:54 -0700
Alexander Duyck <alexander.duyck@gmail.com> wrote:

> On Fri, Mar 28, 2025 at 1:06=E2=80=AFAM Maxime Chevallier
> <maxime.chevallier@bootlin.com> wrote:
> >
> > On Thu, 27 Mar 2025 18:16:00 -0700
> > Alexander H Duyck <alexander.duyck@gmail.com> wrote:
> > =20
> > > On Fri, 2025-03-07 at 18:36 +0100, Maxime Chevallier wrote: =20
> > > > When phylink creates a fixed-link configuration, it finds a matching
> > > > linkmode to set as the advertised, lp_advertising and supported mod=
es
> > > > based on the speed and duplex of the fixed link.
> > > >
> > > > Use the newly introduced phy_caps_lookup to get these modes instead=
 of
> > > > phy_lookup_settings(). This has the side effect that the matched
> > > > settings and configured linkmodes may now contain several linkmodes=
 (the
> > > > intersection of supported linkmodes from the phylink settings and t=
he
> > > > linkmodes that match speed/duplex) instead of the one from
> > > > phy_lookup_settings().
> > > >
> > > > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > > > ---
> > > >  drivers/net/phy/phylink.c | 44 +++++++++++++++++++++++++++--------=
----
> > > >  1 file changed, 31 insertions(+), 13 deletions(-)
> > > >
> > > > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > > > index cf9f019382ad..8e2b7d647a92 100644
> > > > --- a/drivers/net/phy/phylink.c
> > > > +++ b/drivers/net/phy/phylink.c
> > > > @@ -802,12 +802,26 @@ static int phylink_validate(struct phylink *p=
l, unsigned long *supported,
> > > >     return phylink_validate_mac_and_pcs(pl, supported, state);
> > > >  }
> > > >
> > > > +static void phylink_fill_fixedlink_supported(unsigned long *suppor=
ted)
> > > > +{
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported=
);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported=
);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supporte=
d);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supporte=
d);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supporte=
d);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supporte=
d);
> > > > +   linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, support=
ed);
> > > > +}
> > > > + =20
> > >
> > > Any chance we can go with a different route here than just locking
> > > fixed mode to being only for BaseT configurations?
> > >
> > > I am currently working on getting the fbnic driver up and running and=
 I
> > > am using fixed-link mode as a crutch until I can finish up enabling
> > > QSFP module support for phylink and this just knocked out the support=
ed
> > > link modes as I was using 25CR, 50CR, 50CR2, and 100CR2.
> > >
> > > Seems like this should really be something handled by some sort of
> > > validation function rather than just forcing all devices using fixed
> > > link to assume that they are BaseT. I know in our direct attached
> > > copper case we aren't running autoneg so that plan was to use fixed
> > > link until we can add more flexibility by getting QSFP support going.=
 =20
> >
> > These baseT mode were for compatibility with the previous way to deal
> > with fixed links, but we can extend what's being report above 10G with
> > other modes. Indeed the above code unnecessarily restricts the
> > linkmodes. Can you tell me if the following patch works for you ?
> >
> > Maxime
> >
> > -----------
> >
> > From 595888afb23f209f2b1002d0b0406380195d53c1 Mon Sep 17 00:00:00 2001
> > From: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > Date: Fri, 28 Mar 2025 08:53:00 +0100
> > Subject: [PATCH] net: phylink: Allow fixed-link registration above 10G
> >
> > The blamed commit introduced a helper to keep the linkmodes reported by
> > fixed links identical to what they were before phy_caps. This means
> > filtering linkmodes only to report BaseT modes.
> >
> > Doing so, it also filtered out any linkmode above 10G. Reinstate the
> > reporting of linkmodes above 10G, where we report any linkmodes that
> > exist at these speeds.
> >
> > Reported-by: Alexander H Duyck <alexander.duyck@gmail.com>
> > Closes: https://lore.kernel.org/netdev/8d3a9c9bb76b1c6bc27d2bd01f4831b2=
cac83f7f.camel@gmail.com/
> > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link =
configuration")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  drivers/net/phy/phylink.c | 17 +++++++++++++----
> >  1 file changed, 13 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 69ca765485db..de90fed9c207 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -715,16 +715,25 @@ static int phylink_parse_fixedlink(struct phylink=
 *pl,
> >                 phylink_warn(pl, "fixed link specifies half duplex for =
%dMbps link?\n",
> >                              pl->link_config.speed);
> >
> > -       linkmode_zero(pl->supported);
> > -       phylink_fill_fixedlink_supported(pl->supported);
> > +       linkmode_fill(pl->supported);
> >
> >         linkmode_copy(pl->link_config.advertising, pl->supported);
> >         phylink_validate(pl, pl->supported, &pl->link_config);
> >
> > +       phylink_fill_fixedlink_supported(match);
> > + =20
>=20
> I worry that this might put you back into the same problem again with
> the older drivers. In addition it is filling in modes that shouldn't
> be present after the validation.

Note that I'm not directly filling pl->supported here.

[...]

 	c =3D phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
 			    pl->supported, true);
-	if (c)
-		linkmode_and(match, pl->supported, c->linkmodes);
+	if (c) {
+		/* Compatbility with the legacy behaviour : Report one single
+		 * BaseT mode for fixed-link speeds under or at 10G, or all
+		 * linkmodes at the speed/duplex for speeds over 10G
+		 */
+		if (linkmode_intersects(match, c->linkmodes))
+			linkmode_and(match, match, c->linkmodes);
+		else
+			linkmode_copy(match, c->linkmodes);
+	}

[...]

	if (c) {
		linkmode_or(pl->supported, pl->supported, match);
		linkmode_or(pl->link_config.lp_advertising,
			    pl->link_config.lp_advertising, match);
	}

For speeds above 10G, you will get all the modes for the requested
speed, so it should solve the issue in the next steps of your code
where you need matching linkmodes for your settings ? Did you give it a
try ?

You may end up with too many linkmodes, but for fixed-link we don't
really expect these modes to precisely represent any real linkmodes

> One thought on this. You might look at checking to see if the TP bit
> is set in the supported modes after validation and then use your
> fixedlink_supported as a mask if it is supporting twisted pair
> connections.

But the TP bit doesn't really mean much here, at least as of today.
What matters at that point really is the supported phy_interface_t and
your requested speed/duplex

> One possibility would be to go through and filter the
> modes based on the media type where you could basically filter out TP,
> Fiber, and Backplane connection types and use that as a second pass
> based on the settings by basically doing a set of AND and OR
> operations.

At that point, the linkmodes aren't very relevant, even if you look at
the old version of that same function, the linkmodes are built only
based on speed/duplex and do not represent any physical mode.

The media-specific filtering will come in a next series, I sent a few
iterations in last cycle to be able to filter out based on medium, I'll
CC you for the next round

> Also I am not sure it makes sense to say we can't support multiple
> modes on a fixed connection. For example in the case of SerDes links
> and the like it isn't unusual to see support for CR/KR advertised at
> the same speed on the same link and use the exact same configuration
> so a fixed config could support both and advertise both at the same
> time if I am not mistaken.

The use-cases for fixed links have mostly been about describing a link
that we know exists, but can't really control or query. In that case,
we don't even know what's the physical medium so we report pretty much
bogus values (as Andrew says, that used to be done by emulating a
copper PHY). As use-cases are evolving, I think we can consider indeed
a better coverage of your use-case :)

Maxime

