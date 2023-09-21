Return-Path: <netdev+bounces-35557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7237A9CCE
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E062A283A32
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B1A68637;
	Thu, 21 Sep 2023 18:35:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8383513D9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:34:56 +0000 (UTC)
Received: from mail-oa1-x49.google.com (mail-oa1-x49.google.com [IPv6:2001:4860:4864:20::49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626CD3174
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:23:53 -0700 (PDT)
Received: by mail-oa1-x49.google.com with SMTP id 586e51a60fabf-1b0812d43a0so1703605fac.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320633; x=1695925433; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nCXDxhqgB2KOjhlkYu+0i3zhJCMZLxANh+kIk0t/1r0=;
        b=jVsPrsS+qWLgoEwfcTIkQsZdS5NsKAiq6qg11Or5hD8uZIR8q4lMboRdL4Nlgku36O
         o7YwlpqlW4u5IVE3TNC6LQXBZ+j2/OxsUAJrGwSbQIc+J3exu60frbECx5GrCYs0MPrI
         Bx7VWSj/qNNgn1Rdv7rry27Z/Qer7bnz3l/jVAGJrtd0I7/zIpZ7y5r1ZgkZcNgG4Z7f
         YJNzlqP/8WziUnf05XvQDSoZp2dCPVsw/NDJE6kVC2OIr//zldHPk6jbNjFPLDnJqZdo
         Sxej/mnnrG3903zpZ8w9tE5RiV6Kac3s6PMuKKC+N0yQr4zxrO66is2ydmZMYS3XvTu4
         ZFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320633; x=1695925433;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nCXDxhqgB2KOjhlkYu+0i3zhJCMZLxANh+kIk0t/1r0=;
        b=NFdnX++jwpBlNIEnZXevdCZg2jsmkCJgVC3Af1YNiy8YIA6Fz3dLqyn1zLPV+V9b0z
         TBadtVKres62wnAtkj1bOFKDJNm5pPijZnB5HSYZyESk3OpUumH5sI59XhDs+fRdpgla
         RQDUYhbEUOJqwubNVLY0AFrE4gf1aKwuaES4IkF+rWrohJWp87jkzwsRWqw/P8mrE2fe
         2XJvikBQrV43uPdcqiMrk9YP73dEv5311fEOaHa2zbFyRrNYdIl1IkQa+YPnW/J2uU6+
         oN6tPuotA66ODwhqMEQl0lkQRIItA2bjOWX+4Uj7h5C+4CqFHWrbD5IYoGgwV+ucN6XH
         OD+g==
X-Gm-Message-State: AOJu0YyXY1+m/6zGyjTQnLbtL0/iv/4sFbuU9Q6itA5CQwn1Qj+9fVbk
	Cqac6jdLrivU0RggTnzt/2fDI/HUPsA7mA==
X-Google-Smtp-Source: AGHT+IE9z/2trbzJEYTk8cMc17yi6ssF8/aPuc8yUTBATzUdEia7V+tXJLx5LsQKTS8TlCOHnaQhTGOVqI1NQw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:ad26:0:b0:56c:e9fe:3cb4 with SMTP id
 l38-20020a81ad26000000b0056ce9fe3cb4mr107776ywh.1.1695286343927; Thu, 21 Sep
 2023 01:52:23 -0700 (PDT)
Date: Thu, 21 Sep 2023 08:52:17 +0000
In-Reply-To: <20230921085218.954120-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921085218.954120-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921085218.954120-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/3] virtio_net: avoid data-races on dev->stats fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use DEV_STATS_INC() and DEV_STATS_READ() which provide
atomicity on paths that can be used concurrently.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index fe7f314d65c971fcad826fa0b3e44a956ef88940..1ed6bcc4cbb1b5836e2be7ae2909add95f3a231a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1258,7 +1258,7 @@ static struct sk_buff *receive_small(struct net_device *dev,
 	if (unlikely(len > GOOD_PACKET_LEN)) {
 		pr_debug("%s: rx error: len %u exceeds max size %d\n",
 			 dev->name, len, GOOD_PACKET_LEN);
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		goto err;
 	}
 
@@ -1323,7 +1323,7 @@ static void mergeable_buf_free(struct receive_queue *rq, int num_buf,
 		if (unlikely(!buf)) {
 			pr_debug("%s: rx error: %d buffers missing\n",
 				 dev->name, num_buf);
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			break;
 		}
 		stats->bytes += len;
@@ -1432,7 +1432,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			pr_debug("%s: rx error: %d buffers out of %d missing\n",
 				 dev->name, *num_buf,
 				 virtio16_to_cpu(vi->vdev, hdr->num_buffers));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
@@ -1451,7 +1451,7 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 			put_page(page);
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err;
 		}
 
@@ -1630,7 +1630,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	if (unlikely(len > truesize - room)) {
 		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 			 dev->name, len, (unsigned long)(truesize - room));
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		goto err_skb;
 	}
 
@@ -1662,7 +1662,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 				 dev->name, num_buf,
 				 virtio16_to_cpu(vi->vdev,
 						 hdr->num_buffers));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_buf;
 		}
 
@@ -1676,7 +1676,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		if (unlikely(len > truesize - room)) {
 			pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
 				 dev->name, len, (unsigned long)(truesize - room));
-			dev->stats.rx_length_errors++;
+			DEV_STATS_INC(dev, rx_length_errors);
 			goto err_skb;
 		}
 
@@ -1763,7 +1763,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
-		dev->stats.rx_length_errors++;
+		DEV_STATS_INC(dev, rx_length_errors);
 		virtnet_rq_free_unused_buf(rq->vq, buf);
 		return;
 	}
@@ -1803,7 +1803,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	return;
 
 frame_err:
-	dev->stats.rx_frame_errors++;
+	DEV_STATS_INC(dev, rx_frame_errors);
 	dev_kfree_skb(skb);
 }
 
@@ -2349,12 +2349,12 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 
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
@@ -2573,10 +2573,10 @@ static void virtnet_stats(struct net_device *dev,
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
2.42.0.459.ge4e396fd5e-goog


