Return-Path: <netdev+bounces-124929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE5A96B634
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:12:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924851C214DE
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0CC1CF5D6;
	Wed,  4 Sep 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B+br5T+0"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139619AD89;
	Wed,  4 Sep 2024 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441080; cv=none; b=DQohU3emka0TyfdyL5EPGbpmHDcYnoO16XLXLW1vtl3p0XWgd2bRUPZjuoRYhywBJk9Mcfsy9LdvzzabUlyO2AzuKlf0QdBS9sob1dYT1P7fNEHwv38+Y6DuNWU/8hTlog2FHQwX2nKhF3pBp0LdJ9aNgtHW68SClt+Y1jFLgmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441080; c=relaxed/simple;
	bh=PUkcYl/seWgseM60RLAmotsm2QswUHcF/Bj2xdQP2hE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D9ukzt7J2vnJ7h1Gt/4u+GsFUEgdRyGTI1bnMdqt1rSfDKL1oPi9Eh4xzXL3j4IbM++b9CDyydNG/cxwvtYnSjezqXu145PMiVvq+yUIuXo+k76gizhQSSaVmYdo7//iWnDIbw/u0YSHCUFPsM4oJ06sbdlq8/q6NTEsDNlIbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B+br5T+0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725441078; x=1756977078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUkcYl/seWgseM60RLAmotsm2QswUHcF/Bj2xdQP2hE=;
  b=B+br5T+00UIAi+BAhggzGBP0WYLtsRe2GOp43wNclcnzilZKPugT8m7U
   62oE1DisjoG2tbwrjc/ib60KXFM+T/8HFo77ywSf/hQ/YfZ3SjOwkgmFJ
   sizh/1QfFTLwLb2vWqVTnCbkccuiyzTsG+Oow44qUgplJ+4AcPGQ/okXe
   I0/D3UfjMXl/ZMWU3ZMPiJ7sFJXfmY0PYh0fUn7FnoOw1zGJNR89bPZXq
   vZ1LmfWgLCkeM1x6IHE2h+2L8KjqnAWnMcOdx/NvSPxPgQco6qiLiY7Ro
   in7tbL6eq+SHImOdFF/Zv3u+10vzg+n9l2Xv1zYRZun7Q2LQNpnbyEkau
   A==;
X-CSE-ConnectionGUID: Zssh7PajQKmY7BC0+cjNqg==
X-CSE-MsgGUID: t/Kmb7n6TXOGd6aZGBC5gQ==
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="31212950"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Sep 2024 02:11:17 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 4 Sep 2024 02:11:02 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 4 Sep 2024 02:10:57 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <bryan.whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <maxime.chevallier@bootlin.com>,
	<linux-kernel@vger.kernel.org>, <horms@kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V5 5/5] net: lan743x: Add support to ethtool phylink get and set settings
Date: Wed, 4 Sep 2024 14:36:45 +0530
Message-ID: <20240904090645.8742-6-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
References: <20240904090645.8742-1-Raju.Lakkaraju@microchip.com>
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
V4 -> V5:
  - Remove the "phydev->eee_enabled" check to update the MAC EEE                
    enable/disable
  - Call lan743x_mac_eee_enable() with true after update tx_lpi_timer.
  - Add phy_support_eee() to initialize the EEE flags
V3 -> V4:
  - Remove the EEE private variables from LAN743x adapter strcture and fix the   
    EEE's set/get functions
  - Change lan743x_set_eee( ) to lan743x_mac_eee_enable( )
  - Fix the EEE's tx lpi counter update
V2 -> V3:
  - No change
V1 -> V2:                                                                       
  - Fix the phylink changes                                                                  

 .../net/ethernet/microchip/lan743x_ethtool.c  | 119 ++++++------------
 drivers/net/ethernet/microchip/lan743x_main.c |  22 ++++
 drivers/net/ethernet/microchip/lan743x_main.h |   1 +
 3 files changed, 63 insertions(+), 79 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 3a63ec091413..574b492b25c3 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1058,61 +1058,51 @@ static int lan743x_ethtool_get_eee(struct net_device *netdev,
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
+		 * eee will be reenabled during link up if eee was negotiated.
+		 */
+		lan743x_mac_eee_enable(adapter, false);
+		lan743x_csr_write(adapter, MAC_EEE_TX_LPI_REQ_DLY_CNT,
+				  eee->tx_lpi_timer);
+		lan743x_mac_eee_enable(adapter, true);
 	}
 
-	return 0;
+	return phylink_ethtool_set_eee(adapter->phylink, eee);
 }
 
-static int lan743x_ethtool_set_eee(struct net_device *netdev,
-				   struct ethtool_keee *eee)
+static int
+lan743x_ethtool_set_link_ksettings(struct net_device *netdev,
+				   const struct ethtool_link_ksettings *cmd)
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
+static int
+lan743x_ethtool_get_link_ksettings(struct net_device *netdev,
+				   struct ethtool_link_ksettings *cmd)
+{
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
-	return phy_ethtool_set_eee(phydev, eee);
+	return phylink_ethtool_ksettings_get(adapter->phylink, cmd);
 }
 
 #ifdef CONFIG_PM
@@ -1124,8 +1114,7 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
 	wol->supported = 0;
 	wol->wolopts = 0;
 
-	if (netdev->phydev)
-		phy_ethtool_get_wol(netdev->phydev, wol);
+	phylink_ethtool_get_wol(adapter->phylink, wol);
 
 	if (wol->supported != adapter->phy_wol_supported)
 		netif_warn(adapter, drv, adapter->netdev,
@@ -1166,7 +1155,7 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 		    !(adapter->phy_wol_supported & WAKE_MAGICSECURE))
 			phy_wol.wolopts &= ~WAKE_MAGIC;
 
-		ret = phy_ethtool_set_wol(netdev->phydev, &phy_wol);
+		ret = phylink_ethtool_set_wol(adapter->phylink, wol);
 		if (ret && (ret != -EOPNOTSUPP))
 			return ret;
 
@@ -1355,44 +1344,16 @@ static void lan743x_get_pauseparam(struct net_device *dev,
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
@@ -1417,8 +1378,8 @@ const struct ethtool_ops lan743x_ethtool_ops = {
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
index 2da05c50fe53..ff78239eb121 100644
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
@@ -3014,7 +3026,11 @@ static void lan743x_phylink_mac_link_down(struct phylink_config *config,
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
@@ -3056,6 +3072,9 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 					  cap & FLOW_CTRL_TX,
 					  cap & FLOW_CTRL_RX);
 
+	if (phydev)
+		lan743x_mac_eee_enable(adapter, phydev->enable_tx_lpi);
+
 	netif_tx_wake_all_queues(netdev);
 }
 
@@ -3265,6 +3284,9 @@ static int lan743x_netdev_open(struct net_device *netdev)
 			goto close_tx;
 	}
 
+	if (netdev->phydev)
+		phy_support_eee(netdev->phydev);
+
 #ifdef CONFIG_PM
 	if (adapter->netdev->phydev) {
 		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
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


