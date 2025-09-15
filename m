Return-Path: <netdev+bounces-222961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9EBB5747F
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 11:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B4FC4E18F0
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 09:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6B62F0C5B;
	Mon, 15 Sep 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OFCXcuUo"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BDF2F0C64;
	Mon, 15 Sep 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927841; cv=none; b=bdz4tax04+U6jLKpVz82SRSX5VJPUQPWyMf3QhBwbGcf2YSgYU63PEACjAI5ITndA430h/Rxyfwangdy3arQMAHW419vm8xnVZM0P+IM3791t/XxVCkM4v9eEqJ03FMIK2pTZNjc9aevLfJ0sg5Xpd1C0eZso9T1RJqL9aLUlqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927841; c=relaxed/simple;
	bh=zfbydqOh+dk1zNcsBtslvIQY6yi3mBOP1C29nui2VcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gSNdi5xIAMFCcKqJuFdStkIQSp5loJHjSTEAM+QRzEUH9dOWX9gWtSP2mHpjRH0EwxVsCOJOM5iNGRSy5d17FzxBNd1pt51J9Z0wB6a7g/YS4DAH8We4djdeSs1XOyMsgOffwFeaCUnLr9KsHy1aquiGjNerAJ6WQv9OqRXAHfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OFCXcuUo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1757927840; x=1789463840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zfbydqOh+dk1zNcsBtslvIQY6yi3mBOP1C29nui2VcI=;
  b=OFCXcuUos/Y72GyXSlFfdK76TdCu4QBRsNVu/kyZDxjuiWO10s5yDA+f
   U4dTkQhwvXblghfOzSto7lCtMHDSTP+rpJsojF6/XMZXNJ4skTbi5WiGy
   /hz0fCsUZS5z4WPSDr5SSB5MgeHctc7/n9hNvEZGfvBMnx/TgsQ5r5Mu1
   Pbd+CgCxolwAgvpe6c36d8GfGBH+4rCYvYo7jkN4JYFP6doEa+40Aw2qm
   rfhHx4aR/IQ6Dj4RMNTSHsecxbnjwWK5clk8uCV9SSQB8Ryq7HtZ+NFhf
   p7ueFNi9i8lGw3Cc61QFGM8m+4zRFYFEZXJI6vGXcevHQhxdSPv2e2FDj
   g==;
X-CSE-ConnectionGUID: D9R2LNivTDmP0BykzHc4zw==
X-CSE-MsgGUID: OdHmFyjUQPG9P7zwgDpDVw==
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; 
   d="scan'208";a="46505434"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Sep 2025 02:17:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 02:16:31 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 15 Sep 2025 02:16:29 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next] net: phy: micrel: Add Fast link failure support for lan8842
Date: Mon, 15 Sep 2025 11:11:49 +0200
Message-ID: <20250915091149.3539162-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support for fast link failure for lan8842, when this is enabled the
PHY will detect link down immediately (~1ms). The disadvantage of this
is that also small instability might be reported as link down.
Therefore add this feature as a tunable configuration and the user will
know when to enable or not. By default it is not enabled.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/micrel.c | 77 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e403cbbcead5b..a946c34dbbf79 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -107,6 +107,7 @@
 #define LAN8814_INTC				0x18
 #define LAN8814_INTS				0x1B
 
+#define LAN8814_INT_FLF				BIT(15)
 #define LAN8814_INT_LINK_DOWN			BIT(2)
 #define LAN8814_INT_LINK_UP			BIT(0)
 #define LAN8814_INT_LINK			(LAN8814_INT_LINK_UP |\
@@ -2805,6 +2806,14 @@ static int ksz886x_cable_test_get_status(struct phy_device *phydev,
 	return ret;
 }
 
+/**
+ * LAN8814_PAGE_PCS - Selects Extended Page 0.
+ *
+ * This page appaers to control the fast link failure and there are different
+ * debug info registers.
+ */
+#define LAN8814_PAGE_PCS 0
+
 /**
  * LAN8814_PAGE_AFE_PMA - Selects Extended Page 1.
  *
@@ -5910,7 +5919,8 @@ static int lan8842_config_intr(struct phy_device *phydev)
 		if (err)
 			return err;
 
-		err = phy_write(phydev, LAN8814_INTC, LAN8814_INT_LINK);
+		err = phy_write(phydev, LAN8814_INTC,
+				LAN8814_INT_LINK | LAN8814_INT_FLF);
 	} else {
 		err = phy_write(phydev, LAN8814_INTC, 0);
 		if (err)
@@ -5986,7 +5996,7 @@ static irqreturn_t lan8842_handle_interrupt(struct phy_device *phydev)
 		return IRQ_NONE;
 	}
 
-	if (irq_status & LAN8814_INT_LINK) {
+	if (irq_status & (LAN8814_INT_LINK | LAN8814_INT_FLF)) {
 		phy_trigger_machine(phydev);
 		ret = IRQ_HANDLED;
 	}
@@ -6055,6 +6065,67 @@ static int lan8842_update_stats(struct phy_device *phydev)
 	return 0;
 }
 
+#define LAN8842_FLF				15 /* 0x0e */
+#define LAN8842_FLF_ENA				BIT(1)
+#define LAN8842_FLF_ENA_LINK_DOWN		BIT(0)
+
+static int lan8842_get_fast_down(struct phy_device *phydev, u8 *msecs)
+{
+	int ret;
+
+	ret = lanphy_read_page_reg(phydev, LAN8814_PAGE_PCS, LAN8842_FLF);
+	if (ret < 0)
+		return ret;
+
+	if (ret & LAN8842_FLF_ENA)
+		*msecs = ETHTOOL_PHY_FAST_LINK_DOWN_ON;
+	else
+		*msecs = ETHTOOL_PHY_FAST_LINK_DOWN_OFF;
+
+	return 0;
+}
+
+static int lan8842_set_fast_down(struct phy_device *phydev, const u8 *msecs)
+{
+	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_ON)
+		return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
+					      LAN8842_FLF,
+					      LAN8842_FLF_ENA |
+					      LAN8842_FLF_ENA_LINK_DOWN,
+					      LAN8842_FLF_ENA |
+					      LAN8842_FLF_ENA_LINK_DOWN);
+
+	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
+		return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
+					      LAN8842_FLF,
+					      LAN8842_FLF_ENA |
+					      LAN8842_FLF_ENA_LINK_DOWN, 0);
+
+	return -EINVAL;
+}
+
+static int lan8842_get_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_FAST_LINK_DOWN:
+		return lan8842_get_fast_down(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lan8842_set_tunable(struct phy_device *phydev,
+			       struct ethtool_tunable *tuna, const void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_FAST_LINK_DOWN:
+		return lan8842_set_fast_down(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void lan8842_get_phy_stats(struct phy_device *phydev,
 				  struct ethtool_eth_phy_stats *eth_stats,
 				  struct ethtool_phy_stats *stats)
@@ -6299,6 +6370,8 @@ static struct phy_driver ksphy_driver[] = {
 	.handle_interrupt = lan8842_handle_interrupt,
 	.get_phy_stats	= lan8842_get_phy_stats,
 	.update_stats	= lan8842_update_stats,
+	.get_tunable	= lan8842_get_tunable,
+	.set_tunable	= lan8842_set_tunable,
 	.cable_test_start	= lan8814_cable_test_start,
 	.cable_test_get_status	= ksz886x_cable_test_get_status,
 }, {
-- 
2.34.1


