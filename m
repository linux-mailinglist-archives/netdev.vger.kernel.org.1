Return-Path: <netdev+bounces-44533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DE7D8770
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 19:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5610A281FAA
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED25138DCE;
	Thu, 26 Oct 2023 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XvdXLt6H"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708D156FA
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 17:18:46 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C41B6
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:18:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso322134276.2
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698340723; x=1698945523; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3WXaTVKlWsMwc1y5n08t2095GKSBp/vBLEIfVJQIPvM=;
        b=XvdXLt6HQcdqdiyfNTjTQC1FCksByM9Uu0jE/8fAhDRtgDqC+Uo6nO0fIfQKCMqzv7
         wqwVh3gZ8Qj9fx3Wjj2omPcqzh2+Cw9U7mpd6XQZFZddbEubppWfmPs41AHlTrqDL6ry
         o0MItFZqzsldFlv17II3QdebU0ctHkJiGYs34QEFroXQQ2P2IvgHi8sqfqf16njZWTnD
         2GtydlXm6JNggm/MHsawExWCuUVxEZ78vzOl99roxSIQtyFxHT7AN5/4fydSVN/ALWD7
         Upm0nbCB8of7ZAhAMhO5z6adelInlHgx54n+H/N6YliR5wp8KV8rhvz6q11OKXo12a14
         ee2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698340723; x=1698945523;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WXaTVKlWsMwc1y5n08t2095GKSBp/vBLEIfVJQIPvM=;
        b=xDay4na7oovyhsWILnHOXvjWlDLSDQ7J3yHghr5XIz8q0eTksuBhEYQafWtfZx/pMe
         zPbfwINia0xpX0uA/mQi/XkC8Ukrd+yZeMMzdthwdF5sz1x3DMfJ7Fgujng8oeo6F1di
         aoyVITNyFGER7MEPSnwKox4n1WwxSMSYJ59JyxXKgYI0b82wnVjy5fWy1FUp5AotPOdw
         eeyLRqIog4Xn9xsO9AB6QmRra5ykidGJBjvkfGlm9YAD/vaTTDSvnfZNkQeidyXNkcbj
         zpgG8ROaRq5rMOGrWkYZBp+0Gl9QhwLIxX9vpt91AnA7ndJzoWIUHbMnZ9CwQcQcLeB8
         eqlQ==
X-Gm-Message-State: AOJu0YwHCe6Wy7O7+4Jn/o7I/wScqTBcfqVk6AEkuza5ap9W8WBF5ETA
	7gm+5LMrgdAt4i/wi7N/KMnwhRy4DpMOqg==
X-Google-Smtp-Source: AGHT+IHqh4rhCUfgcXnaR2iqhRay4fknXO9keDlNtnJM5r6RB31f+YCGPjiKBD79Xj3YFFsSS1jpD1cx1PIW5g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1083:b0:d9a:47ea:69a5 with SMTP
 id v3-20020a056902108300b00d9a47ea69a5mr523707ybu.1.1698340723006; Thu, 26
 Oct 2023 10:18:43 -0700 (PDT)
Date: Thu, 26 Oct 2023 17:18:40 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231026171840.4082735-1-edumazet@google.com>
Subject: [PATCH net-next] virtio_net: use u64_stats_t infra to avoid data-races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a data-race in virtnet_poll / virtnet_stats [1]

u64_stats_t infra has very nice accessors that must be used
to avoid potential load-store tearing.

[1]
BUG: KCSAN: data-race in virtnet_poll / virtnet_stats

