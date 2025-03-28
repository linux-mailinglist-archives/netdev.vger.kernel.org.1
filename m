Return-Path: <netdev+bounces-178065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB56A744FD
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D505189C809
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 08:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3424212B2D;
	Fri, 28 Mar 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N092Qp7O"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC18C14885B;
	Fri, 28 Mar 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743149201; cv=none; b=TSrBNIRIXB8hA1xZ6nQvwY5PPJt6WFm0Qarss3Dii4zgyJp2f36Kv3VKejAIeZG1ocr/r6bipdob/oHTkjBYvUp62iYX+9+etRRw6ckubhy8Ty5uV23h68hexm2w/7FtRPJgQKd/vAle61hQ7zw5/o6aPBH6Wl9QAV0SbHRDWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743149201; c=relaxed/simple;
	bh=inIinvMRcoxSU5jkQ4C6yhA2C5QhP0fLo1Xh4gg2+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgyPCbloDdiRi1hb+CZyTp+Vx6EdaHXq6ZsUcWpQ/gVA7NOAdmSEZvKpdQNrKTkfoidMBBRe1NrCYGmpcqEH2fYVHA17jjPrQQzdvojPfpdab0gBIWFAAZ6ORS8J4Z9aDIce2Ntc6a6Y/gut8E+TRZ26W6hzH6vMbF5735KZLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N092Qp7O; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2FFF4434A;
	Fri, 28 Mar 2025 08:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743149191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txpxsTy5Igy4BZd7LQw51gIz0+Sc/EV673tLlRbxdo0=;
	b=N092Qp7O4xu0C0LC9Jld0qwLeROPEa2bmbHa5rx+7UryRNUCT3x0EbFCiiWUWjRguxk6bB
	mk5ZtVAtYtX97CjiRg3dkVV4YPzvVEpfg3s6RuvDbBbyi7EThmLtS8fwI66Suwlaciq4v4
	Rf5krwbNXkTmZYMJ7T0t9iWAPu+oYN2jjP7XWMYgPNm4BSi9QSsNkhuz1x4FyBogit97es
	W72asT8vzmkMmAk7JAXCvNR8IV2i+d2x6sW/Nm3I9waCp8fsWg5YR8x8iMiLD/HTNIPxbf
	nkPnXDB1e6ODDgjV81XDs3Ui/33W81KOClPg8T5JShIJvqKJASv5fz4JworyEg==
Date: Fri, 28 Mar 2025 09:06:21 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Alexander H Duyck <alexander.duyck@gmail.com>
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
Message-ID: <20250328090621.2d0b3665@fedora-2.home>
In-Reply-To: <8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	<20250307173611.129125-10-maxime.chevallier@bootlin.com>
	<8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeeifeevjeevfeeujeeuieeftdehieejkedukeffhfehhedvieeugeejvefhffeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrqddvrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegrlhgvgigrnhguvghrrdguuhihtghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdpr
 hgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 27 Mar 2025 18:16:00 -0700
Alexander H Duyck <alexander.duyck@gmail.com> wrote:

> On Fri, 2025-03-07 at 18:36 +0100, Maxime Chevallier wrote:
> > When phylink creates a fixed-link configuration, it finds a matching
> > linkmode to set as the advertised, lp_advertising and supported modes
> > based on the speed and duplex of the fixed link.
> >=20
> > Use the newly introduced phy_caps_lookup to get these modes instead of
> > phy_lookup_settings(). This has the side effect that the matched
> > settings and configured linkmodes may now contain several linkmodes (the
> > intersection of supported linkmodes from the phylink settings and the
> > linkmodes that match speed/duplex) instead of the one from
> > phy_lookup_settings().
> >=20
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  drivers/net/phy/phylink.c | 44 +++++++++++++++++++++++++++------------
> >  1 file changed, 31 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index cf9f019382ad..8e2b7d647a92 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -802,12 +802,26 @@ static int phylink_validate(struct phylink *pl, u=
nsigned long *supported,
> >  	return phylink_validate_mac_and_pcs(pl, supported, state);
> >  }
> > =20
> > +static void phylink_fill_fixedlink_supported(unsigned long *supported)
> > +{
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, supported);
> > +}
> > + =20
>=20
> Any chance we can go with a different route here than just locking
> fixed mode to being only for BaseT configurations?
>=20
> I am currently working on getting the fbnic driver up and running and I
> am using fixed-link mode as a crutch until I can finish up enabling
> QSFP module support for phylink and this just knocked out the supported
> link modes as I was using 25CR, 50CR, 50CR2, and 100CR2.
>=20
> Seems like this should really be something handled by some sort of
> validation function rather than just forcing all devices using fixed
> link to assume that they are BaseT. I know in our direct attached
> copper case we aren't running autoneg so that plan was to use fixed
> link until we can add more flexibility by getting QSFP support going.

These baseT mode were for compatibility with the previous way to deal
with fixed links, but we can extend what's being report above 10G with
other modes. Indeed the above code unnecessarily restricts the
linkmodes. Can you tell me if the following patch works for you ?

Maxime

-----------

=46rom 595888afb23f209f2b1002d0b0406380195d53c1 Mon Sep 17 00:00:00 2001
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Fri, 28 Mar 2025 08:53:00 +0100
Subject: [PATCH] net: phylink: Allow fixed-link registration above 10G

The blamed commit introduced a helper to keep the linkmodes reported by
fixed links identical to what they were before phy_caps. This means
filtering linkmodes only to report BaseT modes.

Doing so, it also filtered out any linkmode above 10G. Reinstate the
reporting of linkmodes above 10G, where we report any linkmodes that
exist at these speeds.

Reported-by: Alexander H Duyck <alexander.duyck@gmail.com>
Closes: https://lore.kernel.org/netdev/8d3a9c9bb76b1c6bc27d2bd01f4831b2cac8=
3f7f.camel@gmail.com/
Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link conf=
iguration")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 69ca765485db..de90fed9c207 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -715,16 +715,25 @@ static int phylink_parse_fixedlink(struct phylink *pl,
 		phylink_warn(pl, "fixed link specifies half duplex for %dMbps link?\n",
 			     pl->link_config.speed);
=20
-	linkmode_zero(pl->supported);
-	phylink_fill_fixedlink_supported(pl->supported);
+	linkmode_fill(pl->supported);
=20
 	linkmode_copy(pl->link_config.advertising, pl->supported);
 	phylink_validate(pl, pl->supported, &pl->link_config);
=20
+	phylink_fill_fixedlink_supported(match);
+
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
=20
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
 	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
--=20
2.48.1


