Return-Path: <netdev+bounces-209872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B40B11206
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 22:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791FB1C26216
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A31254873;
	Thu, 24 Jul 2025 20:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JTTnNvVL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA99239581;
	Thu, 24 Jul 2025 20:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753387934; cv=none; b=htyMFL9qk4NH7Tuu0+cekTHWTpHxtB+ne+p93+0pgruhbdPpefjPuIgf++7grkWHkFG4hdeqKR2NpnGDyQIrrXGyM1NYzi6B2VuDVn2wduyR23g0EW5zNNjbWTUsbn3MsUQ1eZ5myiwjju5bQcr+0LepDUbHps3NFzm5k3Pz2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753387934; c=relaxed/simple;
	bh=pUAqg/uKxaVXamSlKodRXwwjXO4TngzCIQoeMPyrq8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aYFE4khE9TtgCKZ89zb5xDx9an/6yh0d4cbqn/BeAxaO13bEx74FWRGdrBeWcfVt9T/et2JqBpSn9V0J6POBn3OT61oSLrt7NhrGPsJkkpVJctKsE1dYDAwGn3+bvjRVy4gFVsecaT3BQA93kKncxjKW7XwEWV6Hh7in9cnu3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JTTnNvVL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753387933; x=1784923933;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pUAqg/uKxaVXamSlKodRXwwjXO4TngzCIQoeMPyrq8A=;
  b=JTTnNvVLQf1+JFE1l6JHECjWTmSLW2deSTL4WDb80y8RAuFQQIWm6Xdh
   lziyAGc6BqO/Q35S23XbJhE3RpKPk+/9QEZMl4kVwg7Fc7JsP8ejk/PbZ
   0k01a/pQei9zPjw5+uNcsRV0vndtKh6jklKaj05ZMDrdG8gXvN03Cukdl
   THi8MtnFhfswXu00jsHGuxECk+NeNthb7oKW4hPEgkAjQ7JQaKixa9v9P
   iC5JuQ5XzvTttP0JO2W8E8C8vwubyAHfD5mHpFtqIy6AlXL7Xk6q/RX5I
   ihia1f9qikn4zzNrSYbAH5KCeMR4UE5PpXHluIlVAaGSUF9kQR58O7sah
   Q==;
X-CSE-ConnectionGUID: dPxjunYJTo2XkJR5vJWM1w==
X-CSE-MsgGUID: tl/UWdpRQMK7w5K+pyCskw==
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="44383323"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jul 2025 13:12:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 24 Jul 2025 13:11:37 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 24 Jul 2025 13:11:35 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <o.rempel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2 4/4] net: phy: micrel: Add support for lan8842
Date: Thu, 24 Jul 2025 22:08:26 +0200
Message-ID: <20250724200826.2662658-5-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
References: <20250724200826.2662658-1-horatiu.vultur@microchip.com>
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
 drivers/net/phy/micrel.c   | 200 +++++++++++++++++++++++++++++++++++++
 include/linux/micrel_phy.h |   1 +
 2 files changed, 201 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index d20f028106b7d..da39d9a1b251a 100644
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
@@ -5718,6 +5729,181 @@ static int ksz9131_resume(struct phy_device *phydev)
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
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_2,
+			      LAN8842_SELF_TEST,
+			      LAN8842_SELF_TEST_RX_CNT_ENA |
+			      LAN8842_SELF_TEST_TX_CNT_ENA);
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
+	ret = lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_4,
+				     LAN8814_QSGMII_SOFT_RESET,
+				     LAN8814_QSGMII_SOFT_RESET_BIT,
+				     LAN8814_QSGMII_SOFT_RESET_BIT);
+	if (ret < 0)
+		return ret;
+
+	/* Disable ANEG with QSGMII PCS Host side
+	 * It has the same address as lan8814
+	 */
+	ret = lanphy_modify_page_reg(phydev, LAN_EXT_PAGE_5,
+				     LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
+				     LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA,
+				     0);
+	if (ret < 0)
+		return ret;
+
+	/* Disable also the SGMII_AUTO_ANEG_ENA, this will determine what is the
+	 * PHY autoneg with the other end and then will update the host side
+	 */
+	ret = lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+				    LAN8842_SGMII_AUTO_ANEG_ENA, 0);
+	if (ret < 0)
+		return ret;
+
+	/* To allow the PHY to control the LEDs the GPIOs of the PHY should have
+	 * a function mode and not the GPIO. Apparently by default the value is
+	 * GPIO and not function even though the datasheet it says that it is
+	 * function. Therefore set this value.
+	 */
+	return lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
+				     LAN8814_GPIO_EN2, 0);
+}
+
+#define LAN8842_INTR_CTRL_REG			52 /* 0x34 */
+
+static int lan8842_config_intr(struct phy_device *phydev)
+{
+	int err;
+
+	lanphy_write_page_reg(phydev, LAN_EXT_PAGE_4,
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
+		val = lanphy_read_page_reg(phydev, LAN_EXT_PAGE_2, regs[j]);
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
+	stats->tx_errors = priv->phy_stats.rx_errors;
+}
+
 static struct phy_driver ksphy_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_KS8737),
@@ -5937,6 +6123,19 @@ static struct phy_driver ksphy_driver[] = {
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
@@ -6032,6 +6231,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
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


