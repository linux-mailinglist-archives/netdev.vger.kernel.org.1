Return-Path: <netdev+bounces-26963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D9D779AC4
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0EED1C20B2D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D9E329AF;
	Fri, 11 Aug 2023 22:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7632F4E
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:40:11 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386613596
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:40:07 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563379fe16aso3612552a12.3
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691793606; x=1692398406;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YheRmQ02r45dH1hqRH09GS5mNEh4zLl5TuEm0vaGueM=;
        b=zhtAa5Nz4/46vyrbX37yVEwuwTCKGcilT6YKzcEPNoi1KyQPKXIOuv2+PHi6MPA5M0
         ejVw2JR67s3BB1kDdzuX148HDS06YQw8XirEV9Wd/XUxEjUV+RIxC0tmOt9yGTYGPd6+
         itkYW1rl8d1kn3YHZ/u0rKGG/IVVKzPaR+5RgXwN/lX5zqCUqHfOIHA5KEOE8JQqE+jv
         MGbhq4rhIfp+BIpNcqG+P0PcPIjSmEoDA2VQHNMnlXRPI9fchk0wnCb/zMeLDexKyiaW
         IEupYc9LvI2sjD3fHGX7qmgEm3f1pyFpR6OQlIOcjSuB4wN21p0CPolArqoMQjn+N2Cz
         TDNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691793606; x=1692398406;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YheRmQ02r45dH1hqRH09GS5mNEh4zLl5TuEm0vaGueM=;
        b=jA9+xNf686n5NKir1EEbf+azrW8KrBNrhbbVwBJmnvoBsxdZ9+cKGJTO2e+rK4Q5Bg
         u+cDnjQpJsY40henV3X6AWCKpx9HZq6AzaRQdclXldieKGOUuIQZO7koeNhDN/7qkksm
         MhC1rkpz4zW9e2a3yS8qjFDm436A4d63qk9kd8Aoa1no37xAAJDxffPcWnMH7/NtXSNQ
         91DHuQzX/kDMevkcKlR+aDfM02Sk7w7++LXnzTp3YhgjbwnkrMrow6NrdRTMdXVBZaQs
         C+5O+/KEO/F6Whjcwhp4xl8PnDbperywszH7qQdNHWGxp0nD2AHLFqe9KRsuccy/lY7j
         iRHA==
X-Gm-Message-State: AOJu0YxCLa3Xq05fYZwWIgOHjtYQV2F/dbtHh2xbKkPlq3tmItW6+RIp
	C8UvfJ7R7ickbnx4dt4p+cjXozQ4IoPvX+GePlgzZYGsoCQAwuysFz7PVlUYzwWXBvCbHTPgUcC
	Tu7Hd8ksRObg1vcDharUIMZ+nb9bEGQCheoY92XUHVgeXBmi7FhRAQUiQjDFkQe/npZNFcQ==
X-Google-Smtp-Source: AGHT+IHP85OhmYLXzAsb9rcPMjWVAtZq78Y9dcPOfNVD6RneTCeQqmJ4tVXc7yZE3zKxXuqLqBm2TSF08r1falw=
X-Received: from ziweixiao.sea.corp.google.com ([2620:15c:11c:202:789:3bb9:c53d:529d])
 (user=ziweixiao job=sendgmr) by 2002:a63:b55e:0:b0:565:8280:eac5 with SMTP id
 u30-20020a63b55e000000b005658280eac5mr455788pgo.0.1691793606637; Fri, 11 Aug
 2023 15:40:06 -0700 (PDT)
Date: Fri, 11 Aug 2023 15:39:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230811223938.997986-1-ziweixiao@google.com>
Subject: [PATCH net-next] gve: add header split support
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeroen de Borst <jeroendb@google.com>

- Add device option to recive device's packet buffer size and header
  buffer size. The driver will use the header-buffer size to determine
  if header-split is on.
- A dma_pool is introduced for the header buffers. Header buffers are
  always copied directly into the skb header and payload is always added
  as a frag.
- Add header-split and strict-header-split ethtool priv flags. These
  flags control header-split behavior. It can be turned on/off and it
  can be set to 'strict' which will cause the driver to drop all the
  packets that don't have a proper header split.
- Add max-rx-buffer-size priv flag to allow user to switch the packet
  buffer size between max and default(e.g. 4K <-> 2K).
- Add reconfigure rx rings to support the header split and
  max-rx-buffer-size enable/disable switch.

Signed-off-by: Jeroen de Borst <jeroendb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  57 +++-
 drivers/net/ethernet/google/gve/gve_adminq.c  |  77 ++++-
 drivers/net/ethernet/google/gve/gve_adminq.h  |  19 +-
 drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +
 drivers/net/ethernet/google/gve/gve_ethtool.c | 111 ++++++--
 drivers/net/ethernet/google/gve/gve_main.c    | 197 ++++++++-----
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  | 264 ++++++++++++++++--
 drivers/net/ethernet/google/gve/gve_utils.c   |  16 +-
 drivers/net/ethernet/google/gve/gve_utils.h   |   3 +
 9 files changed, 621 insertions(+), 125 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 0d1e681be250..b6f568f0b241 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -48,10 +48,17 @@
 
 #define GVE_RX_BUFFER_SIZE_DQO 2048
 
+#define GVE_MIN_RX_BUFFER_SIZE 2048
+#define GVE_MAX_RX_BUFFER_SIZE 4096
+
 #define GVE_XDP_ACTIONS 5
 
 #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
 
+#define GVE_HEADER_BUFFER_SIZE_MIN 64
+#define GVE_HEADER_BUFFER_SIZE_MAX 256
+#define GVE_HEADER_BUFFER_SIZE_DEFAULT 128
+
 #define DQO_QPL_DEFAULT_TX_PAGES 512
 #define DQO_QPL_DEFAULT_RX_PAGES 2048
 
@@ -145,6 +152,11 @@ struct gve_rx_compl_queue_dqo {
 	u32 mask; /* Mask for indices to the size of the ring */
 };
 
+struct gve_header_buf {
+	u8 *data;
+	dma_addr_t addr;
+};
+
 /* Stores state for tracking buffers posted to HW */
 struct gve_rx_buf_state_dqo {
 	/* The page posted to HW. */
@@ -158,6 +170,9 @@ struct gve_rx_buf_state_dqo {
 	 */
 	u32 last_single_ref_offset;
 
+	/* Pointer to the header buffer when header-split is active */
+	struct gve_header_buf *hdr_buf;
+
 	/* Linked list index to next element in the list, or -1 if none */
 	s16 next;
 };
@@ -247,19 +262,27 @@ struct gve_rx_ring {
 
 			/* track number of used buffers */
 			u16 used_buf_states_cnt;
+
+			/* Array of buffers for header-split */
+			struct gve_header_buf *hdr_bufs;
 		} dqo;
 	};
 
 	u64 rbytes; /* free-running bytes received */
+	u64 rheader_bytes; /* free-running header bytes received */
 	u64 rpackets; /* free-running packets received */
 	u32 cnt; /* free-running total number of completed packets */
 	u32 fill_cnt; /* free-running total number of descs and buffs posted */
 	u32 mask; /* masks the cnt and fill_cnt to the size of the ring */
+	u64 rx_hsplit_pkt; /* free-running packets with headers split */
+	u64 rx_hsplit_hbo_pkt; /* free-running packets with header buffer overflow */
 	u64 rx_copybreak_pkt; /* free-running count of copybreak packets */
 	u64 rx_copied_pkt; /* free-running total number of copied packets */
 	u64 rx_skb_alloc_fail; /* free-running count of skb alloc fails */
 	u64 rx_buf_alloc_fail; /* free-running count of buffer alloc fails */
 	u64 rx_desc_err_dropped_pkt; /* free-running count of packets dropped by descriptor error */
