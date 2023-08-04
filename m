Return-Path: <netdev+bounces-24586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA027770B15
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 23:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF971C216A3
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 21:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5E524170;
	Fri,  4 Aug 2023 21:35:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50231F92A
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 21:35:06 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24CDC5
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:35:04 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5868992ddd4so28315157b3.0
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691184904; x=1691789704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NiuvfODsh00p/7dE0Ehrj/UCs+oSbHL8KiYbqcOnKTM=;
        b=Myv9Tr5wtF2IwlpILjejzJwnnwlsvn4a3w+1+FjOsfDrV4hVvn5C5kkmh43dsUer24
         fwS0rBYAo0PoSNdhVFLRr1qLaSn3l6TQTkdTnh4LCplcs1Kaz5qMZpjfuZCLQ70zY+OA
         ieIktZipYB8e4/FlQ8OTAxMkgv8Du+R8R/k3/X89mqD8VJa6P1G6goZJhPVvU1SGDufS
         ppmIDy9CFqk8insJ7yFh7FyW0QgY64pzwtgPAsIcQaiH0FZ3Qp6R0JP6AjcQ5dMQuCGf
         d2jGpu2D4pe2Q0NEOVZitDqC/UTUtT7MTDVmn7atKPW2F6MHFgo0eQEfHxDWg4061VWH
         69xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691184904; x=1691789704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NiuvfODsh00p/7dE0Ehrj/UCs+oSbHL8KiYbqcOnKTM=;
        b=IzSaWzsfNfCm8nBYZLLPXa6j8Nv+gUHpBTyQJil3OAZM1ycXBoRjzqrhoEVps63UcA
         l/wwUBVS/KyYfs7c/8sUi2dUpfUhyQpfplGDVomeCKlD6P3K9ZeaBLFKOmB6zVkQaoUC
         1V9AAP1b+9fSA2KJW8BlU8/vh7BxvZkt+UaWris+zTyUtozgovezOnWwsMwYj8uYDF83
         4sAvxHgtH3hAv7ByUjleTqKCxqig1JEMzOrNuCEOlOw/xsTbTIgN3g/kG1nTsMQ5ndt3
         AxD8rYBSDsmFKj/8ReAsxB4pHbe/J2Gt0MAniaNihpdXyqoFfVJeK7UKfZOkv1xvryNe
         XNGQ==
X-Gm-Message-State: AOJu0YxKLNBYFi2C/+KPIAxOlPa2akwaDMMScbhmIUOqVuoia9PvaRjn
	JsmgoPNjF9eZcPM4cIOfLkhFci9OjrBSi15aJZEurEuczEBlbPIzjBplZKa/kjZrx4CQchnOYA2
	Iv4h+VDnXXBXXpf3PJP6sm2UVKRyOAZGaOFWbMjmOn6b7rUoQBmQZQCn9NSZzkCHd
X-Google-Smtp-Source: AGHT+IE9t3oZYyNdBqFU8jJ/VeBxRy4DP9JY6vdRrTL1lAcwwN72Tr/vdqvMIRLxe/h5zB9cYYLz+hgC2A1E
X-Received: from wrushilg.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2168])
 (user=rushilg job=sendgmr) by 2002:a81:d44d:0:b0:581:3939:59a2 with SMTP id
 g13-20020a81d44d000000b00581393959a2mr20935ywl.3.1691184903468; Fri, 04 Aug
 2023 14:35:03 -0700 (PDT)
Date: Fri,  4 Aug 2023 21:34:43 +0000
In-Reply-To: <20230804213444.2792473-1-rushilg@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230804213444.2792473-1-rushilg@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804213444.2792473-4-rushilg@google.com>
Subject: [PATCH net-next v2 3/4] gve: RX path for DQO-QPL
From: Rushil Gupta <rushilg@google.com>
To: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	willemb@google.com, edumazet@google.com, pabeni@redhat.com
Cc: Rushil Gupta <rushilg@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bailey Forrest <bcf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The RX path allocates the QPL page pool at queue creation, and
tries to reuse these pages through page recycling. This patch
ensures that on refill no non-QPL pages are posted to the device.

