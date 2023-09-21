Return-Path: <netdev+bounces-35559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C197A9C99
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539401C21462
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE54B691F9;
	Thu, 21 Sep 2023 18:35:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EED68C35
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:35:06 +0000 (UTC)
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAEECE15F
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:19:42 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id af79cd13be357-77410b85b63so64833685a.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320381; x=1695925181; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SDpmP4ph1EwxT+bKgliqcRTZW1LJ9TwBv/0ldt7rr+I=;
        b=bKhHy7aSiK2s555gIJULiRdtz0KqIRToJeoHkWgSj9DQqBpTdfI1wTVL8AfkrNHK8l
         73j3iw7yfBaXbIXqB+khDcuR+mWROeTt8pcSIl2bOSHqsoOjPZVraXQLOOw5geVsm2ez
         dw6XnfS4PlAM/GwGKPfXR7T+eA1OQ4yeTFZPnwQNvrse7+BV9RmnccsklXBhmlX970UT
         CtVt/cfM2PnfoUxVRWXnqVhiArO0drT6M4hTrN+QPBy2+NOlqmQy4GUz0W7Rw5/QHG1E
         A8e20bYNDvRaXj5V0xOMmYllhA7bofpvHfexnnicFTiWxQtTkEkADv3hYJH/+bONiM7U
         9DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320381; x=1695925181;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDpmP4ph1EwxT+bKgliqcRTZW1LJ9TwBv/0ldt7rr+I=;
        b=B1D6+svubDZULl/RRwaeVzBGjYFTWrfbxehFYuk3CCITkQH2TqV1iaBrX3rCUbyUsU
         65A3lD8MQbefkX8tQrGX/82/w/2bYPYorJ9fB44EysHQHPoUyQx0dWvF5YOjIuZnybk0
         s5auvZ7dqoDSqBP/av72Wixhn55j7uPgHRSn/mJrQZf+pL6mVgq25af0i+N1Ub2LYvDp
         mFE7kZ6r+ZZah5vZoMLiYgAR5WL7fR35Yglr7nG9sHoawphMEgCMP6h/M8RTbiB6dWzs
         J+BTBViOAvtnj+EBztdXyNNVUdsXbDETB8GJiD+UsW7mkxvvFEUzHS3wwicfASTcf0mU
         faDg==
X-Gm-Message-State: AOJu0YzQ9exsMH2W34uoN1M1DoP9NMiUEg/OWly2KyBZvwNkAKSAQZ1v
	EUUsmJJBPERloLXsUjvzuyHeSNQnP5F6WA==
X-Google-Smtp-Source: AGHT+IEcvkNxBhZDSGL2TZBNUwNGVj1AS0YurM+rGrL1gGvDrB8Q1mixI6HrBUFjfRB5kfRWmCeN5TBZx9wyRQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ae66:0:b0:d7e:79c3:cd0b with SMTP id
 g38-20020a25ae66000000b00d7e79c3cd0bmr65790ybe.3.1695288434961; Thu, 21 Sep
 2023 02:27:14 -0700 (PDT)
Date: Thu, 21 Sep 2023 09:27:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921092713.1488792-1-edumazet@google.com>
Subject: [PATCH net] neighbour: fix data-races around n->output
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

n->output field can be read locklessly, while a writer
might change the pointer concurrently.

Add missing annotations to prevent load-store tearing.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/neighbour.h         |  2 +-
 net/bridge/br_netfilter_hooks.c |  2 +-
 net/core/neighbour.c            | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 6da68886fabbcb33a63ef256242d51a618571c95..07022bb0d44d4b5eef5812cc86e042833cf3a337 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -539,7 +539,7 @@ static inline int neigh_output(struct neighbour *n, struct sk_buff *skb,
 	    READ_ONCE(hh->hh_len))
 		return neigh_hh_output(hh, skb);
 
-	return n->output(n, skb);
+	return READ_ONCE(n->output)(n, skb);
 }
 
 static inline struct neighbour *
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 15186247b59af52062907cacec994e736ddbc01b..033034d68f1f057349acdd2f127c427195be6b62 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -294,7 +294,7 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 			/* tell br_dev_xmit to continue with forwarding */
 			nf_bridge->bridged_dnat = 1;
 			/* FIXME Need to refragment */
-			ret = neigh->output(neigh, skb);
+			ret = READ_ONCE(neigh->output)(neigh, skb);
 		}
 		neigh_release(neigh);
 		return ret;
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 7212c7e521ef6388f450f3882077e26088bb3644..9c09f091cbffe59043ce4614423d7dce7d4ec42a 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -410,7 +410,7 @@ static void neigh_flush_dev(struct neigh_table *tbl, struct net_device *dev,
 				 */
 				__skb_queue_purge(&n->arp_queue);
 				n->arp_queue_len_bytes = 0;
-				n->output = neigh_blackhole;
+				WRITE_ONCE(n->output, neigh_blackhole);
 				if (n->nud_state & NUD_VALID)
 					n->nud_state = NUD_NOARP;
 				else
@@ -920,7 +920,7 @@ static void neigh_suspect(struct neighbour *neigh)
 {
 	neigh_dbg(2, "neigh %p is suspected\n", neigh);
 
-	neigh->output = neigh->ops->output;
+	WRITE_ONCE(neigh->output, neigh->ops->output);
 }
 
 /* Neighbour state is OK;
@@ -932,7 +932,7 @@ static void neigh_connect(struct neighbour *neigh)
 {
 	neigh_dbg(2, "neigh %p is connected\n", neigh);
 
-	neigh->output = neigh->ops->connected_output;
+	WRITE_ONCE(neigh->output, neigh->ops->connected_output);
 }
 
 static void neigh_periodic_work(struct work_struct *work)
@@ -1449,7 +1449,7 @@ static int __neigh_update(struct neighbour *neigh, const u8 *lladdr,
 				if (n2)
 					n1 = n2;
 			}
-			n1->output(n1, skb);
+			READ_ONCE(n1->output)(n1, skb);
 			if (n2)
 				neigh_release(n2);
 			rcu_read_unlock();
@@ -3155,7 +3155,7 @@ int neigh_xmit(int index, struct net_device *dev,
 			rcu_read_unlock();
 			goto out_kfree_skb;
 		}
-		err = neigh->output(neigh, skb);
+		err = READ_ONCE(neigh->output)(neigh, skb);
 		rcu_read_unlock();
 	}
 	else if (index == NEIGH_LINK_TABLE) {
-- 
2.42.0.459.ge4e396fd5e-goog


