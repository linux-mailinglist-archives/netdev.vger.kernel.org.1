Return-Path: <netdev+bounces-47746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF95F7EB202
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 15:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F68C1F24DFB
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 14:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7327E41218;
	Tue, 14 Nov 2023 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="LtsSnx8U"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C24C405ED
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 14:21:00 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718BAD1
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:20:58 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cc34c3420bso43703155ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 06:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1699971657; x=1700576457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh3M+al8uoXi2CtwG2fnszwhbAARPu0RxBHKH5YuMy8=;
        b=LtsSnx8UHInrAA+tl7Vxb/DF2GRbHZ/w/xJ9o2xdxunC2gwhq2A55KrsOJjj+CdJeD
         IyWrjJoBCYRrbgDBwNJJDhC2HIt8oUHT/7ePio6CoOiZsiTHvYhPvbaO9a62Lmoon9AV
         aYSpLD9elp9UFOuoEVpw1naG4EVaKIyrW+yta9xiku/N+iTHhwUszIfYYXz17ekzHI5/
         BBWYgMwE2rgiaK0r26uQnssDZGdGL6SDI8Qoxpeu+SxN5WVEfefxz7Fa1v0i9ISTeUCZ
         S7cwV0NouhKz7roROXCkaH0TXjfU48anBld10ERUgIQhDk0Hllwz7Ji+oy4wu3UAp7Jk
         typw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699971657; x=1700576457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yh3M+al8uoXi2CtwG2fnszwhbAARPu0RxBHKH5YuMy8=;
        b=ob2iDRKHknMM0o4KXlDn0MzfgllKEkBVOvUN2j2RimjTnp0DvSVKIhX+vo5zh16Mro
         rlBkekoxQSk7nAhP2hXt8Rh9VwLtCjVZcbTBBwAiLRgY64Tl4/lC5sakFs5D7d8Vdg8q
         WG7tijQNwxE8TKnUQt9h5h0AVSMW2iKFs/Kxk+6akoNyUg0TATM2bEEwXD+QgxsW6Siu
         +xvSWn14lC0VHVQZm/aDwyQG850qU2sC75+0iIcEnGOi5427h4C2qLwmItIgQCAwVj9g
         CJb/R/FAwi5TLV/kONGtaHeRPGejwtJhshzpSL71AelCozAlP5mksR58L9NPFbTB/G5m
         11pg==
X-Gm-Message-State: AOJu0YxI95whHX8umS7geVvygDCrVm+VHi31oHik0qN6JVpVAjeca9or
	qPRlxyDFiNK1jkHltzvET2Mc59mKZFsAYBq89JY=
X-Google-Smtp-Source: AGHT+IEt53gyWoZ/3ONwNNC/aztc7BqDR04KYikUJZS61UI1SJz1X3ZMCaACqq7PDAzFkFqxi2aU9g==
X-Received: by 2002:a17:902:ac8f:b0:1cc:b460:e6cc with SMTP id h15-20020a170902ac8f00b001ccb460e6ccmr2570113plr.12.1699971657461;
        Tue, 14 Nov 2023 06:20:57 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([2804:14d:5c5e:44fb:70a4:6f84:7ab8:14d8])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001c8a0879805sm5687608pli.206.2023.11.14.06.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 06:20:56 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com
Subject: [PATCH net-next 1/2] net/sched: cls_u32: replace int refcounts with proper refcounts
Date: Tue, 14 Nov 2023 11:18:55 -0300
Message-Id: <20231114141856.974326-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231114141856.974326-1-pctammela@mojatatu.com>
References: <20231114141856.974326-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Proper refcounts will always warn splat when something goes wrong,
be it underflow, saturation or object resurrection. As these are always
a source of bugs, use it in cls_u32 as a safeguard to prevent/catch issues.
Another benefit is that the refcount API self documents the code, making
clear when transitions to dead are expected.

For such an update we had to make minor adaptations on u32 to fit the refcount
API. First we set explicitly to '1' when objects are created, then the
objects are alive until a 1 -> 0 happens, which is then released appropriately.

The above made clear some redundant operations in the u32 code
around the root_ht handling that were removed. The root_ht is created
with a refcnt set to 1. Then when it's associated with tcf_proto it increments the refcnt to 2.
Throughout the entire code the root_ht is an exceptional case and can never be referenced,
therefore the refcnt never incremented/decremented.
Its lifetime is always bound to tcf_proto, meaning if you delete tcf_proto
the root_ht is deleted as well. The code made up for the fact that root_ht refcnt is 2 and did
a double decrement to free it, which is not a fit for the refcount API.

