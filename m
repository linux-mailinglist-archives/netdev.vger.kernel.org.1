Return-Path: <netdev+bounces-214465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94544B29B62
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 09:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC66189D102
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 07:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537952BD5BD;
	Mon, 18 Aug 2025 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LVO5Q23r"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8113229B228;
	Mon, 18 Aug 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503751; cv=none; b=QgaCoP6TtRLQvC3RQfVZYeXie9DqkdN839ls0xmwdFNEsbLBupeQi3ag115v4Dm6+lMuSoeAxItmwmiYZDYiJUiOwN9K9iYv1rLHVjIpX+IsdtaVXfoo/26dNg7hBqADThjNAD0NJ8/B/7IPvch70qpXUOoKCA2JJkeOe1EI9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503751; c=relaxed/simple;
	bh=NdkaO7qTOV++SmAnaVAD0he5pLCcDGaSDlgJ+scH07Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1zUGL6eI2uow/iV47C53uZ8FU5dLHiZtBC73n+TVi5oLrr0U0X+PerbfwUw41UNmhvGuUFQ+XUmhH9II0DVLua45Ra7k/yA4Eu/7FiL+wPg7xWI6Wk31IpwWeGwXlMB7bkwxW/BTV/4yAqT35S7UokOemSZTcMt5pd2IGaHXPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LVO5Q23r; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755503749; x=1787039749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NdkaO7qTOV++SmAnaVAD0he5pLCcDGaSDlgJ+scH07Q=;
  b=LVO5Q23r44zTAj+7CFTBXiVUVkKE8kxTZ79bi/YXo5HNKU+Ak+HDFB9I
   j5IiLG96LsVuPx/OLwyy6uptzIoBFy633O58PDFGlqEZC8biLE4QHrDjH
   NpBb25lADU8zA1grEJxUesmIJV2BYMSejfNvE+zw4j53rv18dWQlhyXZa
   M928TCivjNsa54Vvf9hW7DlqRV7+RQtEQDRUnr6Ivi8QrzMcy82z6TMKs
   BItr19R2QUtLYOuatPqghBlK3epupN/gTa19pj/MsvIwCr/FbH1MaM7Cc
   3FGeZ1/BehtQG70Xy5LD/65n7KDgtjkPkc3Sr9Eqo6KfL6EfZWLupmk7n
   A==;
X-CSE-ConnectionGUID: lelYe7zJQdi8/urTPkYXFg==
X-CSE-MsgGUID: zlqJNGU5S3i7Rb0QcDBu7A==
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="212736487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Aug 2025 00:55:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 18 Aug 2025 00:55:26 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 18 Aug 2025 00:55:24 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>,
	<alok.a.tiwari@oracle.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v5 4/4] net: phy: micrel: Add support for lan8842
Date: Mon, 18 Aug 2025 09:51:21 +0200
Message-ID: <20250818075121.1298170-5-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818075121.1298170-1-horatiu.vultur@microchip.com>
References: <20250818075121.1298170-1-horatiu.vultur@microchip.com>
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
 drivers/net/phy/micrel.c   | 209 +++++++++++++++++++++++++++++++++++++
 include/linux/micrel_phy.h |   1 +
 2 files changed, 210 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index c621ed465d2e5..04bd744920b0d 100644
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
@@ -5768,6 +5779,188 @@ static int ksz9131_resume(struct phy_device *phydev)
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
+static unsigned int lan8842_inband_caps(struct phy_device *phydev,
+					phy_interface_t interface)
+{
+	/* Inband configuration can be enabled or disabled using the registers
+	 * PCS1G_ANEG_CONFIG.
+	 */
+	return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
+}
+
+static int lan8842_config_inband(struct phy_device *phydev, unsigned int modes)
+{
+	bool enable;
+
+	if (modes == LINK_INBAND_DISABLE)
+		enable = false;
+	else
+		enable = true;
+
+	/* Disable or enable in-band autoneg with PCS Host side
+	 * It has the same address as lan8814
+	 */
+	return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PORT_REGS,
+				      LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
+				      LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
+				      enable ? LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA : 0);
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
+	u64 ret = 0;
+	int val;
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
@@ -5987,6 +6180,21 @@ static struct phy_driver ksphy_driver[] = {
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
+	.inband_caps	= lan8842_inband_caps,
+	.config_inband	= lan8842_config_inband,
+	.handle_interrupt = lan8842_handle_interrupt,
+	.get_phy_stats	= lan8842_get_phy_stats,
+	.update_stats	= lan8842_update_stats,
+	.cable_test_start	= lan8814_cable_test_start,
+	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
 	PHY_ID_MATCH_MODEL(PHY_ID_KSZ9131),
 	.name		= "Microchip KSZ9131 Gigabit PHY",
@@ -6082,6 +6290,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
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