When the driver is running low on free buffers, an ondemand
allocation step kicks in that allocates a non-qpl page for
SKB business to free up the QPL page in use.

gve_try_recycle_buf was moved to gve_rx_append_frags so that driver does
not attempt to mark buffer as used if a non-qpl page was allocated
ondemand.

Signed-off-by: Rushil Gupta <rushilg@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Bailey Forrest <bcf@google.com>
---
Changes in v2:
- Allocate ondemand page using GFP_ATOMIC since it is in softirq.

 drivers/net/ethernet/google/gve/gve.h        |   6 +
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 126 ++++++++++++++++---
 2 files changed, 114 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index a6bbd1d9c165..6f8f34043e8c 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -240,6 +240,12 @@ struct gve_rx_ring {
 
 			/* qpl assigned to this queue */
 			struct gve_queue_page_list *qpl;
+
+			/* index into queue page list */
+			u32 next_qpl_page_idx;
+
+			/* track number of used buffers */
+			u16 used_buf_states_cnt;
 		} dqo;
 	};
 
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index e57b73eb70f6..ea0e38b4d9e9 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -22,11 +22,13 @@ static int gve_buf_ref_cnt(struct gve_rx_buf_state_dqo *bs)
 }
 
 static void gve_free_page_dqo(struct gve_priv *priv,
-			      struct gve_rx_buf_state_dqo *bs)
+			      struct gve_rx_buf_state_dqo *bs,
+			      bool free_page)
 {
 	page_ref_sub(bs->page_info.page, bs->page_info.pagecnt_bias - 1);
-	gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
-		      DMA_FROM_DEVICE);
+	if (free_page)
+		gve_free_page(&priv->pdev->dev, bs->page_info.page, bs->addr,
+			      DMA_FROM_DEVICE);
 	bs->page_info.page = NULL;
 }
 
@@ -130,12 +132,20 @@ gve_get_recycled_buf_state(struct gve_rx_ring *rx)
 	 */
 	for (i = 0; i < 5; i++) {
 		buf_state = gve_dequeue_buf_state(rx, &rx->dqo.used_buf_states);
-		if (gve_buf_ref_cnt(buf_state) == 0)
+		if (gve_buf_ref_cnt(buf_state) == 0) {
+			rx->dqo.used_buf_states_cnt--;
 			return buf_state;
+		}
 
 		gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
 	}
 
+	/* For QPL, we cannot allocate any new buffers and must
+	 * wait for the existing ones to be available.
+	 */
+	if (rx->dqo.qpl)
+		return NULL;
+
 	/* If there are no free buf states discard an entry from
 	 * `used_buf_states` so it can be used.
 	 */
@@ -144,23 +154,39 @@ gve_get_recycled_buf_state(struct gve_rx_ring *rx)
 		if (gve_buf_ref_cnt(buf_state) == 0)
 			return buf_state;
 
-		gve_free_page_dqo(rx->gve, buf_state);
+		gve_free_page_dqo(rx->gve, buf_state, true);
 		gve_free_buf_state(rx, buf_state);
 	}
 
 	return NULL;
 }
 
