Return-Path: <netdev+bounces-16597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D5874DF65
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64829281391
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462C713AD8;
	Mon, 10 Jul 2023 20:36:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F10E6FA9
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:36:15 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEEF195
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:36:14 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-579dfae6855so61903867b3.1
        for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689021373; x=1691613373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N8ztVDcyJmOHlzAxJNlJFwjk86y60iqpqyKg27i3OGU=;
        b=IDnh+N8cbam28LKjjB+QunFpkyfbgJZqYVs4IATTvLhalNBQOzf801sIuHJBSzyMjz
         iQ8ZHms3XCjIuB9C89ZbAJN7BEflpr4Y/FiUTgblSZP9NARTiUmDeofRndEF6X7DDih8
         6B09Me4aXmn2rXgQAHMxXu5ESlv+3KKpd6ZYM5l6CMmBInoWRdhevLO2vRUMa3UxlikM
         nNdKA+9NBbaKCfHkom/a1ivQS9LqvwltyBPDyxAApuFUDdG00p6wEu0TSV4JrmLTjBvX
         nYRA7Sq0CIwlJWg+98QmU5GTfokwJ+swutNvsVwB3FWGMWYM+2ofTBXsdj5O+E60Gys+
         v/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689021373; x=1691613373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N8ztVDcyJmOHlzAxJNlJFwjk86y60iqpqyKg27i3OGU=;
        b=YjkDHnJ1axj+ScBp/mhD6itYhpKXeUypC5JJC4XMVqEuyUWBCmRw5wbkyhSIshUaSE
         y7O3nZChwyEIfHWmmoLVtlIDx4ma1fjCouaZgP2T6ip/VFPIg37crybjuWoVo2NujgTE
         dZyWn4LYih7m8ZJwmTI87jboGOCoKULVG4ahktsGtmcHdjUnl5LhEhyZDiNfMpKkGbG1
         lyrjofgvKKVjY1sXbNXijkvSIegtna4zOyVnZCZj3fIO8bZRLq0jCqKsUIcDFdPB14kJ
         uaQntP7Bqb3ROPuvoKcqVuweO//bdA0wOezRST+I/tnt7fLCkh0ZgXBdV2ba4CbdJ2xB
         ZHDg==
X-Gm-Message-State: ABy/qLYcegzjZiGK2d4vAjUgmk7ozZw30/vGzFpMN5BaAS4+tYzmdSsM
	/IuSZbJUg64hoUV8zIuxDbA=
X-Google-Smtp-Source: APBJJlEN60/LqKB/oGUKIbjxX4Wf/X2oL8sSGJmEfUSLyo89IjTaniOeCDBiIL2Rk2lHwFsFcIxzNg==
X-Received: by 2002:a81:5f83:0:b0:576:b52d:4946 with SMTP id t125-20020a815f83000000b00576b52d4946mr14210014ywb.30.1689021373117;
        Mon, 10 Jul 2023 13:36:13 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:c11f:9814:297e:2db9])
        by smtp.gmail.com with ESMTPSA id r186-20020a0dcfc3000000b0057a165e6ee1sm175429ywd.35.2023.07.10.13.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:36:12 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH net] net/ipv6: Remove expired routes with a separated list of routes.
Date: Mon, 10 Jul 2023 13:36:09 -0700
Message-Id: <20230710203609.520720-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
can be expensive if the number of routes in a table is big, even if most of
them are permanent. Checking routes in a separated list of routes having
expiration will avoid this potential issue.

Background
==========

The size of a Linux IPv6 routing table can become a big problem if not
managed appropriately.  Now, Linux has a garbage collector to remove
expired routes periodically.  However, this may lead to a situation in
which the routing path is blocked for a long period due to an
excessive number of routes.

For example, years ago, there is a commit about "ICMPv6 Packet too big
messages". The root cause is that malicious ICMPv6 packets were sent back
for every small packet sent to them. These packets add routes with an
expiration time that prompts the GC to periodically check all routes in the
tables, including permanent ones.

Why Route Expires
=================

Users can add IPv6 routes with an expiration time manually. However,
the Neighbor Discovery protocol may also generate routes that can
expire.  For example, Router Advertisement (RA) messages may create a
default route with an expiration time. [RFC 4861] For IPv4, it is not
possible to set an expiration time for a route, and there is no RA, so
there is no need to worry about such issues.

Create Routes with Expires
==========================

You can create routes with expires with the  command.

For example,

    ip -6 route add 2001:b000:591::3 via fe80::5054:ff:fe12:3457 \
        dev enp0s3 expires 30

The route that has been generated will be deleted automatically in 30
seconds.

GC of FIB6
==========

The function called fib6_run_gc() is responsible for performing
garbage collection (GC) for the Linux IPv6 stack. It checks for the
expiration of every route by traversing the trees of routing
tables. The time taken to traverse a routing table increases with its
size. Holding the routing table lock during traversal is particularly
undesirable. Therefore, it is preferable to keep the lock for the
shortest possible duration.

