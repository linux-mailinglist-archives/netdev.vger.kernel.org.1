Return-Path: <netdev+bounces-205203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6A5AFDC70
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 02:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9166F18873CF
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 00:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B961CDFCA;
	Wed,  9 Jul 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KRjiOOyC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E080D198851;
	Wed,  9 Jul 2025 00:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752021194; cv=none; b=jIsSifNZcMQAoenDoGBk1gZZSEFRx0zznMFS+yJOkkXufKIrBZTwlRo2A5eWkbxBZl+pUMtdDkUOOnxy3q6x+5gxWFW7seSLOl0AM0qGjJNa45anhFONMqJ+NI2P+WqDmF2cgX3LDVobsg2qPMztBKNSROGmjBE2tQaWrL0bjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752021194; c=relaxed/simple;
	bh=OCGqMHjTb4kKH5bsqpnCpJFBEwWrFYWA+Y/wMiR1Y2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/X1I1Ot0pJ8aj6YrAO17ZgbZCsap5PoU6rIzUrGOHigxEyLpJSxJVoxIjrRxdV/KwJp4zpvJtMizC/6psYpBV1MOi8/3VhBjFM4QExtJB4JO/oY8qUHhXnPTSqjesfkr5Nmmeihok6q9csb1/MAwLh56tDl6YVY3LdNqG0Qcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KRjiOOyC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1752021192; x=1783557192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OCGqMHjTb4kKH5bsqpnCpJFBEwWrFYWA+Y/wMiR1Y2U=;
  b=KRjiOOyC0/FRwIS3S0RBeIKyl9iUiuOnRwNr2Ik4GipVPSO+bvJ7B90t
   pFfjSa8pbWgXgL256zTTmvv39hO+y7CWO5oqCCR4XD8A0xf5CnqadJ20E
   ZihCwM4ymbotDpNNIfc1dF2Kl9ZQonT5pTSMyWtU4mQFs2D74eaTnT33b
   rR1vNaN0VdhCpfqvvL6t1/ZqfqBK5OPnryZ0qb8sS/3RaWZVDoUwvHOyA
   D5Vka3ObEyqIqV3DsRaM6BaU5YZgKPX4QR1CSXfuYvEeAQ5rybL/sBHjo
   /9cplYHTyblOEBvD+bvRsSvKzTB6ZQ29oYxySpsk/+sNdbbOqwX2ef/XF
   w==;
X-CSE-ConnectionGUID: CSUfBCd3SzyYJ8hslua0Vg==
X-CSE-MsgGUID: MhxY0+icRwG11IcPzMqDLg==
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="211198516"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Jul 2025 17:33:08 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Jul 2025 17:32:36 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 8 Jul 2025 17:32:36 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next v3 4/7] net: dsa: microchip: Use different registers for KSZ8463
Date: Tue, 8 Jul 2025 17:32:30 -0700
Message-ID: <20250709003234.50088-5-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709003234.50088-1-Tristram.Ha@microchip.com>
References: <20250709003234.50088-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
to change some registers when using KSZ8463.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v3
- Replace cpu_to_be16() with swab16() to avoid compiler warning

 drivers/net/dsa/microchip/ksz8.c       | 78 +++++++++++++++++++-------
 drivers/net/dsa/microchip/ksz_common.c | 35 +++++++++---
 drivers/net/dsa/microchip/ksz_dcb.c    | 10 +++-
 3 files changed, 94 insertions(+), 29 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index f0c6049afe51..904db68e11f3 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -143,6 +143,11 @@ int ksz8_reset_switch(struct ksz_device *dev)
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, true);
 		ksz_cfg(dev, KSZ8863_REG_SW_RESET,
 			KSZ8863_GLOBAL_SOFTWARE_RESET | KSZ8863_PCS_RESET, false);
