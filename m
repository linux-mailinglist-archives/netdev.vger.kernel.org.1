Return-Path: <netdev+bounces-194328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F26AC898A
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 09:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53153B722E
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 07:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFA7213254;
	Fri, 30 May 2025 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="j5BdfYpA"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE7D211A27;
	Fri, 30 May 2025 07:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748591776; cv=none; b=F4dNr987xGbAXxI3HR9181OgimYNlWGANycsWYVt9H3Ps2eZSp89lmkvhn7MNgAHT9US4ZsT16or6SrWxyi3MCRN6QBa5n9cBW9Iavp8uhBk6r2fL4A0yvKs2HIAE+6xwxiZKw2oPz4L5lSc5Z6zNQIlHup89Ojk1CXyUIlf3JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748591776; c=relaxed/simple;
	bh=9/2s7jrItrKe9BHQE86oFTYHuG14i7s/xK/dqV+ulu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gx6ir1RAtnqFpNws+xsVCU4VOWIARBut6gYMGIGyXt4sDGBw93GMLlkb1t6OELsXWfh4IGKmlZ5VogX9mvQNnKsDAM0VixoTIVl3GzGtbBFF+lXba0sd0Txc7zUjvXjZ+DVsIuNYqwZYqySsKY08BeoNoGsQrvxb2DDtekBRTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=j5BdfYpA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4383543A63;
	Fri, 30 May 2025 07:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1748591770;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d5uXLy3aVascoGW7+x+sYRkxemKiyBvlPpkaZTuHscc=;
	b=j5BdfYpAd3WxUunXRmpE2ibM9G+KVDDhSfYDrSD1+PDUyzarJgvym3lOUXc72O4YUFn6hc
	xtiF6q4PRjWDB4Ynzs5ip4KMmRnhYdWNJfqKcpglpe4CiCwTgndCnAFRO7b2gTl2unPo+f
	bUqgleDvtC492VcnYkRX15i7xRzTNRoXi+JhRBpALr9TfOM9+n6euiYdParj1gbWj91gbi
	51ZCpLIqtSjDSdBsmGlnLxdhcrd3PfQfqrJKwziiui2JNdbfJtxTV+ch/7RGBSB2yHbbof
	aOvr3GZVFPMWbkQLJ6BqlCP9NpgrgBvw8vrsdUAnr2vPGEdaTBEmP3MUuW9pmg==
Date: Fri, 30 May 2025 09:56:08 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <thomas.petazzoni@bootlin.com>,
 <linux-arm-kernel@lists.infradead.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, "shenjian15@huawei.com"
 <shenjian15@huawei.com>
Subject: Re: [PATCH net-next v5 07/13] net: phy: phy_caps: Allow looking-up
 link caps based on speed and duplex
Message-ID: <20250530095608.63c42399@fedora.home>
In-Reply-To: <5bbf1201-e803-40ea-a081-c25919f5e89d@huawei.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	<20250307173611.129125-8-maxime.chevallier@bootlin.com>
	<5bbf1201-e803-40ea-a081-c25919f5e89d@huawei.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeegieculddtuddrgeefvddrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopehshhgrohhjihhjihgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehlu
 hhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 29 May 2025 17:36:11 +0800
Jijie Shao <shaojijie@huawei.com> wrote:

