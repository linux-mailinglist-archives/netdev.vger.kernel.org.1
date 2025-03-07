Return-Path: <netdev+bounces-173029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11523A56F28
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D468176F97
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125D42417F8;
	Fri,  7 Mar 2025 17:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mAiQp2+y"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322424167A;
	Fri,  7 Mar 2025 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368983; cv=none; b=OaMtOmCQxab5GYV04JabTxGvCzAwxRzIu5f1ocBJ6jtkTb6n1QXeEqhbqfqxeO10PqPdWUAh5MXbctzYCk6HJrWQSGtp0W3UtjsZFB8elNz9kayKtzrC4ysAxFxrTWfPbYV4+W+iVZgeYlgGE1klWwWrUGZo+18tFEoAN2HSBXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368983; c=relaxed/simple;
	bh=E4OR015MOnz4KW/EkDuuBPLfMhsZ3SstGrwprglPnuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWkqn8pBJFFzSjYE9GYtJpr5TnVj70dlrTxubCEmfhHie7Lep34oYPHcL6MXenO8P++SPVdE9EjLOjRdIeu45PcF9CmZg4BuDHqFaKR2YVCG5V0yG1oktHzn0z4D2Dt/wewX/jyyFK7lErMbo1CYH8n3YcCxZQOLZ1Xxf0S75zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mAiQp2+y; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C635204CF;
	Fri,  7 Mar 2025 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=we2vjGe2rMyWwNUBhS76n+GMxFZ67228QyLFHYW9fhQ=;
	b=mAiQp2+ylUQVqTnLaOtJQ/AGCqoYzlYgvPVcF8NAxd7DE3TPCwHNJ1xa6F0fzjo9waAjr0
	+Tq3IL6XfhV7orQQZ1PYB4EGUYnLcFItLI7GzPMOrQrT+c/op6T10VFCbw9e6/QpRZeCzW
	dC3HcZtiiZCwm6HY7XMColOnBDkdO2T3QO/VwMFr8Nokjf4XnLzjOuBIvVgjfxvgMKQO7B
	4hf3MRR1TMNhqBdzIWjNFD2gPPZk4FpFfRbus6PMydR2MQpO/K813bqtvvI1qTkxO48guQ
	ts66vg8N5X15RuUltqh01cNiaewc2B+mDBdxvyceFKLx2MkhSQVihIZJ1+k2qw==
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
Subject: [PATCH net-next v5 03/13] net: phy: phy_caps: Move phy_speeds to phy_caps
Date: Fri,  7 Mar 2025 18:36:00 +0100
Message-ID: <20250307173611.129125-4-maxime.chevallier@bootlin.com>
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

Use the newly introduced link_capabilities array to derive the list of
possible speeds when given a combination of linkmodes. As
link_capabilities is indexed by speed, we don't have to iterate the
whole phy_settings array.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phy-caps.h |  3 +++
 drivers/net/phy/phy-core.c | 15 ---------------
 drivers/net/phy/phy.c      |  3 ++-
 drivers/net/phy/phy_caps.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  2 --
 5 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 6024f1d11a93..5a5f4ee3006b 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -40,4 +40,7 @@ struct link_capabilities {
 
 int phy_caps_init(void);
 
+size_t phy_caps_speeds(unsigned int *speeds, size_t size,
+		       unsigned long *linkmodes);
+
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 154d29be6293..542e9284d207 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -340,21 +340,6 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
 }
 EXPORT_SYMBOL_GPL(phy_lookup_setting);
 
-size_t phy_speeds(unsigned int *speeds, size_t size,
-		  unsigned long *mask)
-{
-	size_t count;
-	int i;
-
-	for (i = 0, count = 0; i < ARRAY_SIZE(settings) && count < size; i++)
-		if (settings[i].bit < __ETHTOOL_LINK_MODE_MASK_NBITS &&
-		    test_bit(settings[i].bit, mask) &&
-		    (count == 0 || speeds[count - 1] != settings[i].speed))
-			speeds[count++] = settings[i].speed;
-
-	return count;
-}
-
 static void __set_linkmode_max_speed(u32 max_speed, unsigned long *addr)
 {
 	const struct phy_setting *p;
diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 16ffc00b419c..3128df03feda 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -37,6 +37,7 @@
 #include <net/sock.h>
 
 #include "phylib-internal.h"
+#include "phy-caps.h"
 
 #define PHY_STATE_TIME	HZ
 
@@ -245,7 +246,7 @@ unsigned int phy_supported_speeds(struct phy_device *phy,
 				  unsigned int *speeds,
 				  unsigned int size)
 {
-	return phy_speeds(speeds, size, phy->supported);
+	return phy_caps_speeds(speeds, size, phy->supported);
 }
 
 /**
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 6cb18e216d97..8ce91257160f 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -57,6 +57,9 @@ static int speed_duplex_to_capa(int speed, unsigned int duplex)
 	return -EINVAL;
 }
 
+#define for_each_link_caps_asc_speed(cap) \
+	for (cap = link_caps; cap < &link_caps[__LINK_CAPA_MAX]; cap++)
+
 /**
  * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
  *
@@ -88,3 +91,33 @@ int phy_caps_init(void)
 
 	return 0;
 }
+
+/**
+ * phy_caps_speeds() - Fill an array of supported SPEED_* values for given modes
+ * @speeds: Output array to store the speeds list into
+ * @size: Size of the output array
+ * @linkmodes: Linkmodes to get the speeds from
+ *
+ * Fills the speeds array with all possible speeds that can be achieved with
+ * the specified linkmodes.
+ *
+ * Returns: The number of speeds filled into the array. If the input array isn't
+ *	    big enough to store all speeds, fill it as much as possible.
+ */
+size_t phy_caps_speeds(unsigned int *speeds, size_t size,
+		       unsigned long *linkmodes)
+{
+	struct link_capabilities *lcap;
+	size_t count = 0;
+
+	for_each_link_caps_asc_speed(lcap) {
+		if (linkmode_intersects(lcap->linkmodes, linkmodes) &&
+		    (count == 0 || speeds[count - 1] != lcap->speed)) {
+			speeds[count++] = lcap->speed;
+			if (count >= size)
+				break;
+		}
+	}
+
+	return count;
+}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index c4a6385faf41..99c195fa3695 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1287,8 +1287,6 @@ struct phy_setting {
 const struct phy_setting *
 phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
 		   bool exact);
-size_t phy_speeds(unsigned int *speeds, size_t size,
-		  unsigned long *mask);
 
 /**
  * phy_is_started - Convenience function to check whether PHY is started
-- 
2.48.1