+	} else if (ksz_is_ksz8463(dev)) {
+		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
+			KSZ8463_GLOBAL_SOFTWARE_RESET, true);
+		ksz_cfg(dev, KSZ8463_REG_SW_RESET,
+			KSZ8463_GLOBAL_SOFTWARE_RESET, false);
 	} else {
 		/* reset switch */
 		ksz_write8(dev, REG_POWER_MANAGEMENT_1,
@@ -231,6 +236,11 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 			       WEIGHTED_FAIR_QUEUE_ENABLE);
 		if (ret)
 			return ret;
+	} else if (ksz_is_ksz8463(dev)) {
+		mask_4q = KSZ8873_PORT_4QUEUE_SPLIT_EN;
+		mask_2q = KSZ8873_PORT_2QUEUE_SPLIT_EN;
+		reg_4q = P1CR1;
+		reg_2q = P1CR1 + 1;
 	} else {
 		mask_4q = KSZ8795_PORT_4QUEUE_SPLIT_EN;
 		mask_2q = KSZ8795_PORT_2QUEUE_SPLIT_EN;
@@ -1269,12 +1279,15 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 
 void ksz8_cfg_port_member(struct ksz_device *dev, int port, u8 member)
 {
+	int offset = P_MIRROR_CTRL;
 	u8 data;
 
-	ksz_pread8(dev, port, P_MIRROR_CTRL, &data);
-	data &= ~PORT_VLAN_MEMBERSHIP;
+	if (ksz_is_ksz8463(dev))
+		offset = P1CR2;
+	ksz_pread8(dev, port, offset, &data);
+	data &= ~dev->port_mask;
 	data |= (member & dev->port_mask);
-	ksz_pwrite8(dev, port, P_MIRROR_CTRL, data);
+	ksz_pwrite8(dev, port, offset, data);
 }
 
 void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
@@ -1282,6 +1295,8 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 	u8 learn[DSA_MAX_PORTS];
 	int first, index, cnt;
 	const u16 *regs;
+	int reg = S_FLUSH_TABLE_CTRL;
+	int mask = SW_FLUSH_DYN_MAC_TABLE;
 
 	regs = dev->info->regs;
 
@@ -1299,7 +1314,11 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 			ksz_pwrite8(dev, index, regs[P_STP_CTRL],
 				    learn[index] | PORT_LEARN_DISABLE);
 	}