+	/* free-running count of packets dropped by header-split overflow */
+	u64 rx_hsplit_err_dropped_pkt;
 	u64 rx_cont_packet_cnt; /* free-running multi-fragment packets received */
 	u64 rx_frag_flip_cnt; /* free-running count of rx segments where page_flip was used */
 	u64 rx_frag_copy_cnt; /* free-running count of rx segments copied */
@@ -711,6 +734,7 @@ struct gve_priv {
 	u64 stats_report_len;
 	dma_addr_t stats_report_bus; /* dma address for the stats report */
 	unsigned long ethtool_flags;
+	unsigned long ethtool_defaults; /* default flags */
 
 	unsigned long stats_report_timer_period;
 	struct timer_list stats_report_timer;
@@ -724,12 +748,20 @@ struct gve_priv {
 
 	/* Must be a power of two. */
 	int data_buffer_size_dqo;
+	int dev_max_rx_buffer_size; /* The max rx buffer size that device support*/
 
 	enum gve_queue_format queue_format;
 
 	/* Interrupt coalescing settings */
 	u32 tx_coalesce_usecs;
 	u32 rx_coalesce_usecs;
+
+	/* The size of buffers to allocate for the headers.
+	 * A non-zero value enables header-split.
+	 */
+	u16 header_buf_size;
+	u8 header_split_strict;
+	struct dma_pool *header_buf_pool;
 };
 
 enum gve_service_task_flags_bit {
@@ -747,9 +779,18 @@ enum gve_state_flags_bit {
 };
 
 enum gve_ethtool_flags_bit {
-	GVE_PRIV_FLAGS_REPORT_STATS		= 0,
+	GVE_PRIV_FLAGS_REPORT_STATS		  = 0,
+	GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT	  = 1,
+	GVE_PRIV_FLAGS_ENABLE_STRICT_HEADER_SPLIT = 2,
+	GVE_PRIV_FLAGS_ENABLE_MAX_RX_BUFFER_SIZE  = 3,
 };
 
+#define GVE_PRIV_FLAGS_MASK \
+	(BIT(GVE_PRIV_FLAGS_REPORT_STATS)		| \
+	 BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT)	| \
+	 BIT(GVE_PRIV_FLAGS_ENABLE_STRICT_HEADER_SPLIT)	| \
+	 BIT(GVE_PRIV_FLAGS_ENABLE_MAX_RX_BUFFER_SIZE))
+
 static inline bool gve_get_do_reset(struct gve_priv *priv)
 {
 	return test_bit(GVE_PRIV_FLAGS_DO_RESET, &priv->service_task_flags);
@@ -883,6 +924,16 @@ static inline void gve_clear_report_stats(struct gve_priv *priv)
 	clear_bit(GVE_PRIV_FLAGS_REPORT_STATS, &priv->ethtool_flags);
 }
 
+static inline bool gve_get_enable_header_split(struct gve_priv *priv)
+{
+	return test_bit(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT, &priv->ethtool_flags);
+}
+
+static inline bool gve_get_enable_max_rx_buffer_size(struct gve_priv *priv)
+{
+	return test_bit(GVE_PRIV_FLAGS_ENABLE_MAX_RX_BUFFER_SIZE, &priv->ethtool_flags);
+}
+
 /* Returns the address of the ntfy_blocks irq doorbell
  */
 static inline __be32 __iomem *gve_irq_doorbell(struct gve_priv *priv,
@@ -1056,6 +1107,10 @@ int gve_rx_poll(struct gve_notify_block *block, int budget);
 bool gve_rx_work_pending(struct gve_rx_ring *rx);
 int gve_rx_alloc_rings(struct gve_priv *priv);
 void gve_rx_free_rings_gqi(struct gve_priv *priv);
+int gve_recreate_rx_rings(struct gve_priv *priv);
+int gve_reconfigure_rx_rings(struct gve_priv *priv,
+			     bool enable_hdr_split,
+			     int packet_buffer_size);
 /* Reset */
 void gve_schedule_reset(struct gve_priv *priv);
 int gve_reset(struct gve_priv *priv, bool attempt_teardown);
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 79db7a6d42bc..ee4bdaef8e63 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -40,7 +40,8 @@ void gve_parse_device_option(struct gve_priv *priv,
 			     struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			     struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
-			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
+			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
+			     struct gve_device_option_buffer_sizes **dev_op_buffer_sizes)
 {
 	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
 	u16 option_length = be16_to_cpu(option->option_length);
@@ -147,6 +148,26 @@ void gve_parse_device_option(struct gve_priv *priv,
 		}
 		*dev_op_jumbo_frames = (void *)(option + 1);
 		break;
+	case GVE_DEV_OPT_ID_BUFFER_SIZES:
+		if (option_length < sizeof(**dev_op_buffer_sizes) ||
+		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES) {
+			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
+				 "Buffer Sizes",
+				 (int)sizeof(**dev_op_buffer_sizes),
+				 GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES,
+				 option_length, req_feat_mask);
+			break;
+		}
+
+		if (option_length > sizeof(**dev_op_buffer_sizes)) {
+			dev_warn(&priv->pdev->dev,
+				 GVE_DEVICE_OPTION_TOO_BIG_FMT,
+				 "Buffer Sizes");
+		}
+		*dev_op_buffer_sizes = (void *)(option + 1);
+		if ((*dev_op_buffer_sizes)->header_buffer_size)
+			priv->ethtool_defaults |= BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT);
+		break;
 	default:
 		/* If we don't recognize the option just continue
 		 * without doing anything.
@@ -164,7 +185,8 @@ gve_process_device_options(struct gve_priv *priv,
 			   struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
 			   struct gve_device_option_dqo_rda **dev_op_dqo_rda,
 			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
-			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
+			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl,
+			   struct gve_device_option_buffer_sizes **dev_op_buffer_sizes)
 {
 	const int num_options = be16_to_cpu(descriptor->num_device_options);
 	struct gve_device_option *dev_opt;
@@ -185,7 +207,7 @@ gve_process_device_options(struct gve_priv *priv,
 		gve_parse_device_option(priv, descriptor, dev_opt,
 					dev_op_gqi_rda, dev_op_gqi_qpl,
 					dev_op_dqo_rda, dev_op_jumbo_frames,
-					dev_op_dqo_qpl);
+					dev_op_dqo_qpl, dev_op_buffer_sizes);
 		dev_opt = next_opt;
 	}
 
@@ -610,6 +632,9 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
 			cpu_to_be16(rx_buff_ring_entries);
 		cmd.create_rx_queue.enable_rsc =
 			!!(priv->dev->features & NETIF_F_LRO);
+		if (rx->dqo.hdr_bufs)
+			cmd.create_rx_queue.header_buffer_size =
+				cpu_to_be16(priv->header_buf_size);
 	}
 
 	return gve_adminq_issue_cmd(priv, &cmd);
@@ -736,8 +761,12 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 					  const struct gve_device_option_jumbo_frames
 					  *dev_op_jumbo_frames,
 					  const struct gve_device_option_dqo_qpl
-					  *dev_op_dqo_qpl)
+					  *dev_op_dqo_qpl,
+					  const struct gve_device_option_buffer_sizes
+					  *dev_op_buffer_sizes)
 {
+	int buf_size;
+
 	/* Before control reaches this point, the page-size-capped max MTU from
 	 * the gve_device_descriptor field has already been stored in
 	 * priv->dev->max_mtu. We overwrite it with the true max MTU below.
@@ -760,10 +789,44 @@ static void gve_enable_supported_features(struct gve_priv *priv,
 		if (priv->rx_pages_per_qpl == 0)
 			priv->rx_pages_per_qpl = DQO_QPL_DEFAULT_RX_PAGES;
 	}
+
+	priv->data_buffer_size_dqo = GVE_RX_BUFFER_SIZE_DQO;
+	priv->dev_max_rx_buffer_size = GVE_RX_BUFFER_SIZE_DQO;
+	priv->header_buf_size = 0;
+
+	if (dev_op_buffer_sizes &&
+	    (supported_features_mask & GVE_SUP_BUFFER_SIZES_MASK)) {
+		dev_info(&priv->pdev->dev,
+			 "BUFFER SIZES device option enabled.\n");
+		buf_size = be16_to_cpu(dev_op_buffer_sizes->packet_buffer_size);
+		if (buf_size) {
+			priv->dev_max_rx_buffer_size = buf_size;
+			if (priv->dev_max_rx_buffer_size &
+				(priv->dev_max_rx_buffer_size - 1))
+				priv->dev_max_rx_buffer_size = GVE_RX_BUFFER_SIZE_DQO;
+			if (priv->dev_max_rx_buffer_size < GVE_MIN_RX_BUFFER_SIZE)
+				priv->dev_max_rx_buffer_size = GVE_MIN_RX_BUFFER_SIZE;
+			if (priv->dev_max_rx_buffer_size > GVE_MAX_RX_BUFFER_SIZE)
+				priv->dev_max_rx_buffer_size = GVE_MAX_RX_BUFFER_SIZE;
+		}
+		buf_size = be16_to_cpu(dev_op_buffer_sizes->header_buffer_size);
+		if (buf_size) {
+			priv->header_buf_size = buf_size;
+			if (priv->header_buf_size & (priv->header_buf_size - 1))
+				priv->header_buf_size =
+					GVE_HEADER_BUFFER_SIZE_DEFAULT;
+			if (priv->header_buf_size < GVE_HEADER_BUFFER_SIZE_MIN)
+				priv->header_buf_size = GVE_HEADER_BUFFER_SIZE_MIN;
+			if (priv->header_buf_size > GVE_HEADER_BUFFER_SIZE_MAX)
+				priv->header_buf_size = GVE_HEADER_BUFFER_SIZE_MAX;
+		}
+	}
+
 }
 
 int gve_adminq_describe_device(struct gve_priv *priv)
 {
+	struct gve_device_option_buffer_sizes *dev_op_buffer_sizes = NULL;
 	struct gve_device_option_jumbo_frames *dev_op_jumbo_frames = NULL;
 	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
 	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
@@ -796,7 +859,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	err = gve_process_device_options(priv, descriptor, &dev_op_gqi_rda,
 					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
 					 &dev_op_jumbo_frames,
-					 &dev_op_dqo_qpl);
+					 &dev_op_dqo_qpl,
+					 &dev_op_buffer_sizes);
 	if (err)
 		goto free_device_descriptor;
 
@@ -865,7 +929,8 @@ int gve_adminq_describe_device(struct gve_priv *priv)
 	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
 
 	gve_enable_supported_features(priv, supported_features_mask,
-				      dev_op_jumbo_frames, dev_op_dqo_qpl);
+				    dev_op_jumbo_frames, dev_op_dqo_qpl,
+					  dev_op_buffer_sizes);
 
 free_device_descriptor:
 	dma_free_coherent(&priv->pdev->dev, PAGE_SIZE, descriptor,
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
index 38a22279e863..1b3b67f74ef1 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.h
+++ b/drivers/net/ethernet/google/gve/gve_adminq.h
@@ -125,6 +125,14 @@ struct gve_device_option_jumbo_frames {
 
 static_assert(sizeof(struct gve_device_option_jumbo_frames) == 8);
 
+struct gve_device_option_buffer_sizes {
+	__be32 supported_features_mask;
+	__be16 packet_buffer_size;
+	__be16 header_buffer_size;
+};
+
+static_assert(sizeof(struct gve_device_option_buffer_sizes) == 8);
+
 /* Terminology:
  *
  * RDA - Raw DMA Addressing - Buffers associated with SKBs are directly DMA
@@ -140,6 +148,7 @@ enum gve_dev_opt_id {
 	GVE_DEV_OPT_ID_DQO_RDA = 0x4,
 	GVE_DEV_OPT_ID_DQO_QPL = 0x7,
 	GVE_DEV_OPT_ID_JUMBO_FRAMES = 0x8,
+	GVE_DEV_OPT_ID_BUFFER_SIZES = 0xa,
 };
 
 enum gve_dev_opt_req_feat_mask {
@@ -149,10 +158,12 @@ enum gve_dev_opt_req_feat_mask {
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES = 0x0,
 	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL = 0x0,
+	GVE_DEV_OPT_REQ_FEAT_MASK_BUFFER_SIZES = 0x0,
 };
 
 enum gve_sup_feature_mask {
 	GVE_SUP_JUMBO_FRAMES_MASK = 1 << 2,
+	GVE_SUP_BUFFER_SIZES_MASK = 1 << 4,
 };
 
 #define GVE_DEV_OPT_LEN_GQI_RAW_ADDRESSING 0x0
@@ -165,6 +176,7 @@ enum gve_driver_capbility {
 	gve_driver_capability_dqo_qpl = 2, /* reserved for future use */
 	gve_driver_capability_dqo_rda = 3,
 	gve_driver_capability_alt_miss_compl = 4,
+	gve_driver_capability_flexible_buffer_size = 5,
 };
 
 #define GVE_CAP1(a) BIT((int)a)
