Return-Path: <netdev+bounces-171125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A971DA4BA36
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CACB16E0E2
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C01F12E8;
	Mon,  3 Mar 2025 09:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H10qubaK"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB27F1EF0A3;
	Mon,  3 Mar 2025 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992619; cv=none; b=aP8e+TJe3EAmq+tlXiewx80bUC+kbQy3aFXhopPyyMiFweF53zQz6kOUUb7hL7huej6qES45/ruGtJkoZf0gaB4xxlc0ooAjlTjhMEpTrIAsTsALl4CnENg06Wt6km324rR4R9MZQWwDa+SItqd7Lf8Dg3w93pQLiwCIuCa0Q9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992619; c=relaxed/simple;
	bh=Lj4c/xpNWcIiZriKGAoheiWyfj04HJqsQBBLykNw90Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZNXPFMead1eyFASyc65e7L1COnM1qAc1ytE78rXW3dZayiaL6jaSRSrGGonpaWIY+7TwCOdfj0NQyX5FNtWiSxB26RMTJa80cnv4bxxlSawfx2hYzM3qMh0d22ZDjb9kKm4NR2J9np6izlgy7Dl6w6VKOK7/2Bu05NBfUFVrSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H10qubaK; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 096184453E;
	Mon,  3 Mar 2025 09:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c6bcy99zdNbeNFZMlRjx168Yd1XH1bH9AK8JYCC77eM=;
	b=H10qubaK0ZvykMKExpyIyox/Xc1U1bRnXlCGB7nvCZxOQrEPvHiqttgpI1YwtuKo2tDbzz
	B5bN4nBWifffb+gUNHQeZb0v35VpR2Y/DBgCMNFs0ASiL5F1qUq/E6xlirPm+5ByRdrle5
	o+eGf0FIHPu/dg93uVNcFBSTeikw7/4N+A1NW6dJNhsaaKnGgnhU3SoqxC6P0zcd1IwgpM
	2tlRWjTRZL4Vk1ReQyuGmsGWWi8pzBpbaY4NJDX1leQLyr8RuqdQ+yw+nLViweLXP4lWpi
	iCQ7CTFPQt2fD2b6SdZnG9iwPkW0YtOeKlED8HmEXisHUXgB60AiEjthOetaAQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next v4 07/13] net: phy: phy_caps: Allow looking-up link caps based on speed and duplex
Date: Mon,  3 Mar 2025 10:03:13 +0100
Message-ID: <20250303090321.805785-8-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

As the link_caps array is efficient for <speed,duplex> lookups,
implement a function for speed/duplex lookups that matches a given
mask. This replicates to some extent the phy_lookup_settings()
behaviour, matching full link_capabilities instead of a single linkmode.

phy.c's phy_santize_settings() and phylink's
phylink_ethtool_ksettings_set() performs such lookup using the
phy_settings table, but are only interested in the actual speed/duplex
that were matched, rathet than the individual linkmode.

Similar to phy_lookup_settings(), the newly introduced phy_caps_lookup()
will run through the link_caps[] array by descending speed/duplex order.

If the link_capabilities for a given <speed/duplex> tuple intersects the
passed linkmodes, we consider that a match.

Similar to phy_lookup_settings(), we also allow passing an 'exact'
boolean, allowing non-exact match. Here, we MUST always match the
linkmodes mask, but we allow matching on lower speed settings.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: Switch to macro iterators for better readability (Russell)

 drivers/net/phy/phy-caps.h |  4 ++++
 drivers/net/phy/phy.c      | 32 ++++++--------------------
 drivers/net/phy/phy_caps.c | 47 ++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c  | 17 +++++++-------
 4 files changed, 67 insertions(+), 33 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 7103cf508d7e..8ae8dc42494f 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -51,4 +51,8 @@ phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
 const struct link_capabilities *
 phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only);
 
+const struct link_capabilities *
+phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
+		bool exact);
+
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 8df37d221fba..562acde89224 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -213,25 +213,6 @@ int phy_aneg_done(struct phy_device *phydev)
 }
 EXPORT_SYMBOL(phy_aneg_done);
 
