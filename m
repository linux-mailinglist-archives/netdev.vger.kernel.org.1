Return-Path: <netdev+bounces-15545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B89748547
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D226B1C2081C
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FDD30E;
	Wed,  5 Jul 2023 13:43:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E29D512
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:43:47 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA29F
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 06:43:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6b708b97418so5623338a34.3
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 06:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688564626; x=1691156626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fjr0w0lmzf3UreyTHM2WtjDff/EVI1BV+jgJEeWJ1w=;
        b=xtfacyj/Prrnk/S5mDSHOFRDKZSBj5Xm1Vl5i8MUGD2/jmke7irz66PYNE+BKi1ImK
         3ZrUJZdx2XAmy8u8p5EKNyMW0SSOqR7oq9b4KBcENwQbn4SiFSn8qL6dtGWcyLzHGLd2
         IASaHsI+hnJdkFhguWaAWIMc1oNIXvfSCIyyfrB6f4PY3EbfeaJj6QFRiEx4kKq67NQP
         EnK5FedrwPk0JtBdMch0TjxHdfTMIyIiPNARKW6Mvub5rZPbIgDFWVDIZXQPcfprHcp5
         dvEQtcuwGdZ3Y8MjFPPalJd80J9Ml5HSsY6lJaVaOVU3ygMkxiaWNwAhCG/E/GHvF+Jj
         f1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564626; x=1691156626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fjr0w0lmzf3UreyTHM2WtjDff/EVI1BV+jgJEeWJ1w=;
        b=LH1A1d/zm1L5802JQbx9G93Vlm+JtUFGfg4bmQz0535pzBM7si1TOTQgjc3QcG55mh
         +RCEOyMZwg2/B+8bjrWrs302gSdWRtI6O5nLu/TViNZ4pfrVfufvKf8hg64KpBRaCBKz
         1j+jxJv9QytcP+O5Fp2rjnl3Dz9ys5LW3kNGZ0VKaxDtvcDunHwgWU4t9mtVN0oO4vZc
         zVkUpeu29tNw2IFBxLUuJFKPgaAXrQS2nKbgXbaOURO3dc6c7K5iEhFoBigAiSZBalN0
         qYL2K8Mv1fHyy+1ihHjgNldrq206rrMb8/jIivtrYzR9uHKGTGrB8PajYQhyUr4UcBOk
         /77g==
X-Gm-Message-State: AC+VfDzLh50GPUHhvIwWZuPIMQKUk7Jg3+NNgjrz0OR+qZ9WAXZ727vv
	ruhVAREebUpFwDEca6Pc2/Giy/ay1l8vyNdl8SU=
X-Google-Smtp-Source: ACHHUZ7Sp/nUppM/Jd5E/TeArpzJVEZE2SiURvRHvQkp/PoQ736bLN1QyhFSsRcO4O9cITJjtVy8gQ==
X-Received: by 2002:a9d:7483:0:b0:6b7:4e97:343 with SMTP id t3-20020a9d7483000000b006b74e970343mr16529756otk.27.1688564625872;
        Wed, 05 Jul 2023 06:43:45 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d740b000000b006b73b6b738esm4516450otk.36.2023.07.05.06.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:43:45 -0700 (PDT)
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
Subject: [PATCH net v2 2/5] net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
Date: Wed,  5 Jul 2023 10:43:26 -0300
Message-Id: <20230705134329.102345-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230705134329.102345-1-victor@mojatatu.com>
References: <20230705134329.102345-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In case an error occurred after mall_set_parms executed successfully, we
must undo the tcf_bind_filter call it issues.

Fix that by calling tcf_unbind_filter in err_replace_hw_filter label.

Fixes: ec2507d2a306 ("net/sched: cls_matchall: Fix error path")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_matchall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sched/cls_matchall.c b/net/sched/cls_matchall.c
index fa3bbd187eb9..e4b649669835 100644
--- a/net/sched/cls_matchall.c
+++ b/net/sched/cls_matchall.c
@@ -163,7 +163,7 @@ static int mall_set_parms(struct net *net, struct tcf_proto *tp,
 			  struct cls_mall_head *head,
 			  unsigned long base, struct nlattr **tb,
 			  struct nlattr *est, u32 flags, u32 fl_flags,
-			  struct netlink_ext_ack *extack)
+			  bool *bound_to_filter, struct netlink_ext_ack *extack)
 {
 	int err;
 
@@ -175,6 +175,7 @@ static int mall_set_parms(struct net *net, struct tcf_proto *tp,
 	if (tb[TCA_MATCHALL_CLASSID]) {
 		head->res.classid = nla_get_u32(tb[TCA_MATCHALL_CLASSID]);
 		tcf_bind_filter(tp, &head->res, base);
+		*bound_to_filter = true;
 	}
 	return 0;
 }
@@ -187,6 +188,7 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 {
 	struct cls_mall_head *head = rtnl_dereference(tp->root);
 	struct nlattr *tb[TCA_MATCHALL_MAX + 1];
+	bool bound_to_filter = false;
 	struct cls_mall_head *new;
 	u32 userflags = 0;
 	int err;
@@ -227,7 +229,7 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	}
 
 	err = mall_set_parms(net, tp, new, base, tb, tca[TCA_RATE],
-			     flags, new->flags, extack);
+			     flags, new->flags, &bound_to_filter, extack);
 	if (err)
 		goto err_set_parms;
 
@@ -246,6 +248,8 @@ static int mall_change(struct net *net, struct sk_buff *in_skb,
 	return 0;
 
 err_replace_hw_filter:
+	if (bound_to_filter)
+		tcf_unbind_filter(tp, &new->res);
 err_set_parms:
 	free_percpu(new->pf);
 err_alloc_percpu:
-- 
2.25.1


