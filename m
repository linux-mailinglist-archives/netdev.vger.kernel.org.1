Return-Path: <netdev+bounces-287926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACnFIMupBWppZgIAu9opvQ
	(envelope-from <netdev+bounces-287926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C9D540A4C
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47384305B2C2
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 10:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254873BB116;
	Thu, 14 May 2026 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AI3zcx2O"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFE23B7B71;
	Thu, 14 May 2026 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778755872; cv=none; b=nbau5kvQMCl9IBlrPZFn9Ds6aHpZYgXYRDbcZ9ZPfp4vBgiDt2pBFg0Z+cjdvJV9BLoFjq9Fin34zQTYURBwSikPKQIEC/SlLM5jgEB6beqhQRwxZ/16YIV42iToOYUymufMnWtRNNpI6l1FWWNf1eGOWcqDjCuap9hEwku5idU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778755872; c=relaxed/simple;
	bh=nc+LssMnHiim6lFPG3GL5ZUz2cDCvzO1E7+0uTSJxw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cexszb+h7RN9DZsIW6D43rxPKglvYZvQajeq6av/tfmjmXW9mjJs4WGa9G2RcQPydBwlOJ0Wh0AI4Hk/ZABEe+E3PBQ7pNw7D4/9t6kEYAUpAms9tFbMDDkh6YW9Z8bf4HsOdOVoR1d3+lOfjXCL7lZ55E8sICnS9TDowgzMRR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AI3zcx2O; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778755870; x=1810291870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nc+LssMnHiim6lFPG3GL5ZUz2cDCvzO1E7+0uTSJxw4=;
  b=AI3zcx2OtErma0MmC4oIDrozZh9ueKMMS5a0KRYMGssLx/FcgZgRVMtp
   NaxZkJNxEm02RbH4U6zvSydTwokuVYQydkHiBO8MdJdfEnycVWvChGtJs
   FSKcOi18G1VERHn51ZL/IoKP5gPI0EydA3YQaTzFc0Tld1p26owCl/+bI
   MFreTVVTMARLeyd0MU7YMYskr7E0gfGgxOCiTmG/5eHXoBLA1wYu5QD9d
   I2YoZTm6DoGNF2IumfGMxT/RAR21a2e6VEv2iRQukO+mY65N2oFn/Up5T
   2QQaS2QhIrBUEb6EiKr+Ktxc8xssB2pP7Y0jHYV/+VHFdAjduoouM7KCu
   Q==;
X-CSE-ConnectionGUID: IBE4cFAPQnOFOZTFHmylNQ==
X-CSE-MsgGUID: G4sXtU9LS9m4ZtixDCiahg==
X-IronPort-AV: E=Sophos;i="6.23,234,1770620400"; 
   d="scan'208";a="65858100"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 03:51:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 14 May 2026 03:51:09 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 14 May 2026 03:51:05 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/5] net: lan743x: Register SFP platform device for PCI11x1x
Date: Thu, 14 May 2026 16:20:27 +0530
Message-ID: <20260514105028.42942-5-thangaraj.s@microchip.com>
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
X-Rspamd-Queue-Id: E6C9D540A4C
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
	TAGGED_FROM(0.00)[bounces-287926-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:mid,microchip.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sfp_info.id:url]
X-Rspamd-Action: no action

Register an SFP platform device backed by the SFP software node when
SFP support is enabled, and associate the I2C adapter's firmware node
so the SFP subsystem can manage module detection and EEPROM reads.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 64 +++++++++++++++++--
 drivers/net/ethernet/microchip/lan743x_main.h |  1 +
 2 files changed, 60 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index b7bdf361705e..649065c36434 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -192,8 +192,8 @@ static int pci1xxxx_i2c_adapter_get(struct lan743x_adapter *adapter)
 		return -EPROBE_DEFER;
 	}
 
