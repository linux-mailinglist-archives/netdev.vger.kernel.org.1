Return-Path: <netdev+bounces-203592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C502CAF67A5
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 04:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260747B39D5
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 02:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CB91F5838;
	Thu,  3 Jul 2025 02:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ESVPzK5p"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291671AAA1C;
	Thu,  3 Jul 2025 02:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751508154; cv=none; b=oqpHz+hLP4SJ/F7KulJ8aBjAU7p70KFl5SOSIxcNBtUsXQ0HlZlHT7MpuFLv74AGTgBMicEzRJg6NdBdA/mPoHtpev86cqE4rpogyDnvB03Dok0wWL+OzsZ/JRegIUwZYw3ZlE5etfdM0hldOL86nrjDnBmqh16YIVhQSd1EcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751508154; c=relaxed/simple;
	bh=a0C++QzSwolBSkncbKo0hAxloCygi4zOG8b3/RAGahI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXt1OFPAO359iJ9HO4VyJVUoBWGE9DQDBt32vQyWo8vjkGG6YVx4TUnyhAtUlA8LH1QbwJoVQsZ+OAbBLElZ6hoONjBi/NyXiYUAV76L0r7Zzyjr+9fHFx8Gz0GSGQlmUqD+M/iqKsCIGYXtwk05LlFpt0DZ85/yGEH2sQY8xLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ESVPzK5p; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751508152; x=1783044152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a0C++QzSwolBSkncbKo0hAxloCygi4zOG8b3/RAGahI=;
  b=ESVPzK5pylrl61sXKsLQPodWKAxK7vgEYhIth+GSOXggLeoKKqgzIHIp
   P/Z3iNvtx9qbNGxxsvY2poaVlQnmeKPHiW8bvkAt55uYv+6K/4zXyjn7e
   8+CW6WbUKTCOOSxPiXeCZMyjFQGz5s+LwyabkDlQDN//cbCFkz5nFSjqk
   Z0lH2WqnEBhekKQ7JumIdzpR+/lXrgv5psZqayKCFLLJrOaay7VNZ8fr+
   JQY0a8rQxxz+Af56DLHIVUgCaNbb0eyY6Hyxs1D5G6UMLJeJuTQ/FosHq
   kx7UjrzpYABr/0LgZkwPbZ+w+mA6Gx4lYpp6aajMGVZ/l4dV/p3yEMjHl
   Q==;
X-CSE-ConnectionGUID: CQFyRSm3RYe0HuwgMRiJcQ==
X-CSE-MsgGUID: RXCAfuRDQMiqzguTuA73+A==
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="274911715"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Jul 2025 19:02:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 2 Jul 2025 19:01:53 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Wed, 2 Jul 2025 19:01:53 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next 2/2] net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
Date: Wed, 2 Jul 2025 19:01:55 -0700
Message-ID: <20250703020155.10331-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703020155.10331-1-Tristram.Ha@microchip.com>
References: <20250703020155.10331-1-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Tristram Ha <tristram.ha@microchip.com>

KSZ8463 switch is a 3-port switch based from KSZ8863.  Its major
difference from other KSZ SPI switches is its register access is not a
simple continual 8-bit transfer with automatic address increase but uses
a byte-enable mechanism specifying 8-bit, 16-bit, or 32-bit access.  Its
registers are also defined in 16-bit format because it shares a design
with a MAC controller using 16-bit access.  As a result some common
register accesses need to be re-arranged.  The 64-bit access used by
other switches needs to be broken into 2 32-bit accesses.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c            | 201 +++++++++++++++++---
 drivers/net/dsa/microchip/ksz8.h            |   4 +
 drivers/net/dsa/microchip/ksz8_reg.h        |  49 +++++
 drivers/net/dsa/microchip/ksz_common.c      | 168 +++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h      | 104 ++++++++--
 drivers/net/dsa/microchip/ksz_dcb.c         |  10 +-
 drivers/net/dsa/microchip/ksz_spi.c         |  14 ++
 include/linux/platform_data/microchip-ksz.h |   1 +
 8 files changed, 502 insertions(+), 49 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index be433b4e2b1c..1207879ef80c 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -3,6 +3,7 @@
  * Microchip KSZ8XXX series switch driver
  *
  * It supports the following switches:
+ * - KSZ8463
  * - KSZ8863, KSZ8873 aka KSZ88X3
  * - KSZ8895, KSZ8864 aka KSZ8895 family
  * - KSZ8794, KSZ8795, KSZ8765 aka KSZ87XX
@@ -35,13 +36,15 @@
 
 static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0);
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, addr), bits,
+			   set ? bits : 0);
 }
 
 static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
 			 bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev), PORT_CTRL_ADDR(port, offset),
+	regmap_update_bits(ksz_regmap_8(dev),
+			   reg8(dev, dev->dev_ops->get_port_addr(port, offset)),
 			   bits, set ? bits : 0);
 }
 
@@ -140,6 +143,11 @@ int ksz8_reset_switch(struct ksz_device *dev)
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
@@ -194,6 +202,7 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return ksz8795_change_mtu(dev, frame_size);
+	case KSZ8463_CHIP_ID:
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
@@ -227,6 +236,11 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
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
@@ -1265,12 +1279,15 @@ int ksz8_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
 
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
@@ -1278,6 +1295,8 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
 	u8 learn[DSA_MAX_PORTS];
 	int first, index, cnt;
 	const u16 *regs;
