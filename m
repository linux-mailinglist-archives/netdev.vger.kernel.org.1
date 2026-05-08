Return-Path: <netdev+bounces-285637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMkhEStz/WlzeQAAu9opvQ
	(envelope-from <netdev+bounces-285637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:22:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 137224F1E71
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72F153012200
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B9233C183;
	Fri,  8 May 2026 05:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uOPg/k2y"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2D54739;
	Fri,  8 May 2026 05:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217764; cv=none; b=PNy4c6FngZ6HEZMR4V4OuIvwOZ3e0eWudBBk2UALauX2aSae8NsDfKCg6JVxq2C1Gu6T0eOEihCY+zZNZONIDoUSnIUEnTIWGEUM0GJggVAm41EIO54anzpbRok+2yCirv7ofYCbpDAJpnaGc5Qw5VpKrscmaQguzqsXLz4fMqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217764; c=relaxed/simple;
	bh=+eLp8zJR0AG9uVHJMCU2Q0AaCq2OI5C10zSnMS4JUpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VD5SsRKu6pUFVBYgRH9h6YFskeYgwTpcOq7bjbI8asmsdczw2ofOdgux+fuZMrs86YE1PZx2GLutoneQA1Ri8cjsAREgUT0+pQSKzhgH5h/27KoEv06QDLvrNtUu2lKdhZnFFPQHG30azpS6C87njGCdyM7IKDv1CwO+dsrlFRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uOPg/k2y; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778217762; x=1809753762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+eLp8zJR0AG9uVHJMCU2Q0AaCq2OI5C10zSnMS4JUpk=;
  b=uOPg/k2yCx/SlSynJ/SiKoKjTm4v1B+4R45+JCLEGkF8M8BYd8IGa3JE
   hUcF8iMovjBoC3uhns2c6kuUbbaQeFWGPUrXry+eDKE5LAS7v4E5iV0Cx
   ++++1aaYm2SlCHwkSBsoAwqB9HtneeDyFEs58dNF88BewZ+5HZ+VDwCp5
   KEm3xSbRC2pdEtWTWBqTCLD4c3s3Cx8VvKKEqCby9X+Rwk+/fJiE849Ap
   wkdJkrbEPgdSNs5Q9scY5fqQZSg8iVUz1oZLp8m2kk4aJtIBVUZmcokw/
   ooHIdZ+PqloN0vViHoZdxv5UlhSFhIKDGubMrIRX5bi4MYVqv3Xc7aWz7
   Q==;
X-CSE-ConnectionGUID: x6TAVB2ERH6vrp55HOupyA==
X-CSE-MsgGUID: b80N0vRfTVSGDgS2fwtpkw==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; 
   d="scan'208";a="57611601"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 22:22:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 7 May 2026 22:22:41 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 22:22:38 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 5/5] net: lan743x: Add PCS/XPCS support for SFP on PCI11x1x
Date: Fri, 8 May 2026 10:51:50 +0530
Message-ID: <20260508052150.11852-6-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260508052150.11852-1-thangaraj.s@microchip.com>
References: <20260508052150.11852-1-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: 137224F1E71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-285637-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:mid,microchip.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a PCS MII bus and XPCS instance to support SFP modules on PCI11x1x
platforms.

Register a dedicated mdiobus for PCS access when SFP support is enabled
and initialize it with C45 read/write callbacks. Implement generic PCS
read/write functions that use the internal SGMII access functions for
the PCS.

Integrate the XPCS instance with phylink by providing a mac_select_pcs
callback. Support SGMII and 2.5GBASE-X interfaces in phylink, allowing
proper link configuration for SFP modules.

Cleanup the PCS mdiobus and XPCS instance during driver removal. Update
adapter structure to hold PCS mdiobus and XPCS references.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 86 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  3 +
 2 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 88a2d11552f8..485fbc678481 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -15,7 +15,6 @@
 #include <linux/rtnetlink.h>
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
-#include <linux/phylink.h>
 
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
@@ -1137,6 +1136,28 @@ static int lan743x_get_lsd(int speed, int duplex, u8 mss)
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
@@ -3199,6 +3220,18 @@ static void lan743x_mac_eee_enable(struct lan743x_adapter *adapter, bool enable)
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
@@ -3330,6 +3363,7 @@ static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
 	.mac_link_up = lan743x_phylink_mac_link_up,
 	.mac_disable_tx_lpi = lan743x_mac_disable_tx_lpi,
 	.mac_enable_tx_lpi = lan743x_mac_enable_tx_lpi,