Solution
========

The cause of the issue is keeping the routing table locked during the
traversal of large trees. To solve this problem, we can create a separate
list of routes that have expiration. This will prevent GC from checking
permanent routes.

Result
======

We conducted a test to measure the execution times of fib6_gc_timer_cb()
and observed that it enhances the GC of FIB6. During the test, we added
permanent routes with the following numbers: 1000, 3000, 6000, and
9000. Additionally, we added a route with an expiration time.

Here are the average execution times for the kernel without the patch.
 - 120020 ns with 1000 permanent routes
 - 308920 ns with 3000 ...
 - 581470 ns with 6000 ...
 - 855310 ns with 9000 ...

The kernel with the patch consistently takes around 14000 ns to execute,
regardless of the number of permanent routes that are installed.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/net/ip6_fib.h |  31 ++++++++-----
 net/ipv6/ip6_fib.c    | 104 ++++++++++++++++++++++++++++++++++++++++--
 net/ipv6/route.c      |   6 +--
 3 files changed, 123 insertions(+), 18 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 05e6f756feaf..fb4d8bf4b938 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -177,6 +177,8 @@ struct fib6_info {
 	};
 	unsigned int			fib6_nsiblings;
 
+	struct hlist_node		gc_link;
+
 	refcount_t			fib6_ref;
 	unsigned long			expires;
 	struct dst_metrics		*fib6_metrics;
@@ -247,18 +249,19 @@ static inline bool fib6_requires_src(const struct fib6_info *rt)
 	return rt->fib6_src.plen > 0;
 }
 
-static inline void fib6_clean_expires(struct fib6_info *f6i)
-{
-	f6i->fib6_flags &= ~RTF_EXPIRES;
-	f6i->expires = 0;
-}
+void fib6_clean_expires(struct fib6_info *f6i);
+/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
+ * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
+ * list of GC candidates until it is inserted into a table.
+ */
+void fib6_clean_expires_locked(struct fib6_info *f6i);
 
-static inline void fib6_set_expires(struct fib6_info *f6i,
-				    unsigned long expires)
-{
-	f6i->expires = expires;
-	f6i->fib6_flags |= RTF_EXPIRES;
-}
+void fib6_set_expires(struct fib6_info *f6i, unsigned long expires);
+/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
+ * NULL.
+ */
+void fib6_set_expires_locked(struct fib6_info *f6i,
+			     unsigned long expires);
 
 static inline bool fib6_check_expired(const struct fib6_info *f6i)
 {
@@ -267,6 +270,11 @@ static inline bool fib6_check_expired(const struct fib6_info *f6i)
 	return false;
 }
 
