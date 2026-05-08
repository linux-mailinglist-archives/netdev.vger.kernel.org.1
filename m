Return-Path: <netdev+bounces-285635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EICYO7hz/WlzeQAAu9opvQ
	(envelope-from <netdev+bounces-285635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:25:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5168E4F1E9D
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D48F302263B
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F335233ADA9;
	Fri,  8 May 2026 05:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Tya9Sfuk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCA833D511;
	Fri,  8 May 2026 05:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217753; cv=none; b=beYvGmqv3sVFrIVX3mijhbRIfQVsaQ/BPJHkmBaaS7GhhonogdwT9iFZFTZVp38Ta2VBZqCFHSTU4nPvIyceS/0RPW3EEsU9y96jKrrXwARfeXzX/nqnQd96u2R2rRbZZPRT7ZDByUS16RcVSELAXZyWISATzWsjOEImkqkfuC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217753; c=relaxed/simple;
	bh=dGI9ac1bMbErdYo5blBAULRaRqnin4ZKhLJdjlmD4ks=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oziZuKr921PWwhy605nl/zSTsb4ZTXusCvRVR2lEQZvosU6a1ZctIJ+lYjDODcH/UiQC9hayjrcp6SBdLxF2aBN7U9RO/LAv+ZlaLxJbbdZmd0OnQikgPHxD7Op5uyhb3bI9lUKrB5Zzh9kwSFomGRv4VSWswIqL4Ireo0LqYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Tya9Sfuk; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778217752; x=1809753752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dGI9ac1bMbErdYo5blBAULRaRqnin4ZKhLJdjlmD4ks=;
  b=Tya9SfukyocNneKeuesiP27CRNtuj75kcYtNP4xWvjp/NK+yTr5AVcRe
   ftFwS4RcEtpc0SrMGBkcNQt9jfb7z1B7oRREQ7bLrStY+Vly3MMvS0Pp2
   GWaEGGiAJ/G86Gf1jmrRiC2F3CRl4ufB7VrA+S/+NknC+ymyqqqVrAnfs
   8K7YZ2vL+UXM9cMNnIpndpfcHiYJ0zzGWSQld/xjuBzSAANN//pRm/7AG
   QCIiBNy5pmwxX3RSIhqqIcr/s9cMlBQj+3/FNGyEuyJ4f1vACQz7PAz5q
   sHyheZAY8nrBoftzi/JCIOz0HMNTMnm+ULCmS79DNTW0t5PHnxoeSuBec
   g==;
X-CSE-ConnectionGUID: 9Cc80jtDQxOHIuUN2DRg5A==
X-CSE-MsgGUID: BvjOtB0TRcmm4rLVHsJzTA==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; 
   d="scan'208";a="224449881"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 May 2026 22:22:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 7 May 2026 22:22:31 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 22:22:27 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 3/5] net: lan743x: Add support to software-nodes for SFP
Date: Fri, 8 May 2026 10:51:48 +0530
Message-ID: <20260508052150.11852-4-thangaraj.s@microchip.com>
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
X-Rspamd-Queue-Id: 5168E4F1E9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-285635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:email,microchip.com:mid,microchip.com:dkim]
X-Rspamd-Action: no action

Register software nodes and define the required device properties.
The software node hierarchy describes the hardware connections for
SFP support, including:
 - GPIO pins used for SFP control and status signals (TX fault,
   TX disable, LOS, mod-def0, rate-select0)
 - the I2C bus used for SFP module EEPROM access
 - the SFP cage signal connections
 - the phylink configuration in in-band status mode

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig        |   2 +
 drivers/net/ethernet/microchip/lan743x_main.c | 196 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  81 ++++++++
 3 files changed, 277 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index ee046468652c..a83db3c7404f 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -50,6 +50,8 @@ config LAN743X
 	select CRC16
 	select CRC32
 	select PHYLINK
+	select I2C_PCI1XXXX
+	select GP_PCI1XXXX
 	help
 	  Support for the Microchip LAN743x and PCI11x1x families of PCI
 	  Express Ethernet devices
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 867310dbe9ba..b90b35cef2e6 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -16,6 +16,7 @@
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
 #include <linux/phylink.h>
+
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -112,6 +113,91 @@ static void lan743x_pci_cleanup(struct lan743x_adapter *adapter)
 	pci_disable_device(adapter->pdev);
 }
 