@@ -176,7 +188,8 @@ enum gve_driver_capbility {
 	(GVE_CAP1(gve_driver_capability_gqi_qpl) | \
 	 GVE_CAP1(gve_driver_capability_gqi_rda) | \
 	 GVE_CAP1(gve_driver_capability_dqo_rda) | \
-	 GVE_CAP1(gve_driver_capability_alt_miss_compl))
+	 GVE_CAP1(gve_driver_capability_alt_miss_compl) | \
+	 GVE_CAP1(gve_driver_capability_flexible_buffer_size))
 
 #define GVE_DRIVER_CAPABILITY_FLAGS2 0x0
 #define GVE_DRIVER_CAPABILITY_FLAGS3 0x0
@@ -259,7 +272,9 @@ struct gve_adminq_create_rx_queue {
 	__be16 packet_buffer_size;
 	__be16 rx_buff_ring_size;
 	u8 enable_rsc;
-	u8 padding[5];
+	u8 padding1;
+	__be16 header_buffer_size;
+	u8 padding2[2];
 };
 
 static_assert(sizeof(struct gve_adminq_create_rx_queue) == 56);
diff --git a/drivers/net/ethernet/google/gve/gve_dqo.h b/drivers/net/ethernet/google/gve/gve_dqo.h
index 1eb4d5fd8561..138aef23f732 100644
--- a/drivers/net/ethernet/google/gve/gve_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_dqo.h
@@ -39,10 +39,12 @@ int gve_tx_alloc_rings_dqo(struct gve_priv *priv);
 void gve_tx_free_rings_dqo(struct gve_priv *priv);
 int gve_rx_alloc_rings_dqo(struct gve_priv *priv);
 void gve_rx_free_rings_dqo(struct gve_priv *priv);
+void gve_rx_reset_rings_dqo(struct gve_priv *priv);
 int gve_clean_tx_done_dqo(struct gve_priv *priv, struct gve_tx_ring *tx,
 			  struct napi_struct *napi);
 void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx);
 void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx);
