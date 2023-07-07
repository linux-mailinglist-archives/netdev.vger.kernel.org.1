Return-Path: <netdev+bounces-16121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5324674B725
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 21:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC8B280FE7
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F6B17ADF;
	Fri,  7 Jul 2023 19:30:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556717AD9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 19:30:34 +0000 (UTC)
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CD12139
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 12:30:19 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b523cf593so2752485a12.1
        for <netdev@vger.kernel.org>; Fri, 07 Jul 2023 12:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758219; x=1691350219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cz5iN1Q4Y5hZZHVnPbPIgzkdKqaBDknEtAb7LANxiZ4=;
        b=h/ZmG0mnTphFv0RxWJHC9kD68nw5nUb2NiLUXCI+QQWkTqyRsNCk6/6veQjwa19FOH
         +hcpCQjS++tf2Xyxlx6zG+KKjSXA2nN5IEceRNd9CBcD59tP8Sm0RRE+QkXcNudXKfLF
         siWadoqxFqGIblnrKOG8g6BFlWpXSmsoNNlmq6a3JuM8t0iPSPEKr91rs3gnxhvoS4ft
         OOt9aDEe/U15VcPop3jx6jqVygZ0oKquCZjgUkhN9n7z215cumO1VcT+nuQPUAtJ5U1Z
         s9a0YSaq+Ug+fbOkUvyO1rL8tYTNYqLq/q3e3bejZmpOtX8o3KKbGybKFXWcXxY2JAqj
         C9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758219; x=1691350219;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cz5iN1Q4Y5hZZHVnPbPIgzkdKqaBDknEtAb7LANxiZ4=;
        b=jypOF/d1Op+4wYI94a8PgLkaR2TPr8pk3YJZjpuzVd/fu20xDLdbb8GL9h0tr390bp
         ETmZTGXndO0Tj8NTVsTD7W23EVHEb1ijikWgkcNh+hf+XVJAPf3N4EiuRnWWcjw3YxQO
         oFlzSgOHRfdKx5ulv8p6XryDIKUK9zQg+y6HYa3J6GJpTrUMTfYPxyNAPwTl2XtK5xg+
         tYsEhj1IP1iUKAGRvq4/mRDg0UhvVP9lEdqH8xDvLtEzGfs919ERG2pi9wwoZqF8TfkQ
         atnQQTHDttoXNdz+vfW6vwM+sGhUQ2OLmmY7iIFVxirbsUgubK3GiuvfWlHG1RoRkGBp
         eoCA==
X-Gm-Message-State: ABy/qLarRxloQ7Tms60gj4OwuaKk6QHK+w/i+X2m8JsNpOv5GXVWJvWZ
	bqUhja69Hym4q2JOMLsWmvlESdE=
X-Google-Smtp-Source: APBJJlHfOcXUVQFu5j8d7jKsGISsaA6lDoRvIjovgEPsq9+lrnIvXKoXfnN0hD6Z/tUYpOCAX3RTvU8=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:1556:0:b0:553:828e:b3e8 with SMTP id
 22-20020a631556000000b00553828eb3e8mr4060001pgv.3.1688758219278; Fri, 07 Jul
 2023 12:30:19 -0700 (PDT)
Date: Fri,  7 Jul 2023 12:29:58 -0700
In-Reply-To: <20230707193006.1309662-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707193006.1309662-1-sdf@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707193006.1309662-7-sdf@google.com>
Subject: [RFC bpf-next v3 06/14] net: veth: Implement devtx timestamp kfuncs
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, netdev@vger.kernel.org, xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Have a software-based example for kfuncs to showcase how it
can be used in the real devices and to have something to
test against in the selftests.

Both path (skb & xdp) are covered. Only the skb path is really
tested though.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 drivers/net/veth.c | 97 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 614f3e3efab0..5af4b15e107c 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -27,6 +27,7 @@
 #include <linux/bpf_trace.h>
 #include <linux/net_tstamp.h>
 #include <net/page_pool.h>
+#include <net/devtx.h>
 
 #define DRV_NAME	"veth"
 #define DRV_VERSION	"1.0"
@@ -123,6 +124,13 @@ struct veth_xdp_buff {
 	struct sk_buff *skb;
 };
 
+struct veth_devtx_ctx {
+	struct devtx_ctx devtx;
+	struct xdp_frame *xdpf;
+	struct sk_buff *skb;
+	ktime_t xdp_tx_timestamp;
+};
+
 static int veth_get_link_ksettings(struct net_device *dev,
 				   struct ethtool_link_ksettings *cmd)
 {
@@ -313,10 +321,33 @@ static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
 	return NET_RX_SUCCESS;
 }
 
