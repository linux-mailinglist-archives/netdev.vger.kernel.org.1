Return-Path: <netdev+bounces-234643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9174C24FB3
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5BB23350EE8
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 12:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEA8347FF2;
	Fri, 31 Oct 2025 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="muZg+Ibh"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37B305E02;
	Fri, 31 Oct 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913464; cv=none; b=MaR9uoeZ4my8mkAw0wWz28tlNB44EojidsOu1mgozY6QewXrIkQitRQr7IUBg70sd7ZyPDQe8ZOMWgMCKbYmG5qx6kkQEN8gHVhVhqWynnFkaZz7BhxvfZcgx5xucxMhM+0ACd6UqoI0MB26Os725fgCcrNsFhQTqeEIYKntAd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913464; c=relaxed/simple;
	bh=xtQyYyhFmDEBa/fL9Nh2RA03zj0vUNUF4yj/pKhh1RQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+aZ0QHU1GX9mPijIrrrapGIOfDVpnJD1IftgQUpjh6VhemQI2x9DCI/jLeKtW24lkoN9EvVMiEBISQcgruajkimvGMCfQO610NQq17Iot2mtydcxNyWU3BKahjaAQd3EOUhJYRBKiSTYjZTqI2SJCBTHVIgGhXbB7eznbdvuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=muZg+Ibh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761913463; x=1793449463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xtQyYyhFmDEBa/fL9Nh2RA03zj0vUNUF4yj/pKhh1RQ=;
  b=muZg+Ibh9EYTtpmio46tfH0hA95BZRkO1NnhSC2PuuWEFGAwQElPT5J/
   +9p+vz1LKfIhPl7mpmo4v/dKxYtQgI7oWSu/xFU/MWWcCbk9XMJf7h2Nd
   3dvEq5K+JSA4eevCTKSkleCP1eyAvuj59ahrwBTaIBb8EPqLoNFiI8O5z
   akNOkADbCQqgE6xOIt6Vi5F86LMq4XWuzEqSlNbyp8XTyM5f7il050ctc
   1ASjFwAtP7kooTRGi1826L9rqR2pOaA4mzEmnMiklXngbipyDhmA7xMyK
   V6NmapHdtBlH7YxfJJzKwrS74KLGfZWgquKfkr5raivRcvnPnnshPlNIh
   A==;
X-CSE-ConnectionGUID: uC/uM7IwQSingkNKy4SUug==
X-CSE-MsgGUID: 2oU8gT4cQEyphYmULF/35Q==
X-IronPort-AV: E=Sophos;i="6.19,269,1754982000"; 
   d="scan'208";a="49022904"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2025 05:24:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Fri, 31 Oct 2025 05:23:43 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 31 Oct 2025 05:23:41 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v4 1/2] net: phy: micrel: lan8842 errata
