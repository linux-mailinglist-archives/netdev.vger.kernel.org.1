Return-Path: <netdev+bounces-111732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F29F9325D4
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9261E1C2255D
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 11:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAC21993A3;
	Tue, 16 Jul 2024 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="GZlVBzWs"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060B198857;
	Tue, 16 Jul 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129878; cv=none; b=dIKoqJ3yA74UDQQIc+1WMvksVzSmN4gwoOM52CgWNHDUFMiGkqorxJqIOySxG3AoCRJAJag/R5KdIgHXeWmyI/Ie8pQYWd4/QiL3AVQHwMaBeVd290U76Mht8ZF6y76r7UMKsD/CI8B8NQ54KjZLDwBYAq6bB1bie+Y5ax2S1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129878; c=relaxed/simple;
	bh=xUnUMlUWDf1KmmCsMCJr89D3W9fr3ciE/oq41kkHucg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRdLu/sY1RYe+SZDox0Xahjjo+fQouOexBXsqG1x8NNP7ng1ZdQ8tlheiLBYlGi29AZaB5LE/BS3fsIK5lLxQKx7C21GMS6Ayr2WKICsasBiJFz7xcXwo/PJDFsjqvSp/cK1LGA+ljN4YMuR2Eew2NsJynLDlSeDcx0+ZdIPPJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=GZlVBzWs; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721129876; x=1752665876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUnUMlUWDf1KmmCsMCJr89D3W9fr3ciE/oq41kkHucg=;
  b=GZlVBzWseHxSK8vDKDtFTRRS0qmJ8/SL1wfGAaLcQWaO7yEIpt5o07vx
   EfXWUI6iMuO1K5uIhgdLE/KuiXVNrvkruTzKyJHYvjgCAypR/b/i/tEpB
   en9RDdB5oQaF6rDy4CMlV78+cIFdPtkc2ty4xwwimzA6+ws/01kIdVUKG
   I7+AXwo4WEr5LX5q8ue7SY8lLx/+JNRO2dDCTwTsSehro+x0rwbbgQy9+
   C9KG7f+BiEzYNSWrboyTLFK4wNU3P66tBivSTBQUX4BudUgirK7JAqBO6
   Cam781c+Rm481PYrpG5rkbFDOuouDnsBLc8akC52+LDBGfkztEVYl2cft
   w==;
X-CSE-ConnectionGUID: cfaeIL7IRUGLMl9e3xGUlQ==
X-CSE-MsgGUID: 4LSU1cQjSF+hLYLVjjPdkg==
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; 
   d="scan'208";a="32002847"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2024 04:37:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jul 2024 04:37:36 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jul 2024 04:37:31 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <andrew@lunn.ch>,
	<horms@kernel.org>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <linux@armlinux.org.uk>,
	<bryan.whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V2 4/4] net: lan743x: Add support to ethtool phylink get and set settings
Date: Tue, 16 Jul 2024 17:03:49 +0530
Message-ID: <20240716113349.25527-5-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
References: <20240716113349.25527-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add support to ethtool phylink functions:
  - get/set settings like speed, duplex etc
  - get/set the wake-on-lan (WOL)
  - get/set the energy-efficient ethernet (EEE)
  - get/set the pause

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:                                                                    
============                                                                    
V1 -> V2:                                                                       
  - Fix the phylink changes                                                                  
 
 .../net/ethernet/microchip/lan743x_ethtool.c  | 118 ++++++------------
 drivers/net/ethernet/microchip/lan743x_main.c |  25 ++++
 drivers/net/ethernet/microchip/lan743x_main.h |   4 +
 3 files changed, 67 insertions(+), 80 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 3a63ec091413..a649ea7442a4 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1058,61 +1058,48 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
 				   struct ethtool_keee *eee)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	struct phy_device *phydev = netdev->phydev;
-	u32 buf;
-	int ret;
-
-	if (!phydev)
-		return -EIO;
-	if (!phydev->drv) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "Missing PHY Driver\n");
-		return -EIO;
-	}
 
