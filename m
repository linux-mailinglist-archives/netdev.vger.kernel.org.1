Return-Path: <netdev+bounces-163791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D28A2B92E
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 03:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F8A166930
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F8C149C4A;
	Fri,  7 Feb 2025 02:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iBvaCSPJ"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47A22417E0;
	Fri,  7 Feb 2025 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738896230; cv=none; b=kWdhmtzxFSOqLxAXW4YDFq9xusdZN2QvG0ZrwXqW05O16rzeBF7IKWfdM6rYsmHaKt7Ubv3gMM0jthNG1B3ef47L2fgU7mUbVi8Uws7Y9ALEQaOC4NUPCEqGnUYZ9NqA3zRZ91mJr981wLjwSr84m9hxsyr1kF/Je7RwHrVRuLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738896230; c=relaxed/simple;
	bh=OgfBQ950k/0sMsVlDFq3XldGbsBQMqbn77v12GgMcNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flxKHJiRD3xaoIPJIT1r3zLMg84EGzsSBI6qXKvZ3mz5p4eTWHI4t3iy0hQ0k2qg1oA6MQ5HrwMQS7qoABpZs4aLdnoUeYNKXAxkvW+6ZUq4KgjCi6HM3iTei9TYqH7RZpNIoBrkVQXJERlYA+yZ6fHBZYOpvpra9IFcQLtNPIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iBvaCSPJ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738896229; x=1770432229;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OgfBQ950k/0sMsVlDFq3XldGbsBQMqbn77v12GgMcNo=;
  b=iBvaCSPJ+oS4FPg6IZO4NVIKkcxDtnBO21HS8ReLXtYHqRtkcqaqXdTt
   w6pddAmQfJLu9hNnnmf3WCQyQYzE27mv1NisEXVm8x+9Bwj5mBApPASNG
   9G1xqNR8qdqsHsXIPNES5irl6wEArUYEyO9WBW+zrIFhmjnRtntLuOccX
   hBEuCrzbM3vuX/gIcRJ6HiAYn499NlMSXeXiJuVCr4WXlq+laHxVpcuPy
   xO35NUdUeKzkqm1tpntRiVEFFmO0Pdydtw40aaj+RGl1yQxS7dAwDqDr0
   UN4o8MkvupC8qzzWCNZzTObIGZlYOxAd58tD9VgyjZtXv6o8IZWOpoS7/
   w==;
X-CSE-ConnectionGUID: RFV87JRpT0eRxdofM7MUrg==
X-CSE-MsgGUID: 2Gg9JwXnR8GNNqopffxZ8A==
X-IronPort-AV: E=Sophos;i="6.13,266,1732604400"; 
   d="scan'208";a="268719544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Feb 2025 19:43:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Feb 2025 19:43:10 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 6 Feb 2025 19:43:10 -0700
From: <Tristram.Ha@microchip.com>
To: Russell King <linux@armlinux.org.uk>, Woojung Huh
	<woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH RFC net-next v2 3/3] net: dsa: microchip: Add SGMII port support to KSZ9477 switch
Date: Thu, 6 Feb 2025 18:43:16 -0800
Message-ID: <20250207024316.25334-4-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250207024316.25334-1-Tristram.Ha@microchip.com>
References: <20250207024316.25334-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

The KSZ9477 switch DSA driver uses the XPCS driver to operate its SGMII
port.  It generates a value when device ids from MDIO_MMD_PMAPMD are
checked to activate DW_XPCS_SGMII_MODE_MAC_MANUAL mode so that some
special code are used to operate the SGMII port correctly.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v2
 - remove sgmii_mutex
 - remove parentheses in returned value in sgmii check functions
 - remove sgmii reset function as this is done in XPCS driver
 - access only 1 16-bit value in SGMII MMD access functions
 - use phy_interface_or to set capabilities

 drivers/net/dsa/microchip/ksz9477.c    | 98 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h    |  4 +-
 drivers/net/dsa/microchip/ksz_common.c | 36 ++++++++--
 drivers/net/dsa/microchip/ksz_common.h | 22 +++++-
 4 files changed, 153 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 29fe79ea74cd..861a166c3b4d 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 switch driver main logic
  *