> on 2025/3/8 1:36, Maxime Chevallier wrote:
> > As the link_caps array is efficient for <speed,duplex> lookups,
> > implement a function for speed/duplex lookups that matches a given
> > mask. This replicates to some extent the phy_lookup_settings()
> > behaviour, matching full link_capabilities instead of a single linkmode.
> >
> > phy.c's phy_santize_settings() and phylink's
> > phylink_ethtool_ksettings_set() performs such lookup using the
> > phy_settings table, but are only interested in the actual speed/duplex
> > that were matched, rathet than the individual linkmode.
> >
> > Similar to phy_lookup_settings(), the newly introduced phy_caps_lookup()
> > will run through the link_caps[] array by descending speed/duplex order.
> >
> > If the link_capabilities for a given <speed/duplex> tuple intersects the
> > passed linkmodes, we consider that a match.
> >
> > Similar to phy_lookup_settings(), we also allow passing an 'exact'
> > boolean, allowing non-exact match. Here, we MUST always match the
> > linkmodes mask, but we allow matching on lower speed settings.
> >
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >   drivers/net/phy/phy-caps.h |  4 ++++
> >   drivers/net/phy/phy.c      | 32 ++++++--------------------
> >   drivers/net/phy/phy_caps.c | 47 ++++++++++++++++++++++++++++++++++++++
> >   drivers/net/phy/phylink.c  | 17 +++++++-------
> >   4 files changed, 67 insertions(+), 33 deletions(-)
> >
> > diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
> > index 8833798f141f..aef4b54a8429 100644
> > --- a/drivers/net/phy/phy-caps.h
> > +++ b/drivers/net/phy/phy-caps.h
> > @@ -51,4 +51,8 @@ phy_caps_lookup_by_linkmode(const unsigned long *link=
modes);
> >   const struct link_capabilities *
> >   phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool =
fdx_only);
> >  =20
> > +const struct link_capabilities *
> > +phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *s=
upported,
> > +		bool exact);
> > +
> >   #endif /* __PHY_CAPS_H */
> > diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> > index 8df37d221fba..562acde89224 100644
> > --- a/drivers/net/phy/phy.c
> > +++ b/drivers/net/phy/phy.c
> > @@ -213,25 +213,6 @@ int phy_aneg_done(struct phy_device *phydev)
> >   }
> >   EXPORT_SYMBOL(phy_aneg_done);
> >  =20
> > -/**
> > - * phy_find_valid - find a PHY setting that matches the requested para=
meters
> > - * @speed: desired speed
> > - * @duplex: desired duplex
> > - * @supported: mask of supported link modes
> > - *
> > - * Locate a supported phy setting that is, in priority order:
> > - * - an exact match for the specified speed and duplex mode
> > - * - a match for the specified speed, or slower speed
> > - * - the slowest supported speed
> > - * Returns the matched phy_setting entry, or %NULL if no supported phy
> > - * settings were found.
> > - */
> > -static const struct phy_setting *
> > -phy_find_valid(int speed, int duplex, unsigned long *supported)
> > -{
> > -	return phy_lookup_setting(speed, duplex, supported, false);
> > -}
> > -
> >   /**
> >    * phy_supported_speeds - return all speeds currently supported by a =
phy device
> >    * @phy: The phy device to return supported speeds of.
> > @@ -274,13 +255,14 @@ EXPORT_SYMBOL(phy_check_valid);
> >    */
> >   static void phy_sanitize_settings(struct phy_device *phydev)
> >   {
> > -	const struct phy_setting *setting;
> > +	const struct link_capabilities *c;
> > +
> > +	c =3D phy_caps_lookup(phydev->speed, phydev->duplex, phydev->supporte=
d,
> > +			    false);
> >  =20
> > -	setting =3D phy_find_valid(phydev->speed, phydev->duplex,
> > -				 phydev->supported);
> > -	if (setting) {
> > -		phydev->speed =3D setting->speed;
> > -		phydev->duplex =3D setting->duplex;
> > +	if (c) {
> > +		phydev->speed =3D c->speed;
> > +		phydev->duplex =3D c->duplex;
> >   	} else {
> >   		/* We failed to find anything (no supported speeds?) */
> >   		phydev->speed =3D SPEED_UNKNOWN;
> > diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> > index c39f38c12ef2..0366feee2912 100644
> > --- a/drivers/net/phy/phy_caps.c
> > +++ b/drivers/net/phy/phy_caps.c
> > @@ -170,6 +170,53 @@ phy_caps_lookup_by_linkmode_rev(const unsigned lon=
g *linkmodes, bool fdx_only)
> >   	return NULL;
> >   }
> >  =20
> > +/**
> > + * phy_caps_lookup() - Lookup capabilities by speed/duplex that matche=
s a mask
> > + * @speed: Speed to match
> > + * @duplex: Duplex to match
> > + * @supported: Mask of linkmodes to match
> > + * @exact: Perform an exact match or not.
> > + *
> > + * Lookup a link_capabilities entry that intersect the supported linkm=
odes mask,
> > + * and that matches the passed speed and duplex.
> > + *
> > + * When @exact is set, an exact match is performed on speed and duplex=
, meaning
> > + * that if the linkmodes for the given speed and duplex intersect the =
supported
> > + * mask, this capability is returned, otherwise we don't have a match =
and return
> > + * NULL.
> > + *
> > + * When @exact is not set, we return either an exact match, or matchin=
g capabilities
> > + * at lower speed, or the lowest matching speed, or NULL.
> > + *
> > + * Returns: a matched link_capabilities according to the above process=
, NULL
> > + *	    otherwise.
> > + */
> > +const struct link_capabilities *
> > +phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *s=
upported,
> > +		bool exact)
> > +{
> > +	const struct link_capabilities *lcap, *last =3D NULL;
> > +
> > +	for_each_link_caps_desc_speed(lcap) {
> > +		if (linkmode_intersects(lcap->linkmodes, supported)) {
> > +			last =3D lcap;
> > +			/* exact match on speed and duplex*/
> > +			if (lcap->speed =3D=3D speed && lcap->duplex =3D=3D duplex) {
> > +				return lcap;
> > +			} else if (!exact) {
> > +				if (lcap->speed <=3D speed)
> > +					return lcap;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (!exact)
> > +		return last;
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(phy_caps_lookup);
> > +
> >   /**
> >    * phy_caps_linkmode_max_speed() - Clamp a linkmodes set to a max spe=
ed
> >    * @max_speed: Speed limit for the linkmode set
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index a3f64b6d2d34..cf9f019382ad 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/timer.h>
> >   #include <linux/workqueue.h>
> >  =20
> > +#include "phy-caps.h"
> >   #include "sfp.h"
> >   #include "swphy.h"
> >  =20
> > @@ -2852,8 +2853,8 @@ int phylink_ethtool_ksettings_set(struct phylink =
*pl,
> >   				  const struct ethtool_link_ksettings *kset)
> >   {
> >   	__ETHTOOL_DECLARE_LINK_MODE_MASK(support);
> > +	const struct link_capabilities *c;
> >   	struct phylink_link_state config;
> > -	const struct phy_setting *s;
> >  =20
> >   	ASSERT_RTNL();
> >  =20
> > @@ -2896,23 +2897,23 @@ int phylink_ethtool_ksettings_set(struct phylin=
k *pl,
> >   		/* Autonegotiation disabled, select a suitable speed and
> >   		 * duplex.
> >   		 */
> > -		s =3D phy_lookup_setting(kset->base.speed, kset->base.duplex,
> > -				       pl->supported, false);
> > -		if (!s)
> > +		c =3D phy_caps_lookup(kset->base.speed, kset->base.duplex,
> > +				    pl->supported, false);
> > +		if (!c)
> >   			return -EINVAL; =20
>=20
>=20
>=20
> Hi Maxime,  fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps=
 based on speed and duplex") might have different behavior than the modific=
ation.
> My case is set 10M Half with disable autoneg both sides and I expect it is
> link in 10M Half. But now, it is link in 10M Full=EF=BC=8Cwhich is not wh=
at I
> expect.
>=20
> I used followed command and trace how phy worked.
> 	ethtool -s eth1 autoneg off speed 10 duplex half
> The log is showed as followed:
> ethtool-13127	[067]	6164.771853: phy_ethtool_ksettings set: (phy_ethtool =
ksettings set+0x0/0x200) duplex=3D0 speed=3D10
> kworker/u322:2-11096	[070]	6164.771853:	_phy_start_aneq: ( _phy_start_ane=
g+0x0/0xb8) duplex=3D0 speed=3D10
> kworker/u322:2-11096	[070]	6164.771854:	phy_caps_lookup: (phy_caps_lookup=
+0x0/0xf0) duplex=3D0 speed=3D10
> kworker/u322:2-11096	[070]	6164.771855:	phy_config_aneg: (phy_config_aneg=
+0x0/0x70) duplex=3D1 speed=3D10
> kworker/u322:2-11096	[070]	6164.771856:	genphy_config_aneg:	(__genphy_con=
fig_aneg+0X0/0X270) duplex=3D1 speed=3D10
>=20
> I also try to fixed it and it works. Do you have any idea about it.

The !exact match logic in the rework is wrong indeed, sorry...

For non-exact matches we return a non-exact match too early without
giving the chance for a potentially exact half-duplex match...

As for the fix, can you try this out :

diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 703321689726..d80f6a37edf1 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -195,7 +195,7 @@ const struct link_capabilities *
 phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *suppo=
rted,
 		bool exact)
 {
-	const struct link_capabilities *lcap, *last =3D NULL;
+	const struct link_capabilities *lcap, *match =3D NULL, *last =3D NULL;
=20
 	for_each_link_caps_desc_speed(lcap) {
 		if (linkmode_intersects(lcap->linkmodes, supported)) {
@@ -204,16 +204,19 @@ phy_caps_lookup(int speed, unsigned int duplex, const=
 unsigned long *supported,
 			if (lcap->speed =3D=3D speed && lcap->duplex =3D=3D duplex) {
 				return lcap;
 			} else if (!exact) {
-				if (lcap->speed <=3D speed)
-					return lcap;
+				if (!match && lcap->speed <=3D speed)
+					match =3D lcap;
+
+				if (lcap->speed < speed)
+					break;
 			}
 		}
 	}
=20
-	if (!exact)
-		return last;
+	if (!match && !exact)
+		match =3D last;
=20
-	return NULL;
+	return match;
 }
 EXPORT_SYMBOL_GPL(phy_caps_lookup);