Date: Fri, 31 Oct 2025 13:16:28 +0100
Message-ID: <20251031121629.814935-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031121629.814935-1-horatiu.vultur@microchip.com>
References: <20251031121629.814935-1-horatiu.vultur@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add errata for lan8842. The errata document can be found here [1].
This is fixing the module 2 ("Analog front-end not optimized for
PHY-side shorted center taps").

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf

Fixes: 5a774b64cd6a ("net: phy: micrel: Add support for lan8842")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 147 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 604b5de0c1581..1fa56d4c17937 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -466,6 +466,12 @@ struct lan8842_priv {
 	u16 rev;
 };
 
+struct lanphy_reg_data {
+	int page;
+	u16 addr;
+	u16 val;
+};
+
 static const struct kszphy_type lan8814_type = {
 	.led_mode_reg		= ~LAN8814_LED_CTRL_1,
 	.cable_diag_reg		= LAN8814_CABLE_DIAG,
@@ -2835,6 +2841,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
  */
 #define LAN8814_PAGE_PCS_DIGITAL 2
 
+/**
+ * LAN8814_PAGE_EEE - Selects Extended Page 3.
+ *
+ * This page contains EEE registers
+ */
+#define LAN8814_PAGE_EEE 3
+
 /**
  * LAN8814_PAGE_COMMON_REGS - Selects Extended Page 4.
  *
@@ -2853,6 +2866,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
  */
 #define LAN8814_PAGE_PORT_REGS 5
 
+/**
+ * LAN8814_PAGE_POWER_REGS - Selects Extended Page 28.
+ *
+ * This page contains analog control registers and power mode registers.
+ */
+#define LAN8814_PAGE_POWER_REGS 28
+
 /**
  * LAN8814_PAGE_SYSTEM_CTRL - Selects Extended Page 31.
  *
@@ -5884,6 +5904,128 @@ static int lan8842_probe(struct phy_device *phydev)
 	return 0;
 }
 
+#define LAN8814_POWER_MGMT_MODE_3_ANEG_MDI		0x13
+#define LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX		0x14
+#define LAN8814_POWER_MGMT_MODE_5_10BT_MDI		0x15
+#define LAN8814_POWER_MGMT_MODE_6_10BT_MDIX		0x16
+#define LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN		0x17
+#define LAN8814_POWER_MGMT_MODE_8_100BT_MDI		0x18
+#define LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX	0x19
+#define LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX	0x1a
+#define LAN8814_POWER_MGMT_MODE_11_100BT_MDIX		0x1b
+#define LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX	0x1c
+#define LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX	0x1d
+#define LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX	0x1e
+
+#define LAN8814_POWER_MGMT_DLLPD_D			BIT(0)
+#define LAN8814_POWER_MGMT_ADCPD_D			BIT(1)
+#define LAN8814_POWER_MGMT_PGAPD_D			BIT(2)
+#define LAN8814_POWER_MGMT_TXPD_D			BIT(3)
+#define LAN8814_POWER_MGMT_DLLPD_C			BIT(4)
+#define LAN8814_POWER_MGMT_ADCPD_C			BIT(5)
+#define LAN8814_POWER_MGMT_PGAPD_C			BIT(6)
+#define LAN8814_POWER_MGMT_TXPD_C			BIT(7)
+#define LAN8814_POWER_MGMT_DLLPD_B			BIT(8)
+#define LAN8814_POWER_MGMT_ADCPD_B			BIT(9)
+#define LAN8814_POWER_MGMT_PGAPD_B			BIT(10)
+#define LAN8814_POWER_MGMT_TXPD_B			BIT(11)
+#define LAN8814_POWER_MGMT_DLLPD_A			BIT(12)
+#define LAN8814_POWER_MGMT_ADCPD_A			BIT(13)
+#define LAN8814_POWER_MGMT_PGAPD_A			BIT(14)
+#define LAN8814_POWER_MGMT_TXPD_A			BIT(15)
+
+#define LAN8814_POWER_MGMT_C_D		(LAN8814_POWER_MGMT_DLLPD_D | \
+					 LAN8814_POWER_MGMT_ADCPD_D | \
+					 LAN8814_POWER_MGMT_PGAPD_D | \
+					 LAN8814_POWER_MGMT_DLLPD_C | \
+					 LAN8814_POWER_MGMT_ADCPD_C | \
+					 LAN8814_POWER_MGMT_PGAPD_C)
+
+#define LAN8814_POWER_MGMT_B_C_D	(LAN8814_POWER_MGMT_C_D | \
+					 LAN8814_POWER_MGMT_DLLPD_B | \
+					 LAN8814_POWER_MGMT_ADCPD_B | \
+					 LAN8814_POWER_MGMT_PGAPD_B)
+
+#define LAN8814_POWER_MGMT_VAL1		(LAN8814_POWER_MGMT_C_D | \
+					 LAN8814_POWER_MGMT_ADCPD_B | \
+					 LAN8814_POWER_MGMT_PGAPD_B | \
+					 LAN8814_POWER_MGMT_ADCPD_A | \
+					 LAN8814_POWER_MGMT_PGAPD_A)
+
+#define LAN8814_POWER_MGMT_VAL2		LAN8814_POWER_MGMT_C_D
+
+#define LAN8814_POWER_MGMT_VAL3		(LAN8814_POWER_MGMT_C_D | \
+					 LAN8814_POWER_MGMT_DLLPD_B | \
+					 LAN8814_POWER_MGMT_ADCPD_B | \
+					 LAN8814_POWER_MGMT_PGAPD_A)
+
+#define LAN8814_POWER_MGMT_VAL4		(LAN8814_POWER_MGMT_B_C_D | \
+					 LAN8814_POWER_MGMT_ADCPD_A | \
+					 LAN8814_POWER_MGMT_PGAPD_A)
+
+#define LAN8814_POWER_MGMT_VAL5		LAN8814_POWER_MGMT_B_C_D
+
+static const struct lanphy_reg_data short_center_tap_errata[] = {
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_3_ANEG_MDI,
+	  LAN8814_POWER_MGMT_VAL1 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX,
+	  LAN8814_POWER_MGMT_VAL1 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_5_10BT_MDI,
+	  LAN8814_POWER_MGMT_VAL1 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_6_10BT_MDIX,
+	  LAN8814_POWER_MGMT_VAL1 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN,
+	  LAN8814_POWER_MGMT_VAL2 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_8_100BT_MDI,
+	  LAN8814_POWER_MGMT_VAL3 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX,
+	  LAN8814_POWER_MGMT_VAL3 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX,
+	  LAN8814_POWER_MGMT_VAL4 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_11_100BT_MDIX,
+	  LAN8814_POWER_MGMT_VAL5 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX,
+	  LAN8814_POWER_MGMT_VAL5 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX,
+	  LAN8814_POWER_MGMT_VAL4 },
+	{ LAN8814_PAGE_POWER_REGS,
+	  LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
+	  LAN8814_POWER_MGMT_VAL4 },
+};
+
+static int lanphy_write_reg_data(struct phy_device *phydev,
+				 const struct lanphy_reg_data *data,
+				 size_t num)
+{
+	int ret = 0;
+
+	while (num--) {
+		ret = lanphy_write_page_reg(phydev, data->page, data->addr,
+					    data->val);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+static int lan8842_erratas(struct phy_device *phydev)
+{
+	return lanphy_write_reg_data(phydev, short_center_tap_errata,
+				    ARRAY_SIZE(short_center_tap_errata));
+}
+
 static int lan8842_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -5896,6 +6038,11 @@ static int lan8842_config_init(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
+	/* Apply the erratas for this device */
+	ret = lan8842_erratas(phydev);
+	if (ret < 0)
+		return ret;
+
 	/* Even if the GPIOs are set to control the LEDs the behaviour of the
 	 * LEDs is wrong, they are not blinking when there is traffic.
 	 * To fix this it is required to set extended LED mode
-- 
2.34.1


