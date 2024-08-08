Return-Path: <netdev+bounces-116819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8F294BCD3
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C32289871
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0C718B495;
	Thu,  8 Aug 2024 12:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0mc3O91G"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995B1156220;
	Thu,  8 Aug 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723118523; cv=none; b=ol1rSKD0MKCp+xqLCgZLRhunOTR/oiJugsPh5ft729IS4428eu47dvrExg/BmUvrbjTjGOOqMq5YnP/TI7AYfL+rtqOXtX+ACeV+dnUhS2/DmmunAiZzGskz+0MBQLsX1CgNBQ5AFl9GZ7qaAnvy7BL+cJ5rJog2LAZ84qCK8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723118523; c=relaxed/simple;
	bh=eK6BCimUxGSjBUAcuOV56n+pMU89/rpF5f4QEreOJAw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HosytF+Fcje2fvtDkLpnKxCEAC4IiBRsmzy1FoRGXuQ7k02W+LBC1STPF3INDs2T3K9aJkRYVaU9Ql2X8VnZw8qN5Sa5rCjZg89YAZKWCSQWpDSsPTKIg729Wz6q+zcR+oxTwNNUPyW+cvrB55wB4k63I+QuadkADye58uYkHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0mc3O91G; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723118520; x=1754654520;
  h=from:to:subject:date:message-id:mime-version;
  bh=eK6BCimUxGSjBUAcuOV56n+pMU89/rpF5f4QEreOJAw=;
  b=0mc3O91GLeIYJ6xfj/miBjlrwgmYvBw6BAaStv4jwtmCaOZisTcf9Pj3
   RQtDWjTjkSQT5jptFncTfxfdNwiW+wSKuP1Qq5DO6KfAihsix8P9gueCI
   Cz8eQnFuZUxQU7RHeUfLKImvKzf7x0VmtMRInM/icoP4VmsH4BN7VeRei
   T/wWeEW1+Ih/0PnFwG0+UzecB06OZGxeqXcDwmu1nYifX9PM8wPVoyx7n
   ZpGuR3cU9MjMnG37z4SvLsljSBxAh/eUxxFEbSkkGg1TByc1wCQchLMwa
   vx+dci53qpB3qG3idYViqm4vgdgRM6kXkHWn8nHLELa+aLpTNNxboOVIE
   g==;
X-CSE-ConnectionGUID: u6StLbFVQVqs04c8KP+nTQ==
X-CSE-MsgGUID: vNey0uziQL6PdUZGJJIpNg==
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="197672361"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Aug 2024 05:01:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Aug 2024 05:01:28 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 8 Aug 2024 05:01:24 -0700
From: Divya Koppera <Divya.Koppera@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] net: phy: microchip_t1: Adds support for LAN887x phy
Date: Thu, 8 Aug 2024 20:29:16 +0530
Message-ID: <20240808145916.26006-1-Divya.Koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: divya.koppera <divya.koppera@microchip.com>

The LAN887x is a Single-Port Ethernet Physical Layer Transceiver compliant
with the IEEE 802.3bw (100BASE-T1) and IEEE 802.3bp (1000BASE-T1)
specifications. The device provides 100/1000 Mbit/s transmit and receive
capability over a single Unshielded Twisted Pair (UTP) cable. It supports
communication with an Ethernet MAC via standard RGMII/SGMII interfaces.

LAN887x supports following features,
- Events/Interrupts
- LED/GPIO Operation
- IEEE 1588 (PTP)
- SQI
- Sleep and Wakeup (TC10)
- Cable Diagnostics

First patch only supports 100Mbps and 1000Mbps force-mode.

Signed-off-by: divya.koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 602 ++++++++++++++++++++++++++++++++-
 1 file changed, 601 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a35528497a57..01f131ae3dc2 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -12,6 +12,7 @@
 
 #define PHY_ID_LAN87XX				0x0007c150
 #define PHY_ID_LAN937X				0x0007c180
+#define PHY_ID_LAN887X				0x0007c1f0
 
 /* External Register Control Register */
 #define LAN87XX_EXT_REG_CTL                     (0x14)
@@ -94,8 +95,101 @@
 /* SQI defines */
 #define LAN87XX_MAX_SQI			0x07
 
