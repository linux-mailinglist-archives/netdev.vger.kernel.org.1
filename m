Return-Path: <netdev+bounces-123086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CABBC963A16
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 07:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 834D6283231
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 05:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB101158550;
	Thu, 29 Aug 2024 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="x80mFvCN"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2BA14EC5D;
	Thu, 29 Aug 2024 05:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910966; cv=none; b=C8F3WFCr1nIU7pMY44m156ml/JQJQMkz96O4WyJfTNsOtvebIXERVc3zcE78c7v2CYj6W8drCyiTnw0r+zN0VW0vzMnOInE7e8qLunM8raSlW3VA70BWgpAn/fA6VR55AuietBDJQKBgZRiJ65srtunDgCVwhLFEnU1VOI6839w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910966; c=relaxed/simple;
	bh=edEdCCAZtD0WOroumycbnXtVwzRb7i5enLvb6qOTwiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UB/cYqz+n6N995LjMItrjtpfzd142f7KaJTmMsfDUPb8+VdH4HFrGpbKuSjVSz45qWHx7KC66rKiPY9ioJwAb6gYhbBQoKHL2mJdfCbv9qL+i/tAQSiwfo9etFcaRxyphadnYawpMJj8b+pWxzSrbVU1YBVNU2NDX0TIPA9qOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=x80mFvCN; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1724910964; x=1756446964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=edEdCCAZtD0WOroumycbnXtVwzRb7i5enLvb6qOTwiY=;
  b=x80mFvCNLHomi3IbrFRdMZza1jrz2kVq8UV8XIiTyqyj1eSGDZsHf48z
   ZB2IdbqGb8N+qNcgsL4eB2cHXfiHAa7/ezShGXlC7lTyDvVavVJEVx7Ys
   eFi3sVRCc8XUwdjrP6t8hTKY5PvhWyknFMsts/EZln5rPFYuWHsM+JuNY
   6GcaRxr4Uk3ggy9e2NtjYSzqAkULoexVqxx93CVTD3HPcE8Mdz+rjbAsy
   GaerkJD6kSQs0gbGhxedyqcKsvg4wAq6j4oOvqKfYEJWlN9+VCYJrxzXa
   C9m4sa9nQ5f8b+HBjejOqB527+HITEJTUU1GusEqaSa1lUoSiCMPFC47s
   w==;
X-CSE-ConnectionGUID: 2MQclz5sT/+LITt4o2qSTg==
X-CSE-MsgGUID: K5PVPhOGSLuOfvvYjMWD5w==
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="261978661"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Aug 2024 22:56:00 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Aug 2024 22:55:41 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 28 Aug 2024 22:55:36 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux@armlinux.org.uk>, <kuba@kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <richardcochran@gmail.com>,
	<rdunlap@infradead.org>, <Bryan.Whitehead@microchip.com>,
	<edumazet@google.com>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>,
	<horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next V4 4/5] net: lan743x: Migrate phylib to phylink
Date: Thu, 29 Aug 2024 11:21:31 +0530
Message-ID: <20240829055132.79638-5-Raju.Lakkaraju@microchip.com>
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

Migrate phy support from phylib to phylink.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:                                                                    
============                                                                    
V3 -> V4:                                                                       
  - Add the Fixed-link by include the Russell King patch
  - Change lan743x_phylink_create( ) argument from netdev to adapter

V2 -> V3:                                                                       
  - Remove the unwanted parens in each of these if() sub-blocks                 
  - Replace "to_net_dev(config->dev)" with "netdev".                            
  - Add GMII_ID/RGMII_TXID/RGMII_RXID in supported_interfaces                   
  - Fix the lan743x_phy_handle_exists( ) return type

V1 -> V2:                                                                       
  - Split the PHYLINK and SFP changes in 2 different patch series                                                                  
 
 drivers/net/ethernet/microchip/Kconfig        |   5 +-
 drivers/net/ethernet/microchip/lan743x_main.c | 599 +++++++++++-------
 drivers/net/ethernet/microchip/lan743x_main.h |   3 +
 3 files changed, 382 insertions(+), 225 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 43ba71e82260..4b7a0433b7e5 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -46,12 +46,13 @@ config LAN743X
 	tristate "LAN743x support"
 	depends on PCI
 	depends on PTP_1588_CLOCK_OPTIONAL