-static int gve_alloc_page_dqo(struct gve_priv *priv,
+static int gve_alloc_page_dqo(struct gve_rx_ring *rx,
 			      struct gve_rx_buf_state_dqo *buf_state)
 {
-	int err;
+	struct gve_priv *priv = rx->gve;
+	u32 idx;
 
-	err = gve_alloc_page(priv, &priv->pdev->dev, &buf_state->page_info.page,
-			     &buf_state->addr, DMA_FROM_DEVICE, GFP_ATOMIC);
-	if (err)
-		return err;
+	if (!rx->dqo.qpl) {
+		int err;
 
+		err = gve_alloc_page(priv, &priv->pdev->dev,
+				     &buf_state->page_info.page,
+				     &buf_state->addr,
+				     DMA_FROM_DEVICE, GFP_ATOMIC);
+		if (err)
+			return err;
+	} else {
+		idx = rx->dqo.next_qpl_page_idx;
+		if (idx >= priv->rx_pages_per_qpl) {
+			net_err_ratelimited("%s: Out of QPL pages\n",
+					    priv->dev->name);
+			return -ENOMEM;
+		}
+		buf_state->page_info.page = rx->dqo.qpl->pages[idx];
+		buf_state->addr = rx->dqo.qpl->page_buses[idx];
+		rx->dqo.next_qpl_page_idx++;
+	}
 	buf_state->page_info.page_offset = 0;
 	buf_state->page_info.page_address =
 		page_address(buf_state->page_info.page);
@@ -195,9 +221,13 @@ static void gve_rx_free_ring_dqo(struct gve_priv *priv, int idx)
 
 	for (i = 0; i < rx->dqo.num_buf_states; i++) {
 		struct gve_rx_buf_state_dqo *bs = &rx->dqo.buf_states[i];
-
+		/* Only free page for RDA. QPL pages are freed in gve_main. */
 		if (bs->page_info.page)
-			gve_free_page_dqo(priv, bs);
+			gve_free_page_dqo(priv, bs, !rx->dqo.qpl);
+	}
+	if (rx->dqo.qpl) {
+		gve_unassign_qpl(priv, rx->dqo.qpl->id);
+		rx->dqo.qpl = NULL;
 	}
 
 	if (rx->dqo.bufq.desc_ring) {
@@ -229,7 +259,8 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	int i;
 
 	const u32 buffer_queue_slots =
-		priv->options_dqo_rda.rx_buff_ring_entries;
+		priv->queue_format == GVE_DQO_RDA_FORMAT ?
+		priv->options_dqo_rda.rx_buff_ring_entries : priv->rx_desc_cnt;
 	const u32 completion_queue_slots = priv->rx_desc_cnt;
 
 	netif_dbg(priv, drv, priv->dev, "allocating rx ring DQO\n");
@@ -243,7 +274,9 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	rx->ctx.skb_head = NULL;
 	rx->ctx.skb_tail = NULL;
 
-	rx->dqo.num_buf_states = min_t(s16, S16_MAX, buffer_queue_slots * 4);
+	rx->dqo.num_buf_states = priv->queue_format == GVE_DQO_RDA_FORMAT ?
+		min_t(s16, S16_MAX, buffer_queue_slots * 4) :
+		priv->rx_pages_per_qpl;
 	rx->dqo.buf_states = kvcalloc(rx->dqo.num_buf_states,
 				      sizeof(rx->dqo.buf_states[0]),
 				      GFP_KERNEL);
@@ -275,6 +308,13 @@ static int gve_rx_alloc_ring_dqo(struct gve_priv *priv, int idx)
 	if (!rx->dqo.bufq.desc_ring)
 		goto err;
 
+	if (priv->queue_format != GVE_DQO_RDA_FORMAT) {
+		rx->dqo.qpl = gve_assign_rx_qpl(priv, rx->q_num);
+		if (!rx->dqo.qpl)
+			goto err;
+		rx->dqo.next_qpl_page_idx = 0;
+	}
+
 	rx->q_resources = dma_alloc_coherent(hdev, sizeof(*rx->q_resources),
 					     &rx->q_resources_bus, GFP_KERNEL);
 	if (!rx->q_resources)
@@ -352,7 +392,7 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
 			if (unlikely(!buf_state))
 				break;
 
-			if (unlikely(gve_alloc_page_dqo(priv, buf_state))) {
+			if (unlikely(gve_alloc_page_dqo(rx, buf_state))) {
 				u64_stats_update_begin(&rx->statss);
 				rx->rx_buf_alloc_fail++;
 				u64_stats_update_end(&rx->statss);
@@ -415,6 +455,7 @@ static void gve_try_recycle_buf(struct gve_priv *priv, struct gve_rx_ring *rx,
 
 mark_used:
 	gve_enqueue_buf_state(rx, &rx->dqo.used_buf_states, buf_state);
+	rx->dqo.used_buf_states_cnt++;
 }
 
 static void gve_rx_skb_csum(struct sk_buff *skb,
@@ -475,6 +516,43 @@ static void gve_rx_free_skb(struct gve_rx_ring *rx)
 	rx->ctx.skb_tail = NULL;
 }
 
+static bool gve_rx_should_trigger_copy_ondemand(struct gve_rx_ring *rx)
+{
+	if (!rx->dqo.qpl)
+		return false;
+	if (rx->dqo.used_buf_states_cnt <
+		     (rx->dqo.num_buf_states -
+		     GVE_DQO_QPL_ONDEMAND_ALLOC_THRESHOLD))
+		return false;
+	return true;
+}
+
+static int gve_rx_copy_ondemand(struct gve_rx_ring *rx,
+				struct gve_rx_buf_state_dqo *buf_state,
+				u16 buf_len)
+{
+	struct page *page = alloc_page(GFP_ATOMIC);
+	int num_frags;
+
+	if (!page)
+		return -ENOMEM;
+
+	memcpy(page_address(page),
+	       buf_state->page_info.page_address +
+	       buf_state->page_info.page_offset,
+	       buf_len);
+	num_frags = skb_shinfo(rx->ctx.skb_tail)->nr_frags;
+	skb_add_rx_frag(rx->ctx.skb_tail, num_frags, page,
+			0, buf_len, PAGE_SIZE);
+
+	u64_stats_update_begin(&rx->statss);
+	rx->rx_frag_alloc_cnt++;
+	u64_stats_update_end(&rx->statss);
+	/* Return unused buffer. */
+	gve_enqueue_buf_state(rx, &rx->dqo.recycled_buf_states, buf_state);
+	return 0;
+}
+
 /* Chains multi skbs for single rx packet.
  * Returns 0 if buffer is appended, -1 otherwise.
  */
@@ -502,12 +580,20 @@ static int gve_rx_append_frags(struct napi_struct *napi,
 		rx->ctx.skb_head->truesize += priv->data_buffer_size_dqo;
 	}
 
+	/* Trigger ondemand page allocation if we are running low on buffers */
+	if (gve_rx_should_trigger_copy_ondemand(rx))
+		return gve_rx_copy_ondemand(rx, buf_state, buf_len);
+
 	skb_add_rx_frag(rx->ctx.skb_tail, num_frags,
 			buf_state->page_info.page,
 			buf_state->page_info.page_offset,
 			buf_len, priv->data_buffer_size_dqo);
 	gve_dec_pagecnt_bias(&buf_state->page_info);
 
+	/* Advances buffer page-offset if page is partially used.
+	 * Marks buffer as used if page is full.
+	 */
+	gve_try_recycle_buf(priv, rx, buf_state);
 	return 0;
 }
 
@@ -561,8 +647,6 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 						 priv)) != 0) {
 			goto error;
 		}
-
-		gve_try_recycle_buf(priv, rx, buf_state);
 		return 0;
 	}
 
@@ -588,6 +672,12 @@ static int gve_rx_dqo(struct napi_struct *napi, struct gve_rx_ring *rx,
 		goto error;
 	rx->ctx.skb_tail = rx->ctx.skb_head;
 
+	if (gve_rx_should_trigger_copy_ondemand(rx)) {
+		if (gve_rx_copy_ondemand(rx, buf_state, buf_len) < 0)
+			goto error;
+		return 0;
+	}
+
 	skb_add_rx_frag(rx->ctx.skb_head, 0, buf_state->page_info.page,
 			buf_state->page_info.page_offset, buf_len,
 			priv->data_buffer_size_dqo);
-- 
2.41.0.585.gd2178a4bd4-goog


