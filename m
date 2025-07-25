Return-Path: <netdev+bounces-209920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7DAB11520
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587F94E82C9
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3369A14A09C;
	Fri, 25 Jul 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2UX/CR9G"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE14B405F7;
	Fri, 25 Jul 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753402687; cv=none; b=nvxuduhXdC0h1SJphxnMziEFwqLEocZalQmItbzl98cfqzgKNw/eUUUorHAPUyIET8TKf3C91Jyzq36g0S9NaForIWjZHEODW/V6Tplhq1Qn8zO09DlMFpWPJZq9sSBlrHD4Z6tCgcjf1s9pWlKpQr+GiGPmtV1TYUEwROsMoWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753402687; c=relaxed/simple;
	bh=yopnrmc/zTdtfVctW4VheIgiysuVOx4+uWGHMMSdVUc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dx3AfwE7ouOA+OnjOQ+INreWkWi6IPwu1JpcmUE59SxwlvOMPvnUu1dkfElGkFmD3jurX52ZuZVWJ4uM/QoOaolj89PMt+3NyWC4TFwN1sy+7/Vm4SkeSDYiWmcOfLuaf418I4dQiwbXaW5OVtIPZVz7FRkDKrOIECGaFgq2tkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2UX/CR9G; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753402684; x=1784938684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yopnrmc/zTdtfVctW4VheIgiysuVOx4+uWGHMMSdVUc=;
  b=2UX/CR9GcYxqrs6AEajQAZRGu+FV/SAqpKpt+Gk6AF8wYI/v2+V4ICa1
   Vl+r7X+XVzjN0YcRGyD1NNPvn2RG6B1IEC5GR5XnKjGqj9MKD8dsuQfO/
   siI+ClAnIrc/7JoibqIs9TJ3jGP685bl9JiJ2Gq40QpcoPAsHuu9iLzf5
   Jx/eKFceBH7zX3uL7tGPKKZvI9EGkhuDM+MaIy4k37+el0lxr8viTHYrl
   SnZCCdVoxbvKiq98kft/a0UMJ512M2a9NxAfC5csZdM/tBxr0bbeUetPM
   a76jFboFADOe53SEeJgHPqdiSKtXlnn7L+8tDg2CXojSit9uQbtGVt591
   w==;
X-CSE-ConnectionGUID: eDIQSHZ3TP2otfHW2Moz3Q==
X-CSE-MsgGUID: vOJL6+JRSoi4E27ZHJlpOw==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="49728963"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 17:18:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 17:17:52 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Thu, 24 Jul 2025 17:17:52 -0700
From: <Tristram.Ha@microchip.com>
To: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>, Rob Herring <robh@kernel.org>,
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Simon Horman
	<horms@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Marek Vasut <marex@denx.de>,
	<UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tristram Ha
	<tristram.ha@microchip.com>
Subject: [PATCH net-next v6 2/6] net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
Date: Thu, 24 Jul 2025 17:17:49 -0700
Message-ID: <20250725001753.6330-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725001753.6330-1-Tristram.Ha@microchip.com>
References: <20250725001753.6330-1-Tristram.Ha@microchip.com>
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
register accesses need to be re-arranged.

This patch adds the basic structure for using KSZ8463.  It cannot use the
same regmap table for other KSZ switches as it interprets the 16-bit
value as little-endian and its SPI commands are different.

KSZ8463 uses a byte-enable mechanism to specify 8-bit, 16-bit, and 32-bit
access.  The register is first shifted right by 2 then left by 4.  Extra
4 bits are added.  If the access is 8-bit one of the 4 bits is set.  If
the access is 16-bit two of the 4 bits are set.  If the access is 32-bit
all 4 bits are set.  The SPI command for read or write is then added.

Because of this register transformation separate SPI read and write
functions are provided for KSZ8463.

KSZ8463's internal PHYs use standard PHY register definitions so there is
no need to remap things.  However, the hardware has a bug that the high
word and low word of the PHY id are swapped.  In addition the port
registers are arranged differently so KSZ8463 has its own mapping for
port registers and PHY registers.  Therefore the PORT_CTRL_ADDR macro is
replaced with the get_port_addr helper function.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
v6
- Set use_single_read and use_single_write so that 64-bit access works
- Change register values for big-endian system if necessary