+int gve_rx_handle_hdr_resources_dqo(struct gve_priv *priv, bool enable_hdr_split);
 
 static inline void
 gve_tx_put_doorbell_dqo(const struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index 233e5946905e..bcae140784cd 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -40,15 +40,17 @@ static u32 gve_get_msglevel(struct net_device *netdev)
  * as declared in enum xdp_action inside file uapi/linux/bpf.h .
  */
 static const char gve_gstrings_main_stats[][ETH_GSTRING_LEN] = {
-	"rx_packets", "tx_packets", "rx_bytes", "tx_bytes",
-	"rx_dropped", "tx_dropped", "tx_timeouts",
+	"rx_packets", "rx_packets_sph", "rx_packets_hbo", "tx_packets",
+	"rx_bytes", "tx_bytes", "rx_dropped", "tx_dropped", "tx_timeouts",
 	"rx_skb_alloc_fail", "rx_buf_alloc_fail", "rx_desc_err_dropped_pkt",
+	"rx_hsplit_err_dropped_pkt",
 	"interface_up_cnt", "interface_down_cnt", "reset_cnt",
 	"page_alloc_fail", "dma_mapping_error", "stats_report_trigger_cnt",
 };
 
 static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
-	"rx_posted_desc[%u]", "rx_completed_desc[%u]", "rx_consumed_desc[%u]", "rx_bytes[%u]",
+	"rx_posted_desc[%u]", "rx_completed_desc[%u]", "rx_consumed_desc[%u]",
+	"rx_bytes[%u]", "rx_header_bytes[%u]",
 	"rx_cont_packet_cnt[%u]", "rx_frag_flip_cnt[%u]", "rx_frag_copy_cnt[%u]",
 	"rx_frag_alloc_cnt[%u]",
 	"rx_dropped_pkt[%u]", "rx_copybreak_pkt[%u]", "rx_copied_pkt[%u]",
@@ -77,7 +79,8 @@ static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
 };
 
 static const char gve_gstrings_priv_flags[][ETH_GSTRING_LEN] = {
-	"report-stats",
+	"report-stats", "enable-header-split", "enable-strict-header-split",
+	"enable-max-rx-buffer-size"
 };
 
 #define GVE_MAIN_STATS_LEN  ARRAY_SIZE(gve_gstrings_main_stats)
@@ -154,11 +157,13 @@ static void
 gve_get_ethtool_stats(struct net_device *netdev,
 		      struct ethtool_stats *stats, u64 *data)
 {
-	u64 tmp_rx_pkts, tmp_rx_bytes, tmp_rx_skb_alloc_fail,
-		tmp_rx_buf_alloc_fail, tmp_rx_desc_err_dropped_pkt,
+	u64 tmp_rx_pkts, tmp_rx_pkts_sph, tmp_rx_pkts_hbo, tmp_rx_bytes,
+		tmp_rx_hbytes, tmp_rx_skb_alloc_fail, tmp_rx_buf_alloc_fail,
+		tmp_rx_desc_err_dropped_pkt, tmp_rx_hsplit_err_dropped_pkt,
 		tmp_tx_pkts, tmp_tx_bytes;
-	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_pkts,
-		rx_skb_alloc_fail, rx_bytes, tx_pkts, tx_bytes, tx_dropped;
+	u64 rx_buf_alloc_fail, rx_desc_err_dropped_pkt, rx_hsplit_err_dropped_pkt,
+		rx_pkts, rx_pkts_sph, rx_pkts_hbo, rx_skb_alloc_fail, rx_bytes,
+		tx_pkts, tx_bytes, tx_dropped;
 	int stats_idx, base_stats_idx, max_stats_idx;
 	struct stats *report_stats;
 	int *rx_qid_to_stats_idx;
@@ -185,8 +190,10 @@ gve_get_ethtool_stats(struct net_device *netdev,
 		kfree(rx_qid_to_stats_idx);
 		return;
 	}
-	for (rx_pkts = 0, rx_bytes = 0, rx_skb_alloc_fail = 0,
-	     rx_buf_alloc_fail = 0, rx_desc_err_dropped_pkt = 0, ring = 0;
+	for (rx_pkts = 0, rx_bytes = 0, rx_pkts_sph = 0, rx_pkts_hbo = 0,
+	     rx_skb_alloc_fail = 0, rx_buf_alloc_fail = 0,
+	     rx_desc_err_dropped_pkt = 0, rx_hsplit_err_dropped_pkt = 0,
+	     ring = 0;
 	     ring < priv->rx_cfg.num_queues; ring++) {
 		if (priv->rx) {
 			do {
@@ -195,18 +202,25 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				start =
 				  u64_stats_fetch_begin(&priv->rx[ring].statss);
 				tmp_rx_pkts = rx->rpackets;
+				tmp_rx_pkts_sph = rx->rx_hsplit_pkt;
+				tmp_rx_pkts_hbo = rx->rx_hsplit_hbo_pkt;
 				tmp_rx_bytes = rx->rbytes;
 				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
 					rx->rx_desc_err_dropped_pkt;
+				tmp_rx_hsplit_err_dropped_pkt =
+					rx->rx_hsplit_err_dropped_pkt;
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			rx_pkts += tmp_rx_pkts;
+			rx_pkts_sph += tmp_rx_pkts_sph;
+			rx_pkts_hbo += tmp_rx_pkts_hbo;
 			rx_bytes += tmp_rx_bytes;
 			rx_skb_alloc_fail += tmp_rx_skb_alloc_fail;
 			rx_buf_alloc_fail += tmp_rx_buf_alloc_fail;
 			rx_desc_err_dropped_pkt += tmp_rx_desc_err_dropped_pkt;
+			rx_hsplit_err_dropped_pkt += tmp_rx_hsplit_err_dropped_pkt;
 		}
 	}
 	for (tx_pkts = 0, tx_bytes = 0, tx_dropped = 0, ring = 0;
@@ -227,6 +241,8 @@ gve_get_ethtool_stats(struct net_device *netdev,
 
 	i = 0;
 	data[i++] = rx_pkts;
+	data[i++] = rx_pkts_sph;
+	data[i++] = rx_pkts_hbo;
 	data[i++] = tx_pkts;
 	data[i++] = rx_bytes;
 	data[i++] = tx_bytes;
@@ -238,6 +254,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 	data[i++] = rx_skb_alloc_fail;
 	data[i++] = rx_buf_alloc_fail;
 	data[i++] = rx_desc_err_dropped_pkt;
+	data[i++] = rx_hsplit_err_dropped_pkt;
 	data[i++] = priv->interface_up_cnt;
 	data[i++] = priv->interface_down_cnt;
 	data[i++] = priv->reset_cnt;
@@ -277,6 +294,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 				start =
 				  u64_stats_fetch_begin(&priv->rx[ring].statss);
 				tmp_rx_bytes = rx->rbytes;
+				tmp_rx_hbytes = rx->rheader_bytes;
 				tmp_rx_skb_alloc_fail = rx->rx_skb_alloc_fail;
 				tmp_rx_buf_alloc_fail = rx->rx_buf_alloc_fail;
 				tmp_rx_desc_err_dropped_pkt =
@@ -284,6 +302,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 			} while (u64_stats_fetch_retry(&priv->rx[ring].statss,
 						       start));
 			data[i++] = tmp_rx_bytes;
+			data[i++] = tmp_rx_hbytes;
 			data[i++] = rx->rx_cont_packet_cnt;
 			data[i++] = rx->rx_frag_flip_cnt;
 			data[i++] = rx->rx_frag_copy_cnt;
@@ -535,30 +554,72 @@ static int gve_set_tunable(struct net_device *netdev,
 static u32 gve_get_priv_flags(struct net_device *netdev)
 {
 	struct gve_priv *priv = netdev_priv(netdev);
-	u32 ret_flags = 0;
-
-	/* Only 1 flag exists currently: report-stats (BIT(O)), so set that flag. */
-	if (priv->ethtool_flags & BIT(0))
-		ret_flags |= BIT(0);
-	return ret_flags;
+	return priv->ethtool_flags & GVE_PRIV_FLAGS_MASK;
 }
 
 static int gve_set_priv_flags(struct net_device *netdev, u32 flags)
 {
 	struct gve_priv *priv = netdev_priv(netdev);
-	u64 ori_flags, new_flags;
+	u64 ori_flags, new_flags, flag_diff;
 	int num_tx_queues;
+	int new_packet_buffer_size;
 
 	num_tx_queues = gve_num_tx_queues(priv);
+
+	/* If turning off header split, strict header split will be turned off too*/
+	if (gve_get_enable_header_split(priv) &&
+	    !(flags & BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT))) {
+		flags &= ~BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT);
+		flags &= ~BIT(GVE_PRIV_FLAGS_ENABLE_STRICT_HEADER_SPLIT);
+	}
+
+	/* If strict header-split is requested, turn on regular header-split */
+	if (flags & BIT(GVE_PRIV_FLAGS_ENABLE_STRICT_HEADER_SPLIT))
+		flags |= BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT);
+
+	/* Make sure header-split is available */
+	if ((flags & BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT)) &&
+	    !(priv->ethtool_defaults & BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT))) {
+		dev_err(&priv->pdev->dev,
+			"Header-split not available\n");
+		return -EINVAL;
+	}
+
+	if ((flags & BIT(GVE_PRIV_FLAGS_ENABLE_MAX_RX_BUFFER_SIZE)) &&
+	    priv->dev_max_rx_buffer_size <= GVE_MIN_RX_BUFFER_SIZE) {
+		dev_err(&priv->pdev->dev,
+			"Max-rx-buffer-size not available\n");
+		return -EINVAL;
+	}
+
 	ori_flags = READ_ONCE(priv->ethtool_flags);
-	new_flags = ori_flags;
 
-	/* Only one priv flag exists: report-stats (BIT(0))*/
-	if (flags & BIT(0))
-		new_flags |= BIT(0);
-	else
-		new_flags &= ~(BIT(0));
+	new_flags = flags & GVE_PRIV_FLAGS_MASK;
+
+	flag_diff = new_flags ^ ori_flags;
+
+	if ((flag_diff & BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT)) ||
+	    (flag_diff & BIT(GVE_PRIV_FLAGS_ENABLE_MAX_RX_BUFFER_SIZE))) {
+		bool enable_hdr_split =
+			new_flags & BIT(GVE_PRIV_FLAGS_ENABLE_HEADER_SPLIT);
+		bool enable_max_buffer_size =
+			new_flags & BIT(GVE_PRIV_FLAGS_ENABLE_MAX_RX_BUFFER_SIZE);
+		int err;
+
+		if (enable_max_buffer_size)
+			new_packet_buffer_size = priv->dev_max_rx_buffer_size;
+		else
+			new_packet_buffer_size = GVE_RX_BUFFER_SIZE_DQO;
+
+		err = gve_reconfigure_rx_rings(priv,
+					       enable_hdr_split,
+					      new_packet_buffer_size);
+		if (err)
+			return err;
+	}
+
 	priv->ethtool_flags = new_flags;
