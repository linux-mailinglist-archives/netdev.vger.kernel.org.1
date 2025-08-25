Return-Path: <netdev+bounces-216408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35DEB33707
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 09:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFDF177C29
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 07:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100C288513;
	Mon, 25 Aug 2025 07:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g0NkESml"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A92882C9;
	Mon, 25 Aug 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105224; cv=none; b=EduBwzK02qX6OXYRBWSJykOo9oKNMzA+xZgsdnKRPJj4XJeMXiwiJq7ExMsQ2eA++LOCzX6o3hKg46Cu/NeQqXt71VIjBpK5tq3oB2OGspjyS54Ax+dRzLCAdnNwo6TJ7knKs7A2zaZhIy5WYUe/YGWj1zED0cqUJ0WqjAPgHwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105224; c=relaxed/simple;
	bh=M9DdtMppJEOnfLbFcRRL0+dJkP45g7dKObfDHa3BZ+4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GJW1H6lLkz8+etvJ9DwoAAwzewYsrVkBVOaag3AJIJxVDyfZ1udgoTThH9GL6S83BGzak5zzUY5hUQC/RdWsGKPyCqeXQUCUOw3b1V1LYNU44gqZb4Wpr4phvHvH8lvUOtBzN3qGFn4+qLngnbH1wDbBQcxNlR+BDt3QH7fGv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g0NkESml; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756105223; x=1787641223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M9DdtMppJEOnfLbFcRRL0+dJkP45g7dKObfDHa3BZ+4=;
  b=g0NkESmlPCgRgoHNoJdZ4B7R/GNiwjdznoXOWSnacsBbTM5JKUnJoT7t
   QWCuuwCgiMpTADbRt8v9ekrbUpcFqx8kxFVbns+9XPDfhdtzOrsYfo1K6
   P/sHeSzrfXH99JEm0VfLMRdJTSoyq+3TQhl9yafe69XL26ulCiE03wGBI
   fGPoXGqs55LCrl+JGF8TVnKc3X7YfeWhK+X9lULOg2EIRVEUXALbPi7sZ
   jAv+VJvPev7qphqx64v/mrtmYOiN/pdr/UUUC5QjJJIpa3wXV6qjtWg4N
   Tk1a53AThdbMTsjee3pv7USP6RIghOeAWLW21ga90VCvXPX5wZsqi7+XO
   w==;
X-CSE-ConnectionGUID: S2m4b2uJQ2uL0XJDsEcpSQ==
X-CSE-MsgGUID: KhUbRrPbS0WOF8bnRqfyeQ==
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="276992244"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 00:00:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 24 Aug 2025 23:59:55 -0700
Received: from DEN-DL-M31836.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Sun, 24 Aug 2025 23:59:51 -0700
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <vladimir.oltean@nxp.com>,
	<rmk+kernel@armlinux.org.uk>, <vadim.fedorenko@linux.dev>,
	<christophe.jaillet@wanadoo.fr>, <rosenp@gmail.com>,
	<viro@zeniv.linux.org.uk>, <atenart@kernel.org>, <quentin.schulz@bootlin.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Horatiu Vultur
	<horatiu.vultur@microchip.com>
Subject: [PATCH net v2] phy: mscc: Fix when PTP clock is register and unregister
Date: Mon, 25 Aug 2025 08:55:43 +0200
Message-ID: <20250825065543.2916334-1-horatiu.vultur@microchip.com>
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
v1->v2:
- move implementation of __vsc8584_deinit_ptp into vsc8584_ptp_deinit
- drop the PHY matching and check if ptp_clock is valid.
---
 drivers/net/phy/mscc/mscc.h      |  4 ++++
 drivers/net/phy/mscc/mscc_main.c |  4 +---
 drivers/net/phy/mscc/mscc_ptp.c  | 34 ++++++++++++++++++++------------
 3 files changed, 26 insertions(+), 16 deletions(-)

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
index de6c7312e8f29..72847320cb652 100644
--- a/drivers/net/phy/mscc/mscc_ptp.c
+++ b/drivers/net/phy/mscc/mscc_ptp.c
@@ -1298,7 +1298,6 @@ static void vsc8584_set_input_clk_configured(struct phy_device *phydev)
 
 static int __vsc8584_init_ptp(struct phy_device *phydev)
 {
-	struct vsc8531_private *vsc8531 = phydev->priv;
 	static const u32 ltc_seq_e[] = { 0, 400000, 0, 0, 0 };
 	static const u8  ltc_seq_a[] = { 8, 6, 5, 4, 2 };
 	u32 val;
@@ -1515,17 +1514,7 @@ static int __vsc8584_init_ptp(struct phy_device *phydev)
 
 	vsc85xx_ts_eth_cmp1_sig(phydev);
 
-	vsc8531->mii_ts.rxtstamp = vsc85xx_rxtstamp;
-	vsc8531->mii_ts.txtstamp = vsc85xx_txtstamp;
-	vsc8531->mii_ts.hwtstamp = vsc85xx_hwtstamp;
-	vsc8531->mii_ts.ts_info  = vsc85xx_ts_info;
-	phydev->mii_ts = &vsc8531->mii_ts;
-
-	memcpy(&vsc8531->ptp->caps, &vsc85xx_clk_caps, sizeof(vsc85xx_clk_caps));
-
-	vsc8531->ptp->ptp_clock = ptp_clock_register(&vsc8531->ptp->caps,
-						     &phydev->mdio.dev);
-	return PTR_ERR_OR_ZERO(vsc8531->ptp->ptp_clock);
+	return 0;
 }
 
 void vsc8584_config_ts_intr(struct phy_device *phydev)
@@ -1552,6 +1541,16 @@ int vsc8584_ptp_init(struct phy_device *phydev)
 	return 0;
 }
 
+void vsc8584_ptp_deinit(struct phy_device *phydev)
+{
+	struct vsc8531_private *vsc8531 = phydev->priv;
+
+	if (vsc8531->ptp->ptp_clock) {
+		ptp_clock_unregister(vsc8531->ptp->ptp_clock);
+		skb_queue_purge(&vsc8531->rx_skbs_list);
+	}
+}
+
 irqreturn_t vsc8584_handle_ts_interrupt(struct phy_device *phydev)
 {
 	struct vsc8531_private *priv = phydev->priv;
@@ -1612,7 +1611,16 @@ int vsc8584_ptp_probe(struct phy_device *phydev)
 
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