+/* Chiptop registers */
+#define LAN887X_PMA_EXT_ABILITY_2		0x12
+#define LAN887X_PMA_EXT_ABILITY_2_1000T1	BIT(1)
+#define LAN887X_PMA_EXT_ABILITY_2_100T1		BIT(0)
+
+/* DSP 100M registers */
+#define LAN887x_CDR_CONFIG1_100			0x0405
+#define LAN887x_LOCK1_EQLSR_CONFIG_100		0x0411
+#define LAN887x_SLV_HD_MUFAC_CONFIG_100		0x0417
+#define LAN887x_PLOCK_MUFAC_CONFIG_100		0x041c
+#define LAN887x_PROT_DISABLE_100		0x0425
+#define LAN887x_KF_LOOP_SAT_CONFIG_100		0x0454
+
+/* DSP 1000M registers */
+#define LAN887X_LOCK1_EQLSR_CONFIG		0x0811
+#define LAN887X_LOCK3_EQLSR_CONFIG		0x0813
+#define LAN887X_PROT_DISABLE			0x0825
+#define LAN887X_FFE_GAIN6			0x0843
+#define LAN887X_FFE_GAIN7			0x0844
+#define LAN887X_FFE_GAIN8			0x0845
+#define LAN887X_FFE_GAIN9			0x0846
+#define LAN887X_ECHO_DELAY_CONFIG		0x08ec
+#define LAN887X_FFE_MAX_CONFIG			0x08ee
+
+/* PCS 1000M registers */
+#define LAN887X_SCR_CONFIG_3			0x8043
+#define LAN887X_INFO_FLD_CONFIG_5		0x8048
+
+/* T1 afe registers */
+#define LAN887X_ZQCAL_CONTROL_1			0x8080
+#define LAN887X_AFE_PORT_TESTBUS_CTRL2		0x8089
+#define LAN887X_AFE_PORT_TESTBUS_CTRL4		0x808b
+#define LAN887X_AFE_PORT_TESTBUS_CTRL6		0x808d
+#define LAN887X_TX_AMPLT_1000T1_REG		0x80b0
+#define LAN887X_INIT_COEFF_DFE1_100		0x0422
+
+/* PMA registers */
+#define LAN887X_DSP_PMA_CONTROL			0x810e
+#define LAN887X_DSP_PMA_CONTROL_LNK_SYNC	BIT(4)
+
+/* PCS 100M registers */
+#define LAN887X_IDLE_ERR_TIMER_WIN		0x8204
+#define LAN887X_IDLE_ERR_CNT_THRESH		0x8213
+
+/* Misc registers */
+#define LAN887X_REG_REG26			0x001a
+#define LAN887X_REG_REG26_HW_INIT_SEQ_EN	BIT(8)
+
+/* Mis registers */
+#define LAN887X_MIS_CFG_REG0			0xa00
+#define LAN887X_MIS_CFG_REG0_RCLKOUT_DIS	BIT(5)
+#define LAN887X_MIS_CFG_REG0_MAC_MODE_SEL	GENMASK(1, 0)
+
+#define LAN887X_MAC_MODE_RGMII			0x01
+#define LAN887X_MAC_MODE_SGMII			0x03
+
+#define LAN887X_MIS_DLL_CFG_REG0		0xa01
+#define LAN887X_MIS_DLL_CFG_REG1		0xa02
+
+#define LAN887X_MIS_DLL_DELAY_EN		BIT(15)
+#define LAN887X_MIS_DLL_EN			BIT(0)
+#define LAN887X_MIS_DLL_CONF	(LAN887X_MIS_DLL_DELAY_EN |\
+				 LAN887X_MIS_DLL_EN)
+
+#define LAN887X_MIS_CFG_REG2			0xa03
+#define LAN887X_MIS_CFG_REG2_FE_LPBK_EN		BIT(2)
+
+#define LAN887X_MIS_PKT_STAT_REG0		0xa06
+#define LAN887X_MIS_PKT_STAT_REG1		0xa07
+#define LAN887X_MIS_PKT_STAT_REG3		0xa09
+#define LAN887X_MIS_PKT_STAT_REG4		0xa0a
+#define LAN887X_MIS_PKT_STAT_REG5		0xa0b
+#define LAN887X_MIS_PKT_STAT_REG6		0xa0c
+
+/* Chiptop common registers */
+#define LAN887X_COMMON_LED3_LED2		0xc05
+#define LAN887X_COMMON_LED2_MODE_SEL_MASK	GENMASK(4, 0)
+#define LAN887X_LED_LINK_ACT_ANY_SPEED		0x0
+
+/* MX chip top registers */
+#define LAN887X_CHIP_SOFT_RST			0xf03f
+#define LAN887X_CHIP_SOFT_RST_RESET		BIT(0)
+
+#define LAN887X_SGMII_CTL			0xf01a
+#define LAN887X_SGMII_CTL_SGMII_MUX_EN		BIT(0)
+
+#define LAN887X_SGMII_PCS_CFG			0xf034
+#define LAN887X_SGMII_PCS_CFG_PCS_ENA		BIT(9)
+
+#define LAN887X_EFUSE_READ_DAT9			0xf209
+#define LAN887X_EFUSE_READ_DAT9_SGMII_DIS	BIT(9)
+#define LAN887X_EFUSE_READ_DAT9_MAC_MODE	GENMASK(1, 0)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
-#define DRIVER_DESC	"Microchip LAN87XX/LAN937x T1 PHY driver"
+#define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
 struct access_ereg_val {
 	u8  mode;
@@ -105,6 +199,32 @@ struct access_ereg_val {
 	u16 mask;
 };
 
+struct lan887x_hw_stat {
+	const char *string;
+	u8 mmd;
+	u16 reg;
+	u8 bits;
+};
+
+static const struct lan887x_hw_stat lan887x_hw_stats[] = {
+	{ "TX Good Count",                      MDIO_MMD_VEND1, LAN887X_MIS_PKT_STAT_REG0, 14},
+	{ "RX Good Count",                      MDIO_MMD_VEND1, LAN887X_MIS_PKT_STAT_REG1, 14},
+	{ "RX ERR Count detected by PCS",       MDIO_MMD_VEND1, LAN887X_MIS_PKT_STAT_REG3, 16},
+	{ "TX CRC ERR Count",                   MDIO_MMD_VEND1, LAN887X_MIS_PKT_STAT_REG4, 8},
+	{ "RX CRC ERR Count",                   MDIO_MMD_VEND1, LAN887X_MIS_PKT_STAT_REG5, 8},
+	{ "RX ERR Count for SGMII MII2GMII",    MDIO_MMD_VEND1, LAN887X_MIS_PKT_STAT_REG6, 8},
+};
+
+struct lan887x_regwr_map {
+	u8  mmd;
+	u16 reg;
+	u16 val;
+};
+
+struct lan887x_priv {
+	u64 stats[ARRAY_SIZE(lan887x_hw_stats)];
+};
+
 static int lan937x_dsp_workaround(struct phy_device *phydev, u16 ereg, u8 bank)
 {
 	u8 prev_bank;
@@ -860,6 +980,471 @@ static int lan87xx_get_sqi_max(struct phy_device *phydev)
 	return LAN87XX_MAX_SQI;
 }
 
+static int lan887x_rgmii_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* SGMII mux disable */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 LAN887X_SGMII_CTL,
+				 LAN887X_SGMII_CTL_SGMII_MUX_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Select MAC_MODE as RGMII */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, LAN887X_MIS_CFG_REG0,
+			     LAN887X_MIS_CFG_REG0_MAC_MODE_SEL,
+			     LAN887X_MAC_MODE_RGMII);
+	if (ret < 0)
+		return ret;
+
+	/* Disable PCS */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 LAN887X_SGMII_PCS_CFG,
+				 LAN887X_SGMII_PCS_CFG_PCS_ENA);
+	if (ret < 0)
+		return ret;
+
+	/* LAN887x Errata: RGMII rx clock active in SGMII mode
+	 * Disabled it for SGMII mode
+	 * Re-enabling it for RGMII mode
+	 */
+	return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				  LAN887X_MIS_CFG_REG0,
+				  LAN887X_MIS_CFG_REG0_RCLKOUT_DIS);
+}
+
+static int lan887x_sgmii_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* SGMII mux enable */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+			       LAN887X_SGMII_CTL,
+			       LAN887X_SGMII_CTL_SGMII_MUX_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Select MAC_MODE as SGMII */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, LAN887X_MIS_CFG_REG0,
+			     LAN887X_MIS_CFG_REG0_MAC_MODE_SEL,
+			     LAN887X_MAC_MODE_SGMII);
+	if (ret < 0)
+		return ret;
+
+	/* LAN887x Errata: RGMII rx clock active in SGMII mode.
+	 * So disabling it for SGMII mode
+	 */
+	ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, LAN887X_MIS_CFG_REG0,
+			       LAN887X_MIS_CFG_REG0_RCLKOUT_DIS);
+	if (ret < 0)
+		return ret;
+
+	/* Enable PCS */
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, LAN887X_SGMII_PCS_CFG,
+				LAN887X_SGMII_PCS_CFG_PCS_ENA);
+}
+
+static int lan887x_config_rgmii_en(struct phy_device *phydev)
+{
+	int txc;
+	int rxc;
+	int ret;
+
+	ret = lan887x_rgmii_init(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Control bit to enable/disable TX DLL delay line in signal path */
+	txc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_MIS_DLL_CFG_REG0);
+	if (txc < 0)
+		return txc;
+
+	/* Control bit to enable/disable RX DLL delay line in signal path */
+	rxc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_MIS_DLL_CFG_REG1);
+	if (rxc < 0)
+		return rxc;
+
+	/* Configures the phy to enable RX/TX delay
+	 * RGMII        - TX & RX delays are either added by MAC or not needed,
+	 *                phy should not add
+	 * RGMII_ID     - Configures phy to enable TX & RX delays, MAC shouldn't add
+	 * RGMII_RX_ID  - Configures the PHY to enable the RX delay.
+	 *                The MAC shouldn't add the RX delay
+	 * RGMII_TX_ID  - Configures the PHY to enable the TX delay.
+	 *                The MAC shouldn't add the TX delay in this case
+	 */
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+		txc &= ~LAN887X_MIS_DLL_CONF;
+		rxc &= ~LAN887X_MIS_DLL_CONF;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_ID:
+		txc |= LAN887X_MIS_DLL_CONF;
+		rxc |= LAN887X_MIS_DLL_CONF;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+		txc &= ~LAN887X_MIS_DLL_CONF;
+		rxc |= LAN887X_MIS_DLL_CONF;
+		break;
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		txc |= LAN887X_MIS_DLL_CONF;
+		rxc &= ~LAN887X_MIS_DLL_CONF;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid phydev interface %d\n", phydev->interface);
+		return 0;
+	}
+
+	/* Configures the PHY to enable/disable RX delay in signal path */
+	ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1, LAN887X_MIS_DLL_CFG_REG1,
+			     LAN887X_MIS_DLL_CONF, rxc);
+	if (ret < 0)
+		return ret;
+
+	/* Configures the PHY to enable/disable the TX delay in signal path */
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, LAN887X_MIS_DLL_CFG_REG0,
+			      LAN887X_MIS_DLL_CONF, txc);
+}
+
+static int lan887x_config_phy_interface(struct phy_device *phydev)
+{
+	int interface_mode;
+	int sgmii_dis;
+	int ret;
+
+	/* Read sku efuse data for interfaces supported by sku */
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_EFUSE_READ_DAT9);
+	if (ret < 0)
+		return ret;
+
+	/* If interface_mode is 1 then efuse sets RGMII operations.
+	 * If interface mode is 3 then efuse sets SGMII operations.
+	 */
+	interface_mode = ret & LAN887X_EFUSE_READ_DAT9_MAC_MODE;
+	/* SGMII disable is set for RGMII operations */
+	sgmii_dis = ret & LAN887X_EFUSE_READ_DAT9_SGMII_DIS;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		/* Reject RGMII settings for SGMII only sku */
+		ret = -EOPNOTSUPP;
+
+		if (!((interface_mode & LAN887X_MAC_MODE_SGMII) ==
+		    LAN887X_MAC_MODE_SGMII))
+			ret = lan887x_config_rgmii_en(phydev);
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		/* Reject SGMII setting for RGMII only sku */
+		ret = -EOPNOTSUPP;
+
+		if (!sgmii_dis)
+			ret = lan887x_sgmii_init(phydev);
+		break;
+	default:
+		/* Reject setting for unsupported interfaces */
+		ret = -EOPNOTSUPP;
+	}
+
+	return ret;
+}
+
+static int lan887x_get_features(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = genphy_c45_pma_read_abilities(phydev);
+	if (ret < 0)
+		return ret;
+
+	/* Enable twisted pair */
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT, phydev->supported);
+
+	/* First patch only supports 100Mbps and 1000Mbps force-mode.
+	 * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added later.
+	 */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, phydev->supported);
+
+	return 0;
+}
+
+static int lan887x_phy_init(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Clear loopback */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 LAN887X_MIS_CFG_REG2,
+				 LAN887X_MIS_CFG_REG2_FE_LPBK_EN);
+	if (ret < 0)
+		return ret;
+
+	if (!IS_ENABLED(CONFIG_OF_MDIO)) {
+		/* Configure default behavior of led to link and activity for any
+		 * speed
+		 */
+		ret = phy_modify_mmd(phydev, MDIO_MMD_VEND1,
+				     LAN887X_COMMON_LED3_LED2,
+				     LAN887X_COMMON_LED2_MODE_SEL_MASK,
+				     LAN887X_LED_LINK_ACT_ANY_SPEED);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* PHY interface setup */
+	return lan887x_config_phy_interface(phydev);
+}
+
+static int lan887x_config_init(struct phy_device *phydev)
+{
+	/* Disable pause frames */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
+	/* Disable asym pause */
+	linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);
+
+	return lan887x_phy_init(phydev);
+}
+
+static int lan887x_phy_config(struct phy_device *phydev,
+			      const struct lan887x_regwr_map *reg_map, int cnt)
+{
+	int ret;
+
+	for (int i = 0; i < cnt; i++) {
+		ret = phy_write_mmd(phydev, reg_map[i].mmd,
+				    reg_map[i].reg, reg_map[i].val);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int lan887x_phy_setup(struct phy_device *phydev)
+{
+	static const struct lan887x_regwr_map phy_cfg[] = {
+		/* PORT_AFE writes */
+		{MDIO_MMD_PMAPMD, LAN887X_ZQCAL_CONTROL_1, 0x4008},
+		{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL2, 0x0000},
+		{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL6, 0x0040},
+		/* 100T1_PCS_VENDOR writes */
+		{MDIO_MMD_PCS,	  LAN887X_IDLE_ERR_CNT_THRESH, 0x0008},
+		{MDIO_MMD_PCS,	  LAN887X_IDLE_ERR_TIMER_WIN, 0x800d},
+		/* 100T1 DSP writes */
+		{MDIO_MMD_VEND1,  LAN887x_CDR_CONFIG1_100, 0x0ab1},
+		{MDIO_MMD_VEND1,  LAN887x_LOCK1_EQLSR_CONFIG_100, 0x5274},
+		{MDIO_MMD_VEND1,  LAN887x_SLV_HD_MUFAC_CONFIG_100, 0x0d74},
+		{MDIO_MMD_VEND1,  LAN887x_PLOCK_MUFAC_CONFIG_100, 0x0aea},
+		{MDIO_MMD_VEND1,  LAN887x_PROT_DISABLE_100, 0x0360},
+		{MDIO_MMD_VEND1,  LAN887x_KF_LOOP_SAT_CONFIG_100, 0x0c30},
+		/* 1000T1 DSP writes */
+		{MDIO_MMD_VEND1,  LAN887X_LOCK1_EQLSR_CONFIG, 0x2a78},
+		{MDIO_MMD_VEND1,  LAN887X_LOCK3_EQLSR_CONFIG, 0x1368},
+		{MDIO_MMD_VEND1,  LAN887X_PROT_DISABLE, 0x1354},
+		{MDIO_MMD_VEND1,  LAN887X_FFE_GAIN6, 0x3C84},
+		{MDIO_MMD_VEND1,  LAN887X_FFE_GAIN7, 0x3ca5},
+		{MDIO_MMD_VEND1,  LAN887X_FFE_GAIN8, 0x3ca5},
+		{MDIO_MMD_VEND1,  LAN887X_FFE_GAIN9, 0x3ca5},
+		{MDIO_MMD_VEND1,  LAN887X_ECHO_DELAY_CONFIG, 0x0024},
+		{MDIO_MMD_VEND1,  LAN887X_FFE_MAX_CONFIG, 0x227f},
+		/* 1000T1 PCS writes */
+		{MDIO_MMD_PCS,    LAN887X_SCR_CONFIG_3, 0x1e00},
+		{MDIO_MMD_PCS,    LAN887X_INFO_FLD_CONFIG_5, 0x0fa1},
+	};
+
+	return lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
+}
+
+static int lan887x_100M_setup(struct phy_device *phydev)
+{
+	int ret;
+
+	/* (Re)configure the speed/mode dependent T1 settings */
+	if (phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_FORCE ||
+	    phydev->master_slave_set == MASTER_SLAVE_CFG_MASTER_PREFERRED){
+		static const struct lan887x_regwr_map phy_cfg[] = {
+			{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x00b8},
+			{MDIO_MMD_PMAPMD, LAN887X_TX_AMPLT_1000T1_REG, 0x0038},
+			{MDIO_MMD_VEND1,  LAN887X_INIT_COEFF_DFE1_100, 0x000f},
+		};
+
+		ret = lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
+	} else {
+		static const struct lan887x_regwr_map phy_cfg[] = {
+			{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x0038},
+			{MDIO_MMD_VEND1, LAN887X_INIT_COEFF_DFE1_100, 0x0014},
+		};
+
+		ret = lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
+	}
+	if (ret < 0)
+		return ret;
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, LAN887X_REG_REG26,
+				LAN887X_REG_REG26_HW_INIT_SEQ_EN);
+}
+
+static int lan887x_1000M_setup(struct phy_device *phydev)
+{
+	static const struct lan887x_regwr_map phy_cfg[] = {
+		{MDIO_MMD_PMAPMD, LAN887X_TX_AMPLT_1000T1_REG, 0x003f},
+		{MDIO_MMD_PMAPMD, LAN887X_AFE_PORT_TESTBUS_CTRL4, 0x00b8},
+	};
+	int ret;
+
+	/* (Re)configure the speed/mode dependent T1 settings */
+	ret = lan887x_phy_config(phydev, phy_cfg, ARRAY_SIZE(phy_cfg));
+	if (ret < 0)
+		return ret;
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_PMAPMD, LAN887X_DSP_PMA_CONTROL,
+				LAN887X_DSP_PMA_CONTROL_LNK_SYNC);
+}
+
+static int lan887x_link_setup(struct phy_device *phydev)
+{
+	int ret = -EINVAL;
+
+	if (phydev->speed == SPEED_1000)
+		ret = lan887x_1000M_setup(phydev);
+	else if (phydev->speed == SPEED_100)
+		ret = lan887x_100M_setup(phydev);
+
+	return ret;
+}
+
+/* LAN887x Errata: speed configuration changes require soft reset
+ * and chip soft reset
+ */
+static int lan887x_phy_reset(struct phy_device *phydev)
+{
+	int ret, val;
+
+	/* Clear 1000M link sync */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, LAN887X_DSP_PMA_CONTROL,
+				 LAN887X_DSP_PMA_CONTROL_LNK_SYNC);
+	if (ret < 0)
+		return ret;
+
+	/* Clear 100M link sync */
+	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, LAN887X_REG_REG26,
+				 LAN887X_REG_REG26_HW_INIT_SEQ_EN);
+	if (ret < 0)
+		return ret;
+
+	/* Chiptop soft-reset to allow the speed/mode change */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_CHIP_SOFT_RST,
+			    LAN887X_CHIP_SOFT_RST_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* CL22 soft-reset to let the link re-train */
+	ret = phy_modify(phydev, MII_BMCR, BMCR_RESET, BMCR_RESET);
+	if (ret < 0)
+		return ret;
+
+	/* Wait for reset complete or timeout if > 10ms */
+	return phy_read_poll_timeout(phydev, MII_BMCR, val, !(val & BMCR_RESET),
+				    5000, 10000, true);
+}
+
+static int lan887x_phy_reconfig(struct phy_device *phydev)
+{
+	int ret;
+
+	linkmode_zero(phydev->advertising);
+
+	ret = genphy_c45_pma_setup_forced(phydev);
+	if (ret < 0)
+		return ret;
+
+	return lan887x_link_setup(phydev);
+}
+
+static int lan887x_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+
+	/* First patch only supports 100Mbps and 1000Mbps force-mode.
+	 * T1 Auto-Negotiation (Clause 98 of IEEE 802.3) will be added later.
+	 */
+	if (phydev->autoneg != AUTONEG_DISABLE) {
+		/* PHY state is inconsistent due to ANEG Enable set
+		 * so we need to assign ANEG Disable for consistent behavior
+		 */
+		phydev->autoneg = AUTONEG_DISABLE;
+		return 0;
+	}
+
+	/* LAN887x Errata: speed configuration changes require soft reset
+	 * and chip soft reset
+	 */
+	ret = lan887x_phy_reset(phydev);
+	if (ret < 0)
+		return ret;
+
+	return lan887x_phy_reconfig(phydev);
+}
+
+static int lan887x_probe(struct phy_device *phydev)
+{
+	struct lan887x_priv *priv;
+
+	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	phydev->priv = priv;
+
+	return lan887x_phy_setup(phydev);
+}
+
+static u64 lan887x_get_stat(struct phy_device *phydev, int i)
+{
+	struct lan887x_hw_stat stat = lan887x_hw_stats[i];
+	struct lan887x_priv *priv = phydev->priv;
+	int val;
+	u64 ret;
+
+	if (stat.mmd)
+		val = phy_read_mmd(phydev, stat.mmd, stat.reg);
+	else
+		val = phy_read(phydev, stat.reg);
+
+	if (val < 0) {
+		ret = U64_MAX;
+	} else {
+		val = val & ((1 << stat.bits) - 1);
+		priv->stats[i] += val;
+		ret = priv->stats[i];
+	}
+
+	return ret;
+}
+
+static void lan887x_get_stats(struct phy_device *phydev,
+			      struct ethtool_stats *stats, u64 *data)
+{
+	for (int i = 0; i < ARRAY_SIZE(lan887x_hw_stats); i++)
+		data[i] = lan887x_get_stat(phydev, i);
+}
+
+static int lan887x_get_sset_count(struct phy_device *phydev)
+{
+	return ARRAY_SIZE(lan887x_hw_stats);
+}
+
+static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
+{
+	for (int i = 0; i < ARRAY_SIZE(lan887x_hw_stats); i++) {
+		strscpy(data + i * ETH_GSTRING_LEN,
+			lan887x_hw_stats[i].string, ETH_GSTRING_LEN);
+	}
+}
+
 static struct phy_driver microchip_t1_phy_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX),
@@ -894,6 +1479,20 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.get_sqi_max	= lan87xx_get_sqi_max,
 		.cable_test_start = lan87xx_cable_test_start,
 		.cable_test_get_status = lan87xx_cable_test_get_status,
+	},
+	{
+		PHY_ID_MATCH_MODEL(PHY_ID_LAN887X),
+		.name		= "Microchip LAN887x T1 PHY",
+		.probe		= lan887x_probe,
+		.get_features	= lan887x_get_features,
+		.config_init    = lan887x_config_init,
+		.config_aneg    = lan887x_config_aneg,
+		.get_stats      = lan887x_get_stats,
+		.get_sset_count = lan887x_get_sset_count,
+		.get_strings    = lan887x_get_strings,
+		.suspend	= genphy_suspend,
+		.resume		= genphy_resume,
+		.read_status	= genphy_c45_read_status,
 	}
 };
 
@@ -902,6 +1501,7 @@ module_phy_driver(microchip_t1_phy_driver);
 static struct mdio_device_id __maybe_unused microchip_t1_tbl[] = {
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN87XX) },
 	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN937X) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_LAN887X) },
 	{ }
 };
 
-- 
2.17.1


