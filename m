Return-Path: <netdev+bounces-285636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEw8C+Vz/WlzeQAAu9opvQ
	(envelope-from <netdev+bounces-285636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:25:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 806F94F1EB3
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 07:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0522A305B298
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 05:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40FF33CEB0;
	Fri,  8 May 2026 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="w7zgv6Xn"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938E33B6CB;
	Fri,  8 May 2026 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778217758; cv=none; b=GGz0ZtUuPyo6BsVGjP4VUz3iekz+oChxHNop0RzMZr6C2PmwykMECxH8Aq/cQhycFOnMCb7I7PwNRLORiUJxuc8NOi+2YeeO5B8bMDi5R5NyMm824K+GyknwuQYWSU8mw3zPCiVDiAigvc+ddYTqpdwpETrPj29ZyRzAquf1lY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778217758; c=relaxed/simple;
	bh=8AO7g6c8FUvqB1OVFF6wMCiM825he4eGw6Zrbwky99w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cdt+22w9RRpDath9ByzaYyH7nHnfRzReApwNyQV7R1YP5jBr91NyrLd34ifO2AGJH8PVrkxGbQxFeLsPtte5vG2ipeDlVZ/xZvx0QhgDiSeEg7wN3sa8d2J4dfohRJGqgXsbLIILbkgRynEMUKfqQfOpnyh+0t2lJrgK6gZPUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=w7zgv6Xn; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778217756; x=1809753756;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8AO7g6c8FUvqB1OVFF6wMCiM825he4eGw6Zrbwky99w=;
  b=w7zgv6XnxkXqJ5aHbTvdeLDkRoS0hEtKb34rNvo5vYcbcd9QnI9JcXdn
   sNF2w2PM77nl0ImOvfE0dE4c7abzBGknA+5fHNXponM7kFMuTBxrRk9We
   I35Nd1jYrStr6TZ8CWz62BSf/P7c6/0dEHtLnV4u8aXAO2z5g7mypo3Tg
   VYB3bIfCgmoPymtWHwsdghaDxERmG4LBkcKD1fI+nv9aTYnLJWM6zNl8z
   1W8h6dQrkrYwyq6KGB3YrDfcs4g+KNJWovBs7YICJ5wSNjgfuiH7LRJwj
   e00dAwZjrlPtJXSF+6W4LjL63vlW6mo4Z59HHkCIXHDxE+nIn1CYUQRxt
   g==;
X-CSE-ConnectionGUID: yImhGIZkR/em+Zd1QgpE2w==
X-CSE-MsgGUID: 9OPHZcA4QY2OZhyqJhy+pw==
X-IronPort-AV: E=Sophos;i="6.23,222,1770620400"; 
   d="scan'208";a="288577543"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 22:22:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Thu, 7 May 2026 22:22:35 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Thu, 7 May 2026 22:22:32 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3 4/5] net: lan743x: Register SFP platform device for PCI11x1x
Date: Fri, 8 May 2026 10:51:49 +0530
Message-ID: <20260508052150.11852-5-thangaraj.s@microchip.com>
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
X-Rspamd-Queue-Id: 806F94F1EB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thangaraj.s@microchip.com,netdev@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-285636-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[microchip.com:email,microchip.com:mid,microchip.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sfp_info.name:url,sfp_info.id:url]
X-Rspamd-Action: no action

Register an SFP platform device when SFP support is enabled on PCI11x1x
platforms.

Use the software node describing the SFP cage as the firmware node
for the platform device. Associate the I2C adapter with its
corresponding software node for SFP module management over I2C.

Register the SFP platform device during probe and unregister it during
driver cleanup.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/Kconfig        |  1 +
 drivers/net/ethernet/microchip/lan743x_main.c | 51 ++++++++++++++++++-
 drivers/net/ethernet/microchip/lan743x_main.h |  2 +
 3 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/Kconfig b/drivers/net/ethernet/microchip/Kconfig
index a83db3c7404f..9857053dabf8 100644
--- a/drivers/net/ethernet/microchip/Kconfig
+++ b/drivers/net/ethernet/microchip/Kconfig
@@ -52,6 +52,7 @@ config LAN743X
 	select PHYLINK
 	select I2C_PCI1XXXX
 	select GP_PCI1XXXX
+	select SFP
 	help
 	  Support for the Microchip LAN743x and PCI11x1x families of PCI
 	  Express Ethernet devices
diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index b90b35cef2e6..88a2d11552f8 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -3066,6 +3066,31 @@ static int lan743x_swnodes_register(struct lan743x_adapter *adapter)
 	return software_node_register_node_group(nodes->group);
 }
 
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
+	sfp_info.id = (pdev->bus->number << 8) | pdev->devfn;
+	sfp_dev = platform_device_register_full(&sfp_info);
+	if (IS_ERR(sfp_dev)) {
+		netif_err(adapter, drv, adapter->netdev,
+			  "Failed to register SFP device\n");
+		return PTR_ERR(sfp_dev);
+	}
+
+	adapter->sfp_dev = sfp_dev;
+	netif_dbg(adapter, drv, adapter->netdev,
+		  "SFP platform device registered");
+
+	return 0;
+}
+
 static int lan743x_phylink_sgmii_config(struct lan743x_adapter *adapter)
 {
 	u32 sgmii_ctl;
@@ -3682,6 +3707,12 @@ static void lan743x_destroy_phylink(struct lan743x_adapter *adapter)
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
@@ -3909,11 +3940,29 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
 		goto cleanup_mdiobus;
 	}
 
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
index 48db45d41502..fd1c2842b4c8 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.h
+++ b/drivers/net/ethernet/microchip/lan743x_main.h
@@ -9,6 +9,7 @@
 #include <linux/i2c.h>
 #include <linux/phy.h>
 #include <linux/phylink.h>
+#include <linux/platform_device.h>
 #include <linux/property.h>
 #include "lan743x_ptp.h"
 
@@ -1173,6 +1174,7 @@ struct lan743x_adapter {
 	int			rx_tstamp_filter;
 	struct lan743x_sw_nodes *nodes;
 	struct i2c_adapter      *i2c_adap;
+	struct platform_device  *sfp_dev;
 };
 
 #define LAN743X_COMPONENT_FLAG_RX(channel)  BIT(20 + (channel))
-- 
2.34.1