-	select PHYLIB
 	select FIXED_PHY
 	select CRC16
 	select CRC32
+	select PHYLINK
 	help
-	  Support for the Microchip LAN743x PCI Express Gigabit Ethernet chip
+	  Support for the Microchip LAN743x and PCI11x1x families of PCI
+	  Express Ethernet devices
 
 	  To compile this driver as a module, choose M here. The module will be
 	  called lan743x.
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index b4a4c2840a83..91e74e231251 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -15,6 +15,7 @@
 #include <linux/rtnetlink.h>
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
+#include <linux/phylink.h>
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -1077,26 +1078,7 @@ static int lan743x_sgmii_2_5G_mode_set(struct lan743x_adapter *adapter,
 					      VR_MII_BAUD_RATE_1P25GBPS);
 }
 
-static int lan743x_is_sgmii_2_5G_mode(struct lan743x_adapter *adapter,
-				      bool *status)
-{
-	int ret;
-
-	ret = lan743x_sgmii_read(adapter, MDIO_MMD_VEND2,
-				 VR_MII_GEN2_4_MPLL_CTRL1);
-	if (ret < 0)
-		return ret;
-
-	if (ret == VR_MII_MPLL_MULTIPLIER_125 ||
-	    ret == VR_MII_MPLL_MULTIPLIER_50)
-		*status = true;
-	else
-		*status = false;
-
-	return 0;
-}
-
-static int lan743x_sgmii_aneg_update(struct lan743x_adapter *adapter)
+static int lan743x_serdes_clock_and_aneg_update(struct lan743x_adapter *adapter)
 {
 	enum lan743x_sgmii_lsd lsd = adapter->sgmii_lsd;
 	int mii_ctrl;
@@ -1211,49 +1193,6 @@ static int lan743x_pcs_power_reset(struct lan743x_adapter *adapter)
 	return lan743x_pcs_seq_state(adapter, PCS_POWER_STATE_UP);
 }
 
-static int lan743x_sgmii_config(struct lan743x_adapter *adapter)
-{
-	struct net_device *netdev = adapter->netdev;
-	struct phy_device *phydev = netdev->phydev;
-	bool status;
-	int ret;
-
-	ret = lan743x_get_lsd(phydev->speed, phydev->duplex,
-			      phydev->master_slave_state);
-	if (ret < 0) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "error %d link-speed-duplex(LSD) invalid\n", ret);
-		return ret;
-	}
-
-	adapter->sgmii_lsd = ret;
-	netif_dbg(adapter, drv, adapter->netdev,
-		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
-
-	ret = lan743x_sgmii_aneg_update(adapter);
-	if (ret < 0) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "error %d SGMII cfg failed\n", ret);
-		return ret;
-	}
-
-	ret = lan743x_is_sgmii_2_5G_mode(adapter, &status);
-	if (ret < 0) {
-		netif_err(adapter, drv, adapter->netdev,
-			  "error %d SGMII get mode failed\n", ret);
-		return ret;
-	}
-
-	if (status)
-		netif_dbg(adapter, drv, adapter->netdev,
-			  "SGMII 2.5G mode enable\n");
-	else
-		netif_dbg(adapter, drv, adapter->netdev,
-			  "SGMII 1G mode enable\n");
-
-	return lan743x_pcs_power_reset(adapter);
-}
-
 static void lan743x_mac_set_address(struct lan743x_adapter *adapter,
 				    u8 *addr)
 {
@@ -1407,103 +1346,11 @@ static int lan743x_phy_reset(struct lan743x_adapter *adapter)
 				  50000, 1000000);
 }
 
-static void lan743x_phy_update_flowcontrol(struct lan743x_adapter *adapter,
-					   u16 local_adv, u16 remote_adv)
-{
-	struct lan743x_phy *phy = &adapter->phy;
-	u8 cap;
-
-	if (phy->fc_autoneg)
-		cap = mii_resolve_flowctrl_fdx(local_adv, remote_adv);
-	else
-		cap = phy->fc_request_control;
-
-	lan743x_mac_flow_ctrl_set_enables(adapter,
-					  cap & FLOW_CTRL_TX,
-					  cap & FLOW_CTRL_RX);
-}
-
 static int lan743x_phy_init(struct lan743x_adapter *adapter)
 {
 	return lan743x_phy_reset(adapter);
 }
 