read-write to 0xffff88810271b1a0 of 8 bytes by interrupt on cpu 0:
virtnet_receive drivers/net/virtio_net.c:2102 [inline]
virtnet_poll+0x6c8/0xb40 drivers/net/virtio_net.c:2148
__napi_poll+0x60/0x3b0 net/core/dev.c:6527
napi_poll net/core/dev.c:6594 [inline]
net_rx_action+0x32b/0x750 net/core/dev.c:6727
__do_softirq+0xc1/0x265 kernel/softirq.c:553
invoke_softirq kernel/softirq.c:427 [inline]
__irq_exit_rcu kernel/softirq.c:632 [inline]
irq_exit_rcu+0x3b/0x90 kernel/softirq.c:644
common_interrupt+0x7f/0x90 arch/x86/kernel/irq.c:247
asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
__sanitizer_cov_trace_const_cmp8+0x0/0x80 kernel/kcov.c:306
jbd2_write_access_granted fs/jbd2/transaction.c:1174 [inline]
jbd2_journal_get_write_access+0x94/0x1c0 fs/jbd2/transaction.c:1239
__ext4_journal_get_write_access+0x154/0x3f0 fs/ext4/ext4_jbd2.c:241
ext4_reserve_inode_write+0x14e/0x200 fs/ext4/inode.c:5745
__ext4_mark_inode_dirty+0x8e/0x440 fs/ext4/inode.c:5919
ext4_evict_inode+0xaf0/0xdc0 fs/ext4/inode.c:299
evict+0x1aa/0x410 fs/inode.c:664
iput_final fs/inode.c:1775 [inline]
iput+0x42c/0x5b0 fs/inode.c:1801
do_unlinkat+0x2b9/0x4f0 fs/namei.c:4405
__do_sys_unlink fs/namei.c:4446 [inline]
__se_sys_unlink fs/namei.c:4444 [inline]
__x64_sys_unlink+0x30/0x40 fs/namei.c:4444
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88810271b1a0 of 8 bytes by task 2814 on cpu 1:
virtnet_stats+0x1b3/0x340 drivers/net/virtio_net.c:2564
dev_get_stats+0x6d/0x860 net/core/dev.c:10511
rtnl_fill_stats+0x45/0x320 net/core/rtnetlink.c:1261
rtnl_fill_ifinfo+0xd0e/0x1120 net/core/rtnetlink.c:1867
rtnl_dump_ifinfo+0x7f9/0xc20 net/core/rtnetlink.c:2240
netlink_dump+0x390/0x720 net/netlink/af_netlink.c:2266
netlink_recvmsg+0x425/0x780 net/netlink/af_netlink.c:1992
sock_recvmsg_nosec net/socket.c:1027 [inline]
sock_recvmsg net/socket.c:1049 [inline]
____sys_recvmsg+0x156/0x310 net/socket.c:2760
___sys_recvmsg net/socket.c:2802 [inline]
__sys_recvmsg+0x1ea/0x270 net/socket.c:2832
__do_sys_recvmsg net/socket.c:2842 [inline]
__se_sys_recvmsg net/socket.c:2839 [inline]
__x64_sys_recvmsg+0x46/0x50 net/socket.c:2839
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x000000000045c334 -> 0x000000000045c376

