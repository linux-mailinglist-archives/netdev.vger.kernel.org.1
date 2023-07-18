Return-Path: <netdev+bounces-18673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F228758413
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F94E1C20DC6
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E151641E;
	Tue, 18 Jul 2023 18:03:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074601641B
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:03:48 +0000 (UTC)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876ECB6
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:03:46 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-577637de4beso61256757b3.0
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689703426; x=1692295426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TR/4BkGxGVKYWleZTfiMv2J01KA2c0QwldS4cSwYrU=;
        b=DG/dIpKNFFlN9owucF7gcVUOPf6hcwJ8FW3l4HyL5Xg+OzmOJiaLTQQkxajJ1mSwpg
         92L8LiFEPMRq5yHRfs3V5HInSFvu5MJ0o8rfjhAViIWbez9ilrY9bPxgbzMGmJl3eDSE
         O9g0Gb2CaPXR95SrlcJPjk8bapHgxKSwRfKUvxaoq2QQE5RGM1onCQQRfk/ASP8IV5/a
         mcUwu8iSyOqx8jxOTNDkJhBtetOqS2G/WDA4wW4pwWA0WiLZ9V5+Y5S85MbS25XB6GwC
         TGMkgTPps609jEzJFxzqNf0pMH/eLZJxZX7UnvnDSY8bWdDWiEDoe29d+b5nbSZiGY95
         ha+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689703426; x=1692295426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TR/4BkGxGVKYWleZTfiMv2J01KA2c0QwldS4cSwYrU=;
        b=JHphhPD5cmDRS0X4dSfe+xE5avUa3NGTLkDUwCOgjdZC9NwdVD+ONjvbR7Koa5p5GT
         KBpCGgQM+8yyb0o+cq4aVYzxy15rDAOcsvByW++eVI1Dp51mkSYCE8KhoyT23SIqJjR5
         pHwHG9uXysvBzUmzLZ4vr3BRgB/CQma0OvVAVU34P8jV+Ruspz6xdUtRJOsPiHWlyLUk
         Oix3VB2Gu9paxQN1GM6ZnSUW4dezKRLXszc0mxLUvgKc5xQ6codboCdzohxCnF4tOahI
         aalqMf4GKA+wT7Asrl3WTdgf/qBM7R69k4KgvQ5+kyYgaPouOcFf62int61zMvvtwLvR
         WKKw==
X-Gm-Message-State: ABy/qLZJaHJkZCb2eJlKuqIShqJXio/hmFbFsQsNItaitJO8be1Ynfnr
	3KtS1Ghbc7Q4JtxoSlWP1v0=
X-Google-Smtp-Source: APBJJlGzTq8bmVqOTYMWhUw0jPyIuwa0tpFMoEK+YdvRDinse5dTgfh/i9K/CFi9qPvtjRjaHdUNwA==
X-Received: by 2002:a81:7505:0:b0:573:7f55:a40e with SMTP id q5-20020a817505000000b005737f55a40emr400866ywc.49.1689703425678;
        Tue, 18 Jul 2023 11:03:45 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:770d:e789:cf56:fb43])
        by smtp.gmail.com with ESMTPSA id d3-20020a81d343000000b00577044eb00esm579121ywl.21.2023.07.18.11.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:03:45 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] net/ipv6: Remove expired routes with a separated list of routes.
Date: Tue, 18 Jul 2023 11:03:20 -0700
Message-Id: <20230718180321.294721-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230718180321.294721-1-kuifeng@meta.com>
References: <20230718180321.294721-1-kuifeng@meta.com>
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

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/net/ip6_fib.h | 65 ++++++++++++++++++++++++++++++++++---------
 net/ipv6/ip6_fib.c    | 53 ++++++++++++++++++++++++++++++++---
 net/ipv6/route.c      |  6 ++--
 3 files changed, 104 insertions(+), 20 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 05e6f756feaf..e6f4d986fb63 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -179,6 +179,9 @@ struct fib6_info {
 
 	refcount_t			fib6_ref;
 	unsigned long			expires;
+
+	struct hlist_node		gc_link;
+
 	struct dst_metrics		*fib6_metrics;
 #define fib6_pmtu		fib6_metrics->metrics[RTAX_MTU-1]
 
@@ -247,19 +250,6 @@ static inline bool fib6_requires_src(const struct fib6_info *rt)
 	return rt->fib6_src.plen > 0;
 }
 
