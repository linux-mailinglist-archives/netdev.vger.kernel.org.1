Return-Path: <netdev+bounces-42608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096E7CF8A0
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 14:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70B211C20A02
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A5DDA6;
	Thu, 19 Oct 2023 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FWYe8yA/"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BF23D1
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 12:21:08 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EB0136
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:21:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81e9981ff4so10710373276.3
        for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697718065; x=1698322865; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NMqgfrSU8o1xNw173qnSKIqJAeAyeUFnlyvYn0TKrYM=;
        b=FWYe8yA/XyoufBXvt3mnfxLxTte761lxXVcQqi5rPyeGaJJyoaraw/rHB/ANKhWmGT
         /Dq7ql3x9f4zojNc0T/4usjgUieJvTjtq7XZvSRCcvV8hiWgEVe9YpnKv3rttj1ZSato
         wL+mwIzX2djeoxAbYE7N1mWVxBlRbadTSuCL6If0WZREo7qNzrjcVLTrwrtkSbVwkSod
         G2zbjlGpjj/xlRAyPYeF2Evkyt/I8a6Lq1uQVIFT6T8f9gQMv2/rvWyc6Ch+80GcQj7z
         69zGCDDeqb2oFWH6kdRAckLuqdKKZ74R8GJDlOP/NO74EA6gTOfAOf/B37i58QaP91bU
         3b1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697718065; x=1698322865;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMqgfrSU8o1xNw173qnSKIqJAeAyeUFnlyvYn0TKrYM=;
        b=bDak/AZhf4P4qo6pqKpwyOKIIAco+Djd9Vgdfyie2tTfBjM4IjyZGUl13/HnDocjc/
         FUjyYTrzLhTsYC9C3ns5WPWJYYODbn/D8Cxt8RHTiGTbii+lsAY0xNXzMGiCkjd34Nl8
         SSZyeufTEe+4YBFPGGEUW6Xm88A5obIKXm90Uc4dv/7QwHeKpznL6KLAkWeaxeh77c+S
         AJxdUozAxZCBz9r+pcpCqJ72TKIgxqqQunXMSKWl7zs933r51Vr/l0FqgB5DA8G/QXbC
         HpccnVntxEvDmXmAJ9o2xJGitRjHnPBCZdv+JOWk7pSP/OrD9T9BVq2pYXJbVNYaohr/
         nZnw==
X-Gm-Message-State: AOJu0YzDwByWf+VV7UVeFXmn2g4KT8JiZXNLI1Ns3DBGm5XcBWfLPyU1
	v1bbScWbOQmwIAKs6W/4Y8xOnYrNGrjY3A==
X-Google-Smtp-Source: AGHT+IFG0drriKO951ah6Yi6+nVj4OvMQ3/eLxUbUm+4qBb8laew4zLnl4/iHGNmeMV0VtDawwZPVNjsz38jkQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1746:b0:d9a:bce6:acf3 with SMTP
 id bz6-20020a056902174600b00d9abce6acf3mr48221ybb.0.1697718065498; Thu, 19
 Oct 2023 05:21:05 -0700 (PDT)
Date: Thu, 19 Oct 2023 12:21:04 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019122104.1448310-1-edumazet@google.com>
Subject: [PATCH net] neighbour: fix various data-races
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

1) tbl->gc_thresh1, tbl->gc_thresh2, tbl->gc_thresh3 and tbl->gc_interval
   can be written from sysfs.

2) tbl->last_flush is read locklessly from neigh_alloc()

3) tbl->proxy_queue.qlen is read locklessly from neightbl_fill_info()

4) neightbl_fill_info() reads cpu stats that can be changed concurrently.

Fixes: c7fb64db001f ("[NETLINK]: Neighbour table configuration and statistics via rtnetlink")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/neighbour.c | 67 +++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 9c09f091cbffe59043ce4614423d7dce7d4ec42a..df81c1f0a57047e176b7c7e4809d2dae59ba6be5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -251,7 +251,8 @@ bool neigh_remove_one(struct neighbour *ndel, struct neigh_table *tbl)
 
 static int neigh_forced_gc(struct neigh_table *tbl)
 {
-	int max_clean = atomic_read(&tbl->gc_entries) - tbl->gc_thresh2;
+	int max_clean = atomic_read(&tbl->gc_entries) -
+			READ_ONCE(tbl->gc_thresh2);
 	unsigned long tref = jiffies - 5 * HZ;
 	struct neighbour *n, *tmp;
 	int shrunk = 0;
@@ -280,7 +281,7 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 		}
 	}
 