Fixes: 3fa2a1df9094 ("virtio-net: per cpu 64 bit stats (v2)")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/virtio_net.c | 124 ++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 59 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 62962216b80c1537b06c1154315c8cd1c9c33413..d16f592c2061fad0414ed893672f91b7813c6423 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -81,24 +81,24 @@ struct virtnet_stat_desc {
 
 struct virtnet_sq_stats {
 	struct u64_stats_sync syncp;
-	u64 packets;
-	u64 bytes;
-	u64 xdp_tx;
-	u64 xdp_tx_drops;
-	u64 kicks;
-	u64 tx_timeouts;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t xdp_tx;
+	u64_stats_t xdp_tx_drops;
+	u64_stats_t kicks;
+	u64_stats_t tx_timeouts;
 };
 
 struct virtnet_rq_stats {
 	struct u64_stats_sync syncp;
-	u64 packets;
-	u64 bytes;
-	u64 drops;
-	u64 xdp_packets;
-	u64 xdp_tx;
-	u64 xdp_redirects;
-	u64 xdp_drops;
-	u64 kicks;
+	u64_stats_t packets;
+	u64_stats_t bytes;
+	u64_stats_t drops;
+	u64_stats_t xdp_packets;
+	u64_stats_t xdp_tx;
+	u64_stats_t xdp_redirects;
+	u64_stats_t xdp_drops;
+	u64_stats_t kicks;
 };
 
 #define VIRTNET_SQ_STAT(m)	offsetof(struct virtnet_sq_stats, m)
@@ -775,8 +775,8 @@ static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 		return;
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	sq->stats.bytes += bytes;
-	sq->stats.packets += packets;
+	u64_stats_add(&sq->stats.bytes, bytes);
+	u64_stats_add(&sq->stats.packets, packets);
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
@@ -975,11 +975,11 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 out:
 	u64_stats_update_begin(&sq->stats.syncp);
-	sq->stats.bytes += bytes;
-	sq->stats.packets += packets;
-	sq->stats.xdp_tx += n;
-	sq->stats.xdp_tx_drops += n - nxmit;
-	sq->stats.kicks += kicks;
+	u64_stats_add(&sq->stats.bytes, bytes);
+	u64_stats_add(&sq->stats.packets, packets);
+	u64_stats_add(&sq->stats.xdp_tx, n);
+	u64_stats_add(&sq->stats.xdp_tx_drops, n - nxmit);
+	u64_stats_add(&sq->stats.kicks, kicks);
 	u64_stats_update_end(&sq->stats.syncp);
 
 	virtnet_xdp_put_sq(vi, sq);
@@ -1011,14 +1011,14 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 	u32 act;
 
 	act = bpf_prog_run_xdp(xdp_prog, xdp);
-	stats->xdp_packets++;
+	u64_stats_inc(&stats->xdp_packets);
 
 	switch (act) {
 	case XDP_PASS:
 		return act;
 
 	case XDP_TX:
-		stats->xdp_tx++;
+		u64_stats_inc(&stats->xdp_tx);
 		xdpf = xdp_convert_buff_to_frame(xdp);
 		if (unlikely(!xdpf)) {
 			netdev_dbg(dev, "convert buff to frame failed for xdp\n");
@@ -1036,7 +1036,7 @@ static int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 		return act;
 
 	case XDP_REDIRECT:
-		stats->xdp_redirects++;
+		u64_stats_inc(&stats->xdp_redirects);
 		err = xdp_do_redirect(dev, xdp, xdp_prog);
 		if (err)
 			return XDP_DROP;
@@ -1232,9 +1232,9 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
 	return skb;
 
 err_xdp:
-	stats->xdp_drops++;
+	u64_stats_inc(&stats->xdp_drops);
 err:
-	stats->drops++;
+	u64_stats_inc(&stats->drops);
 	put_page(page);
 xdp_xmit:
 	return NULL;
@@ -1253,7 +1253,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	struct sk_buff *skb;
 
 	len -= vi->hdr_len;
-	stats->bytes += len;
+	u64_stats_add(&stats->bytes, len);
 
 	if (unlikely(len > GOOD_PACKET_LEN)) {
 		pr_debug("%s: rx error: len %u exceeds max size %d\n",
@@ -1282,7 +1282,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 		return skb;
 
 err:
-	stats->drops++;
+	u64_stats_inc(&stats->drops);
 	put_page(page);
 	return NULL;
 }
@@ -1298,14 +1298,14 @@ static struct sk_buff *receive_big(struct net_device *dev,
 	struct sk_buff *skb =
 		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
 
-	stats->bytes += len - vi->hdr_len;
+	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 	if (unlikely(!skb))
 		goto err;
 
 	return skb;
 
 err:
-	stats->drops++;
+	u64_stats_inc(&stats->drops);
 	give_pages(rq, page);
 	return NULL;
 }
@@ -1326,7 +1326,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 			DEV_STATS_INC(dev, rx_length_errors);
 			break;
 		}
-		stats->bytes += len;
+		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 		put_page(page);
 	}
@@ -1436,7 +1436,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			goto err;
 		}
 
-		stats->bytes += len;
+		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 		offset = buf - page_address(page);
 
@@ -1600,8 +1600,8 @@ static struct sk_buff *receive_mergeable_xdp(struct net_device *dev,
 	put_page(page);
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
-	stats->xdp_drops++;
-	stats->drops++;
+	u64_stats_inc(&stats->xdp_drops);
+	u64_stats_inc(&stats->drops);
 	return NULL;
 }
 
@@ -1625,7 +1625,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	unsigned int room = SKB_DATA_ALIGN(headroom + tailroom);
 
 	head_skb = NULL;
-	stats->bytes += len - vi->hdr_len;
+	u64_stats_add(&stats->bytes, len - vi->hdr_len);
 
 	if (unlikely(len > truesize - room)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
@@ -1666,7 +1666,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 			goto err_buf;
 		}
 
-		stats->bytes += len;
+		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 
 		truesize = mergeable_ctx_to_truesize(ctx);
@@ -1718,7 +1718,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	mergeable_buf_free(rq, num_buf, dev, stats);
 
 err_buf:
-	stats->drops++;
+	u64_stats_inc(&stats->drops);
 	dev_kfree_skb(head_skb);
 	return NULL;
 }
@@ -1985,7 +1985,7 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
 		unsigned long flags;
 
 		flags = u64_stats_update_begin_irqsave(&rq->stats.syncp);
-		rq->stats.kicks++;
+		u64_stats_inc(&rq->stats.kicks);
 		u64_stats_update_end_irqrestore(&rq->stats.syncp, flags);
 	}
 
@@ -2065,22 +2065,23 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 	struct virtnet_info *vi = rq->vq->vdev->priv;
 	struct virtnet_rq_stats stats = {};
 	unsigned int len;
+	int packets = 0;
 	void *buf;
 	int i;
 
 	if (!vi->big_packets || vi->mergeable_rx_bufs) {
 		void *ctx;
 
-		while (stats.packets < budget &&
+		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, &ctx))) {
 			receive_buf(vi, rq, buf, len, ctx, xdp_xmit, &stats);
-			stats.packets++;
+			packets++;
 		}
 	} else {
-		while (stats.packets < budget &&
+		while (packets < budget &&
 		       (buf = virtnet_rq_get_buf(rq, &len, NULL)) != NULL) {
 			receive_buf(vi, rq, buf, len, NULL, xdp_xmit, &stats);
-			stats.packets++;
+			packets++;
 		}
 	}
 
@@ -2093,17 +2094,19 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
 		}
 	}
 
