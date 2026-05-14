Return-Path: <netdev+bounces-287925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MLjNZSpBWppZgIAu9opvQ
	(envelope-from <netdev+bounces-287925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:53:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53062540A2F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EA073071438
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB43BA220;
	Thu, 14 May 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ztdz5jP9"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3563B9D8C;
	Thu, 14 May 2026 10:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755867; cv=none; b=gPFCF/mUzoQpPj8NPYGu4khaZCivukNK0ME0NIy/2EKM85CMLm3Z6CLLBeWYIzx4TfqDSkj2gierrJWMbv/r9qtnctms+vgx5PXgiA76WkANFU/FR36wvK+UCkeWNQPdNXQitNMrqAWKzLO23VTZjCUMCqS3VjZTzmVtOoeycYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755867; c=relaxed/simple;
	bh=v9wVTyUTLOcbFxcTLl5NoveieUtTljJG4yrT320KOgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4rruwHnWrdqnfoJA4ccMVSDC2ka40GtAXBghDAP8wmqf2ZiBhvc2r+t0YsNl2Oz+mp3GolC7HAi77lgKyCHsthqxztZG7ZYvuY2nLiF0tKkHWOB0bcJIBcP4UPaKPaOd2oiAviSMzhAQKR56lchZZSsj2S8wDMTqYh8EB7oXV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ztdz5jP9; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778755865; x=1810291865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v9wVTyUTLOcbFxcTLl5NoveieUtTljJG4yrT320KOgQ=;
  b=ztdz5jP9g4g1mhMUSS5XG+wLIzCUaRfDKw3SXLezCA3wgU3o62fqETZq
   38VkBKMQM1MPEz5NyOULxbYbVosrYNCDnUD3mm/35ETgUZy/75PrhowK0
   e1vxR1JZ4gh8xf7UcBxTUnRZbbBvcXKZjLT0kARhOdW/wDxXRLuNSWWc+
   /hPWAt4T+cvc6W36WkDzMCz3LjOf4nKF23W07DWX5yoqQt7ASf4OkU/qq
   6uczD5VsGMHRvbkY8DXodJvnqbunvco4qSyUYpbVjOXVIOYOYS5ymtFPg
   13fKDt3b4dow9BwrzGa4Pmv/OU76YPvexUzlmAqhHR/eRTiR8whU0/RnX
   g==;
X-CSE-ConnectionGUID: gg+kE8jZRnCAyBMDCwGXsA==
X-CSE-MsgGUID: 4tN2LVnsQ5W28XAltCUN7A==
X-IronPort-AV: E=Sophos;i="6.23,234,1770620400"; 
   d="scan'208";a="57503048"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 03:51:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 14 May 2026 03:51:03 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 14 May 2026 03:51:00 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/5] net: lan743x: Add support to software-nodes for SFP
Date: Thu, 14 May 2026 16:20:26 +0530
Message-ID: <20260514105028.42942-4-thangaraj.s@microchip.com>
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
X-Rspamd-Queue-Id: 53062540A2F
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
	TAGGED_FROM(0.00)[bounces-287925-lists,netdev=lfdr.de];
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

Register software nodes to describe the SFP hardware topology: the GPIO
device (for TX-fault, TX-disable, LOS, mod-def0, and rate-select0
signals), the I2C adapter (for SFP EEPROM access), the SFP cage node,
and a phylink node configured for in-band-status mode.

Property entry arrays are sized with a trailing zero-initialised entry
as required by swnode.c iteration. Error paths in
lan743x_swnodes_register() free the nodes allocation via a common
return_error label to avoid memory leaks.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 261 +++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  58 ++++
 2 files changed, 317 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 77a554a0432c..b7bdf361705e 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -16,6 +16,7 @@
 #include <linux/iopoll.h>
 #include <linux/crc16.h>
 #include <linux/phylink.h>
+
 #include "lan743x_main.h"
 #include "lan743x_ethtool.h"
 
@@ -119,6 +120,139 @@ static void lan743x_pci_cleanup(struct lan743x_adapter *adapter)
 	pci_disable_device(adapter->pdev);
 }
 
