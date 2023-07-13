Return-Path: <netdev+bounces-17669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FCE752A21
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B351281ED0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B31F1F92D;
	Thu, 13 Jul 2023 18:05:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B41F92B
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:05:30 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96300271F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:29 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1b3f281c4e1so843755fac.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689271529; x=1691863529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq7JLWSnO4kLsX66Bz5Lma1zemUZ3rsSNZ/srgBkgmo=;
        b=eP43kPRLRepvAZpcqoPrfIqUTZPZ/uSRp9gXi/Eu9I/owN6iS8AwVMslZ/sA8J7dvz
         KOOHsamX5w6cefZW0WIyRQqTlAcWBBAqvqGLW06TYJnnJMSbwBGA71ACZ4oZCoO2dINP
         Cv51168XhccDOHZ1p519MBD0EmTSiWgOBhMrRIA+LBbI9Pl01Iqh+sckRnM8mBMtHvcD
         znHVfZLxZTNNflUWoQMAiKV3EsYzi/QEfZQdgcRY8FkI5fxzc9QnpJ8dLHNxGRzwlolt
         s4csTUmcmD9RHbQqi2fXbpPT7ZBWuftfUsALMy7AC4RNGVIWuf+3eP2/sMWC2+0gxXgd
         5eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271529; x=1691863529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lq7JLWSnO4kLsX66Bz5Lma1zemUZ3rsSNZ/srgBkgmo=;
        b=Z4Fk+Z1PbN9Eiee8WnguQM/h9dEyTVp1K30A2YyEfczjkZuf4g0l+0JM1Hyd/WfKBE
         VtbI6r9LwnUiNb9CWsEglarxXsS2Ixb5gtvebANWW19j/as6IHtcY4c6LyhebQo0pFXy
         rHyDKggfrmrZ5QVWtZcw3mHZoT2EkvXXMMestvZtAYOrfKIvj/DCZGxUjXFVcN4wF5VP
         UJQ5uzWu0I1Y6ByKCESvh6CMF8IaurBvNCVFs8kWwVQnQWmxmApVM7zEjQsU+qyeftS9
         nKiqoc6B56vkAAAIerg1XZ8aGeaxbLaZn/G6ZjgY778gZKR9sTcB5DIqQTlBRETuh2hW
         sdHA==
X-Gm-Message-State: ABy/qLZn12UKHwJ/dlX2mWiupOpAEXiV80kb65v0ExqT1NVoc4bXfqaz
	Fe9Y6W+UCdtOYunTXC58VgcMHkISGEXdKbkBN8E=
X-Google-Smtp-Source: APBJJlHqPYmQT0owseusIcsbSt2onEJjvTiOujWi/StbjLxQMUC8//o0xBUMCQiMDeafM1IbYDMDDQ==
X-Received: by 2002:a05:6871:20f:b0:1b0:5fc0:e2b5 with SMTP id t15-20020a056871020f00b001b05fc0e2b5mr3013677oad.53.1689271528800;
        Thu, 13 Jul 2023 11:05:28 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id t65-20020a4a5444000000b005660b585a00sm3175299ooa.22.2023.07.13.11.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:05:28 -0700 (PDT)
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
Subject: [PATCH net v5 1/5] net: sched: cls_matchall: Undo tcf_bind_filter in case of failure after mall_set_parms
Date: Thu, 13 Jul 2023 15:05:10 -0300
Message-Id: <20230713180514.592812-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230713180514.592812-1-victor@mojatatu.com>
References: <20230713180514.592812-1-victor@mojatatu.com>
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
Reviewed-by: Simon Horman <simon.horman@corigine.com>
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


