Return-Path: <netdev+bounces-169782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D0EA45B43
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A52B23A4ECE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D124DFF5;
	Wed, 26 Feb 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ctCIMceL"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFB2459C1;
	Wed, 26 Feb 2025 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564580; cv=none; b=f4eQVHQUKrAdjf+VFa9CQdn5biOmFcnO5kC+TJwroL/m3c9iV3a+O4T+taFjvIU4gxrSltgIUvwloSAJjHLf+JXcrLYm8NlzLqxQW8Px1aljNrrgxvTxbxodrkZwxYQxxNHLHJYUTjDFNQb6owbQBJM9snDvk0zTfiHJGyFCJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564580; c=relaxed/simple;
	bh=tJNuoErBtwx5EyjpjSBaf7yWMPKt6cYePJ8AhlSsMo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xc+HS/9hCYM9bA2t5KpfiWgrwQM6essejM4jmk9T7MEgSBZBn+Z1aO2Sm9px9P1DLjZzV0BVCyw+BX7qurDPEGSIAo7ipPqkuxrBmGPUQiOQ/+eX4cRHKxHGWTP3RmQRI29v+U3DE0IhdTtdbS2eTjzFYTjdiCLZawpbQm5VUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ctCIMceL; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 794E94320D;
	Wed, 26 Feb 2025 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740564576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HiAT6Gdgmy6nltrsdakVDV70lKlkqVQdE/svk4iWZOA=;
	b=ctCIMceL+hVTcExsTI+xWmRmqtwMrBz23txFy2z9lIk0+D1IscPUF1PLX1Ikznq3+5A833
	MBMcfoD63wwYHMLLdMD2gSGsFszfv2agZd+e1Evfbx13wZpmpmSHXCx+Bye3ki2bodYv/8
	2KZh+XzD+dXJtTbNOr7lFIWskQd/D2Iwkp+OCerusP4/kLVItMiQbvOcufSnBmrsI0/iwT
	QV45o7H7EzYN2kCL19qqomKcfYFaBjDFZ+oK6/g8/QFf5OjwRMJSmxYSXmesFZk4Uh2fQT
	GVUtqsZdTRuKlDV24ZCbuxzppGRnXE1uPpcKGmCtgZTVrAAJmcyGF4gq1hZ/yw==
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
Subject: [PATCH net-next v2 02/13] net: phy: Use an internal, searchable storage for the linkmodes
Date: Wed, 26 Feb 2025 11:09:17 +0100
Message-ID: <20250226100929.1646454-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
References: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudettdeigfetteeileehleduhffggfeghfehhfduheeuveejtedvjeeggfffvdeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmr
 giivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

The canonical definition for all the link modes is in linux/ethtool.h,
which is complemented by the link_mode_params array stored in
net/ethtool/common.h . That array contains all the metadata about each
of these modes, including the Speed and Duplex information.

Phylib and phylink needs that information as well for internal
management of the link, which was done by duplicating that information
in locally-stored arrays and lookup functions. This makes it easy for
developpers adding new modes to forget modifying phylib and phylink
accordingly.

However, the link_mode_params array in net/ethtool/common.c is fairly
inefficient to search through, as it isn't sorted in any manner. Phylib
and phylink perform a lot of lookup operations, mostly to filter modes
by speed and/or duplex.

We therefore introduce the link_caps private array in phy_caps.c, that
indexes linkmodes in a more efficient manner. Each element associated a
tuple <speed, duplex> to a bitfield of all the linkmodes runs at these
speed/duplex.

We end-up with an array that's fairly short, easily addressable and that
it optimised for the typical use-cases of phylib/phylink.