v5
- Use separate SPI read and write functions for KSZ8463
- remove inline keyword inside ksz8.c

v4
- Fix a typo in ksz8_reg.h
- Fix logic in ksz8463_r_phy()

 drivers/net/dsa/microchip/ksz8.c            |  83 +++++++++++++-
 drivers/net/dsa/microchip/ksz8.h            |   4 +
 drivers/net/dsa/microchip/ksz8_reg.h        |  49 +++++++++
 drivers/net/dsa/microchip/ksz_common.c      | 114 ++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h      |  37 ++++++-
 drivers/net/dsa/microchip/ksz_spi.c         | 104 ++++++++++++++++++
 include/linux/platform_data/microchip-ksz.h |   1 +
 7 files changed, 389 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index be433b4e2b1c..3761a81a7320 100644
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
@@ -41,7 +42,8 @@ static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool set)
 static void ksz_port_cfg(struct ksz_device *dev, int port, int offset, u8 bits,
 			 bool set)
 {
-	regmap_update_bits(ksz_regmap_8(dev), PORT_CTRL_ADDR(port, offset),
+	regmap_update_bits(ksz_regmap_8(dev),
+			   dev->dev_ops->get_port_addr(port, offset),
 			   bits, set ? bits : 0);
 }
 
@@ -194,6 +196,7 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return ksz8795_change_mtu(dev, frame_size);
+	case KSZ8463_CHIP_ID:
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
@@ -1947,6 +1950,84 @@ u32 ksz8_get_port_addr(int port, int offset)
 	return PORT_CTRL_ADDR(port, offset);
 }
 
