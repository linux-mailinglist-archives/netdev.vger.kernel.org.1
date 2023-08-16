Return-Path: <netdev+bounces-28061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE5877E1B4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF461C21091
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C8DF60;
	Wed, 16 Aug 2023 12:33:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D80D537
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:33:12 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B21B2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:33:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6887059f121so1098181b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692189190; x=1692793990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZvbl1IlQSMRNbWII2yzhMSZzRydzJjjANaWs24ENjI=;
        b=MbXXtMz5/LnN54ceCmkjI1uxqK1ulq/M5vocrnV22x42YsW1Wm8tpTbOdkopCPbnkC
         cyEWEsrMtkdOjWK/UfjayKDUVcr+QS2cQzyqOZm4iNOUcibdpPXMJwK1eTe9BtgXheIN
         /q6yGJ6WhnxibgA602Ivww1RIBiNxR6IPY5CzsyISwVA7VSv9KEssnNo+3g/l/ldXNzy
         Ssd4Ti/fWvHd/+m+79+OYjv+vHoveOsyn6q3ldwQGJSgQb/2p53v80BkFMsmGDadFMlY
         2gFqVgY4e0vJ9mBekU0AhhIT5LpUO5V3IGQw5m+FnVXJEljGa6K0zBHtDvT3qf6bCLwq
         Qo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189190; x=1692793990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZvbl1IlQSMRNbWII2yzhMSZzRydzJjjANaWs24ENjI=;
        b=ZtbiUEclBc3QMP9TNqdghvDfGUAZ56z3KeSFsGYAif+h7QVsj66WlJQhNQ9HxZ63NS
         U/miTcSi1BZg9vGGlWJOfoK/rRWaXN8b2KJa0QtYRlb40S9zdCAuOZm9kJBBBQukbSzq
         pnnGMyicrcu2dQ2tFzMEyBJAzUwLDjfN82i48jku4AA2w9tHb/zM1Hk/Hppr9TcPP1rt
         /sejuDmMYAQ2L6SsaZfKsHGKS0/dklc9krWF+ClQKcKCX7baPUpq/926y6Nj5rNz+ADW
         hRtgN6oYNOJKafQHujEA+kCk6SBCnZ1Jqj/QIOQuYNhE5ml0BDdgdA3Jfv71oz1rc2bb
         j7wg==
X-Gm-Message-State: AOJu0Yy7TigN+z3PJtEIUKCr8YSl1eSrSlsvH19YoDLFwY83e3V3IreK
	zGABUkFKid4g+xOupwhYj1M=
X-Google-Smtp-Source: AGHT+IHbTgZc7/c9E33tvxtUTR44dUdHQzNk5pW/66L5tq+UooxTQ1rvxtmYmfCCW2TEznCL3FU0ow==
X-Received: by 2002:a17:902:c942:b0:1bd:d446:6676 with SMTP id i2-20020a170902c94200b001bdd4466676mr1474656pla.31.1692189190134;
        Wed, 16 Aug 2023 05:33:10 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.googlemail.com with ESMTPSA id x2-20020a170902ec8200b001bba669a7eesm13096539plg.52.2023.08.16.05.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:33:08 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: hawk@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linyunsheng@huawei.com
Cc: ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [RFC PATCH net-next v3 1/2] net: veth: Improving page pool recycling
Date: Wed, 16 Aug 2023 20:30:28 +0800
Message-Id: <20230816123029.20339-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816123029.20339-1-liangchen.linux@gmail.com>
References: <20230816123029.20339-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Page pool is supported for veth. But for XDP_TX and XDP_REDIRECT cases,
the pages are not effectively recycled. "ethtool -S" statistics for the
page pool are as follows:

NIC statistics:
rx_pp_alloc_fast: 18041186
rx_pp_alloc_slow: 286369
rx_pp_recycle_ring: 0
rx_pp_recycle_released_ref: 18327555

This failure to recycle page pool pages is a result of the code snippet
below, which converts page pool pages into regular pages and releases
the skb data structure:

veth_xdp_get(xdp);
consume_skb(skb);

The reason behind is some skbs received from the veth peer are not page
pool pages, and remain so after conversion to xdp frame. In order to not
confusing __xdp_return with mixed regular pages and page pool pages, they
are all converted to regular pages. So registering xdp memory model as
MEM_TYPE_PAGE_SHARED is sufficient.

If we replace the above code with kfree_skb_partial, directly releasing
the skb data structure, we can retain the original page pool page behavior.
However, directly changing the xdp memory model to MEM_TYPE_PAGE_POOL is
not a solution as explained above. Therefore, we introduced an additionally
MEM_TYPE_PAGE_POOL model for each rq.

The following tests were conducted using pktgen to generate traffic and
evaluate the performance improvement after page pool pages get successfully
recycled in scenarios involving XDP_TX, XDP_REDIRECT, and AF_XDP.

Test environment setup:
ns1                 ns2
veth0   <-peer->    veth1
veth2   <-peer->    veth3

Test Results:
pktgen -> veth1 -> veth0(XDP_TX) -> veth1(XDP_DROP)
    without PP recycle: 1,855,069
    with PP recycle: 2,033,439
    improvement: ~10%

pktgen -> veth1 -> veth0(XDP_TX) -> veth1(XDP_PASS)
    without PP recycle: 1,494,890
    with PP recycle: 1,585,462
    improvement: 5%

pktgen -> veth1 -> veth0(XDP_REDIRECT) -> veth2 -> veth3(XDP_DROP)
    without PP recycle: 1,631,582
    with PP recycle: 1,787,342
    improvement: ~10%

