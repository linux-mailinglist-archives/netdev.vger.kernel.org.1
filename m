Return-Path: <netdev+bounces-229489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D546FBDCDD9
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0C0E3B7025
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3A8313539;
	Wed, 15 Oct 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXE/0qbY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D9299AAF;
	Wed, 15 Oct 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512542; cv=none; b=R0GQvG4RjrXqI6PJ7SBTiD7P5a6oX+W5PnQ9aFyLhXZwt7UmSOSq3VUo+eGfLMVlTnBUo8zMKRWMZvm6XVJGmOWauyuKKc5PP0gFazP2WPgd5CV6Cp6P1EcPa4gfEw5qt1Z2yT9gFNfp52C/9IPdZEJZpbqMWX6vXbN0lrscyY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512542; c=relaxed/simple;
	bh=Ytp39hw63jXTJnCsXV9bBFGBpvPA2tM+uzC7VuneJro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Twu9jqCfgbr0GvpGsHUd5hvKF9pjDLs1B+Ka7zMW8N9+KM4W2jMsKQnje4xBBeunMeiMgz9f4Fml8/3kqfyvpkhK2xIJihGmYjVPF0ABWlMw0gDhjmoJgKVtCfNhcL4+uTmjsisFZO/Tw+GM97EF5gwmFjBqYIeu7XucY0gLEs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXE/0qbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 250BEC4CEF8;
	Wed, 15 Oct 2025 07:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512541;
	bh=Ytp39hw63jXTJnCsXV9bBFGBpvPA2tM+uzC7VuneJro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZXE/0qbYshID5ISmwR7hfRynixtKZHtxJAz/0jB6PQttgvBPdOUa5p0NWkik/bbBY
	 uCguWbc53chNCiBYofzLNzeP2wnX6uzyZUTgNKLcSvh008zrkhJ/90K2wJH6K0NYd5
	 kVICzGuzIlwWf2rrRMmhTrt2bEabGeI/8AjGoSB0XP4lEu1bXeM2Hut6UF96vGMLep
	 4GXn5z+oWrrghR34jYoDRBdQfW0OniTrh36teJW7xrciF7GIz/ylFdpYfOirTNFDjh
	 KnzmaS78xglGyQE4WalUOOSEbHcnH81/coW5ii+ugoFsjKAyNRuh7Ri7tItJyBeWAY
	 Dq3g5dFb2Wc6A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Oct 2025 09:15:04 +0200
Subject: [PATCH net-next 04/12] net: airoha: Add airoha_eth_soc_data struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-an7583-eth-support-v1-4-064855f05923@kernel.org>
References: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
In-Reply-To: <20251015-an7583-eth-support-v1-0-064855f05923@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>
X-Mailer: b4 0.14.2

Introduce airoha_eth_soc_data struct to contain differences between
various SoC. Move XSI reset names in airoha_eth_soc_data. This is a
preliminary patch to enable AN7583 ethernet controller support in
airoha-eth driver.

Co-developed-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 42 +++++++++++++++++++++++++-------
 drivers/net/ethernet/airoha/airoha_eth.h | 17 +++++++++++--
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 6effdda64380bf72ce3c5b6b2f551f560f2ee097..32015c41b58df68a0fe87bb026ee0a6d44ea6ec9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1387,8 +1387,7 @@ static int airoha_hw_init(struct platform_device *pdev,
 	int err, i;
 
 	/* disable xsi */
-	err = reset_control_bulk_assert(ARRAY_SIZE(eth->xsi_rsts),
-					eth->xsi_rsts);
+	err = reset_control_bulk_assert(eth->soc->num_xsi_rsts, eth->xsi_rsts);
 	if (err)
 		return err;
 
@@ -2908,6 +2907,7 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 
 static int airoha_probe(struct platform_device *pdev)
 {
+	struct reset_control_bulk_data *xsi_rsts;
 	struct device_node *np;
 	struct airoha_eth *eth;
 	int i, err;
@@ -2916,6 +2916,10 @@ static int airoha_probe(struct platform_device *pdev)
 	if (!eth)
 		return -ENOMEM;
 
+	eth->soc = of_device_get_match_data(&pdev->dev);
+	if (!eth->soc)
+		return -EINVAL;
+
 	eth->dev = &pdev->dev;
 
 	err = dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));
