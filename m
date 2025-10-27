Return-Path: <netdev+bounces-233181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77309C0DB26
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 13:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D1574F5EB5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566C22A4EE;
	Mon, 27 Oct 2025 12:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jy3oKCA2"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFDA226CFD;
	Mon, 27 Oct 2025 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569176; cv=none; b=kwLft0q1BE+W2tFeiUJyunX/z8QzhbuWChTU0zA87UPHpLHkcB++g6ulLFHOVSQ3DmlJzSCUCvicLxF4SCBE7//gsoBPFqte/9UBRD2tLKT4o9QRFzv+5SWuAznnVcEBRjY7pQxPYJswpO/4hfMM1ieGyrCy6RYGf9BC0T5hSyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569176; c=relaxed/simple;
	bh=TdxuPqLZziFnxsPOgN04mmsgtUByweKcrhEQE8hk0ok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eRViZIJzOQdkvibf40gEtH8wHQeGenG0mDgeYFPYD+vEfIP5usMLrxXahqpi8YGODxYmbxnWaPxz2nHj39eENZq7mjDcAumOT32+1VJc+rp6dxFVabZQuybNWfTy15dw5NCypaQ3i7/AS8GGFwINDfFE7sr83E32VlmP6/5SSSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jy3oKCA2; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761569175; x=1793105175;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TdxuPqLZziFnxsPOgN04mmsgtUByweKcrhEQE8hk0ok=;
  b=Jy3oKCA2noVmg7nRXyXIVjhuqYjCmVBLxOAtNgxF5plaKMJ/nCpVOCwN
   wTF/T6lDjn93LYFteqo7Vqh9xJpkfewvEKKNEWAEmMzB/+USdUuGV7NbF
   glGBEOhr0dSWsH2vp1uYv0qe3/eO26/osUE5Yp+qZew4AaXpDeLVG/p0m
   mOc7kuAv+mRZK1AUcfdfKq8lju1RMrSOkrXOs1ZVxTjCXRbl3NKin3GPL
   LJP0Uu1kwhOq6qz/Nqo2iOAbJffc/UwZSoOfCfn8fnSUKt1EQLhzIx1Q6
   kzXrnN63WY87xjzIFFH/f5w0E1W+uKXbK8UXe78AKiwC+SuV/zrvo4I9P
   w==;
X-CSE-ConnectionGUID: CRg2JnddQXqvHrHDe8eZOQ==
X-CSE-MsgGUID: p1KyY9n1TaCHml4dmxlesg==
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="279676605"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2025 05:46:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 27 Oct 2025 05:45:45 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 27 Oct 2025 05:45:43 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy:  micrel: lan8842 erratas
Date: Mon, 27 Oct 2025 13:40:26 +0100
Message-ID: <20251027124026.64232-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add two erratas for lan8842. The errata document can be found here [1].
This is fixing the module 2 ("Analog front-end not optimized for
PHY-side shorted center taps") and module 7 ("1000BASE-T PMA EEE TX wake
timer is non-compliant")

[1] https://ww1.microchip.com/downloads/aemDocuments/documents/UNG/ProductDocuments/Errata/LAN8842-Errata-DS80001172.pdf

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 166 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 166 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index edca0024b7c73..60788dba3ee8d 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2837,6 +2837,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
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
@@ -2855,6 +2862,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
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
@@ -5918,6 +5932,153 @@ static int lan8842_probe(struct phy_device *phydev)
 	return 0;
 }
 
+#define LAN8814_POWER_MGMT_MODE_3_ANEG_MDI		0x13
+#define LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX		0x14
+#define LAN8814_POWER_MGMT_MODE_5_10BT_MDI		0x15
+#define LAN8814_POWER_MGMT_MODE_6_10BT_MDIX		0x15
+#define LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN		0x15
+#define LAN8814_POWER_MGMT_MODE_8_100BT_MDI		0x15
+#define LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX	0x15
+#define LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX	0x15
+#define LAN8814_POWER_MGMT_MODE_11_100BT_MDIX		0x1b
+#define LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX	0x15
+#define LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX	0x15
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
+#define LAN8814_EEE_WAKE_TX_TIMER			0x0e
+#define LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL		0x1f
+
+static int lan8842_erratas(struct phy_device *phydev)
+{
+	int ret;
+
+	/* Magjack center tapped ports */
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_3_ANEG_MDI,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_4_ANEG_MDIX,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_5_10BT_MDI,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_6_10BT_MDIX,
+				    LAN8814_POWER_MGMT_VAL1);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_7_100BT_TRAIN,
+				    LAN8814_POWER_MGMT_VAL2);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_8_100BT_MDI,
+				    LAN8814_POWER_MGMT_VAL3);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_9_100BT_EEE_MDI_TX,
+				    LAN8814_POWER_MGMT_VAL3);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_10_100BT_EEE_MDI_RX,
+				    LAN8814_POWER_MGMT_VAL4);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_11_100BT_MDIX,
+				    LAN8814_POWER_MGMT_VAL5);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_12_100BT_EEE_MDIX_TX,
+				    LAN8814_POWER_MGMT_VAL5);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_13_100BT_EEE_MDIX_RX,
+				    LAN8814_POWER_MGMT_VAL4);
+	if (ret < 0)
+		return ret;
+
+	ret = lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				    LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
+				    LAN8814_POWER_MGMT_VAL4);
+	if (ret < 0)
+		return ret;
+
+	/* Refresh time Waketx timer */
+	return lanphy_write_page_reg(phydev, LAN8814_PAGE_EEE,
+				     LAN8814_EEE_WAKE_TX_TIMER,
+				     LAN8814_EEE_WAKE_TX_TIMER_MAX_VAL);
+}
+
 static int lan8842_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -5930,6 +6091,11 @@ static int lan8842_config_init(struct phy_device *phydev)
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