+static void *pci1xxxx_perif_drvdata_get(struct lan743x_adapter *adapter,
+					u16 perif_id)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct pci_bus *perif_bus;
+	struct pci_dev *perif_dev;
+	struct pci_dev *br_dev;
+	struct pci_bus *br_bus;
+	struct pci_dev *dev;
+
+	/* PCI11x1x devices' PCIe topology consists of a top level pcie
+	 * switch with up to four downstream ports, some of which have
+	 * integrated endpoints connected to them. One of the downstream ports
+	 * has an embedded single function pcie ethernet controller which is
+	 * handled by this driver. Another downstream port has an
+	 * embedded multifunction pcie endpoint, with four pcie functions
+	 * (the "peripheral controllers": I2C controller, GPIO controller,
+	 * UART controllers, SPI controllers)
+	 * The code below navigates the PCI11x1x topology
+	 * to find (by matching its PCI device ID) the peripheral controller
+	 * that should be paired to the embedded ethernet controller.
+	 */
+
+	br_dev = pci_upstream_bridge(pdev);
+	if (!br_dev) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "upstream bridge not found\n");
+		return br_dev;
+	}
+
+	br_bus = br_dev->bus;
+	list_for_each_entry(dev, &br_bus->devices, bus_list) {
+		if (dev->vendor == PCI1XXXX_VENDOR_ID &&
+		    (dev->device & ~PCI1XXXX_DEV_MASK) == PCI1XXXX_BR_PERIF_ID) {
+			perif_bus = dev->subordinate;
+			list_for_each_entry(perif_dev, &perif_bus->devices,
+					    bus_list) {
+				if (perif_dev->vendor == PCI1XXXX_VENDOR_ID &&
+				    (perif_dev->device & ~PCI1XXXX_DEV_MASK) ==
+				     perif_id)
+					return pci_get_drvdata(perif_dev);
+			}
+		}
+	}
+
+	netif_err(adapter, drv, adapter->netdev,
+		  "pci1xxxx peripheral (0x%X) device not found\n", perif_id);
+
+	return NULL;
+}
+
+static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
+{
+	struct pci1xxxx_i2c *i2c_drvdata;
+
+	i2c_drvdata = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_I2C_ID);
+	if (!i2c_drvdata)
+		return -EPROBE_DEFER;
+
+	adapter->i2c_adap = &i2c_drvdata->adap;
+	strscpy(adapter->nodes->i2c_name, adapter->i2c_adap->name,
+		sizeof(adapter->nodes->i2c_name));
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->i2c_adap->name);
+
+	return 0;
+}
+
+static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
+{
+	struct aux_bus_device *aux_bus;
+	struct device *gpio_dev;
+
+	aux_bus = pci1xxxx_perif_drvdata_get(adapter, PCI1XXXX_PERIF_GPIO_ID);
+	if (!aux_bus)
+		return -EPROBE_DEFER;
+
+	gpio_dev = &aux_bus->aux_device_wrapper[1]->aux_dev.dev;
+	strscpy(adapter->nodes->gpio_name, dev_name(gpio_dev),
+		sizeof(adapter->nodes->gpio_name));
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->nodes->gpio_name);
+	return 0;
+}
+
 static int lan743x_pci_init(struct lan743x_adapter *adapter,
 			    struct pci_dev *pdev)
 {
@@ -2890,6 +2976,96 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 	return ret;
 }
 