-static void lan743x_phy_link_status_change(struct net_device *netdev)
-{
-	struct lan743x_adapter *adapter = netdev_priv(netdev);
-	struct phy_device *phydev = netdev->phydev;
-	u32 data;
-
-	phy_print_status(phydev);
-	if (phydev->state == PHY_RUNNING) {
-		int remote_advertisement = 0;
-		int local_advertisement = 0;
-
-		data = lan743x_csr_read(adapter, MAC_CR);
-
-		/* set duplex mode */
-		if (phydev->duplex)
-			data |= MAC_CR_DPX_;
-		else
-			data &= ~MAC_CR_DPX_;
-
-		/* set bus speed */
-		switch (phydev->speed) {
-		case SPEED_10:
-			data &= ~MAC_CR_CFG_H_;
-			data &= ~MAC_CR_CFG_L_;
-		break;
-		case SPEED_100:
-			data &= ~MAC_CR_CFG_H_;
-			data |= MAC_CR_CFG_L_;
-		break;
-		case SPEED_1000:
-			data |= MAC_CR_CFG_H_;
-			data &= ~MAC_CR_CFG_L_;
-		break;
-		case SPEED_2500:
-			data |= MAC_CR_CFG_H_;
-			data |= MAC_CR_CFG_L_;
-		break;
-		}
-		lan743x_csr_write(adapter, MAC_CR, data);
-
-		local_advertisement =
-			linkmode_adv_to_mii_adv_t(phydev->advertising);
-		remote_advertisement =
-			linkmode_adv_to_mii_adv_t(phydev->lp_advertising);
-
-		lan743x_phy_update_flowcontrol(adapter, local_advertisement,
-					       remote_advertisement);
-		lan743x_ptp_update_latency(adapter, phydev->speed);
-		if (phydev->interface == PHY_INTERFACE_MODE_SGMII ||
-		    phydev->interface == PHY_INTERFACE_MODE_1000BASEX ||
-		    phydev->interface == PHY_INTERFACE_MODE_2500BASEX)
-			lan743x_sgmii_config(adapter);
-
-		data = lan743x_csr_read(adapter, MAC_CR);
-		if (phydev->enable_tx_lpi)
-			data |=  MAC_CR_EEE_EN_;
-		else
-			data &= ~MAC_CR_EEE_EN_;
-		lan743x_csr_write(adapter, MAC_CR, data);
-	}
-}
-
-static void lan743x_phy_close(struct lan743x_adapter *adapter)
-{
-	struct net_device *netdev = adapter->netdev;
-	struct phy_device *phydev = netdev->phydev;
-
-	phy_stop(netdev->phydev);
-	phy_disconnect(netdev->phydev);
-
-	/* using phydev here as phy_disconnect NULLs netdev->phydev */
-	if (phy_is_pseudo_fixed_link(phydev))
-		fixed_phy_unregister(phydev);
-
-}
-
 static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 {
 	u32 id_rev;
@@ -1520,65 +1367,9 @@ static void lan743x_phy_interface_select(struct lan743x_adapter *adapter)
 		adapter->phy_interface = PHY_INTERFACE_MODE_MII;
 	else
 		adapter->phy_interface = PHY_INTERFACE_MODE_RGMII;
-}
-
-static int lan743x_phy_open(struct lan743x_adapter *adapter)
-{
-	struct net_device *netdev = adapter->netdev;
-	struct lan743x_phy *phy = &adapter->phy;
-	struct fixed_phy_status fphy_status = {
-		.link = 1,
-		.speed = SPEED_1000,
-		.duplex = DUPLEX_FULL,
-	};
-	struct phy_device *phydev;
-	int ret = -EIO;
-
-	/* try devicetree phy, or fixed link */
-	phydev = of_phy_get_and_connect(netdev, adapter->pdev->dev.of_node,
-					lan743x_phy_link_status_change);
-
-	if (!phydev) {
-		/* try internal phy */
-		phydev = phy_find_first(adapter->mdiobus);
-		if (!phydev)	{
-			if ((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
-					ID_REV_ID_LAN7431_) {
-				phydev = fixed_phy_register(PHY_POLL,
-							    &fphy_status, NULL);
-				if (IS_ERR(phydev)) {
-					netdev_err(netdev, "No PHY/fixed_PHY found\n");
-					return PTR_ERR(phydev);
-				}
-			} else {
-				goto return_error;
-				}
-		}
 
-		lan743x_phy_interface_select(adapter);
-
-		ret = phy_connect_direct(netdev, phydev,
-					 lan743x_phy_link_status_change,
-					 adapter->phy_interface);
-		if (ret)
-			goto return_error;
-	}
-
-	/* MAC doesn't support 1000T Half */
-	phy_remove_link_mode(phydev, ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
-
-	/* support both flow controls */
-	phy_support_asym_pause(phydev);
-	phy->fc_request_control = (FLOW_CTRL_RX | FLOW_CTRL_TX);
-	phy->fc_autoneg = phydev->autoneg;
-
-	phy_start(phydev);
-	phy_start_aneg(phydev);
-	phy_attached_info(phydev);
-	return 0;
-
-return_error:
-	return ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "selected phy interface: 0x%X\n", adapter->phy_interface);
 }
 
 static void lan743x_rfe_open(struct lan743x_adapter *adapter)
@@ -3079,6 +2870,350 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 	return ret;
 }
 
