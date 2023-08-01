Return-Path: <netdev+bounces-23439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E85776BF93
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 23:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812061C21055
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 21:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39A026B9C;
	Tue,  1 Aug 2023 21:54:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D200A214E9
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 21:54:24 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFBC103
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 14:54:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d326cb4c97fso2500329276.0
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690926862; x=1691531662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9t3UVTAg7ytzQSNnMwpet2CewMeyBk+4GY+nBj1yWYc=;
        b=PVlmH0u5uWwrNIq7T4UBmZ1UBub9wl73NmrAtzvHNG9QyGe8k2BMLohhAgCN5cMss9
         oPkS5D377/yJlgU1bH7gmqd2JDPlyLL3IWsyJbrCcDRID4WuW9fBe6o3SoatclppCAyL
         iYnAsB6PQ3cmQFYihKAVcAh9mRr2cwaViJNO/40Gv3fyrZ9x652WqPMp4NLMmdFngX2B
         j4uV3MMrizegKzTQMfHAjLVhbGwlhPIFiNDcbWaJRf6IQXT9VqYwUuIRLk/ZFHigfoVD
         jv0u/rvfeWnu27aiHfkpqqmbvGfaTUwTlZ06bNsfRKFzydD0g0im0fWL/XpUUqufKtDN
         ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690926862; x=1691531662;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9t3UVTAg7ytzQSNnMwpet2CewMeyBk+4GY+nBj1yWYc=;
        b=NfCazvwDSj2qCvyLpLwsjE1b2MqCXhE22gj52YpwEvcRdSfGfFxkgmZG+970r4A9GV
         /oiJ35ztzLrjhLsc2h0Tcmw0xOzQKpnZ5/kdkbDvTgj7fUp+S1Zpo6/35uVHwxwpGB97
         FsTjnM/XtYZDC2G2s9d0OZ/+oU5ce6tQJQ2OCmePB2Ctm/u9VA0qp90lxf7tGZ8ofd36
         dDvIC6JxyE13Z+ctxYUnLnyhYNzTmRcwyTM1jgX4bY2kLRgs6XsrC8A0Wu9bNVsxjm04
         NMqVchRb62wreoqW7HZSnF80AG9GB8oVL7PSPKWut9qo9ha1x8iZCLGNwaIWcMHOir8M
         QxKg==
X-Gm-Message-State: ABy/qLYZrdm5llRP//nWaLEY6lYHU8a39JdciQmm1i1Rnk982UmuRJG8
	O3bhkDdJmV8PQ3B2+oZ/VOb+xrEbnggOQmNw2YXst4X5lg7DIa79Q/jOncc/9MMNa3ECr4R5p0Q
	+dIlODjWpQZBV0WgRs7ltS7wRvaoJs2HuQP51Jqv5OGNY6lyObEz6uZ7orohVf4pz
X-Google-Smtp-Source: APBJJlFQd5tGh+LJoU2J3smYQxNJcR358XLWMhcBeajA+s60x7q3mZydfud+MANjsTxM2YNMtb00BlyBqoIM
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a05:6902:160e:b0:d09:6ba9:69ec with SMTP
 id bw14-20020a056902160e00b00d096ba969ecmr101761ybb.4.1690926862127; Tue, 01
 Aug 2023 14:54:22 -0700 (PDT)
Date: Tue,  1 Aug 2023 21:54:03 +0000
In-Reply-To: <20230801215405.2192259-1-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230801215405.2192259-1-rushilg@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801215405.2192259-2-rushilg@google.com>
Subject: [PATCH net-next 1/4] gve: Control path for DQO-QPL
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com
Cc: Rushil Gupta <rushilg@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bailey Forrest <bcf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add checks, abi-changes and device options to support
QPL mode for DQO in addition to GQI. Also, use
pages-per-qpl supplied by device-option to control the
size of the "queue-page-list".

