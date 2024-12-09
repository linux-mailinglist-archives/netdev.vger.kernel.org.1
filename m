Return-Path: <netdev+bounces-150261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2422D9E9A3F
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCDB1642C3
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD101F0E22;
	Mon,  9 Dec 2024 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="n00KrHCP"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA3D1C5CD6;
	Mon,  9 Dec 2024 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733757503; cv=none; b=W0c79hd/oE7D+h3/DhZEeNoZN/yrrQXohpUZoPHBQ52xV4P/QzPD41VcIvXHHniVSbewyyjBqxy1VZ/8kawxu/5lDFH7KmmZPxvnXaBicSAwZlnj0rVstSu8tWC0XdC6yho+lKVNUqmR23yFTfOrEmG0IUw8YdBBbvX7UobsvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733757503; c=relaxed/simple;
	bh=PRlmrlfVkKdHL5h3fcsDewPyc+WWxgXH7RFjGKU4QHY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QumULOPRatY28IPC3EPle8zSYFaX8jZ3DlRtoRM968NAypCcei114cskAbGMAACM/BSinx45oYJxS5SrFOFmUSYp6NpOSZoW5kaiHek7nmHo2BILzhPsa3flKKfwq/QmtIyYUMoaNmYS6dXu5E+VaU/NcdgJBreU2V7bYjvRP0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=n00KrHCP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733757502; x=1765293502;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=PRlmrlfVkKdHL5h3fcsDewPyc+WWxgXH7RFjGKU4QHY=;
  b=n00KrHCPMm5c8VV4IoB2rtHAbOl6A5c1Gz1oVkuPWnNdYJAEB3TrFWjW
   hXRBLANmxT1EmYa77EJk28suKtLsY/Cfj+k7gNFzsfUNPAmsyHT9yLEK5
   KQd/U4cr4ZQ/M5ThJhevFZUsdoQbfinY1BLrDYgbSKrW8TjHwjRptrLqg
   p1Dr2OOF3wtsWm8T1nGOqz0ohxbF5Scr0GXNZXPNp2BCPm4Mqj3zPfpQp
   T18F1SKkGxgTzUTXLE7BKUHgJIQqUhGDuIwvkbd9GAUVGDXxel3zsvVHh
   FTEslI8NEfE3eLxps3luarKY83f/VoG0ROv7aB+36rjYdfCAhMp2ZNsA2
   A==;
X-CSE-ConnectionGUID: yJIa2BtxQkuJT04wZ40P6A==
X-CSE-MsgGUID: 7fc63HofQoWQAb2X16tGBg==
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="35775873"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 08:18:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 08:17:58 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Dec 2024 08:17:54 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v6 5/5] net: phy: microchip_t1 : Add initialization of ptp for lan887x
Date: Mon, 9 Dec 2024 20:47:42 +0530
Message-ID: <20241209151742.9128-6-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241209151742.9128-1-divya.koppera@microchip.com>
References: <20241209151742.9128-1-divya.koppera@microchip.com>
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
v5 -> v6
- Renamed ptp functions and macros.

v2 -> v5
- No changes

v1 -> v2
Fixed below review comment
  Added ptp support only if interrupts are supported as interrupts are mandatory
  for ptp.
---
 drivers/net/phy/microchip_t1.c | 41 +++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index b17bf6708003..73f28463bc35 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -10,11 +10,15 @@
 #include <linux/ethtool.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/bitfield.h>
+#include "microchip_rds_ptp.h"
 
 #define PHY_ID_LAN87XX				0x0007c150
 #define PHY_ID_LAN937X				0x0007c180
 #define PHY_ID_LAN887X				0x0007c1f0
 
+#define MCHP_RDS_PTP_LTC_BASE_ADDR		0xe000
+#define MCHP_RDS_PTP_PORT_BASE_ADDR	    (MCHP_RDS_PTP_LTC_BASE_ADDR + 0x800)
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
@@ -319,6 +324,8 @@ struct lan887x_regwr_map {
 
 struct lan887x_priv {
 	u64 stats[ARRAY_SIZE(lan887x_hw_stats)];
+	struct mchp_rds_ptp_clock *clock;
+	bool init_done;
 };
 
 static int lan937x_dsp_workaround(struct phy_device *phydev, u16 ereg, u8 bank)
@@ -1269,8 +1276,19 @@ static int lan887x_get_features(struct phy_device *phydev)
 
 static int lan887x_phy_init(struct phy_device *phydev)
 {
+	struct lan887x_priv *priv = phydev->priv;
 	int ret;
 
+	if (!priv->init_done && phy_interrupt_is_valid(phydev)) {
+		priv->clock = mchp_rds_ptp_probe(phydev, MDIO_MMD_VEND1,
+						 MCHP_RDS_PTP_LTC_BASE_ADDR,
+						 MCHP_RDS_PTP_PORT_BASE_ADDR);
+		if (IS_ERR(priv->clock))
+			return PTR_ERR(priv->clock);
+
+		priv->init_done = true;
+	}
+
 	/* Clear loopback */
 	ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
 				 LAN887X_MIS_CFG_REG2,
@@ -1470,6 +1488,7 @@ static int lan887x_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->init_done = false;
 	phydev->priv = priv;
 
 	return lan887x_phy_setup(phydev);
@@ -1518,6 +1537,7 @@ static void lan887x_get_strings(struct phy_device *phydev, u8 *data)
 
 static int lan887x_config_intr(struct phy_device *phydev)
 {
+	struct lan887x_priv *priv = phydev->priv;
 	int rc;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
@@ -1537,12 +1557,24 @@ static int lan887x_config_intr(struct phy_device *phydev)
 
 		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
 	}
+	if (rc < 0)
+		return rc;
 
-	return rc < 0 ? rc : 0;
+	if (phy_is_default_hwtstamp(phydev)) {
+		return mchp_rds_ptp_top_config_intr(priv->clock,
+					LAN887X_INT_MSK,
+					LAN887X_INT_MSK_P1588_MOD_INT_MSK,
+					(phydev->interrupts ==
+					 PHY_INTERRUPT_ENABLED));
+	}
+
+	return 0;
 }
 
 static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
 {
+	struct lan887x_priv *priv = phydev->priv;
+	int rc = IRQ_NONE;
 	int irq_status;
 
 	irq_status = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
@@ -1553,10 +1585,13 @@ static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
 
 	if (irq_status & LAN887X_MX_CHIP_TOP_LINK_MSK) {
 		phy_trigger_machine(phydev);
-		return IRQ_HANDLED;
+		rc = IRQ_HANDLED;
 	}
 
-	return IRQ_NONE;
+	if (irq_status & LAN887X_INT_MSK_P1588_MOD_INT_MSK)
+		rc = mchp_rds_ptp_handle_interrupt(priv->clock);
+
+	return rc;
 }
 
 static int lan887x_cd_reset(struct phy_device *phydev,
-- 
2.17.1