+DEFINE_DEVTX_HOOKS(veth);
+
 static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
 			    struct veth_rq *rq, bool xdp)
 {
-	return __dev_forward_skb(dev, skb) ?: xdp ?
+	struct net_device *orig_dev = skb->dev;
+	int ret;
+
+	ret = __dev_forward_skb(dev, skb);
+	if (ret)
+		return ret;
+
+	if (devtx_enabled()) {
+		struct veth_devtx_ctx ctx = {
+			.devtx = {
+				.netdev = orig_dev,
+				.sinfo = skb_shinfo(skb),
+			},
+			.skb = skb,
+		};
+
+		__skb_push(skb, ETH_HLEN);
+		veth_devtx_complete_skb(&ctx.devtx, skb);
+		__skb_pull(skb, ETH_HLEN);
+	}
+
+	return xdp ?
 		veth_xdp_rx(rq, skb) :
 		__netif_rx(skb);
 }
@@ -356,6 +387,18 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto drop;
 	}
 
+	if (devtx_enabled()) {
+		struct veth_devtx_ctx ctx = {
+			.devtx = {
+				.netdev = skb->dev,
+				.sinfo = skb_shinfo(skb),
+			},
+			.skb = skb,
+		};
+
+		veth_devtx_submit_skb(&ctx.devtx, skb);
+	}
+
 	rcv_priv = netdev_priv(rcv);
 	rxq = skb_get_queue_mapping(skb);
 	if (rxq < rcv->real_num_rx_queues) {
@@ -509,11 +552,28 @@ static int veth_xdp_xmit(struct net_device *dev, int n,
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *frame = frames[i];
 		void *ptr = veth_xdp_to_ptr(frame);
+		struct veth_devtx_ctx ctx;
 
 		if (unlikely(xdp_get_frame_len(frame) > max_len ||
-			     __ptr_ring_produce(&rq->xdp_ring, ptr)))
+			     __ptr_ring_full(&rq->xdp_ring)))
+			break;
+
+		if (devtx_enabled()) {
+			memset(&ctx, 0, sizeof(ctx));
+			ctx.devtx.netdev = dev;
+			ctx.devtx.sinfo = xdp_frame_has_frags(frame) ?
+				xdp_get_shared_info_from_frame(frame) : NULL;
+			ctx.xdpf = frame;
+
+			veth_devtx_submit_xdp(&ctx.devtx, frame);
+		}
+
+		if (unlikely(__ptr_ring_produce(&rq->xdp_ring, ptr)))
 			break;
 		nxmit++;
+
+		if (devtx_enabled())
+			veth_devtx_complete_xdp(&ctx.devtx, frame);
 	}
 	spin_unlock(&rq->xdp_ring.producer_lock);
 
@@ -1732,6 +1792,28 @@ static int veth_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 	return 0;
 }
 
+static int veth_devtx_request_tx_timestamp(const struct devtx_ctx *_ctx)
+{
+	struct veth_devtx_ctx *ctx = (struct veth_devtx_ctx *)_ctx;
+
+	if (ctx->skb)
+		__net_timestamp(ctx->skb);
+	else
+		ctx->xdp_tx_timestamp = ktime_get_real();
+
+	return 0;
+}
+
+static int veth_devtx_tx_timestamp(const struct devtx_ctx *_ctx, u64 *timestamp)
+{
+	struct veth_devtx_ctx *ctx = (struct veth_devtx_ctx *)_ctx;
+
+	if (ctx->skb)
+		*timestamp = ctx->skb->tstamp;
+
+	return 0;
+}
+
 static const struct net_device_ops veth_netdev_ops = {
 	.ndo_init            = veth_dev_init,
 	.ndo_open            = veth_open,
@@ -1756,6 +1838,8 @@ static const struct net_device_ops veth_netdev_ops = {
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
 	.xmo_rx_timestamp		= veth_xdp_rx_timestamp,
 	.xmo_rx_hash			= veth_xdp_rx_hash,
+	.xmo_request_tx_timestamp	= veth_devtx_request_tx_timestamp,
+	.xmo_tx_timestamp		= veth_devtx_tx_timestamp,
 };
 
 #define VETH_FEATURES (NETIF_F_SG | NETIF_F_FRAGLIST | NETIF_F_HW_CSUM | \
@@ -2041,11 +2125,20 @@ static struct rtnl_link_ops veth_link_ops = {
 
 static __init int veth_init(void)
 {
+	int ret;
+
+	ret = devtx_hooks_register(&veth_devtx_hook_ids, &veth_xdp_metadata_ops);
+	if (ret) {
+		pr_warn("failed to register devtx hooks: %d", ret);
+		return ret;
+	}
+
 	return rtnl_link_register(&veth_link_ops);
 }
 
 static __exit void veth_exit(void)
 {
+	devtx_hooks_unregister(&veth_devtx_hook_ids);
 	rtnl_link_unregister(&veth_link_ops);
 }
 
-- 
2.41.0.255.g8b1d071c50-goog


