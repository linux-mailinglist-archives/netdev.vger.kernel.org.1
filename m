Return-Path: <netdev+bounces-204791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B667DAFC136
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 05:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A08E7AE63F
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 03:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7012222FE15;
	Tue,  8 Jul 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z7W406b5"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AC1DDD1;
	Tue,  8 Jul 2025 03:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751944639; cv=none; b=sKPIdt+ywNmFV8tBzkExcP0z93mpSf5E/CE0LjExkG0m9yNuH2nVlZQbosfxqqJ2GPSmExdHuGBHckOY2wyDPzvR2ifEswLnDjoV3sA1D+zRdJQF8ine3hvzxoIYqeAb24nmujA9BlvbPiSsUHwBavdFrSngGENwXaX4MnUQ38Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751944639; c=relaxed/simple;
	bh=6bx/Zz1UqwlsyHy6BhYJRPtyPqCDinDZc1KRINGZhG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fnflhTsMdYeoxfnGl1WtlCyDCnuLx4CjXrt3Yco57gHOhcbEs728C3zALTSiM9JZ3itM4IRTd1vrNlGn8khveBSAI2KRtFTgRmhqqkMzBCfllr1ivFrDc26rDCjZEnzTjp2/XU5BDwid5hjWFN8CeQeFp96XDr5Ry4tpoJujSgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z7W406b5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1751944635; x=1783480635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6bx/Zz1UqwlsyHy6BhYJRPtyPqCDinDZc1KRINGZhG0=;
  b=Z7W406b5idZnnXKWsj3yEiO7c6+sa6wNQw0qPmQuR0g0lUDgoZQL8IaE
   FgT9OVyrApSb/nbxWSE0/UBj7DGkp+nJcPZOzQ7P/Y5hfJI49xw0E3Ale
   xOcH8gTPumR0AAx/Ma9/RVC4AQ1UsN5unoh/rcycUU8oben9iJ0J2BdAB
   9RZmcbPxzVnojUhyn/0OcD3KvM8hPPWAXHvACA/95ZA8grppfm/jRrVyB
   lHF9xQs/mV48xPeb9N0+FJr8vv29wTjDgZODGjdhseI7uoPAMjCpIntkR
   yzO5AhAflnvwRKgSt28B1hQy7RlRq/JxEEY3s59Roc/DKwiDeaP6Nfpx7
   g==;
X-CSE-ConnectionGUID: cVEISvaDRiehsZPvdpmZNg==
X-CSE-MsgGUID: 8aL1KSujTLOZQqVkxDzNYg==
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; 
   d="scan'208";a="43198298"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Jul 2025 20:17:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 7 Jul 2025 20:16:45 -0700
Received: from pop-os.microchip.com (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 7 Jul 2025 20:16:44 -0700
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
Subject: [PATCH net-next 2/6 v2] net: dsa: microchip: Add KSZ8463 switch support to KSZ DSA driver
Date: Mon, 7 Jul 2025 20:16:44 -0700
Message-ID: <20250708031648.6703-3-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708031648.6703-1-Tristram.Ha@microchip.com>
References: <20250708031648.6703-1-Tristram.Ha@microchip.com>
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

This patch adds the basic structure for using KSZ8463.  It cannot use the
same regmap table for other KSZ switches as it interprets the 16-bit
value as little-endian and its SPI commands are different.

KSZ8463's internal PHYs use standard PHY register definitions so there is
no need to remap things.  However, the hardware has a bug that the high
word and low word of the PHY id are swapped.  In addition the port
registers are arranged differently so KSZ8463 has its own mapping for
port registers and PHY registers.

Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8.c            |  87 +++++++++++++++
 drivers/net/dsa/microchip/ksz8.h            |   4 +
 drivers/net/dsa/microchip/ksz8_reg.h        |  49 +++++++++
 drivers/net/dsa/microchip/ksz_common.c      | 114 ++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h      |  33 ++++++
 drivers/net/dsa/microchip/ksz_spi.c         |  14 +++
 include/linux/platform_data/microchip-ksz.h |   1 +
 7 files changed, 302 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index be433b4e2b1c..92a720ee1f71 100644
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
@@ -194,6 +195,7 @@ int ksz8_change_mtu(struct ksz_device *dev, int port, int mtu)
 	case KSZ8794_CHIP_ID:
 	case KSZ8765_CHIP_ID:
 		return ksz8795_change_mtu(dev, frame_size);
+	case KSZ8463_CHIP_ID:
 	case KSZ88X3_CHIP_ID:
 	case KSZ8864_CHIP_ID:
 	case KSZ8895_CHIP_ID:
@@ -1947,6 +1949,91 @@ u32 ksz8_get_port_addr(int port, int offset)
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
index a08417df2ca4..3ffca7054983 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -222,6 +222,7 @@ struct ksz_device {
 
 /* List of supported models */
 enum ksz_model {
+	KSZ8463,
 	KSZ8563,
 	KSZ8567,
 	KSZ8795,
@@ -761,6 +762,7 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define REG_CHIP_ID0			0x00
 
 #define SW_FAMILY_ID_M			GENMASK(15, 8)
+#define KSZ84_FAMILY_ID			0x84
 #define KSZ87_FAMILY_ID			0x87
 #define KSZ88_FAMILY_ID			0x88
 #define KSZ8895_FAMILY_ID		0x95
@@ -906,6 +908,9 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
 #define KSZ_SPI_OP_RD		3
 #define KSZ_SPI_OP_WR		2
 
+#define KSZ8463_SPI_OP_RD	0
+#define KSZ8463_SPI_OP_WR	1
+
 #define swabnot_used(x)		0
 
 #define KSZ_SPI_OP_FLAG_MASK(opcode, swp, regbits, regpad)		\
@@ -939,4 +944,32 @@ static inline bool ksz_is_sgmii_port(struct ksz_device *dev, int port)
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


