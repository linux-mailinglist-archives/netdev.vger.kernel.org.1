Return-Path: <netdev+bounces-123088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A26963A1D
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B401F21D45
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C9215FA75;
	Thu, 29 Aug 2024 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="06ZlPsrv"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411DF14B96B;
	Thu, 29 Aug 2024 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910985; cv=none; b=SrO6JKW3JKFiYUhbPrwsihPU5zwuGW0ow7gK6XULN7s1OhFpCswLcsjRk1Y95dvci/joFa7MqeZ0+6eATcD8uxWdipYqcU10FXhyGM+dE25qfLLl6f9Faz/pQ8VpKCYSc8yMfDWBQXnay5BDRx1QvA5pm8CQIBkkexhWqvbIy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910985; c=relaxed/simple;
	bh=cw/BYcOiJlwss0j8ZGlMCUaXf/1vQpLWbZscjXoqqR4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CeBqDF+v83OLUMNS06L37dcHrGDXxFjTp1fOct8ihvUp0fKhWNOzhSsz1HXS6EkXIAItfSlO47XiNYsAiGhpXxtnuaI4dvjqdi6EvF/V2hwHykKI89+QQgSxmRc/DYqYkCiZL2M2iHkBsxHz3Ioxt0YIu6I9uAVfZvRgo4+Yh94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=06ZlPsrv; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724910983; x=1756446983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cw/BYcOiJlwss0j8ZGlMCUaXf/1vQpLWbZscjXoqqR4=;
  b=06ZlPsrvyC3IkdRBv2qudkMk0tHhUC7MRbPG9RpwHLd7WzehtCYgiqR/
   OZ0qAVbEon01fjlB+zWUG8FOollVUafT04nw9slSD++Vxes4Z35Rv8Ox0
   pUfo1cxHfJU2aB4yh3GKmPklKeKDtwgW6nlUv79sPGqX+STPxp/Csapg1
   6YBCDsKhDJx3mQWF+esfd4JrcKtAPEgJQgzGX9hy4mEaxvqek1W3ASI34
   mcogGjUr6pKc4UvTUI321R+QHmiVS8QbQlZS/DGr7v9VDpMgaSnUBGn5T
   Dpb6plfclxYybTwrWDkC5V3GtqR1vUFcN36BPUyipI976QXTCcu5vRgVS
   Q==;
X-CSE-ConnectionGUID: OqQ8UWHzRieRXsYt6b8OmA==
X-CSE-MsgGUID: FB9RCfzeROiLzjHvHs4bVQ==
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="30971353"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 22:56:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Aug 2024 22:55:44 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 28 Aug 2024 22:55:42 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V4 5/5] net: lan743x: Add support to ethtool phylink get and set settings
Date: Thu, 29 Aug 2024 11:21:32 +0530
Message-ID: <20240829055132.79638-6-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
References: <20240829055132.79638-1-Raju.Lakkaraju@microchip.com>
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
V3 -> V4:
  - Remove the EEE private variables from LAN743x adapter strcture and fix the   
    EEE's set/get functions
  - Change lan743x_set_eee( ) to lan743x_mac_eee_enable( )
  - Fix the EEE's tx lpi counter update
V2 -> V3:
  - No change
V1 -> V2:                                                                       
  - Fix the phylink changes                                                                  
 
 .../net/ethernet/microchip/lan743x_ethtool.c  | 117 ++++++------------
 drivers/net/ethernet/microchip/lan743x_main.c |  20 +++
 drivers/net/ethernet/microchip/lan743x_main.h |   1 +
 3 files changed, 59 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 3a63ec091413..b15b52d53e84 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1058,61 +1058,49 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
 				   struct ethtool_keee *eee)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	struct phy_device *phydev = netdev->phydev;
-	u32 buf;
-	int ret;
 
-	if (!phydev)
-		return -EIO;
-	if (!phydev->drv) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "Missing PHY Driver\n");
-		return -EIO;
-	}
+	eee->tx_lpi_timer = lan743x_csr_read(adapter,
+					     MAC_EEE_TX_LPI_REQ_DLY_CNT);
 
-	ret = phy_ethtool_get_eee(phydev, eee);
-	if (ret < 0)
-		return ret;
+	return phylink_ethtool_get_eee(adapter->phylink, eee);
+}
 
