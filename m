Return-Path: <netdev+bounces-223443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A00B59278
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D28487783
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2827B296BA7;
	Tue, 16 Sep 2025 09:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="G9udsDFW"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F536221F13;
	Tue, 16 Sep 2025 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015665; cv=none; b=Mk52Kvt90ZytuEiGD4nZKiLLj4Jcp4922jogNDMxiju4NLF6VojH+VfLUJCDd4530mbX6qRdvGfTNCE/cocEnvFtQ7IDEruChmYY3zx3iww7Ona/ZufZFH5Z9HM8H/+CZn9Cxg3k94IJYvzRtUbFVRT0qbrz7xV5J0eE/187/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015665; c=relaxed/simple;
	bh=7mDQ3f8snEovW3tpnZoa5moze2SXoSnMrbg0Lk29bGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=klHEr9q/dPsWkLCZti0axJjrcTr2t6LM6HiwnAOgH+nrn7R17TdnSky0xFfqmDsaQhEOyPv0FQT/Z/eE8vWN6BVy9Vh6QN80Y0jXobOB1ISJOnJgNS5IF4eNR+u9l79oCZGItRxBN0EutN2Ro33FwKKILHWLu8V/J/zou1Ffops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=G9udsDFW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758015662; x=1789551662;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7mDQ3f8snEovW3tpnZoa5moze2SXoSnMrbg0Lk29bGA=;
  b=G9udsDFWQzUayOuDG57iXHN/XMn48AgXupopC2XhpIGbhBdFXStwT4cB
   sl9wT7srOHj6ajS4VRhJDL0U9Obkm4Gr0fA6VuFG74IhcW7BmiNYuwMCQ
   EHRH8NFdSUjnR02iVvf/TctEu77B1ExxNf/EedeAB1w1FmwTjYjZMjYW4
   hPs14w+MZip2oKqv4AsjrGx+fs6ajef3lYjMnkUCbvVfi4dmV24dRpZR8
   Cphl+hZkOeJOFT6gj/R9aCzCVpAeVqbqPXa55dfo/ZrLpn6gxTYAmWzDY
   mdTtUur6ew24gEeximUEy9/vg1k84/hWtOjGXytFPsfurDpibdFInG94U
   Q==;
X-CSE-ConnectionGUID: NkyZM3DcTXSy4ES9qfIxYw==
X-CSE-MsgGUID: dgoXgsAuSWqkOOV8WWkw1w==
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="45983016"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Sep 2025 02:40:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 16 Sep 2025 02:40:27 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 16 Sep 2025 02:40:25 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net-next v2] net: phy: micrel: Add Fast link failure support for lan8842
Date: Tue, 16 Sep 2025 11:36:05 +0200
Message-ID: <20250916093605.3735843-1-horatiu.vultur@microchip.com>
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
v1->v2:
- fix typo appaers->appears
- simplify lan8842_set_fast_down as suggested by Russell
---
 drivers/net/phy/micrel.c | 79 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index e403cbbcead5b..5e3f41fceab21 100644
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
+ * This page appears to control the fast link failure and there are different
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


