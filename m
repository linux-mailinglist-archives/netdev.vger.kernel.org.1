Return-Path: <netdev+bounces-127467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D459E975806
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001791C25FDD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088C41AE852;
	Wed, 11 Sep 2024 16:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rEBXGX1N"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1901AC885;
	Wed, 11 Sep 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071317; cv=none; b=Cg3NNRJq47wEeN5FDHmhGXhfczCulk7hCo8PtD3dGV2H6PlS0gFh2XWiiWCpEGwJVWogUJ9tu/7Fr7HslNkewDAdhqdernwsoDf2Og4/8rCXKFQQL/4hFtpxiTyV85gKOsxprYcGsQSgtL7DlcaszcZW9YlfTNrs7vQEKXiV3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071317; c=relaxed/simple;
	bh=ftM+DDnmQmOYnwN5aQVtFV0dJlz1AGJWP+A1i0WPDNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sS+sXpWHY+PQNkm9l9X1/kCVlVJF2Zad2t5/XUnNBN2WAPXLaDQ3WK9H+gdbPCBaTm3GEn1ePCR0E5odkxyictuD9yL3IUbKjqupHFi3K1iJYhNjg9F031kxmci4A1hksdNJUw0azzYJ7Fp5FKcnlE76OLSeRZGrr8P23sMlANM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rEBXGX1N; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1726071316; x=1757607316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ftM+DDnmQmOYnwN5aQVtFV0dJlz1AGJWP+A1i0WPDNQ=;
  b=rEBXGX1N4OLxZX09J2SWsuc3MdXPWTViQQJAyNFuEZWnkVCemVIXFJLS
   1TwvuG+BcTIHUB+lL/q5tcndaILSXePdTZocxFIaD0hLLfPyCvyF4inuU
   nqPSDAUPwYHf/bKGMHE5gP9oQfPm1lIfeqt+cDvs6jwA0iNd8XbDh1BUk
   3PeeK9bCmIfCCW/ktSTeyOzcdvTbJpuWiBlHs56epUf9E5QDifzkFh7w1
   JJSqEnaKUp0QtT+gaZMg8Z+Hyvo9fItTYtmzSmql0El1Ou7UR5BuWdB8Z
   iFT4NMNHSzXdeVgcsAgcd3ELpvwx0xH3uMOzPuyBSf+WNh2aIgeZ3+tmX
   w==;
X-CSE-ConnectionGUID: I+zUQG3KSiiiwGtN22Ixjw==
X-CSE-MsgGUID: c072b4IOQiqRjevIyY933Q==
X-IronPort-AV: E=Sophos;i="6.10,220,1719903600"; 
   d="scan'208";a="32280151"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2024 09:15:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 11 Sep 2024 09:15:10 -0700
Received: from HYD-DK-UNGSW21.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 11 Sep 2024 09:15:05 -0700
From: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>, <andrew@lunn.ch>,
	<Steen.Hegelund@microchip.com>, <Raju.Lakkaraju@microchip.com>,
	<daniel.machon@microchip.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Date: Wed, 11 Sep 2024 21:40:53 +0530
Message-ID: <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Register MDIO bus for PCS layer to use Synopsys designware XPCS, support
SGMII/1000Base-X/2500Base-X interfaces.

Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
---
Change List:
============                                                                    
V2 : Include this new patch in the V2 series. 

 drivers/net/ethernet/microchip/Kconfig        |  1 +
 drivers/net/ethernet/microchip/lan743x_main.c | 72 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  2 +
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index 3dacf39b49b4..793a20ef51fc 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -53,6 +53,7 @@ config LAN743X
 	select I2C_PCI1XXXX
 	select GP_PCI1XXXX
 	select SFP
+	select PCS_XPCS
 	help
 	  Support for the Microchip LAN743x and PCI11x1x families of PCI
 	  Express Ethernet devices
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index c1061e2972f9..ef76d0c1642f 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -1143,6 +1143,28 @@ static int lan743x_get_lsd(int speed, int duplex, u8 mss)
 	return lsd;
 }
 
