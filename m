Return-Path: <netdev+bounces-173038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786EBA56F3B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF9DD3B1BEB
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6222505B6;
	Fri,  7 Mar 2025 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="itxiXWcH"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE3124E4DD;
	Fri,  7 Mar 2025 17:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368993; cv=none; b=BU6N/WcE5eChL5aCbireyCVh35rcW0AQw5KwceTAJoPn02NrG0L5XNGJxMNK8tNomDR0GH7p0uj6JDXZqxDeqgYZ3cE0fAlCb7rFR1cCAN5zogsU+DW7jSzoaG7npR7OyapkdLJZqxwg/SxBzsifkHiC52lcpJfNBTS/d1RRBvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368993; c=relaxed/simple;
	bh=sJeV9kLoRVZsI0zaBDcms4xFoCq3Snu4WKoFJ1ZEm3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSqVkkVq53zzESgNkipZOHGlWzVY/wmDh00ogmQ6mkXQ8KgQBA0M5Tb4f1gOCaOwaSkOp1sCpF39XSAkHMpqkvaZxW/xVRe9NpVFx8JMhmltk0pjSlRiOPVZ97bmv+TqQpko4EPyIrYeCo4HMjFs17I5UR7ZEPTg3kmXMf2y7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=itxiXWcH; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C8B9820479;
	Fri,  7 Mar 2025 17:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVDTy+fF2jXuebQ3SxDMJcIY3vuxfzogvGsF6tamhpQ=;
	b=itxiXWcHgbC0lfFw62jbr6jGIqNn3X0Rsa+UT92YZ76vpk5HR0wRRzq8RAqsas5bdU2G/v
	XnKEPwRp0umA/wosHfL744X19v/QLJ9jFIzAmxVJMbSf6PRjoAmZn7NWL9gF6zDME6ZGsV
	Hg0+32g8t5zHvHbN17ylC9J0ARpJU0RgFAaSNDDNcUgtGcIQoxYaMoptV8EFbJBcVA4H6D
	xO9iJmTmmNOS8Yup+dS+ol1dZN78x7e+Hhkq7lq6PjwE81Hp4/pul5/W+cnAj0hMROXtms
	yEqXtMAUtX0VXUL12SMsO4qZwS7yzCWGpSL3D8SURh0bvp9lmMfF8hflGhzE9A==
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
Subject: [PATCH net-next v5 12/13] net: phylink: Convert capabilities to linkmodes using phy_caps
Date: Fri,  7 Mar 2025 18:36:09 +0100
Message-ID: <20250307173611.129125-13-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

phylink_caps_to_linkmodes() is used to derive a list of linkmodes that
can be conceivably exposed using a given set of speeds and duplex
through phylink's MAC capabilities.

This list can be derived from the link_caps array in phy_caps, provided
we convert the MAC capabilities into a LINK_CAPA bitmask first.

Introduce an internal phylink helper phylink_caps_to_link_caps() to
convert from MAC capabilities into phy_caps, then  phy_caps_linkmodes()
to do the link_caps -> linkmodes conversion.

This avoids having to update phylink for every new linkmode.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |   1 +
 drivers/net/phy/phy_caps.c |  14 ++++
 drivers/net/phy/phylink.c  | 155 +++++--------------------------------
 3 files changed, 36 insertions(+), 134 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index aef4b54a8429..7fc930876e33 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -44,6 +44,7 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 		       unsigned long *linkmodes);
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
 bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes);
+void phy_caps_linkmodes(unsigned long caps, unsigned long *linkmodes);
 
 const struct link_capabilities *
 phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 0366feee2912..fc1568f83c1a 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -251,3 +251,17 @@ bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes)
 
 	return linkmode_intersects(link_caps[capa].linkmodes, linkmodes);
 }
+
+/**
+ * phy_caps_linkmodes() - Convert a bitfield of capabilities into linkmodes
+ * @caps: The list of caps, each bit corresponding to a LINK_CAPA value
+ * @linkmodes: The set of linkmodes to fill. Must be previously initialized.
+ */
+void phy_caps_linkmodes(unsigned long caps, unsigned long *linkmodes)
+{
+	unsigned long capa;
+
+	for_each_set_bit(capa, &caps, __LINK_CAPA_MAX)
+		linkmode_or(linkmodes, linkmodes, link_caps[capa].linkmodes);
+}
+EXPORT_SYMBOL_GPL(phy_caps_linkmodes);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index c6fa3f003833..a75aad5e4563 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -317,6 +317,24 @@ static struct {
 	{ MAC_10HD,     SPEED_10,     DUPLEX_HALF, BIT(LINK_CAPA_10HD) },
 };
 
+/**
+ * phylink_caps_to_link_caps() - Convert a set of MAC capabilities LINK caps
+ * @caps: A set of MAC capabilities
+ *
+ * Returns: The corresponding set of LINK_CAPA as defined in phy-caps.h
+ */
+static unsigned long phylink_caps_to_link_caps(unsigned long caps)
+{
+	unsigned long link_caps = 0;
+	int i;
+
+	for (i = 0; i <  ARRAY_SIZE(phylink_caps_params); i++)
+		if (caps & phylink_caps_params[i].mask)
+			link_caps |= phylink_caps_params[i].caps_bit;
+
+	return link_caps;
+}
+
 /**
  * phylink_caps_to_linkmodes() - Convert capabilities to ethtool link modes
  * @linkmodes: ethtool linkmode mask (must be already initialised)
@@ -328,146 +346,15 @@ static struct {
 static void phylink_caps_to_linkmodes(unsigned long *linkmodes,
 				      unsigned long caps)
 {
+	unsigned long link_caps = phylink_caps_to_link_caps(caps);
+
 	if (caps & MAC_SYM_PAUSE)
 		__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, linkmodes);
 
 	if (caps & MAC_ASYM_PAUSE)
 		__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, linkmodes);
 
-	if (caps & MAC_10HD) {
-		__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_Half_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT, linkmodes);
-	}
-
-	if (caps & MAC_10FD) {
-		__set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_100HD) {
-		__set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100baseFX_Half_BIT, linkmodes);
-	}
-
-	if (caps & MAC_100FD) {
-		__set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_1000HD)
-		__set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, linkmodes);
-
-	if (caps & MAC_1000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_2500FD) {
-		__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_5000FD)
-		__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, linkmodes);
-
-	if (caps & MAC_10000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseR_FEC_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_10000baseER_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_25000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_40000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_50000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseSR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_50000baseDR_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_56000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_56000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_56000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_100000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseKR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseSR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseLR_ER_FR_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseCR_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_100000baseDR_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_200000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseLR2_ER2_FR2_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseDR2_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT, linkmodes);
-	}
-
-	if (caps & MAC_400000FD) {
-		__set_bit(ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseKR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseSR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
-			  linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT, linkmodes);
-		__set_bit(ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT, linkmodes);
-	}
+	phy_caps_linkmodes(link_caps, linkmodes);
 }
 
 /**
-- 
2.48.1


