Return-Path: <netdev+bounces-35246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B017A8213
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B201C20ACB
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1E36AE9;
	Wed, 20 Sep 2023 12:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC6A347BB
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:54:29 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63EEC9
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d85bdcbec9cso486792276.2
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695214467; x=1695819267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NTYYWVZVbxp2Vq2AadFMORSt7LB+tquicmOTfN6YTF4=;
        b=i8VyOtK2YOwxhsS9WLNafqidUuCvCUBn9aHTOX3V+dIrN0QGnX/7M5lSUAWcWthOrx
         WPqYbcMqjGbX5jlMY28uVyBacyZISgNniTb2kSxUxNa4Pzb2WLox0kFTwBXvrF0DGLXa
         cUOirsVjh/8WNbPgPzRebYdRJCbEeIegjUjUDfm2nyJwjUGj8LW5gDH+FlsKhP4xamzD
         TiYnD1YEioXtSsbW7o0eZc6L2UD7+Mz0aIEguXOlKyZbL/BYiYzkfHjs8VGfznPCougl
         zjeuLvRarMgJTzebvVrQ4asqtCbct1ABgNznnims44VQ4SzBplQ4GirPFAoPDfRXGMkC
         35CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214467; x=1695819267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NTYYWVZVbxp2Vq2AadFMORSt7LB+tquicmOTfN6YTF4=;
        b=CDKAScSssz9Z6mna2zN4kMCedBELMQAWk3mczGFfALeUFo/AQe9Fogq+I+NgD93BdS
         Ii585QUVuuw6bFE4yacFKrcZT8Oet/5AxqkY9MwJ5ovNTHoN7zhbnDgBxlsFWMP5ee8l
         WKQHATWiuehAi0e5BLgjrI2eDAL8vyys/51uDclbkirLGGjeh/JV1rNuFS/K0HTEUcqk
         VV/UmAn/SSC7YSUrNJg4nv7zDSWm3uUJxACgHLQVpZoBstoMF9tBAUbuN3CDbCRImoP1
         gnMB3zfFQj1GBEfIxkAqP3W6iROA3mZT5Hl29J0SzDiPfPB0+Rhd6FtNGTdL6hBmLMhy
         p0BQ==
X-Gm-Message-State: AOJu0YwXxaAMp9C0NDYQ0bm9/RnFh16PEw1nEGRfWUdO0d1P31UDozJU
	/EaV0WC7bfjacZr4e0GcUNf4ztYoy7ZHhA==
X-Google-Smtp-Source: AGHT+IEOhXmCWpYY+DvS+Jz0B9A73gdiu9PSmP+MA5Gr1lqoaXk9fRdXuPxEKeBtkgTVOpMwngS4uDPSJ9nELg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:140e:b0:d81:9903:9dec with SMTP
 id z14-20020a056902140e00b00d8199039decmr33453ybu.7.1695214467003; Wed, 20
 Sep 2023 05:54:27 -0700 (PDT)
Date: Wed, 20 Sep 2023 12:54:18 +0000
In-Reply-To: <20230920125418.3675569-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230920125418.3675569-1-edumazet@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230920125418.3675569-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] net_sched: sch_fq: always garbage collect
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
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
index ea510003bc385148397a690c5afd9387fba9796c..0fe2e90af14c2ef822a1455f3c308f0caeb53fe3 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -366,9 +366,7 @@ static struct fq_flow *fq_classify(struct Qdisc *sch, struct sk_buff *skb)
 
 	root = &q->fq_root[hash_ptr(sk, q->fq_trees_log)];
 
-	if (q->flows >= (2U << q->fq_trees_log) &&
-	    q->inactive_flows > q->flows/2)
-		fq_gc(q, root, sk);
+	fq_gc(q, root, sk);
 
 	p = &root->rb_node;
 	parent = NULL;
-- 
2.42.0.459.ge4e396fd5e-goog


