Return-Path: <netdev+bounces-214940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB740B2C36F
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 14:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B6F57A7347
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316F5343D61;
	Tue, 19 Aug 2025 12:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyCR6xx6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CB34321E
	for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755606089; cv=none; b=acs7KvaVFM2iX8GmyG2h73Egr0BksnOzmgJTdNZHqbPyNAaQ9g50uwaZMPkQrLkkmZv86W3U80P4U3df+iVd+Cs6LFB+eDKOBBKg0BSfuYz+cn9EPCvaS8CMG3wvF5Gr6aGPa92TijXSLtrL9+lk1rg4X7OKy6Beeg7LZKmvJvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755606089; c=relaxed/simple;
	bh=yIZC/YPrJ4rvcIHRrzw0y4RwLvWupKfvOlIXCXQTD5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GCtEEDTrARKRqHnfzMLn3KMZmjIsYHcyyDU7fiXrfPeRJPf9wuPTfh4uukQPbovzxvlfZSqlGOKfPJPZ5tJ0rKK1TCvpZoLCX2rNgARz1uXr/kf7wiZK1vmAII4OlYsh8hco9Y8UzsowO23UUCLfGQTwHYrQGqd+hhaEd8cL0dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyCR6xx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C7EC4CEF1;
	Tue, 19 Aug 2025 12:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755606088;
	bh=yIZC/YPrJ4rvcIHRrzw0y4RwLvWupKfvOlIXCXQTD5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lyCR6xx6A4MSRXeDkaCopFfxYD4GHgj7N8r2FxXaJe878BzuWNfvnUcOZaQ6gnnWz
	 qDpFZHav4sHYRclxULOWPjHwqiBwPceSJfYD+jVEqUZHN2we36VIiCEOkKXzFvIwAp
	 JGocN74zHlwXUXe/i0RZa4Am/ja92kcqXjd6rDbfJkPdmBj46UEZeFPaDyf7AYAlHI
	 rFTvlqikR9F+399sMyz9Ai7roF+yXHj9B2Mfodca010tZZpsBJad/VFfJQgKuZs/6S
	 osboNHjB10++zYn94qraxecqHA+JGrkbq0ogUtYgXxQR4u6NFunOQFvXpV2Pjfv+gv
	 IFAbOdawiN3kA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 19 Aug 2025 14:21:07 +0200
Subject: [PATCH net-next 2/3] net: airoha: Add airoha_ppe_dev struct
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-airoha-en7581-wlan-rx-offload-v1-2-71a097e0e2a1@kernel.org>
References: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
In-Reply-To: <20250819-airoha-en7581-wlan-rx-offload-v1-0-71a097e0e2a1@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Introduce airoha_ppe_dev struct as container for PPE offload callbacks
consumed by the MT76 driver during flowtable offload for traffic
received by the wlan NIC and forwarded to the wired one.
Add airoha_ppe_setup_tc_block_cb routine to PPE offload ops for MT76
driver.
Rely on airoha_ppe_dev pointer in airoha_ppe_setup_tc_block_cb
signature.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c  |  4 +-
 drivers/net/ethernet/airoha/airoha_eth.h  |  4 +-
 drivers/net/ethernet/airoha/airoha_npu.c  |  1 -
 drivers/net/ethernet/airoha/airoha_ppe.c  | 68 +++++++++++++++++++++++++++++--
 include/linux/soc/airoha/airoha_offload.h | 35 ++++++++++++++++
 5 files changed, 105 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index e6b802e3d84493508d2dbd248fb1cbfa9ace468f..5a04f90dd3de47ae0ee8e90bfe221618076297e6 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2599,13 +2599,15 @@ static int airoha_dev_setup_tc_block_cb(enum tc_setup_type type,
 					void *type_data, void *cb_priv)
 {
 	struct net_device *dev = cb_priv;
+	struct airoha_gdm_port *port = netdev_priv(dev);
+	struct airoha_eth *eth = port->qdma->eth;
 
 	if (!tc_can_offload(dev))
 		return -EOPNOTSUPP;
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		return airoha_ppe_setup_tc_block_cb(dev, type_data);
+		return airoha_ppe_setup_tc_block_cb(&eth->ppe->dev, type_data);
 	case TC_SETUP_CLSMATCHALL:
 		return airoha_dev_tc_matchall(dev, type_data);
 	default:
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 9f721e2b972f0e547978419701caf532df664910..9060b1d2814e0e4023d42a05ecb5265212df588f 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/reset.h>
+#include <linux/soc/airoha/airoha_offload.h>
 #include <net/dsa.h>
 
 #define AIROHA_MAX_NUM_GDM_PORTS	4
@@ -546,6 +547,7 @@ struct airoha_gdm_port {
 #define AIROHA_RXD4_FOE_ENTRY		GENMASK(15, 0)
 
 struct airoha_ppe {
+	struct airoha_ppe_dev dev;
 	struct airoha_eth *eth;
 
 	void *foe;
@@ -622,7 +624,7 @@ bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 
 void airoha_ppe_check_skb(struct airoha_ppe *ppe, struct sk_buff *skb,
 			  u16 hash);
-int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data);
+int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data);
 int airoha_ppe_init(struct airoha_eth *eth);
 void airoha_ppe_deinit(struct airoha_eth *eth);
 void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port);
diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 1a6b191ae0b0bba2dc0a011b9da4eb5f4686783e..e1d131d6115c10b40a56b63427eec59ea587d22a 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -11,7 +11,6 @@
 #include <linux/of_platform.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/regmap.h>