+static inline bool fib6_has_expires(const struct fib6_info *f6i)
+{
+	return f6i->fib6_flags & RTF_EXPIRES;
+}
+
 /* Function to safely get fn->fn_sernum for passed in rt
  * and store result in passed in cookie.
  * Return true if we can get cookie safely
@@ -388,6 +396,7 @@ struct fib6_table {
 	struct inet_peer_base	tb6_peers;
 	unsigned int		flags;
 	unsigned int		fib_seq;
+	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
 #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
 };
 
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index bac768d36cc1..32292a758722 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -160,6 +160,8 @@ struct fib6_info *fib6_info_alloc(gfp_t gfp_flags, bool with_fib6_nh)
 	INIT_LIST_HEAD(&f6i->fib6_siblings);
 	refcount_set(&f6i->fib6_ref, 1);
 
+	INIT_HLIST_NODE(&f6i->gc_link);
+
 	return f6i;
 }
 
@@ -246,6 +248,7 @@ static struct fib6_table *fib6_alloc_table(struct net *net, u32 id)
 				   net->ipv6.fib6_null_entry);
 		table->tb6_root.fn_flags = RTN_ROOT | RTN_TL_ROOT | RTN_RTINFO;
 		inet_peer_base_init(&table->tb6_peers);
+		INIT_HLIST_HEAD(&table->tb6_gc_hlist);
 	}
 
 	return table;
@@ -1057,6 +1060,11 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 				    lockdep_is_held(&table->tb6_lock));
 		}
 	}
+
+	if (fib6_has_expires(rt)) {
+		hlist_del_init(&rt->gc_link);
+		rt->fib6_flags &= ~RTF_EXPIRES;
+	}
 }
 
 /*
@@ -1118,9 +1126,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
 				if (!(iter->fib6_flags & RTF_EXPIRES))
 					return -EEXIST;
 				if (!(rt->fib6_flags & RTF_EXPIRES))
-					fib6_clean_expires(iter);
+					fib6_clean_expires_locked(iter);
 				else
-					fib6_set_expires(iter, rt->expires);
+					fib6_set_expires_locked(iter, rt->expires);
 
 				if (rt->fib6_pmtu)
 					fib6_metric_set(iter, RTAX_MTU,
@@ -1480,6 +1488,9 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
 		fib6_start_gc(info->nl_net, rt);
+
+		if (fib6_has_expires(rt))
+			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
 	}
 
 out:
@@ -2267,6 +2278,91 @@ void fib6_clean_all(struct net *net, int (*func)(struct fib6_info *, void *),
 	__fib6_clean_all(net, func, FIB6_NO_SERNUM_CHANGE, arg, false);
 }
 
+void fib6_set_expires(struct fib6_info *f6i, unsigned long expires)
+{
+	struct fib6_table *tb6;
+
+	tb6 = f6i->fib6_table;
+	spin_lock_bh(&tb6->tb6_lock);
+	f6i->expires = expires;
+	if (!fib6_has_expires(f6i))
+		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
+	f6i->fib6_flags |= RTF_EXPIRES;
+	spin_unlock_bh(&tb6->tb6_lock);
+}
+
+void fib6_set_expires_locked(struct fib6_info *f6i, unsigned long expires)
+{
+	struct fib6_table *tb6;
+
+	tb6 = f6i->fib6_table;
+	f6i->expires = expires;
+	if (tb6 && !fib6_has_expires(f6i))
+		hlist_add_head(&f6i->gc_link, &tb6->tb6_gc_hlist);
+	f6i->fib6_flags |= RTF_EXPIRES;
+}
+
+void fib6_clean_expires(struct fib6_info *f6i)
+{
+	struct fib6_table *tb6;
+
+	tb6 = f6i->fib6_table;
+	spin_lock_bh(&tb6->tb6_lock);
+	if (fib6_has_expires(f6i))
+		hlist_del_init(&f6i->gc_link);
+	f6i->fib6_flags &= ~RTF_EXPIRES;
+	f6i->expires = 0;
+	spin_unlock_bh(&tb6->tb6_lock);
+}
+
+void fib6_clean_expires_locked(struct fib6_info *f6i)
+{
+	struct fib6_table *tb6;
+
+	tb6 = f6i->fib6_table;
+	if (tb6 && fib6_has_expires(f6i))
+		hlist_del_init(&f6i->gc_link);
+	f6i->fib6_flags &= ~RTF_EXPIRES;
+	f6i->expires = 0;
+}
+
+static void fib6_gc_table(struct net *net,
+			  struct fib6_table *tb6,
+			  int (*func)(struct fib6_info *, void *arg),
+			  void *arg)
+{
+	struct fib6_info *rt;
+	struct hlist_node *n;
+	struct nl_info info = {
+		.nl_net = net,
+		.skip_notify = false,
+	};
+
+	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
+		if (func(rt, arg) == -1)
+			fib6_del(rt, &info);
+}
+
+static void fib6_gc_all(struct net *net,
+			int (*func)(struct fib6_info *, void *),
+			void *arg)
+{
+	struct fib6_table *table;
+	struct hlist_head *head;
+	unsigned int h;
+
+	rcu_read_lock();
+	for (h = 0; h < FIB6_TABLE_HASHSZ; h++) {
+		head = &net->ipv6.fib_table_hash[h];
+		hlist_for_each_entry_rcu(table, head, tb6_hlist) {
+			spin_lock_bh(&table->tb6_lock);
+			fib6_gc_table(net, table, func, arg);
+			spin_unlock_bh(&table->tb6_lock);
+		}
+	}
+	rcu_read_unlock();
+}
+
 void fib6_clean_all_skip_notify(struct net *net,
 				int (*func)(struct fib6_info *, void *),
 				void *arg)
@@ -2295,7 +2391,7 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 	 *	Routes are expired even if they are in use.
 	 */
 
-	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
+	if (fib6_has_expires(rt) && rt->expires) {
 		if (time_after(now, rt->expires)) {
 			RT6_TRACE("expiring %p\n", rt);
 			return -1;
@@ -2327,7 +2423,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 			  net->ipv6.sysctl.ip6_rt_gc_interval;
 	gc_args.more = 0;
 
-	fib6_clean_all(net, fib6_age, &gc_args);
+	fib6_gc_all(net, fib6_age, &gc_args);
 	now = jiffies;
 	net->ipv6.ip6_rt_last_gc = now;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..a69083563689 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3760,10 +3760,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 		rt->dst_nocount = true;
 
 	if (cfg->fc_flags & RTF_EXPIRES)
-		fib6_set_expires(rt, jiffies +
-				clock_t_to_jiffies(cfg->fc_expires));
+		fib6_set_expires_locked(rt, jiffies +
+					clock_t_to_jiffies(cfg->fc_expires));
 	else
-		fib6_clean_expires(rt);
+		fib6_clean_expires_locked(rt);
 
 	if (cfg->fc_protocol == RTPROT_UNSPEC)
 		cfg->fc_protocol = RTPROT_BOOT;
-- 
2.34.1


