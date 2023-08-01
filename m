Return-Path: <netdev+bounces-23062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28476A8D9
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F9A1C20D5C
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9CF4A12;
	Tue,  1 Aug 2023 06:20:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E5C46A2
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 06:20:12 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC00172A
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:20:10 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686e29b058cso3787245b3a.1
        for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690870810; x=1691475610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Ms0XqowSs6BgosKEdgtBRCCzidv4yOMwJh6/f5WUIQ=;
        b=Vkjl7118apaUzoT0SOE2RSB3LI5w+EVXVrGIl0p+TlbuaivvJzc+d0nIcEG7SdR+/O
         4GEulOM8kFOGc/lHKj1dSdODPgdBe2mUGZ9mPaheE42Vza2kSbq9Zl6I0FtMTjIlDY7m
         16KfJAF1we6sHrcBjdtQppDPh8U6dxu5Cb60kdR85hPucwp3jM4wOYIWiNxzaIndH2SC
         n3+UPKNJbipligDftRAd4VA8uTzh5KbKoASO8ayMpjFR3rHf4Tfnf854fsG0hdax0cCo
         OTAfT8R8cWPFasAEftJMT65rYPe/VUwl2lJ/X/tpgfT4ks0I1DKIdchl/vPpBvEtISp/
         lCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690870810; x=1691475610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Ms0XqowSs6BgosKEdgtBRCCzidv4yOMwJh6/f5WUIQ=;
        b=GH2SZwF1/xVaGXAz7cVL8tvJyu1zAN1bA/EMVB0mnowX3rpfxafwiREbqyStF2vttg
         kS5HQw/DZwI+MD9TERH1MB5J5D/3lMgQOxPrvXF89pdK0iU95s1j4A46kB11Oz4EVLYR
         OWR6TjcvBwl/UqHvqzcKq4M0iMAS11mPCjN07UZ4LNh6buOdmm9IR5uCa1Qt/ghwpr6v
         RDoxpY5A2MlP9sGnEU9XtFWPRGcnF/6w4EVpjZo0beqeTSgsZHKtYIP6v/1ZhnCfVq45
         tDxr0Di9UtXNV9+z80E52Ko8+teuUCKbvfLz/FyXAWGZDJXWIOryd5q8v99mnQHW5828
         xDnA==
X-Gm-Message-State: ABy/qLbPJHrymPuLrkAZpYV+bluACViRryTehHXZ89SK7y2w+MDvBkEi
	9TwmzCNto47MRBZHadi1DMY=
X-Google-Smtp-Source: APBJJlFHAqfmt6MOlJPLlFJoSId0XIHbs2AhwlynQzlOQOfyb5HmJcT3BwzLn7pfgeKPXha3ArV8aQ==
X-Received: by 2002:a05:6a00:179d:b0:686:b94a:3879 with SMTP id s29-20020a056a00179d00b00686b94a3879mr15352399pfg.18.1690870809885;
        Mon, 31 Jul 2023 23:20:09 -0700 (PDT)
Received: from localhost.localdomain ([2408:843e:400:7b06:9c8e:d68e:629d:2c7d])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79211000000b0066a31111cc5sm8512735pfo.152.2023.07.31.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 23:20:08 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linyunsheng@huawei.com
Cc: hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [RFC PATCH net-next v2 2/2] net: veth: Improving page pool pages recycling
Date: Tue,  1 Aug 2023 14:19:32 +0800
Message-Id: <20230801061932.10335-2-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230801061932.10335-1-liangchen.linux@gmail.com>
References: <20230801061932.10335-1-liangchen.linux@gmail.com>
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

In addition, to avoid mixing up pages from page pools with different
xdp_mem_id, page pool pages directly coming from the peers are still
converted into regular pages. This is not common, as most of the time,
they will be reallocated in veth_convert_skb_to_xdp_buff.

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
 Changes from v1:
- pp pages from the peers are still converted into regular pages.
---
 drivers/net/veth.c | 48 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 509e901da41d..ea1b344e5db4 100644
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
@@ -836,6 +837,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	struct bpf_prog *xdp_prog;
 	struct veth_xdp_buff vxbuf;
 	struct xdp_buff *xdp = &vxbuf.xdp;
+	struct sk_buff *skb_orig;
 	u32 act, metalen;
 	int off;
 
@@ -848,6 +850,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		goto out;
 	}
 
+	skb_orig = skb;
 	__skb_push(skb, skb->data - skb_mac_header(skb));
 	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
 		goto drop;
@@ -862,9 +865,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_PASS:
 		break;
 	case XDP_TX:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
+		if (skb != skb_orig) {
+			xdp->rxq->mem = rq->xdp_mem_pp;
+			kfree_skb_partial(skb, true);
+		} else if (!skb->pp_recycle) {
+			xdp->rxq->mem = rq->xdp_mem;
+			kfree_skb_partial(skb, true);
+		} else {
+			veth_xdp_get(xdp);
+			consume_skb(skb);
+			xdp->rxq->mem = rq->xdp_mem;
+		}
+
 		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
@@ -874,9 +886,18 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 		rcu_read_unlock();
 		goto xdp_xmit;
 	case XDP_REDIRECT:
-		veth_xdp_get(xdp);
-		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
+		if (skb != skb_orig) {
+			xdp->rxq->mem = rq->xdp_mem_pp;
+			kfree_skb_partial(skb, true);
+		} else if (!skb->pp_recycle) {
+			xdp->rxq->mem = rq->xdp_mem;
+			kfree_skb_partial(skb, true);
+		} else {
+			veth_xdp_get(xdp);
+			consume_skb(skb);
+			xdp->rxq->mem = rq->xdp_mem;
+		}
+
 		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
@@ -1061,6 +1082,14 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
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
 
@@ -1082,6 +1111,10 @@ static int __veth_napi_enable_range(struct net_device *dev, int start, int end)
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
@@ -1117,6 +1150,9 @@ static void veth_napi_del_range(struct net_device *dev, int start, int end)
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