+	int reg = S_FLUSH_TABLE_CTRL;
+	int mask = SW_FLUSH_DYN_MAC_TABLE;
 
 	regs = dev->info->regs;
 
@@ -1295,7 +1314,11 @@ void ksz8_flush_dyn_mac_table(struct ksz_device *dev, int port)
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
@@ -1434,7 +1457,7 @@ int ksz8_fdb_del(struct ksz_device *dev, int port, const unsigned char *addr,
 int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
 			     struct netlink_ext_ack *extack)
 {
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
 
 	/* Discard packets with VID not enabled on the switch */
@@ -1450,9 +1473,12 @@ int ksz8_port_vlan_filtering(struct ksz_device *dev, int port, bool flag,
 
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
@@ -1467,7 +1493,7 @@ int ksz8_port_vlan_add(struct ksz_device *dev, int port,
 	u16 data, new_pvid = 0;
 	u8 fid, member, valid;
 
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
 
 	/* If a VLAN is added with untagged flag different from the
@@ -1536,7 +1562,7 @@ int ksz8_port_vlan_del(struct ksz_device *dev, int port,
 	u16 data, pvid;
 	u8 fid, member, valid;
 
-	if (ksz_is_ksz88x3(dev))
+	if (ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev))
 		return -ENOTSUPP;
 
 	ksz_pread16(dev, port, REG_PORT_CTRL_VID, &pvid);
@@ -1566,19 +1592,23 @@ int ksz8_port_mirror_add(struct ksz_device *dev, int port,
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
@@ -1587,20 +1617,23 @@ int ksz8_port_mirror_add(struct ksz_device *dev, int port,
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
 
@@ -1625,17 +1658,24 @@ void ksz8_port_setup(struct ksz_device *dev, int port, bool cpu_port)
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
@@ -1675,6 +1715,7 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 	const u32 *masks;
 	const u16 *regs;
 	u8 remote;
+	u8 fiber_ports = 0;
 	int i;
 
 	masks = dev->info->masks;
@@ -1705,6 +1746,31 @@ void ksz8_config_cpu_port(struct dsa_switch *ds)
 		else
 			ksz_port_cfg(dev, i, regs[P_STP_CTRL],
 				     PORT_FORCE_FLOW_CTRL, false);
+		if (p->fiber)
+			fiber_ports |= (1 << i);
+	}
+	if (ksz_is_ksz8463(dev)) {
+		/* Setup fiber ports. */
+		if (fiber_ports) {
+			regmap_update_bits(ksz_regmap_16(dev),
+					   reg16(dev, KSZ8463_REG_CFG_CTRL),
+					   fiber_ports << PORT_COPPER_MODE_S,
+					   0);
+			regmap_update_bits(ksz_regmap_16(dev),
+					   reg16(dev, KSZ8463_REG_DSP_CTRL_6),
+					   COPPER_RECEIVE_ADJUSTMENT, 0);
+		}
+
+		/* Turn off PTP function as the switch's proprietary way of
+		 * handling timestamp is not supported in current Linux PTP
+		 * stack implementation.
+		 */
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_MSG_CONF1),
+				   PTP_ENABLE, 0);
+		regmap_update_bits(ksz_regmap_16(dev),
+				   reg16(dev, KSZ8463_PTP_CLK_CTRL),
+				   PTP_CLK_ENABLE, 0);
 	}
 }
 
@@ -1886,14 +1952,14 @@ int ksz8_setup(struct dsa_switch *ds)
 	ksz_cfg(dev, S_LINK_AGING_CTRL, SW_LINK_AUTO_AGING, true);
 
 	/* Enable aggressive back off algorithm in half duplex mode. */
-	regmap_update_bits(ksz_regmap_8(dev), REG_SW_CTRL_1,
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, REG_SW_CTRL_1),
 			   SW_AGGR_BACKOFF, SW_AGGR_BACKOFF);
 
 	/*
 	 * Make sure unicast VLAN boundary is set as default and
 	 * enable no excessive collision drop.
 	 */
-	regmap_update_bits(ksz_regmap_8(dev), REG_SW_CTRL_2,
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, REG_SW_CTRL_2),
 			   UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP,
 			   UNICAST_VLAN_BOUNDARY | NO_EXC_COLLISION_DROP);
 
@@ -1901,7 +1967,7 @@ int ksz8_setup(struct dsa_switch *ds)
 
 	ksz_cfg(dev, S_MIRROR_CTRL, SW_MIRROR_RX_TX, false);
 
-	if (!ksz_is_ksz88x3(dev))
+	if (!ksz_is_ksz88x3(dev) && !ksz_is_ksz8463(dev))
 		ksz_cfg(dev, REG_SW_CTRL_19, SW_INS_TAG_ENABLE, true);
 
 	for (i = 0; i < (dev->info->num_vlans / 4); i++)
@@ -1947,6 +2013,91 @@ u32 ksz8_get_port_addr(int port, int offset)
 	return PORT_CTRL_ADDR(port, offset);
 }
 