-static inline void fib6_clean_expires(struct fib6_info *f6i)
-{
-	f6i->fib6_flags &= ~RTF_EXPIRES;
-	f6i->expires = 0;
-}
-
-static inline void fib6_set_expires(struct fib6_info *f6i,
-				    unsigned long expires)
-{
-	f6i->expires = expires;
-	f6i->fib6_flags |= RTF_EXPIRES;
-}
-
 static inline bool fib6_check_expired(const struct fib6_info *f6i)
 {
 	if (f6i->fib6_flags & RTF_EXPIRES)
@@ -267,6 +257,11 @@ static inline bool fib6_check_expired(const struct fib6_info *f6i)
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
@@ -388,6 +383,7 @@ struct fib6_table {
 	struct inet_peer_base	tb6_peers;
 	unsigned int		flags;
 	unsigned int		fib_seq;
+	struct hlist_head       tb6_gc_hlist;	/* GC candidates */
 #define RT6_TABLE_HAS_DFLT_ROUTER	BIT(0)
 };
 
@@ -504,6 +500,49 @@ void fib6_gc_cleanup(void);
 
 int fib6_init(void);
 
+/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
+ * NULL.
+ */
+static inline void fib6_set_expires_locked(struct fib6_info *f6i, unsigned long expires)
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
+/* fib6_info must be locked by the caller, and fib6_info->fib6_table can be
+ * NULL.  If fib6_table is NULL, the fib6_info will no be inserted into the
+ * list of GC candidates until it is inserted into a table.
+ */
+static inline void fib6_set_expires(struct fib6_info *f6i, unsigned long expires)
+{
+	spin_lock_bh(&f6i->fib6_table->tb6_lock);
+	fib6_set_expires_locked(f6i, expires);
+	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
+}
+
+static inline void fib6_clean_expires_locked(struct fib6_info *f6i)
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
+static inline void fib6_clean_expires(struct fib6_info *f6i)
+{
+	spin_lock_bh(&f6i->fib6_table->tb6_lock);
+	fib6_clean_expires_locked(f6i);
+	spin_unlock_bh(&f6i->fib6_table->tb6_lock);
+}
+
 struct ipv6_route_iter {
 	struct seq_net_private p;
 	struct fib6_walker w;
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index bac768d36cc1..a4422d513d4d 100644
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
@@ -2295,7 +2306,7 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 	 *	Routes are expired even if they are in use.
 	 */
 
-	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
+	if (fib6_has_expires(rt) && rt->expires) {
 		if (time_after(now, rt->expires)) {
 			RT6_TRACE("expiring %p\n", rt);
 			return -1;
@@ -2312,6 +2323,40 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 	return 0;
 }
 
+static void fib6_gc_table(struct net *net,
+			  struct fib6_table *tb6,
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
+		if (fib6_age(rt, arg) == -1)
+			fib6_del(rt, &info);
+}
+
+static void fib6_gc_all(struct net *net, void *arg)
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
+			fib6_gc_table(net, table, arg);
+			spin_unlock_bh(&table->tb6_lock);
+		}
+	}
+	rcu_read_unlock();
+}
+
 void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 {
 	struct fib6_gc_args gc_args;
@@ -2327,7 +2372,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 			  net->ipv6.sysctl.ip6_rt_gc_interval;
 	gc_args.more = 0;
 
-	fib6_clean_all(net, fib6_age, &gc_args);
+	fib6_gc_all(net, &gc_args);
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