That array is initialized at the same time as phylib. As the
link_mode_params array is part of the net stack, which phylink depends
on, it should always be accessible from phylib.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1 -> V2: - Moved the LINK_CAPA enums in phy-caps.h
	  - Fixed typos in the commit log reported by Köry
	  
 drivers/net/phy/Makefile     |  2 +-
 drivers/net/phy/phy-caps.h   | 44 ++++++++++++++++++++
 drivers/net/phy/phy_caps.c   | 78 ++++++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c |  2 +
 4 files changed, 125 insertions(+), 1 deletion(-)
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
index 000000000000..846d483269f6
--- /dev/null
+++ b/drivers/net/phy/phy-caps.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * link caps internal header, for link modes <-> capabilities <-> interfaces
+ * conversions.
+ */
+
+#ifndef __PHY_CAPS_H
+#define __PHY_CAPS_H
+
+#include <linux/ethtool.h>
+
+enum {
+	LINK_CAPA_10HD = 0,
+	LINK_CAPA_10FD,
+	LINK_CAPA_100HD,
+	LINK_CAPA_100FD,
+	LINK_CAPA_1000HD,
+	LINK_CAPA_1000FD,
+	LINK_CAPA_2500FD,
+	LINK_CAPA_5000FD,
+	LINK_CAPA_10000FD,
+	LINK_CAPA_20000FD,
+	LINK_CAPA_25000FD,
+	LINK_CAPA_40000FD,
+	LINK_CAPA_50000FD,
+	LINK_CAPA_56000FD,
+	LINK_CAPA_100000FD,
+	LINK_CAPA_200000FD,
+	LINK_CAPA_400000FD,
+	LINK_CAPA_800000FD,
+
+	__LINK_CAPA_LAST = LINK_CAPA_800000FD,
+	__LINK_CAPA_MAX,
+};
+
+struct link_capabilities {
+	int speed;
+	unsigned int duplex;
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(linkmodes);
+};
+
+void phy_caps_init(void);
+
+#endif /* __PHY_CAPS_H */
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
new file mode 100644
index 000000000000..367ca7110ddc
--- /dev/null
+++ b/drivers/net/phy/phy_caps.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/ethtool.h>
+#include <linux/linkmode.h>
+#include <linux/phy.h>
+
+#include "phy-caps.h"
+
+static struct link_capabilities link_caps[__LINK_CAPA_MAX] __ro_after_init = {
+	{ SPEED_10, DUPLEX_HALF, {0} }, /* LINK_CAPA_10HD */
+	{ SPEED_10, DUPLEX_FULL, {0} }, /* LINK_CAPA_10FD */
+	{ SPEED_100, DUPLEX_HALF, {0} }, /* LINK_CAPA_100HD */
+	{ SPEED_100, DUPLEX_FULL, {0} }, /* LINK_CAPA_100FD */
+	{ SPEED_1000, DUPLEX_HALF, {0} }, /* LINK_CAPA_1000HD */
+	{ SPEED_1000, DUPLEX_FULL, {0} }, /* LINK_CAPA_1000FD */
+	{ SPEED_2500, DUPLEX_FULL, {0} }, /* LINK_CAPA_2500FD */
+	{ SPEED_5000, DUPLEX_FULL, {0} }, /* LINK_CAPA_5000FD */
+	{ SPEED_10000, DUPLEX_FULL, {0} }, /* LINK_CAPA_10000FD */
+	{ SPEED_20000, DUPLEX_FULL, {0} }, /* LINK_CAPA_20000FD */
+	{ SPEED_25000, DUPLEX_FULL, {0} }, /* LINK_CAPA_25000FD */
+	{ SPEED_40000, DUPLEX_FULL, {0} }, /* LINK_CAPA_40000FD */
+	{ SPEED_50000, DUPLEX_FULL, {0} }, /* LINK_CAPA_50000FD */
+	{ SPEED_56000, DUPLEX_FULL, {0} }, /* LINK_CAPA_56000FD */
+	{ SPEED_100000, DUPLEX_FULL, {0} }, /* LINK_CAPA_100000FD */
+	{ SPEED_200000, DUPLEX_FULL, {0} }, /* LINK_CAPA_200000FD */
+	{ SPEED_400000, DUPLEX_FULL, {0} }, /* LINK_CAPA_400000FD */
+	{ SPEED_800000, DUPLEX_FULL, {0} }, /* LINK_CAPA_800000FD */
+};
+
+static int speed_duplex_to_capa(int speed, unsigned int duplex)
+{
+	if (duplex == DUPLEX_UNKNOWN ||
+	    (speed > SPEED_1000 && duplex != DUPLEX_FULL))
+		return -EINVAL;
+
+	switch (speed) {
+	case SPEED_10: return duplex == DUPLEX_FULL ?
+			      LINK_CAPA_10FD : LINK_CAPA_10HD;
+	case SPEED_100: return duplex == DUPLEX_FULL ?
+			       LINK_CAPA_100FD : LINK_CAPA_100HD;
+	case SPEED_1000: return duplex == DUPLEX_FULL ?
+				LINK_CAPA_1000FD : LINK_CAPA_1000HD;
+	case SPEED_2500: return LINK_CAPA_2500FD;
+	case SPEED_5000: return LINK_CAPA_5000FD;
+	case SPEED_10000: return LINK_CAPA_10000FD;
+	case SPEED_20000: return LINK_CAPA_20000FD;
+	case SPEED_25000: return LINK_CAPA_25000FD;
+	case SPEED_40000: return LINK_CAPA_40000FD;
+	case SPEED_50000: return LINK_CAPA_50000FD;
+	case SPEED_56000: return LINK_CAPA_56000FD;
+	case SPEED_100000: return LINK_CAPA_100000FD;
+	case SPEED_200000: return LINK_CAPA_200000FD;
+	case SPEED_400000: return LINK_CAPA_400000FD;
+	case SPEED_800000: return LINK_CAPA_800000FD;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
+ */
+void phy_caps_init(void)
+{
+	const struct link_mode_info *linkmode;
+	int i, capa;
+
+	/* Fill the caps array from net/ethtool/common.c */
+	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
+		linkmode = &link_mode_params[i];
+		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
+
+		if (capa < 0)
+			continue;
+
+		__set_bit(i, link_caps[capa].linkmodes);
+	}
+}
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index a38d399f244b..9c573555ac49 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -42,6 +42,7 @@
 #include <linux/unistd.h>
 
 #include "phylib-internal.h"
+#include "phy-caps.h"
 
 MODULE_DESCRIPTION("PHY library");
 MODULE_AUTHOR("Andy Fleming");
@@ -3795,6 +3796,7 @@ static int __init phy_init(void)
 	if (rc)
 		goto err_ethtool_phy_ops;
 
+	phy_caps_init();
 	features_init();
 
 	rc = phy_driver_register(&genphy_c45_driver, THIS_MODULE);
-- 
2.48.1


