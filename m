Return-Path: <netdev+bounces-235701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D4C33D94
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 04:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E1A4203B3
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 03:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6A221FA0;
	Wed,  5 Nov 2025 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0UUPHrVy"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A81DED42;
	Wed,  5 Nov 2025 03:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762313877; cv=none; b=NoOuVui29YPpCdhK9HPEDCgVlegaMtROB7sbqMXvUZywFYQ9NRVF2xxyY6l/PZXpls9VgWRcO4qhVwxIGQlR/IyBIdH8WDCsMVDGntPGr2/D4Mt0hQUas089tNvSHu+u1e2clymaq8RirjWQZU5BqmDhhJm1GVvI48Q2kkXl/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762313877; c=relaxed/simple;
	bh=5APbX8nC0EgqBYBRur3ANJ9lbqie0uPkIEEM+6nXuZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UQ2K4n6TWoG/iSN9JTN7C85UnSmJlv2KDgpMePpbo6TzvMlk8YBHUzgH5gx8XX/aULetIkMT6h6hmfeyg0Rnf7D5lE1EISggx/CLotfHptiGAnbJB/bDyP3OxNR5Q7NG7PasiJcyu4S9ZUGfChaK2bQOfdbiG2PXJ+feduA4RAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0UUPHrVy; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762313875; x=1793849875;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5APbX8nC0EgqBYBRur3ANJ9lbqie0uPkIEEM+6nXuZk=;
  b=0UUPHrVyPa9QBYZldU4qWdF6O+248KvmT8zrJQce9eQhglJrA+CL5Is/
   Y7fK2nQ0g79TyODffl5Hi/yBFBotVB3YaferrBfEpVPFD4S+2Szv1ugnb
   qXM3QT4zZ5T98cgXBsjsCTxDzuEK+aVdKnCpeyH6w+TMoErgNZctG3pfQ
   vI3/tef8WieyKWnSLuiflG/BGe30j2bODTq2/JkrB7B4S9gtgaNJ7LmAm
   5cE1HfMDIGKuqPJ8oDkQkoGmq1KWCWvyiBYyOfufJSUIq06bMK+pLgsl6
   knKT+El3tm0T7eitkDqJfcioctr12T7FMLJUhfgWPzAT2i7kcSudaTiIf
   A==;
X-CSE-ConnectionGUID: MH33LE4+R32TIjAv3cJ5zw==
X-CSE-MsgGUID: TIj8QXDtQJOnnxY6qhiT5w==
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="48697233"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 20:37:55 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 20:37:14 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 20:37:13 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
	<arun.ramadoss@microchip.com>, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
	<olteanv@gmail.com>
CC: Oleksij Rempel <linux@rempel-privat.de>,
	=?UTF-8?q?=C5=81ukasz=20Majewski?= <lukma@nabladev.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Tristram Ha <tristram.ha@microchip.com>
Subject: [PATCH net v2] net: dsa: microchip: Fix reserved multicast address table programming
Date: Tue, 4 Nov 2025 19:37:41 -0800
Message-ID: <20251105033741.6455-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Tristram Ha <tristram.ha@microchip.com>

KSZ9477/KSZ9897 and LAN937X families of switches use a reserved multicast
address table for some specific forwarding with some multicast addresses,
like the one used in STP.  The hardware assumes the host port is the last
port in KSZ9897 family and port 5 in LAN937X family.  Most of the time
this assumption is correct but not in other cases like KSZ9477.
Originally the function just setups the first entry, but the others still
need update, especially for one common multicast address that is used by
PTP operation.

LAN937x also uses different register bits when accessing the reserved
table.

Fixes: 457c182af597 ("net: dsa: microchip: generic access to ksz9477 static and reserved table")
Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
Tested-by: Łukasz Majewski <lukma@nabladev.com>
---
 v2
  - use a define for the multicast table entry count
  - do not check entries for portmap as software knows the final mapping

 drivers/net/dsa/microchip/ksz9477.c     | 98 +++++++++++++++++++++----
 drivers/net/dsa/microchip/ksz9477_reg.h |  3 +-
 drivers/net/dsa/microchip/ksz_common.c  |  4 +
 drivers/net/dsa/microchip/ksz_common.h  |  2 +
 4 files changed, 91 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index d747ea1c41a7..5df8f153d511 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1355,9 +1355,15 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds)
 	}
 }
 
