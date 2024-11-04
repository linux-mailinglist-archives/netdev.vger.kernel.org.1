Return-Path: <netdev+bounces-141450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC09BAF25
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 10:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA41B1F21A9B
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 09:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F91AD403;
	Mon,  4 Nov 2024 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qmESNuTL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B31AC458;
	Mon,  4 Nov 2024 09:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711333; cv=none; b=aQY3n2kUElqNdTtShYI5KJOWL+ukXHOkiKd/sXyx1RLBIQZ5c4UGyE/9tfjTUNWsEgOJ9W/QB6fDXwfePxV5c0kgF5WdaF2GaTU7a0iBpxIP5GzSZmHurtuntDQVjcjiAQMc6vOzeJUxOvAYZ38r7IxhFggfN70n7ZpLdWnnEAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711333; c=relaxed/simple;
	bh=/cFKz9ZTZlBH6GEhxrrNisrcY1Sf2JsbEbTGGhMslJQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKissKVZNbU89E2m++oURL3lGhna/2begdSXxFNVLia2/J1f4gECWcBj42ogKOVOh8Z7LG2BenWOKx8MXyaJgTbxGy8OipoxSouqjwC8rXFadZk8JynAjiWrMeLCRbBm+hhYK2obylnw4Kpq47gg7x112bPC/GLpU28vGOmFiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qmESNuTL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1730711332; x=1762247332;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=/cFKz9ZTZlBH6GEhxrrNisrcY1Sf2JsbEbTGGhMslJQ=;
  b=qmESNuTLfTQDKy1ZOJZ8ePxS7Di1cMCuVGTXAZgYYWk5EIoOfq+NCuo4
   GGsxufjDdGfMnJPVMpk6kk7RmwkNeJ3N4D2l848r6mwwe+m683967wUTa
   njQ+WLZ7xxEj85mCu/c4Xi1pPLfCpqKUlrjzmjkd8tvP5nrvS6awj9/S4
   85zExVxM8KYnrZpaScqexTBoN2mbyFDLLez9XtzW6Pb9hXkAWTSmA//Zz
   8bu8eUgTAlpY1OhkjqK+tD3jr+a/q2i12VrWF2HWfZ/RE8y8cXYIb8cha
   UTjuluxPbxbfngQ4EU7DCiOGVr3vyVILb0WhLAAxHNjC71uOw9+san7US
   g==;
X-CSE-ConnectionGUID: 76DCBbJASTWMbmfvXbdxcw==
X-CSE-MsgGUID: hKMK2P+cSB+EcZckZ4PJgQ==
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="33830845"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Nov 2024 02:08:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Nov 2024 02:08:19 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 4 Nov 2024 02:08:15 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>
Subject: [PATCH net-next 5/5] net: phy: microchip_t1 : Add initialization of ptp for lan887x
Date: Mon, 4 Nov 2024 14:37:50 +0530
Message-ID: <20241104090750.12942-6-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241104090750.12942-1-divya.koppera@microchip.com>
References: <20241104090750.12942-1-divya.koppera@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add initialization of ptp for lan887x.

Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
---
 drivers/net/phy/microchip_t1.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 71d6050b2833..0a8b88d577c3 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -10,11 +10,15 @@
 #include <linux/ethtool.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/bitfield.h>
+#include "microchip_ptp.h"
 
 #define PHY_ID_LAN87XX				0x0007c150
 #define PHY_ID_LAN937X				0x0007c180
 #define PHY_ID_LAN887X				0x0007c1f0
 
+#define MCHP_PTP_LTC_BASE_ADDR			0xe000
+#define MCHP_PTP_PORT_BASE_ADDR			(MCHP_PTP_LTC_BASE_ADDR + 0x800)
+
 /* External Register Control Register */
 #define LAN87XX_EXT_REG_CTL                     (0x14)
 #define LAN87XX_EXT_REG_CTL_RD_CTL              (0x1000)
@@ -229,6 +233,7 @@
 
 #define LAN887X_INT_STS				0xf000
 #define LAN887X_INT_MSK				0xf001
+#define LAN887X_INT_MSK_P1588_MOD_INT_MSK	BIT(3)
 #define LAN887X_INT_MSK_T1_PHY_INT_MSK		BIT(2)
 #define LAN887X_INT_MSK_LINK_UP_MSK		BIT(1)
 #define LAN887X_INT_MSK_LINK_DOWN_MSK		BIT(0)
@@ -319,6 +324,7 @@ struct lan887x_regwr_map {
 
 struct lan887x_priv {
 	u64 stats[ARRAY_SIZE(lan887x_hw_stats)];
+	struct mchp_ptp_clock *clock;
 };
 
 static int lan937x_dsp_workaround(struct phy_device *phydev, u16 ereg, u8 bank)
@@ -1472,6 +1478,12 @@ static int lan887x_probe(struct phy_device *phydev)
 
 	phydev->priv = priv;
 
+	priv->clock = mchp_ptp_probe(phydev, MDIO_MMD_VEND1,
+				     MCHP_PTP_LTC_BASE_ADDR,
+				     MCHP_PTP_PORT_BASE_ADDR);
+	if (IS_ERR(priv->clock))
+		return PTR_ERR(priv->clock);
+
 	return lan887x_phy_setup(phydev);
 }
 
@@ -1518,6 +1530,7 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
 
 static int lan887x_config_intr(struct phy_device *phydev)
 {
+	struct lan887x_priv *priv = phydev->priv;
 	int rc;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
@@ -1538,11 +1551,18 @@ static int lan887x_config_intr(struct phy_device *phydev)
 		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
 	}
 
-	return rc < 0 ? rc : 0;
+	if (rc < 0)
+		return rc;
+
+	return mchp_config_ptp_intr(priv->clock, LAN887X_INT_MSK,
+				    LAN887X_INT_MSK_P1588_MOD_INT_MSK,
+				    (phydev->interrupts == PHY_INTERRUPT_ENABLED));
 }
 
 static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
 {
+	struct lan887x_priv *priv = phydev->priv;
+	int rc = IRQ_NONE;
 	int irq_status;
 
 	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
@@ -1553,10 +1573,13 @@ static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
 
 	if (irq_status & LAN887X_MX_CHIP_TOP_LINK_MSK) {
 		phy_trigger_machine(phydev);
-		return IRQ_HANDLED;
+		rc = IRQ_HANDLED;
 	}
 
-	return IRQ_NONE;
+	if (irq_status & LAN887X_INT_MSK_P1588_MOD_INT_MSK)
+		rc = mchp_ptp_handle_interrupt(priv->clock);
+
+	return rc;
 }
 
 static int lan887x_cd_reset(struct phy_device *phydev,
-- 
2.17.1