Signed-off-by: Rushil Gupta <rushilg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        | 20 ++++-
 drivers/net/ethernet/google/gve/gve_adminq.c | 93 +++++++++++++++++---
 drivers/net/ethernet/google/gve/gve_adminq.h | 10 +++
 drivers/net/ethernet/google/gve/gve_main.c   | 20 +++--
 4 files changed, 123 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 4b425bf71ede..517a63b60cb9 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -51,6 +51,12 @@
 
 #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
 
+#define DQO_QPL_DEFAULT_TX_PAGES 512
+#define DQO_QPL_DEFAULT_RX_PAGES 2048
+
+/* Maximum TSO size supported on DQO */
+#define GVE_DQO_TX_MAX	0x3FFFF
+
 /* Each slot in the desc ring has a 1:1 mapping to a slot in the data ring */
 struct gve_rx_desc_queue {
 	struct gve_rx_desc *desc_ring; /* the descriptor ring */
@@ -531,6 +537,7 @@ enum gve_queue_format {
 	GVE_GQI_RDA_FORMAT		= 0x1,
 	GVE_GQI_QPL_FORMAT		= 0x2,
 	GVE_DQO_RDA_FORMAT		= 0x3,
+	GVE_DQO_QPL_FORMAT		= 0x4,
 };
 
 struct gve_priv {
@@ -550,7 +557,8 @@ struct gve_priv {
 	u16 num_event_counters;
 	u16 tx_desc_cnt; /* num desc per ring */
 	u16 rx_desc_cnt; /* num desc per ring */
-	u16 tx_pages_per_qpl; /* tx buffer length */
+	u16 tx_pages_per_qpl; /* Suggested number of pages per qpl for TX queues by NIC */
+	u16 rx_pages_per_qpl; /* Suggested number of pages per qpl for RX queues by NIC */
 	u16 rx_data_slot_cnt; /* rx buffer length */
 	u64 max_registered_pages;
 	u64 num_registered_pages; /* num pages registered with NIC */
@@ -808,11 +816,17 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_priv *priv, u32 queue_idx)
 	return (priv->num_ntfy_blks / 2) + queue_idx;
 }
 
+static inline bool gve_is_qpl(struct gve_priv *priv)
+{
+	return priv->queue_format == GVE_GQI_QPL_FORMAT ||
+		priv->queue_format == GVE_DQO_QPL_FORMAT;
+}
+
 /* Returns the number of tx queue page lists
  */
 static inline u32 gve_num_tx_qpls(struct gve_priv *priv)
 {
-	if (priv->queue_format != GVE_GQI_QPL_FORMAT)
+	if (!gve_is_qpl(priv))
 		return 0;
 
 	return priv->tx_cfg.num_queues + priv->num_xdp_queues;
@@ -832,7 +846,7 @@ static inline u32 gve_num_xdp_qpls(struct gve_priv *priv)
  */
 static inline u32 gve_num_rx_qpls(struct gve_priv *priv)
 {
-	if (priv->queue_format != GVE_GQI_QPL_FORMAT)
+	if (!gve_is_qpl(priv))
 		return 0;
 
 	return priv->rx_cfg.num_queues;
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 252974202a3f..a16e7cf21911 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -39,7 +39,8 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_gqi_rda **dev_op_gqi_rda,
 			     struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			     struct gve_device_option_dqo_rda **dev_op_dqo_rda,
-			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
+			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
+			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
 	u16 option_length = be16_to_cpu(option->option_length);
@@ -112,6 +113,22 @@ void gve_parse_device_option(struct gve_priv *priv,
 		}
 		*dev_op_dqo_rda = (void *)(option + 1);
 		break;
+	case GVE_DEV_OPT_ID_DQO_QPL:
+		if (option_length < sizeof(**dev_op_dqo_qpl) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "DQO QPL", (int)sizeof(**dev_op_dqo_qpl),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_dqo_qpl)) {
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT, "DQO QPL");
+		}
+		*dev_op_dqo_qpl = (void *)(option + 1);
+		break;
 	case GVE_DEV_OPT_ID_JUMBO_FRAMES:
 		if (option_length < sizeof(**dev_op_jumbo_frames) ||
 		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES) {
@@ -146,7 +163,8 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_gqi_rda **dev_op_gqi_rda,
 			   struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			   struct gve_device_option_dqo_rda **dev_op_dqo_rda,
-			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
+			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
+			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
 	struct gve_device_option *dev_opt;
@@ -166,7 +184,8 @@ gve_process_device_options(struct gve_priv *priv,
 
 		gve_parse_device_option(priv, descriptor, dev_opt,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
-					dev_op_dqo_rda, dev_op_jumbo_frames);
+					dev_op_dqo_rda, dev_op_jumbo_frames,
+					dev_op_dqo_qpl);
 		dev_opt = next_opt;
 	}
 
@@ -505,12 +524,24 @@ static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
 
 		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 	} else {
+		u16 comp_ring_size = 0;
+		u32 qpl_id = 0;
+
+		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
+			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
+			comp_ring_size =
+				priv->options_dqo_rda.tx_comp_ring_entries;
+		} else {
+			qpl_id = tx->dqo.qpl->id;
+			comp_ring_size = priv->tx_desc_cnt;
+		}
+		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 		cmd.create_tx_queue.tx_ring_size =
 			cpu_to_be16(priv->tx_desc_cnt);
 		cmd.create_tx_queue.tx_comp_ring_addr =
 			cpu_to_be64(tx->complq_bus_dqo);
 		cmd.create_tx_queue.tx_comp_ring_size =
