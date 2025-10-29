Return-Path: <netdev+bounces-233802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4870C18B00
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 08:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD5AB4F8807
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272232DA763;
	Wed, 29 Oct 2025 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s/aR5K49"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC874C6D;
	Wed, 29 Oct 2025 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722909; cv=none; b=YN5hZiM7YTcVGby4xnkeAnwPG0aTJvXrDMcEJZCh0OzMZ/uPvOuYiWL34UKOeZa+0nOfvPYL1sS21jnZ76DVUwRIayW94BXH3EYvb/owxIcCQCI8cWWHYAeCK0ZWmdRDnLrLcI0UzhjBMzYHLg6kTsnB5oegrZzkDSSDMJYSqCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722909; c=relaxed/simple;
	bh=IKrMilH0x+w3pVBYhXKASnpatCeKSv405ItmAQMtA/4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDw1cTo4wBKBFSqICTJSAdDUyrXZo03m8/kfHvaPNHaT/VI7F+I43ExZyBISNaNKfXlwd+qjlB4nW2NxN8LTDAG5UJyGoAPeUAT032lt4hNEeGlo1l9hwWZ3s4gfsF1ka+xQzvq5BkPqaqk4GkXDgoOX+wFyocM+6KM58DXd5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s/aR5K49; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1761722906; x=1793258906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IKrMilH0x+w3pVBYhXKASnpatCeKSv405ItmAQMtA/4=;
  b=s/aR5K49wwOX312rvxgx+ta1vnrTd6Fp0+7FjtbjP7i92xB8W8Ziva2c
   Vw/9Pliz98aYsaShrSUW1pxglqpnyHCZBThv5zSgfe7oR3jXzyHXaJWl0
   GOp77VE/L2SdYYFW97Fs4TiRSc+8oZzgPhYyfUG2ubeJutSeIDfh37KNq
   v8yPEHW46Ez0iqFvVoxiggm67WA4eiSw1iTVQz0zCqS+G2FcYTWjjUP4s
   7p2zREuhyr+dzfes/EiDuhRpD/vncxFP7QVJxJvQqpK24nEm+6M8izu6g
   cjSfxlgIpOHAsw8tB6QWlRngfmeBhl0jzc6shfrDbL2sj844+tNyz0BBb
   g==;
X-CSE-ConnectionGUID: lh0mYcbFSl+9cvidjQy/DA==
X-CSE-MsgGUID: VC/bIrsLQlWhs/MxJf3ZLQ==
X-IronPort-AV: E=Sophos;i="6.19,263,1754982000"; 
   d="scan'208";a="215747487"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2025 00:28:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 29 Oct 2025 00:28:15 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 29 Oct 2025 00:28:13 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2 1/2] net: phy: micrel: lan8842 errata
Date: Wed, 29 Oct 2025 08:24:55 +0100
Message-ID: <20251029072456.392969-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029072456.392969-1-horatiu.vultur@microchip.com>
References: <20251029072456.392969-1-horatiu.vultur@microchip.com>
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
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 149 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 604b5de0c1581..4b526587093c6 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2853,6 +2853,13 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
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
@@ -5884,6 +5891,143 @@ static int lan8842_probe(struct phy_device *phydev)
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
+	return lanphy_write_page_reg(phydev, LAN8814_PAGE_POWER_REGS,
+				     LAN8814_POWER_MGMT_MODE_14_100BTX_EEE_TX_RX,
+				     LAN8814_POWER_MGMT_VAL4);
+}
+
 static int lan8842_config_init(struct phy_device *phydev)
 {
 	int ret;
@@ -5896,6 +6040,11 @@ static int lan8842_config_init(struct phy_device *phydev)
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


