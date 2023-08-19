Return-Path: <netdev+bounces-29050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBA1781766
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 06:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12021C20BA8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF3A1858;
	Sat, 19 Aug 2023 04:41:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732851C3A
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 04:41:09 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B793A8D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fbfcb8d90so152217b3.1
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692420067; x=1693024867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ET2lSiBST0i4cjsbmnEL0JJvkPhDEBJ5nZ7MevLc9ak=;
        b=nhHeqzeE2oUZSc2DjLKHEgYSuWAM6GERuMyBopg7wslXedCG3Uv8pgWsGwlBHOy4ew
         Am9JhgM/5rGUL0nW/J/72lAw9rkebCfBcV1WscXvGBohx8UXNRlPr0IyOqcO/8aGvTNH
         mBJFC8IIXwzBNndOc3T/SFLHYQcwio9B0E0pA/M/HiwesjNFlQVONURGU74tl/sFAMDR
         p6MNWDqPScGWb/fbedR+VOdAICRwbohCaiaTy34sJM1bd5hn1C7LH/Ig2a0qiL18rwqy
         tbTbhjDyR3IRYnTUGdLtYdKiVB1GT9USDLblZwyr8xjNrKW++WiJdWgB/FokUnMXu+J+
         E8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692420067; x=1693024867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ET2lSiBST0i4cjsbmnEL0JJvkPhDEBJ5nZ7MevLc9ak=;
        b=WDWwY3pcJjFp/8DMsetPZfJaJ5qmCOX95q3x+pzNLRkdt2wArV6it6EqE3bY10ToZ/
         n/7esYVNUZcbVmD/YjBqfmgChtDiVn6O607J4AO4Rrn4ho0I1zKqM9dausuQTyU/dKl3
         L1/FCZ589bxuSCXDPOxUY4YpPwSj7F4UMBlaMBzDfvy01nEjVdkRBsL7OZK8QPU7rA1Q
         f5srsfUoUgrO+VSL9DcsQbPgs4lptOVvif/1uaU9Gbs2/KoRQa1NSHbPdLYuzBdXD9xH
         16ZQq6bLlcqxlVXI8tiejNmiHP74iafQx5WSyEHR+M6DHIyxEc6+xDSh0oWgywEEjbkr
         QcdA==
X-Gm-Message-State: AOJu0YxeYlLAxxC+00cAzY0yvQBYXTfzj1VgyGsk4zUO4wra/pSY7gJ4
	9F0dkqKkiIy6NVXWgA+/kymnG2GJf54gBg==
X-Google-Smtp-Source: AGHT+IGjCmI70mt4EGbGigYAb9zWc4UdOCNGQKVtaZBHiRG/Fk51c9A5mZrD5gzB8zTgAPHnD8phYedYqROA9A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:a845:0:b0:58c:b5a4:8e1f with SMTP id
 f66-20020a81a845000000b0058cb5a48e1fmr12629ywh.3.1692420067024; Fri, 18 Aug
 2023 21:41:07 -0700 (PDT)
Date: Sat, 19 Aug 2023 04:40:59 +0000
In-Reply-To: <20230819044059.833749-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230819044059.833749-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819044059.833749-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] net: l2tp_eth: use generic dev->stats fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Core networking has opt-in atomic variant of dev->stats,
simply use DEV_STATS_INC(), DEV_STATS_ADD() and DEV_STATS_READ().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/l2tp/l2tp_eth.c | 32 ++++++++++++--------------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index f2ae03c404736d826fd7dc327b1567eac1c8651a..897f6d0283d839ee210df8c31e1b9e60bc3ff6e6 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -37,12 +37,6 @@
 /* via netdev_priv() */
 struct l2tp_eth {
 	struct l2tp_session	*session;
-	atomic_long_t		tx_bytes;
-	atomic_long_t		tx_packets;
-	atomic_long_t		tx_dropped;
-	atomic_long_t		rx_bytes;
-	atomic_long_t		rx_packets;
-	atomic_long_t		rx_errors;
 };
 
 /* via l2tp_session_priv() */
@@ -79,10 +73,10 @@ static netdev_tx_t l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev
 	int ret = l2tp_xmit_skb(session, skb);
 
 	if (likely(ret == NET_XMIT_SUCCESS)) {
-		atomic_long_add(len, &priv->tx_bytes);
-		atomic_long_inc(&priv->tx_packets);
+		DEV_STATS_ADD(dev, tx_bytes, len);
+		DEV_STATS_INC(dev, tx_packets);
 	} else {
-		atomic_long_inc(&priv->tx_dropped);
+		DEV_STATS_INC(dev, tx_dropped);
 	}
 	return NETDEV_TX_OK;
 }
@@ -90,14 +84,12 @@ static netdev_tx_t l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev
 static void l2tp_eth_get_stats64(struct net_device *dev,
 				 struct rtnl_link_stats64 *stats)
 {
-	struct l2tp_eth *priv = netdev_priv(dev);
-
-	stats->tx_bytes   = (unsigned long)atomic_long_read(&priv->tx_bytes);
-	stats->tx_packets = (unsigned long)atomic_long_read(&priv->tx_packets);
-	stats->tx_dropped = (unsigned long)atomic_long_read(&priv->tx_dropped);
-	stats->rx_bytes   = (unsigned long)atomic_long_read(&priv->rx_bytes);
-	stats->rx_packets = (unsigned long)atomic_long_read(&priv->rx_packets);
-	stats->rx_errors  = (unsigned long)atomic_long_read(&priv->rx_errors);
+	stats->tx_bytes   = DEV_STATS_READ(dev, tx_bytes);
+	stats->tx_packets = DEV_STATS_READ(dev, tx_packets);
+	stats->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	stats->rx_bytes   = DEV_STATS_READ(dev, rx_bytes);
+	stats->rx_packets = DEV_STATS_READ(dev, rx_packets);
+	stats->rx_errors  = DEV_STATS_READ(dev, rx_errors);
 }
 
 static const struct net_device_ops l2tp_eth_netdev_ops = {
@@ -146,10 +138,10 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 
 	priv = netdev_priv(dev);
 	if (dev_forward_skb(dev, skb) == NET_RX_SUCCESS) {
-		atomic_long_inc(&priv->rx_packets);
-		atomic_long_add(data_len, &priv->rx_bytes);
+		DEV_STATS_INC(dev, rx_packets);
+		DEV_STATS_ADD(dev, rx_bytes, data_len);
 	} else {
-		atomic_long_inc(&priv->rx_errors);
+		DEV_STATS_INC(dev, rx_errors);
 	}
 	rcu_read_unlock();
 
-- 
2.42.0.rc1.204.g551eb34607-goog


