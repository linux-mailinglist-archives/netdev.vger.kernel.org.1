Return-Path: <netdev+bounces-223967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F690B7CD1B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81F27523789
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E8F29A323;
	Wed, 17 Sep 2025 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U7LByDbT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7B2D05D;
	Wed, 17 Sep 2025 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106360; cv=none; b=ncJ/wXBnmdrpyF6S9dRdQKOzshSpF80ZDYUmwrVP+jWXVjkY7QtHss/8R8+SZbVzoeDoeQ9hp9XV8yoQvuF+TqO1cgKR2tiNpDN5ZWTk0bDmjcYe7/wGJ4zFiGD1tSRrloZ8Amp61VReM2u/4poilye1y/RVMFQa3Efv4QBh0yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106360; c=relaxed/simple;
	bh=cT1ndc0cXbjAgVOSSx+yf4dBqSEecEZsxVmJK/s64qg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=heo4vqTrW2h+xBbNWhHCVWs+CbltETMfm21H20Kcn+bEs3+mvGeKyFjIepybAs4mVUHgllMqlWcafJmJ3Ki62MafUD+ntxJ/UwlX2wHZ2QuU7XNSudf7RH/NrRY6NPiVdt4VTWYuGYFqNe4dTDO3g8LhMphQV0/TtJWHpAH+r9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U7LByDbT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758106358; x=1789642358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cT1ndc0cXbjAgVOSSx+yf4dBqSEecEZsxVmJK/s64qg=;
  b=U7LByDbTD7xrump8yVdrq3htawHUgtO6aiTu1P9PrTxoOv1qLyY+Tk+j
   GmaiDMP0ABLoARicffmsw9/Qh9geIbqRde9/ss1r6x8dgKv57Mz9icLIe
   uiP+BSbr4L1ivCcCZpfTLPGd8/q7fQFhbdmQNIqg8kmcZEg73ecPBFfNf
   wsTIVZejn5V1dEmabUHI6Tnr9/y/qC+jfPRorB6rHXkBj2SanBE1ZQZE7
   00FY3QFPKi8gmkSd7ySAi62BUR7BEKCDUt3RIgsJuGClwhCeYeRoPgkW9
   iAf0kfThL/2GTeNQvdpy8Su9HwLpHFPwtsLXWPgUsCW+uQ1vosZiA9+2r
   Q==;
X-CSE-ConnectionGUID: 4yvbvGwYT+ChxZSk5lvAZQ==
X-CSE-MsgGUID: 6eK46GDiRbaqAoZ1tCO1cQ==
X-IronPort-AV: E=Sophos;i="6.18,271,1751266800"; 
   d="scan'208";a="46037418"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 03:52:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 17 Sep 2025 03:52:00 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Wed, 17 Sep 2025 03:51:59 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v3] net: phy: micrel: Add Fast link failure support for lan8842
Date: Wed, 17 Sep 2025 12:46:30 +0200
Message-ID: <20250917104630.3931969-1-horatiu.vultur@microchip.com>
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
v2->v3:
- improve comment for LAN8814_PAGE_PCS by saying explict what it
  contains
v1->v2:
- fix typo appaers->appears
- simplify lan8842_set_fast_down as suggested by Russell
---
 drivers/net/phy/micrel.c | 79 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e403cbbcead5b..af05764394f69 100644
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
+ * This page contains timers used for auto-negotiation, debug registers and
+ * register to configure fast link failure.
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
@@ -6055,6 +6065,69 @@ static int lan8842_update_stats(struct phy_device *phydev)
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
+	u16 flf;
+
+	switch (*msecs) {
+	case ETHTOOL_PHY_FAST_LINK_DOWN_OFF:
+		flf = 0;
+		break;
+	case ETHTOOL_PHY_FAST_LINK_DOWN_ON:
+		flf = LAN8842_FLF_ENA | LAN8842_FLF_ENA_LINK_DOWN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return lanphy_modify_page_reg(phydev, LAN8814_PAGE_PCS,
+				      LAN8842_FLF,
+				      LAN8842_FLF_ENA |
+				      LAN8842_FLF_ENA_LINK_DOWN, flf);
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
@@ -6299,6 +6372,8 @@ static struct phy_driver ksphy_driver[] = {
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