+u32 ksz8463_get_port_addr(int port, int offset)
+{
+	return offset + 0x18 * port;
+}
+
+static u16 ksz8463_get_phy_addr(u16 phy, u16 reg, u16 offset)
+{
+	return offset + reg * 2 + phy * (P2MBCR - P1MBCR);
+}
+
+int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
+{
+	u16 sw_reg = 0;
+	u16 data = 0;
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
+	case MII_TPISTATUS:
+		/* This register holds the PHY interrupt status for simulated
+		 * Micrel KSZ PHY.
+		 */
+		data = 0x0505;
+		break;
+	default:
+		break;
+	}
+	if (sw_reg) {
+		ret = ksz_read16(dev, sw_reg, &data);
+		if (ret)
+			return ret;
+	}
+	*val = data;
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
index 329688603a58..491aa1e50175 100644
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
+#define P1ANLPR				0x56
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
index 6e1daf0018bc..095e647b3897 100644
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
@@ -3400,6 +3509,7 @@ static enum dsa_tag_protocol ksz_get_tag_protocol(struct dsa_switch *ds,
 		proto = DSA_TAG_PROTO_KSZ8795;
 
 	if (dev->chip_id == KSZ88X3_CHIP_ID ||
+	    dev->chip_id == KSZ8463_CHIP_ID ||
 	    dev->chip_id == KSZ8563_CHIP_ID ||
 	    dev->chip_id == KSZ9893_CHIP_ID ||
 	    dev->chip_id == KSZ9563_CHIP_ID)
@@ -3512,6 +3622,7 @@ static int ksz_max_mtu(struct dsa_switch *ds, int port)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return KSZ8795_HUGE_PACKET_SIZE - VLAN_ETH_HLEN - ETH_FCS_LEN;
+	case KSZ8463_CHIP_ID:
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
@@ -3866,6 +3977,9 @@ static int ksz_switch_detect(struct ksz_device *dev)
 	id2 = FIELD_GET(SW_CHIP_ID_M, id16);
 
 	switch (id1) {
+	case KSZ84_FAMILY_ID:
+		dev->chip_id = KSZ8463_CHIP_ID;
+		break;
 	case KSZ87_FAMILY_ID:
 		if (id2 == KSZ87_CHIP_ID_95) {
 			u8 val;
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a08417df2ca4..a1eb39771bb9 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -222,6 +222,7 @@ struct ksz_device {
 
 /* List of supported models */
 enum ksz_model {
+	KSZ8463,
 	KSZ8563,
 	KSZ8567,
 	KSZ8795,
@@ -484,6 +485,11 @@ static inline struct regmap *ksz_regmap_32(struct ksz_device *dev)
 	return dev->regmap[KSZ_REGMAP_32];
 }
 
+static inline bool ksz_is_ksz8463(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8463_CHIP_ID;
+}
+
 static inline int ksz_read8(struct ksz_device *dev, u32 reg, u8 *val)
 {
 	unsigned int value;
@@ -709,12 +715,13 @@ static inline bool ksz_is_8895_family(struct ksz_device *dev)
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
@@ -761,6 +768,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define REG_CHIP_ID0			0x00
 
 #define SW_FAMILY_ID_M			GENMASK(15, 8)
+#define KSZ84_FAMILY_ID			0x84
 #define KSZ87_FAMILY_ID			0x87
 #define KSZ88_FAMILY_ID			0x88
 #define KSZ8895_FAMILY_ID		0x95
@@ -939,4 +947,29 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 		[KSZ_REGMAP_32] = KSZ_REGMAP_ENTRY(32, swp, (regbits), (regpad), (regalign)), \
 	}
 
+#define KSZ8463_REGMAP_ENTRY(width, regbits, regpad, regalign)		\
+	{								\
+		.name = #width,						\
+		.val_bits = (width),					\
+		.reg_stride = (width / 8),				\
+		.reg_bits = (regbits) + (regalign),			\
+		.pad_bits = (regpad),					\
+		.read = ksz8463_spi_read,				\
+		.write = ksz8463_spi_write,				\
+		.max_register = BIT(regbits) - 1,			\
+		.cache_type = REGCACHE_NONE,				\
+		.zero_flag_mask = 1,					\
+		.use_single_read = 1,					\
+		.use_single_write = 1,					\
+		.lock = ksz_regmap_lock,				\
+		.unlock = ksz_regmap_unlock,				\
+	}
+
+#define KSZ8463_REGMAP_TABLE(ksz, regbits, regpad, regalign)		\
+	static const struct regmap_config ksz##_regmap_config[] = {	\
+		[KSZ_REGMAP_8] = KSZ8463_REGMAP_ENTRY(8, (regbits), (regpad), (regalign)), \
+		[KSZ_REGMAP_16] = KSZ8463_REGMAP_ENTRY(16, (regbits), (regpad), (regalign)), \
+		[KSZ_REGMAP_32] = KSZ8463_REGMAP_ENTRY(32, (regbits), (regpad), (regalign)), \
+	}
+
 #endif
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index b633d263098c..d8001734b057 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -16,6 +16,10 @@
 
 #include "ksz_common.h"
 
+#define KSZ8463_SPI_ADDR_SHIFT			13
+#define KSZ8463_SPI_ADDR_ALIGN			3
+#define KSZ8463_SPI_TURNAROUND_SHIFT		2
+
 #define KSZ8795_SPI_ADDR_SHIFT			12
 #define KSZ8795_SPI_ADDR_ALIGN			3
 #define KSZ8795_SPI_TURNAROUND_SHIFT		1
@@ -37,6 +41,99 @@ KSZ_REGMAP_TABLE(ksz8863, 16, KSZ8863_SPI_ADDR_SHIFT,
 KSZ_REGMAP_TABLE(ksz9477, 32, KSZ9477_SPI_ADDR_SHIFT,
 		 KSZ9477_SPI_TURNAROUND_SHIFT, KSZ9477_SPI_ADDR_ALIGN);
 
+static u16 ksz8463_reg(u16 reg, size_t size)
+{
+	switch (size) {
+	case 1:
+		reg = ((reg >> 2) << 4) | (1 << (reg & 3));
+		break;
+	case 2:
+		reg = ((reg >> 2) << 4) | (reg & 2 ? 0x0c : 0x03);
+		break;
+	default:
+		reg = ((reg >> 2) << 4) | 0xf;
+		break;
+	}
+	reg <<= KSZ8463_SPI_TURNAROUND_SHIFT;
+	return reg;
+}
+
+static int ksz8463_spi_read(void *context,
+			    const void *reg, size_t reg_size,
+			    void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	u8 bytes[2];
+	u16 cmd;
+	int rc;
+
+	if (reg_size > 2 || val_size > 4)
+		return -EINVAL;
+	memcpy(&cmd, reg, sizeof(u16));
+	cmd = ksz8463_reg(cmd, val_size);
+	/* SPI command uses big-endian format. */
+	put_unaligned_be16(cmd, bytes);
+	rc = spi_write_then_read(spi, bytes, reg_size, val, val_size);
+#if defined(__BIG_ENDIAN)
+	/* Register value uses little-endian format so need to convert when
+	 * running in big-endian system.
+	 */
+	if (!rc && val_size > 1) {
+		if (val_size == 2) {
+			u16 v = get_unaligned_le16(val);
+
+			memcpy(val, &v, sizeof(v));
+		} else if (val_size == 4) {
+			u32 v = get_unaligned_le32(val);
+
+			memcpy(val, &v, sizeof(v));
+		}
+	}
+#endif
+	return rc;
+}
+
+static int ksz8463_spi_write(void *context, const void *data, size_t count)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	size_t val_size = count - 2;
+	u8 bytes[6];
+	u16 cmd;
+
+	if (count <= 2 || count > 6)
+		return -EINVAL;
+	memcpy(bytes, data, count);
+	memcpy(&cmd, data, sizeof(u16));
+	cmd = ksz8463_reg(cmd, val_size);
+	cmd |= (1 << (KSZ8463_SPI_ADDR_SHIFT + KSZ8463_SPI_TURNAROUND_SHIFT));
+	/* SPI command uses big-endian format. */
+	put_unaligned_be16(cmd, bytes);
+#if defined(__BIG_ENDIAN)
+	/* Register value uses little-endian format so need to convert when
+	 * running in big-endian system.
+	 */
+	if (val_size == 2) {
+		u8 *val = &bytes[2];
+		u16 v;
+
+		memcpy(&v, val, sizeof(v));
+		put_unaligned_le16(v, val);
+	} else if (val_size == 4) {
+		u8 *val = &bytes[2];
+		u32 v;
+
+		memcpy(&v, val, sizeof(v));
+		put_unaligned_le32(v, val);
+	}
+#endif
+	return spi_write(spi, bytes, count);
+}
+
+KSZ8463_REGMAP_TABLE(ksz8463, KSZ8463_SPI_ADDR_SHIFT, 0,
+		     KSZ8463_SPI_ADDR_ALIGN);
+
 static int ksz_spi_probe(struct spi_device *spi)
 {
 	const struct regmap_config *regmap_config;
@@ -58,6 +155,8 @@ static int ksz_spi_probe(struct spi_device *spi)
 	dev->chip_id = chip->chip_id;
 	if (chip->chip_id == KSZ88X3_CHIP_ID)
 		regmap_config = ksz8863_regmap_config;
+	else if (chip->chip_id == KSZ8463_CHIP_ID)
+		regmap_config = ksz8463_regmap_config;
 	else if (chip->chip_id == KSZ8795_CHIP_ID ||
 		 chip->chip_id == KSZ8794_CHIP_ID ||
 		 chip->chip_id == KSZ8765_CHIP_ID)
@@ -125,6 +224,10 @@ static void ksz_spi_shutdown(struct spi_device *spi)
 }
 
 static const struct of_device_id ksz_dt_ids[] = {
+	{
+		.compatible = "microchip,ksz8463",
+		.data = &ksz_switch_chips[KSZ8463]
+	},
 	{
 		.compatible = "microchip,ksz8765",
 		.data = &ksz_switch_chips[KSZ8765]
@@ -214,6 +317,7 @@ static const struct of_device_id ksz_dt_ids[] = {
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


