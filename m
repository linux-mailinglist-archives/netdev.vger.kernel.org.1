Return-Path: <netdev+bounces-173040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D98A56F3E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 18:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090E13B84AD
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1B62512CF;
	Fri,  7 Mar 2025 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CWYu9IxP"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C13924FC03;
	Fri,  7 Mar 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741368994; cv=none; b=rkle1AYHyaekrGJVr9IL2X9u/hmCShG/fdxwQrMwp6rVULZZFU+NdQmbNtKQVMa6x35iBdRrRBRChAhWu93bIGtyKH8w4G/vQVNy/ac4fieV5gR6+LqM8B6gDpUs55FyZmm+/BqyfLqBwYci9pHTE1P9hCAW9NH5MV37xFeE7Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741368994; c=relaxed/simple;
	bh=4hAGK/uWg4m6SbIs/NRdf+2y8h7tV4dC3vStnycNv2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hWqBkuA0iilSU3WqJzS/c3trbUu9d0++IQOXgvc4R0lRM0T4ErF0pkQMYl2oJm6ooH53ro2ghAYMLTEYwO/Wx9wiC5xHc9LPidb89SgxnWJsVeYoB7lY9kV8xmmL2vDQPrRcMDaKvWB6hu0LQXV5c9TQXvZ/Rjam8+32h8ADRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CWYu9IxP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0024220581;
	Fri,  7 Mar 2025 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741368991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gWeqvh8QTIhH2uGBkRVJadWUIdnz/egznXSfSJY0rjs=;
	b=CWYu9IxP+MkP/3cXsHHgzYL1REjvSHiwyDQCL/2PhhDxz8cMCQCVpOHSvep0/+BdEG0csK
	phaOhJZNn8qC6rp/87TD4ihpDYjy29zaS0Tr0ybv1uvsJH6s0QYJNKg2sAnVOc2XZdQjs7
	PsZNUBscIpZ3ynbRT851nqZAmv0z32ZOrLqQbQ+Zr4gkvPjVgAzvt6CnLJHPTqjoQ3vWP3
	EGsRu0nukXTR8PO7l6UKYHBpxsK0vn3S0Jv0OOyr9CHhIESUqgE8b5Z4EUR4alhPJNCumn
	oCv5h+KNrwv7DfnuB39ZFWjmEscZ96njK6uPycMu+KDtaCLYW10/0biJFeypQw==
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
Subject: [PATCH net-next v5 13/13] net: phylink: Use phy_caps to get an interface's capabilities and modes
Date: Fri,  7 Mar 2025 18:36:10 +0100
Message-ID: <20250307173611.129125-14-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgepuddvnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughum
 hgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Phylink has internal code to get the MAC capabilities of a given PHY
interface (what are the supported speed and duplex).

Extract that into phy_caps, but use the link_capa for conversion. Add an
internal phylink helper for the link caps -> mac caps conversion, and
use this in phylink_caps_to_linkmodes().

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V5: Rename the patch with the phylink prefix

 drivers/net/phy/phy-caps.h |  4 ++
 drivers/net/phy/phy_caps.c | 92 ++++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c  | 90 ++++++-------------------------------
 3 files changed, 110 insertions(+), 76 deletions(-)

diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
index 7fc930876e33..157759966650 100644
--- a/drivers/net/phy/phy-caps.h
+++ b/drivers/net/phy/phy-caps.h
@@ -8,6 +8,7 @@
 #define __PHY_CAPS_H
 
 #include <linux/ethtool.h>