+static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
+{
+	u32 sgmii_ctl;
+	int ret;
+
+	ret = lan743x_get_lsd(SPEED_1000, DUPLEX_FULL,
+			      MASTER_SLAVE_STATE_MASTER);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
+	}
+
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
+	/* LINK_STATUS_SOURCE from the External PHY via SGMII */
+	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+	sgmii_ctl &= ~SGMII_CTL_LINK_STATUS_SOURCE_;
+	lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+
+	ret = lan743x_serdes_clock_and_aneg_update(adapter);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d sgmii aneg update failed\n", ret);
+		return ret;
+	}
+
+	return lan743x_pcs_power_reset(adapter);
+}
+
+static int lan743x_phylink_1000basex_config(struct lan743x_adapter *adapter)
+{
+	u32 sgmii_ctl;
+	int ret;
+
+	ret = lan743x_get_lsd(SPEED_1000, DUPLEX_FULL,
+			      MASTER_SLAVE_STATE_MASTER);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
+	}
+
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
+	/* LINK_STATUS_SOURCE from 1000BASE-X PCS link status */
+	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+	sgmii_ctl |= SGMII_CTL_LINK_STATUS_SOURCE_;
+	lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+
+	ret = lan743x_serdes_clock_and_aneg_update(adapter);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d 1000basex aneg update failed\n", ret);
+		return ret;
+	}
+
+	return lan743x_pcs_power_reset(adapter);
+}
+
+static int lan743x_phylink_2500basex_config(struct lan743x_adapter *adapter)
+{
+	u32 sgmii_ctl;
+	int ret;
+
+	ret = lan743x_get_lsd(SPEED_2500, DUPLEX_FULL,
+			      MASTER_SLAVE_STATE_MASTER);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d link-speed-duplex(LSD) invalid\n", ret);
+		return ret;
+	}
+
+	adapter->sgmii_lsd = ret;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "Link Speed Duplex (lsd) : 0x%X\n", adapter->sgmii_lsd);
+
+	/* LINK_STATUS_SOURCE from 2500BASE-X PCS link status */
+	sgmii_ctl = lan743x_csr_read(adapter, SGMII_CTL);
+	sgmii_ctl |= SGMII_CTL_LINK_STATUS_SOURCE_;
+	lan743x_csr_write(adapter, SGMII_CTL, sgmii_ctl);
+
+	ret = lan743x_serdes_clock_and_aneg_update(adapter);
+	if (ret < 0) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "error %d 2500basex aneg update failed\n", ret);
+		return ret;
+	}
+
+	return lan743x_pcs_power_reset(adapter);
+}
+
+static void lan743x_phylink_mac_config(struct phylink_config *config,
+				       unsigned int link_an_mode,
+				       const struct phylink_link_state *state)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	int ret;
+
+	switch (state->interface) {
+	case PHY_INTERFACE_MODE_2500BASEX:
+		ret = lan743x_phylink_2500basex_config(adapter);
+		if (ret < 0)
+			netif_err(adapter, drv, adapter->netdev,
+				  "2500BASEX config failed. Error %d\n", ret);
+		else
+			netif_dbg(adapter, drv, adapter->netdev,
+				  "2500BASEX mode selected and configured\n");
+		break;
+	case PHY_INTERFACE_MODE_1000BASEX:
+		ret = lan743x_phylink_1000basex_config(adapter);
+		if (ret < 0)
+			netif_err(adapter, drv, adapter->netdev,
+				  "1000BASEX config failed. Error %d\n", ret);
+		else
+			netif_dbg(adapter, drv, adapter->netdev,
+				  "1000BASEX mode selected and configured\n");
+		break;
+	case PHY_INTERFACE_MODE_SGMII:
+		ret = lan743x_phylink_sgmii_config(adapter);
+		if (ret < 0)
+			netif_err(adapter, drv, adapter->netdev,
+				  "SGMII config failed. Error %d\n", ret);
+		else
+			netif_dbg(adapter, drv, adapter->netdev,
+				  "SGMII mode selected and configured\n");
+		break;
+	default:
+		netif_dbg(adapter, drv, adapter->netdev,
+			  "RGMII/GMII/MII(0x%X) mode enable\n", state->interface);
+		break;
+	}
+}
+
+static void lan743x_phylink_mac_link_down(struct phylink_config *config,
+					  unsigned int link_an_mode,
+					  phy_interface_t interface)
+{
+	netif_tx_stop_all_queues(to_net_dev(config->dev));
+}
+
+static void lan743x_phylink_mac_link_up(struct phylink_config *config,
+					struct phy_device *phydev,
+					unsigned int link_an_mode,
+					phy_interface_t interface,
+					int speed, int duplex,
+					bool tx_pause, bool rx_pause)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+	int mac_cr;
+	u8 cap;
+
+	mac_cr = lan743x_csr_read(adapter, MAC_CR);
+	/* Pre-initialize register bits.
+	 * Resulting value corresponds to SPEED_10
+	 */
+	mac_cr &= ~(MAC_CR_CFG_H_ | MAC_CR_CFG_L_);
+	if (speed == SPEED_2500)
+		mac_cr |= MAC_CR_CFG_H_ | MAC_CR_CFG_L_;
+	else if (speed == SPEED_1000)
+		mac_cr |= MAC_CR_CFG_H_;
+	else if (speed == SPEED_100)
+		mac_cr |= MAC_CR_CFG_L_;
+
+	lan743x_csr_write(adapter, MAC_CR, mac_cr);
+
+	lan743x_ptp_update_latency(adapter, speed);
+
+	/* Flow Control operation */
+	cap = 0;
+	if (tx_pause)
+		cap |= FLOW_CTRL_TX;
+	if (rx_pause)
+		cap |= FLOW_CTRL_RX;
+
+	lan743x_mac_flow_ctrl_set_enables(adapter,
+					  cap & FLOW_CTRL_TX,
+					  cap & FLOW_CTRL_RX);
+
+	netif_tx_wake_all_queues(netdev);
+}
+
+static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
+	.mac_config = lan743x_phylink_mac_config,
+	.mac_link_down = lan743x_phylink_mac_link_down,
+	.mac_link_up = lan743x_phylink_mac_link_up,
+};
+
+static struct {
+	unsigned long mask;
+	int speed;
+	int duplex;
+} lan743x_mac_caps_params[] = {
+	{ MAC_2500FD,	SPEED_2500,   DUPLEX_FULL },
+	{ MAC_1000FD,	SPEED_1000,   DUPLEX_FULL },
+	{ MAC_100FD,	SPEED_100,    DUPLEX_FULL },
+	{ MAC_10FD,	SPEED_10,     DUPLEX_FULL },
+	{ MAC_100HD,	SPEED_100,    DUPLEX_HALF },
+	{ MAC_10HD,	SPEED_10,     DUPLEX_HALF },
+};
+
+static int lan743x_find_max_speed(unsigned long caps, int *speed, int *duplex)
+{
+	int i;
+
+	*speed = SPEED_UNKNOWN;
+	*duplex = DUPLEX_UNKNOWN;
+	for (i = 0; i < ARRAY_SIZE(lan743x_mac_caps_params); i++) {
+		if (caps & lan743x_mac_caps_params[i].mask) {
+			*speed = lan743x_mac_caps_params[i].speed;
+			*duplex = lan743x_mac_caps_params[i].duplex;
+			break;
+		}
+	}
+
+	return *speed == SPEED_UNKNOWN ? -EINVAL : 0;
+}
+
+static int lan743x_phylink_create(struct lan743x_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct phylink *pl;
+
+	adapter->phylink_config.dev = &netdev->dev;
+	adapter->phylink_config.type = PHYLINK_NETDEV;
+	adapter->phylink_config.mac_managed_pm = false;
+
+	adapter->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
+		MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000FD;
+
+	lan743x_phy_interface_select(adapter);
+
+	switch (adapter->phy_interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  adapter->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+			  adapter->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+			  adapter->phylink_config.supported_interfaces);
+		adapter->phylink_config.mac_capabilities |= MAC_2500FD;
+		break;
+	case PHY_INTERFACE_MODE_GMII:
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  adapter->phylink_config.supported_interfaces);
+		break;
+	case PHY_INTERFACE_MODE_MII:
+		__set_bit(PHY_INTERFACE_MODE_MII,
+			  adapter->phylink_config.supported_interfaces);
+		break;
+	default:
+		phy_interface_set_rgmii(adapter->phylink_config.supported_interfaces);
+	}
+
+	pl = phylink_create(&adapter->phylink_config, NULL,
+			    adapter->phy_interface, &lan743x_phylink_mac_ops);
+
+	if (IS_ERR(pl)) {
+		netdev_err(netdev, "Could not create phylink (%pe)\n", pl);
+		return PTR_ERR(pl);
+	}
+
+	adapter->phylink = pl;
+	netdev_dbg(netdev, "lan743x phylink created");
+
+	return 0;
+}
+
+static bool lan743x_phy_handle_exists(struct device_node *dn)
+{
+	dn = of_parse_phandle(dn, "phy-handle", 0);
+	of_node_put(dn);
+	return dn != NULL;
+}
+
+static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
+{
+	struct device_node *dn = adapter->pdev->dev.of_node;
+	struct net_device *dev = adapter->netdev;
+	struct phy_device *phydev;
+	int ret;
+
+	if (dn)
+		ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
+
+	if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
+		phydev = phy_find_first(adapter->mdiobus);
+		if (phydev) {
+			/* attach the mac to the phy */
+			ret = phylink_connect_phy(adapter->phylink, phydev);
+		} else if (((adapter->csr.id_rev & ID_REV_ID_MASK_) ==
+			      ID_REV_ID_LAN7431_) || adapter->is_pci11x1x) {
+			struct phylink_link_state state;
+			unsigned long caps;
+
+			caps = adapter->phylink_config.mac_capabilities;
+			ret = lan743x_find_max_speed(caps, &state.speed,
+						     &state.duplex);
+			if (ret) {
+				netdev_err(dev, "find unknown speed (%d)\n",
+					   ret);
+				return ret;
+			}
+
+			ret = phylink_set_fixed_link(adapter->phylink, &state);
+			if (ret) {
+				netdev_err(dev, "Could not set fixed link\n");
+				return ret;
+			}
+		} else {
+			netdev_err(dev, "no PHY found\n");
+			return -ENXIO;
+		}
+	}
+
+	if (ret) {
+		netdev_err(dev, "Could not attach PHY (%d)\n", ret);
+		return ret;
+	}
+
+	phylink_start(adapter->phylink);
+
+	return 0;
+}
+
+static void lan743x_phylink_disconnect(struct lan743x_adapter *adapter)
+{
+	struct net_device *netdev = adapter->netdev;
+	struct phy_device *phydev = netdev->phydev;
+
+	phylink_stop(adapter->phylink);
+	phylink_disconnect_phy(adapter->phylink);
+
+	if (phydev)
+		if (phy_is_pseudo_fixed_link(phydev))
+			fixed_phy_unregister(phydev);
+}
+
 static int lan743x_netdev_close(struct net_device *netdev)
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
@@ -3092,7 +3227,7 @@ static int lan743x_netdev_close(struct net_device *netdev)
 
 	lan743x_ptp_close(adapter);
 
