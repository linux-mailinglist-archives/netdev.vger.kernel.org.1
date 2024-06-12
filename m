Return-Path: <netdev+bounces-102959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FE99059E2
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 19:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDCA283284
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 17:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BA71822FF;
	Wed, 12 Jun 2024 17:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="McFqGSFj"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D541822D2;
	Wed, 12 Jun 2024 17:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213337; cv=none; b=Cs7prT0vc1aoyuGEBEgShh1olT6sgYw7JZOuRyZAAcjH6fGXFQ0SN1/OhtfHylHixHaXv9CnxmCzXZdwYJDPC3qnxteBDgxe2HYGFyvgwgNn2lGIuWaY9inbyKiZBena5/RBcGng7RQCDfKhHu+PwEtFEMgDESEaogZyo7VCkCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213337; c=relaxed/simple;
	bh=MRgRTR5p5l3UILYskd9d2TrX4KZPn/4uGWX/PfQ7Zf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pmA2nRA75euDeIRx+mh8HQtipHwseW2hFsKaeiVs2VG46G4/CUCi504nPz+GxgZrTIeZpn3RZt9Il/regX9RGfIOOmFiBino9Ui/QWF3hhjtftY9WuP/Rksrw4t1//174FZx4YT8EA9gHQnOpFqQcRHgJN6ns+nmZXlkeBsbqr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=McFqGSFj; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718213335; x=1749749335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MRgRTR5p5l3UILYskd9d2TrX4KZPn/4uGWX/PfQ7Zf8=;
  b=McFqGSFjhbfWplj4Bz8nAuuf9jZ10qmrsJz26uXwacLx1n1+GZRT0c9o
   HfzWU/I2XXkouoNsmEJmdovBw/RROudeqLAnSjZM0yJtp6HISCHn54012
   vCKNGan7UCcuLZWE+ylGgJgpw0bqWyiTCaYyP2cj+Eaj97CGnnzRxE/28
   prMmnSrkY2Z7Swy1vGU4fFbO2IZ98cmU2Feo94nKBNabEejZ6zFLCGiZK
   /E5UL5h8V2fOu9vCqGcLBF6dxzb5udVxoJaMjN6wmPIkQ+0y3qIrwx65l
   sz/koccALQ4R9Ni2L8B4JYVSa0g5X+QNT87tfdA5wPCsyMRzHxAwNYfMl
   Q==;
X-CSE-ConnectionGUID: kQJR97/CQB64mCyFSlUH9g==
X-CSE-MsgGUID: xzMLbVX+TVO8pXX/N7EH3w==
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="258194653"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2024 10:28:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Jun 2024 10:28:45 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 12 Jun 2024 10:28:39 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
	<bryan.whitehead@microchip.com>, <andrew@lunn.ch>, <linux@armlinux.org.uk>,
	<sbauer@blackbox.su>, <hmehrtens@maxlinear.com>, <lxu@maxlinear.com>,
	<hkallweit1@gmail.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<wojciech.drewek@intel.com>, <UNGLinuxDriver@microchip.com>, "kernel test
 robot" <lkp@intel.com>
Subject: [PATCH net V4 2/3] net: lan743x: Support WOL at both the PHY and MAC appropriately
Date: Wed, 12 Jun 2024 22:55:38 +0530
Message-ID: <20240612172539.28565-3-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
References: <20240612172539.28565-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Prevent options not supported by the PHY from being requested to it by the MAC
Whenever a WOL option is supported by both, the PHY is given priority
since that usually leads to better power savings.

Fixes: e9e13b6adc338 ("lan743x: fix for potential NULL pointer dereference with bare card")
Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406052200.w3zuc32H-lkp@intel.com/
---
Change List:
------------
V3 -> V4:
  - Fix the support for "CONFIG_PM=N" 
V2 -> V3:
  - Remove the "phy does not support WOL" debug message which is not required
  - Remove WAKE_PHY support option from Ethernet MAC (LAN743x/PCI11x1x) driver
  - Add "phy_wol_supported" and "phy_wolopts" variables to hold PHY's WOL config
V1 -> V2:
  - Repost - No change
