Return-Path: <netdev+bounces-208497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3852FB0BD8B
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A542189D6D8
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 07:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D627F006;
	Mon, 21 Jul 2025 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JyKx/faa"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A8C3594A;
	Mon, 21 Jul 2025 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753082319; cv=none; b=HDHANwjCCAe1ZRR3Bv7X2BR7QnnZEm/cKEWmslIHfoNaLhRgJC8k115RpAvCfmxk/90Bs+lsibv24OudHhETxH45IX0llndofeX/gjW1eA0awqnOsyFVegEf6MBEgOaRpcSZyc0z88AIX1hcSXnN3r0Oa5/1BLnNiCTs3PHUzzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753082319; c=relaxed/simple;
	bh=M9Xmkv2qVHqWPjHsSh0YdKsAJ8wRcIdOQU7GZVK0pkw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JuUOH0AKWk9KbfHZaCcwiIgjFMsbczwE0+IYLrhN5e23wnBujfbo9EflBmwm/l6jm4e5wEYrDMeHHdn37QMeyKiEJPKmNF19LicqcNP6OqhTgcjSHvDBcd0yuX7ZeV4adKdhm6zWiXwqQyBYnFsDMstQ9YfTkiGJgkZMKOpYvVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=JyKx/faa; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1753082316; x=1784618316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M9Xmkv2qVHqWPjHsSh0YdKsAJ8wRcIdOQU7GZVK0pkw=;
  b=JyKx/faaPt/o3znDzprPgN7yHR9ZtE2w2hHak6kOCJfQmFJ3ByYphnhG
   SJQzpgn5IMopT4h9QQhzRKnGP38Islwkligj9SACQ8mnZG+C4xaf+zDrp
   5LQlN6VurSiIwUJEfpKv0qjJ8k2kQO8HPcRLC65MEX31bm+pi0HLsf9sk
   OgSs98bjaiqZ4KLykN8RoBpOhgwTdO4R6TndYJKauoQL3CPmfkBuZSu6U
   zsqnI/dT9+DJjdQTaSRjycJI8jfwSA+SHKikY8UBDTWxe9Dm+DL9kAhR3
   wiN2Xo8TBz+KW2kHGKzsP/8TEUzglpix4TyZ/Pk4/rXS6AIm79RrgaNIl
   w==;
X-CSE-ConnectionGUID: jUV/n59CS0i32eQvvYcxeQ==
X-CSE-MsgGUID: S2PLcvX7RdyKKoNKr+BWbQ==
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="43694035"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 00:18:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 21 Jul 2025 00:17:57 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 21 Jul 2025 00:17:55 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <o.rempel@pengutronix.de>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy: micrel: Add support for lan8842
Date: Mon, 21 Jul 2025 09:14:05 +0200
Message-ID: <20250721071405.1859491-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
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
 drivers/net/phy/micrel.c   | 199 +++++++++++++++++++++++++++++++++++++
 include/linux/micrel_phy.h |   1 +
 2 files changed, 200 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index f678c1bdacdf0..c5887a23f9941 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -107,6 +107,7 @@
 #define LAN8814_INTC				0x18
 #define LAN8814_INTS				0x1B
 
+#define LAN8814_INT_FLF				BIT(15)
 #define LAN8814_INT_LINK_DOWN			BIT(2)
 #define LAN8814_INT_LINK_UP			BIT(0)
 #define LAN8814_INT_LINK			(LAN8814_INT_LINK_UP |\
@@ -448,6 +449,20 @@ struct kszphy_priv {
 	struct kszphy_phy_stats phy_stats;
 };
 
+struct lan8842_hw_stat {
+	const char *string;
+	u8 page;
+	u8 regs_count;
+	u8 regs[3];
+};
+
+static struct lan8842_hw_stat lan8842_hw_stats[] = {
+	{ "phy_rx_correct_count", 2, 3, {88, 61, 60}},
+	{ "phy_rx_crc_count", 2, 2, {63, 62}},
+	{ "phy_tx_correct_count", 2, 3, {89, 85, 84}},
+	{ "phy_tx_crc_count", 2, 2, {87, 86}},
+};
+
 static const struct kszphy_type lan8814_type = {
 	.led_mode_reg		= ~LAN8814_LED_CTRL_1,
 	.cable_diag_reg		= LAN8814_CABLE_DIAG,
@@ -5641,6 +5656,174 @@ static int ksz9131_resume(struct phy_device *phydev)
 	return kszphy_resume(phydev);
 }
 
