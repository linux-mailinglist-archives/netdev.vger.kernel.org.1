Return-Path: <netdev+bounces-173033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6480DA56F30
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77511785D6
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819772459CA;
	Fri,  7 Mar 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N/cVT/Uy"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C7242922;
	Fri,  7 Mar 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368986; cv=none; b=cw+SSsgAAkuRnSqX1QpULv3+QVxPj9EDZBmGcTpZe1hlkA6IdcFUWJDAtjOFm+SNvCQGz/aHF/YmTiD45Ak0C9PLdDS66z2Hz0VEEV/ofl2m+o1rECoFFvesEDww2PVcb8XE66f85S+PqCFFp5pkDdvk/bILTtoF9ypQA3Lklp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368986; c=relaxed/simple;
	bh=943PXyry+VtM8nPtSR3UwvOyvMSJkjeyknGSxIDo3ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ri3F/oFOPa9hKx4MBQXGnUhphhdum76lJAx47mf0nfQIWO9CN63USgAW6ICY1IvPMJeykHhqJet1x9sORaj4ejkpCQ5fRpiXauWDEBZy94Wa3lIt4EGPfG1NK3mGMhUvThHfy6j8tF5lxvcgP+hnZlWLSfH29pm+0IrtoitVDkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N/cVT/Uy; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0E4720454;
	Fri,  7 Mar 2025 17:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiynNqh+wJZdhqF/dmsuu7i5c7oDX9Htf0hCO5R07rs=;
	b=N/cVT/UyIYAhXUoqzBPMxH/jyX3w3Mafno1CpmDbt1QNgzzJ15rbqXdet58quCz9rWrcJr
	JRUNttOEEXCfTczsBM2clARn8urU9v9NEkE6yQAVOZw8NNxwABnIw9Jat63nsf+c6XHM1O
	rRHGwopWsIrABHbDM3Ycud/DhrmZ8r1M2f3MMiBqdsBXY4vzWNGRooK6eVAzvJKZhkBHos
	3jnbA4jXYoFrAskDknoqXdkXHIJaHw/Dy0IhahZmbxuWPKiwit1WC/Wm9o5WmhHoTKK25w
	O2tg1qg0L26m/AG04GERmcI6OGtLqGZC/S2L5rzIncRgfH35EDHlZc+q+kqqvA==
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
Subject: [PATCH net-next v5 06/13] net: phy: phy_caps: Implement link_capabilities lookup by linkmode
Date: Fri,  7 Mar 2025 18:36:03 +0100
Message-ID: <20250307173611.129125-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

In several occasions, phylib needs to lookup a set of matching speed and
duplex against a given linkmode set. Instead of relying on the
phy_settings array and thus iterate over the whole linkmodes list, use
the link_capabilities array to lookup these matches, as we aren't
interested in the actual link setting that matches but rather the speed
and duplex for that setting.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  5 +++++
 drivers/net/phy/phy-core.c | 36 +++++++++++++-----------------
 drivers/net/phy/phy_caps.c | 45 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 1217686f1f91..8833798f141f 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -45,5 +45,10 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
 bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes);
 
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
+
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only);
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index af2463e67cea..bfba03f208fd 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -469,16 +469,15 @@ EXPORT_SYMBOL_GPL(phy_resolve_aneg_pause);
 void phy_resolve_aneg_linkmode(struct phy_device *phydev)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	int i;
+	const struct link_capabilities *c;
 
 	linkmode_and(common, phydev->lp_advertising, phydev->advertising);
 
-	for (i = 0; i < ARRAY_SIZE(settings); i++)
-		if (test_bit(settings[i].bit, common)) {
-			phydev->speed = settings[i].speed;
-			phydev->duplex = settings[i].duplex;
-			break;
-		}
+	c = phy_caps_lookup_by_linkmode(common);
+	if (c) {
+		phydev->speed = c->speed;
+		phydev->duplex = c->duplex;
+	}
 
 	phy_resolve_aneg_pause(phydev);
 }
@@ -496,7 +495,8 @@ EXPORT_SYMBOL_GPL(phy_resolve_aneg_linkmode);
 void phy_check_downshift(struct phy_device *phydev)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	int i, speed = SPEED_UNKNOWN;
+	const struct link_capabilities *c;
+	int speed = SPEED_UNKNOWN;
 
 	phydev->downshifted_rate = 0;
 
@@ -506,11 +506,9 @@ void phy_check_downshift(struct phy_device *phydev)
 
 	linkmode_and(common, phydev->lp_advertising, phydev->advertising);
 
-	for (i = 0; i < ARRAY_SIZE(settings); i++)
-		if (test_bit(settings[i].bit, common)) {
-			speed = settings[i].speed;
-			break;
-		}
+	c = phy_caps_lookup_by_linkmode(common);
+	if (c)
+		speed = c->speed;
 
 	if (speed == SPEED_UNKNOWN || phydev->speed >= speed)
 		return;
@@ -524,17 +522,13 @@ void phy_check_downshift(struct phy_device *phydev)
 static int phy_resolve_min_speed(struct phy_device *phydev, bool fdx_only)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	int i = ARRAY_SIZE(settings);
+	const struct link_capabilities *c;
 
 	linkmode_and(common, phydev->lp_advertising, phydev->advertising);
 
-	while (--i >= 0) {
-		if (test_bit(settings[i].bit, common)) {
-			if (fdx_only && settings[i].duplex != DUPLEX_FULL)
-				continue;
-			return settings[i].speed;
-		}
-	}
+	c = phy_caps_lookup_by_linkmode_rev(common, fdx_only);
+	if (c)
+		return c->speed;
 
 	return SPEED_UNKNOWN;
 }
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 4ee8c25c8521..c39f38c12ef2 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -125,6 +125,51 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 	return count;
 }
 
+/**
+ * phy_caps_lookup_by_linkmode() - Lookup the fastest matching link_capabilities
+ * @linkmodes: Linkmodes to match against
+ *
+ * Returns: The highest-speed link_capabilities that intersects the given
+ *	    linkmodes. In case several DUPLEX_ options exist at that speed,
+ *	    DUPLEX_FULL is matched first. NULL is returned if no match.
+ */
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode(const unsigned long *linkmodes)
+{
+	struct link_capabilities *lcap;
+
+	for_each_link_caps_desc_speed(lcap)
+		if (linkmode_intersects(lcap->linkmodes, linkmodes))
+			return lcap;
+
+	return NULL;
+}
+
+/**
+ * phy_caps_lookup_by_linkmode_rev() - Lookup the slowest matching link_capabilities
+ * @linkmodes: Linkmodes to match against
+ * @fdx_only: Full duplex match only when set
+ *
+ * Returns: The lowest-speed link_capabilities that intersects the given
+ *	    linkmodes. When set, fdx_only will ignore half-duplex matches.
+ *	    NULL is returned if no match.
+ */
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only)
+{
+	struct link_capabilities *lcap;
+
+	for_each_link_caps_asc_speed(lcap) {
+		if (fdx_only && lcap->duplex != DUPLEX_FULL)
+			continue;
+
+		if (linkmode_intersects(lcap->linkmodes, linkmodes))
+			return lcap;
+	}
+
+	return NULL;
+}
+
 /**
  * phy_caps_linkmode_max_speed() - Clamp a linkmodes set to a max speed
  * @max_speed: Speed limit for the linkmode set
-- 
2.48.1