+	.mac_select_pcs = lan743x_phylink_mac_select,
 };
 
 static int lan743x_phylink_create(struct lan743x_adapter *adapter)
@@ -3353,6 +3387,7 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 
 	switch (adapter->phy_interface) {
 	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  adapter->phylink_config.supported_interfaces);
 		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
@@ -3416,12 +3451,13 @@ static int lan743x_phylink_connect(struct lan743x_adapter *adapter)
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
@@ -3694,6 +3730,9 @@ static void lan743x_hardware_cleanup(struct lan743x_adapter *adapter)
 
 static void lan743x_mdiobus_cleanup(struct lan743x_adapter *adapter)
 {
+	if (adapter->xpcs)
+		xpcs_destroy_pcs(adapter->xpcs);
+
 	mdiobus_unregister(adapter->mdiobus);
 }
 
@@ -3806,6 +3845,42 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
 	return 0;
 }
 
+static int lan743x_pcs_mdiobus_init(struct lan743x_adapter *adapter)
+{
+	struct phylink_pcs *pcs;
+	int ret;
+
+	adapter->pcs_mdiobus = devm_mdiobus_alloc(&adapter->pdev->dev);
+	if (!(adapter->pcs_mdiobus)) {
+		ret = -ENOMEM;
+		goto return_error;
+	}
+
+	adapter->pcs_mdiobus->priv = (void *)adapter;
+	adapter->pcs_mdiobus->read_c45 = pci11x1x_pcs_read;
+	adapter->pcs_mdiobus->write_c45 = pci11x1x_pcs_write;
+	adapter->pcs_mdiobus->name = "lan743x-pcs-mdiobus-c45";
+	netif_dbg(adapter, drv, adapter->netdev, "lan743x-pcs-mdiobus-c45\n");
+	snprintf(adapter->pcs_mdiobus->id, MII_BUS_ID_SIZE, "pci-pcs-%s", pci_name(adapter->pdev));
+
+	if (!adapter->phy_interface)
+		lan743x_phy_interface_select(adapter);
+
+	pcs = xpcs_create_pcs_mdiodev(adapter->pcs_mdiobus, 0);
+	if (IS_ERR(pcs)) {
+		netdev_err(adapter->netdev, "failed to create xpcs\n");
+		ret = PTR_ERR(pcs);
+		goto return_error;
+	}
+
+	adapter->xpcs = pcs;
+	return 0;
+
+return_error:
+	mdiobus_free(adapter->pcs_mdiobus);
+	return ret;
+}
+
 static int lan743x_mdiobus_init(struct lan743x_adapter *adapter)
 {
 	int ret;
@@ -3927,6 +4002,11 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 	if (ret)
 		goto cleanup_hardware;
 
+	if (adapter->is_sfp_support_en) {
+		ret = lan743x_pcs_mdiobus_init(adapter);
+		if (ret)
+			goto cleanup_hardware;
+	}
 	adapter->netdev->netdev_ops = &lan743x_netdev_ops;
 	adapter->netdev->ethtool_ops = &lan743x_ethtool_ops;
 	adapter->netdev->features = NETIF_F_SG | NETIF_F_TSO |
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index fd1c2842b4c8..9740c2628f94 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -8,6 +8,7 @@
 #include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/phy.h>
+#include <linux/pcs/pcs-xpcs.h>
 #include <linux/phylink.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -1132,6 +1133,7 @@ struct lan743x_sw_nodes {
 struct lan743x_adapter {
 	struct net_device       *netdev;
 	struct mii_bus		*mdiobus;
+	struct mii_bus		*pcs_mdiobus;
 	int                     msg_enable;
 #ifdef CONFIG_PM
 	u32			wolopts;
@@ -1169,6 +1171,7 @@ struct lan743x_adapter {
 	u32			flags;
 	u32			hw_cfg;
 	phy_interface_t		phy_interface;
+	struct phylink_pcs      *xpcs;
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	int			rx_tstamp_filter;
-- 
2.34.1