+static int pci11x1x_pcs_read(struct mii_bus *bus, int addr, int devnum,
+			     int regnum)
+{
+	struct lan743x_adapter *adapter = bus->priv;
+
+	if (addr)
+		return -EOPNOTSUPP;
+
+	return lan743x_sgmii_read(adapter, devnum, regnum);
+}
+
+static int pci11x1x_pcs_write(struct mii_bus *bus, int addr, int devnum,
+			      int regnum, u16 val)
+{
+	struct lan743x_adapter *adapter = bus->priv;
+
+	if (addr)
+		return -EOPNOTSUPP;
+
+	return lan743x_sgmii_write(adapter, devnum, regnum, val);
+}
+
 static int lan743x_sgmii_mpll_set(struct lan743x_adapter *adapter,
 				  u16 baud)
 {
@@ -3201,6 +3223,19 @@ void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable)
 	lan743x_csr_write(adapter, MAC_CR, mac_cr);
 }
 
+static struct phylink_pcs *
+lan743x_phylink_mac_select_pcs(struct phylink_config *config,
+			       phy_interface_t interface)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	if (adapter->xpcs)
+		return &adapter->xpcs->pcs;
+
+	return NULL;
+}
+
 static void lan743x_phylink_mac_config(struct phylink_config *config,
 				       unsigned int link_an_mode,
 				       const struct phylink_link_state *state)
@@ -3302,6 +3337,7 @@ static void lan743x_phylink_mac_link_up(struct phylink_config *config,
 }
 
 static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
+	.mac_select_pcs = lan743x_phylink_mac_select_pcs,
 	.mac_config = lan743x_phylink_mac_config,
 	.mac_link_down = lan743x_phylink_mac_link_down,
 	.mac_link_up = lan743x_phylink_mac_link_up,
@@ -3654,6 +3690,9 @@ static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
 
 static void lan743x_mdiobus_cleanup(struct lan743x_adapter *adapter)
 {
+	if (adapter->xpcs)
+		xpcs_destroy(adapter->xpcs);
+
 	mdiobus_unregister(adapter->mdiobus);
 }
 
@@ -3763,6 +3802,7 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 
 static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 {
+	struct dw_xpcs *xpcs;
 	u32 sgmii_ctl;
 	int ret;
 
@@ -3783,8 +3823,17 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 				  "SGMII operation\n");
 			adapter->mdiobus->read = lan743x_mdiobus_read_c22;
 			adapter->mdiobus->write = lan743x_mdiobus_write_c22;
-			adapter->mdiobus->read_c45 = lan743x_mdiobus_read_c45;
-			adapter->mdiobus->write_c45 = lan743x_mdiobus_write_c45;
+			if (adapter->is_sfp_support_en) {
+				adapter->mdiobus->read_c45 =
+					pci11x1x_pcs_read;
+				adapter->mdiobus->write_c45 =
+					pci11x1x_pcs_write;
+			} else {
+				adapter->mdiobus->read_c45 =
+					 lan743x_mdiobus_read_c45;
+				adapter->mdiobus->write_c45 =
+					 lan743x_mdiobus_write_c45;
+			}
 			adapter->mdiobus->name = "lan743x-mdiobus-c45";
 			netif_dbg(adapter, drv, adapter->netdev,
 				  "lan743x-mdiobus-c45\n");
@@ -3820,9 +3869,28 @@ static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 	ret = mdiobus_register(adapter->mdiobus);
 	if (ret < 0)
 		goto return_error;
+
+	if (adapter->is_sfp_support_en) {
+		if (!adapter->phy_interface)
+			lan743x_phy_interface_select(adapter);
+
+		xpcs = xpcs_create_mdiodev(adapter->mdiobus, 0,
+					   adapter->phy_interface);
+		if (IS_ERR(xpcs)) {
+			netdev_err(adapter->netdev, "failed to create xpcs\n");
+			ret = PTR_ERR(xpcs);
+			goto err_destroy_xpcs;
+		}
+		adapter->xpcs = xpcs;
+	}
+
 	return 0;
 
+err_destroy_xpcs:
+	xpcs_destroy(xpcs);
+
 return_error:
+	mdiobus_free(adapter->mdiobus);
 	return ret;
 }
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index c303a69c3bea..f7480a401a27 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -10,6 +10,7 @@
 #include <linux/i2c.h>
 #include <linux/gpio/machine.h>
 #include <linux/auxiliary_bus.h>
+#include <linux/pcs/pcs-xpcs.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
@@ -1130,6 +1131,7 @@ struct lan743x_adapter {
 	struct lan743x_sw_nodes	*nodes;
 	struct i2c_adapter	*i2c_adap;
 	struct platform_device	*sfp_dev;
+	struct dw_xpcs		*xpcs;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