+
 	/* start report-stats timer when user turns report stats on. */
 	if (flags & BIT(0)) {
 		mod_timer(&priv->stats_report_timer,
@@ -577,6 +638,10 @@ static int gve_set_priv_flags(struct net_device *netdev, u32 flags)
 				   sizeof(struct stats));
 		del_timer_sync(&priv->stats_report_timer);
 	}
+	priv->header_split_strict =
+		(priv->ethtool_flags &
+		 BIT(GVE_PRIV_FLAGS_ENABLE_STRICT_HEADER_SPLIT)) ? true : false;
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 5704b5f57cd0..93443784c3cf 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -688,45 +688,11 @@ static int gve_unregister_qpls(struct gve_priv *priv)
 	return 0;
 }
 
-static int gve_create_xdp_rings(struct gve_priv *priv)
-{
-	int err;
-
-	err = gve_adminq_create_tx_queues(priv,
-					  gve_xdp_tx_start_queue_id(priv),
-					  priv->num_xdp_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d XDP tx queues\n",
-			  priv->num_xdp_queues);
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d XDP tx queues\n",
-		  priv->num_xdp_queues);
-
-	return 0;
-}
-
-static int gve_create_rings(struct gve_priv *priv)
+static int gve_create_rx_rings(struct gve_priv *priv)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 	int i;
 
-	err = gve_adminq_create_tx_queues(priv, 0, num_tx_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
-			  num_tx_queues);
-		/* This failure will trigger a reset - no need to clean
-		 * up
-		 */
-		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
-		  num_tx_queues);
-
 	err = gve_adminq_create_rx_queues(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		netif_err(priv, drv, priv->dev, "failed to create %d rx queues\n",
@@ -758,6 +724,50 @@ static int gve_create_rings(struct gve_priv *priv)
 	return 0;
 }
 
+static int gve_create_tx_rings(struct gve_priv *priv, int start_id, u32 num_tx_queues)
+{
+	int err;
+
+	err = gve_adminq_create_tx_queues(priv, start_id, num_tx_queues);
+	if (err) {
+		netif_err(priv, drv, priv->dev, "failed to create %d tx queues\n",
+			  num_tx_queues);
+		/* This failure will trigger a reset - no need to clean
+		 * up
+		 */
+		return err;
+	}
+	netif_dbg(priv, drv, priv->dev, "created %d tx queues\n",
+		  num_tx_queues);
+
+	return 0;
+}
+
+static int gve_create_xdp_rings(struct gve_priv *priv)
+{
+	int err;
+
+	err = gve_create_tx_rings(priv,
+				  gve_xdp_tx_start_queue_id(priv),
+				  priv->num_xdp_queues);
+
+	return err;
+}
+
+static int gve_create_rings(struct gve_priv *priv)
+{
+	int num_tx_queues = gve_num_tx_queues(priv);
+	int err;
+
+	err = gve_create_tx_rings(priv, 0, num_tx_queues);
+	if (err)
+		return err;
+
+	err = gve_create_rx_rings(priv);
+
+	return err;
+}
+
 static void add_napi_init_xdp_sync_stats(struct gve_priv *priv,
 					 int (*napi_poll)(struct napi_struct *napi,
 							  int budget))
@@ -875,32 +885,27 @@ static int gve_alloc_rings(struct gve_priv *priv)
 	return err;
 }
 
-static int gve_destroy_xdp_rings(struct gve_priv *priv)
+static int gve_destroy_rx_rings(struct gve_priv *priv)
 {
-	int start_id;
 	int err;
 
-	start_id = gve_xdp_tx_start_queue_id(priv);
-	err = gve_adminq_destroy_tx_queues(priv,
-					   start_id,
-					   priv->num_xdp_queues);
+	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
 	if (err) {
 		netif_err(priv, drv, priv->dev,
-			  "failed to destroy XDP queues\n");
+			  "failed to destroy rx queues\n");
 		/* This failure will trigger a reset - no need to clean up */
 		return err;
 	}
-	netif_dbg(priv, drv, priv->dev, "destroyed XDP queues\n");
+	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
 
 	return 0;
 }
 