-			cpu_to_be16(priv->options_dqo_rda.tx_comp_ring_entries);
+			cpu_to_be16(comp_ring_size);
 	}
 
 	return gve_adminq_issue_cmd(priv, &cmd);
@@ -555,6 +586,18 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 		cmd.create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);
 	} else {
+		u16 rx_buff_ring_entries = 0;
+		u32 qpl_id = 0;
+
+		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
+			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
+			rx_buff_ring_entries =
+				priv->options_dqo_rda.rx_buff_ring_entries;
+		} else {
+			qpl_id = rx->dqo.qpl->id;
+			rx_buff_ring_entries = priv->rx_desc_cnt;
+		}
+		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
 		cmd.create_rx_queue.rx_ring_size =
 			cpu_to_be16(priv->rx_desc_cnt);
 		cmd.create_rx_queue.rx_desc_ring_addr =
@@ -564,7 +607,7 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 		cmd.create_rx_queue.packet_buffer_size =
 			cpu_to_be16(priv->data_buffer_size_dqo);
 		cmd.create_rx_queue.rx_buff_ring_size =
-			cpu_to_be16(priv->options_dqo_rda.rx_buff_ring_entries);
+			cpu_to_be16(rx_buff_ring_entries);
 		cmd.create_rx_queue.enable_rsc =
 			!!(priv->dev->features & NETIF_F_LRO);
 	}
