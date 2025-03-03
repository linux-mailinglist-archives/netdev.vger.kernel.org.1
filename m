Return-Path: <netdev+bounces-171129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8E3A4BA3E
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 10:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2D116D7E4
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBD01F193D;
	Mon,  3 Mar 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AHx3N9Jf"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F831F0E4B;
	Mon,  3 Mar 2025 09:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992622; cv=none; b=drNYqd3egibrqAbGsv5CdvVeLolDSej1O51crqk+VGVkZVjgoxov0lFacsHo5Biu5RhRPIiWpZ39xYqM/NV51Fow8j5xe8ge3s7hT7Oy88H0SR8np8Yxoayv998FyPqaDNb/iX1iihqP/QCADD9fkU+FlJ3rgdtXEHmIUdJe/8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992622; c=relaxed/simple;
	bh=vQes/MGmepE8M1zjLoU5TZNFHc6jabiNKr5hi0zyXS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AT6z6Lt5vDxOkBLU6vr7d0Ykw2snlVewQAoK4rxlbFl9/b45517vIh3hfHofxvrXIIydpJ1thW2UK2n/zAL0TFTwIQKEoJPlBZeeZkpIk91+JJMvVjZ0H1mJ1hFYMQY06kUqVYFcou/QB6zN+nzFnGW+VBw7JfeM86pvO0Lgu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AHx3N9Jf; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A7B1944538;
	Mon,  3 Mar 2025 09:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740992611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5MOnPR0mchEN4qQDSULtuzCrOBj+/icIObUGqnFbI0=;
	b=AHx3N9JfMIXN1WGYqcfDnQVNc+j0lqNGhBrkgBy79YDB3CRM9JKMe6atKYy4pct9gVb6bp
	+KvBUAkwpO+kvnyjfFEzRKG5/ClWqChMwDmZho05OxVWRwSXIlYN3KZojTPgiagC9htdqp
	g1S4BOaoSX7i+p/P9E4LOVySooXrkdPOxyZrWv7dlhJaBdgX/UOMucJiEYMhyk5ZsI9JdO
	55X1GerDA+EzrSxMJlToBcE9zu25m6hHelQ/JG7pi95gzfoZMx9EFpIaAZKs8f0YmHQiW6
	TCjvkxNA0VWpMTwjPq+440hb9whIr6qhMBMNrnHhNj5qCXNSOTW+WGXHnyilsA==
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
Subject: [PATCH net-next v4 03/13] net: phy: phy_caps: Move phy_speeds to phy_caps
Date: Mon,  3 Mar 2025 10:03:09 +0100
Message-ID: <20250303090321.805785-4-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Use the newly introduced link_capabilities array to derive the list of
possible speeds when given a combination of linkmodes. As
link_capabilities is indexed by speed, we don't have to iterate the
whole phy_settings array.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4: Switch to macro iterators for better readability (Russell)

 drivers/net/phy/phy-caps.h |  3 +++
 drivers/net/phy/phy-core.c | 15 ---------------
 drivers/net/phy/phy.c      |  3 ++-
 drivers/net/phy/phy_caps.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/phy.h        |  2 --
 5 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 8a0dc2c486bb..52e2fb8cabab 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -40,4 +40,7 @@ struct link_capabilities {
 
 void phy_caps_init(void);
 
+size_t phy_caps_speeds(unsigned int *speeds, size_t size,
+		       unsigned long *linkmodes);
+
 #endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index b1c1670de23b..8533e57c3500 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -339,21 +339,6 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
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
index 367ca7110ddc..827ded2729d8 100644
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
  */
@@ -76,3 +79,33 @@ void phy_caps_init(void)
 		__set_bit(i, link_caps[capa].linkmodes);
 	}
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
index 7bfbae51070a..5749aad96862 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1322,8 +1322,6 @@ struct phy_setting {
 const struct phy_setting *
 phy_lookup_setting(int speed, int duplex, const unsigned long *mask,
 		   bool exact);
-size_t phy_speeds(unsigned int *speeds, size_t size,
-		  unsigned long *mask);
 
 /**
  * phy_is_started - Convenience function to check whether PHY is started
-- 
2.48.1