V0 -> V1:
  - Change the "phy does not support WOL" print from netif_info() to
    netif_dbg()

 .../net/ethernet/microchip/lan743x_ethtool.c  | 44 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.c | 18 ++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  4 ++
 3 files changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index d0f4ff4ee075..0d1740d64676 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -1127,8 +1127,12 @@ static void lan743x_ethtool_get_wol(struct net_device *netdev,
 	if (netdev->phydev)
 		phy_ethtool_get_wol(netdev->phydev, wol);
 
-	wol->supported |= WAKE_BCAST | WAKE_UCAST | WAKE_MCAST |
-		WAKE_MAGIC | WAKE_PHY | WAKE_ARP;
+	if (wol->supported != adapter->phy_wol_supported)
+		netif_warn(adapter, drv, adapter->netdev,
+			   "PHY changed its supported WOL! old=%x, new=%x\n",
+			   adapter->phy_wol_supported, wol->supported);
+
+	wol->supported |= MAC_SUPPORTED_WAKES;
 
 	if (adapter->is_pci11x1x)
 		wol->supported |= WAKE_MAGICSECURE;
@@ -1143,7 +1147,39 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 {
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
+	/* WAKE_MAGICSEGURE is a modifier of and only valid together with
+	 * WAKE_MAGIC
+	 */
+	if ((wol->wolopts & WAKE_MAGICSECURE) && !(wol->wolopts & WAKE_MAGIC))
+		return -EINVAL;
+
+	if (netdev->phydev) {
+		struct ethtool_wolinfo phy_wol;
+		int ret;
+
+		phy_wol.wolopts = wol->wolopts & adapter->phy_wol_supported;
+
+		/* If WAKE_MAGICSECURE was requested, filter out WAKE_MAGIC
+		 * for PHYs that do not support WAKE_MAGICSECURE
+		 */
+		if (wol->wolopts & WAKE_MAGICSECURE &&
+		    !(adapter->phy_wol_supported & WAKE_MAGICSECURE))
+			phy_wol.wolopts &= ~WAKE_MAGIC;
+
+		ret = phy_ethtool_set_wol(netdev->phydev, &phy_wol);
+		if (ret && (ret != -EOPNOTSUPP))
+			return ret;
+
+		if (ret == -EOPNOTSUPP)
+			adapter->phy_wolopts = 0;
+		else
+			adapter->phy_wolopts = phy_wol.wolopts;
+	} else {
+		adapter->phy_wolopts = 0;
+	}
+
 	adapter->wolopts = 0;
+	wol->wolopts &= ~adapter->phy_wolopts;
 	if (wol->wolopts & WAKE_UCAST)
 		adapter->wolopts |= WAKE_UCAST;
 	if (wol->wolopts & WAKE_MCAST)
@@ -1164,10 +1200,10 @@ static int lan743x_ethtool_set_wol(struct net_device *netdev,
 		memset(adapter->sopass, 0, sizeof(u8) * SOPASS_MAX);
 	}
 
+	wol->wolopts = adapter->wolopts | adapter->phy_wolopts;
 	device_set_wakeup_enable(&adapter->pdev->dev, (bool)wol->wolopts);
 
-	return netdev->phydev ? phy_ethtool_set_wol(netdev->phydev, wol)
-			: -ENETDOWN;
+	return 0;
 }
 #endif /* CONFIG_PM */
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 6a40b961fafb..90572e780d9f 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3118,6 +3118,17 @@ static int lan743x_netdev_open(struct net_device *netdev)
 		if (ret)
 			goto close_tx;
 	}
+
+#ifdef CONFIG_PM
+	if (adapter->netdev->phydev) {
+		struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
+
+		phy_ethtool_get_wol(netdev->phydev, &wol);
+		adapter->phy_wol_supported = wol.supported;
+		adapter->phy_wolopts = wol.wolopts;
+	}
+#endif
+
 	return 0;
 
 close_tx:
@@ -3587,10 +3598,9 @@ static void lan743x_pm_set_wol(struct lan743x_adapter *adapter)
 
 	pmtctl |= PMT_CTL_ETH_PHY_D3_COLD_OVR_ | PMT_CTL_ETH_PHY_D3_OVR_;
 
-	if (adapter->wolopts & WAKE_PHY) {
-		pmtctl |= PMT_CTL_ETH_PHY_EDPD_PLL_CTL_;
+	if (adapter->phy_wolopts)
 		pmtctl |= PMT_CTL_ETH_PHY_WAKE_EN_;
-	}
+
 	if (adapter->wolopts & WAKE_MAGIC) {
 		wucsr |= MAC_WUCSR_MPEN_;
 		macrx |= MAC_RX_RXEN_;
@@ -3686,7 +3696,7 @@ static int lan743x_pm_suspend(struct device *dev)
 	lan743x_csr_write(adapter, MAC_WUCSR2, 0);
 	lan743x_csr_write(adapter, MAC_WK_SRC, 0xFFFFFFFF);
 
-	if (adapter->wolopts)
+	if (adapter->wolopts || adapter->phy_wolopts)
 		lan743x_pm_set_wol(adapter);
 
 	if (adapter->is_pci11x1x) {
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index fac0f33d10b2..3b2585a384e2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1042,6 +1042,8 @@ enum lan743x_sgmii_lsd {
 	LINK_2500_SLAVE
 };
 
+#define MAC_SUPPORTED_WAKES  (WAKE_BCAST | WAKE_UCAST | WAKE_MCAST | \
+			      WAKE_MAGIC | WAKE_ARP)
 struct lan743x_adapter {
 	struct net_device       *netdev;
 	struct mii_bus		*mdiobus;
@@ -1049,6 +1051,8 @@ struct lan743x_adapter {
 #ifdef CONFIG_PM
 	u32			wolopts;
 	u8			sopass[SOPASS_MAX];
+	u32			phy_wolopts;
+	u32			phy_wol_supported;
 #endif
 	struct pci_dev		*pdev;
 	struct lan743x_csr      csr;
-- 
2.34.1