- * Copyright (C) 2017-2024 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #include <linux/kernel.h>
@@ -161,6 +161,94 @@ static int ksz9477_wait_alu_sta_ready(struct ksz_device *dev)
 					10, 1000);
 }
 
+static void port_sgmii_s(struct ksz_device *dev, uint port, u16 devid, u16 reg)
+{
+	u32 data;
+
+	data = (devid & MII_MMD_CTRL_DEVAD_MASK) << 16;
+	data |= reg;
+	ksz_pwrite32(dev, port, REG_PORT_SGMII_ADDR__4, data);
+}
+
+static void port_sgmii_r(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 *buf)
+{
+	port_sgmii_s(dev, port, devid, reg);
+	ksz_pread16(dev, port, REG_PORT_SGMII_DATA__4 + 2, buf);
+
+	/* Simulate a value to activate DW_XPCS_SGMII_MODE_MAC_MANUAL in the
+	 * XPCS driver.
+	 */
+	if (devid == MDIO_MMD_PMAPMD) {
+		if (reg == MDIO_DEVID1)
+			*buf = 0x9477;
+		else if (reg == MDIO_DEVID2)
+			*buf = 0x22 << 10;
+	}
+}
+
+static void port_sgmii_w(struct ksz_device *dev, uint port, u16 devid, u16 reg,
+			 u16 buf)
+{
+	port_sgmii_s(dev, port, devid, reg);
+	ksz_pwrite32(dev, port, REG_PORT_SGMII_DATA__4, buf);
+}
+
+static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
+{
+	struct ksz_device *dev = bus->priv;
+	int port = ksz_get_sgmii_port(dev);
+	u16 val;
+
+	port_sgmii_r(dev, port, mmd, reg, &val);
+	return val;
+}
+
+static int ksz9477_pcs_write(struct mii_bus *bus, int phy, int mmd, int reg,
+			     u16 val)
+{
+	struct ksz_device *dev = bus->priv;
+	int port = ksz_get_sgmii_port(dev);
+
+	port_sgmii_w(dev, port, mmd, reg, val);
+	return 0;
+}
+
+int ksz9477_pcs_create(struct ksz_device *dev)
+{
+	/* This chip has a SGMII port. */
+	if (ksz_has_sgmii_port(dev)) {
+		int port = ksz_get_sgmii_port(dev);
+		struct ksz_port *p = &dev->ports[port];
+		struct phylink_pcs *pcs;
+		struct mii_bus *bus;
+		int ret;
+
+		bus = devm_mdiobus_alloc(dev->dev);
+		if (!bus)
+			return -ENOMEM;
+
+		bus->name = "ksz_pcs_mdio_bus";
+		snprintf(bus->id, MII_BUS_ID_SIZE, "%s-pcs",
+			 dev_name(dev->dev));
+		bus->read_c45 = &ksz9477_pcs_read;
+		bus->write_c45 = &ksz9477_pcs_write;
+		bus->parent = dev->dev;
+		bus->phy_mask = ~0;
+		bus->priv = dev;
+
+		ret = devm_mdiobus_register(dev->dev, bus);
+		if (ret)
+			return ret;
+
+		pcs = xpcs_create_pcs_mdiodev(bus, 0);
+		if (IS_ERR(pcs))
+			return PTR_ERR(pcs);
+		p->pcs = pcs;
+	}
+	return 0;
+}
+
 int ksz9477_reset_switch(struct ksz_device *dev)
 {
 	u8 data8;
@@ -978,6 +1066,14 @@ void ksz9477_get_caps(struct ksz_device *dev, int port,
 
 	if (dev->info->gbit_capable[port])
 		config->mac_capabilities |= MAC_1000FD;
+
+	if (ksz_is_sgmii_port(dev, port)) {
+		struct ksz_port *p = &dev->ports[port];
+
+		phy_interface_or(config->supported_interfaces,
+				 config->supported_interfaces,
+				 p->pcs->supported_interfaces);
+	}
 }
 
 int ksz9477_set_ageing_time(struct ksz_device *dev, unsigned int msecs)
diff --git a/drivers/net/dsa/microchip/ksz9477.h b/drivers/net/dsa/microchip/ksz9477.h
index d2166b0d881e..0d1a6dfda23e 100644
--- a/drivers/net/dsa/microchip/ksz9477.h
+++ b/drivers/net/dsa/microchip/ksz9477.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 series Header file
  *
- * Copyright (C) 2017-2022 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_H
@@ -97,4 +97,6 @@ void ksz9477_acl_match_process_l2(struct ksz_device *dev, int port,
 				  u16 ethtype, u8 *src_mac, u8 *dst_mac,
 				  unsigned long cookie, u32 prio);
 
+int ksz9477_pcs_create(struct ksz_device *dev);
+
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 89f0796894af..bf2ce48a264e 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2,7 +2,7 @@
 /*
  * Microchip switch driver main logic
  *
- * Copyright (C) 2017-2024 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #include <linux/delay.h>
@@ -354,10 +354,26 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 					int speed, int duplex, bool tx_pause,
 					bool rx_pause);
 
+static struct phylink_pcs *
+ksz_phylink_mac_select_pcs(struct phylink_config *config,
+			   phy_interface_t interface)
+{
+	struct dsa_port *dp = dsa_phylink_to_port(config);
+	struct ksz_device *dev = dp->ds->priv;
+	struct ksz_port *p = &dev->ports[dp->index];
+
+	if (ksz_is_sgmii_port(dev, dp->index) &&
+	    (interface == PHY_INTERFACE_MODE_SGMII ||
+	    interface == PHY_INTERFACE_MODE_1000BASEX))
+		return p->pcs;
+	return NULL;
+}
+
 static const struct phylink_mac_ops ksz9477_phylink_mac_ops = {
 	.mac_config	= ksz_phylink_mac_config,
 	.mac_link_down	= ksz_phylink_mac_link_down,
 	.mac_link_up	= ksz9477_phylink_mac_link_up,
+	.mac_select_pcs	= ksz_phylink_mac_select_pcs,
 };
 
 static const struct ksz_dev_ops ksz9477_dev_ops = {
@@ -395,6 +411,7 @@ static const struct ksz_dev_ops ksz9477_dev_ops = {
 	.reset = ksz9477_reset_switch,
 	.init = ksz9477_switch_init,
 	.exit = ksz9477_switch_exit,
+	.pcs_create = ksz9477_pcs_create,
 };
 
 static const struct phylink_mac_ops lan937x_phylink_mac_ops = {
@@ -1035,8 +1052,7 @@ static const struct regmap_range ksz9477_valid_regs[] = {
 	regmap_reg_range(0x701b, 0x701b),
 	regmap_reg_range(0x701f, 0x7020),
 	regmap_reg_range(0x7030, 0x7030),
-	regmap_reg_range(0x7200, 0x7203),
-	regmap_reg_range(0x7206, 0x7207),
+	regmap_reg_range(0x7200, 0x7207),
 	regmap_reg_range(0x7300, 0x7301),
 	regmap_reg_range(0x7400, 0x7401),
 	regmap_reg_range(0x7403, 0x7403),
@@ -1552,6 +1568,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
 		.ptp_capable = true,
+		.sgmii_port = 7,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 	},
@@ -1944,6 +1961,7 @@ const struct ksz_chip_data ksz_switch_chips[] = {
 		.internal_phy	= {true, true, true, true,
 				   true, false, false},
 		.gbit_capable	= {true, true, true, true, true, true, true},
+		.sgmii_port = 7,
 		.wr_table = &ksz9477_register_set,
 		.rd_table = &ksz9477_register_set,
 	},
@@ -2067,7 +2085,7 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 
 	spin_unlock(&mib->stats64_lock);
 
-	if (dev->info->phy_errata_9477) {
+	if (dev->info->phy_errata_9477 && !ksz_is_sgmii_port(dev, port)) {
 		ret = ksz9477_errata_monitor(dev, port, raw->tx_late_col);
 		if (ret)
 			dev_err(dev->dev, "Failed to monitor transmission halt\n");
@@ -2775,6 +2793,12 @@ static int ksz_setup(struct dsa_switch *ds)
 	if (ret)
 		return ret;
 
+	if (ksz_has_sgmii_port(dev) && dev->dev_ops->pcs_create) {
+		ret = dev->dev_ops->pcs_create(dev);
+		if (ret)
+			return ret;
+	}
+
 	/* set broadcast storm protection 10% rate */
 	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
 			   BROADCAST_STORM_RATE,
@@ -3613,6 +3637,10 @@ static void ksz_phylink_mac_config(struct phylink_config *config,
 	if (dev->info->internal_phy[port])
 		return;
 
+	/* No need to configure XMII control register when using SGMII. */
+	if (ksz_is_sgmii_port(dev, port))
+		return;
+
 	if (phylink_autoneg_inband(mode)) {
 		dev_err(dev->dev, "In-band AN not supported!\n");
 		return;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index af17a9c030d4..963dd3b3909b 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /* Microchip switch driver common header
  *
- * Copyright (C) 2017-2024 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #ifndef __KSZ_COMMON_H
@@ -10,6 +10,7 @@
 #include <linux/etherdevice.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/phy.h>
 #include <linux/regmap.h>
 #include <net/dsa.h>
@@ -93,6 +94,7 @@ struct ksz_chip_data {
 	bool internal_phy[KSZ_MAX_NUM_PORTS];
 	bool gbit_capable[KSZ_MAX_NUM_PORTS];
 	bool ptp_capable;
+	u8 sgmii_port;
 	const struct regmap_access_table *wr_table;
 	const struct regmap_access_table *rd_table;
 };
@@ -141,6 +143,7 @@ struct ksz_port {
 	void *acl_priv;
 	struct ksz_irq pirq;
 	u8 num;
+	struct phylink_pcs *pcs;
 #if IS_ENABLED(CONFIG_NET_DSA_MICROCHIP_KSZ_PTP)
 	struct hwtstamp_config tstamp_config;
 	bool hwts_tx_en;
@@ -440,6 +443,8 @@ struct ksz_dev_ops {
 	int (*reset)(struct ksz_device *dev);
 	int (*init)(struct ksz_device *dev);
 	void (*exit)(struct ksz_device *dev);
+
+	int (*pcs_create)(struct ksz_device *dev);
 };
 
 struct ksz_device *ksz_switch_alloc(struct device *base, void *priv);
@@ -731,6 +736,21 @@ static inline bool is_lan937x_tx_phy(struct ksz_device *dev, int port)
 		dev->chip_id == LAN9372_CHIP_ID) && port == KSZ_PORT_4;
 }
 
+static inline int ksz_get_sgmii_port(struct ksz_device *dev)
+{
+	return dev->info->sgmii_port - 1;
+}
+
+static inline bool ksz_has_sgmii_port(struct ksz_device *dev)
+{
+	return dev->info->sgmii_port > 0;
+}
+
+static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
+{
+	return dev->info->sgmii_port == port + 1;
+}
+
 /* STP State Defines */
 #define PORT_TX_ENABLE			BIT(2)
 #define PORT_RX_ENABLE			BIT(1)
-- 
2.34.1


