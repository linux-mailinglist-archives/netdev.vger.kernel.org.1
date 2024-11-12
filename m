Return-Path: <netdev+bounces-144098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B184E9C5AF0
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 15:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C88B343A6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228816BE01;
	Tue, 12 Nov 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t/dj9K9d"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1314F114;
	Tue, 12 Nov 2024 13:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418675; cv=none; b=Nz8BKocLIRLH8vF/k5MHIXUisEJuVpwfwi8wYlg5/KSgNMCJqJTPeEds6lBs2/qUz/8XA9nsZIeD1p/humc1zsrReeuWR5tYFt+rGEBY+Pe45xVgRW20wTpgXHdM0L+53RDA5UQB9v002AdsfXuUN6IuVWaGDATjLR4S5uKjiog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418675; c=relaxed/simple;
	bh=M22kBCoViF2oiFHSYv/LdDbplNtw0xPr17RcYl8I/8M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcoLfo4R9UULv9yWoIIs8StzjHFttCSDt7gukD/Y9YwsrTqC/Muw0/nLEBavJPuhi01uVFetFefLTkEE5Ut0LgXTbUD7/1bceAUlDSusHJQ4R+gHD4njVnKErVuiiUd87WP9/egJbtgndId7g0mJl5KupmyF8E2rd4EjU1I+whM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t/dj9K9d; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1731418675; x=1762954675;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version;
  bh=M22kBCoViF2oiFHSYv/LdDbplNtw0xPr17RcYl8I/8M=;
  b=t/dj9K9dNxzCypomC5jzcot1WXgHJjgtYM0vsnxvnlaU5x4UikIXdDcT
   OIuW9vras6bWwLXIUOpoH7heja6lN5Q0crhlNezQsc3UQJpX3J/bGIoUV
   bebqEMuzPQ5aiqYhY+dVEFG0K606DSjnp93aw3lLTr36lpCtCm7O74F2U
   2X7YG7IWzjjc6NhWqf2f6MLnwgPukPA70Vd2KlfDnkqZAWTFYXqGx+AJx
   5pU5hUc8aPVBbU2CErXl4PX5NrNzCYvhfNxqCJwIzHFrZnZxyP+GFI53I
   7aPk9Kd1BcKxvk0ZVx60XQGihfuB+UNyJeCt9PogC7IWA266q82fOH3Jl
   A==;
X-CSE-ConnectionGUID: Z+lqW6AuToqQiDfZr0WV1g==
X-CSE-MsgGUID: kASvUUYyTz21D5rDXtDTBA==
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="34197677"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Nov 2024 06:37:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Nov 2024 06:37:31 -0700
Received: from training-HP-280-G1-MT-PC.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 12 Nov 2024 06:37:27 -0700
From: Divya Koppera <divya.koppera@microchip.com>
To: <andrew@lunn.ch>, <arun.ramadoss@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <richardcochran@gmail.com>,
	<vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 5/5] net: phy: microchip_t1 : Add initialization of ptp for lan887x
Date: Tue, 12 Nov 2024 19:07:24 +0530
Message-ID: <20241112133724.16057-6-divya.koppera@microchip.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112133724.16057-1-divya.koppera@microchip.com>
References: <20241112133724.16057-1-divya.koppera@microchip.com>
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
v2 -> v3
- No changes

v1 -> v2
Fixed below review comment
  Added ptp support only if interrupts are supported as interrupts are mandatory
  for ptp.
---
 drivers/net/phy/microchip_t1.c | 40 +++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index 71d6050b2833..63206ae8075d 100644
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
@@ -319,6 +324,8 @@ struct lan887x_regwr_map {
 
 struct lan887x_priv {
 	u64 stats[ARRAY_SIZE(lan887x_hw_stats)];
+	struct mchp_ptp_clock *clock;
+	bool init_done;
 };
 
 static int lan937x_dsp_workaround(struct phy_device *phydev, u16 ereg, u8 bank)
@@ -1269,8 +1276,19 @@ static int lan887x_get_features(struct phy_device *phydev)
 
 static int lan887x_phy_init(struct phy_device *phydev)
 {
+	struct lan887x_priv *priv = phydev->priv;
 	int ret;
 
+	if (!priv->init_done && phy_interrupt_is_valid(phydev)) {
+		priv->clock = mchp_ptp_probe(phydev, MDIO_MMD_VEND1,
+					     MCHP_PTP_LTC_BASE_ADDR,
+					     MCHP_PTP_PORT_BASE_ADDR);
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
@@ -1537,12 +1557,23 @@ static int lan887x_config_intr(struct phy_device *phydev)
 
 		rc = phy_read_mmd(phydev, MDIO_MMD_VEND1, LAN887X_INT_STS);
 	}
+	if (rc < 0)
+		return rc;
 
-	return rc < 0 ? rc : 0;
+	if (phy_is_default_hwtstamp(phydev)) {
+		return mchp_config_ptp_intr(priv->clock, LAN887X_INT_MSK,
+					    LAN887X_INT_MSK_P1588_MOD_INT_MSK,
+					    (phydev->interrupts ==
+					     PHY_INTERRUPT_ENABLED));
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
@@ -1553,10 +1584,13 @@ static irqreturn_t lan887x_handle_interrupt(struct phy_device *phydev)
 
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


