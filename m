Return-Path: <netdev+bounces-287928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJF3HBqqBWpyZgIAu9opvQ
	(envelope-from <netdev+bounces-287928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:55:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E12540A92
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83195309B0C7
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A13BE631;
	Thu, 14 May 2026 10:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ckGOYb3E"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040363BB687;
	Thu, 14 May 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755877; cv=none; b=OX7+DwEZsmrGaXbLNdnKhp91kxsoM9oUAGqbGHMB3838UQqTUby2qd1uLeKwoH8DiIf4YamcBzFaJoBnRJ253ZuHUO+ntEQb4H3qfZ6vfkaWfgSHrClzQJxhgj3w1zeKS7UyAVhHVN+cIQ6Y34CVY9UTmr5GM0Ew5snyPJHtP2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755877; c=relaxed/simple;
	bh=GLC1Dg4DAQYOUX5stTUxmUbQS2csfmdPXEjjgpMel0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMbTCeq89KUoc6WH21Oeslf7Q+BGP3JExnZOXVv/JbEHZpDI970+u9VnywwfdcUZtB6t5m2zEtlf2Et6h6x9M697FUardKVJZGK5qmkPvyU3msNCkPCVoUOVrIl+rnYATxG9DbMFoujuWIGk+9ij03+h0TW7gt7J/PD6f2EXsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ckGOYb3E; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778755876; x=1810291876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GLC1Dg4DAQYOUX5stTUxmUbQS2csfmdPXEjjgpMel0c=;
  b=ckGOYb3EzZ8VOZdSS5YYDoAKLQb9WBSFVUnGd4v4/Bdi7S3YlhNHUtTU
   efa4rNtdDgyHxBJCq0tSZXsw+2tFeTkdWoFDXxPGWikPp7eNzGEY7WHrE
   5VnY06dm7I6I7GE6NiaX5qnrrej9b6rSCCiF/8FmqfUxkYhLiKM6Dd2G1
   t9ImyRbs4Eh6iRq+rPje3JWApG9mVGxVl9UBNPVwrJ8TD8oc3pAqLzX2I
   3arGQ65XDetktXGLuuEIcx/neBNmDUIM85Lz7ETxZeSsSs1OwYAtJQzdL
   ypvNRk7T1CxJXNpIYDOc3mc/EE/RGDfkl9awROh0Md26IXa1z5btGinfl
   g==;
X-CSE-ConnectionGUID: kYThZSFMTzyTA5rtXI+lEw==
X-CSE-MsgGUID: h4zf1VzfQ0OdptI4p7gMkg==
X-IronPort-AV: E=Sophos;i="6.23,234,1770620400"; 
   d="scan'208";a="57503058"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 03:51:15 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 14 May 2026 03:51:14 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 14 May 2026 03:51:11 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/5] net: lan743x: Add PCS/XPCS support for SFP on PCI11x1x
Date: Thu, 14 May 2026 16:20:28 +0530
Message-ID: <20260514105028.42942-6-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260514105028.42942-1-thangaraj.s@microchip.com>
References: <20260514105028.42942-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: D4E12540A92
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-287928-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:mid,microchip.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a PCS MII bus and XPCS instance to support SFP modules on PCI11x1x
platforms.

Register a dedicated mdiobus for PCS access when SFP support is enabled
and initialize it with C45 read/write callbacks wired to the internal
SGMII access functions. Set phy_mask to ~0 to prevent the MDIO bus scan
from probing internal SGMII registers as PHY addresses.

Integrate the XPCS instance with phylink by providing a mac_select_pcs
callback. Support SGMII and 2.5GBASE-X interfaces in phylink, allowing
proper link configuration for SFP modules.

Cleanup the PCS mdiobus and XPCS instance during driver removal. Update
adapter structure to hold PCS mdiobus and XPCS references.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 92 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  5 +
 2 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 649065c36434..72f135fba8e2 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -15,7 +15,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
-#include <linux/phylink.h>
 
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
@@ -1192,6 +1191,28 @@ static int lan743x_get_lsd(int speed, int duplex, u8 mss)
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
@@ -3268,6 +3289,18 @@ static void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable)
 	lan743x_csr_write(adapter, MAC_CR, mac_cr);
 }
 
+static struct phylink_pcs *lan743x_phylink_mac_select(struct phylink_config *config,
+						      phy_interface_t interface)
+{
+	struct net_device *netdev = to_net_dev(config->dev);
+	struct lan743x_adapter *adapter = netdev_priv(netdev);
+
+	if (adapter->xpcs)
+		return adapter->xpcs;
+
+	return NULL;
+}
+
 static void lan743x_phylink_mac_config(struct phylink_config *config,
 				       unsigned int link_an_mode,
 				       const struct phylink_link_state *state)
@@ -3399,6 +3432,7 @@ static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
 	.mac_link_up = lan743x_phylink_mac_link_up,
 	.mac_disable_tx_lpi = lan743x_mac_disable_tx_lpi,
 	.mac_enable_tx_lpi = lan743x_mac_enable_tx_lpi,