+static void lan743x_swnodes_unregister(struct lan743x_adapter *adapter)
+{
+	if (adapter->nodes) {
+		software_node_unregister_node_group(adapter->nodes->group);
+		kfree(adapter->nodes);
+		adapter->nodes = NULL;
+	}
+}
+
+static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct lan743x_sw_nodes *nodes;
+	struct software_node *swnodes;
+	int ret;
+	u32 id;
+
+	nodes = kzalloc_obj(*nodes);
+	if (!nodes)
+		return -ENOMEM;
+
+	adapter->nodes = nodes;
+
+	ret = pci1xxxx_gpio_dev_get(adapter);
+	if (ret < 0)
+		return ret;
+
+	ret = pci1xxxx_i2c_adapter_get(adapter);
+	if (ret < 0)
+		return ret;
+
+	id = (pdev->bus->number << 8) | pdev->devfn;
+	snprintf(nodes->sfp_name, sizeof(nodes->sfp_name), "sfp-%d", id);
+	snprintf(nodes->phylink_name, sizeof(nodes->phylink_name),
+		 "mchp-pci1xxxx-phylink-%d", id);
+
+	swnodes = nodes->swnodes;
+
+	nodes->gpio_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names", "default");
+	swnodes[SWNODE_GPIO] = NODE_PROP(nodes->gpio_name, nodes->gpio_props);
+
+	nodes->tx_fault_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							 PCI11X1X_TX_FAULT_GPIO,
+							 GPIO_ACTIVE_HIGH);
+	nodes->tx_disable_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							   PCI11X1X_TX_DIS_GPIO,
+							   GPIO_ACTIVE_HIGH);
+	nodes->mod_def0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							 PCI11X1X_MOD_DEF0_GPIO,
+							 GPIO_ACTIVE_LOW);
+	nodes->los_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+						    PCI11X1X_LOS_GPIO,
+						    GPIO_ACTIVE_HIGH);
+	nodes->rate_sel0_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_GPIO],
+							  PCI11X1X_RATE_SEL0_GPIO,
+							  GPIO_ACTIVE_HIGH);
+
+	nodes->i2c_props[0] = PROPERTY_ENTRY_STRING("pinctrl-names", "default");
+	swnodes[SWNODE_I2C] = NODE_PROP(nodes->i2c_name, nodes->i2c_props);
+	nodes->i2c_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_I2C]);
+
+	nodes->sfp_props[0] = PROPERTY_ENTRY_STRING("compatible", "sff,sfp");
+	nodes->sfp_props[1] = PROPERTY_ENTRY_REF_ARRAY("i2c-bus", nodes->i2c_ref);
+	nodes->sfp_props[2] = PROPERTY_ENTRY_REF_ARRAY("tx-fault-gpios",
+						       nodes->tx_fault_ref);
+	nodes->sfp_props[3] = PROPERTY_ENTRY_REF_ARRAY("tx-disable-gpios",
+						       nodes->tx_disable_ref);
+	nodes->sfp_props[4] = PROPERTY_ENTRY_REF_ARRAY("mod-def0-gpios",
+						       nodes->mod_def0_ref);
+	nodes->sfp_props[5] = PROPERTY_ENTRY_REF_ARRAY("los-gpios",
+						       nodes->los_ref);
+	nodes->sfp_props[6] = PROPERTY_ENTRY_REF_ARRAY("rate-select0-gpios",
+						       nodes->rate_sel0_ref);
+	swnodes[SWNODE_SFP] = NODE_PROP(nodes->sfp_name, nodes->sfp_props);
+	nodes->sfp_ref[0] = SOFTWARE_NODE_REFERENCE(&swnodes[SWNODE_SFP]);
+	nodes->phylink_props[0] = PROPERTY_ENTRY_STRING("managed",
+							"in-band-status");
+	nodes->phylink_props[1] = PROPERTY_ENTRY_REF_ARRAY("sfp",
+							   nodes->sfp_ref);
+	swnodes[SWNODE_PHYLINK] = NODE_PROP(nodes->phylink_name,
+					    nodes->phylink_props);
+
+	nodes->group[SWNODE_GPIO] = &swnodes[SWNODE_GPIO];
+	nodes->group[SWNODE_I2C] = &swnodes[SWNODE_I2C];
+	nodes->group[SWNODE_SFP] = &swnodes[SWNODE_SFP];
+	nodes->group[SWNODE_PHYLINK] = &swnodes[SWNODE_PHYLINK];
+
+	return software_node_register_node_group(nodes->group);
+}
+
 static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
 {
 	u32 sgmii_ctl;
@@ -3134,7 +3310,9 @@ static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
 static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct fwnode_handle *fwnode = NULL;
 	struct phylink *pl;
+	int ret;
 
 	adapter->phylink_config.dev = &netdev->dev;
 	adapter->phylink_config.type = PHYLINK_NETDEV;
@@ -3174,11 +3352,24 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	       adapter->phylink_config.supported_interfaces,
 	       sizeof(adapter->phylink_config.lpi_interfaces));
 
-	pl = phylink_create(&adapter->phylink_config, NULL,
-			    adapter->phy_interface, &lan743x_phylink_mac_ops);
+	if (adapter->is_sfp_support_en) {
+		ret = lan743x_swnodes_register(adapter);
+		if (ret) {
+			netdev_err(netdev, "failed to register software nodes\n");
+			return ret;
+		}
+		fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_PHYLINK]);
+		if (!fwnode) {
+			lan743x_swnodes_unregister(adapter);
+			return -ENODEV;
+		}
+	}
 
+	pl = phylink_create(&adapter->phylink_config, fwnode,
+			    adapter->phy_interface, &lan743x_phylink_mac_ops);
 	if (IS_ERR(pl)) {
 		netdev_err(netdev, "Could not create phylink (%pe)\n", pl);
+		lan743x_swnodes_unregister(adapter);
 		return PTR_ERR(pl);
 	}
 