-	ret = phy_ethtool_get_eee(phydev, eee);
-	if (ret < 0)
-		return ret;
-
-	buf = lan743x_csr_read(adapter, MAC_CR);
-	if (buf & MAC_CR_EEE_EN_) {
-		/* EEE_TX_LPI_REQ_DLY & tx_lpi_timer are same uSec unit */
-		buf = lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
-		eee->tx_lpi_timer = buf;
-	} else {
-		eee->tx_lpi_timer = 0;
-	}
+	eee->tx_lpi_timer = lan743x_csr_read(adapter,
+					     MAC_EEE_TX_LPI_REQ_DLY_CNT);
+	eee->eee_enabled = adapter->eee_enabled;
+	eee->eee_active = adapter->eee_active;
+	eee->tx_lpi_enabled = adapter->tx_lpi_enabled;
 
-	return 0;
+	return phylink_ethtool_get_eee(adapter->phylink, eee);
 }
 
 static int lan743x_ethtool_set_eee(struct net_device *netdev,
 				   struct ethtool_keee *eee)
 {
-	struct lan743x_adapter *adapter;
-	struct phy_device *phydev;
-	u32 buf = 0;
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
-	if (!netdev)
-		return -EINVAL;
-	adapter = netdev_priv(netdev);
-	if (!adapter)
-		return -EINVAL;
-	phydev = netdev->phydev;
-	if (!phydev)
-		return -EIO;
-	if (!phydev->drv) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "Missing PHY Driver\n");
-		return -EIO;
-	}
+	if (eee->tx_lpi_enabled)
+		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT,
+				  eee->tx_lpi_timer);
+	else
+		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, 0);
 
-	if (eee->eee_enabled) {
-		buf = (u32)eee->tx_lpi_timer;
-		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, buf);
-	}
+	adapter->eee_enabled = eee->eee_enabled;
+	adapter->tx_lpi_enabled = eee->tx_lpi_enabled;
+	lan743x_set_eee(adapter, eee->tx_lpi_enabled && eee->eee_enabled);
 
-	return phy_ethtool_set_eee(phydev, eee);
+	return phylink_ethtool_set_eee(adapter->phylink, eee);
+}
+
+static int lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
+					      const struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_set(adapter->phylink, cmd);
+}
+
+static int lan743x_ethtool_get_link_ksettings(struct net_device *netdev,
+					      struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	return phylink_ethtool_ksettings_get(adapter->phylink, cmd);
 }
 
 #ifdef CONFIG_PM
@@ -1124,8 +1111,7 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
 	wol->supported = 0;
 	wol->wolopts = 0;
 
-	if (netdev->phydev)
-		phy_ethtool_get_wol(netdev->phydev, wol);
+	phylink_ethtool_get_wol(adapter->phylink, wol);
 
 	if (wol->supported != adapter->phy_wol_supported)
 		netif_warn(adapter, drv, adapter->netdev,
@@ -1166,7 +1152,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 		    !(adapter->phy_wol_supported & WAKE_MAGICSECURE))
 			phy_wol.wolopts &= ~WAKE_MAGIC;
 
-		ret = phy_ethtool_set_wol(netdev->phydev, &phy_wol);
+		ret = phylink_ethtool_set_wol(adapter->phylink, wol);
 		if (ret && (ret != -EOPNOTSUPP))
 			return ret;
 
