Return-Path: <netdev+bounces-35368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C627A912D
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 05:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50511C20843
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C521843;
	Thu, 21 Sep 2023 03:14:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75A20FE
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 03:14:34 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA0DED
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:14:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690b7cb71aeso291461b3a.0
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695266071; x=1695870871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyRu9ZFQ6bf2X/vqxHPZ5XhAAvrYOzQr3LtH33jTLEI=;
        b=dU9P+aG48VIaj2BFfkRlwvhbiUTBpl2ZM8uQoMqOXbj/hF3CxQJQRGl4LXTXhsY5Yr
         +d7TCeMukGlq7RVOxRMsXY0X3C4Y6BUIt/IZBVgZgGFWRidjDDY8wfcE3Bo3RAMgVDnQ
         uMrRuFZrr6QADyGsqF+9Wfbo+siTsTNuQpHE1xc4vYeGn5dJFl0EQiRNSaUY2FnSooKw
         +gSAjVvEAwhiz8DEYaQGocxFKo/NBRMik0pe3KnCi4nFXS3noJNL03TkOiAzU2WSHMsr
         uD7hWom6xBVXpFdDaxF12GblHKGRD+1eXEZbHlwzRMQAW1HM0rTZXrJ1orCBY66Pyzxl
         hO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695266071; x=1695870871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyRu9ZFQ6bf2X/vqxHPZ5XhAAvrYOzQr3LtH33jTLEI=;
        b=L0Jv6xjzDogFpPIoBSh1BuzierLUz2M1PM44h02fzKlr2hO4k9PmLAm5dW8I1LVHNZ
         RnwjxXS9JHEG7JuQNzJY14zSu6jkWKRev638WKmZ123jxTzvOxRgVbYYni4hGnJxafdP
         XKW/j9IR9DO/DTP88k9TyJIu0k4wFPUFcWv3+5nUp81phxga8ykkCe7p8+tKgCR1dlzl
         fNn34FfVZ0DiBXU0iL+sMCKadqsP8i/IJ3LjO5MK6ny1nhjwxOcCzeeg0VJ9qAjJuWus
         R87ZXXzrCilF3LBDg91LOzR3tobUY4BP7Vr7Vxs6aVOeWR/niyN3aIQzKEVPpmBsV2Pg
         ngMA==
X-Gm-Message-State: AOJu0Yy7DRwHg7aFhCMKb4AnZu0egCcxoUjk1rJANtR8moBjU2DcUshV
	fd35iyub8bGbkKgf7NXxTZOLz9bDJ01hR66v
X-Google-Smtp-Source: AGHT+IEvO7dJxaBqfT/4NYhSea9qvtXK62Z6RIHCfPLQlcWWHJkx7oeJqDSHbmzBq8TInZbBFMzIuw==
X-Received: by 2002:a05:6a00:16d0:b0:690:fd48:1aa4 with SMTP id l16-20020a056a0016d000b00690fd481aa4mr3595826pfc.0.1695266071049;
        Wed, 20 Sep 2023 20:14:31 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg2-20020a056a001f8200b0068fe76cdc62sm236032pfb.93.2023.09.20.20.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 20:14:29 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Thomas Haller <thaller@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Eric Dumazet <edumazet@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/2] ipv4/fib: send notify when delete source address routes
Date: Thu, 21 Sep 2023 11:14:09 +0800
Message-ID: <20230921031409.514488-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230921031409.514488-1-liuhangbin@gmail.com>
References: <20230921031409.514488-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an interface address in fib_del_ifaddr(), the function
scans the fib_info list for stray entries and calls fib_flush() and
fib_table_flush(). Then the stray entries will be deleted silently and no
RTM_DELROUTE notification will be sent.

This lack of notification can make routing daemons, or monitor like
`ip monitor route` miss the routing changes. e.g.

+ ip link add dummy1 type dummy
+ ip link add dummy2 type dummy
+ ip link set dummy1 up
+ ip link set dummy2 up
+ ip addr add 192.168.5.5/24 dev dummy1
+ ip route add 7.7.7.0/24 dev dummy2 src 192.168.5.5
+ ip -4 route
7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5

As Ido reminded, fib_table_flush() isn't only called when an address is
deleted, but also when an interface is deleted or put down. The lack of
notification in these cases is deliberate. And commit 7c6bb7d2faaf
("net/ipv6: Add knob to skip DELROUTE message on device down") introduced
a sysctl to make IPv6 behave like IPv4 in this regard. So we can't send
the route delete notify blindly in fib_table_flush().

To fix this issue, let's add a new bit in "struct fib_info" to track the
deleted prefer source address routes, and only send notify for them.

After update:
+ ip monitor route
+ ip addr del 192.168.5.5/24 dev dummy1
Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
Deleted 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5

Suggested-by: Thomas Haller <thaller@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
v3: update patch description
v2: Add a bit in fib_info to mark the deleted src route.
---
 include/net/ip_fib.h     | 3 ++-
 net/ipv4/fib_semantics.c | 1 +
 net/ipv4/fib_trie.c      | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 6d05469cf5da..d7fc03c1d115 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -153,7 +153,8 @@ struct fib_info {
 #define fib_advmss fib_metrics->metrics[RTAX_ADVMSS-1]
 	int			fib_nhs;
 	u8			fib_nh_is_v6:1,
-				nh_updated:1;
+				nh_updated:1,
+				pfsrc_removed:1;
 	struct nexthop		*nh;
 	struct rcu_head		rcu;
 	struct fib_nh		fib_nh[];
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index b2858b0a1229..ced474d5584d 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1887,6 +1887,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 			continue;
 		if (fi->fib_prefsrc == local) {
 			fi->fib_flags |= RTNH_F_DEAD;
+			fi->pfsrc_removed = 1;
 			ret++;
 		}
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index d13fb9e76b97..9bdfdab906fe 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2027,6 +2027,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	struct nl_info info = { .nl_net = net };
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -2089,6 +2090,9 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 
 			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
 						NULL);
+			if (fi->pfsrc_removed)
+				rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+					  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
 			hlist_del_rcu(&fa->fa_list);
 			fib_release_info(fa->fa_info);
 			alias_free_mem_rcu(fa);
-- 
2.41.0