@@ -3485,6 +3676,7 @@ static void lan743x_destroy_phylink(struct lan743x_adapter *adapter)
 {
 	phylink_destroy(adapter->phylink);
 	adapter->phylink = NULL;
+	lan743x_swnodes_unregister(adapter);
 }
 
 static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 26c30dc2e55c..48db45d41502 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -4,14 +4,59 @@
 #ifndef _LAN743X_H
 #define _LAN743X_H
 
+#include <linux/auxiliary_bus.h>
+#include <linux/gpio/machine.h>
+#include <linux/i2c.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/property.h>
 #include "lan743x_ptp.h"
 
 #define DRIVER_AUTHOR   "Bryan Whitehead <Bryan.Whitehead@microchip.com>"
 #define DRIVER_DESC "LAN743x PCIe Gigabit Ethernet Driver"
 #define DRIVER_NAME "lan743x"
 
+#define PCI1XXXX_VENDOR_ID		0x1055
+#define PCI1XXXX_BR_PERIF_ID		0xA00C
+#define PCI1XXXX_PERIF_I2C_ID		0xA003
+#define PCI1XXXX_PERIF_GPIO_ID		0xA005
+#define PCI1XXXX_DEV_MASK		GENMASK(7, 4)
+#define PCI11X1X_TX_FAULT_GPIO		46
+#define PCI11X1X_TX_DIS_GPIO		47
+#define PCI11X1X_RATE_SEL0_GPIO		48
+#define PCI11X1X_LOS_GPIO		49
+#define PCI11X1X_MOD_DEF0_GPIO		51
+
+#define NODE_PROP(_NAME, _PROP)		\
+	((const struct software_node) {	\
+		.name = _NAME,		\
+		.properties = _PROP,	\
+	 })
+
+struct pci1xxxx_i2c {
+	struct completion i2c_xfer_done;
+	bool i2c_xfer_in_progress;
+	struct i2c_adapter adap;
+	void __iomem *i2c_base;
+	u32 freq;
+	u32 flags;
+};
+
+struct gp_aux_data_type {
+	int irq_num;
+	resource_size_t region_start;
+	resource_size_t region_length;
+};
+
+struct auxiliary_device_wrapper {
+	struct auxiliary_device aux_dev;
+	struct gp_aux_data_type gp_aux_data;
+};
+
+struct aux_bus_device {
+	struct auxiliary_device_wrapper *aux_device_wrapper[2];
+};
+
 /* Register Definitions */
 #define ID_REV				(0x00)
 #define ID_REV_ID_MASK_			(0xFFFF0000)
@@ -1049,6 +1094,40 @@ enum lan743x_sgmii_lsd {
 
 #define MAC_SUPPORTED_WAKES  (WAKE_BCAST | WAKE_UCAST | WAKE_MCAST | \
 			      WAKE_MAGIC | WAKE_ARP)
+
+enum lan743x_swnodes {
+	SWNODE_GPIO = 0,
+	SWNODE_I2C,
+	SWNODE_SFP,
+	SWNODE_PHYLINK,
+	SWNODE_MAX
+};
+
+#define I2C_DRV_NAME           48
+#define GPIO_DRV_NAME          32
+#define SFP_NODE_NAME          32
+#define PHYLINK_NODE_NAME      32
+
+struct lan743x_sw_nodes {
+	char gpio_name[GPIO_DRV_NAME];
+	char i2c_name[I2C_DRV_NAME];
+	char sfp_name[SFP_NODE_NAME];
+	char phylink_name[PHYLINK_NODE_NAME];
+	struct property_entry gpio_props[1];
+	struct property_entry i2c_props[1];
+	struct property_entry sfp_props[8];
+	struct property_entry phylink_props[2];
+	struct software_node_ref_args i2c_ref[1];
+	struct software_node_ref_args tx_fault_ref[1];
+	struct software_node_ref_args tx_disable_ref[1];
+	struct software_node_ref_args mod_def0_ref[1];
+	struct software_node_ref_args los_ref[1];
+	struct software_node_ref_args rate_sel0_ref[1];
+	struct software_node_ref_args sfp_ref[1];
+	struct software_node swnodes[SWNODE_MAX];
+	const struct software_node *group[SWNODE_MAX + 1];
+};
+
 struct lan743x_adapter {
 	struct net_device       *netdev;
 	struct mii_bus		*mdiobus;
@@ -1092,6 +1171,8 @@ struct lan743x_adapter {
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	int			rx_tstamp_filter;
+	struct lan743x_sw_nodes *nodes;
+	struct i2c_adapter      *i2c_adap;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