+#define LAN8842_SELF_TEST			14 /* 0x0e */
+#define LAN8842_SELF_TEST_RX_CNT_ENA		BIT(8)
+#define LAN8842_SELF_TEST_TX_CNT_ENA		BIT(4)
+
+static int lan8842_probe(struct phy_device *phydev)
+{
+	int ret;
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
+	lanphy_write_page_reg(phydev, 2, LAN8842_SELF_TEST,
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
+	int val;
+	int ret;
+
+	/* Reset the PHY */
+	val = lanphy_read_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET);
+	if (val < 0)
+		return val;
+	val |= LAN8814_QSGMII_SOFT_RESET_BIT;
+	lanphy_write_page_reg(phydev, 4, LAN8814_QSGMII_SOFT_RESET, val);
+
+	/* Disable ANEG with QSGMII PCS Host side
+	 * It has the same address as lan8814
+	 */
+	val = lanphy_read_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG);
+	if (val < 0)
+		return val;
+	val &= ~LAN8814_QSGMII_PCS1G_ANEG_CONFIG_ANEG_ENA;
+	ret = lanphy_write_page_reg(phydev, 5, LAN8814_QSGMII_PCS1G_ANEG_CONFIG,
+				    val);
+	if (ret < 0)
+		return ret;
+
+	/* Disable also the SGMII_AUTO_ANEG_ENA, this will determine what is the
+	 * PHY autoneg with the other end and then will update the host side
+	 */
+	lanphy_write_page_reg(phydev, 4, LAN8842_SGMII_AUTO_ANEG_ENA, 0);
+
+	/* To allow the PHY to control the LEDs the GPIOs of the PHY should have
+	 * a function mode and not the GPIO. Apparently by default the value is
+	 * GPIO and not function even though the datasheet it says that it is
+	 * function. Therefore set this value.
+	 */
+	lanphy_write_page_reg(phydev, 4, LAN8814_GPIO_EN2, 0);
+
+	/* Enable the Fast link failure, at the top level, at the bottom level
+	 * it would be set/cleared inside lan8842_config_intr
+	 */
+	val = lanphy_read_page_reg(phydev, 0, LAN8842_FLF);
+	if (val < 0)
+		return val;
+	val |= LAN8842_FLF_ENA | LAN8842_FLF_ENA_LINK_DOWN;
+	lanphy_write_page_reg(phydev, 0, LAN8842_FLF, val);
+
+	return 0;
+}
+
+#define LAN8842_INTR_CTRL_REG			52 /* 0x34 */
+
+static int lan8842_config_intr(struct phy_device *phydev)
+{
+	int err;
+
+	lanphy_write_page_reg(phydev, 4, LAN8842_INTR_CTRL_REG,
+			      LAN8814_INTR_CTRL_REG_INTR_ENABLE);
+
+	/* enable / disable interrupts */
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		err = lan8814_ack_interrupt(phydev);
+		if (err)
+			return err;
+
+		err = phy_write(phydev, LAN8814_INTC,
+				LAN8814_INT_LINK | LAN8814_INT_FLF);
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
+	if (irq_status & (LAN8814_INT_LINK | LAN8814_INT_FLF)) {
+		phy_trigger_machine(phydev);
+		ret = IRQ_HANDLED;
+	}
+
+	return ret;
+}
+
+static int lan8842_get_sset_count(struct phy_device *phydev)
+{
+	return ARRAY_SIZE(lan8842_hw_stats);
+}
+
+static void lan8842_get_strings(struct phy_device *phydev, u8 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lan8842_hw_stats); i++) {
+		strscpy(data + i * ETH_GSTRING_LEN,
+			lan8842_hw_stats[i].string, ETH_GSTRING_LEN);
+	}
+}
+
+static u64 lan8842_get_stat(struct phy_device *phydev, int i)
+{
+	struct lan8842_hw_stat stat = lan8842_hw_stats[i];
+	int val;
+	u64 ret = 0;
+
+	for (int j = 0; j < stat.regs_count; ++j) {
+		val = lanphy_read_page_reg(phydev,
+					   stat.page,
+					   stat.regs[j]);
+		if (val < 0)
+			return U64_MAX;
+
+		ret <<= 16;
+		ret += val;
+	}
+
+	return ret;
+}
+
+static void lan8842_get_stats(struct phy_device *phydev,
+			      struct ethtool_stats *stats, u64 *data)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(lan8842_hw_stats); i++)
+		data[i] = lan8842_get_stat(phydev, i);
+}
+
 static struct phy_driver ksphy_driver[] = {
 {
 	.phy_id		= PHY_ID_KS8737,
@@ -5869,6 +6052,21 @@ static struct phy_driver ksphy_driver[] = {
 	.resume		= lan8841_resume,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
+}, {
+	.phy_id		= PHY_ID_LAN8842,
+	.phy_id_mask	= MICREL_PHY_ID_MASK,
+	.name		= "Microchip LAN8842 Gigabit PHY",
+	.flags		= PHY_POLL_CABLE_TEST,
+	.driver_data	= &lan8814_type,
+	.probe		= lan8842_probe,
+	.config_init	= lan8842_config_init,
+	.config_intr	= lan8842_config_intr,
+	.handle_interrupt = lan8842_handle_interrupt,
+	.get_sset_count	= lan8842_get_sset_count,
+	.get_strings	= lan8842_get_strings,
+	.get_stats	= lan8842_get_stats,
+	.cable_test_start	= lan8814_cable_test_start,
+	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
 	.phy_id		= PHY_ID_KSZ9131,
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
@@ -5967,6 +6165,7 @@ static const struct mdio_device_id __maybe_unused micrel_tbl[] = {
 	{ PHY_ID_LAN8814, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8804, MICREL_PHY_ID_MASK },
 	{ PHY_ID_LAN8841, MICREL_PHY_ID_MASK },
+	{ PHY_ID_LAN8842, MICREL_PHY_ID_MASK },
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


