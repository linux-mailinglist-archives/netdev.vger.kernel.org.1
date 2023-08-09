Return-Path: <netdev+bounces-25903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351687761FB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1547281C0D
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B819BAC;
	Wed,  9 Aug 2023 14:03:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7CE198B6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 14:03:03 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0757C9F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 07:03:02 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68706d67ed9so4895679b3a.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691589781; x=1692194581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUyV0IQHJEvr40k2Rwcgkm93zaIwGC9loopJJhh7UqI=;
        b=Wz+7joloyYO6Lw10Ia7K4c/M4KDyPgggc8E4K4ETfHouaevawkZUnA/8thu90SItz8
         qH8wKMNutCKUi7b4d0+bXxd8scoCYOhpkpWS3TUAHT1N2HGPOqZa8oPJJMQ3E+auMcdp
         v54brqU9OK4v2LBR8lZHfP3q3bg5z5DNrPjXa2ajgLHb8YAUC5kLmFfjGr4Bfeeyp6sg
         +t5HrL9VpOF4baGiACE4wE3A1FOjsAmxogliZBUrGP+dsGrCHiwovxelkPzlwyGCIHYm
         ApBXd+e7Q4+HscuOL/HNNujb4FaZ0laakRfWnbHlv8KnymKcVG43AkyNwHl+bHGpMLux
         uL4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691589781; x=1692194581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUyV0IQHJEvr40k2Rwcgkm93zaIwGC9loopJJhh7UqI=;
        b=iWFHjzO+4aQg7LdKmoz5AMuqAT+G6Wa8mcrJuSUFVFTzLGGUSc8zsDJOAiT/VUHiPn
         OKxU2W0uqZbNIU/W75+2erOHeH3qpXRH5TkG0njlX4wJfoIUygZMVdf/qRImujHpbTK+
         EKTN8svFdja4CrqW2MgmouhRvWjCjLsoDFaoWNOMc0ljlvCoSGZpvThe1fXv0TN1gB7Y
         dAdFOwiGskRih3zGgu2Kr4AyvitE4aFXi2QwkfkXXzdD62kg2ebH0GyFG2z/tTqk7l++
         lbbBxtepL8ZdUqWFWtYEWMHZOy1JHAAHx7odJxmcakZuh2YwRvS8A0cdQ+tgh7gmR+Ye
         74Gg==
X-Gm-Message-State: AOJu0YxQ7T5TkD0mwgkjpgB49MrKKKdoaVYnJnKF1eLr6oetuWAJa87w
	h8FoBj8ntMTwfUEp/2VYXfD76RMXrZ2e7A==
X-Google-Smtp-Source: AGHT+IEhNg/IdhrH23CFqR76ZE6YsNlgpAd4OquSilzZaMBj1s9K+y6Hp4t/jnD3sUhY3duezaehVw==
X-Received: by 2002:a05:6a00:2402:b0:687:4dd1:92f8 with SMTP id z2-20020a056a00240200b006874dd192f8mr2450147pfh.10.1691589780726;
        Wed, 09 Aug 2023 07:03:00 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id q25-20020a62ae19000000b0064aea45b040sm9935674pff.168.2023.08.09.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:03:00 -0700 (PDT)
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
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv2 net-next 2/2] ipv4/fib: send notify when delete source address routes
Date: Wed,  9 Aug 2023 22:02:34 +0800
Message-Id: <20230809140234.3879929-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230809140234.3879929-1-liuhangbin@gmail.com>
References: <20230809140234.3879929-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

After deleting an interface address in fib_del_ifaddr(), the function
scans the fib_info list for stray entries and calls fib_flush() and
fib_table_flush(). Then the stray entries will be deleted silently and no
RTM_DELROUTE notification will be sent.

This lack of notification can make routing daemons like NetworkManager,
miss the routing changes. e.g.

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
v2: Add a bit in fib_info to mark the deleted src route.
---
 include/net/ip_fib.h     | 3 ++-
 net/ipv4/fib_semantics.c | 1 +
 net/ipv4/fib_trie.c      | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index a91f8a28689a..12dedfa4c9fd 100644
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
index ce1c10e408cf..6cd919b442a7 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1884,6 +1884,7 @@ int fib_sync_down_addr(struct net_device *dev, __be32 local)
 			continue;
 		if (fi->fib_prefsrc == local) {
 			fi->fib_flags |= RTNH_F_DEAD;
+			fi->pfsrc_removed = 1;
 			ret++;
 		}
 	}
diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 74d403dbd2b4..9cadeeaaa93a 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2026,6 +2026,7 @@ void fib_table_flush_external(struct fib_table *tb)
 int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 {
 	struct trie *t = (struct trie *)tb->tb_data;
+	struct nl_info info = { .nl_net = net };
 	struct key_vector *pn = t->kv;
 	unsigned long cindex = 1;
 	struct hlist_node *tmp;
@@ -2088,6 +2089,9 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 
 			fib_notify_alias_delete(net, n->key, &n->leaf, fa,
 						NULL);
+			if (fi->pfsrc_removed)
+				rtmsg_fib(RTM_DELROUTE, htonl(n->key), fa,
+					  KEYLENGTH - fa->fa_slen, tb->tb_id, &info, 0);
 			hlist_del_rcu(&fa->fa_list);
 			fib_release_info(fa->fa_info);
 			alias_free_mem_rcu(fa);
-- 
2.38.1