+	.mac_select_pcs = lan743x_phylink_mac_select,
 };
 
 static int lan743x_phylink_create(struct lan743x_adapter *adapter)
@@ -3422,6 +3456,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 
 	switch (adapter->phy_interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  adapter->phylink_config.supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
@@ -3489,12 +3524,13 @@ static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
 	struct device_node *dn = adapter->pdev->dev.of_node;
 	struct net_device *dev = adapter->netdev;
 	struct phy_device *phydev;
-	int ret;
+	int ret = 0;
 
 	if (dn)
 		ret = phylink_of_phy_connect(adapter->phylink, dn, 0);
 
-	if (!dn || (ret && !lan743x_phy_handle_exists(dn))) {
+	if (!adapter->is_sfp_support_en &&
+	    (!dn || (ret && !lan743x_phy_handle_exists(dn)))) {
 		phydev = phy_find_first(adapter->mdiobus);
 		if (phydev) {
 			/* attach the mac to the phy */
@@ -3767,6 +3803,11 @@ static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
 
 static void lan743x_mdiobus_cleanup(struct lan743x_adapter *adapter)
 {
+#ifdef CONFIG_LAN743X_SFP
+	if (adapter->xpcs)
+		xpcs_destroy_pcs(adapter->xpcs);
+#endif
+
 	mdiobus_unregister(adapter->mdiobus);
 }
 
@@ -3881,6 +3922,44 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	return 0;
 }
 
+#ifdef CONFIG_LAN743X_SFP
+static int lan743x_pcs_mdiobus_init(struct lan743x_adapter *adapter)
+{
+	struct phylink_pcs *pcs;
+	int ret;
+
+	adapter->pcs_mdiobus = devm_mdiobus_alloc(&adapter->pdev->dev);
+	if (!adapter->pcs_mdiobus)
+		return -ENOMEM;
+
+	adapter->pcs_mdiobus->priv = (void *)adapter;
+	adapter->pcs_mdiobus->read_c45 = pci11x1x_pcs_read;
+	adapter->pcs_mdiobus->write_c45 = pci11x1x_pcs_write;
+	adapter->pcs_mdiobus->name = "lan743x-pcs-mdiobus-c45";
+	adapter->pcs_mdiobus->phy_mask = ~0;
+	netif_dbg(adapter, drv, adapter->netdev, "lan743x-pcs-mdiobus-c45\n");
+	snprintf(adapter->pcs_mdiobus->id, MII_BUS_ID_SIZE, "pci-pcs-%s", pci_name(adapter->pdev));
+
+	if (!adapter->phy_interface)
+		lan743x_phy_interface_select(adapter);
+
+	ret = devm_mdiobus_register(&adapter->pdev->dev, adapter->pcs_mdiobus);
+	if (ret) {
+		netdev_err(adapter->netdev, "failed to register pcs mdiobus\n");
+		return ret;
+	}
+
+	pcs = xpcs_create_pcs_mdiodev(adapter->pcs_mdiobus, 0);
+	if (IS_ERR(pcs)) {
+		netdev_err(adapter->netdev, "failed to create xpcs\n");
+		return PTR_ERR(pcs);
+	}
+
+	adapter->xpcs = pcs;
+	return 0;
+}
+#endif /* CONFIG_LAN743X_SFP */
+
 static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 {
 	int ret;
@@ -4002,6 +4081,13 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	if (ret)
 		goto cleanup_hardware;
 
+#ifdef CONFIG_LAN743X_SFP
+	if (adapter->is_sfp_support_en) {
+		ret = lan743x_pcs_mdiobus_init(adapter);
+		if (ret)
+			goto cleanup_mdiobus;
+	}
+#endif
 	adapter->netdev->netdev_ops = &lan743x_netdev_ops;
 	adapter->netdev->ethtool_ops = &lan743x_ethtool_ops;
 	adapter->netdev->features = NETIF_F_SG | NETIF_F_TSO |
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index a25864bd8328..a16fc69c4466 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -8,6 +8,9 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <linux/i2c.h>
 #include <linux/phy.h>
+#ifdef CONFIG_LAN743X_SFP
+#include <linux/pcs/pcs-xpcs.h>
+#endif
 #include <linux/phylink.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -1108,6 +1111,7 @@ struct lan743x_sw_nodes {
 struct lan743x_adapter {
 	struct net_device       *netdev;
 	struct mii_bus		*mdiobus;
+	struct mii_bus		*pcs_mdiobus;
 	int                     msg_enable;
 #ifdef CONFIG_PM
 	u32			wolopts;
@@ -1145,6 +1149,7 @@ struct lan743x_adapter {
 	u32			flags;
 	u32			hw_cfg;
 	phy_interface_t		phy_interface;
+	struct phylink_pcs      *xpcs;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	int			rx_tstamp_filter;
-- 
2.34.1