+	u64_stats_set(&stats.packets, packets);
 	u64_stats_update_begin(&rq->stats.syncp);
 	for (i = 0; i < VIRTNET_RQ_STATS_LEN; i++) {
 		size_t offset = virtnet_rq_stats_desc[i].offset;
-		u64 *item;
+		u64_stats_t *item, *src;
 
-		item = (u64 *)((u8 *)&rq->stats + offset);
-		*item += *(u64 *)((u8 *)&stats + offset);
+		item = (u64_stats_t *)((u8 *)&rq->stats + offset);
+		src = (u64_stats_t *)((u8 *)&stats + offset);
+		u64_stats_add(item, u64_stats_read(src));
 	}
 	u64_stats_update_end(&rq->stats.syncp);
 
-	return stats.packets;
+	return packets;
 }
 
 static void virtnet_poll_cleantx(struct receive_queue *rq)
@@ -2158,7 +2161,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 		sq = virtnet_xdp_get_sq(vi);
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
-			sq->stats.kicks++;
+			u64_stats_inc(&sq->stats.kicks);
 			u64_stats_update_end(&sq->stats.syncp);
 		}
 		virtnet_xdp_put_sq(vi, sq);
@@ -2370,7 +2373,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (kick || netif_xmit_stopped(txq)) {
 		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
 			u64_stats_update_begin(&sq->stats.syncp);
-			sq->stats.kicks++;
+			u64_stats_inc(&sq->stats.kicks);
 			u64_stats_update_end(&sq->stats.syncp);
 		}
 	}
@@ -2553,16 +2556,16 @@ static void virtnet_stats(struct net_device *dev,
 
 		do {
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
-			tpackets = sq->stats.packets;
-			tbytes   = sq->stats.bytes;
-			terrors  = sq->stats.tx_timeouts;
+			tpackets = u64_stats_read(&sq->stats.packets);
+			tbytes   = u64_stats_read(&sq->stats.bytes);
+			terrors  = u64_stats_read(&sq->stats.tx_timeouts);
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 
 		do {
 			start = u64_stats_fetch_begin(&rq->stats.syncp);
-			rpackets = rq->stats.packets;
-			rbytes   = rq->stats.bytes;
-			rdrops   = rq->stats.drops;
+			rpackets = u64_stats_read(&rq->stats.packets);
+			rbytes   = u64_stats_read(&rq->stats.bytes);
+			rdrops   = u64_stats_read(&rq->stats.drops);
 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 
 		tot->rx_packets += rpackets;
@@ -3191,17 +3194,19 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	unsigned int idx = 0, start, i, j;
 	const u8 *stats_base;
+	const u64_stats_t *p;
 	size_t offset;
 
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct receive_queue *rq = &vi->rq[i];
 
-		stats_base = (u8 *)&rq->stats;
+		stats_base = (const u8 *)&rq->stats;
 		do {
 			start = u64_stats_fetch_begin(&rq->stats.syncp);
 			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++) {
 				offset = virtnet_rq_stats_desc[j].offset;
-				data[idx + j] = *(u64 *)(stats_base + offset);
+				p = (const u64_stats_t *)(stats_base + offset);
+				data[idx + j] = u64_stats_read(p);
 			}
 		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
 		idx += VIRTNET_RQ_STATS_LEN;
@@ -3210,12 +3215,13 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
 	for (i = 0; i < vi->curr_queue_pairs; i++) {
 		struct send_queue *sq = &vi->sq[i];
 
-		stats_base = (u8 *)&sq->stats;
+		stats_base = (const u8 *)&sq->stats;
 		do {
 			start = u64_stats_fetch_begin(&sq->stats.syncp);
 			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++) {
 				offset = virtnet_sq_stats_desc[j].offset;
-				data[idx + j] = *(u64 *)(stats_base + offset);
+				p = (const u64_stats_t *)(stats_base + offset);
+				data[idx + j] = u64_stats_read(p);
 			}
 		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
 		idx += VIRTNET_SQ_STATS_LEN;
@@ -3898,7 +3904,7 @@ static void virtnet_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
 
 	u64_stats_update_begin(&sq->stats.syncp);
-	sq->stats.tx_timeouts++;
+	u64_stats_inc(&sq->stats.tx_timeouts);
 	u64_stats_update_end(&sq->stats.syncp);
 
 	netdev_err(dev, "TX timeout on queue: %u, sq: %s, vq: 0x%x, name: %s, %u usecs ago\n",
-- 
2.42.0.758.gaed0368e0e-goog