+u32 ksz8463_get_port_addr(int port, int offset)
+{
+	return offset + 0x18 * port;
+}
+
+static inline u16 ksz8463_get_phy_addr(u16 phy, u16 reg, u16 offset)
+{
+	return offset + reg * 2 + phy * (P2MBCR - P1MBCR);
+}
+
+int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
+{
+	bool processed = true;
+	u16 sw_reg = 0;
+	u16 data;
+	int ret;
+
+	if (phy > 1)
+		return -ENOSPC;
+	switch (reg) {
+	case MII_PHYSID1:
+		sw_reg = ksz8463_get_phy_addr(phy, 0, PHY1IHR);
+		break;
+	case MII_PHYSID2:
+		sw_reg = ksz8463_get_phy_addr(phy, 0, PHY1ILR);
+		break;
+	case MII_BMCR:
+	case MII_BMSR:
+	case MII_ADVERTISE:
+	case MII_LPA:
+		sw_reg = ksz8463_get_phy_addr(phy, reg, P1MBCR);
+		break;
+
+	/* No MMD access. */
+	case MII_MMD_CTRL:
+	case MII_MMD_DATA:
+		break;
+	case MII_TPISTATUS:
+		/* This register holds the PHY interrupt status for simulated
+		 * Micrel KSZ PHY.
+		 */
+		data = 0x0505;
+		break;
+	default:
+		processed = false;
+		break;
+	}
+	if (processed && sw_reg) {
+		ret = ksz_read16(dev, sw_reg, &data);
+		if (ret)
+			return ret;
+		*val = data;
+	}
+
+	return 0;
+}
+
+int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val)
+{
+	u16 sw_reg = 0;
+	int ret;
+
+	if (phy > 1)
+		return -ENOSPC;
+
+	/* No write to fiber port. */
+	if (dev->ports[phy].fiber)
+		return 0;
+	switch (reg) {
+	case MII_BMCR:
+	case MII_ADVERTISE:
+		sw_reg = ksz8463_get_phy_addr(phy, reg, P1MBCR);
+		break;
+	default:
+		break;
+	}
+	if (sw_reg) {
+		ret = ksz_write16(dev, sw_reg, val);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int ksz8_switch_init(struct ksz_device *dev)
 {
 	dev->cpu_port = fls(dev->info->cpu_ports) - 1;
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index e1c79ff97123..0f2cd1474b44 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -63,4 +63,8 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      bool tx_pause, bool rx_pause);
 int ksz8_all_queues_split(struct ksz_device *dev, int queues);
 
+u32 ksz8463_get_port_addr(int port, int offset);
+int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);
+int ksz8463_w_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 val);
+
 #endif
diff --git a/drivers/net/dsa/microchip/ksz8_reg.h b/drivers/net/dsa/microchip/ksz8_reg.h
index 329688603a58..8f5845812383 100644
--- a/drivers/net/dsa/microchip/ksz8_reg.h
+++ b/drivers/net/dsa/microchip/ksz8_reg.h
@@ -729,6 +729,55 @@
 #define PHY_POWER_SAVING_ENABLE		BIT(2)
 #define PHY_REMOTE_LOOPBACK		BIT(1)
 
+/* KSZ8463 specific registers. */
+#define P1MBCR				0x4C
+#define P1MBSR				0x4E
+#define PHY1ILR				0x50
+#define PHY1IHR				0x52
+#define P1ANAR				0x54
+#define P1ANLPR				0x58
+#define P2MBCR				0x58
+#define P2MBSR				0x5A
+#define PHY2ILR				0x5C
+#define PHY2IHR				0x5E
+#define P2ANAR				0x60
+#define P2ANLPR				0x62
+
+#define P1CR1				0x6C
+#define P1CR2				0x6E
+#define P1CR3				0x72
+#define P1CR4				0x7E
+#define P1SR				0x80
+
+#define KSZ8463_FLUSH_TABLE_CTRL	0xAD
+
+#define KSZ8463_FLUSH_DYN_MAC_TABLE	BIT(2)
+#define KSZ8463_FLUSH_STA_MAC_TABLE	BIT(1)
+
+#define KSZ8463_REG_SW_CTRL_9		0xAE
+
+#define KSZ8463_REG_CFG_CTRL		0xD8
+
+#define PORT_2_COPPER_MODE		BIT(7)
+#define PORT_1_COPPER_MODE		BIT(6)
+#define PORT_COPPER_MODE_S		6
+
+#define KSZ8463_REG_SW_RESET		0x126
+
+#define KSZ8463_GLOBAL_SOFTWARE_RESET	BIT(0)
+
+#define KSZ8463_PTP_CLK_CTRL		0x600
+
+#define PTP_CLK_ENABLE			BIT(1)
+
+#define KSZ8463_PTP_MSG_CONF1		0x620
+
+#define PTP_ENABLE			BIT(6)
+
+#define KSZ8463_REG_DSP_CTRL_6		0x734
+
+#define COPPER_RECEIVE_ADJUSTMENT	BIT(13)
+
 /* Chip resource */
 
 #define PRIO_QUEUES			4
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 6e1daf0018bc..a4d01679b806 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -331,6 +331,38 @@ static const struct phylink_mac_ops ksz8_phylink_mac_ops = {
 	.mac_enable_tx_lpi = ksz_phylink_mac_enable_tx_lpi,
 };
 
