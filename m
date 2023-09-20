Return-Path: <netdev+bounces-35323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EB67A8DBD
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 22:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF89DB20C2D
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 20:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2493450C0;
	Wed, 20 Sep 2023 20:17:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448519BC2
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 20:17:27 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C192A1
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:26 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d814a1f7378so2494168276.1
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695241045; x=1695845845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/duLnmJa+e92siKqjS2thsa1Pid0d3PPfvkcZ7rXNXg=;
        b=x8FWaVb3vNdscZuk2UN2de33wryiX4DMgngj49e7KEfBSVubPqXhkxgbjc+HkRCr75
         YtFtKwttusk6y5g90FV8oI+AmmpD0qEIZAINwnPI75YAyRwutuqPR+Cw7enoAfXOk4xs
         mG8Xa7kOig1RnSt6eHU3wAjP4KqnsQbq4ooHSQu/pfCQjVhkJuxDJrwCqVeOhwBgD7lN
         1xWmof+HcpPqu6/EBtnAecJtMfiy9Ld3cs9Dc9NWuLcCQyzukgmWkZq6Zw8nULID90es
         ZD5B/EP/TaGD7lvGHYGDwBKwPW7a84iLsIJyH1emsixgP0+ZltFAF4A78oCas5s8CUCA
         foiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695241045; x=1695845845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/duLnmJa+e92siKqjS2thsa1Pid0d3PPfvkcZ7rXNXg=;
        b=YlxA9HtSfy6tH4c8dbcJDrflL94moGYCTi5t9O5POK/AQh1Z6Lv2e8N7SbG86khzpL
         8WkCfnDZoY7czfXZd0S91NtE5plmJaLTA3/yfBdiy/d1shabF4ik7zM/9g/4XLhPRYgi
         LU1VZsW6R6r1hMEZT51jHr1xb4eT7fGf4Nlq6r1vL4f9x8enVmacYsNB7m+vK4PdXKGe
         3sKsToi15cDJeb1+5oG8VmT299sIL6Rnw/GvMdyGBnwTqHMRsYSkYYBcbXr1AwS/NejB
         Quv59YbH0LkfESbCVoEmQ5DPNTKzaPqtSJsFMVWKLDeSBaNUkJjuerKqcI8ujIKVJqi/
         XL6w==
X-Gm-Message-State: AOJu0YyKhmNAqFdhw+8IhFf6+CxetDYEYZCIfcU1fjpwoPXX/E9szxme
	Qulx6YZmxWpzZBzZl2gL2lEBJnkkSaIVJQ==
X-Google-Smtp-Source: AGHT+IGddGbwX8tlqZ6qSpfU+YsqGzfcrpyfu2vF22e+uX4WfMNy2fXS6Cw1zik9vqSeOWIEk0KEeKI01vp1HQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:b7d1:0:b0:d81:57ba:4d7a with SMTP id
 u17-20020a25b7d1000000b00d8157ba4d7amr78489ybj.6.1695241045610; Wed, 20 Sep
 2023 13:17:25 -0700 (PDT)
Date: Wed, 20 Sep 2023 20:17:15 +0000
In-Reply-To: <20230920201715.418491-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920201715.418491-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920201715.418491-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/5] net_sched: sch_fq: always garbage collect
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

FQ performs garbage collection at enqueue time, and only
if number of flows is above a given threshold, which
is hit after the qdisc has been used a bit.

Since an RB-tree traversal is needed to locate a flow,
it makes sense to perform gc all the time, to keep
rb-trees smaller.

This reduces by 50 % average storage costs in FQ,
and avoids 1 cache line miss at enqueue time when
fast path added in prior patch can not be used.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 5cf3b50a24d58d0e22c33997592696c4a03ec8ee..681bbf34b70763032c68d89003307ceec8ab46b4 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -367,9 +367,7 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb)
 
 	root = &q->fq_root[hash_ptr(sk, q->fq_trees_log)];
 
-	if (q->flows >= (2U << q->fq_trees_log) &&
-	    q->inactive_flows > q->flows/2)
-		fq_gc(q, root, sk);
+	fq_gc(q, root, sk);
 
 	p = &root->rb_node;
 	parent = NULL;
-- 
2.42.0.459.ge4e396fd5e-goog


