Return-Path: <netdev+bounces-29049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE1781765
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 06:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7161D281CC2
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE01116;
	Sat, 19 Aug 2023 04:41:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116161858
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 04:41:07 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADB1A7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d73db0a7e03so2242096276.2
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692420065; x=1693024865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Yzqiom9eaEF1INfhowiJaKJJqohj5QTaU6lO3aCBxU=;
        b=GBbSqTBLoecv/xjNFmP1jqbTjUR9ci2KHs6HJp/Pa6N+dUVszHdztvHKlncOi1aJUZ
         aHsWzHTsUlhQNy/ysdM2cQlCXF2IUkTw3BKgNhEXdDnIFfU5WcBpirDgC8X4vqm1DW/3
         XdMeEF/aJAMD4g9A97WTutqztlbfUdWJF8uI3yG/zcGQLLhHlL//LSFLb0S+ETyxYrOK
         yZowM2XiS+6nlR0oazxBgM6dTC0sG9RLBZDjCCpfUS2BbnRYa5PMJ7nQ4MOkigtvpKu2
         GI/xvp/ETGmJz1oKFrVwMElKqOmS5q5pSJbzk9femdfeKWDmNA83gUGybErWcGkA8T+n
         kGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692420065; x=1693024865;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Yzqiom9eaEF1INfhowiJaKJJqohj5QTaU6lO3aCBxU=;
        b=dWD6Xx+NB7vSTieOHma/m+Xn/U5IGCvTyBFbHhM3+EdTcI5L5rpv/h5YcrDhJwxYEU
         Qv7l9doqEdEeQYKD3GYvYTFezPUpgGpcGLOQTJsvvPqdCN91nu3lb8C85G/juxIQNJaP
         DZB79Nbf0kqm8Wb4avVFAzpjuGvirBsUokj95pd85v3wdkxsbIrLbVgQfPLvuZtFBdYl
         QnHse+lrjY+i5mu803ov86+xtT7R6rlpmwlLHQyHrdJII1nNYOEFa/feRzDuoWV5ysL2
         JDGO8Ugy0jUA89fs3rSg1XLNIPYLeAnm+ljo+XuQ3BzUI7L00/oBdEcNDGJ3alHwMW18
         Fm2w==
X-Gm-Message-State: AOJu0YywhdoVlf+FIgPfQA4Q+I9ifW5WZ5fzeZ4YySSpHXEEP/pi1PoJ
	voFoPNIfw2Pwck8ZZmp5wHiwk395AYjbkw==
X-Google-Smtp-Source: AGHT+IG/ITKm2AZrrrMcVDbiyN7rrueQ8HCzG3OwBp78CvAaOlG16IMe6JztZlxRgw6dpabegRU29TsHLLJb3g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:add5:0:b0:d46:45a1:b775 with SMTP id
 d21-20020a25add5000000b00d4645a1b775mr9583ybe.3.1692420064934; Fri, 18 Aug
 2023 21:41:04 -0700 (PDT)
Date: Sat, 19 Aug 2023 04:40:58 +0000
In-Reply-To: <20230819044059.833749-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230819044059.833749-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819044059.833749-3-edumazet@google.com>
Subject: [PATCH net-next 2/3] virtio_net: avoid data-races on dev->stats fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use DEV_STATS_INC() and DEV_STATS_READ() which provide
atomicity on paths that can be used concurrently.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 494242bb9cf60cfd54381f12eef338711a558483..d0570de1b0b47ee585ff8945a438e7cd2e1a7de5 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1085,7 +1085,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	if (unlikely(len > GOOD_PACKET_LEN)) {
 		pr_debug("%s: rx error: len %u exceeds max size %d\n",
 			 dev->name, len, GOOD_PACKET_LEN);
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		goto err;
 	}
 
@@ -1150,7 +1150,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers missing\n",
 				 dev->name, num_buf);
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			break;
 		}
 		stats->bytes += len;
@@ -1259,7 +1259,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
 				 dev->name, *num_buf,
 				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
@@ -1278,7 +1278,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			put_page(page);
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
@@ -1457,7 +1457,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(len > truesize - room)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 			 dev->name, len, (unsigned long)(truesize - room));
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		goto err_skb;
 	}
 
@@ -1489,7 +1489,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				 dev->name, num_buf,
 				 virtio16_to_cpu(vi->vdev,
 						 hdr->num_buffers));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_buf;
 		}
 
@@ -1503,7 +1503,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		if (unlikely(len > truesize - room)) {
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_skb;
 		}
 
@@ -1590,7 +1590,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		virtnet_rq_free_unused_buf(rq->vq, buf);
 		return;
 	}
@@ -1630,7 +1630,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	return;
 
 frame_err:
-	dev->stats.rx_frame_errors++;
+	DEV_STATS_INC(dev, rx_frame_errors);
 	dev_kfree_skb(skb);
 }
 
@@ -2170,12 +2170,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	/* This should not happen! */
 	if (unlikely(err)) {
-		dev->stats.tx_fifo_errors++;
+		DEV_STATS_INC(dev, tx_fifo_errors);
 		if (net_ratelimit())
 			dev_warn(&dev->dev,
 				 "Unexpected TXQ (%d) queue failure: %d\n",
 				 qnum, err);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
@@ -2394,10 +2394,10 @@ static void virtnet_stats(struct net_device *dev,
 		tot->tx_errors  += terrors;
 	}
 
-	tot->tx_dropped = dev->stats.tx_dropped;
-	tot->tx_fifo_errors = dev->stats.tx_fifo_errors;
-	tot->rx_length_errors = dev->stats.rx_length_errors;
-	tot->rx_frame_errors = dev->stats.rx_frame_errors;
+	tot->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	tot->tx_fifo_errors = DEV_STATS_READ(dev, tx_fifo_errors);
+	tot->rx_length_errors = DEV_STATS_READ(dev, rx_length_errors);
+	tot->rx_frame_errors = DEV_STATS_READ(dev, rx_frame_errors);
 }
 
 static void virtnet_ack_link_announce(struct virtnet_info *vi)
-- 
2.42.0.rc1.204.g551eb34607-goog


