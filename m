Return-Path: <netdev+bounces-168774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA80A40911
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 15:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BD219C77EF
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 14:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB63020E310;
	Sat, 22 Feb 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IpO0OoM6"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4623220C460;
	Sat, 22 Feb 2025 14:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234472; cv=none; b=shU8syw1C3OoEiQO9tCOTvftR6xF+i/+UovLfKOl5Z++2iPWd9vqy3AxLl656QOpSqvluduoGbHgRpGWr1Rt9SzblX72Rla1DMSE6AijWPXDSyq2fyY90NIrTq8WD/GtyqJjn9GtqqLKu4eWYncCyRP2R0MxpepO3qRqleQjYPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234472; c=relaxed/simple;
	bh=ZkWZAuQQaE2U0nBYZPUgQjLxsKQ8v8l8c7giTiQNutY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMfN/WafKUG8Zx5m/wRbqXBOHzFuSP2lmVL8Gf4HXHOKUts9aTSBcJYOx6tea4DNXCKWfegSSSm7FRD9Ils4OmywpA9UJYHz3XLGHfy6S4Jv9QoLLtmppJly7xKC/K+9lVlKH0ifZytnXWgl4agmiKudnTvWb87rs7BW26c5wz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IpO0OoM6; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8F76744281;
	Sat, 22 Feb 2025 14:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740234468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp7KP6Y53xqk/fsyDiO4ohhExI4+jwvcPEze3DUsVbw=;
	b=IpO0OoM6lub3w/uUvmVIVIvUi+BG0A1zlvjelEEtwI3J3n/w1L60GKWmB8liY6JhU2kX5B
	6GXxc4vvqQUmvSkctKITqh2OxLFrX0JdRaEDq1CgiAIihSG30Lcc3Qlrf8/QlsdjnR4aPZ
	WtDu3ty7jh9EUseS6K2JDmnlMr8kdGFtQ9GOMczhIYFbtqJCUgFCUInqc8/lfJeS1a7OH0
	3RX/Xz5Rsd5bZFeIpTThSEeTfh6Noz+mf97G+gEzBK91qD8zvlsLCY7oU8qiH7CEmohIvh
	81QSkk5WsXj1lNQJDTY+Rfv+9H5JtCK9K51Wc2Hfdq0pi4t1TA/LFjEyUcP5ww==
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
Subject: [PATCH net-next 13/13] net: phy: drop phy_settings and the associated lookup helpers
Date: Sat, 22 Feb 2025 15:27:25 +0100
Message-ID: <20250222142727.894124-14-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejfeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedutdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

The phy_settings array is no longer relevant as it has now been replaced
by the link_caps array and associated phy_caps helpers.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-core.c | 184 -------------------------------------
 include/linux/phy.h        |  12 ---
 2 files changed, 196 deletions(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 98c58689fbf0..9b810c8a039a 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -155,190 +155,6 @@ int phy_interface_num_ports(phy_interface_t interface)
 }
 EXPORT_SYMBOL_GPL(phy_interface_num_ports);
 