-	if (!device_link_add(&perif_dev->dev, &adapter->pdev->dev,
-			     DL_FLAG_MANAGED | DL_FLAG_AUTOREMOVE_CONSUMER)) {
+	if (!device_link_add(&adapter->pdev->dev, &perif_dev->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
 		netif_err(adapter, drv, adapter->netdev,
 			  "failed to link I2C peripheral device\n");
 		put_device(adap_dev);
@@ -234,8 +234,8 @@ static int pci1xxxx_gpio_dev_get(struct lan743x_adapter *adapter)
 		return -EPROBE_DEFER;
 	}
 
-	if (!device_link_add(&perif_dev->dev, &adapter->pdev->dev,
-			     DL_FLAG_MANAGED | DL_FLAG_AUTOREMOVE_CONSUMER)) {
+	if (!device_link_add(&adapter->pdev->dev, &perif_dev->dev,
+			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
 		netif_err(adapter, drv, adapter->netdev,
 			  "failed to link GPIO peripheral device\n");
 		put_device(gpio_dev);
@@ -3132,6 +3132,34 @@ static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
 }
 #endif /* CONFIG_LAN743X_SFP */
 
+#ifdef CONFIG_LAN743X_SFP
+static int lan743x_sfp_register(struct lan743x_adapter *adapter)
+{
+	struct pci_dev *pdev = adapter->pdev;
+	struct platform_device_info sfp_info;
+	struct platform_device *sfp_dev;
+
+	memset(&sfp_info, 0, sizeof(sfp_info));
+	sfp_info.parent = &adapter->pdev->dev;
+	sfp_info.fwnode = software_node_fwnode(adapter->nodes->group[SWNODE_SFP]);
+	sfp_info.name = "sfp";
+	sfp_info.id = (pci_domain_nr(pdev->bus) << 16) |
+		      (pdev->bus->number << 8) | pdev->devfn;
+	sfp_dev = platform_device_register_full(&sfp_info);
+	if (IS_ERR(sfp_dev)) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Failed to register SFP device\n");
+		return PTR_ERR(sfp_dev);
+	}
+
+	adapter->sfp_dev = sfp_dev;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP platform device registered\n");
+
+	return 0;
+}
+#endif /* CONFIG_LAN743X_SFP */
+
 static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
 {
 	u32 sgmii_ctl;
@@ -3754,6 +3782,12 @@ static void lan743x_destroy_phylink(struct lan743x_adapter *adapter)
 static void lan743x_full_cleanup(struct lan743x_adapter *adapter)
 {
 	unregister_netdev(adapter->netdev);
+	if (adapter->sfp_dev) {
+		platform_device_unregister(adapter->sfp_dev);
+		adapter->sfp_dev = NULL;
+	}
+	if (adapter->i2c_adap)
+		adapter->i2c_adap = NULL;
 
 	lan743x_destroy_phylink(adapter);
 	lan743x_mdiobus_cleanup(adapter);
@@ -3981,11 +4015,31 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 		goto cleanup_mdiobus;
 	}
 
+#ifdef CONFIG_LAN743X_SFP
+	if (adapter->is_sfp_support_en) {
+		adapter->i2c_adap->dev.fwnode =
+			software_node_fwnode(adapter->nodes->group[SWNODE_I2C]);
+
+		ret = lan743x_sfp_register(adapter);
+		if (ret < 0) {
+			netif_err(adapter, probe, netdev,
+				  "failed to sfp register (%d)\n", ret);
+			goto cleanup_phylink;
+		}
+	}
+#endif
+
 	ret = register_netdev(adapter->netdev);
 	if (ret < 0)
-		goto cleanup_phylink;
+		goto cleanup_sfp;
 	return 0;
 
+cleanup_sfp:
+	if (adapter->sfp_dev) {
+		platform_device_unregister(adapter->sfp_dev);
+		adapter->sfp_dev = NULL;
+	}
+
 cleanup_phylink:
 	lan743x_destroy_phylink(adapter);
 
diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
index 1bff59f43d50..a25864bd8328 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -1150,6 +1150,7 @@ struct lan743x_adapter {
 	int			rx_tstamp_filter;
 	struct lan743x_sw_nodes *nodes;
 	struct i2c_adapter      *i2c_adap;
+	struct platform_device  *sfp_dev;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