@@ -2940,13 +2944,18 @@ static int airoha_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	eth->xsi_rsts[0].id = "xsi-mac";
-	eth->xsi_rsts[1].id = "hsi0-mac";
-	eth->xsi_rsts[2].id = "hsi1-mac";
-	eth->xsi_rsts[3].id = "hsi-mac";
-	eth->xsi_rsts[4].id = "xfp-mac";
+	xsi_rsts = devm_kzalloc(eth->dev,
+				eth->soc->num_xsi_rsts * sizeof(*xsi_rsts),
+				GFP_KERNEL);
+	if (err)
+		return err;
+
+	eth->xsi_rsts = xsi_rsts;
+	for (i = 0; i < eth->soc->num_xsi_rsts; i++)
+		eth->xsi_rsts[i].id = eth->soc->xsi_rsts_names[i];
+
 	err = devm_reset_control_bulk_get_exclusive(eth->dev,
-						    ARRAY_SIZE(eth->xsi_rsts),
+						    eth->soc->num_xsi_rsts,
 						    eth->xsi_rsts);
 	if (err) {
 		dev_err(eth->dev, "failed to get bulk xsi reset lines\n");
@@ -3034,8 +3043,23 @@ static void airoha_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 }
 
+static const char * const en7581_xsi_rsts_names[] = {
+	"xsi-mac",
+	"hsi0-mac",
+	"hsi1-mac",
+	"hsi-mac",
+	"xfp-mac",
+};
+
+static const struct airoha_eth_soc_data en7581_soc_data = {
+	.version = 0x7581,
+	.xsi_rsts_names = en7581_xsi_rsts_names,
+	.num_xsi_rsts = ARRAY_SIZE(en7581_xsi_rsts_names),
+	.num_ppe = 2,
+};
+
 static const struct of_device_id of_airoha_match[] = {
-	{ .compatible = "airoha,en7581-eth" },
+	{ .compatible = "airoha,en7581-eth", .data = &en7581_soc_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, of_airoha_match);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 1f7e34a5f457ca2200e9c81dd05dc03cd7c5eb77..cb7e198e40eeb2f44bd6e035cc7b583f47441d59 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -21,7 +21,6 @@
 #define AIROHA_MAX_NUM_IRQ_BANKS	4
 #define AIROHA_MAX_DSA_PORTS		7
 #define AIROHA_MAX_NUM_RSTS		3
-#define AIROHA_MAX_NUM_XSI_RSTS		5
 #define AIROHA_MAX_MTU			9216
 #define AIROHA_MAX_PACKET_SIZE		2048
 #define AIROHA_NUM_QOS_CHANNELS		4
@@ -556,9 +555,18 @@ struct airoha_ppe {
 	struct dentry *debugfs_dir;
 };
 
+struct airoha_eth_soc_data {
+	u16 version;
+	const char * const *xsi_rsts_names;
+	int num_xsi_rsts;
+	int num_ppe;
+};
+
 struct airoha_eth {
 	struct device *dev;
 
+	const struct airoha_eth_soc_data *soc;
+
 	unsigned long state;
 	void __iomem *fe_regs;
 
@@ -568,7 +576,7 @@ struct airoha_eth {
 	struct rhashtable flow_table;
 
 	struct reset_control_bulk_data rsts[AIROHA_MAX_NUM_RSTS];
-	struct reset_control_bulk_data xsi_rsts[AIROHA_MAX_NUM_XSI_RSTS];
+	struct reset_control_bulk_data *xsi_rsts;
 
 	struct net_device *napi_dev;
 
@@ -611,6 +619,11 @@ static inline bool airhoa_is_lan_gdm_port(struct airoha_gdm_port *port)
 	return port->id == 1;
 }
 
+static inline bool airoha_is_7581(struct airoha_eth *eth)
+{
+	return eth->soc->version == 0x7581;
+}
+
 bool airoha_is_valid_gdm_port(struct airoha_eth *eth,
 			      struct airoha_gdm_port *port);
 

-- 
2.51.0


