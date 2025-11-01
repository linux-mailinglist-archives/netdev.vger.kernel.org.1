Return-Path: <netdev+bounces-234813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 514BBC275A9
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3DAF34A90A
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DAA218AAB;
	Sat,  1 Nov 2025 01:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VIiZF4z7"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675A9224F3;
	Sat,  1 Nov 2025 01:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961694; cv=none; b=QC0po0OA5CUGwEYOVHyuTdrBFUyjIgrM5kbDzy13hN0KU61YITwUEqRCTv2yVkhKC6N6RI7fIpncBS8/rj3LXY7WhcDHtotbF4w9to1tEDF+WH/HsTSEsNmX2jCkW0SOIEDJ6CBHWWxDYz/mq5rDWNNQcd0FCkN+IN0OjsiLGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961694; c=relaxed/simple;
	bh=sDhgG8UNTXAchLzz3Jd6nUl2T2M++jiZBsh9nQk3bTI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nTxIkPEqWD858GIByHsDqJVCKMF2qOih0BBBwQdzJoLBBvqBHqR7TusVq2C6PQR9c9BTuqq3huDRJMk71MIToOnhw4jIqcYWcanj/W4VzjCqHiqbGp51K33XCpkuL71Y/4rCgTYnUgaxMq2foWYZld+RgPAgzFXNCoqG5chjbjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VIiZF4z7; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761961693; x=1793497693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sDhgG8UNTXAchLzz3Jd6nUl2T2M++jiZBsh9nQk3bTI=;
  b=VIiZF4z7tiiNTHJ0yfAs005FxHZeiRTxhWZpqCYRhSlzU0nkY7lwKJNQ
   1qpD0zQQIkCi36/aszHmDC9xHYkQkmOwDovqHQoejnZ+SgWsiDn9NiPXX
   Jb/iLxyteeCo/znwezdi8k5ZnUDGjlItbvT1r5ZNwN24NTIwOOxz5fpYb
   Tw5swidp8+K8U/zlYy1AjO8Lx2cTvuvZvxU/xZH+dHtvFNFZ0wg4wMlOZ
   nUiEUdNmnOPYTRslCcB9ogHAmdLxlpJPWPeLhGnB+DZwCeVH735c/iMm2
   yET/4MYp8T8pfZDiAIFaP3cxIFoY+0mmQmwOX8TfowBwRCrwNvcgVZ2yy
   g==;
X-CSE-ConnectionGUID: YVDUQMDIRpC22NuqNUfoEw==
X-CSE-MsgGUID: VfID1uMLSuOE/eFp9LozUA==
X-IronPort-AV: E=Sophos;i="6.19,270,1754982000"; 
   d="scan'208";a="279917492"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 18:48:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 31 Oct 2025 18:47:41 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 31 Oct 2025 18:47:40 -0700
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
Subject: [PATCH net] net: dsa: microchip: Fix reserved multicast address table programming
Date: Fri, 31 Oct 2025 18:48:03 -0700
Message-ID: <20251101014803.49842-1-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

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
---
 drivers/net/dsa/microchip/ksz9477.c     | 103 ++++++++++++++++++++----
 drivers/net/dsa/microchip/ksz9477_reg.h |   3 +-
 drivers/net/dsa/microchip/ksz_common.c  |   4 +
 drivers/net/dsa/microchip/ksz_common.h  |   2 +
 4 files changed, 96 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index d747ea1c41a7..9b6731de52a7 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1355,8 +1355,12 @@ void ksz9477_config_cpu_port(struct dsa_switch *ds)
 	}
 }
 
+static u8 reserved_mcast_map[8] = { 0, 1, 3, 16, 32, 33, 2, 17 };
+
 int ksz9477_enable_stp_addr(struct ksz_device *dev)
 {
+	u8 all_ports = (1 << dev->info->port_cnt) - 1;
+	u8 i, def_port, ports, update;
 	const u32 *masks;
 	u32 data;
 	int ret;
@@ -1366,23 +1370,94 @@ int ksz9477_enable_stp_addr(struct ksz_device *dev)
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
+	def_port = BIT(dev->info->port_cnt - 1);
+	if (is_lan937x(dev))
+		def_port = BIT(4);
+	for (i = 0; i < 8; i++) {
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
+		ports = data & dev->port_mask;
+		if (ports == def_port) {
+			/* Change the host port. */
+			update = BIT(dev->cpu_port);
+
+			/* The host port is correct so no need to update the
+			 * the whole table but the first entry still needs to
+			 * set the Override bit for STP.
+			 */
+			if (update == def_port && i == 0)
+				ports = 0;
+		} else if (ports == 0) {
+			/* No change to entry. */
+			update = 0;
+		} else if (ports == (all_ports & ~def_port)) {
+			/* This entry does not forward to host port.  But if
+			 * the host needs to process protocols like MVRP and
+			 * MMRP the host port needs to be set.
+			 */
+			update = ports & ~BIT(dev->cpu_port);
+			update |= def_port;
+		} else {
+			/* No change to entry. */
+			update = ports;
+		}
+		if (update != ports) {
+			data &= ~dev->port_mask;
+			data |= update;
+			/* Set Override bit for STP in the first entry. */
+			if (i == 0)
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
+
+			/* No need to check the whole table. */
+			if (i == 0 && !ports)
+				break;
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