-static int gve_destroy_rings(struct gve_priv *priv)
+static int gve_destroy_tx_rings(struct gve_priv *priv, int start_id, u32 num_queues)
 {
-	int num_tx_queues = gve_num_tx_queues(priv);
 	int err;
 
-	err = gve_adminq_destroy_tx_queues(priv, 0, num_tx_queues);
+	err = gve_adminq_destroy_tx_queues(priv, start_id, num_queues);
 	if (err) {
 		netif_err(priv, drv, priv->dev,
 			  "failed to destroy tx queues\n");
@@ -908,14 +913,35 @@ static int gve_destroy_rings(struct gve_priv *priv)
 		return err;
 	}
 	netif_dbg(priv, drv, priv->dev, "destroyed tx queues\n");
-	err = gve_adminq_destroy_rx_queues(priv, priv->rx_cfg.num_queues);
-	if (err) {
-		netif_err(priv, drv, priv->dev,
-			  "failed to destroy rx queues\n");
-		/* This failure will trigger a reset - no need to clean up */
+
+	return 0;
+}
+
+static int gve_destroy_xdp_rings(struct gve_priv *priv)
+{
+	int start_id;
+	int err;
+
+	start_id = gve_xdp_tx_start_queue_id(priv);
+	err = gve_destroy_tx_rings(priv,
+				   start_id,
+				   priv->num_xdp_queues);
+
+	return err;
+}
+
+static int gve_destroy_rings(struct gve_priv *priv)
+{
+	int num_tx_queues = gve_num_tx_queues(priv);
+	int err;
+
+	err = gve_destroy_tx_rings(priv, 0, num_tx_queues);
+	if (err)
+		return err;
+
+	err = gve_destroy_rx_rings(priv);
+	if (err)
 		return err;
-	}
-	netif_dbg(priv, drv, priv->dev, "destroyed rx queues\n");
 	return 0;
 }
 
@@ -1306,12 +1332,6 @@ static int gve_open(struct net_device *dev)
 	if (err)
 		goto reset;
 
-	if (!gve_is_gqi(priv)) {
-		/* Hard code this for now. This may be tuned in the future for
-		 * performance.
-		 */
-		priv->data_buffer_size_dqo = GVE_RX_BUFFER_SIZE_DQO;
-	}
 	err = gve_create_rings(priv);
 	if (err)
 		goto reset;
@@ -1457,12 +1477,64 @@ static void gve_handle_link_status(struct gve_priv *priv, bool link_status)
 	}
 }
 
+static void gve_turnup_and_check_status(struct gve_priv *priv)
+{
+	u32 status;
+
+	gve_turnup(priv);
+	status = ioread32be(&priv->reg_bar0->device_status);
+	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+}
+
+int gve_recreate_rx_rings(struct gve_priv *priv)
+{
+	int err;
+
+	/* Unregister queues with the device*/
+	err = gve_destroy_rx_rings(priv);
+	if (err)
+		return err;
+
+	/* Reset the RX state */
+	gve_rx_reset_rings_dqo(priv);
+
+	/* Register queues with the device */
+	return gve_create_rx_rings(priv);
+}
+
+int gve_reconfigure_rx_rings(struct gve_priv *priv,
+			     bool enable_hdr_split,
+			     int packet_buffer_size)
+{
+	int err = 0;
+
+	if (priv->queue_format != GVE_DQO_RDA_FORMAT)
+		return -EOPNOTSUPP;
+
+	gve_turndown(priv);
+
+	/* Allocate/free hdr resources */
+	if (enable_hdr_split != !!priv->header_buf_pool) {
+		err = gve_rx_handle_hdr_resources_dqo(priv, enable_hdr_split);
+		if (err)
+			goto err;
+	}
+
+	/* Apply new RX configuration changes */
+	priv->data_buffer_size_dqo = packet_buffer_size;
+
+	/* Reset RX state and re-register with the device */
+	err = gve_recreate_rx_rings(priv);
+err:
+	gve_turnup_and_check_status(priv);
+	return err;
+}
+
 static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		       struct netlink_ext_ack *extack)
 {
 	struct bpf_prog *old_prog;
 	int err = 0;
-	u32 status;
 
 	old_prog = READ_ONCE(priv->xdp_prog);
 	if (!netif_carrier_ok(priv->dev)) {
@@ -1491,9 +1563,7 @@ static int gve_set_xdp(struct gve_priv *priv, struct bpf_prog *prog,
 		bpf_prog_put(old_prog);
 
 out:
-	gve_turnup(priv);
-	status = ioread32be(&priv->reg_bar0->device_status);
-	gve_handle_link_status(priv, GVE_DEVICE_STATUS_LINK_STATUS_MASK & status);
+	gve_turnup_and_check_status(priv);
 	return err;
 }
 
@@ -2278,6 +2348,7 @@ static int gve_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	priv->service_task_flags = 0x0;
 	priv->state_flags = 0x0;
 	priv->ethtool_flags = 0x0;
+	priv->ethtool_defaults = 0x0;
 
 	gve_set_probe_in_progress(priv);
 	priv->gve_wq = alloc_ordered_workqueue("gve", 0);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index ea0e38b4d9e9..b3974a91dc94 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -111,6 +111,13 @@ static void gve_enqueue_buf_state(struct gve_rx_ring *rx,
 	}
 }
 
+static void gve_recycle_buf(struct gve_rx_ring *rx,
+			    struct gve_rx_buf_state_dqo *buf_state)
+{
+	buf_state->hdr_buf = NULL;
+	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+}
+
 static struct gve_rx_buf_state_dqo *
 gve_get_recycled_buf_state(struct gve_rx_ring *rx)
 {
@@ -199,6 +206,23 @@ static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 	return 0;
 }
 
+static void gve_rx_free_hdr_bufs(struct gve_priv *priv, int idx)
+{
+	struct gve_rx_ring *rx = &priv->rx[idx];
+	int buffer_queue_slots = rx->dqo.bufq.mask + 1;
+	int i;
+
+	if (rx->dqo.hdr_bufs) {
+		for (i = 0; i < buffer_queue_slots; i++)
+			if (rx->dqo.hdr_bufs[i].data)
+				dma_pool_free(priv->header_buf_pool,
+					      rx->dqo.hdr_bufs[i].data,
+					      rx->dqo.hdr_bufs[i].addr);
+		kvfree(rx->dqo.hdr_bufs);
+		rx->dqo.hdr_bufs = NULL;
+	}
+}
+
 static void gve_rx_free_ring_dqo(struct gve_priv *priv, int idx)
 {
 	struct gve_rx_ring *rx = &priv->rx[idx];
@@ -248,15 +272,99 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, int idx)
 	kvfree(rx->dqo.buf_states);
 	rx->dqo.buf_states = NULL;
 
+	gve_rx_free_hdr_bufs(priv, idx);
+
 	netif_dbg(priv, drv, priv->dev, "freed rx ring %d\n", idx);
 }
 