-/* A mapping of all SUPPORTED settings to speed/duplex.  This table
- * must be grouped by speed and sorted in descending match priority
- * - iow, descending speed.
- */
-
-#define PHY_SETTING(s, d, b) { .speed = SPEED_ ## s, .duplex = DUPLEX_ ## d, \
-			       .bit = ETHTOOL_LINK_MODE_ ## b ## _BIT}
-
-static const struct phy_setting settings[] = {
-	/* 800G */
-	PHY_SETTING( 800000, FULL, 800000baseCR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseKR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR8_2_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseSR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseVR8_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseCR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseKR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseDR4_2_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseSR4_Full		),
-	PHY_SETTING( 800000, FULL, 800000baseVR4_Full		),
-	/* 400G */
-	PHY_SETTING( 400000, FULL, 400000baseCR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseKR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseLR8_ER8_FR8_Full	),
-	PHY_SETTING( 400000, FULL, 400000baseDR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseSR8_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseCR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseKR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseLR4_ER4_FR4_Full	),
-	PHY_SETTING( 400000, FULL, 400000baseDR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseSR4_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseCR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseKR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseDR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseDR2_2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseSR2_Full		),
-	PHY_SETTING( 400000, FULL, 400000baseVR2_Full		),
-	/* 200G */
-	PHY_SETTING( 200000, FULL, 200000baseCR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseKR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseLR4_ER4_FR4_Full	),
-	PHY_SETTING( 200000, FULL, 200000baseDR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseSR4_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseCR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseKR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseLR2_ER2_FR2_Full	),
-	PHY_SETTING( 200000, FULL, 200000baseDR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseSR2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseCR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseKR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseDR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseDR_2_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseSR_Full		),
-	PHY_SETTING( 200000, FULL, 200000baseVR_Full		),
-	/* 100G */
-	PHY_SETTING( 100000, FULL, 100000baseCR4_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseKR4_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseLR4_ER4_Full	),
-	PHY_SETTING( 100000, FULL, 100000baseSR4_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseCR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseKR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseLR2_ER2_FR2_Full	),
-	PHY_SETTING( 100000, FULL, 100000baseDR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseSR2_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseCR_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseKR_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseLR_ER_FR_Full	),
-	PHY_SETTING( 100000, FULL, 100000baseDR_Full		),
-	PHY_SETTING( 100000, FULL, 100000baseSR_Full		),
-	/* 56G */
-	PHY_SETTING(  56000, FULL,  56000baseCR4_Full	  	),
-	PHY_SETTING(  56000, FULL,  56000baseKR4_Full	  	),
-	PHY_SETTING(  56000, FULL,  56000baseLR4_Full	  	),
-	PHY_SETTING(  56000, FULL,  56000baseSR4_Full	  	),
-	/* 50G */
-	PHY_SETTING(  50000, FULL,  50000baseCR2_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseKR2_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseSR2_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseCR_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseKR_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseLR_ER_FR_Full	),
-	PHY_SETTING(  50000, FULL,  50000baseDR_Full		),
-	PHY_SETTING(  50000, FULL,  50000baseSR_Full		),
-	/* 40G */
-	PHY_SETTING(  40000, FULL,  40000baseCR4_Full		),
-	PHY_SETTING(  40000, FULL,  40000baseKR4_Full		),
-	PHY_SETTING(  40000, FULL,  40000baseLR4_Full		),
-	PHY_SETTING(  40000, FULL,  40000baseSR4_Full		),
-	/* 25G */
-	PHY_SETTING(  25000, FULL,  25000baseCR_Full		),
-	PHY_SETTING(  25000, FULL,  25000baseKR_Full		),
-	PHY_SETTING(  25000, FULL,  25000baseSR_Full		),
-	/* 20G */
-	PHY_SETTING(  20000, FULL,  20000baseKR2_Full		),
-	PHY_SETTING(  20000, FULL,  20000baseMLD2_Full		),
-	/* 10G */
-	PHY_SETTING(  10000, FULL,  10000baseCR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseER_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseKR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseKX4_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseLR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseLRM_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseR_FEC		),
-	PHY_SETTING(  10000, FULL,  10000baseSR_Full		),
-	PHY_SETTING(  10000, FULL,  10000baseT_Full		),
-	/* 5G */
-	PHY_SETTING(   5000, FULL,   5000baseT_Full		),
-	/* 2.5G */
-	PHY_SETTING(   2500, FULL,   2500baseT_Full		),
-	PHY_SETTING(   2500, FULL,   2500baseX_Full		),
-	/* 1G */
-	PHY_SETTING(   1000, FULL,   1000baseT_Full		),
-	PHY_SETTING(   1000, HALF,   1000baseT_Half		),
-	PHY_SETTING(   1000, FULL,   1000baseT1_Full		),
-	PHY_SETTING(   1000, FULL,   1000baseX_Full		),
-	PHY_SETTING(   1000, FULL,   1000baseKX_Full		),
-	/* 100M */
-	PHY_SETTING(    100, FULL,    100baseT_Full		),
-	PHY_SETTING(    100, FULL,    100baseT1_Full		),
-	PHY_SETTING(    100, HALF,    100baseT_Half		),
-	PHY_SETTING(    100, HALF,    100baseFX_Half		),
-	PHY_SETTING(    100, FULL,    100baseFX_Full		),
-	/* 10M */
-	PHY_SETTING(     10, FULL,     10baseT_Full		),
-	PHY_SETTING(     10, HALF,     10baseT_Half		),
-	PHY_SETTING(     10, FULL,     10baseT1L_Full		),
-	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
-	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
-	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
-	PHY_SETTING(     10, FULL,     10baseT1BRR_Full		),
-};
-#undef PHY_SETTING
-
-/**
- * phy_lookup_setting - lookup a PHY setting
- * @speed: speed to match
- * @duplex: duplex to match
- * @mask: allowed link modes
- * @exact: an exact match is required
- *
- * Search the settings array for a setting that matches the speed and
- * duplex, and which is supported.
- *
- * If @exact is unset, either an exact match or %NULL for no match will
- * be returned.
- *
- * If @exact is set, an exact match, the fastest supported setting at
- * or below the specified speed, the slowest supported setting, or if
- * they all fail, %NULL will be returned.
- */
-const struct phy_setting *
-phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
-{
-	const struct phy_setting *p, *match = NULL, *last = NULL;
-	int i;
-
-	for (i = 0, p = settings; i < ARRAY_SIZE(settings); i++, p++) {
-		if (p->bit < __ETHTOOL_LINK_MODE_MASK_NBITS &&
-		    test_bit(p->bit, mask)) {
-			last = p;
-			if (p->speed == speed && p->duplex == duplex) {
-				/* Exact match for speed and duplex */
-				match = p;
-				break;
-			} else if (!exact) {
-				if (!match && p->speed <= speed)
-					/* Candidate */
-					match = p;
-
-				if (p->speed < speed)
-					break;
-			}
-		}
-	}
-
-	if (!match && !exact)
-		match = last;
-
-	return match;
-}
-EXPORT_SYMBOL_GPL(phy_lookup_setting);
-
 static void __set_phy_supported(struct phy_device *phydev, u32 max_speed)
 {
 	phy_caps_linkmode_max_speed(max_speed, phydev->supported);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index b582590427bc..f66340c26982 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1317,18 +1317,6 @@ const char *phy_rate_matching_to_str(int rate_matching);
 
 int phy_interface_num_ports(phy_interface_t interface);
 
-/* A structure for mapping a particular speed and duplex
- * combination to a particular SUPPORTED and ADVERTISED value
- */
-struct phy_setting {
-	u32 speed;
-	u8 duplex;
-	u8 bit;
-};
-
-const struct phy_setting *
-phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
-		   bool exact);
 void of_set_phy_supported(struct phy_device *phydev);
 void of_set_phy_eee_broken(struct phy_device *phydev);
 void of_set_phy_timing_role(struct phy_device *phydev);
-- 
2.48.1