pktgen -> veth1 -> veth0(XDP_REDIRECT) -> veth2 -> veth3(XDP_PASS)
    without PP recycle: 1,309,265
    with PP recycle: 1,391,587
    improvement: ~6%

pktgen -> veth1 -> veth0(AF_XDP) -> user space(DROP)
    without PP recycle: 1,674,021
    with PP recycle: 1,811,844
    improvement: ~8%

Additionally, the performance improvement were measured when converting to
xdp_buff doesn't require buffer copy and original skb uses regular pages,
i.e. page pool recycle not involved. This still gives around 2% improvement
attributed to the changes from consume_skb to kfree_skb_partial.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/veth.c | 64 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 509e901da41d..7234eb0297dd 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -62,6 +62,7 @@ struct veth_rq {
 	struct net_device	*dev;
 	struct bpf_prog __rcu	*xdp_prog;
 	struct xdp_mem_info	xdp_mem;
+	struct xdp_mem_info	xdp_mem_pp;
 	struct veth_rq_stats	stats;
 	bool			rx_notify_masked;
 	struct ptr_ring		xdp_ring;
@@ -728,7 +729,8 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 					struct xdp_buff *xdp,
-					struct sk_buff **pskb)
+					struct sk_buff **pskb,
+					bool *local_pp_alloc)
 {
 	struct sk_buff *skb = *pskb;
 	u32 frame_sz;
@@ -802,6 +804,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 
 		consume_skb(skb);
 		skb = nskb;
+		*local_pp_alloc = true;
 	}
 
 	/* SKB "head" area always have tailroom for skb_shared_info */
@@ -827,6 +830,37 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	return -ENOMEM;
 }
 
+static void __skb2xdp_steal_data(struct sk_buff *skb,
+				 struct xdp_buff *xdp,
+				 struct veth_rq *rq,
+				 bool local_pp_alloc)
+{
+	if (local_pp_alloc) {
+		/* This is the most common case where the skb was reallocated locally in
+		 * veth_convert_skb_to_xdp_buff, and it's safe to use the xdp_mem_pp model.
+		 */
+		xdp->rxq->mem = rq->xdp_mem_pp;
+		kfree_skb_partial(skb, true);
+	} else if (!skb->pp_recycle) {
+		/* We can safely use kfree_skb_partial here because this cannot be an fclone
+		 * skb. Fclone skbs are allocated via __alloc_skb, with their head buffer
+		 * allocated by kmalloc_reserve (i.e. skb->head_frag = 0), satisfying the
+		 * skb_head_is_locked condition in veth_convert_skb_to_xdp_buff, and are
+		 * thus reallocated.
+		 */
+		xdp->rxq->mem = rq->xdp_mem;
+		kfree_skb_partial(skb, true);
+	} else {
+		/* skbs in this case may include page_pool pages from peer. We cannot use
+		 * rq->xdp_mem_pp as for the local_pp_alloc case, because they might already
+		 * be associated with different xdp_mem_info.
+		 */
+		veth_xdp_get(xdp);
+		consume_skb(skb);
+		xdp->rxq->mem = rq->xdp_mem;
+	}
+}
+
 static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 					struct sk_buff *skb,
 					struct veth_xdp_tx_bq *bq,
@@ -836,6 +870,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	struct bpf_prog *xdp_prog;
 	struct veth_xdp_buff vxbuf;
 	struct xdp_buff *xdp = &vxbuf.xdp;
+	bool local_pp_alloc = false;
 	u32 act, metalen;
 	int off;
 
@@ -849,7 +884,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	}
 
 	__skb_push(skb, skb->data - skb_mac_header(skb));
-	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
+	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb, &local_pp_alloc))
 		goto drop;
 	vxbuf.skb = skb;
 
@@ -862,9 +897,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_PASS:
 		break;
 	case XDP_TX:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
+		__skb2xdp_steal_data(skb, xdp, rq, local_pp_alloc);
+
 		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
@@ -874,9 +908,8 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		rcu_read_unlock();
 		goto xdp_xmit;
 	case XDP_REDIRECT:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
+		__skb2xdp_steal_data(skb, xdp, rq, local_pp_alloc);
+
 		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
@@ -1061,6 +1094,14 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 			goto err_page_pool;
 	}
 
+	for (i = start; i < end; i++) {
+		err = xdp_reg_mem_model(&priv->rq[i].xdp_mem_pp,
+					MEM_TYPE_PAGE_POOL,
+					priv->rq[i].page_pool);
+		if (err)
+			goto err_reg_mem;
+	}
+
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
@@ -1082,6 +1123,10 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
 	for (i--; i >= start; i--)
 		ptr_ring_cleanup(&priv->rq[i].xdp_ring, veth_ptr_free);
 	i = end;
+err_reg_mem:
+	for (i--; i >= start; i--)
+		xdp_unreg_mem_model(&priv->rq[i].xdp_mem_pp);
+	i = end;
 err_page_pool:
 	for (i--; i >= start; i--) {
 		page_pool_destroy(priv->rq[i].page_pool);
@@ -1117,6 +1162,9 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
 		ptr_ring_cleanup(&rq->xdp_ring, veth_ptr_free);
 	}
 
+	for (i = start; i < end; i++)
+		xdp_unreg_mem_model(&priv->rq[i].xdp_mem_pp);
+
 	for (i = start; i < end; i++) {
 		page_pool_destroy(priv->rq[i].page_pool);
 		priv->rq[i].page_pool = NULL;
-- 
2.40.1


