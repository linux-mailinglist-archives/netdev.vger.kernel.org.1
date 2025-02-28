Return-Path: <netdev+bounces-170749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E5FA49C86
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 15:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFA03BA1FD
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8A276044;
	Fri, 28 Feb 2025 14:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kfJBpXL8"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A35227425F;
	Fri, 28 Feb 2025 14:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740754553; cv=none; b=Ia2JY3a/DjMZvYL5E1tldMKUyyCfWPLDu9CQMWic81lHU4A4xgi6aYxldXdZ1Ce+itNpbWldxb6oGSQl/4M5LzrIX7GleTcv2b/qmJ6oKmNlHuwkuaU7WacCfDZBC3oh3yrj6V7R7Jw6fkTb/KXg6YKBpCkuAhZ4Pids7a3UazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740754553; c=relaxed/simple;
	bh=+otnl69tOg4VrdMoEo8sP+t93zT/HdT5Yi3hD63tO+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wzyld2UJAGZerzrDdmvIw5rG/v2wli3ivxWP7QaHHbrJHjhA2OZ8GXwRKbVxBkHcgGYYylqvdXPonAiDlQWP1K3gRsaNUp7hyqH4nMAPJ7aE68EB5ulePjR6yQNBL0cLKv4vz7GkhhS/+mMAJ5Uu72QN5H3StBR1pnVpzb2YFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kfJBpXL8; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B4D13443F3;
	Fri, 28 Feb 2025 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740754549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMeWIy1pokFUafjD0nCX3zVlZ19P+ScVtBIyEejkHgY=;
	b=kfJBpXL83BU7MMrUipafybxNCBGl0H6pj34lh+rbJPDRRDnAVyAaHnoDzdirt4iCyVnhy7
	R5HTrR/EG1x96uSKpjIreY/NbfNpe6YLvArVNglJ7+pDehXgvU7kmINcBj6An2cEKwMH/V
	rEMinzGtDZlnOVLGsy9pBHBJE447jXmSPXnaT1WaCCTzS1aXr3DvU3O+AhGs753Bp7bvA/
	nNeejD8nS3QKdkRxlX4q/zgDfP1CcT089v9dBxb3Zue9tru+4Qy18OxL28Yg/Q6wMHgN56
	u7aoBYoDKQDQ9Wv3WccDv00nN2aIDjOGqxxyKlre+yBh17GwQK8NdGJW77AQCA==
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
Subject: [PATCH net-next v3 06/13] net: phy: phy_caps: Implement link_capabilities lookup by linkmode
Date: Fri, 28 Feb 2025 15:55:31 +0100
Message-ID: <20250228145540.2209551-7-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
References: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
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
index 7359983fce0f..7b95a9cb5ebb 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -46,5 +46,10 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
 bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes);
 
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
+
+const struct link_capabilities *
+phy_caps_lookup_by_linkmode_rev(const unsigned long *linkmodes, bool fdx_only);
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index f62bc1be67b2..6cb8f857a7f1 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -468,16 +468,15 @@ EXPORT_SYMBOL_GPL(phy_resolve_aneg_pause);
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
@@ -495,7 +494,8 @@ EXPORT_SYMBOL_GPL(phy_resolve_aneg_linkmode);
 void phy_check_downshift(struct phy_device *phydev)
 {
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
-	int i, speed = SPEED_UNKNOWN;
+	const struct link_capabilities *c;
+	int speed = SPEED_UNKNOWN;
 
 	phydev->downshifted_rate = 0;
 
@@ -505,11 +505,9 @@ void phy_check_downshift(struct phy_device *phydev)
 
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
@@ -523,17 +521,13 @@ void phy_check_downshift(struct phy_device *phydev)
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
index b776375ea9e4..8cf7ff3f1368 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -104,6 +104,51 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
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
+	int capa;
+
+	for (capa = __LINK_CAPA_LAST; capa >= 0; capa--)
+		if (linkmode_intersects(link_caps[capa].linkmodes, linkmodes))
+			return &link_caps[capa];
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
+	int capa;
+
+	for (capa = 0; capa < __LINK_CAPA_MAX; capa++) {
+		if (fdx_only && link_caps[capa].duplex != DUPLEX_FULL)
+			continue;
+
+		if (linkmode_intersects(link_caps[capa].linkmodes, linkmodes))
+			return &link_caps[capa];
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