+#define RESV_MCAST_CNT	8
+
+static u8 reserved_mcast_map[RESV_MCAST_CNT] = { 0, 1, 3, 16, 32, 33, 2, 17 };
+
 int ksz9477_enable_stp_addr(struct ksz_device *dev)
 {
+	u8 i, ports, update;
 	const u32 *masks;
+	bool override;
 	u32 data;
 	int ret;
 
@@ -1366,23 +1372,87 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
 	/* Enable Reserved multicast table */
 	ksz_cfg(dev, REG_SW_LUE_CTRL_0, SW_RESV_MCAST_ENABLE, true);
 
-	/* Set the Override bit for forwarding BPDU packet to CPU */
-	ret = ksz_write32(dev, REG_SW_ALU_VAL_B,
-			  ALU_V_OVERRIDE | BIT(dev->cpu_port));
-	if (ret < 0)
-		return ret;
+	/* The reserved multicast address table has 8 entries.  Each entry has
+	 * a default value of which port to forward.  It is assumed the host
+	 * port is the last port in most of the switches, but that is not the
+	 * case for KSZ9477 or maybe KSZ9897.  For LAN937X family the default
+	 * port is port 5, the first RGMII port.  It is okay for LAN9370, a
+	 * 5-port switch, but may not be correct for the other 8-port
+	 * versions.  It is necessary to update the whole table to forward to
+	 * the right ports.
+	 * Furthermore PTP messages can use a reserved multicast address and
+	 * the host will not receive them if this table is not correct.
+	 */
+	for (i = 0; i < RESV_MCAST_CNT; i++) {
+		data = reserved_mcast_map[i] <<
+			dev->info->shifts[ALU_STAT_INDEX];
+		data |= ALU_STAT_START |
+			masks[ALU_STAT_DIRECT] |
+			masks[ALU_RESV_MCAST_ADDR] |
+			masks[ALU_STAT_READ];
+		ret = ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4, data);
+		if (ret < 0)
+			return ret;
 
-	data = ALU_STAT_START | ALU_RESV_MCAST_ADDR | masks[ALU_STAT_WRITE];
+		/* wait to be finished */
+		ret = ksz9477_wait_alu_sta_ready(dev);
+		if (ret < 0)
+			return ret;
 
-	ret = ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4, data);
-	if (ret < 0)
-		return ret;
+		ret = ksz_read32(dev, REG_SW_ALU_VAL_B, &data);
+		if (ret < 0)
+			return ret;
 
-	/* wait to be finished */
-	ret = ksz9477_wait_alu_sta_ready(dev);
-	if (ret < 0) {
-		dev_err(dev->dev, "Failed to update Reserved Multicast table\n");
-		return ret;
+		override = false;
+		ports = data & dev->port_mask;
+		switch (i) {
+		case 0:
+		case 6:
+			/* Change the host port. */
+			update = BIT(dev->cpu_port);
+			override = true;
+			break;
+		case 2:
+			/* Change the host port. */
+			update = BIT(dev->cpu_port);
+			break;
+		case 4:
+		case 5:
+		case 7:
+			/* Skip the host port. */
+			update = dev->port_mask & ~BIT(dev->cpu_port);
+			break;
+		default:
+			update = ports;
+			break;
+		}
+		if (update != ports || override) {
+			data &= ~dev->port_mask;
+			data |= update;
+			/* Set Override bit to receive frame even when port is
+			 * closed.
+			 */
+			if (override)
+				data |= ALU_V_OVERRIDE;
+			ret = ksz_write32(dev, REG_SW_ALU_VAL_B, data);
+			if (ret < 0)
+				return ret;
+
+			data = reserved_mcast_map[i] <<
+			       dev->info->shifts[ALU_STAT_INDEX];
+			data |= ALU_STAT_START |
+				masks[ALU_STAT_DIRECT] |
+				masks[ALU_RESV_MCAST_ADDR] |
+				masks[ALU_STAT_WRITE];
+			ret = ksz_write32(dev, REG_SW_ALU_STAT_CTRL__4, data);
+			if (ret < 0)
+				return ret;
+
+			/* wait to be finished */
+			ret = ksz9477_wait_alu_sta_ready(dev);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;
diff --git a/drivers/net/dsa/microchip/ksz9477_reg.h b/drivers/net/dsa/microchip/ksz9477_reg.h
index ff579920078e..61ea11e3338e 100644
--- a/drivers/net/dsa/microchip/ksz9477_reg.h
+++ b/drivers/net/dsa/microchip/ksz9477_reg.h
@@ -2,7 +2,7 @@
 /*
  * Microchip KSZ9477 register definitions
  *
- * Copyright (C) 2017-2024 Microchip Technology Inc.
+ * Copyright (C) 2017-2025 Microchip Technology Inc.
  */
 
 #ifndef __KSZ9477_REGS_H
@@ -397,7 +397,6 @@
 
 #define ALU_RESV_MCAST_INDEX_M		(BIT(6) - 1)
 #define ALU_STAT_START			BIT(7)
-#define ALU_RESV_MCAST_ADDR		BIT(1)
 
 #define REG_SW_ALU_VAL_A		0x0420
 
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a962055bfdbd..933ae8dc6337 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -808,6 +808,8 @@ static const u16 ksz9477_regs[] = {
 static const u32 ksz9477_masks[] = {
 	[ALU_STAT_WRITE]		= 0,
 	[ALU_STAT_READ]			= 1,
+	[ALU_STAT_DIRECT]		= 0,
+	[ALU_RESV_MCAST_ADDR]		= BIT(1),
 	[P_MII_TX_FLOW_CTRL]		= BIT(5),
 	[P_MII_RX_FLOW_CTRL]		= BIT(3),
 };
@@ -835,6 +837,8 @@ static const u8 ksz9477_xmii_ctrl1[] = {
 static const u32 lan937x_masks[] = {
 	[ALU_STAT_WRITE]		= 1,
 	[ALU_STAT_READ]			= 2,
+	[ALU_STAT_DIRECT]		= BIT(3),
+	[ALU_RESV_MCAST_ADDR]		= BIT(2),
 	[P_MII_TX_FLOW_CTRL]		= BIT(5),
 	[P_MII_RX_FLOW_CTRL]		= BIT(3),
 };
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a1eb39771bb9..c65188cd3c0a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -294,6 +294,8 @@ enum ksz_masks {
 	DYNAMIC_MAC_TABLE_TIMESTAMP,
 	ALU_STAT_WRITE,
 	ALU_STAT_READ,
+	ALU_STAT_DIRECT,
+	ALU_RESV_MCAST_ADDR,
 	P_MII_TX_FLOW_CTRL,
 	P_MII_RX_FLOW_CTRL,
 };
-- 
2.34.1