@@ -675,9 +718,13 @@ gve_set_desc_cnt_dqo(struct gve_priv *priv,
 		     const struct gve_device_option_dqo_rda *dev_op_dqo_rda)
 {
 	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
+	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
+
+	if (priv->queue_format == GVE_DQO_QPL_FORMAT)
+		return 0;
+
 	priv->options_dqo_rda.tx_comp_ring_entries =
 		be16_to_cpu(dev_op_dqo_rda->tx_comp_ring_entries);
-	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
 	priv->options_dqo_rda.rx_buff_ring_entries =
 		be16_to_cpu(dev_op_dqo_rda->rx_buff_ring_entries);
 
@@ -687,7 +734,9 @@ gve_set_desc_cnt_dqo(struct gve_priv *priv,
 static void gve_enable_supported_features(struct gve_priv *priv,
 					  u32 supported_features_mask,
 					  const struct gve_device_option_jumbo_frames
-						  *dev_op_jumbo_frames)
+					  *dev_op_jumbo_frames,
+					  const struct gve_device_option_dqo_qpl
+					  *dev_op_dqo_qpl)
 {
 	/* Before control reaches this point, the page-size-capped max MTU from
 	 * the gve_device_descriptor field has already been stored in
@@ -699,6 +748,20 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 			 "JUMBO FRAMES device option enabled.\n");
 		priv->dev->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
 	}
+
+	/* Override pages for qpl for DQO-QPL */
+	if (dev_op_dqo_qpl) {
+		dev_info(&priv->pdev->dev,
+			 "DQO QPL device option enabled.\n");
+		priv->tx_pages_per_qpl =
+			be16_to_cpu(dev_op_dqo_qpl->tx_pages_per_qpl);
+		priv->rx_pages_per_qpl =
+			be16_to_cpu(dev_op_dqo_qpl->rx_pages_per_qpl);
+		if (priv->tx_pages_per_qpl == 0)
+			priv->tx_pages_per_qpl = DQO_QPL_DEFAULT_TX_PAGES;
+		if (priv->rx_pages_per_qpl == 0)
+			priv->rx_pages_per_qpl = DQO_QPL_DEFAULT_RX_PAGES;
+	}
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
@@ -707,6 +770,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
 	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
+	struct gve_device_option_dqo_qpl *dev_op_dqo_qpl = NULL;
 	struct gve_device_descriptor *descriptor;
 	u32 supported_features_mask = 0;
 	union gve_adminq_command cmd;
@@ -733,13 +797,14 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 
 	err = gve_process_device_options(priv, descriptor, &dev_op_gqi_rda,
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
-					 &dev_op_jumbo_frames);
+					 &dev_op_jumbo_frames,
+					 &dev_op_dqo_qpl);
 	if (err)
 		goto free_device_descriptor;
 
 	/* If the GQI_RAW_ADDRESSING option is not enabled and the queue format
 	 * is not set to GqiRda, choose the queue format in a priority order:
-	 * DqoRda, GqiRda, GqiQpl. Use GqiQpl as default.
+	 * DqoRda, DqoQpl, GqiRda, GqiQpl. Use GqiQpl as default.
 	 */
 	if (dev_op_dqo_rda) {
 		priv->queue_format = GVE_DQO_RDA_FORMAT;
@@ -747,7 +812,13 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 			 "Driver is running with DQO RDA queue format.\n");
 		supported_features_mask =
 			be32_to_cpu(dev_op_dqo_rda->supported_features_mask);
-	} else if (dev_op_gqi_rda) {
+	} else if (dev_op_dqo_qpl) {
+		priv->queue_format = GVE_DQO_QPL_FORMAT;
+		dev_info(&priv->pdev->dev,
+			 "Driver is running with DQO QPL queue format.\n");
+		supported_features_mask =
+			be32_to_cpu(dev_op_dqo_qpl->supported_features_mask);
+	}  else if (dev_op_gqi_rda) {
 		priv->queue_format = GVE_GQI_RDA_FORMAT;
 		dev_info(&priv->pdev->dev,
 			 "Driver is running with GQI RDA queue format.\n");
@@ -798,7 +869,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
 
 	gve_enable_supported_features(priv, supported_features_mask,
-				      dev_op_jumbo_frames);
+				      dev_op_jumbo_frames, dev_op_dqo_qpl);
 
 free_device_descriptor:
 	dma_free_coherent(&priv->pdev->dev, PAGE_SIZE, descriptor,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index f894beb3deaf..38a22279e863 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -109,6 +109,14 @@ struct gve_device_option_dqo_rda {
 
 static_assert(sizeof(struct gve_device_option_dqo_rda) == 8);
 
+struct gve_device_option_dqo_qpl {
+	__be32 supported_features_mask;
+	__be16 tx_pages_per_qpl;
+	__be16 rx_pages_per_qpl;
+};
+
+static_assert(sizeof(struct gve_device_option_dqo_qpl) == 8);
+
 struct gve_device_option_jumbo_frames {
 	__be32 supported_features_mask;
 	__be16 max_mtu;
@@ -130,6 +138,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_GQI_RDA = 0x2,
 	GVE_DEV_OPT_ID_GQI_QPL = 0x3,
 	GVE_DEV_OPT_ID_DQO_RDA = 0x4,
+	GVE_DEV_OPT_ID_DQO_QPL = 0x7,
 	GVE_DEV_OPT_ID_JUMBO_FRAMES = 0x8,
 };
 
@@ -139,6 +148,7 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_QPL = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES = 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL = 0x0,
 };
 
 enum gve_sup_feature_mask {
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e6f1711d9be0..b40fafe1460a 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -31,7 +31,6 @@
 
 // Minimum amount of time between queue kicks in msec (10 seconds)
 #define MIN_TX_TIMEOUT_GAP (1000 * 10)
-#define DQO_TX_MAX	0x3FFFF
 
 char gve_driver_name[] = "gve";
 const char gve_version_str[] = GVE_VERSION;
@@ -494,7 +493,7 @@ static int gve_setup_device_resources(struct gve_priv *priv)
 		goto abort_with_stats_report;
 	}
 
-	if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
+	if (!gve_is_gqi(priv)) {
 		priv->ptype_lut_dqo = kvzalloc(sizeof(*priv->ptype_lut_dqo),
 					       GFP_KERNEL);
 		if (!priv->ptype_lut_dqo) {
@@ -1085,9 +1084,10 @@ static int gve_alloc_qpls(struct gve_priv *priv)
 	int max_queues = priv->tx_cfg.max_queues + priv->rx_cfg.max_queues;
 	int start_id;
 	int i, j;
+	int page_count;
 	int err;
 
-	if (priv->queue_format != GVE_GQI_QPL_FORMAT)
+	if (!gve_is_qpl(priv))
 		return 0;
 
 	priv->qpls = kvcalloc(max_queues, sizeof(*priv->qpls), GFP_KERNEL);
@@ -1095,17 +1095,25 @@ static int gve_alloc_qpls(struct gve_priv *priv)
 		return -ENOMEM;
 
 	start_id = gve_tx_start_qpl_id(priv);
+	page_count = priv->tx_pages_per_qpl;
 	for (i = start_id; i < start_id + gve_num_tx_qpls(priv); i++) {
 		err = gve_alloc_queue_page_list(priv, i,
-						priv->tx_pages_per_qpl);
+						page_count);
 		if (err)
 			goto free_qpls;
 	}
 
 	start_id = gve_rx_start_qpl_id(priv);
+
+	/* For GQI_QPL number of pages allocated have 1:1 relationship with
+	 * number of descriptors. For DQO, number of pages required are
+	 * more than descriptors (because of out of order completions).
+	 */
+	page_count = priv->queue_format == GVE_GQI_QPL_FORMAT ?
+		priv->rx_data_slot_cnt : priv->rx_pages_per_qpl;
 	for (i = start_id; i < start_id + gve_num_rx_qpls(priv); i++) {
 		err = gve_alloc_queue_page_list(priv, i,
-						priv->rx_data_slot_cnt);
+						page_count);
 		if (err)
 			goto free_qpls;
 	}
@@ -2051,7 +2059,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 
 	/* Big TCP is only supported on DQ*/
 	if (!gve_is_gqi(priv))
-		netif_set_tso_max_size(priv->dev, DQO_TX_MAX);
+		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
 
 	priv->num_registered_pages = 0;
 	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
-- 
2.41.0.585.gd2178a4bd4-goog


