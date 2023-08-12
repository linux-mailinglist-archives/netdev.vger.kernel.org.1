Return-Path: <netdev+bounces-26983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4CA779BEF
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 02:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89797281FF9
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965F0111B;
	Sat, 12 Aug 2023 00:30:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8261F1106
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 00:30:55 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0773588
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:30:52 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d3522283441so2279217276.0
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691800251; x=1692405051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPVd8gODCUWF4vrR+GopLmNOe3vAMdPdB0aczcy/7Ik=;
        b=IaV+bZDbS7141vKKjEPkpSDspllJBZTRDyh+k1B9mv4Nt+uwqBEL+AN0inQyb2NzTg
         SoddZjVGtmr8j1PzXZmmEqPevOI1zTssqMLkqpm1hk+2CXXZYAC8+N0JRwqXe0vvnKq1
         7xAzh7RHAnOnNakU4xHn8fAL14dz3ujMnX20eJz94Nx0aGzalKsLY5HLoyYzi/WjtKnD
         kC35YRlTEu98EvzsN9Opw86tcYggdqc5QEvP3Zoq1/Xdo0yZeDSQyjzu5hPqCbHQ1EDZ
         JE5jiqhRdbNdK7zi1teDNgrBGbjS5nx211xrN3iSL9EyfqfVZtsLvfFcLXum7iZCS/fo
         5/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691800251; x=1692405051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TPVd8gODCUWF4vrR+GopLmNOe3vAMdPdB0aczcy/7Ik=;
        b=L5/FmrggluOQCbYyBzh1E0VaKAJrewfxkd2GRu/tqetR3VgiWUnOvBzY+CAPknWcI+
         PP+w8dY/TW4HoACkmRLS0CRpP1m/Jp6TLl+BaLxV7HHc82toxc0fGteppvpQ4Z3IRhXQ
         dBS7Pt6j8CXtrlHkX0C38y/zonI2BvoTZ24I1uJ69EHtlqcD/sGZdaKviW8B9Y1WOd4S
         4walWumnSj9VnWF7Fzrwc0dUzZjL8t7sut4ciXr9M/rvK15f5Sr1+N2ksFgwM8iWbhx9
         ReeRUY+VQN//4AvbK21dJJm5e2SRvCohyCtY0HRlEOzXxiLzJMHfRZgNlvVXDb1eL8AB
         orHA==
X-Gm-Message-State: AOJu0YyPY7J5iFGJueuZAc3p3wcJM8OFBDeOW4DnzZfjHS15iUDxPLz1
	4uxxZuNSVTDW7wviLvWYEUI=
X-Google-Smtp-Source: AGHT+IED1tIKatoNDM7y+xDiAmNvAFvY93yiUQ2Qo0AagKZHTFyxEtXPZLVEP3ROyH4GBQD/t5qgxw==
X-Received: by 2002:a0d:f403:0:b0:57a:6a2c:f4dd with SMTP id d3-20020a0df403000000b0057a6a2cf4ddmr3320480ywf.36.1691800251262;
        Fri, 11 Aug 2023 17:30:51 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id n11-20020a0dcb0b000000b0058419c57c66sm1319648ywd.4.2023.08.11.17.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 17:30:50 -0700 (PDT)
From: thinker.li@gmail.com
To: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	yhs@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH net-next v7 1/2] net/ipv6: Remove expired routes with a separated list of routes.
Date: Fri, 11 Aug 2023 17:30:46 -0700
Message-Id: <20230812003047.447772-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812003047.447772-1-thinker.li@gmail.com>
References: <20230812003047.447772-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Kui-Feng Lee <thinker.li@gmail.com>

FIB6 GC walks trees of fib6_tables to remove expired routes. Walking a tree
can be expensive if the number of routes in a table is big, even if most of
them are permanent. Checking routes in a separated list of routes having
expiration will avoid this potential issue.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/ip6_fib.h | 62 ++++++++++++++++++++++++++++++++++---------
 net/ipv6/ip6_fib.c    | 54 ++++++++++++++++++++++++++++++++-----
 net/ipv6/route.c      |  6 ++---
 3 files changed, 100 insertions(+), 22 deletions(-)

diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 05e6f756feaf..36e983e9fd20 100644
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
 
@@ -504,6 +500,46 @@ void fib6_gc_cleanup(void);
 
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
+	if (fib6_has_expires(f6i))
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
index bac768d36cc1..c54d9b34d621 100644
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
@@ -1057,6 +1060,8 @@ static void fib6_purge_rt(struct fib6_info *rt, struct fib6_node *fn,
 				    lockdep_is_held(&table->tb6_lock));
 		}
 	}
+
+	fib6_clean_expires_locked(rt);
 }
 
 /*
@@ -1118,9 +1123,9 @@ static int fib6_add_rt2node(struct fib6_node *fn, struct fib6_info *rt,
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
@@ -1479,6 +1484,10 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
 		if (rt->nh)
 			list_add(&rt->nh_list, &rt->nh->f6i_list);
 		__fib6_update_sernum_upto_root(rt, fib6_new_sernum(info->nl_net));
+
+		if (fib6_has_expires(rt))
+			hlist_add_head(&rt->gc_link, &table->tb6_gc_hlist);
+
 		fib6_start_gc(info->nl_net, rt);
 	}
 
@@ -2285,9 +2294,8 @@ static void fib6_flush_trees(struct net *net)
  *	Garbage collection
  */
 
-static int fib6_age(struct fib6_info *rt, void *arg)
+static int fib6_age(struct fib6_info *rt, struct fib6_gc_args *gc_args)
 {
-	struct fib6_gc_args *gc_args = arg;
 	unsigned long now = jiffies;
 
 	/*
@@ -2295,7 +2303,7 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 	 *	Routes are expired even if they are in use.
 	 */
 
-	if (rt->fib6_flags & RTF_EXPIRES && rt->expires) {
+	if (fib6_has_expires(rt) && rt->expires) {
 		if (time_after(now, rt->expires)) {
 			RT6_TRACE("expiring %p\n", rt);
 			return -1;
@@ -2312,6 +2320,40 @@ static int fib6_age(struct fib6_info *rt, void *arg)
 	return 0;
 }
 
+static void fib6_gc_table(struct net *net,
+			  struct fib6_table *tb6,
+			  struct fib6_gc_args *gc_args)
+{
+	struct fib6_info *rt;
+	struct hlist_node *n;
+	struct nl_info info = {
+		.nl_net = net,
+		.skip_notify = false,
+	};
+
+	hlist_for_each_entry_safe(rt, n, &tb6->tb6_gc_hlist, gc_link)
+		if (fib6_age(rt, gc_args) == -1)
+			fib6_del(rt, &info);
+}
+
+static void fib6_gc_all(struct net *net, struct fib6_gc_args *gc_args)
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
+			fib6_gc_table(net, table, gc_args);
+			spin_unlock_bh(&table->tb6_lock);
+		}
+	}
+	rcu_read_unlock();
+}
+
 void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 {
 	struct fib6_gc_args gc_args;
@@ -2327,7 +2369,7 @@ void fib6_run_gc(unsigned long expires, struct net *net, bool force)
 			  net->ipv6.sysctl.ip6_rt_gc_interval;
 	gc_args.more = 0;
 
-	fib6_clean_all(net, fib6_age, &gc_args);
+	fib6_gc_all(net, &gc_args);
 	now = jiffies;
 	net->ipv6.ip6_rt_last_gc = now;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 10751df16dab..db10c36f34bb 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3761,10 +3761,10 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
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


