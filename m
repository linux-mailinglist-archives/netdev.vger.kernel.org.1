Return-Path: <netdev+bounces-215584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E1B2F5A9
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 12:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE337AE0C4
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE353093DB;
	Thu, 21 Aug 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="iUzuca7u"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA576308F35;
	Thu, 21 Aug 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773494; cv=none; b=laNydgR40UO/yFp+LOCBSuJDiWqDHtjKAg6zolzqKo779+u8fhN+/TwNT5A4Hvb6MjjREO/iyknNY3lk0tvd6tPSXmmZBWZio7mKb9IRhvtKzsglPotEhb0Q8oDUfcu6E2pNhxgWkYhZ/XEXJWdyFZy654p5N7kUzONpPRm6SBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773494; c=relaxed/simple;
	bh=KHvuHVpT8XLrB8kkvREiSYcjY5lHv8A1nlW+gWH/5H8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m5NTxZB+CYir41SvY35gj4se9u91A/kGSAiRWFU6JR8YvtMs1iMHx5r+nrVXawl7e+wlhPHlT/IuZIlUu8ba4UnBGzR1t0v286D3krDh3JvbjSauVpIgF4Fs5q8r/h8YIxzGElQUgF6PUX0xhuVcnJGGpGcg3cb5WfO5IoUmonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=iUzuca7u; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1755773492; x=1787309492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KHvuHVpT8XLrB8kkvREiSYcjY5lHv8A1nlW+gWH/5H8=;
  b=iUzuca7uruZLMUAiio2XuCgKMu+6lV9GtR+sZRBHuQp6D/y9x82N/ge2
   s3A+gIqQmf4hGeBZad6hGW6x4FilynMXGPZjWYI2tNvdd3PWTz0lZdfBR
   9Pk/rX2e0bYnbM+WYn92JOHwGtB+7Zh8nX91Owex4CBBB73+/I0FbKz64
   3hlyvONMO//DemUhJ+KYF7EeGqXjX7tJYJaIsDrpAlxFosauYko2VO83Q
   6pEtLVp3Gjg4CLIQDMLcmaw/eO/WqLG9Vt9Vjjr2rjs4ksIRALZgKUuM6
   Obnt7qlqlz4KXHvvFLvPBABwgd/pfnIIWVcHr5vc+WqaZ9KCnP/u9UBWE
   w==;
X-CSE-ConnectionGUID: +qjVfyXuTYuMLQY71/8fbw==
X-CSE-MsgGUID: aNC6yLbjRH6jginZxGGdSg==
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="212904275"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2025 03:51:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 21 Aug 2025 03:50:44 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 21 Aug 2025 03:50:41 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vadim.fedorenko@linux.dev>,
	<vladimir.oltean@nxp.com>, <rmk+kernel@armlinux.org.uk>, <rosenp@gmail.com>,
	<christophe.jaillet@wanadoo.fr>, <viro@zeniv.linux.org.uk>,
	<atenart@kernel.org>, <quentin.schulz@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net] phy: mscc: Fix when PTP clock is register and unregister
Date: Thu, 21 Aug 2025 12:46:28 +0200
Message-ID: <20250821104628.2329569-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

It looks like that every time when the interface was set down and up the
driver was creating a new ptp clock. On top of this the function
ptp_clock_unregister was never called.
Therefore fix this by calling ptp_clock_register and initialize the
mii_ts struct inside the probe function and call ptp_clock_unregister when
driver is removed.

Fixes: 7d272e63e0979d ("net: phy: mscc: timestamping and PHC support")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/net/phy/mscc/mscc.h      |  4 ++++
 drivers/net/phy/mscc/mscc_main.c |  4 +---
 drivers/net/phy/mscc/mscc_ptp.c  | 40 +++++++++++++++++++++++---------
 3 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