-	tbl->last_flush = jiffies;
+	WRITE_ONCE(tbl->last_flush, jiffies);
 
 	write_unlock_bh(&tbl->lock);
 
@@ -464,17 +465,17 @@ static struct neighbour *neigh_alloc(struct neigh_table *tbl,
 {
 	struct neighbour *n = NULL;
 	unsigned long now = jiffies;
-	int entries;
+	int entries, gc_thresh3;
 
 	if (exempt_from_gc)
 		goto do_alloc;
 
 	entries = atomic_inc_return(&tbl->gc_entries) - 1;
-	if (entries >= tbl->gc_thresh3 ||
-	    (entries >= tbl->gc_thresh2 &&
-	     time_after(now, tbl->last_flush + 5 * HZ))) {
-		if (!neigh_forced_gc(tbl) &&
-		    entries >= tbl->gc_thresh3) {
+	gc_thresh3 = READ_ONCE(tbl->gc_thresh3);
+	if (entries >= gc_thresh3 ||
+	    (entries >= READ_ONCE(tbl->gc_thresh2) &&
+	     time_after(now, READ_ONCE(tbl->last_flush) + 5 * HZ))) {
+		if (!neigh_forced_gc(tbl) && entries >= gc_thresh3) {
 			net_info_ratelimited("%s: neighbor table overflow!\n",
 					     tbl->id);
 			NEIGH_CACHE_STAT_INC(tbl, table_fulls);
@@ -955,13 +956,14 @@ static void neigh_periodic_work(struct work_struct *work)
 
 	if (time_after(jiffies, tbl->last_rand + 300 * HZ)) {
 		struct neigh_parms *p;
-		tbl->last_rand = jiffies;
+
+		WRITE_ONCE(tbl->last_rand, jiffies);
 		list_for_each_entry(p, &tbl->parms_list, list)
 			p->reachable_time =
 				neigh_rand_reach_time(NEIGH_VAR(p, BASE_REACHABLE_TIME));
 	}
 
-	if (atomic_read(&tbl->entries) < tbl->gc_thresh1)
+	if (atomic_read(&tbl->entries) < READ_ONCE(tbl->gc_thresh1))
 		goto out;
 
 	for (i = 0 ; i < (1 << nht->hash_shift); i++) {
@@ -2167,15 +2169,16 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 	ndtmsg->ndtm_pad2   = 0;
 
 	if (nla_put_string(skb, NDTA_NAME, tbl->id) ||
-	    nla_put_msecs(skb, NDTA_GC_INTERVAL, tbl->gc_interval, NDTA_PAD) ||
-	    nla_put_u32(skb, NDTA_THRESH1, tbl->gc_thresh1) ||
-	    nla_put_u32(skb, NDTA_THRESH2, tbl->gc_thresh2) ||
-	    nla_put_u32(skb, NDTA_THRESH3, tbl->gc_thresh3))
+	    nla_put_msecs(skb, NDTA_GC_INTERVAL, READ_ONCE(tbl->gc_interval),
+			  NDTA_PAD) ||
+	    nla_put_u32(skb, NDTA_THRESH1, READ_ONCE(tbl->gc_thresh1)) ||
+	    nla_put_u32(skb, NDTA_THRESH2, READ_ONCE(tbl->gc_thresh2)) ||
+	    nla_put_u32(skb, NDTA_THRESH3, READ_ONCE(tbl->gc_thresh3)))
 		goto nla_put_failure;
 	{
 		unsigned long now = jiffies;
-		long flush_delta = now - tbl->last_flush;
-		long rand_delta = now - tbl->last_rand;
+		long flush_delta = now - READ_ONCE(tbl->last_flush);
+		long rand_delta = now - READ_ONCE(tbl->last_rand);
 		struct neigh_hash_table *nht;
 		struct ndt_config ndc = {
 			.ndtc_key_len		= tbl->key_len,
@@ -2183,7 +2186,7 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			.ndtc_entries		= atomic_read(&tbl->entries),
 			.ndtc_last_flush	= jiffies_to_msecs(flush_delta),
 			.ndtc_last_rand		= jiffies_to_msecs(rand_delta),
-			.ndtc_proxy_qlen	= tbl->proxy_queue.qlen,
+			.ndtc_proxy_qlen	= READ_ONCE(tbl->proxy_queue.qlen),
 		};
 
 		rcu_read_lock();
@@ -2206,17 +2209,17 @@ static int neightbl_fill_info(struct sk_buff *skb, struct neigh_table *tbl,
 			struct neigh_statistics	*st;
 
 			st = per_cpu_ptr(tbl->stats, cpu);
-			ndst.ndts_allocs		+= st->allocs;
-			ndst.ndts_destroys		+= st->destroys;
-			ndst.ndts_hash_grows		+= st->hash_grows;
-			ndst.ndts_res_failed		+= st->res_failed;
-			ndst.ndts_lookups		+= st->lookups;
-			ndst.ndts_hits			+= st->hits;
-			ndst.ndts_rcv_probes_mcast	+= st->rcv_probes_mcast;
-			ndst.ndts_rcv_probes_ucast	+= st->rcv_probes_ucast;
-			ndst.ndts_periodic_gc_runs	+= st->periodic_gc_runs;
-			ndst.ndts_forced_gc_runs	+= st->forced_gc_runs;
-			ndst.ndts_table_fulls		+= st->table_fulls;
+			ndst.ndts_allocs		+= READ_ONCE(st->allocs);
+			ndst.ndts_destroys		+= READ_ONCE(st->destroys);
+			ndst.ndts_hash_grows		+= READ_ONCE(st->hash_grows);
+			ndst.ndts_res_failed		+= READ_ONCE(st->res_failed);
+			ndst.ndts_lookups		+= READ_ONCE(st->lookups);
+			ndst.ndts_hits			+= READ_ONCE(st->hits);
+			ndst.ndts_rcv_probes_mcast	+= READ_ONCE(st->rcv_probes_mcast);
+			ndst.ndts_rcv_probes_ucast	+= READ_ONCE(st->rcv_probes_ucast);
+			ndst.ndts_periodic_gc_runs	+= READ_ONCE(st->periodic_gc_runs);
+			ndst.ndts_forced_gc_runs	+= READ_ONCE(st->forced_gc_runs);
+			ndst.ndts_table_fulls		+= READ_ONCE(st->table_fulls);
 		}
 
 		if (nla_put_64bit(skb, NDTA_STATS, sizeof(ndst), &ndst,
@@ -2445,16 +2448,16 @@ static int neightbl_set(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto errout_tbl_lock;
 
 	if (tb[NDTA_THRESH1])
-		tbl->gc_thresh1 = nla_get_u32(tb[NDTA_THRESH1]);
+		WRITE_ONCE(tbl->gc_thresh1, nla_get_u32(tb[NDTA_THRESH1]));
 
 	if (tb[NDTA_THRESH2])
-		tbl->gc_thresh2 = nla_get_u32(tb[NDTA_THRESH2]);
+		WRITE_ONCE(tbl->gc_thresh2, nla_get_u32(tb[NDTA_THRESH2]));
 
 	if (tb[NDTA_THRESH3])
-		tbl->gc_thresh3 = nla_get_u32(tb[NDTA_THRESH3]);
+		WRITE_ONCE(tbl->gc_thresh3, nla_get_u32(tb[NDTA_THRESH3]));
 
 	if (tb[NDTA_GC_INTERVAL])
-		tbl->gc_interval = nla_get_msecs(tb[NDTA_GC_INTERVAL]);
+		WRITE_ONCE(tbl->gc_interval, nla_get_msecs(tb[NDTA_GC_INTERVAL]));
 
 	err = 0;
 
-- 
2.42.0.655.g421f12c284-goog


