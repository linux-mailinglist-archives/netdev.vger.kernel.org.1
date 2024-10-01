Return-Path: <netdev+bounces-130913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C0598C034
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C2B283B5B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 14:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2E1C7B89;
	Tue,  1 Oct 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="nVKn6zYB"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476441C6F7A;
	Tue,  1 Oct 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727793486; cv=none; b=S21fp5Fw0raLcRyZz0iw/VLcYviA9Ph+mObOb86Dt4u8n0kDLeTlUyKiavt/Y4PyP6VXWGSjdH+JirFQF+abmZF7ZyQviCm3SaUlFO/hMPDFebKPxpYfGrP7SLgE0/iDIVXcitYAt5sLtSbGH1tGYIMcuv+UAD28FGVNKRdqyo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727793486; c=relaxed/simple;
	bh=jfVsYpkir0k3lmTrvxYtwcsj3SsjsgLmclZ+WaqdzKU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OIuYwnUx0LH31Mn+CcEjLOzLYbKH4krdMcMyGzITZVln35MysOTePNspmJNFL79Y3MgXWIRXztdNVY/jKAKJ6M9DFq03hUsEXOfdGXmPnf2dUVasWvLhXdt2oczC0Y3lRa9+UX/Vxml8aUhstHW+wNJis8//wNqJ5k/AUw+xpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=nVKn6zYB; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727793484; x=1759329484;
  h=from:to:subject:date:message-id:mime-version;
  bh=jfVsYpkir0k3lmTrvxYtwcsj3SsjsgLmclZ+WaqdzKU=;
  b=nVKn6zYBkHVhLNfh0vT3C9zmVk7WxNgvj3ju1smsyQ57sEdO1kSlgnr6
   02Wo40uGvJl33VQKmtukpyenNvyUsv4rGj2J5lXUC5YGHVYZTQYGgxf9q
   1s2r9eDpWkAe4udIEb/3K1DAAkD6tElHRihJ+xnsi4IZYHcb1z2MIpuiT
   gnRTRhT/UAFZtX2A1tlR2rZh/xDfgj3ERxBWJU62sY5MQDpNv5DADOFce
   rxw4wJJUkzNTn1LZqt3ysqx8h3zxaxOPYaVIu2FC8b9LfFbSKUndzyLNQ
   AxVqeyDgA93NXtQ3O2c19kt3PSAdQgUUEl/fQnozQ0PtALAKDA7n+rTzH
   w==;
X-CSE-ConnectionGUID: APWxkd+jQIOd5mDRlmtNJw==
X-CSE-MsgGUID: 7UhC6AvmRaaVXjsJIAysMw==
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="33060315"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Oct 2024 07:38:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 1 Oct 2024 07:37:52 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 1 Oct 2024 07:37:48 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <arun.ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v2] net: phy: microchip_t1: Interrupt support for lan887x
Date: Tue, 1 Oct 2024 20:14:21 +0530
Message-ID: <20241001144421.6661-1-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add support for link up and link down interrupts in lan887x.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
v1 -> v2
- Replaced ret with rc return variable.
- Moved interrupt APIs to proper place and removed forward declaration.
- Removed redundant return variable declaration.
---
 drivers/net/phy/microchip_t1.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index a5ef8fe50704..f99f37634d5e 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -226,6 +226,18 @@
 #define MICROCHIP_CABLE_MAX_TIME_DIFF	\
 	(MICROCHIP_CABLE_MIN_TIME_DIFF + MICROCHIP_CABLE_TIME_MARGIN)
 
+#define LAN887X_INT_STS				0xf000
+#define LAN887X_INT_MSK				0xf001
+#define LAN887X_INT_MSK_T1_PHY_INT_MSK		BIT(2)
+#define LAN887X_INT_MSK_LINK_UP_MSK		BIT(1)
+#define LAN887X_INT_MSK_LINK_DOWN_MSK		BIT(0)
+
+#define LAN887X_MX_CHIP_TOP_LINK_MSK	(LAN887X_INT_MSK_LINK_UP_MSK |\
+					 LAN887X_INT_MSK_LINK_DOWN_MSK)
+
+#define LAN887X_MX_CHIP_TOP_ALL_MSK	(LAN887X_INT_MSK_T1_PHY_INT_MSK |\
+					 LAN887X_MX_CHIP_TOP_LINK_MSK)
+
 #define DRIVER_AUTHOR	"Nisar Sayed <nisar.sayed@microchip.com>"
 #define DRIVER_DESC	"Microchip LAN87XX/LAN937x/LAN887x T1 PHY driver"
 
@@ -1474,6 +1486,49 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
 		ethtool_puts(&data, lan887x_hw_stats[i].string);
 }
 
+static int lan887x_config_intr(struct phy_device *phydev)
+{
+	int rc;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		/* Clear the interrupt status before enabling interrupts */
+		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
+		if (rc < 0)
+			return rc;
+
+		/* Unmask for enabling interrupt */
+		rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_MSK,
+				   (u16)~LAN887X_MX_CHIP_TOP_ALL_MSK);
+	} else {
+		rc = phy_write_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_MSK,
+				   GENMASK(15, 0));
+		if (rc < 0)
+			return rc;
+
+		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
+	}
+
+	return rc < 0 ? rc : 0;
+}
+
+static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	if (irq_status & LAN887X_MX_CHIP_TOP_LINK_MSK) {
+		phy_trigger_machine(phydev);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
 static int lan887x_cd_reset(struct phy_device *phydev,
 			    enum cable_diag_state cd_done)
 {
@@ -1504,6 +1559,10 @@ static int lan887x_cd_reset(struct phy_device *phydev,
 		if (rc < 0)
 			return rc;
 
+		rc = lan887x_config_intr(phydev);
+		if (rc < 0)
+			return rc;
+
 		rc = lan887x_phy_reconfig(phydev);
 		if (rc < 0)
 			return rc;
@@ -1881,6 +1940,8 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.read_status	= genphy_c45_read_status,
 		.cable_test_start = lan887x_cable_test_start,
 		.cable_test_get_status = lan887x_cable_test_get_status,
+		.config_intr    = lan887x_config_intr,
+		.handle_interrupt = lan887x_handle_interrupt,
 	}
 };
 
-- 
2.17.1


