Return-Path: <netdev+bounces-168763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D214A40902
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 15:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA07E7037B4
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 14:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2191B189913;
	Sat, 22 Feb 2025 14:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="I1W0EFpM"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E31E156653;
	Sat, 22 Feb 2025 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740234464; cv=none; b=B2W0P3/xmM8+uPAujsZy6CrgYYmH16pqR/gkXwNHd2Bl712Bq9r8aTHhusXC0eCFleNNrOB6aoDG5NLLhXDT7/SHHr9pdkbSrLF6gehq9vhSS/O+6NN0W+zIcELVLNMySB7FwlbkdVugh7MWiG9PIuhIeAZEjbPh+fAkf745b5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740234464; c=relaxed/simple;
	bh=hVbvG6Jha4TxcM22wKl5k4Us4w211uJsH6XiJS7rivI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNA/iC2iMDbIiOD3UhXunKwjoQZJXFZH01TUSFmQp5Jl3cu2MMtDAuuGS0hKnrDTDiRu1X6fXcrCg8vQTVs6E6GfhxiqoQlZq6T9cDxEpcz4kjXZw0laJlaG/zQAL13J2v5x4RMCTidv347a4b+DhzImPE2QxB9t/1NTIm4jDLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=I1W0EFpM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B0D14422B;
	Sat, 22 Feb 2025 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740234454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3M8fSUpOeriXILIAnN9xG5HBVWu/rX5PDNk7L69xhA=;
	b=I1W0EFpMOQ3uJhX6HrqUP8AeSuLQqt4lS/Zp+R2KjUib3ZJIwXysxnkkJ66yvkJDxcjv0f
	JHAaT0/nAT01SL4QXgrOOt43c1o3O6P1M04rm6h0+hqL0YAHz9jtPnZMAJ6xjUC+aB/nuS
	cf5UI7EN9/4O+VrP2sLC7bLFDGOlv28PrvHlJWBLYTmyZdJ2JmgPtiuuFAl9Feb3WbkfG3
	iSlG8ZM06Rb7ALnfQr5OJ4SQ/ctbuxCYdbCGCOI6jnUxnfBgExryyU5+7ujr3xks4J/Y21
	UBn3eQcGzoBuUCz17tG0l2reS0PhGAKMiH7AAz6/k3SZbg2iz5amGqp4b1GilA==
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
Subject: [PATCH net-next 01/13] net: phy: Extract the speed/duplex to linkmode conversion from phylink
Date: Sat, 22 Feb 2025 15:27:13 +0100
Message-ID: <20250222142727.894124-2-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejfeduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeevgedtffelffelveeuleelgfejfeevvdejhfehgeefgfffvdefteegvedutefftdenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgri
 igvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

Phylink uses MAC capabilities to represent the Pause, AsymPause, Speed
and Duplex capabilities of a given MAC device. These capabilities are
used internally by phylink for link validation and get a coherent set of
linkmodes that we can effectively use on a given interface.

The conversion from MAC capabilities to linkmodes is done in a dedicated
function, that associates speed/duplex to linkmodes.

As preparation work for phy_port, extract this logic away from phylink
and have it in a dedicated file that will deal with all the conversions
between capabilities, linkmodes and interfaces.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/Makefile   |   2 +-
 drivers/net/phy/phy-caps.h |  12 +++
 drivers/net/phy/phy_caps.c | 162 +++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phylink.c  | 162 ++-----------------------------------
 4 files changed, 180 insertions(+), 158 deletions(-)
 create mode 100644 drivers/net/phy/phy-caps.h
 create mode 100644 drivers/net/phy/phy_caps.c

diff --git a/drivers/net/phy/Makefile b/drivers/net/phy/Makefile
index c8dac6e92278..7e800619162b 100644
--- a/drivers/net/phy/Makefile
+++ b/drivers/net/phy/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Linux PHY drivers
 
 libphy-y			:= phy.o phy-c45.o phy-core.o phy_device.o \
-				   linkmode.o phy_link_topology.o
+				   linkmode.o phy_link_topology.o phy_caps.o
 mdio-bus-y			+= mdio_bus.o mdio_device.o
 
 ifdef CONFIG_MDIO_DEVICE
diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
new file mode 100644
index 000000000000..99c648f76dea
--- /dev/null
+++ b/drivers/net/phy/phy-caps.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * link caps internal header, for link modes <-> capabilities <-> interfaces
+ * conversions.
+ */
+
+#ifndef __PHY_CAPS_H
+#define __PHY_CAPS_H
+
+void linkmode_from_caps(unsigned long *linkmode, unsigned long caps);
+
+#endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
new file mode 100644
index 000000000000..807be1317263
--- /dev/null
+++ b/drivers/net/phy/phy_caps.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/ethtool.h>
+#include <linux/linkmode.h>
+#include <linux/phy.h>
+#include <linux/phylink.h>
+
+#include "phy-caps.h"
+
+/**
+ * linkmode_from_caps() - Convert capabilities to ethtool link modes
+ * @linkmodes: ethtool linkmode mask (must be already initialised)
+ * @caps: bitmask of MAC capabilities
+ *
+ * Set all possible pause, speed and duplex linkmodes in @linkmodes that are
+ * supported by the @caps. @linkmodes must have been initialised previously.
+ */
+
+void linkmode_from_caps(unsigned long *linkmodes, unsigned long caps)
+{
+	if (caps & MAC_SYM_PAUSE)
+		__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, linkmodes);
+
+	if (caps & MAC_ASYM_PAUSE)
+		__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, linkmodes);
+
+	if (caps & MAC_10HD) {
+		__set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_Half_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT, linkmodes);
+	}
+
+	if (caps & MAC_10FD) {
+		__set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10baseT1L_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10baseT1S_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_100HD) {
+		__set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100baseFX_Half_BIT, linkmodes);
+	}
+
+	if (caps & MAC_100FD) {
+		__set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100baseFX_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_1000HD)
+		__set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, linkmodes);
+
+	if (caps & MAC_1000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_1000baseT1_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_2500FD) {
+		__set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_2500baseX_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_5000FD)
+		__set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, linkmodes);
+
+	if (caps & MAC_10000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseKX4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseR_FEC_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseCR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseLRM_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_10000baseER_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_25000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_40000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_50000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_50000baseKR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_50000baseSR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_50000baseCR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_50000baseDR_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_56000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_56000baseKR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_56000baseCR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_56000baseSR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_56000baseLR4_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_100000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseKR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseSR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseLR_ER_FR_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseCR_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_100000baseDR_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_200000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseDR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseKR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseSR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseLR2_ER2_FR2_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseDR2_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_200000baseCR2_Full_BIT, linkmodes);
+	}
+
+	if (caps & MAC_400000FD) {
+		__set_bit(ETHTOOL_LINK_MODE_400000baseKR8_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseSR8_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseLR8_ER8_FR8_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseDR8_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseCR8_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseKR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseSR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseLR4_ER4_FR4_Full_BIT,
+			  linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseDR4_Full_BIT, linkmodes);
+		__set_bit(ETHTOOL_LINK_MODE_400000baseCR4_Full_BIT, linkmodes);
+	}
+}
+EXPORT_SYMBOL_GPL(linkmode_from_caps);
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a3b186ab3854..3b32be40073e 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -20,6 +20,7 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 
+#include "phy-caps.h"
 #include "sfp.h"
 #include "swphy.h"
 
@@ -291,159 +292,6 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	return SPEED_UNKNOWN;
 }
 
-/**
- * phylink_caps_to_linkmodes() - Convert capabilities to ethtool link modes
- * @linkmodes: ethtool linkmode mask (must be already initialised)
- * @caps: bitmask of MAC capabilities
- *
- * Set all possible pause, speed and duplex linkmodes in @linkmodes that are
- * supported by the @caps. @linkmodes must have been initialised previously.
- */
-static void phylink_caps_to_linkmodes(unsigned long *linkmodes,
-				      unsigned long caps)
-{
-	if (caps & MAC_SYM_PAUSE)
-		__set_bit(ETHTOOL_LINK_MODE_Pause_BIT, linkmodes);
-
-	if (caps & MAC_ASYM_PAUSE)
-		__set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, linkmodes);
-
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
-}
-
 static struct {
 	unsigned long mask;
 	int speed;
@@ -667,7 +515,7 @@ static void phylink_validate_mask_caps(unsigned long *supported,
 	phylink_set(mask, Autoneg);
 	caps = phylink_get_capabilities(state->interface, mac_capabilities,
 					state->rate_matching);
-	phylink_caps_to_linkmodes(mask, caps);
+	linkmode_from_caps(mask, caps);
 
 	linkmode_and(supported, supported, mask);
 	linkmode_and(state->advertising, state->advertising, mask);
@@ -961,7 +809,7 @@ static int phylink_parse_mode(struct phylink *pl,
 			caps = ~(MAC_SYM_PAUSE | MAC_ASYM_PAUSE);
 			caps = phylink_get_capabilities(pl->link_config.interface, caps,
 							RATE_MATCH_NONE);
-			phylink_caps_to_linkmodes(pl->supported, caps);
+			linkmode_from_caps(pl->supported, caps);
 			break;
 
 		default:
@@ -2232,8 +2080,8 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 
 		/* Convert the MAC's LPI capabilities to linkmodes */
 		linkmode_zero(pl->supported_lpi);
-		phylink_caps_to_linkmodes(pl->supported_lpi,
-					  pl->config->lpi_capabilities);
+		linkmode_from_caps(pl->supported_lpi,
+				   pl->config->lpi_capabilities);
 
 		/* Restrict the PHYs EEE support/advertisement to the modes
 		 * that the MAC supports.
-- 
2.48.1


