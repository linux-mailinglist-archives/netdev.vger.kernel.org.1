Return-Path: <netdev+bounces-17308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA7751271
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDDE2817AA
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297ACEAF6;
	Wed, 12 Jul 2023 21:13:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795FEAF4
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:13:58 +0000 (UTC)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FE2D41
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:33 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-56368c40e8eso87647eaf.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689196410; x=1691788410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WpNe/o38FaCW/2lGi21/dT2D8N/Nbav3INnvayo378=;
        b=3aXKMwPEVpG7VDAwPZMfiFVtzdutaGueS6mtbWTN+IC9OSqKvFTD45zaNtUqU0jmeQ
         8Ird2Bxl1qQiKlPjtFm9+UQBZ0FPJ5vaNhBAq5Ic9v+C2liNNTUB2xtgrQQWnVtZ7LZm
         ApXhwhebefZYstznl4SBWXxklcKrPQmHPthD7m0oWbw8XxqUMg5Q8nGT8DSMA5V0y7g8
         oJYmgEE1Fy0CWbvainyYGxcEaIlcKYA9C95a0+gBDcRv+3b5sAfYhc+Welgrlfp27Mfr
         o8UfhQhUjTgEn9Tir9u5Y1nPzOjO2fnLVtia9TwdsAT9L0j3OyifFDmLKofW5kgF7GdB
         pTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196410; x=1691788410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WpNe/o38FaCW/2lGi21/dT2D8N/Nbav3INnvayo378=;
        b=ID4rYDg8PZYM5QDbAllC6Jyri6DBE9sAzWMXKrszEt1AFuNsAwCM/W5kzvZF2n7DQw
         OtwTDQQ3OahXqscaUXLvw4CVFeKt65KLNISJ5xoCNxSHwe7P4B0Bzzm01zFOtxbNUV1O
         Ibze9zyzjNwv2KsOPPzRO/jqT0++CmImLwfOfpeppNQ/gFkAXYJvAlFWmOlANRyb5mDn
         PikkvIR+BSbwrgt4bQxPGn+3oyWv61npZJH8eO9ptdLTssnQeeGVGdfSa5WdXtGj8FSs
         BmNYyccsHum6p2zL6G8fJhDItyvf/j1Hl3GpaRzFaxvnzTJRUrtanXYcB1XVm1L8v5VU
         rocg==
X-Gm-Message-State: ABy/qLYG7nC013fgHjsM+pcuGC8KPSgxiGr4dTmqMgWnJQJGnI73NCqh
	+CN9MEZNreqDQFrGueygGRGfmdqdDMpF5kpUISk=
X-Google-Smtp-Source: APBJJlHgkWrfc1ZnNWeBVlVCsWop6OgVJ7iJ1mCItx3lmJoduty97bFbYbM8J6d/KW3IEJhGFAvvhQ==
X-Received: by 2002:a05:6870:c224:b0:1b3:8c06:c9d7 with SMTP id z36-20020a056870c22400b001b38c06c9d7mr20427183oae.10.1689196410474;
        Wed, 12 Jul 2023 14:13:30 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001a663e49523sm2387213oab.36.2023.07.12.14.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:13:30 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pctammela@mojatatu.com,
	simon.horman@corigine.com,
	kernel@mojatatu.com
Subject: [PATCH net-next v4 1/5] net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
Date: Wed, 12 Jul 2023 18:13:09 -0300
Message-Id: <20230712211313.545268-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230712211313.545268-1-victor@mojatatu.com>
References: <20230712211313.545268-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In case an error occurred after mall_set_parms executed successfully, we
must undo the tcf_bind_filter call it issues.

Fix that by calling tcf_unbind_filter in err_replace_hw_filter label.

Fixes: ec2507d2a306 ("net/sched: cls_matchall: Fix error path")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_matchall.c | 35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index fa3bbd187eb9..c4ed11df6254 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -159,26 +159,6 @@ static const struct nla_policy mall_policy[TCA_MATCHALL_MAX + 1] = {
 	[TCA_MATCHALL_FLAGS]		= { .type = NLA_U32 },
 };
 
-static int mall_set_parms(struct net *net, struct tcf_proto *tp,
-			  struct cls_mall_head *head,
-			  unsigned long base, struct nlattr **tb,
-			  struct nlattr *est, u32 flags, u32 fl_flags,
-			  struct netlink_ext_ack *extack)
-{
-	int err;
-
-	err = tcf_exts_validate_ex(net, tp, tb, est, &head->exts, flags,
-				   fl_flags, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_MATCHALL_CLASSID]) {
-		head->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
-		tcf_bind_filter(tp, &head->res, base);
-	}
-	return 0;
-}
-
 static int mall_change(struct net *net, struct sk_buff *in_skb,
 		       struct tcf_proto *tp, unsigned long base,
 		       u32 handle, struct nlattr **tca,
@@ -187,6 +167,7 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 {
 	struct cls_mall_head *head = rtnl_dereference(tp->root);
 	struct nlattr *tb[TCA_MATCHALL_MAX + 1];
+	bool bound_to_filter = false;
 	struct cls_mall_head *new;
 	u32 userflags = 0;
 	int err;
@@ -226,11 +207,17 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 		goto err_alloc_percpu;
 	}
 
-	err = mall_set_parms(net, tp, new, base, tb, tca[TCA_RATE],
-			     flags, new->flags, extack);
-	if (err)
+	err = tcf_exts_validate_ex(net, tp, tb, tca[TCA_RATE],
+				   &new->exts, flags, new->flags, extack);
+	if (err < 0)
 		goto err_set_parms;
 
+	if (tb[TCA_MATCHALL_CLASSID]) {
+		new->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
+		tcf_bind_filter(tp, &new->res, base);
+		bound_to_filter = true;
+	}
+
 	if (!tc_skip_hw(new->flags)) {
 		err = mall_replace_hw_filter(tp, new, (unsigned long)new,
 					     extack);
@@ -246,6 +233,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 err_replace_hw_filter:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &new->res);
 err_set_parms:
 	free_percpu(new->pf);
 err_alloc_percpu:
-- 
2.25.1


