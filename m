Return-Path: <netdev+bounces-35554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807457A9CC9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3512833ED
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B294044499;
	Thu, 21 Sep 2023 18:34:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED9E516E9
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:34:48 +0000 (UTC)
Received: from mail-oa1-x4a.google.com (mail-oa1-x4a.google.com [IPv6:2001:4860:4864:20::4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF33D4357
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:24:45 -0700 (PDT)
Received: by mail-oa1-x4a.google.com with SMTP id 586e51a60fabf-1c8c1f34aadso1827700fac.3
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320684; x=1695925484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kaqb66+WQ1T0RJN/T0hkDcgZGDRkYTPMFOHHNGqFBM=;
        b=Y8Q3BNKh8+XARimtgCI0ZR0N/RjCJDQAbD4DFy7Ak8WgcHuCKzMKA9ADbe0dfcIKmE
         UBtESjWcLJHpp4N0k7CCO3s7GA9pDdxLSTtB52oVQZsE4Nlu8sM//5SI5rhksNzakU/P
         VH0MBTx263KgNSh1CXiiWb7sShAZVDjUyg5nrxiKK/Uzfn2GIoFL/HLyuF5B2IuQieRU
         50WsxQcUtYJu4HQG8zYfrwEYbMiQ80KpsIZCiwZGuFxXGlGJQTQRnVGWz58SYKtgbGLZ
         +IAPB3rZVKeThYj/ljTLhJbtq/j/X3sMBNh/9OOomQdnYEKuSVwUnCujXP9GkBr9fn8c
         wiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320684; x=1695925484;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1kaqb66+WQ1T0RJN/T0hkDcgZGDRkYTPMFOHHNGqFBM=;
        b=exAJVDoo25e5lJQAJKHCOSCafRzgDOxJppA99IjAo+25Ssrw1EvXUFSYzAgdfQHnez
         I5mpJ/9Dd+veB9bmAUPlgk3u7TFAtz5//ceKfjHGAx4SQA5h8cuVypNsjQm4gYcxXscL
         meGcdv6joFPL64/cO5VmT+e5WvGh1UoGxRdpzzUky8PqMKEGgMvEZs2aSLqYfMhwd6c3
         ffNWXrJ1yuOcV5wGVY4D5+hPcpl+bauOlFGpNi7+Sqiu+oHyKNqY5XLf7p+yOaUb5SRD
         fZw3keB+FZdj3We/10fOsA+it+EP7GxePOMHR4j5cOpHAuHM6o/sP2pckX9T/PwMLMrY
         0w/A==
X-Gm-Message-State: AOJu0Yx+ykKVc9AVWeyFcBe0gVBDtphjwD34JY/vZ2wsxKhG9Pg/9iMK
	t6iGQm+4EnrMqPrTBgLF3XkiRoz6P67Q3g==
X-Google-Smtp-Source: AGHT+IG5MSUeDyf/uSUq7mgtkwv4BCAfpUS1sp55wHac+1IhZjto0UpwLhtmtDTt5XvR2Vb5QoaJ27IbCLEZrg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d085:0:b0:d84:2619:56df with SMTP id
 h127-20020a25d085000000b00d84261956dfmr78340ybg.13.1695286345824; Thu, 21 Sep
 2023 01:52:25 -0700 (PDT)
Date: Thu, 21 Sep 2023 08:52:18 +0000
In-Reply-To: <20230921085218.954120-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230921085218.954120-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921085218.954120-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] net: l2tp_eth: use generic dev->stats fields
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Core networking has opt-in atomic variant of dev->stats,
simply use DEV_STATS_INC(), DEV_STATS_ADD() and DEV_STATS_READ().

v2: removed @priv local var in l2tp_eth_dev_recv() (Simon)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>
---
 net/l2tp/l2tp_eth.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index f2ae03c404736d826fd7dc327b1567eac1c8651a..25ca89f804145a0ed9b407011bb3013a745e50f3 100644
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
@@ -126,7 +118,6 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 {
 	struct l2tp_eth_sess *spriv = l2tp_session_priv(session);
 	struct net_device *dev;
-	struct l2tp_eth *priv;
 
 	if (!pskb_may_pull(skb, ETH_HLEN))
 		goto error;
@@ -144,12 +135,11 @@ static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff *skb,
 	if (!dev)
 		goto error_rcu;
 
-	priv = netdev_priv(dev);
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
2.42.0.459.ge4e396fd5e-goog