+static int gve_rx_alloc_hdr_bufs(struct gve_priv *priv, int idx)
+{
+	struct gve_rx_ring *rx = &priv->rx[idx];
+	int buffer_queue_slots = rx->dqo.bufq.mask + 1;
+	int i;
+
+	rx->dqo.hdr_bufs = kvcalloc(buffer_queue_slots,
+				    sizeof(rx->dqo.hdr_bufs[0]),
+				    GFP_KERNEL);
+	if (!rx->dqo.hdr_bufs)
+		return -ENOMEM;
+	for (i = 0; i < buffer_queue_slots; i++) {
+		rx->dqo.hdr_bufs[i].data =
+			dma_pool_alloc(priv->header_buf_pool,
+				       GFP_KERNEL,
+				       &rx->dqo.hdr_bufs[i].addr);
+		if (!rx->dqo.hdr_bufs[i].data)
+			goto err;
+	}
+	return 0;
+err:
+	gve_rx_free_hdr_bufs(priv, idx);
+	return -ENOMEM;
+}
+
+static void gve_rx_init_ring_state_dqo(struct gve_rx_ring *rx,
+				       const u32 buffer_queue_slots,
+				       const u32 completion_queue_slots)
+{
+	int i;
+	/* Set buffer queue state */
+	rx->dqo.bufq.mask = buffer_queue_slots - 1;
+	rx->dqo.bufq.head = 0;
+	rx->dqo.bufq.tail = 0;
+	/* Set completion queue state */
+	rx->dqo.complq.num_free_slots = completion_queue_slots;
+	rx->dqo.complq.mask = completion_queue_slots - 1;
+	rx->dqo.complq.cur_gen_bit = 0;
+	rx->dqo.complq.head = 0;
+	/* Set RX SKB context */
+	rx->ctx.skb_head = NULL;
+	rx->ctx.skb_tail = NULL;
+	/* Set up linked list of buffer IDs */
+	for (i = 0; i < rx->dqo.num_buf_states - 1; i++)
+		rx->dqo.buf_states[i].next = i + 1;
+	rx->dqo.buf_states[rx->dqo.num_buf_states - 1].next = -1;
+	rx->dqo.free_buf_states = 0;
+	rx->dqo.recycled_buf_states.head = -1;
+	rx->dqo.recycled_buf_states.tail = -1;
+	rx->dqo.used_buf_states.head = -1;
+	rx->dqo.used_buf_states.tail = -1;
+}
+
+static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
+{
+	struct gve_rx_ring *rx = &priv->rx[idx];
+	size_t size;
+	int i;
+	const u32 buffer_queue_slots = priv->rx_desc_cnt;
+	const u32 completion_queue_slots = priv->rx_desc_cnt;
+
+	netif_dbg(priv, drv, priv->dev, "Resetting rx ring\n");
+	/* Reset buffer queue */
+	size = sizeof(rx->dqo.bufq.desc_ring[0]) *
+		buffer_queue_slots;
+	memset(rx->dqo.bufq.desc_ring, 0, size);
+	/* Reset completion queue */
+	size = sizeof(rx->dqo.complq.desc_ring[0]) *
+		completion_queue_slots;
+	memset(rx->dqo.complq.desc_ring, 0, size);
+	/* Reset q_resources */
+	memset(rx->q_resources, 0, sizeof(*rx->q_resources));
+	/* Reset buf states */
+	for (i = 0; i < rx->dqo.num_buf_states; i++) {
+		struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
+
+		if (bs->page_info.page)
+			gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
+	}
+	gve_rx_init_ring_state_dqo(rx, buffer_queue_slots,
+				   completion_queue_slots);
+}
+
 static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 {
 	struct gve_rx_ring *rx = &priv->rx[idx];
 	struct device *hdev = &priv->pdev->dev;
 	size_t size;
-	int i;
 
 	const u32 buffer_queue_slots =
 		priv->queue_format == GVE_DQO_RDA_FORMAT ?
@@ -268,11 +376,6 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	memset(rx, 0, sizeof(*rx));
 	rx->gve = priv;
 	rx->q_num = idx;
-	rx->dqo.bufq.mask = buffer_queue_slots - 1;
-	rx->dqo.complq.num_free_slots = completion_queue_slots;
-	rx->dqo.complq.mask = completion_queue_slots - 1;
-	rx->ctx.skb_head = NULL;
-	rx->ctx.skb_tail = NULL;
 
 	rx->dqo.num_buf_states = priv->queue_format == GVE_DQO_RDA_FORMAT ?
 		min_t(s16, S16_MAX, buffer_queue_slots * 4) :
@@ -283,16 +386,6 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	if (!rx->dqo.buf_states)
 		return -ENOMEM;
 
-	/* Set up linked list of buffer IDs */
-	for (i = 0; i < rx->dqo.num_buf_states - 1; i++)
-		rx->dqo.buf_states[i].next = i + 1;
-
-	rx->dqo.buf_states[rx->dqo.num_buf_states - 1].next = -1;
-	rx->dqo.recycled_buf_states.head = -1;
-	rx->dqo.recycled_buf_states.tail = -1;
-	rx->dqo.used_buf_states.head = -1;
-	rx->dqo.used_buf_states.tail = -1;
-
 	/* Allocate RX completion queue */
 	size = sizeof(rx->dqo.complq.desc_ring[0]) *
 		completion_queue_slots;
@@ -320,6 +413,14 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	if (!rx->q_resources)
 		goto err;
 
+	gve_rx_init_ring_state_dqo(rx, buffer_queue_slots,
+				   completion_queue_slots);
+
+	/* Allocate header buffers for header-split */
+	if (priv->header_buf_pool)
+		if (gve_rx_alloc_hdr_bufs(priv, idx))
+			goto err;
+
 	gve_rx_add_to_block(priv, idx);
 
 	return 0;
@@ -337,10 +438,28 @@ void gve_rx_write_doorbell_dqo(const struct gve_priv *priv, int queue_idx)
 	iowrite32(rx->dqo.bufq.tail, &priv->db_bar2[index]);
 }
 
