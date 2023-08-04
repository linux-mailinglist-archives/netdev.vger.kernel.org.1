Return-Path: <netdev+bounces-24516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CA0770708
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 19:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98772282721
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4B1AA87;
	Fri,  4 Aug 2023 17:26:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A722BE7C
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 17:26:58 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9797F49EF
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:26:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d064a458dd5so2367046276.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 10:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691170014; x=1691774814;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iU5gSuYskl09i6PGWA3IzggA+4h98Agc1JdGECIHvwE=;
        b=ClG2oQp23VI5Bjl3ZU67O9BMX2KXxUMTH0d7PGK++HJ2m+JCFgFtdA1rjdHMDfMnRX
         coLyAIFgho7onvn2xUNVl2JiIwUFyvZt2yfsyb9LyA9/kAL9dLX8MHzcBv14piB0JAn/
         5RbQk/Y9oi1qhOvu16O7p4CqNC0z31C91vFSdRmG239jrjA6BWR5h3vb0ImrNizIfuUT
         WC/YaA7QbBAm2gH3e/SepdXJyswgHLav37yTU3faqHlzZaqxchtKXvu+a6v2dsI4Fces
         Qc7rjxoEGqzZefm9UVLglqx04x9pjTsiFWtjOePY1Uyv8jHPlyZzhjuvwWFLPkqgg0fv
         +fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691170014; x=1691774814;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iU5gSuYskl09i6PGWA3IzggA+4h98Agc1JdGECIHvwE=;
        b=cuiVIqGOGvIV4zj+nzvXLHGzbJQ2yrVVV/R/UMZMHiliAX8PWB67cKiDVrczqsG3th
         amms75bQmvaEpWhD/k3jzhhwA9oyGW+iyP+OmHmWR6ZZCKLpJ9pgHeJg60i+qul6n01T
         47AsZxeQ9SD5xOP+UL8HrdnMPlpjflMK293vqGEdyn6z+hdM6MQ4W9NmxVm0k2yqZAvM
         eDQTWwmUyro/o5CokONEmSL7lWb7yZq/a12Nlo5ikJjfZSkFNuVb8eIoD1fsMH106ore
         Qu6DVeR8qtZFxZ5w/TZgr2OP45FgHaS6kwWOOHsun0a7vVpMcClIOaD//1YfYZQS0VJp
         J6vg==
X-Gm-Message-State: AOJu0YzEJ8ahAJ04m3v00HNNR4Q2Lolc2RwZf+5K1CKo2pny4iqoay31
	FJop5N9FMwPHqOwy7A3kgLatuwDumtWqAw==
X-Google-Smtp-Source: AGHT+IFgemE2A+pbZHoIjvOU156GPqJY6CI0cBYYQTWXt5R00tSh7B+NW5gleOe2e1kY4VBk6DSD28TggEfwwQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1588:b0:d3b:12d3:564e with SMTP
 id k8-20020a056902158800b00d3b12d3564emr13301ybu.2.1691170013788; Fri, 04 Aug
 2023 10:26:53 -0700 (PDT)
Date: Fri,  4 Aug 2023 17:26:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230804172652.1962-1-edumazet@google.com>
Subject: [PATCH net] macsec: use DEV_STATS_INC()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Soheil Hassas Yeganeh <soheil@google.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

syzbot/KCSAN reported data-races in macsec whenever dev->stats fields
are updated.

It appears all of these updates can happen from multiple cpus.

Adopt SMP safe DEV_STATS_INC() to update dev->stats fields.

Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
---
 drivers/net/macsec.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 984dfa5d6c11cb3ae6900597edeb1612f27decc3..144ec756c796a6962286b69cbabe223ad4984610 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -743,7 +743,7 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsLate++;
 		u64_stats_update_end(&rxsc_stats->syncp);
-		secy->netdev->stats.rx_dropped++;
+		DEV_STATS_INC(secy->netdev, rx_dropped);
 		return false;
 	}
 
@@ -767,7 +767,7 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 			rxsc_stats->stats.InPktsNotValid++;
 			u64_stats_update_end(&rxsc_stats->syncp);
 			this_cpu_inc(rx_sa->stats->InPktsNotValid);
-			secy->netdev->stats.rx_errors++;
+			DEV_STATS_INC(secy->netdev, rx_errors);
 			return false;
 		}
 
@@ -1069,7 +1069,7 @@ static enum rx_handler_result handle_not_macsec(struct sk_buff *skb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoTag++;
 			u64_stats_update_end(&secy_stats->syncp);
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			continue;
 		}
 
@@ -1179,7 +1179,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&secy_stats->syncp);
 		secy_stats->stats.InPktsBadTag++;
 		u64_stats_update_end(&secy_stats->syncp);
-		secy->netdev->stats.rx_errors++;
+		DEV_STATS_INC(secy->netdev, rx_errors);
 		goto drop_nosa;
 	}
 
@@ -1196,7 +1196,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
-			secy->netdev->stats.rx_errors++;
+			DEV_STATS_INC(secy->netdev, rx_errors);
 			if (active_rx_sa)
 				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
@@ -1230,7 +1230,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsLate++;
 			u64_stats_update_end(&rxsc_stats->syncp);
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			goto drop;
 		}
 	}
@@ -1271,7 +1271,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	if (ret == NET_RX_SUCCESS)
 		count_rx(dev, len);
 	else
-		macsec->secy.netdev->stats.rx_dropped++;
+		DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 
 	rcu_read_unlock();
 
@@ -1308,7 +1308,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
-			macsec->secy.netdev->stats.rx_errors++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_errors);
 			continue;
 		}
 
@@ -1327,7 +1327,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			secy_stats->stats.InPktsUnknownSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
 		} else {
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 		}
 	}
 
@@ -3422,7 +3422,7 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 
 	if (!secy->operational) {
 		kfree_skb(skb);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
@@ -3430,7 +3430,7 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 	skb = macsec_encrypt(skb, dev);
 	if (IS_ERR(skb)) {
 		if (PTR_ERR(skb) != -EINPROGRESS)
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
@@ -3667,9 +3667,9 @@ static void macsec_get_stats64(struct net_device *dev,
 
 	dev_fetch_sw_netstats(s, dev->tstats);
 
-	s->rx_dropped = dev->stats.rx_dropped;
-	s->tx_dropped = dev->stats.tx_dropped;
-	s->rx_errors = dev->stats.rx_errors;
+	s->rx_dropped = atomic_long_read(&dev->stats.__rx_dropped);
+	s->tx_dropped = atomic_long_read(&dev->stats.__tx_dropped);
+	s->rx_errors = atomic_long_read(&dev->stats.__rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
-- 
2.41.0.640.ga95def55d0-goog


