Return-Path: <netdev+bounces-173031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27461A56F2B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF2176735
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2FC242927;
	Fri,  7 Mar 2025 17:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gYJp48E+"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6762417D7;
	Fri,  7 Mar 2025 17:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368984; cv=none; b=g/bMBA5O9OBNXljuv9YNbmfx8kpogBz4NZ+M4e8eVpT3k8dnedv2+S2YnOPjyDzvdF9N/jGXN8pJ9X9qqjrf9SwcgEz2vaoRjn0QrYiXSsuFE32fcprTfQ71EzHElL8Ft2F9zy1pQyf7YWlaDGjBG6c+hTX6kYmTIooKyoyEhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368984; c=relaxed/simple;
	bh=3cfTj/9vSoIBmywXXf1X3IeRM7/+0e9rVORV6zN+1X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvdk1OcYsUQt3dDq6s59LZ95+gEo0XSMemuyEfQXo75w1JFJ5oZMwT0lq7n5QYFQ5NBh/OgAGldXn+8SPlSFmThAVpJYkYJk5APBw/h2zMiIERti4XWriHYz8psAsMpDCS+jSzgcSjpOg8Ce8Odi43/Q0btMBrprOb3CR0JZklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gYJp48E+; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E452204CC;
	Fri,  7 Mar 2025 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XPDgnRDoWQel8ibR+WlIsojFp8JuySYKgsG+4W+VtY=;
	b=gYJp48E+J63SzgYxdF97+2OJMP7vVJ+WIp0VJL52PPXVaE39dhtxSexFo+nkFvoB1H9g++
	5sy/dxaWEEy+nMkyiBeskDfI6zJwkegiX61OENPm53HwVpdRLzzJKDo9pur/QLYKBQ8Ggz
	M9V190fb6GTeIcDrptlbtaNnwEM7+yV+OA/Lhl+ueTLh/b6LV0jMwnM3HOSZnShyeDSWFl
	MSg4bRnIc0QSvW/tNUO4oPZ6z8myGtKcZMqvsJj+Zsb8q0VKXg/1SHqrYR9mXWIqiIb0V4
	/6bJOMb3+BvXE1zqmiAWy1ef+DkoKfnnYwk+kSLbpi+IZMFQXsBU56AekJFF5A==
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
Subject: [PATCH net-next v5 04/13] net: phy: phy_caps: Move __set_linkmode_max_speed to phy_caps
Date: Fri,  7 Mar 2025 18:36:01 +0100
Message-ID: <20250307173611.129125-5-maxime.chevallier@bootlin.com>
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

Convert the __set_linkmode_max_speed to use the link_capabilities array.
This makes it easy to clamp the linkmodes to a given max speed.
Introduce a new helper phy_caps_linkmode_max_speed to replace the
previous one that used phy_settings.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  2 ++
 drivers/net/phy/phy-core.c | 18 +++---------------
 drivers/net/phy/phy_caps.c | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 5a5f4ee3006b..1bef9cca62c5 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -42,5 +42,7 @@ int phy_caps_init(void);
 
 size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 		       unsigned long *linkmodes);
+void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
+
 
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 542e9284d207..af2463e67cea 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -8,6 +8,7 @@
 
 #include "phylib.h"
 #include "phylib-internal.h"
+#include "phy-caps.h"
 
 /**
  * phy_speed_to_str - Return a string representing the PHY link speed
@@ -340,22 +341,9 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
 }
 EXPORT_SYMBOL_GPL(phy_lookup_setting);
 
-static void __set_linkmode_max_speed(u32 max_speed, unsigned long *addr)
-{
-	const struct phy_setting *p;
-	int i;
-
-	for (i = 0, p = settings; i < ARRAY_SIZE(settings); i++, p++) {
-		if (p->speed > max_speed)
-			linkmode_clear_bit(p->bit, addr);
-		else
-			break;
-	}
-}
-
 static void __set_phy_supported(struct phy_device *phydev, u32 max_speed)
 {
-	__set_linkmode_max_speed(max_speed, phydev->supported);
+	phy_caps_linkmode_max_speed(max_speed, phydev->supported);
 }
 
 /**
@@ -558,7 +546,7 @@ int phy_speed_down_core(struct phy_device *phydev)
 	if (min_common_speed == SPEED_UNKNOWN)
 		return -EINVAL;
 
-	__set_linkmode_max_speed(min_common_speed, phydev->advertising);
+	phy_caps_linkmode_max_speed(min_common_speed, phydev->advertising);
 
 	return 0;
 }
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 8ce91257160f..d43493884ff7 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -60,6 +60,9 @@ static int speed_duplex_to_capa(int speed, unsigned int duplex)
 #define for_each_link_caps_asc_speed(cap) \
 	for (cap = link_caps; cap < &link_caps[__LINK_CAPA_MAX]; cap++)
 
+#define for_each_link_caps_desc_speed(cap) \
+	for (cap = &link_caps[__LINK_CAPA_MAX - 1]; cap >= link_caps; cap--)
+
 /**
  * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
  *
@@ -121,3 +124,19 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 
 	return count;
 }
+
+/**
+ * phy_caps_linkmode_max_speed() - Clamp a linkmodes set to a max speed
+ * @max_speed: Speed limit for the linkmode set
+ * @linkmodes: Linkmodes to limit
+ */
+void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes)
+{
+	struct link_capabilities *lcap;
+
+	for_each_link_caps_desc_speed(lcap)
+		if (lcap->speed > max_speed)
+			linkmode_andnot(linkmodes, linkmodes, lcap->linkmodes);
+		else
+			break;
+}
-- 
2.48.1