+#ifdef CONFIG_LAN743X_SFP
+/* Walk the PCI11x1x topology to find a peripheral controller function by its
+ * device ID. Returns the matching pci_dev with its reference count incremented
+ * (caller must call pci_dev_put()), or NULL if not found.
+ *
+ * PCI11x1x devices consist of a PCIe switch with downstream ports. One port
+ * carries the embedded ethernet controller handled by this driver; another
+ * carries a multifunction peripheral endpoint (I2C, GPIO, UART, SPI).
+ *
+ * pci_walk_bus() is used to traverse the bus safely, as it holds the
+ * appropriate PCI bus lock during the walk.
+ */
+struct pci1xxxx_perif_ctx {
+	u16 perif_id;
+	struct pci_dev *found;
+};
+
+static int pci1xxxx_perif_match(struct pci_dev *dev, void *data)
+{
+	struct pci1xxxx_perif_ctx *ctx = data;
+
+	if (dev->vendor == PCI1XXXX_VENDOR_ID &&
+	    (dev->device & ~PCI1XXXX_DEV_MASK) == ctx->perif_id) {
+		ctx->found = pci_dev_get(dev);
+		return 1;
+	}
+	return 0;
+}
+
+static struct pci_dev *pci1xxxx_perif_dev_find(struct lan743x_adapter *adapter,
+					       u16 perif_id)
+{
+	struct pci1xxxx_perif_ctx ctx = { .perif_id = perif_id };
+	struct pci_dev *br_dev;
+
+	br_dev = pci_upstream_bridge(adapter->pdev);
+	if (!br_dev) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "upstream bridge not found\n");
+		return NULL;
+	}
+
+	pci_walk_bus(br_dev->bus, pci1xxxx_perif_match, &ctx);
+
+	if (!ctx.found)
+		netif_err(adapter, drv, adapter->netdev,
+			  "pci1xxxx peripheral (0x%X) device not found\n",
+			  perif_id);
+	return ctx.found;
+}
+
+static int pci1xxxx_i2c_dev_match(struct device *dev, const void *data)
+{
+	return i2c_verify_adapter(dev);
+}
+
+static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *perif_dev;
+	struct device *adap_dev;
+
+	perif_dev = pci1xxxx_perif_dev_find(adapter, PCI1XXXX_PERIF_I2C_ID);
+	if (!perif_dev)
+		return -EPROBE_DEFER;
+
+	adap_dev = device_find_child(&perif_dev->dev, NULL,
+				     pci1xxxx_i2c_dev_match);
+	if (!adap_dev) {
+		pci_dev_put(perif_dev);
+		return -EPROBE_DEFER;
+	}
+
+	if (!device_link_add(&perif_dev->dev, &adapter->pdev->dev,
+			     DL_FLAG_MANAGED | DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "failed to link I2C peripheral device\n");
+		put_device(adap_dev);
+		pci_dev_put(perif_dev);
+		return -EINVAL;
+	}
+
+	adapter->i2c_adap = i2c_verify_adapter(adap_dev);
+	strscpy(adapter->nodes->i2c_name, adapter->i2c_adap->name,
+		sizeof(adapter->nodes->i2c_name));
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->i2c_adap->name);
+	put_device(adap_dev);
+	pci_dev_put(perif_dev);
+	return 0;
+}
+
+static int pci1xxxx_gpio_aux_dev_match(struct device *dev, const void *data)
+{
+	if (!dev_is_auxiliary(dev))
+		return 0;
+	return strcmp(to_auxiliary_dev(dev)->name, "gp_gpio") == 0;
+}
+
+static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *perif_dev;
+	struct device *gpio_dev;
+
+	perif_dev = pci1xxxx_perif_dev_find(adapter, PCI1XXXX_PERIF_GPIO_ID);
+	if (!perif_dev)
+		return -EPROBE_DEFER;
+
+	gpio_dev = device_find_child(&perif_dev->dev, NULL,
+				     pci1xxxx_gpio_aux_dev_match);
+	if (!gpio_dev) {
+		pci_dev_put(perif_dev);
+		return -EPROBE_DEFER;
+	}
+
+	if (!device_link_add(&perif_dev->dev, &adapter->pdev->dev,
+			     DL_FLAG_MANAGED | DL_FLAG_AUTOREMOVE_CONSUMER)) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "failed to link GPIO peripheral device\n");
+		put_device(gpio_dev);
+		pci_dev_put(perif_dev);
+		return -EINVAL;
+	}
+
+	strscpy(adapter->nodes->gpio_name, dev_name(gpio_dev),
+		sizeof(adapter->nodes->gpio_name));
+	netif_dbg(adapter, drv, adapter->netdev, "Found %s\n",
+		  adapter->nodes->gpio_name);
+	put_device(gpio_dev);
+	pci_dev_put(perif_dev);
+	return 0;
+}
+#endif /* CONFIG_LAN743X_SFP */
+
 static int lan743x_pci_init(struct lan743x_adapter *adapter,
 			    struct pci_dev *pdev)
 {
@@ -2897,6 +3031,107 @@ static int lan743x_rx_open(struct lan743x_rx *rx)
 	return ret;
 }
 