+static const struct ksz_dev_ops ksz8463_dev_ops = {
+	.setup = ksz8_setup,
+	.get_port_addr = ksz8463_get_port_addr,
+	.cfg_port_member = ksz8_cfg_port_member,
+	.flush_dyn_mac_table = ksz8_flush_dyn_mac_table,
+	.port_setup = ksz8_port_setup,
+	.r_phy = ksz8463_r_phy,
+	.w_phy = ksz8463_w_phy,
+	.r_mib_cnt = ksz8_r_mib_cnt,
+	.r_mib_pkt = ksz8_r_mib_pkt,
+	.r_mib_stat64 = ksz88xx_r_mib_stats64,
+	.freeze_mib = ksz8_freeze_mib,
+	.port_init_cnt = ksz8_port_init_cnt,
+	.fdb_dump = ksz8_fdb_dump,
+	.fdb_add = ksz8_fdb_add,
+	.fdb_del = ksz8_fdb_del,
+	.mdb_add = ksz8_mdb_add,
+	.mdb_del = ksz8_mdb_del,
+	.vlan_filtering = ksz8_port_vlan_filtering,
+	.vlan_add = ksz8_port_vlan_add,
+	.vlan_del = ksz8_port_vlan_del,
+	.mirror_add = ksz8_port_mirror_add,
+	.mirror_del = ksz8_port_mirror_del,
+	.get_caps = ksz8_get_caps,
+	.config_cpu_port = ksz8_config_cpu_port,
+	.enable_stp_addr = ksz8_enable_stp_addr,
+	.reset = ksz8_reset_switch,
+	.init = ksz8_switch_init,
+	.exit = ksz8_switch_exit,
+	.change_mtu = ksz8_change_mtu,
+};
+
 static const struct ksz_dev_ops ksz88xx_dev_ops = {
 	.setup = ksz8_setup,
 	.get_port_addr = ksz8_get_port_addr,
@@ -517,6 +549,60 @@ static const struct ksz_dev_ops lan937x_dev_ops = {
 	.exit = lan937x_switch_exit,
 };
 
+static const u16 ksz8463_regs[] = {
+	[REG_SW_MAC_ADDR]		= 0x10,
+	[REG_IND_CTRL_0]		= 0x30,
+	[REG_IND_DATA_8]		= 0x26,
+	[REG_IND_DATA_CHECK]		= 0x26,
+	[REG_IND_DATA_HI]		= 0x28,
+	[REG_IND_DATA_LO]		= 0x2C,
+	[REG_IND_MIB_CHECK]		= 0x2F,
+	[P_FORCE_CTRL]			= 0x0C,
+	[P_LINK_STATUS]			= 0x0E,
+	[P_LOCAL_CTRL]			= 0x0C,
+	[P_NEG_RESTART_CTRL]		= 0x0D,
+	[P_REMOTE_STATUS]		= 0x0E,
+	[P_SPEED_STATUS]		= 0x0F,
+	[S_TAIL_TAG_CTRL]		= 0xAD,
+	[P_STP_CTRL]			= 0x6F,
+	[S_START_CTRL]			= 0x01,
+	[S_BROADCAST_CTRL]		= 0x06,
+	[S_MULTICAST_CTRL]		= 0x04,
+};
+
+static const u32 ksz8463_masks[] = {
+	[PORT_802_1P_REMAPPING]		= BIT(3),
+	[SW_TAIL_TAG_ENABLE]		= BIT(0),
+	[MIB_COUNTER_OVERFLOW]		= BIT(7),
+	[MIB_COUNTER_VALID]		= BIT(6),
+	[VLAN_TABLE_FID]		= GENMASK(15, 12),
+	[VLAN_TABLE_MEMBERSHIP]		= GENMASK(18, 16),
+	[VLAN_TABLE_VALID]		= BIT(19),
+	[STATIC_MAC_TABLE_VALID]	= BIT(19),
+	[STATIC_MAC_TABLE_USE_FID]	= BIT(21),
+	[STATIC_MAC_TABLE_FID]		= GENMASK(25, 22),
+	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(20),
+	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(18, 16),
+	[DYNAMIC_MAC_TABLE_ENTRIES_H]	= GENMASK(1, 0),
+	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(2),
+	[DYNAMIC_MAC_TABLE_NOT_READY]	= BIT(7),
+	[DYNAMIC_MAC_TABLE_ENTRIES]	= GENMASK(31, 24),
+	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(19, 16),
+	[DYNAMIC_MAC_TABLE_SRC_PORT]	= GENMASK(21, 20),
+	[DYNAMIC_MAC_TABLE_TIMESTAMP]	= GENMASK(23, 22),
+};
+
+static u8 ksz8463_shifts[] = {
+	[VLAN_TABLE_MEMBERSHIP_S]	= 16,
+	[STATIC_MAC_FWD_PORTS]		= 16,
+	[STATIC_MAC_FID]		= 22,
+	[DYNAMIC_MAC_ENTRIES_H]		= 8,
+	[DYNAMIC_MAC_ENTRIES]		= 24,
+	[DYNAMIC_MAC_FID]		= 16,
+	[DYNAMIC_MAC_TIMESTAMP]		= 22,
+	[DYNAMIC_MAC_SRC_PORT]		= 20,
+};
+
 static const u16 ksz8795_regs[] = {
 	[REG_SW_MAC_ADDR]		= 0x68,
 	[REG_IND_CTRL_0]		= 0x6E,
@@ -1387,6 +1473,29 @@ static const struct regmap_access_table ksz8873_register_set = {
 };
 
 const struct ksz_chip_data ksz_switch_chips[] = {
+	[KSZ8463] = {
+		.chip_id = KSZ8463_CHIP_ID,
+		.dev_name = "KSZ8463",
+		.num_vlans = 16,
+		.num_alus = 0,
+		.num_statics = 8,
+		.cpu_ports = 0x4,	/* can be configured as cpu port */
+		.port_cnt = 3,
+		.num_tx_queues = 4,
+		.num_ipms = 4,
+		.ops = &ksz8463_dev_ops,
+		.phylink_mac_ops = &ksz88x3_phylink_mac_ops,
+		.mib_names = ksz88xx_mib_names,
+		.mib_cnt = ARRAY_SIZE(ksz88xx_mib_names),
+		.reg_mib_cnt = MIB_COUNTER_NUM,
+		.regs = ksz8463_regs,
+		.masks = ksz8463_masks,
+		.shifts = ksz8463_shifts,
+		.supports_mii = {false, false, true},
+		.supports_rmii = {false, false, true},
+		.internal_phy = {true, true, false},
+	},
+
 	[KSZ8563] = {
 		.chip_id = KSZ8563_CHIP_ID,
 		.dev_name = "KSZ8563",
@@ -2842,6 +2951,7 @@ static int ksz_parse_drive_strength(struct ksz_device *dev);
 static int ksz_setup(struct dsa_switch *ds)
 {
 	struct ksz_device *dev = ds->priv;
+	u16 storm_mask, storm_rate;
 	struct dsa_port *dp;
 	struct ksz_port *p;
 	const u16 *regs;
@@ -2871,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *ds)
 	}
 
 	/* set broadcast storm protection 10% rate */
-	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
-			   BROADCAST_STORM_RATE,
-			   (BROADCAST_STORM_VALUE *
-			   BROADCAST_STORM_PROT_RATE) / 100);
+	storm_mask = BROADCAST_STORM_RATE;
+	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
+	if (ksz_is_ksz8463(dev)) {
+		storm_mask = htons(storm_mask);
+		storm_rate = htons(storm_rate);
+	}
+	regmap_update_bits(ksz_regmap_16(dev),
+			   reg16(dev, regs[S_BROADCAST_CTRL]),
+			   storm_mask, storm_rate);
 
 	dev->dev_ops->config_cpu_port(ds);
 
@@ -2882,7 +2997,8 @@ static int ksz_setup(struct dsa_switch *ds)
 
 	ds->num_tx_queues = dev->info->num_tx_queues;
 
-	regmap_update_bits(ksz_regmap_8(dev), regs[S_MULTICAST_CTRL],
+	regmap_update_bits(ksz_regmap_8(dev),
+			   reg8(dev, regs[S_MULTICAST_CTRL]),
 			   MULTICAST_STORM_DISABLE, MULTICAST_STORM_DISABLE);
 
 	ksz_init_mib_timer(dev);
@@ -2942,7 +3058,7 @@ static int ksz_setup(struct dsa_switch *ds)
 		goto out_ptp_clock_unregister;
 
 	/* start switch */
-	regmap_update_bits(ksz_regmap_8(dev), regs[S_START_CTRL],
+	regmap_update_bits(ksz_regmap_8(dev), reg8(dev, regs[S_START_CTRL]),
 			   SW_START, SW_START);
 
 	return 0;
@@ -3400,6 +3516,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 		proto = DSA_TAG_PROTO_KSZ8795;
 
 	if (dev->chip_id == KSZ88X3_CHIP_ID ||
+	    dev->chip_id == KSZ8463_CHIP_ID ||
 	    dev->chip_id == KSZ8563_CHIP_ID ||
 	    dev->chip_id == KSZ9893_CHIP_ID ||
 	    dev->chip_id == KSZ9563_CHIP_ID)
@@ -3512,6 +3629,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
+	case KSZ8463_CHIP_ID:
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
@@ -3866,6 +3984,9 @@ static int ksz_switch_detect(struct ksz_device *dev)
 	id2 = FIELD_GET(SW_CHIP_ID_M, id16);
 
 	switch (id1) {
+	case KSZ84_FAMILY_ID:
+		dev->chip_id = KSZ8463_CHIP_ID;
+		break;
 	case KSZ87_FAMILY_ID:
 		if (id2 == KSZ87_CHIP_ID_95) {
 			u8 val;
@@ -4107,6 +4228,17 @@ static int ksz_ets_band_to_queue(struct tc_ets_qopt_offload_replace_params *p,
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
@@ -4142,6 +4274,8 @@ static int ksz88x3_tc_ets_add(struct ksz_device *dev, int port,
 		 * port/queue
 		 */
 		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+		if (ksz_is_ksz8463(dev))
+			reg = ksz8463_tc_ctrl(port, queue);
 
 		/* Clear WFQ enable bit to select strict priority scheduling */
 		ret = ksz_rmw8(dev, reg, KSZ8873_TXQ_WFQ_ENABLE, 0);
@@ -4177,6 +4311,8 @@ static int ksz88x3_tc_ets_del(struct ksz_device *dev, int port)
 		 * port/queue
 		 */
 		reg = KSZ8873_TXQ_SPLIT_CTRL_REG(port, queue);
+		if (ksz_is_ksz8463(dev))
+			reg = ksz8463_tc_ctrl(port, queue);
 
 		/* Set WFQ enable bit to revert back to default scheduling
 		 * mode
@@ -4324,7 +4460,7 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
 	struct ksz_device *dev = ds->priv;
 	int ret;
 
-	if (is_ksz8(dev) && !ksz_is_ksz88x3(dev))
+	if (is_ksz8(dev) && !(ksz_is_ksz88x3(dev) || ksz_is_ksz8463(dev)))
 		return -EOPNOTSUPP;
 
 	if (qopt->parent != TC_H_ROOT) {
@@ -4338,13 +4474,13 @@ static int ksz_tc_setup_qdisc_ets(struct dsa_switch *ds, int port,
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
@@ -4687,7 +4823,16 @@ int ksz_switch_macaddr_get(struct dsa_switch *ds, int port,
 
 	/* Program the switch MAC address to hardware */
 	for (i = 0; i < ETH_ALEN; i++) {
-		ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i, addr[i]);
+		if (ksz_is_ksz8463(dev)) {
+			u16 addr16 = ((u16)addr[i] << 8) | addr[i + 1];
+
+			ret = ksz_write16(dev, regs[REG_SW_MAC_ADDR] + i,
+					  addr16);
+			i++;
+		} else {
+			ret = ksz_write8(dev, regs[REG_SW_MAC_ADDR] + i,
+					 addr[i]);
+		}
 		if (ret)
 			goto macaddr_drop;
 	}
@@ -5296,6 +5441,9 @@ int ksz_switch_register(struct ksz_device *dev)
 						&dev->ports[port_num].interface);
 
 				ksz_parse_rgmii_delay(dev, port_num, port);
+				dev->ports[port_num].fiber =
+					of_property_read_bool(port,
+							      "micrel,fiber-mode");
 			}
 			of_node_put(ports);
 		}
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a08417df2ca4..cdf89e50238a 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -222,6 +222,7 @@ struct ksz_device {
 
 /* List of supported models */
 enum ksz_model {
+	KSZ8463,
 	KSZ8563,
 	KSZ8567,
 	KSZ8795,
@@ -484,10 +485,36 @@ static inline struct regmap *ksz_regmap_32(struct ksz_device *dev)
 	return dev->regmap[KSZ_REGMAP_32];
 }
 
+static inline bool ksz_is_ksz8463(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8463_CHIP_ID;
+}
+
+static inline u32 reg8(struct ksz_device *dev, u32 reg)
+{
+	if (ksz_is_ksz8463(dev))
+		return ((reg >> 2) << 4) | (1 << (reg & 3));
+	return reg;
+}
+
+static inline u32 reg16(struct ksz_device *dev, u32 reg)
+{
+	if (ksz_is_ksz8463(dev))
+		return ((reg >> 2) << 4) | (reg & 2 ? 0x0c : 0x03);
+	return reg;
+}
+
+static inline u32 reg32(struct ksz_device *dev, u32 reg)
+{
+	if (ksz_is_ksz8463(dev))
+		return ((reg >> 2) << 4) | 0xf;
+	return reg;
+}
+
 static inline int ksz_read8(struct ksz_device *dev, u32 reg, u8 *val)
 {
 	unsigned int value;
-	int ret = regmap_read(ksz_regmap_8(dev), reg, &value);
+	int ret = regmap_read(ksz_regmap_8(dev), reg8(dev, reg), &value);
 
 	if (ret)
 		dev_err(dev->dev, "can't read 8bit reg: 0x%x %pe\n", reg,
@@ -500,7 +527,7 @@ static inline int ksz_read8(struct ksz_device *dev, u32 reg, u8 *val)
 static inline int ksz_read16(struct ksz_device *dev, u32 reg, u16 *val)
 {
 	unsigned int value;
-	int ret = regmap_read(ksz_regmap_16(dev), reg, &value);
+	int ret = regmap_read(ksz_regmap_16(dev), reg16(dev, reg), &value);
 
 	if (ret)
 		dev_err(dev->dev, "can't read 16bit reg: 0x%x %pe\n", reg,
@@ -513,7 +540,7 @@ static inline int ksz_read16(struct ksz_device *dev, u32 reg, u16 *val)
 static inline int ksz_read32(struct ksz_device *dev, u32 reg, u32 *val)
 {
 	unsigned int value;
-	int ret = regmap_read(ksz_regmap_32(dev), reg, &value);
+	int ret = regmap_read(ksz_regmap_32(dev), reg32(dev, reg), &value);
 
 	if (ret)
 		dev_err(dev->dev, "can't read 32bit reg: 0x%x %pe\n", reg,
@@ -528,7 +555,17 @@ static inline int ksz_read64(struct ksz_device *dev, u32 reg, u64 *val)
 	u32 value[2];
 	int ret;
 
-	ret = regmap_bulk_read(ksz_regmap_32(dev), reg, value, 2);
+	if (ksz_is_ksz8463(dev)) {
+		int i;
+
+		for (i = 0; i < 2; i++)
+			ret = regmap_read(ksz_regmap_32(dev),
+					  reg32(dev, reg + i * 4),
+					  &value[i]);
+		*val = (u64)value[0] << 32 | value[1];
+		return ret;
+	}
+	ret = regmap_bulk_read(ksz_regmap_32(dev), reg32(dev, reg), value, 2);
 	if (ret)
 		dev_err(dev->dev, "can't read 64bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -542,7 +579,7 @@ static inline int ksz_write8(struct ksz_device *dev, u32 reg, u8 value)
 {
 	int ret;
 
-	ret = regmap_write(ksz_regmap_8(dev), reg, value);
+	ret = regmap_write(ksz_regmap_8(dev), reg8(dev, reg), value);
 	if (ret)
 		dev_err(dev->dev, "can't write 8bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -554,7 +591,7 @@ static inline int ksz_write16(struct ksz_device *dev, u32 reg, u16 value)
 {
 	int ret;
 
-	ret = regmap_write(ksz_regmap_16(dev), reg, value);
+	ret = regmap_write(ksz_regmap_16(dev), reg16(dev, reg), value);
 	if (ret)
 		dev_err(dev->dev, "can't write 16bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -566,7 +603,7 @@ static inline int ksz_write32(struct ksz_device *dev, u32 reg, u32 value)
 {
 	int ret;
 
-	ret = regmap_write(ksz_regmap_32(dev), reg, value);
+	ret = regmap_write(ksz_regmap_32(dev), reg32(dev, reg), value);
 	if (ret)
 		dev_err(dev->dev, "can't write 32bit reg: 0x%x %pe\n", reg,
 			ERR_PTR(ret));
@@ -579,7 +616,7 @@ static inline int ksz_rmw16(struct ksz_device *dev, u32 reg, u16 mask,
 {
 	int ret;
 
-	ret = regmap_update_bits(ksz_regmap_16(dev), reg, mask, value);
+	ret = regmap_update_bits(ksz_regmap_16(dev), reg16(dev, reg), mask, value);
 	if (ret)
 		dev_err(dev->dev, "can't rmw 16bit reg 0x%x: %pe\n", reg,
 			ERR_PTR(ret));
@@ -592,7 +629,7 @@ static inline int ksz_rmw32(struct ksz_device *dev, u32 reg, u32 mask,
 {
 	int ret;
 
-	ret = regmap_update_bits(ksz_regmap_32(dev), reg, mask, value);
+	ret = regmap_update_bits(ksz_regmap_32(dev), reg32(dev, reg), mask, value);
 	if (ret)
 		dev_err(dev->dev, "can't rmw 32bit reg 0x%x: %pe\n", reg,
 			ERR_PTR(ret));
@@ -609,14 +646,22 @@ static inline int ksz_write64(struct ksz_device *dev, u32 reg, u64 value)
 	val[0] = swab32(value & 0xffffffffULL);
 	val[1] = swab32(value >> 32ULL);
 
-	return regmap_bulk_write(ksz_regmap_32(dev), reg, val, 2);
+	if (ksz_is_ksz8463(dev)) {
+		int i, ret;
+
+		for (i = 0; i < 2; i++)
+			ret = regmap_write(ksz_regmap_32(dev),
+					   reg32(dev, reg + i * 4), val[i]);
+		return ret;
+	}
+	return regmap_bulk_write(ksz_regmap_32(dev), reg32(dev, reg), val, 2);
 }
 
 static inline int ksz_rmw8(struct ksz_device *dev, int offset, u8 mask, u8 val)
 {
 	int ret;
 
-	ret = regmap_update_bits(ksz_regmap_8(dev), offset, mask, val);
+	ret = regmap_update_bits(ksz_regmap_8(dev), reg8(dev, offset), mask, val);
 	if (ret)
 		dev_err(dev->dev, "can't rmw 8bit reg 0x%x: %pe\n", offset,
 			ERR_PTR(ret));
@@ -709,12 +754,13 @@ static inline bool ksz_is_8895_family(struct ksz_device *dev)
 static inline bool is_ksz8(struct ksz_device *dev)
 {
 	return ksz_is_ksz87xx(dev) || ksz_is_ksz88x3(dev) ||
-	       ksz_is_8895_family(dev);
+	       ksz_is_8895_family(dev) || ksz_is_ksz8463(dev);
 }
 
 static inline bool is_ksz88xx(struct ksz_device *dev)
 {
-	return ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev);
+	return ksz_is_ksz88x3(dev) || ksz_is_8895_family(dev) ||
+	       ksz_is_ksz8463(dev);
 }
 
 static inline bool is_ksz9477(struct ksz_device *dev)
@@ -761,6 +807,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define REG_CHIP_ID0			0x00
 
 #define SW_FAMILY_ID_M			GENMASK(15, 8)
+#define KSZ84_FAMILY_ID			0x84
 #define KSZ87_FAMILY_ID			0x87
 #define KSZ88_FAMILY_ID			0x88
 #define KSZ8895_FAMILY_ID		0x95
@@ -906,6 +953,9 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ_SPI_OP_RD		3
 #define KSZ_SPI_OP_WR		2
 
+#define KSZ8463_SPI_OP_RD	0
+#define KSZ8463_SPI_OP_WR	1
+
 #define swabnot_used(x)		0
 
 #define KSZ_SPI_OP_FLAG_MASK(opcode, swp, regbits, regpad)		\
@@ -939,4 +989,32 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 		[KSZ_REGMAP_32] = KSZ_REGMAP_ENTRY(32, swp, (regbits), (regpad), (regalign)), \
 	}
 
+#define KSZ8463_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)	\
+	{								\
+		.name = #width,						\
+		.val_bits = (width),					\
+		.reg_stride = 1,					\
+		.reg_bits = (regbits) + (regalign),			\
+		.pad_bits = (regpad),					\
+		.max_register = BIT(regbits) - 1,			\
+		.cache_type = REGCACHE_NONE,				\
+		.read_flag_mask =					\
+			KSZ_SPI_OP_FLAG_MASK(KSZ8463_SPI_OP_RD, swp,	\
+					     regbits, regpad),		\
+		.write_flag_mask =					\
+			KSZ_SPI_OP_FLAG_MASK(KSZ8463_SPI_OP_WR, swp,	\
+					     regbits, regpad),		\
+		.lock = ksz_regmap_lock,				\
+		.unlock = ksz_regmap_unlock,				\
+		.reg_format_endian = REGMAP_ENDIAN_BIG,			\
+		.val_format_endian = REGMAP_ENDIAN_LITTLE		\
+	}
+
+#define KSZ8463_REGMAP_TABLE(ksz, swp, regbits, regpad, regalign)	\
+	static const struct regmap_config ksz##_regmap_config[] = {	\
+		[KSZ_REGMAP_8] = KSZ8463_REGMAP_ENTRY(8, swp, (regbits), (regpad), (regalign)), \
+		[KSZ_REGMAP_16] = KSZ8463_REGMAP_ENTRY(16, swp, (regbits), (regpad), (regalign)), \
+		[KSZ_REGMAP_32] = KSZ8463_REGMAP_ENTRY(32, swp, (regbits), (regpad), (regalign)), \
+	}
+
 #endif
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
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index b633d263098c..d7ce2d1cc3f0 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -16,6 +16,10 @@
 
 #include "ksz_common.h"
 
+#define KSZ8463_SPI_ADDR_SHIFT			13
+#define KSZ8463_SPI_ADDR_ALIGN			1
+#define KSZ8463_SPI_TURNAROUND_SHIFT		2
+
 #define KSZ8795_SPI_ADDR_SHIFT			12
 #define KSZ8795_SPI_ADDR_ALIGN			3
 #define KSZ8795_SPI_TURNAROUND_SHIFT		1
@@ -28,6 +32,9 @@
 #define KSZ9477_SPI_ADDR_ALIGN			3
 #define KSZ9477_SPI_TURNAROUND_SHIFT		5
 
+KSZ8463_REGMAP_TABLE(ksz8463, 16, KSZ8463_SPI_ADDR_SHIFT,
+		     KSZ8463_SPI_TURNAROUND_SHIFT, KSZ8463_SPI_ADDR_ALIGN);
+
 KSZ_REGMAP_TABLE(ksz8795, 16, KSZ8795_SPI_ADDR_SHIFT,
 		 KSZ8795_SPI_TURNAROUND_SHIFT, KSZ8795_SPI_ADDR_ALIGN);
 
@@ -58,6 +65,8 @@ static int ksz_spi_probe(struct spi_device *spi)
 	dev->chip_id = chip->chip_id;
 	if (chip->chip_id == KSZ88X3_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
+	else if (chip->chip_id == KSZ8463_CHIP_ID)
+		regmap_config = ksz8463_regmap_config;
 	else if (chip->chip_id == KSZ8795_CHIP_ID ||
 		 chip->chip_id == KSZ8794_CHIP_ID ||
 		 chip->chip_id == KSZ8765_CHIP_ID)
@@ -125,6 +134,10 @@ static void ksz_spi_shutdown(struct spi_device *spi)
 }
 
 static const struct of_device_id ksz_dt_ids[] = {
+	{
+		.compatible = "microchip,ksz8463",
+		.data = &ksz_switch_chips[KSZ8463]
+	},
 	{
 		.compatible = "microchip,ksz8765",
 		.data = &ksz_switch_chips[KSZ8765]
@@ -214,6 +227,7 @@ static const struct of_device_id ksz_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ksz_dt_ids);
 
 static const struct spi_device_id ksz_spi_ids[] = {
+	{ "ksz8463" },
 	{ "ksz8765" },
 	{ "ksz8794" },
 	{ "ksz8795" },
diff --git a/include/linux/platform_data/microchip-ksz.h b/include/linux/platform_data/microchip-ksz.h
index 0e0e8fe6975f..028781ad4059 100644
--- a/include/linux/platform_data/microchip-ksz.h
+++ b/include/linux/platform_data/microchip-ksz.h
@@ -23,6 +23,7 @@
 #include <linux/platform_data/dsa.h>
 
 enum ksz_chip_id {
+	KSZ8463_CHIP_ID = 0x8463,
 	KSZ8563_CHIP_ID = 0x8563,
 	KSZ8795_CHIP_ID = 0x8795,
 	KSZ8794_CHIP_ID = 0x8794,
-- 
2.34.1