+#include <linux/phy.h>
 
 enum {
 	LINK_CAPA_10HD = 0,
@@ -32,6 +33,8 @@ enum {
 	__LINK_CAPA_MAX,
 };
 
+#define LINK_CAPA_ALL	GENMASK((__LINK_CAPA_MAX - 1), 0)
+
 struct link_capabilities {
 	int speed;
 	unsigned int duplex;
@@ -45,6 +48,7 @@ size_t phy_caps_speeds(unsigned int *speeds, size_t size,
 void phy_caps_linkmode_max_speed(u32 max_speed, unsigned long *linkmodes);
 bool phy_caps_valid(int speed, int duplex, const unsigned long *linkmodes);
 void phy_caps_linkmodes(unsigned long caps, unsigned long *linkmodes);
+unsigned long phy_caps_from_interface(phy_interface_t interface);
 
 const struct link_capabilities *
 phy_caps_lookup_by_linkmode(const unsigned long *linkmodes);
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index fc1568f83c1a..703321689726 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -265,3 +265,95 @@ void phy_caps_linkmodes(unsigned long caps, unsigned long *linkmodes)
 		linkmode_or(linkmodes, linkmodes, link_caps[capa].linkmodes);
 }
 EXPORT_SYMBOL_GPL(phy_caps_linkmodes);
+
+/**
+ * phy_caps_from_interface() - Get the link capa from a given PHY interface
+ * @interface: The PHY interface we want to get the possible Speed/Duplex from
+ *
+ * Returns: A bitmask of LINK_CAPA_xxx values that can be achieved with the
+ *          provided interface.
+ */
+unsigned long phy_caps_from_interface(phy_interface_t interface)
+{
+	unsigned long link_caps = 0;
+
+	switch (interface) {
+	case PHY_INTERFACE_MODE_USXGMII:
+		link_caps |= BIT(LINK_CAPA_10000FD) | BIT(LINK_CAPA_5000FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_10G_QXGMII:
+		link_caps |= BIT(LINK_CAPA_2500FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_PSGMII:
+	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_GMII:
+		link_caps |= BIT(LINK_CAPA_1000HD) | BIT(LINK_CAPA_1000FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_REVRMII:
+	case PHY_INTERFACE_MODE_RMII:
+	case PHY_INTERFACE_MODE_SMII:
+	case PHY_INTERFACE_MODE_REVMII:
+	case PHY_INTERFACE_MODE_MII:
+		link_caps |= BIT(LINK_CAPA_10HD) | BIT(LINK_CAPA_10FD);
+		fallthrough;
+
+	case PHY_INTERFACE_MODE_100BASEX:
+		link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
+		break;
+
+	case PHY_INTERFACE_MODE_TBI:
+	case PHY_INTERFACE_MODE_MOCA:
+	case PHY_INTERFACE_MODE_RTBI:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		link_caps |= BIT(LINK_CAPA_1000HD);
+		fallthrough;
+	case PHY_INTERFACE_MODE_1000BASEKX:
+	case PHY_INTERFACE_MODE_TRGMII:
+		link_caps |= BIT(LINK_CAPA_1000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_2500BASEX:
+		link_caps |= BIT(LINK_CAPA_2500FD);
+		break;
+
+	case PHY_INTERFACE_MODE_5GBASER:
+		link_caps |= BIT(LINK_CAPA_5000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_RXAUI:
+	case PHY_INTERFACE_MODE_XAUI:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_10GKR:
+		link_caps |= BIT(LINK_CAPA_10000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_25GBASER:
+		link_caps |= BIT(LINK_CAPA_25000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_XLGMII:
+		link_caps |= BIT(LINK_CAPA_40000FD);
+		break;
+
+	case PHY_INTERFACE_MODE_INTERNAL:
+		link_caps |= LINK_CAPA_ALL;
+		break;
+
+	case PHY_INTERFACE_MODE_NA:
+	case PHY_INTERFACE_MODE_MAX:
+		break;
+	}
+
+	return link_caps;
+}
+EXPORT_SYMBOL_GPL(phy_caps_from_interface);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a75aad5e4563..08a2f0f7c08e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -335,6 +335,18 @@ static unsigned long phylink_caps_to_link_caps(unsigned long caps)
 	return link_caps;
 }
 
+static unsigned long phylink_link_caps_to_mac_caps(unsigned long link_caps)
+{
+	unsigned long caps = 0;
+	int i;
+
+	for (i = 0; i <  ARRAY_SIZE(phylink_caps_params); i++)
+		if (link_caps & phylink_caps_params[i].caps_bit)
+			caps |= phylink_caps_params[i].mask;
+
+	return caps;
+}
+
 /**
  * phylink_caps_to_linkmodes() - Convert capabilities to ethtool link modes
  * @linkmodes: ethtool linkmode mask (must be already initialised)
@@ -412,86 +424,12 @@ static unsigned long phylink_get_capabilities(phy_interface_t interface,
 					      unsigned long mac_capabilities,
 					      int rate_matching)
 {
+	unsigned long link_caps = phy_caps_from_interface(interface);
 	int max_speed = phylink_interface_max_speed(interface);
 	unsigned long caps = MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
 	unsigned long matched_caps = 0;
 
-	switch (interface) {
-	case PHY_INTERFACE_MODE_USXGMII:
-		caps |= MAC_10000FD | MAC_5000FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_10G_QXGMII:
-		caps |= MAC_2500FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_RGMII_TXID:
-	case PHY_INTERFACE_MODE_RGMII_RXID:
-	case PHY_INTERFACE_MODE_RGMII_ID:
-	case PHY_INTERFACE_MODE_RGMII:
-	case PHY_INTERFACE_MODE_PSGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
-	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_GMII:
-		caps |= MAC_1000HD | MAC_1000FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_REVRMII:
-	case PHY_INTERFACE_MODE_RMII:
-	case PHY_INTERFACE_MODE_SMII:
-	case PHY_INTERFACE_MODE_REVMII:
-	case PHY_INTERFACE_MODE_MII:
-		caps |= MAC_10HD | MAC_10FD;
-		fallthrough;
-
-	case PHY_INTERFACE_MODE_100BASEX:
-		caps |= MAC_100HD | MAC_100FD;
-		break;
-
-	case PHY_INTERFACE_MODE_TBI:
-	case PHY_INTERFACE_MODE_MOCA:
-	case PHY_INTERFACE_MODE_RTBI:
-	case PHY_INTERFACE_MODE_1000BASEX:
-		caps |= MAC_1000HD;
-		fallthrough;
-	case PHY_INTERFACE_MODE_1000BASEKX:
-	case PHY_INTERFACE_MODE_TRGMII:
-		caps |= MAC_1000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_2500BASEX:
-		caps |= MAC_2500FD;
-		break;
-
-	case PHY_INTERFACE_MODE_5GBASER:
-		caps |= MAC_5000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_XGMII:
-	case PHY_INTERFACE_MODE_RXAUI:
-	case PHY_INTERFACE_MODE_XAUI:
-	case PHY_INTERFACE_MODE_10GBASER:
-	case PHY_INTERFACE_MODE_10GKR:
-		caps |= MAC_10000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_25GBASER:
-		caps |= MAC_25000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_XLGMII:
-		caps |= MAC_40000FD;
-		break;
-
-	case PHY_INTERFACE_MODE_INTERNAL:
-		caps |= ~0;
-		break;
-
-	case PHY_INTERFACE_MODE_NA:
-	case PHY_INTERFACE_MODE_MAX:
-		break;
-	}
+	caps |= phylink_link_caps_to_mac_caps(link_caps);
 
 	switch (rate_matching) {
 	case RATE_MATCH_OPEN_LOOP:
-- 
2.48.1