-	lan743x_phy_close(adapter);
+	lan743x_phylink_disconnect(adapter);
 
 	lan743x_mac_close(adapter);
 
@@ -3115,13 +3250,13 @@ static int lan743x_netdev_open(struct net_device *netdev)
 	if (ret)
 		goto close_intr;
 
-	ret = lan743x_phy_open(adapter);
+	ret = lan743x_phylink_connect(adapter);
 	if (ret)
 		goto close_mac;
 
 	ret = lan743x_ptp_open(adapter);
 	if (ret)
-		goto close_phy;
+		goto close_mac;
 
 	lan743x_rfe_open(adapter);
 
@@ -3161,9 +3296,8 @@ static int lan743x_netdev_open(struct net_device *netdev)
 			lan743x_rx_close(&adapter->rx[index]);
 	}
 	lan743x_ptp_close(adapter);
-
-close_phy:
-	lan743x_phy_close(adapter);
+	if (adapter->phylink)
+		lan743x_phylink_disconnect(adapter);
 
 close_mac:
 	lan743x_mac_close(adapter);
@@ -3192,11 +3326,14 @@ static netdev_tx_t lan743x_netdev_xmit_frame(struct sk_buff *skb,
 static int lan743x_netdev_ioctl(struct net_device *netdev,
 				struct ifreq *ifr, int cmd)
 {
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
 	if (!netif_running(netdev))
 		return -EINVAL;
 	if (cmd == SIOCSHWTSTAMP)
 		return lan743x_ptp_ioctl(netdev, ifr, cmd);
-	return phy_mii_ioctl(netdev->phydev, ifr, cmd);
+
+	return phylink_mii_ioctl(adapter->phylink, ifr, cmd);
 }
 
 static void lan743x_netdev_set_multicast(struct net_device *netdev)
@@ -3301,10 +3438,17 @@ static void lan743x_mdiobus_cleanup(struct lan743x_adapter *adapter)
 	mdiobus_unregister(adapter->mdiobus);
 }
 
