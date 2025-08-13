Return-Path: <netdev+bounces-213202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FF9B241B6
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721C2881236
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81F2D46CE;
	Wed, 13 Aug 2025 06:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sz0suKej"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3CA2D3ED5;
	Wed, 13 Aug 2025 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755066983; cv=none; b=StqNnERh6B7PTVa6OrVtS9pud2ot/gonWFAoTxhEZQR4F335MGQxB/F8DiI1cG10FpKXCWisfmgyevzOqEOZUE32+ZbpNn6bGaqAMcl+HOl1mJb0OKhKdZV7aM3paWNrlZyOPrgCrRBDJ3vcYAg8qrMNyX9AJ7a8/cuQUVJ1rR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755066983; c=relaxed/simple;
	bh=3A4+zUwKZ1wnZgT0Vud6rLqyK8IqgqIFERcr7GSnEJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkCgWWHRsZoQ/uq4h4STbtAKd0fd5MXsw4TPBk4+z9IO/K07bhF6AUhaHr5Oq0SHcqutE8FS6XU47sBjyMALUOLMvhPTNStxDfa7AU6up1RwO4gi2Fb/eZn9zfhS/PjwQyMKIlNqcXuV3yIUTTUJjXy7f+Admbq+lXIRj08gDeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sz0suKej; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755066982; x=1786602982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3A4+zUwKZ1wnZgT0Vud6rLqyK8IqgqIFERcr7GSnEJY=;
  b=sz0suKej6kXz0EDUdzF2wOhf5UtaFJPPvfbC1Yzx61OjJ3GP+X9c6VEE
   vQR7MuPB3t1uVAkfLkDq+uQqBTeFR9Vw2X/LmZrphRQzndyA2hVnaawFn
   bEQsizUIEBLch/t4Gt6QfNjL6jVMJb0hq0UsCK10zMP1ysfuQkOqcEjeE
   Vd2Ae7e53v55xFQZHxsoA8A99MohhAnzbW1s3Jki9KECEvobywWKKqrPd
   x+YUQ+ogUXWDQMWcp4IcIYKxPupmScXax6UJzbUBz2P6ELZpRs3UvdxMX
   b/zimCLL6M6Zm/xf+IhlKAZSgb1wxy3zogpgAEziJ1wBw/aUM0TKjvxf9
   g==;
X-CSE-ConnectionGUID: HLS0dFJYR22/6mpwumLuLw==
X-CSE-MsgGUID: pJIwVFI1TtuKQFYnXL4TsA==
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="276526648"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2025 23:36:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 12 Aug 2025 23:35:58 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 12 Aug 2025 23:35:56 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3 3/3] net: phy: micrel: Add support for lan8842
Date: Wed, 13 Aug 2025 08:30:44 +0200
Message-ID: <20250813063044.421661-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813063044.421661-1-horatiu.vultur@microchip.com>
References: <20250813063044.421661-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The LAN8842 is a low-power, single port triple-speed (10BASE-T/ 100BASE-TX/
1000BASE-T) ethernet physical layer transceiver (PHY) that supports
transmission and reception of data on standard CAT-5, as well as CAT-5e and
CAT-6, Unshielded Twisted Pair (UTP) cables.

The LAN8842 supports industry-standard SGMII (Serial Gigabit Media
Independent Interface) providing chip-to-chip connection to a Gigabit
Ethernet MAC using a single serialized link (differential pair) in each
direction.

There are 2 variants of the lan8842. The one that supports timestamping
(lan8842) and one that doesn't have timestamping (lan8832).

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c   | 203 +++++++++++++++++++++++++++++++++++++
 include/linux/micrel_phy.h |   1 +
 2 files changed, 204 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 968f6e724c066..cbd1b542c0ad6 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -448,6 +448,17 @@ struct kszphy_priv {
 	struct kszphy_phy_stats phy_stats;
 };
 
+struct lan8842_phy_stats {
+	u64 rx_packets;
+	u64 rx_errors;
+	u64 tx_packets;
+	u64 tx_errors;
+};
+
+struct lan8842_priv {
+	struct lan8842_phy_stats phy_stats;
+};
+
 static const struct kszphy_type lan8814_type = {
 	.led_mode_reg		= ~LAN8814_LED_CTRL_1,
 	.cable_diag_reg		= LAN8814_CABLE_DIAG,
@@ -5766,6 +5777,184 @@ static int ksz9131_resume(struct phy_device *phydev)
 	return kszphy_resume(phydev);
 }
 