Even though refcount_t is implemented using atomics, we should observe
a negligible control plane impact.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_u32.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d5bdfd4a7655..fc1f3498082c 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -71,7 +71,7 @@ struct tc_u_hnode {
 	struct tc_u_hnode __rcu	*next;
 	u32			handle;
 	u32			prio;
-	int			refcnt;
+	refcount_t		refcnt;
 	unsigned int		divisor;
 	struct idr		handle_idr;
 	bool			is_root;
@@ -86,7 +86,7 @@ struct tc_u_hnode {
 struct tc_u_common {
 	struct tc_u_hnode __rcu	*hlist;
 	void			*ptr;
-	int			refcnt;
+	refcount_t		refcnt;
 	struct idr		handle_idr;
 	struct hlist_node	hnode;
 	long			knodes;
@@ -359,7 +359,7 @@ static int u32_init(struct tcf_proto *tp)
 	if (root_ht == NULL)
 		return -ENOBUFS;
 
-	root_ht->refcnt++;
+	refcount_set(&root_ht->refcnt, 1);
 	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : 0x80000000;
 	root_ht->prio = tp->prio;
 	root_ht->is_root = true;
@@ -371,18 +371,20 @@ static int u32_init(struct tcf_proto *tp)
 			kfree(root_ht);
 			return -ENOBUFS;
 		}
+		refcount_set(&tp_c->refcnt, 1);
 		tp_c->ptr = key;
 		INIT_HLIST_NODE(&tp_c->hnode);
 		idr_init(&tp_c->handle_idr);
 
 		hlist_add_head(&tp_c->hnode, tc_u_hash(key));
+	} else {
+		refcount_inc(&tp_c->refcnt);
 	}
 
-	tp_c->refcnt++;
 	RCU_INIT_POINTER(root_ht->next, tp_c->hlist);
 	rcu_assign_pointer(tp_c->hlist, root_ht);
 
-	root_ht->refcnt++;
+	/* root_ht must be destroyed when tcf_proto is destroyed */
 	rcu_assign_pointer(tp->root, root_ht);
 	tp->data = tp_c;
 	return 0;
@@ -393,7 +395,7 @@ static void __u32_destroy_key(struct tc_u_knode *n)
 	struct tc_u_hnode *ht = rtnl_dereference(n->ht_down);
 
 	tcf_exts_destroy(&n->exts);
-	if (ht && --ht->refcnt == 0)
+	if (ht && refcount_dec_and_test(&ht->refcnt))
 		kfree(ht);
 	kfree(n);
 }
@@ -601,8 +603,6 @@ static int u32_destroy_hnode(struct tcf_proto *tp, struct tc_u_hnode *ht,
 	struct tc_u_hnode __rcu **hn;
 	struct tc_u_hnode *phn;
 
-	WARN_ON(--ht->refcnt);
-
 	u32_clear_hnode(tp, ht, extack);
 
 	hn = &tp_c->hlist;
@@ -630,10 +630,10 @@ static void u32_destroy(struct tcf_proto *tp, bool rtnl_held,
 
 	WARN_ON(root_ht == NULL);
 
-	if (root_ht && --root_ht->refcnt == 1)
+	if (root_ht && refcount_dec_and_test(&root_ht->refcnt))
 		u32_destroy_hnode(tp, root_ht, extack);
 
-	if (--tp_c->refcnt == 0) {
+	if (refcount_dec_and_test(&tp_c->refcnt)) {
 		struct tc_u_hnode *ht;
 
 		hlist_del(&tp_c->hnode);
@@ -645,7 +645,7 @@ static void u32_destroy(struct tcf_proto *tp, bool rtnl_held,
 			/* u32_destroy_key() will later free ht for us, if it's
 			 * still referenced by some knode
 			 */
-			if (--ht->refcnt == 0)
+			if (refcount_dec_and_test(&ht->refcnt))
 				kfree_rcu(ht, rcu);
 		}
 
@@ -674,7 +674,7 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
 		return -EINVAL;
 	}
 
-	if (ht->refcnt == 1) {
+	if (refcount_dec_if_one(&ht->refcnt)) {
 		u32_destroy_hnode(tp, ht, extack);
 	} else {
 		NL_SET_ERR_MSG_MOD(extack, "Can not delete in-use filter");
@@ -682,7 +682,7 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
 	}
 
 out:
-	*last = tp_c->refcnt == 1 && tp_c->knodes == 0;
+	*last = refcount_read(&tp_c->refcnt) == 1 && tp_c->knodes == 0;
 	return ret;
 }
 
@@ -766,14 +766,14 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 				NL_SET_ERR_MSG_MOD(extack, "Not linking to root node");
 				return -EINVAL;
 			}
-			ht_down->refcnt++;
+			refcount_inc(&ht_down->refcnt);
 		}
 
 		ht_old = rtnl_dereference(n->ht_down);
 		rcu_assign_pointer(n->ht_down, ht_down);
 
 		if (ht_old)
-			ht_old->refcnt--;
+			refcount_dec(&ht_old->refcnt);
 	}
 
 	if (ifindex >= 0)
@@ -852,7 +852,7 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
 
 	/* bump reference count as long as we hold pointer to structure */
 	if (ht)
-		ht->refcnt++;
+		refcount_inc(&ht->refcnt);
 
 	return new;
 }
@@ -932,7 +932,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 				ht_old = rtnl_dereference(n->ht_down);
 				if (ht_old)
-					ht_old->refcnt++;
+					refcount_inc(&ht_old->refcnt);
 			}
 			__u32_destroy_key(new);
 			return err;
@@ -980,7 +980,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 				return err;
 			}
 		}
-		ht->refcnt = 1;
+		refcount_set(&ht->refcnt, 1);
 		ht->divisor = divisor;
 		ht->handle = handle;
 		ht->prio = tp->prio;
-- 
2.40.1


