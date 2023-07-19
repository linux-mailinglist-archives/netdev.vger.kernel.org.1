Return-Path: <netdev+bounces-18879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC9C758F0A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 09:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934F81C20C4C
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54D8C2EF;
	Wed, 19 Jul 2023 07:30:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3172C8C9
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 07:30:16 +0000 (UTC)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322061735
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:30:08 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a43cbb4326so3372545b6e.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 00:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689751807; x=1692343807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUsxddRtqsdWiaCAPofDENzH2V6d3XTUlYIjhXyS7Oc=;
        b=cGU7xMeBIXMIDRFnOMD3UKeNuoEzD1czT/Q73tBuAlOqGQVDlyLBxZwIxGAB+y5zdU
         re46EHG/bGYBt9ipQFDt2U8NK6kKkKqb79sJ1TIPEROI7jBS6prQhgbi6YmcmbL2suT/
         r0SADJoYspd987U4lRf2RJGWtYc2NPrngGN1e2w4tqNYou0Tc189c7kcD6xnMQKVz9Ss
         NUu4KtQKn6Mm22jzOJPgBV/bVSnn+PZDFBNvtWkbku5t6uDUNugzN74Pa8x20h4Em3Ti
         xDHIEsWJ0UhvgwhxpbJaKV5FrzsYUJB/716ipI3/7TXrFaSt1Z7R+j9dVovgEBESPpEC
         7n7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689751807; x=1692343807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUsxddRtqsdWiaCAPofDENzH2V6d3XTUlYIjhXyS7Oc=;
        b=UHGcomDt4M5p8dvhPLZkNpU6UkJcntfPTSiLV2v6ha+qhJ/l07th3nKitkE1yRHySR
         dnWMXJOQUr+S0LzyJlsBGpSTVhu1LPMGVLJreh9xByE/NIUUF+nOUsOZnK86fKjS1muM
         9mrOS93/BdGmbBRAbmFpVV4knyiGTBa1ezdzySVTx9q/C/fDIJJusSd39PS5UWbOXG0J
         BnjFkcTrS3hHCXVHDDRsngTOizbH/yU/47NhYyzaqYX4nFMPpNVpxuJ7d8U2BYQ3/Geu
         5y0/rL50mDBNoiqtXfDTUQN1wPXqunAieItpyr4zvCJ7n/K8jnrJHr5/31RXy+NGlG65
         mFsA==
X-Gm-Message-State: ABy/qLbwJHX7G/MfqcPANyhLLhVlrJnkpMBswaasKvcktwSpjAKUb76m
	OQqkzmdRytrSWp/f9BbABj0=
X-Google-Smtp-Source: APBJJlHxcK0VWAPYK4+KgW6HvJYD+Lc6bnUUYRu3RVIo1Ug3mfgmuyUPWWl/NTv/fb8bEqxAGZ7wDw==
X-Received: by 2002:a05:6808:de1:b0:3a0:6949:c884 with SMTP id g33-20020a0568080de100b003a06949c884mr1458721oic.34.1689751807364;
        Wed, 19 Jul 2023 00:30:07 -0700 (PDT)
Received: from 192.168.0.123 ([123.120.23.36])
        by smtp.googlemail.com with ESMTPSA id b17-20020a17090a8c9100b00264044cca0fsm4287092pjo.1.2023.07.19.00.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:30:06 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	linyunsheng@huawei.com,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [RFC PATCH net-next 2/2] net: veth: Improving page pool recycling
Date: Wed, 19 Jul 2023 15:29:07 +0800
Message-Id: <20230719072907.100948-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230719072907.100948-1-liangchen.linux@gmail.com>
References: <20230719072907.100948-1-liangchen.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
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
    without PP recycle: 1,780,392
    with PP recycle: 1,984,680
    improvement: ~10%

pktgen -> veth1 -> veth0(XDP_TX) -> veth1(XDP_PASS)
    without PP recycle: 1,433,491
    with PP recycle: 1,511,680
    improvement: 5~6%

pktgen -> veth1 -> veth0(XDP_REDIRECT) -> veth2 -> veth3(XDP_DROP)
    without PP recycle: 1,527,708
    with PP recycle: 1,672,101
    improvement: ~10%

pktgen -> veth1 -> veth0(XDP_REDIRECT) -> veth2 -> veth3(XDP_PASS)
    without PP recycle: 1,325,804
    with PP recycle: 1,392,704
    improvement: ~5.5%

pktgen -> veth1 -> veth0(AF_XDP) -> user space(DROP)
    without PP recycle: 1,607,609
    with PP recycle: 1,736,957
    improvement: ~8%

Additionally, the performance improvement were measured when converting to
xdp_buff doesn't require buffer copy and original skb uses regular pages,
i.e. page pool recycle not involved. This still gives around 2% improvement
attributed to the changes from consume_skb to kfree_skb_partial.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/net/veth.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 509e901da41d..a825b086f744 100644
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
@@ -713,19 +714,6 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	}
 }
 
-static void veth_xdp_get(struct xdp_buff *xdp)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-	int i;
-
-	get_page(virt_to_page(xdp->data));
-	if (likely(!xdp_buff_has_frags(xdp)))
-		return;
-
-	for (i = 0; i < sinfo->nr_frags; i++)
-		__skb_frag_ref(&sinfo->frags[i]);
-}
-
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 					struct xdp_buff *xdp,
 					struct sk_buff **pskb)
@@ -862,9 +850,9 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_PASS:
 		break;
 	case XDP_TX:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
+		xdp->rxq->mem = skb->pp_recycle ? rq->xdp_mem_pp : rq->xdp_mem;
+		kfree_skb_partial(skb, true);
+
 		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
@@ -874,9 +862,9 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		rcu_read_unlock();
 		goto xdp_xmit;
 	case XDP_REDIRECT:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
+		xdp->rxq->mem = skb->pp_recycle ? rq->xdp_mem_pp : rq->xdp_mem;
+		kfree_skb_partial(skb, true);
+
 		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
@@ -1061,6 +1049,14 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
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
 
@@ -1082,6 +1078,10 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
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
@@ -1117,6 +1117,9 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
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