+#define LAN8842_SELF_TEST			14 /* 0x0e */
+#define LAN8842_SELF_TEST_RX_CNT_ENA		BIT(8)
+#define LAN8842_SELF_TEST_TX_CNT_ENA		BIT(4)
+
+static int lan8842_probe(struct phy_device *phydev)
+{
+	struct lan8842_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	/* Similar to lan8814 this PHY has a pin which needs to be pulled down
+	 * to enable to pass any traffic through it. Therefore use the same
+	 * function as lan8814
+	 */
+	ret = lan8814_release_coma_mode(phydev);
+	if (ret)
+		return ret;
+
+	/* Enable to count the RX and TX packets */
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_PCS_DIGITAL,
+				    LAN8842_SELF_TEST,
+				    LAN8842_SELF_TEST_RX_CNT_ENA |
+				    LAN8842_SELF_TEST_TX_CNT_ENA);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+#define LAN8842_SGMII_AUTO_ANEG_ENA		69 /* 0x45 */
+#define LAN8842_FLF				15 /* 0x0e */
+#define LAN8842_FLF_ENA				BIT(1)
+#define LAN8842_FLF_ENA_LINK_DOWN		BIT(0)
+
+static int lan8842_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Reset the PHY */
+	ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				     LAN8814_QSGMII_SOFT_RESET,
+				     LAN8814_QSGMII_SOFT_RESET_BIT,
+				     LAN8814_QSGMII_SOFT_RESET_BIT);
+	if (ret < 0)
+		return ret;
+
+	/* Disable ANEG with QSGMII PCS Host side
+	 * It has the same address as lan8814
+	 */
+	ret = lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
+				     LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
+				     LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
+				     0);
+	if (ret < 0)
+		return ret;
+
+	/* Disable also the SGMII_AUTO_ANEG_ENA, this will determine what is the
+	 * PHY autoneg with the other end and then will update the host side
+	 */
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				    LAN8842_SGMII_AUTO_ANEG_ENA, 0);
+	if (ret < 0)
+		return ret;
+
+	/* To allow the PHY to control the LEDs the GPIOs of the PHY should have
+	 * a function mode and not the GPIO. Apparently by default the value is
+	 * GPIO and not function even though the datasheet it says that it is
+	 * function. Therefore set this value.
+	 */
+	return lanphy_write_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				     LAN8814_GPIO_EN2, 0);
+}
+
+#define LAN8842_INTR_CTRL_REG			52 /* 0x34 */
+
+static int lan8842_config_intr(struct phy_device *phydev)
+{
+	int err;
+
+	lanphy_write_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+			      LAN8842_INTR_CTRL_REG,
+			      LAN8814_INTR_CTRL_REG_INTR_ENABLE);
+
+	/* enable / disable interrupts */
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		err = lan8814_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		err = phy_write(phydev, LAN8814_INTC, LAN8814_INT_LINK);
+	} else {
+		err = phy_write(phydev, LAN8814_INTC, 0);
+		if (err)
+			return err;
+
+		err = lan8814_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+
+static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
+{
+	int ret = IRQ_NONE;
+	int irq_status;
+
+	irq_status = phy_read(phydev, LAN8814_INTS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (irq_status & LAN8814_INT_LINK) {
+		phy_trigger_machine(phydev);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static u64 lan8842_get_stat(struct phy_device *phydev, int count, int *regs)
+{
+	int val;
+	u64 ret = 0;
+
+	for (int j = 0; j < count; ++j) {
+		val = lanphy_read_page_reg(phydev, LAN8814_PAGE_PCS_DIGITAL,
+					   regs[j]);
+		if (val < 0)
+			return U64_MAX;
+
+		ret <<= 16;
+		ret += val;
+	}
+	return ret;
+}
+
+static int lan8842_update_stats(struct phy_device *phydev)
+{
+	struct lan8842_priv *priv = phydev->priv;
+	int rx_packets_regs[] = {88, 61, 60};
+	int rx_errors_regs[] = {63, 62};
+	int tx_packets_regs[] = {89, 85, 84};
+	int tx_errors_regs[] = {87, 86};
+
+	priv->phy_stats.rx_packets = lan8842_get_stat(phydev,
+						      ARRAY_SIZE(rx_packets_regs),
+						      rx_packets_regs);
+	priv->phy_stats.rx_errors = lan8842_get_stat(phydev,
+						     ARRAY_SIZE(rx_errors_regs),
+						     rx_errors_regs);
+	priv->phy_stats.tx_packets = lan8842_get_stat(phydev,
+						      ARRAY_SIZE(tx_packets_regs),
+						      tx_packets_regs);
+	priv->phy_stats.tx_errors = lan8842_get_stat(phydev,
+						     ARRAY_SIZE(tx_errors_regs),
+						     tx_errors_regs);
+
+	return 0;
+}
+
+static void lan8842_get_phy_stats(struct phy_device *phydev,
+				  struct ethtool_eth_phy_stats *eth_stats,
+				  struct ethtool_phy_stats *stats)
+{
+	struct lan8842_priv *priv = phydev->priv;
+
+	stats->rx_packets = priv->phy_stats.rx_packets;
+	stats->rx_errors = priv->phy_stats.rx_errors;
+	stats->tx_packets = priv->phy_stats.tx_packets;
+	stats->tx_errors = priv->phy_stats.tx_errors;
+}
+
 static struct phy_driver ksphy_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
@@ -5985,6 +6174,19 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= lan8841_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+}, {
+	PHY_ID_MATCH_MODEL(PHY_ID_LAN8842),
+	.name		= "Microchip LAN8842 Gigabit PHY",
+	.flags		= PHY_POLL_CABLE_TEST,
+	.driver_data	= &lan8814_type,
+	.probe		= lan8842_probe,
+	.config_init	= lan8842_config_init,
+	.config_intr	= lan8842_config_intr,
+	.handle_interrupt = lan8842_handle_interrupt,
+	.get_phy_stats	= lan8842_get_phy_stats,
+	.update_stats	= lan8842_update_stats,
+	.cable_test_start	= lan8814_cable_test_start,
+	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
 	.name		= "Microchip KSZ9131 Gigabit PHY",
@@ -6080,6 +6282,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8814) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8804) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8841) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN8842) },
 	{ }
 };
 
diff --git a/include/linux/micrel_phy.h b/include/linux/micrel_phy.h
index 9af01bdd86d26..ca691641788b8 100644
--- a/include/linux/micrel_phy.h
+++ b/include/linux/micrel_phy.h
@@ -32,6 +32,7 @@
 #define PHY_ID_LAN8814		0x00221660
 #define PHY_ID_LAN8804		0x00221670
 #define PHY_ID_LAN8841		0x00221650
+#define PHY_ID_LAN8842		0x002216C0
 
 #define PHY_ID_KSZ886X		0x00221430
 #define PHY_ID_KSZ8863		0x00221435
-- 
2.34.1