+static void lan743x_destroy_phylink(struct lan743x_adapter *adapter)
+{
+	phylink_destroy(adapter->phylink);
+	adapter->phylink = NULL;
+}
+
 static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 {
 	unregister_netdev(adapter->netdev);
 
+	lan743x_destroy_phylink(adapter);
 	lan743x_mdiobus_cleanup(adapter);
 	lan743x_hardware_cleanup(adapter);
 	lan743x_pci_cleanup(adapter);
@@ -3518,14 +3662,21 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 				    NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	adapter->netdev->hw_features = adapter->netdev->features;
 
-	/* carrier off reporting is important to ethtool even BEFORE open */
-	netif_carrier_off(netdev);
+	ret = lan743x_phylink_create(adapter);
+	if (ret < 0) {
+		netif_err(adapter, probe, netdev,
+			  "failed to setup phylink (%d)\n", ret);
+		goto cleanup_mdiobus;
+	}
 
 	ret = register_netdev(adapter->netdev);
 	if (ret < 0)
-		goto cleanup_mdiobus;
+		goto cleanup_phylink;
 	return 0;
 
+cleanup_phylink:
+	lan743x_destroy_phylink(adapter);
+
 cleanup_mdiobus:
 	lan743x_mdiobus_cleanup(adapter);
 
@@ -3781,6 +3932,7 @@ static int lan743x_pm_resume(struct device *dev)
 	       MAC_WK_SRC_WK_FR_SAVED_;
 	lan743x_csr_write(adapter, MAC_WK_SRC, data);
 
+	rtnl_lock();
 	/* open netdev when netdev is at running state while resume.
 	 * For instance, it is true when system wakesup after pm-suspend
 	 * However, it is false when system wakes up after suspend GUI menu
@@ -3789,6 +3941,7 @@ static int lan743x_pm_resume(struct device *dev)
 		lan743x_netdev_open(netdev);
 
 	netif_device_attach(netdev);
+	rtnl_unlock();
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 3b2585a384e2..7f73d66854be 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -5,6 +5,7 @@
 #define _LAN743X_H
 
 #include <linux/phy.h>
+#include <linux/phylink.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -1083,6 +1084,8 @@ struct lan743x_adapter {
 	u32			flags;
 	u32			hw_cfg;
 	phy_interface_t		phy_interface;
+	struct phylink		*phylink;
+	struct phylink_config	phylink_config;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