-	ksz_cfg(dev, S_FLUSH_TABLE_CTRL, SW_FLUSH_DYN_MAC_TABLE, true);
+	if (ksz_is_ksz8463(dev)) {
+		reg = KSZ8463_FLUSH_TABLE_CTRL;
+		mask = KSZ8463_FLUSH_DYN_MAC_TABLE;
+	}
+	ksz_cfg(dev, reg, mask, true);
 	for (index = first; index < cnt; index++) {
 		if (!(learn[index] & PORT_LEARN_DISABLE))
 			ksz_pwrite8(dev, index, regs[P_STP_CTRL], learn[index]);
@@ -1438,7 +1457,7 @@ int ksz8_fdb_del(struct ksz_device *dev, int port, const unsigned char *addr,
 int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
 			     struct netlink_ext_ack *extack)
 {
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
 
 	/* Discard packets with VID not enabled on the switch */
@@ -1454,9 +1473,12 @@ int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
 
 static void ksz8_port_enable_pvid(struct ksz_device *dev, int port, bool state)
 {
-	if (ksz_is_ksz88x3(dev)) {
-		ksz_cfg(dev, REG_SW_INSERT_SRC_PVID,
-			0x03 << (4 - 2 * port), state);
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev)) {
+		int reg = REG_SW_INSERT_SRC_PVID;
+
+		if (ksz_is_ksz8463(dev))
+			reg = KSZ8463_REG_SW_CTRL_9;
+		ksz_cfg(dev, reg, 0x03 << (4 - 2 * port), state);
 	} else {
 		ksz_pwrite8(dev, port, REG_PORT_CTRL_12, state ? 0x0f : 0x00);
 	}
@@ -1471,7 +1493,7 @@ int ksz8_port_vlan_add(struct ksz_device *dev, int port,
 	u16 data, new_pvid = 0;
 	u8 fid, member, valid;
 
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
 
 	/* If a VLAN is added with untagged flag different from the
@@ -1540,7 +1562,7 @@ int ksz8_port_vlan_del(struct ksz_device *dev, int port,
 	u16 data, pvid;
 	u8 fid, member, valid;
 
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
 
 	ksz_pread16(dev, port, REG_PORT_CTRL_VID, &pvid);
@@ -1570,19 +1592,23 @@ int ksz8_port_mirror_add(struct ksz_device *dev, int port,
 			 struct dsa_mall_mirror_tc_entry *mirror,
 			 bool ingress, struct netlink_ext_ack *extack)
 {
+	int offset = P_MIRROR_CTRL;
+
+	if (ksz_is_ksz8463(dev))
+		offset = P1CR2;
 	if (ingress) {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_RX, true);
+		ksz_port_cfg(dev, port, offset, PORT_MIRROR_RX, true);
 		dev->mirror_rx |= BIT(port);
 	} else {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_TX, true);
+		ksz_port_cfg(dev, port, offset, PORT_MIRROR_TX, true);
 		dev->mirror_tx |= BIT(port);
 	}
 
-	ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_SNIFFER, false);
+	ksz_port_cfg(dev, port, offset, PORT_MIRROR_SNIFFER, false);
 
 	/* configure mirror port */
 	if (dev->mirror_rx || dev->mirror_tx)
-		ksz_port_cfg(dev, mirror->to_local_port, P_MIRROR_CTRL,
+		ksz_port_cfg(dev, mirror->to_local_port, offset,
 			     PORT_MIRROR_SNIFFER, true);
 
 	return 0;
@@ -1591,20 +1617,23 @@ int ksz8_port_mirror_add(struct ksz_device *dev, int port,
 void ksz8_port_mirror_del(struct ksz_device *dev, int port,
 			  struct dsa_mall_mirror_tc_entry *mirror)
 {
+	int offset = P_MIRROR_CTRL;
 	u8 data;
 
+	if (ksz_is_ksz8463(dev))
+		offset = P1CR2;
 	if (mirror->ingress) {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_RX, false);
+		ksz_port_cfg(dev, port, offset, PORT_MIRROR_RX, false);
 		dev->mirror_rx &= ~BIT(port);
 	} else {
-		ksz_port_cfg(dev, port, P_MIRROR_CTRL, PORT_MIRROR_TX, false);
+		ksz_port_cfg(dev, port, offset, PORT_MIRROR_TX, false);
 		dev->mirror_tx &= ~BIT(port);
 	}
 
-	ksz_pread8(dev, port, P_MIRROR_CTRL, &data);
+	ksz_pread8(dev, port, offset, &data);
 
 	if (!dev->mirror_rx && !dev->mirror_tx)
-		ksz_port_cfg(dev, mirror->to_local_port, P_MIRROR_CTRL,
+		ksz_port_cfg(dev, mirror->to_local_port, offset,
 			     PORT_MIRROR_SNIFFER, false);
 }
 
@@ -1629,17 +1658,24 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
 	const u16 *regs = dev->info->regs;
 	struct dsa_switch *ds = dev->ds;
 	const u32 *masks;
+	int offset;
 	u8 member;
 
 	masks = dev->info->masks;
 
 	/* enable broadcast storm limit */
-	ksz_port_cfg(dev, port, P_BCAST_STORM_CTRL, PORT_BROADCAST_STORM, true);
+	offset = P_BCAST_STORM_CTRL;
+	if (ksz_is_ksz8463(dev))
+		offset = P1CR1;
+	ksz_port_cfg(dev, port, offset, PORT_BROADCAST_STORM, true);
 
 	ksz8_port_queue_split(dev, port, dev->info->num_tx_queues);
 
 	/* replace priority */
-	ksz_port_cfg(dev, port, P_802_1P_CTRL,
+	offset = P_802_1P_CTRL;
+	if (ksz_is_ksz8463(dev))
+		offset = P1CR2;
+	ksz_port_cfg(dev, port, offset,
 		     masks[PORT_802_1P_REMAPPING], false);
 
 	if (cpu_port)
@@ -1905,7 +1941,7 @@ int ksz8_setup(struct dsa_switch *ds)
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
 
-	if (!ksz_is_ksz88x3(dev))
+	if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
 		ksz_cfg(dev, REG_SW_CTRL_19, SW_INS_TAG_ENABLE, true);
 
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 5261747b7753..b78017abf0b8 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2951,6 +2951,7 @@ static int ksz_parse_drive_strength(struct ksz_device *dev);
 static int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	u16 storm_mask, storm_rate;
 	struct dsa_port *dp;
 	struct ksz_port *p;
 	const u16 *regs;
@@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *ds)
 	}
 
 	/* set broadcast storm protection 10% rate */
-	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
-			   BROADCAST_STORM_RATE,
-			   (BROADCAST_STORM_VALUE *
-			   BROADCAST_STORM_PROT_RATE) / 100);
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	if (ksz_is_ksz8463(dev)) {
+		storm_mask = swab16(storm_mask);
+		storm_rate = swab16(storm_rate);
+	}
+	regmap_update_bits(ksz_regmap_16(dev),
+			   reg16(dev, regs[S_BROADCAST_CTRL]),
+			   storm_mask, storm_rate);
 
 	dev->dev_ops->config_cpu_port(ds);
 
@@ -4222,6 +4228,17 @@ static int ksz_ets_band_to_queue(struct tc_ets_qopt_offload_replace_params *p,
 	return p->bands - 1 - band;
 }
 
+static u8 ksz8463_tc_ctrl(int port, int queue)
+{
+	u8 reg;
+
+	reg = 0xC8 + port * 4;
+	reg += ((3 - queue) / 2) * 2;
+	reg++;
+	reg -= (queue & 1);
+	return reg;
+}
+
 /**
  * ksz88x3_tc_ets_add - Configure ETS (Enhanced Transmission Selection)
  *                      for a port on KSZ88x3 switch
@@ -4257,6 +4274,8 @@ static int ksz88x3_tc_ets_add(struct ksz_device *dev, int port,
 		 * port/queue
 		 */
 		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+		if (ksz_is_ksz8463(dev))
+			reg = ksz8463_tc_ctrl(port, queue);
 
 		/* Clear WFQ enable bit to select strict priority scheduling */
 		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE, 0);
@@ -4292,6 +4311,8 @@ static int ksz88x3_tc_ets_del(struct ksz_device *dev, int port)
 		 * port/queue
 		 */
 		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+		if (ksz_is_ksz8463(dev))
+			reg = ksz8463_tc_ctrl(port, queue);
 
 		/* Set WFQ enable bit to revert back to default scheduling
 		 * mode
@@ -4439,7 +4460,7 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 	struct ksz_device *dev = ds->priv;
 	int ret;
 
-	if (is_ksz8(dev) && !ksz_is_ksz88x3(dev))
+	if (is_ksz8(dev) && !(ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev)))
 		return -EOPNOTSUPP;
 
 	if (qopt->parent != TC_H_ROOT) {
@@ -4453,13 +4474,13 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 		if (ret)
 			return ret;
 
-		if (ksz_is_ksz88x3(dev))
+		if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 			return ksz88x3_tc_ets_add(dev, port,
 						  &qopt->replace_params);
 		else
 			return ksz_tc_ets_add(dev, port, &qopt->replace_params);
 	case TC_ETS_DESTROY:
-		if (ksz_is_ksz88x3(dev))
+		if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 			return ksz88x3_tc_ets_del(dev, port);
 		else
 			return ksz_tc_ets_del(dev, port);
diff --git a/drivers/net/dsa/microchip/ksz_dcb.c b/drivers/net/dsa/microchip/ksz_dcb.c
index c3b501997ac9..7131c5caac54 100644
--- a/drivers/net/dsa/microchip/ksz_dcb.c
+++ b/drivers/net/dsa/microchip/ksz_dcb.c
@@ -16,10 +16,12 @@
  * Therefore, we define the base offset as 0x00 here to align with that logic.
  */
 #define KSZ8_REG_PORT_1_CTRL_0			0x00
+#define KSZ8463_REG_PORT_1_CTRL_0		0x6C
 #define KSZ8_PORT_DIFFSERV_ENABLE		BIT(6)
 #define KSZ8_PORT_802_1P_ENABLE			BIT(5)
 #define KSZ8_PORT_BASED_PRIO_M			GENMASK(4, 3)
 
+#define KSZ8463_REG_TOS_DSCP_CTRL		0x16
 #define KSZ88X3_REG_TOS_DSCP_CTRL		0x60
 #define KSZ8765_REG_TOS_DSCP_CTRL		0x90
 
@@ -98,6 +100,8 @@ static void ksz_get_default_port_prio_reg(struct ksz_device *dev, int *reg,
 		*reg = KSZ8_REG_PORT_1_CTRL_0;
 		*mask = KSZ8_PORT_BASED_PRIO_M;
 		*shift = __bf_shf(KSZ8_PORT_BASED_PRIO_M);
+		if (ksz_is_ksz8463(dev))
+			*reg = KSZ8463_REG_PORT_1_CTRL_0;
 	} else {
 		*reg = KSZ9477_REG_PORT_MRI_MAC_CTRL;
 		*mask = KSZ9477_PORT_BASED_PRIO_M;
@@ -122,10 +126,12 @@ static void ksz_get_dscp_prio_reg(struct ksz_device *dev, int *reg,
 		*reg = KSZ8765_REG_TOS_DSCP_CTRL;
 		*per_reg = 4;
 		*mask = GENMASK(1, 0);
-	} else if (ksz_is_ksz88x3(dev)) {
+	} else if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev)) {
 		*reg = KSZ88X3_REG_TOS_DSCP_CTRL;
 		*per_reg = 4;
 		*mask = GENMASK(1, 0);
+		if (ksz_is_ksz8463(dev))
+			*reg = KSZ8463_REG_TOS_DSCP_CTRL;
 	} else {
 		*reg = KSZ9477_REG_DIFFSERV_PRIO_MAP;
 		*per_reg = 2;
@@ -151,6 +157,8 @@ static void ksz_get_apptrust_map_and_reg(struct ksz_device *dev,
 		*map = ksz8_apptrust_map_to_bit;
 		*reg = KSZ8_REG_PORT_1_CTRL_0;
 		*mask = KSZ8_PORT_DIFFSERV_ENABLE | KSZ8_PORT_802_1P_ENABLE;
+		if (ksz_is_ksz8463(dev))
+			*reg = KSZ8463_REG_PORT_1_CTRL_0;
 	} else {
 		*map = ksz9477_apptrust_map_to_bit;
 		*reg = KSZ9477_REG_PORT_MRI_PRIO_CTRL;
-- 
2.34.1