+#ifdef CONFIG_LAN743X_SFP
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
+		goto return_error;
+
+	ret = pci1xxxx_i2c_adapter_get(adapter);
+	if (ret < 0)
+		goto return_error;
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
+	ret = software_node_register_node_group(nodes->group);
+	if (ret)
+		goto return_error;
+
+	return 0;
+
+return_error:
+	kfree(nodes);
+	adapter->nodes = NULL;
+	return ret;
+}
+#endif /* CONFIG_LAN743X_SFP */
+
 static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
 {
 	u32 sgmii_ctl;
@@ -3141,7 +3376,9 @@ static const struct phylink_mac_ops lan743x_phylink_mac_ops = {
 static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
+	struct fwnode_handle *fwnode = NULL;
 	struct phylink *pl;
+	int ret;
 
 	adapter->phylink_config.dev = &netdev->dev;
 	adapter->phylink_config.type = PHYLINK_NETDEV;
@@ -3181,11 +3418,28 @@ static int lan743x_phylink_create(struct lan743x_adapter *adapter)
 	       adapter->phylink_config.supported_interfaces,
 	       sizeof(adapter->phylink_config.lpi_interfaces));
 
-	pl = phylink_create(&adapter->phylink_config, NULL,
-			    adapter->phy_interface, &lan743x_phylink_mac_ops);
+#ifdef CONFIG_LAN743X_SFP
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
+#endif
 
+	pl = phylink_create(&adapter->phylink_config, fwnode,
+			    adapter->phy_interface, &lan743x_phylink_mac_ops);
 	if (IS_ERR(pl)) {
 		netdev_err(netdev, "Could not create phylink (%pe)\n", pl);
+#ifdef CONFIG_LAN743X_SFP
+		lan743x_swnodes_unregister(adapter);
+#endif
 		return PTR_ERR(pl);
 	}
 
@@ -3492,6 +3746,9 @@ static void lan743x_destroy_phylink(struct lan743x_adapter *adapter)
 {
 	phylink_destroy(adapter->phylink);
 	adapter->phylink = NULL;
+#ifdef CONFIG_LAN743X_SFP
+	lan743x_swnodes_unregister(adapter);
+#endif
 }
 
 static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index d9eb10ffac6c..1bff59f43d50 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -4,14 +4,36 @@
 #ifndef _LAN743X_H
 #define _LAN743X_H
 
+#include <linux/auxiliary_bus.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <linux/i2c.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/platform_device.h>
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
 /* Register Definitions */
 #define ID_REV				(0x00)
 #define ID_REV_ID_MASK_			(0xFFFF0000)
@@ -1049,6 +1071,40 @@ enum lan743x_sgmii_lsd {
 
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
+	struct property_entry gpio_props[2];
+	struct property_entry i2c_props[2];
+	struct property_entry sfp_props[8];
+	struct property_entry phylink_props[3];
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
@@ -1092,6 +1148,8 @@ struct lan743x_adapter {
 	struct phylink		*phylink;
 	struct phylink_config	phylink_config;
 	int			rx_tstamp_filter;
+	struct lan743x_sw_nodes *nodes;
+	struct i2c_adapter      *i2c_adap;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