-/**
- * phy_find_valid - find a PHY setting that matches the requested parameters
- * @speed: desired speed
- * @duplex: desired duplex
- * @supported: mask of supported link modes
- *
- * Locate a supported phy setting that is, in priority order:
- * - an exact match for the specified speed and duplex mode
- * - a match for the specified speed, or slower speed
- * - the slowest supported speed
- * Returns the matched phy_setting entry, or %NULL if no supported phy
- * settings were found.
- */
-static const struct phy_setting *
-phy_find_valid(int speed, int duplex, unsigned long *supported)
-{
-	return phy_lookup_setting(speed, duplex, supported, false);
-}
-
 /**
  * phy_supported_speeds - return all speeds currently supported by a phy device
  * @phy: The phy device to return supported speeds of.
@@ -274,13 +255,14 @@ EXPORT_SYMBOL(phy_check_valid);
  */
 static void phy_sanitize_settings(struct phy_device *phydev)
 {
-	const struct phy_setting *setting;
+	const struct link_capabilities *c;
+
+	c = phy_caps_lookup(phydev->speed, phydev->duplex, phydev->supported,
+			    false);
 
-	setting = phy_find_valid(phydev->speed, phydev->duplex,
-				 phydev->supported);
-	if (setting) {
-		phydev->speed = setting->speed;
-		phydev->duplex = setting->duplex;
+	if (c) {
+		phydev->speed = c->speed;
+		phydev->duplex = c->duplex;
 	} else {
 		/* We failed to find anything (no supported speeds?) */
 		phydev->speed = SPEED_UNKNOWN;
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 8160cb53b5ae..8b90fb6d6b15 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -158,6 +158,53 @@ phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only)
 	return NULL;
 }
 
+/**
+ * phy_caps_lookup() - Lookup capabilities by speed/duplex that matches a mask
+ * @speed: Speed to match
+ * @duplex: Duplex to match
+ * @supported: Mask of linkmodes to match
+ * @exact: Perform an exact match or not.
+ *
+ * Lookup a link_capabilities entry that intersect the supported linkmodes mask,
+ * and that matches the passed speed and duplex.
+ *
+ * When @exact is set, an exact match is performed on speed and duplex, meaning
+ * that if the linkmodes for the given speed and duplex intersect the supported
+ * mask, this capability is returned, otherwise we don't have a match and return
+ * NULL.
+ *
+ * When @exact is not set, we return either an exact match, or matching capabilities
+ * at lower speed, or the lowest matching speed, or NULL.
+ *
+ * Returns: a matched link_capabilities according to the above process, NULL
+ *	    otherwise.
+ */
+const struct link_capabilities *
+phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
+		bool exact)
+{
+	const struct link_capabilities *lcap, *last = NULL;
+
+	for_each_link_caps_desc_speed(lcap) {
+		if (linkmode_intersects(lcap->linkmodes, supported)) {
+			last = lcap;
+			/* exact match on speed and duplex*/
+			if (lcap->speed == speed && lcap->duplex == duplex) {
+				return lcap;
+			} else if (!exact) {
+				if (lcap->speed <= speed)
+					return lcap;
+			}
+		}
+	}
+
+	if (!exact)
+		return last;
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(phy_caps_lookup);
+
 /**
  * phy_caps_linkmode_max_speed() - Clamp a linkmodes set to a max speed
  * @max_speed: Speed limit for the linkmode set
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a3b186ab3854..6c67d5c9b787 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -20,6 +20,7 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 
+#include "phy-caps.h"
 #include "sfp.h"
 #include "swphy.h"
 
@@ -2852,8 +2853,8 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 				  const struct ethtool_link_ksettings *kset)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(support);
+	const struct link_capabilities *c;
 	struct phylink_link_state config;
-	const struct phy_setting *s;
 
 	ASSERT_RTNL();
 
@@ -2896,23 +2897,23 @@ int phylink_ethtool_ksettings_set(struct phylink *pl,
 		/* Autonegotiation disabled, select a suitable speed and
 		 * duplex.
 		 */
-		s = phy_lookup_setting(kset->base.speed, kset->base.duplex,
-				       pl->supported, false);
-		if (!s)
+		c = phy_caps_lookup(kset->base.speed, kset->base.duplex,
+				    pl->supported, false);
+		if (!c)
 			return -EINVAL;
 
 		/* If we have a fixed link, refuse to change link parameters.
 		 * If the link parameters match, accept them but do nothing.
 		 */
 		if (pl->req_link_an_mode == MLO_AN_FIXED) {
-			if (s->speed != pl->link_config.speed ||
-			    s->duplex != pl->link_config.duplex)
+			if (c->speed != pl->link_config.speed ||
+			    c->duplex != pl->link_config.duplex)
 				return -EINVAL;
 			return 0;
 		}
 
-		config.speed = s->speed;
-		config.duplex = s->duplex;
+		config.speed = c->speed;
+		config.duplex = c->duplex;
 		break;
 
 	case AUTONEG_ENABLE:
-- 
2.48.1