-#include <linux/soc/airoha/airoha_offload.h>
 
 #include "airoha_eth.h"
 
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 2fabf33a5034d98c46efcaf3934e4ff21bd60e4a..fe050a54cdcc818e18cd781a5c6a0b5cf1b496d6 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -6,8 +6,9 @@
 
 #include <linux/ip.h>
 #include <linux/ipv6.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
 #include <linux/rhashtable.h>
-#include <linux/soc/airoha/airoha_offload.h>
 #include <net/ipv6.h>
 #include <net/pkt_cls.h>
 
@@ -1284,10 +1285,10 @@ static int airoha_ppe_offload_setup(struct airoha_eth *eth)
 	return err;
 }
 
-int airoha_ppe_setup_tc_block_cb(struct net_device *dev, void *type_data)
+int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev, void *type_data)
 {
-	struct airoha_gdm_port *port = netdev_priv(dev);
-	struct airoha_eth *eth = port->qdma->eth;
+	struct airoha_ppe *ppe = dev->priv;
+	struct airoha_eth *eth = ppe->eth;
 	int err = 0;
 
 	mutex_lock(&flow_offload_mutex);
@@ -1340,6 +1341,62 @@ void airoha_ppe_init_upd_mem(struct airoha_gdm_port *port)
 		     PPE_UPDMEM_WR_MASK | PPE_UPDMEM_REQ_MASK);
 }
 
+struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)
+{
+	struct platform_device *pdev;
+	struct device_node *np;
+	struct airoha_eth *eth;
+
+	np = of_parse_phandle(dev->of_node, "airoha,eth", 0);
+	if (!np)
+		return ERR_PTR(-ENODEV);
+
+	pdev = of_find_device_by_node(np);
+
+	if (!pdev) {
+		dev_err(dev, "cannot find device node %s\n", np->name);
+		of_node_put(np);
+		return ERR_PTR(-ENODEV);
+	}
+	of_node_put(np);
+
+	if (!try_module_get(THIS_MODULE)) {
+		dev_err(dev, "failed to get the device driver module\n");
+		goto error_pdev_put;
+	}
+
+	eth = platform_get_drvdata(pdev);
+	if (!eth)
+		goto error_module_put;
+
+	if (!device_link_add(dev, &pdev->dev, DL_FLAG_AUTOREMOVE_SUPPLIER)) {
+		dev_err(&pdev->dev,
+			"failed to create device link to consumer %s\n",
+			dev_name(dev));
+		goto error_module_put;
+	}
+
+	return &eth->ppe->dev;
+
+error_module_put:
+	module_put(THIS_MODULE);
+error_pdev_put:
+	platform_device_put(pdev);
+
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL_GPL(airoha_ppe_get_dev);
+
+void airoha_ppe_put_dev(struct airoha_ppe_dev *dev)
+{
+	struct airoha_ppe *ppe = dev->priv;
+	struct airoha_eth *eth = ppe->eth;
+
+	module_put(THIS_MODULE);
+	put_device(eth->dev);
+}
+EXPORT_SYMBOL_GPL(airoha_ppe_put_dev);
+
 int airoha_ppe_init(struct airoha_eth *eth)
 {
 	struct airoha_ppe *ppe;
@@ -1349,6 +1406,9 @@ int airoha_ppe_init(struct airoha_eth *eth)
 	if (!ppe)
 		return -ENOMEM;
 
+	ppe->dev.ops.setup_tc_block_cb = airoha_ppe_setup_tc_block_cb;
+	ppe->dev.priv = ppe;
+
 	foe_size = PPE_NUM_ENTRIES * sizeof(struct airoha_foe_entry);
 	ppe->foe = dmam_alloc_coherent(eth->dev, foe_size, &ppe->foe_dma,
 				       GFP_KERNEL);
diff --git a/include/linux/soc/airoha/airoha_offload.h b/include/linux/soc/airoha/airoha_offload.h
index 117c63c2448d2bd2a5c108c5baa56a39f6974d91..e05ded67c9e6fb89940e5b152f14c6ea0d7c6c49 100644
--- a/include/linux/soc/airoha/airoha_offload.h
+++ b/include/linux/soc/airoha/airoha_offload.h
@@ -9,6 +9,41 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+struct airoha_ppe_dev {
+	struct {
+		int (*setup_tc_block_cb)(struct airoha_ppe_dev *dev,
+					 void *type_data);
+	} ops;
+
+	void *priv;
+};
+
+#if (IS_BUILTIN(CONFIG_NET_AIROHA) || IS_MODULE(CONFIG_NET_AIROHA))
+struct airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev);
+void airoha_ppe_put_dev(struct airoha_ppe_dev *dev);
+
+static inline int airoha_ppe_dev_setup_tc_block_cb(struct airoha_ppe_dev *dev,
+						   void *type_data)
+{
+	return dev->ops.setup_tc_block_cb(dev, type_data);
+}
+#else
+static inline airoha_ppe_dev *airoha_ppe_get_dev(struct device *dev)
+{
+	return NULL;
+}
+
+static inline void airoha_ppe_put_dev(struct airoha_ppe_dev *dev)
+{
+}
+
+static inline int airoha_ppe_setup_tc_block_cb(struct airoha_ppe_dev *dev,
+					       void *type_data)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
 #define NPU_NUM_CORES		8
 #define NPU_NUM_IRQ		6
 #define NPU_RX0_DESC_NUM	512

-- 
2.50.1