-	buf = lan743x_csr_read(adapter, MAC_CR);
-	if (buf & MAC_CR_EEE_EN_) {
-		/* EEE_TX_LPI_REQ_DLY & tx_lpi_timer are same uSec unit */
-		buf = lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
-		eee->tx_lpi_timer = buf;
-	} else {
-		eee->tx_lpi_timer = 0;
+static int lan743x_ethtool_set_eee(struct net_device *netdev,
+				   struct ethtool_keee *eee)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	u32 tx_lpi_timer;
+
+	tx_lpi_timer = lan743x_csr_read(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT);
+	if (tx_lpi_timer != eee->tx_lpi_timer) {
+		/* Software should only change this field when Energy Efficient
+		 * Ethernet Enable (EEEEN) is cleared.
+		 * This function will trigger an autonegotiation restart and
+		 * that eee will be reenabled during link up if eee was
+		 * negotiated.
+		 */
+		lan743x_mac_eee_enable(adapter, false);
+		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT,
+				  eee->tx_lpi_timer);
 	}
 
-	return 0;
+	return phylink_ethtool_set_eee(adapter->phylink, eee);
 }
 
-static int lan743x_ethtool_set_eee(struct net_device *netdev,
-				   struct ethtool_keee *eee)
+static int lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
+					      const struct ethtool_link_ksettings *cmd)
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
+	return phylink_ethtool_ksettings_set(adapter->phylink, cmd);
+}
 
-	if (eee->eee_enabled) {
-		buf = (u32)eee->tx_lpi_timer;
-		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT, buf);
-	}
+static int lan743x_ethtool_get_link_ksettings(struct net_device *netdev,
+					      struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
-	return phy_ethtool_set_eee(phydev, eee);
+	return phylink_ethtool_ksettings_get(adapter->phylink, cmd);
 }
 
 #ifdef CONFIG_PM
@@ -1124,8 +1112,7 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
 	wol->supported = 0;
 	wol->wolopts = 0;
 
-	if (netdev->phydev)
-		phy_ethtool_get_wol(netdev->phydev, wol);
+	phylink_ethtool_get_wol(adapter->phylink, wol);
 
 	if (wol->supported != adapter->phy_wol_supported)
 		netif_warn(adapter, drv, adapter->netdev,
@@ -1166,7 +1153,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 		    !(adapter->phy_wol_supported & WAKE_MAGICSECURE))
 			phy_wol.wolopts &= ~WAKE_MAGIC;
 
-		ret = phy_ethtool_set_wol(netdev->phydev, &phy_wol);
+		ret = phylink_ethtool_set_wol(adapter->phylink, wol);
 		if (ret && (ret != -EOPNOTSUPP))
 			return ret;
 
@@ -1355,44 +1342,16 @@ static void lan743x_get_pauseparam(struct net_device *dev,
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
@@ -1417,8 +1376,8 @@ const struct ethtool_ops lan743x_ethtool_ops = {
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
index 91e74e231251..9c18e025a28d 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2966,6 +2966,18 @@ static int lan743x_phylink_2500basex_config(struct lan743x_adapter *adapter)
 	return lan743x_pcs_power_reset(adapter);
 }
 
+void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable)
+{
+	u32 mac_cr;
+
+	mac_cr = lan743x_csr_read(adapter, MAC_CR);
+	if (enable)
+		mac_cr |= MAC_CR_EEE_EN_;
+	else
+		mac_cr &= ~MAC_CR_EEE_EN_;
+	lan743x_csr_write(adapter, MAC_CR, mac_cr);
+}
+
 static void lan743x_phylink_mac_config(struct phylink_config *config,
 				       unsigned int link_an_mode,
 				       const struct phylink_link_state *state)
@@ -3013,7 +3025,11 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
 					  unsigned int link_an_mode,
 					  phy_interface_t interface)
 {
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
 	netif_tx_stop_all_queues(to_net_dev(config->dev));
+	lan743x_mac_eee_enable(adapter, false);
 }
 
 static void lan743x_phylink_mac_link_up(struct phylink_config *config,
@@ -3055,6 +3071,10 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 					  cap & FLOW_CTRL_TX,
 					  cap & FLOW_CTRL_RX);
 
+	if (phydev)
+		lan743x_mac_eee_enable(adapter, phydev->enable_tx_lpi &&
+				       phydev->eee_enabled);
+
 	netif_tx_wake_all_queues(netdev);
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 7f73d66854be..8ef897c114d3 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1206,5 +1206,6 @@ void lan743x_hs_syslock_release(struct lan743x_adapter *adapter);
 void lan743x_mac_flow_ctrl_set_enables(struct lan743x_adapter *adapter,
 				       bool tx_enable, bool rx_enable);
 int lan743x_sgmii_read(struct lan743x_adapter *adapter, u8 mmd, u16 addr);
+void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable);
 
 #endif /* _LAN743X_H */
-- 
2.34.1