+static int gve_rx_alloc_hdr_buf_pool(struct gve_priv *priv)
+{
+	priv->header_buf_pool = dma_pool_create("header_bufs",
+						&priv->pdev->dev,
+						priv->header_buf_size,
+						64, 0);
+	if (!priv->header_buf_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
 int gve_rx_alloc_rings_dqo(struct gve_priv *priv)
 {
 	int err = 0;
-	int i;
+	int i = 0;
+
+	if (gve_get_enable_header_split(priv)) {
+		err = gve_rx_alloc_hdr_buf_pool(priv);
+		if (err)
+			goto err;
+	}
 
 	for (i = 0; i < priv->rx_cfg.num_queues; i++) {
 		err = gve_rx_alloc_ring_dqo(priv, i);
@@ -361,12 +480,23 @@ int gve_rx_alloc_rings_dqo(struct gve_priv *priv)
 	return err;
 }
 
+void gve_rx_reset_rings_dqo(struct gve_priv *priv)
+{
+	int i;
+
+	for (i = 0; i < priv->rx_cfg.num_queues; i++)
+		gve_rx_reset_ring_dqo(priv, i);
+}
+
 void gve_rx_free_rings_dqo(struct gve_priv *priv)
 {
 	int i;
 
 	for (i = 0; i < priv->rx_cfg.num_queues; i++)
 		gve_rx_free_ring_dqo(priv, i);
+
+	dma_pool_destroy(priv->header_buf_pool);
+	priv->header_buf_pool = NULL;
 }
 
 void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
@@ -404,6 +534,12 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 		desc->buf_id = cpu_to_le16(buf_state - rx->dqo.buf_states);
 		desc->buf_addr = cpu_to_le64(buf_state->addr +
 					     buf_state->page_info.page_offset);
+		if (rx->dqo.hdr_bufs) {
+			struct gve_header_buf *hdr_buf =
+				&rx->dqo.hdr_bufs[bufq->tail];
+			buf_state->hdr_buf = hdr_buf;
+			desc->header_buf_addr = cpu_to_le64(hdr_buf->addr);
+		}
 
 		bufq->tail = (bufq->tail + 1) & bufq->mask;
 		complq->num_free_slots--;
@@ -450,7 +586,7 @@ static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 		goto mark_used;
 	}
 
-	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+	gve_recycle_buf(rx, buf_state);
 	return;
 
 mark_used:
@@ -606,10 +742,13 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		      int queue_idx)
 {
 	const u16 buffer_id = le16_to_cpu(compl_desc->buf_id);
+	const bool hbo = compl_desc->header_buffer_overflow != 0;
 	const bool eop = compl_desc->end_of_packet != 0;
+	const bool sph = compl_desc->split_header != 0;
 	struct gve_rx_buf_state_dqo *buf_state;
 	struct gve_priv *priv = rx->gve;
 	u16 buf_len;
+	u16 hdr_len;
 
 	if (unlikely(buffer_id >= rx->dqo.num_buf_states)) {
 		net_err_ratelimited("%s: Invalid RX buffer_id=%u\n",
@@ -624,18 +763,55 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	}
 
 	if (unlikely(compl_desc->rx_error)) {
-		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
-				      buf_state);
+		net_err_ratelimited("%s: Descriptor error=%u\n",
+				    priv->dev->name, compl_desc->rx_error);
+		gve_recycle_buf(rx, buf_state);
 		return -EINVAL;
 	}
 
 	buf_len = compl_desc->packet_len;
+	hdr_len = compl_desc->header_len;
+
+	if (unlikely(hbo && priv->header_split_strict)) {
+		gve_recycle_buf(rx, buf_state);
+		return -EFAULT;
+	}
 
 	/* Page might have not been used for awhile and was likely last written
 	 * by a different thread.
 	 */
 	prefetch(buf_state->page_info.page);
 
+	/* Copy the header into the skb in the case of header split */
+	if (sph) {
+		if (unlikely(!hdr_len)) {
+			gve_recycle_buf(rx, buf_state);
+			return -EINVAL;
+		}
+
+		if (unlikely(!buf_state->hdr_buf)) {
+			gve_recycle_buf(rx, buf_state);
+			return -EINVAL;
+		}
+		dma_sync_single_for_cpu(&priv->pdev->dev,
+					buf_state->hdr_buf->addr,
+					hdr_len, DMA_FROM_DEVICE);
+
+		rx->ctx.skb_head = gve_rx_copy_data(priv->dev, napi,
+						    buf_state->hdr_buf->data,
+						    hdr_len);
+		if (unlikely(!rx->ctx.skb_head))
+			goto error;
+
+		rx->ctx.skb_tail = rx->ctx.skb_head;
+
+		u64_stats_update_begin(&rx->statss);
+		rx->rx_hsplit_pkt++;
+		rx->rx_hsplit_hbo_pkt += hbo;
+		rx->rheader_bytes += hdr_len;
+		u64_stats_update_end(&rx->statss);
+	}
+
 	/* Sync the portion of dma buffer for CPU to read. */
 	dma_sync_single_range_for_cpu(&priv->pdev->dev, buf_state->addr,
 				      buf_state->page_info.page_offset,
@@ -644,9 +820,8 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	/* Append to current skb if one exists. */
 	if (rx->ctx.skb_head) {
 		if (unlikely(gve_rx_append_frags(napi, buf_state, buf_len, rx,
-						 priv)) != 0) {
+						 priv)) != 0)
 			goto error;
-		}
 		return 0;
 	}
 
@@ -662,8 +837,7 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		rx->rx_copybreak_pkt++;
 		u64_stats_update_end(&rx->statss);
 
-		gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states,
-				      buf_state);
+		gve_recycle_buf(rx, buf_state);
 		return 0;
 	}
 
@@ -687,7 +861,9 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 	return 0;
 
 error:
-	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+	net_err_ratelimited("%s: Error returning from Rx DQO\n",
+			    priv->dev->name);
+	gve_recycle_buf(rx, buf_state);
 	return -ENOMEM;
 }
 
@@ -786,6 +962,8 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 				rx->rx_skb_alloc_fail++;
 			else if (err == -EINVAL)
 				rx->rx_desc_err_dropped_pkt++;
+			else if (err == -EFAULT)
+				rx->rx_hsplit_err_dropped_pkt++;
 			u64_stats_update_end(&rx->statss);
 		}
 
@@ -844,3 +1022,39 @@ int gve_rx_poll_dqo(struct gve_notify_block *block, int budget)
 
 	return work_done;
 }
+
+int gve_rx_handle_hdr_resources_dqo(struct gve_priv *priv,
+				    bool enable_hdr_split)
+{
+	int err = 0;
+	int i;
+
+	if (enable_hdr_split) {
+		err = gve_rx_alloc_hdr_buf_pool(priv);
+		if (err)
+			goto err;
+
+		for (i = 0; i < priv->rx_cfg.num_queues; i++) {
+			err = gve_rx_alloc_hdr_bufs(priv, i);
+			if (err)
+				goto free_buf_pool;
+		}
+	} else {
+		for (i = 0; i < priv->rx_cfg.num_queues; i++)
+			gve_rx_free_hdr_bufs(priv, i);
+
+		dma_pool_destroy(priv->header_buf_pool);
+		priv->header_buf_pool = NULL;
+	}
+
+	return 0;
+
+free_buf_pool:
+	for (i--; i >= 0; i--)
+		gve_rx_free_hdr_bufs(priv, i);
+
+	dma_pool_destroy(priv->header_buf_pool);
+	priv->header_buf_pool = NULL;
+err:
+	return err;
+}
diff --git a/drivers/net/ethernet/google/gve/gve_utils.c b/drivers/net/ethernet/google/gve/gve_utils.c
index 26e08d753270..5e6275e7b517 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.c
+++ b/drivers/net/ethernet/google/gve/gve_utils.c
@@ -48,11 +48,9 @@ void gve_rx_add_to_block(struct gve_priv *priv, int queue_idx)
 	rx->ntfy_id = ntfy_idx;
 }
 
-struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
-			    struct gve_rx_slot_page_info *page_info, u16 len)
+struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *napi,
+				 u8 *data, u16 len)
 {
-	void *va = page_info->page_address + page_info->page_offset +
-		page_info->pad;
 	struct sk_buff *skb;
 
 	skb = napi_alloc_skb(napi, len);
@@ -60,12 +58,20 @@ struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 		return NULL;
 
 	__skb_put(skb, len);
-	skb_copy_to_linear_data_offset(skb, 0, va, len);
+	skb_copy_to_linear_data_offset(skb, 0, data, len);
 	skb->protocol = eth_type_trans(skb, dev);
 
 	return skb;
 }
 
+struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
+			    struct gve_rx_slot_page_info *page_info, u16 len)
+{
+	void *va = page_info->page_address + page_info->page_offset +
+		page_info->pad;
+	return gve_rx_copy_data(dev, napi, va, len);
+}
+
 void gve_dec_pagecnt_bias(struct gve_rx_slot_page_info *page_info)
 {
 	page_info->pagecnt_bias--;
diff --git a/drivers/net/ethernet/google/gve/gve_utils.h b/drivers/net/ethernet/google/gve/gve_utils.h
index 324fd98a6112..6131aefbc5b8 100644
--- a/drivers/net/ethernet/google/gve/gve_utils.h
+++ b/drivers/net/ethernet/google/gve/gve_utils.h
@@ -17,6 +17,9 @@ void gve_tx_add_to_block(struct gve_priv *priv, int queue_idx);
 void gve_rx_remove_from_block(struct gve_priv *priv, int queue_idx);
 void gve_rx_add_to_block(struct gve_priv *priv, int queue_idx);
 
+struct sk_buff *gve_rx_copy_data(struct net_device *dev, struct napi_struct *napi,
+				 u8 *data, u16 len);
+
 struct sk_buff *gve_rx_copy(struct net_device *dev, struct napi_struct *napi,
 			    struct gve_rx_slot_page_info *page_info, u16 len);
 
-- 
2.41.0.640.ga95def55d0-goog