index b8c6ba7c7834e..2d8eca54c40a2 100644
--- a/drivers/net/phy/mscc/mscc.h
+++ b/drivers/net/phy/mscc/mscc.h
@@ -484,6 +484,7 @@ static inline void vsc8584_config_macsec_intr(struct phy_device *phydev)
 void vsc85xx_link_change_notify(struct phy_device *phydev);
 void vsc8584_config_ts_intr(struct phy_device *phydev);
 int vsc8584_ptp_init(struct phy_device *phydev);
+void vsc8584_ptp_deinit(struct phy_device *phydev);
 int vsc8584_ptp_probe_once(struct phy_device *phydev);
 int vsc8584_ptp_probe(struct phy_device *phydev);
 irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev);
@@ -498,6 +499,9 @@ static inline int vsc8584_ptp_init(struct phy_device *phydev)
 {
 	return 0;
 }
+static inline void vsc8584_ptp_deinit(struct phy_device *phydev)
+{
+}
 static inline int vsc8584_ptp_probe_once(struct phy_device *phydev)
 {
 	return 0;
diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 800da302ae632..a034a8a8dde51 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -2370,9 +2370,7 @@ static int vsc85xx_probe(struct phy_device *phydev)
 
 static void vsc85xx_remove(struct phy_device *phydev)
 {
-	struct vsc8531_private *priv = phydev->priv;
-
-	skb_queue_purge(&priv->rx_skbs_list);
+	vsc8584_ptp_deinit(phydev);
 }
 
 /* Microsemi VSC85xx PHYs */
diff --git a/drivers/net/phy/mscc/mscc_ptp.c b/drivers/net/phy/mscc/mscc_ptp.c
index de6c7312e8f29..827c399d9d30f 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1298,7 +1298,6 @@ static void vsc8584_set_input_clk_configured(struct phy_device *phydev)
 
 static int __vsc8584_init_ptp(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531 = phydev->priv;
 	static const u32 ltc_seq_e[] = { 0, 400000, 0, 0, 0 };
 	static const u8  ltc_seq_a[] = { 8, 6, 5, 4, 2 };
 	u32 val;
@@ -1515,17 +1514,15 @@ static int __vsc8584_init_ptp(struct phy_device *phydev)
 
 	vsc85xx_ts_eth_cmp1_sig(phydev);
 
-	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
-	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
-	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
-	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
-	phydev->mii_ts = &vsc8531->mii_ts;
+	return 0;
+}
 
-	memcpy(&vsc8531->ptp->caps, &vsc85xx_clk_caps, sizeof(vsc85xx_clk_caps));
+static void __vsc8584_deinit_ptp(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
 
-	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
-						     &phydev->mdio.dev);
-	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
+	ptp_clock_unregister(vsc8531->ptp->ptp_clock);
+	skb_queue_purge(&vsc8531->rx_skbs_list);
 }
 
 void vsc8584_config_ts_intr(struct phy_device *phydev)
@@ -1552,6 +1549,18 @@ int vsc8584_ptp_init(struct phy_device *phydev)
 	return 0;
 }
 
+void vsc8584_ptp_deinit(struct phy_device *phydev)
+{
+	switch (phydev->phy_id & phydev->drv->phy_id_mask) {
+	case PHY_ID_VSC8572:
+	case PHY_ID_VSC8574:
+	case PHY_ID_VSC8575:
+	case PHY_ID_VSC8582:
+	case PHY_ID_VSC8584:
+		return __vsc8584_deinit_ptp(phydev);
+	}
+}
+
 irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 {
 	struct vsc8531_private *priv = phydev->priv;
@@ -1612,7 +1621,16 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
 	vsc8531->ptp->phydev = phydev;
 
-	return 0;
+	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
+	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
+	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
+	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
+	phydev->mii_ts = &vsc8531->mii_ts;
+
+	memcpy(&vsc8531->ptp->caps, &vsc85xx_clk_caps, sizeof(vsc85xx_clk_caps));
+	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
+						     &phydev->mdio.dev);
+	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
 }
 
 int vsc8584_ptp_probe_once(struct phy_device *phydev)
-- 
2.34.1