@@ -1355,44 +1341,16 @@ static void lan743x_get_pauseparam(struct net_device *dev,
 				   struct ethtool_pauseparam *pause)
 {
 	struct lan743x_adapter *adapter = netdev_priv(dev);
-	struct lan743x_phy *phy = &adapter->phy;
 
-	if (phy->fc_request_control & FLOW_CTRL_TX)
-		pause->tx_pause = 1;
-	if (phy->fc_request_control & FLOW_CTRL_RX)
-		pause->rx_pause = 1;
-	pause->autoneg = phy->fc_autoneg;
+	phylink_ethtool_get_pauseparam(adapter->phylink, pause);
 }
 
 static int lan743x_set_pauseparam(struct net_device *dev,
 				  struct ethtool_pauseparam *pause)
 {
 	struct lan743x_adapter *adapter = netdev_priv(dev);
-	struct phy_device *phydev = dev->phydev;
-	struct lan743x_phy *phy = &adapter->phy;
 
-	if (!phydev)
-		return -ENODEV;
-
-	if (!phy_validate_pause(phydev, pause))
-		return -EINVAL;
-
-	phy->fc_request_control = 0;
-	if (pause->rx_pause)
-		phy->fc_request_control |= FLOW_CTRL_RX;
-
-	if (pause->tx_pause)
-		phy->fc_request_control |= FLOW_CTRL_TX;
-
-	phy->fc_autoneg = pause->autoneg;
-
-	if (pause->autoneg == AUTONEG_DISABLE)
-		lan743x_mac_flow_ctrl_set_enables(adapter, pause->tx_pause,
-						  pause->rx_pause);
-	else
-		phy_set_asym_pause(phydev, pause->rx_pause,  pause->tx_pause);
-
-	return 0;
+	return phylink_ethtool_set_pauseparam(adapter->phylink, pause);
 }
 
 const struct ethtool_ops lan743x_ethtool_ops = {
@@ -1417,8 +1375,8 @@ const struct ethtool_ops lan743x_ethtool_ops = {
 	.get_ts_info = lan743x_ethtool_get_ts_info,
 	.get_eee = lan743x_ethtool_get_eee,
 	.set_eee = lan743x_ethtool_set_eee,
-	.get_link_ksettings = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings = phy_ethtool_set_link_ksettings,
+	.get_link_ksettings = lan743x_ethtool_get_link_ksettings,
+	.set_link_ksettings = lan743x_ethtool_set_link_ksettings,
 	.get_regs_len = lan743x_get_regs_len,
 	.get_regs = lan743x_get_regs,
 	.get_pauseparam = lan743x_get_pauseparam,
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 9f958fb27bd8..40ef64fa7e5f 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2966,6 +2966,18 @@ static int lan743x_phylink_2500basex_config(struct lan743x_adapter *adapter)
 	return lan743x_pcs_power_reset(adapter);
 }
 
+void lan743x_set_eee(struct lan743x_adapter *adapter, bool enable)
+{
+	u32 lpi_ctl1;
+
+	lpi_ctl1 = lan743x_csr_read(adapter, MAC_CR);
+	if (enable)
+		lpi_ctl1 |= MAC_CR_EEE_EN_;
+	else
+		lpi_ctl1 &= ~MAC_CR_EEE_EN_;
+	lan743x_csr_write(adapter, MAC_CR, lpi_ctl1);
+}
+
 static void lan743x_phylink_mac_config(struct phylink_config *config,
 				       unsigned int link_an_mode,
 				       const struct phylink_link_state *state)
@@ -3013,7 +3025,12 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
 					  unsigned int link_an_mode,
 					  phy_interface_t interface)
 {
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
 	netif_tx_stop_all_queues(to_net_dev(config->dev));
+	adapter->eee_active = false;
+	lan743x_set_eee(adapter, false);
 }
 
 static void lan743x_phylink_mac_link_up(struct phylink_config *config,
@@ -3056,6 +3073,14 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 					  cap & FLOW_CTRL_RX);
 
 	netif_tx_wake_all_queues(to_net_dev(config->dev));
+
+	if (phydev && adapter->eee_enabled) {
+		bool enable;
+
+		adapter->eee_active = phy_init_eee(phydev, false) >= 0;
+		enable = adapter->eee_active && adapter->tx_lpi_enabled;
+		lan743x_set_eee(adapter, enable);
+	}
 }
 
 static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 7f73d66854be..79f21789eb32 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1086,6 +1086,9 @@ struct lan743x_adapter {
 	phy_interface_t		phy_interface;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
+	bool eee_enabled;
+	bool eee_active;
+	bool tx_lpi_enabled;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
@@ -1206,5 +1209,6 @@ void lan743x_hs_syslock_release(struct lan743x_adapter *adapter);
 void lan743x_mac_flow_ctrl_set_enables(struct lan743x_adapter *adapter,
 				       bool tx_enable, bool rx_enable);
 int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr);
+void lan743x_set_eee(struct lan743x_adapter *adapter, bool enable);
 
 #endif /* _LAN743X_H */
-- 
2.34.1


