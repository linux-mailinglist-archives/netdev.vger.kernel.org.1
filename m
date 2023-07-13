Return-Path: <netdev+bounces-17670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAD9752A22
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270A7281EF5
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407BB1F935;
	Thu, 13 Jul 2023 18:05:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3468E1F922
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:05:34 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2C3271F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:33 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-560b56b638eso618331eaf.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689271532; x=1691863532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWAL230OToaDGGCE5V6CVwFPYGqlRrkHrId/ceZWwhk=;
        b=Iyhh74xlMR9YjZRx/eOZ9ruTbzRet0Z5nT4dsn0xlLx+IJnTA5vVbEbOJEN8Suxbtk
         vsD/hW8XtGPyJh3jwlHD7anxSjfTI6rnwEfVhZFGzOkAieaf2y6bEQmGx0U/4W/dJmdH
         tEAMl8Fz1H1oZmD8U7lOM46BtiStXtSQ11+VW0KmgxUcysmWeLwVuqtI0ysfkHrO1TTp
         w6KypLwHaaSqumSUeYvs4h+STSJEWMiPh3tXBZno6l59CFKvif1J0xh98U7ZpFukqxQx
         bjz/1+U23jOgW4RCqZQ7S2J9QvITO0qjXgflS+7pQ6BbfFFzbk7DapEewoZuhAkEnxPg
         rHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271532; x=1691863532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWAL230OToaDGGCE5V6CVwFPYGqlRrkHrId/ceZWwhk=;
        b=kFGCrv/VpChbxg63N4wnVHSdPxeKyWQ3CQnnXRIhAjYa0yednMvlc1Pf1Wux9I4Xhx
         f4eAyzFPIld7VgqnfeLnkBlosFdFUfg7VjVjGJXWlPtoaiFmsnMbFLF12w3s8xATT//l
         jn0kt4llWOdnyMTV7Oze/h/x1zib+AqS1sxSQpWWHwrgYDWHRVF2PpNAvlerGVDCjhvO
         7ZubaApW61eajFLrwViPQ8VtT8DMcPv2DDvggm8buYhgPvAISd1Oy62BeDva3k9UZICI
         zbiU1DL4+Bd9hFzGTu9nhy04nY+ibwwOZNaPs7/QhSoGAk4/JvsCCWVOouBXG31d5uBI
         AnXg==
X-Gm-Message-State: ABy/qLbkOHwzg8KcLf5CkTECi48LT5Z6oNsDnvP6XH4S4sHwWY2Lsv8u
	kY2ervEN/UvBzc1XvAvgT3zEDJSBEiw3qJnhQiA=
X-Google-Smtp-Source: APBJJlGLcNHUF3BJgfBVPA4H8IhpAfWtcl3sxyd/TnSr/rQ4LmoWR7rNmNTEwQNlgHmQ1Z0yY/eAaQ==
X-Received: by 2002:a4a:e2ce:0:b0:560:bc01:24e2 with SMTP id l14-20020a4ae2ce000000b00560bc0124e2mr338195oot.4.1689271532245;
        Thu, 13 Jul 2023 11:05:32 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id t65-20020a4a5444000000b005660b585a00sm3175299ooa.22.2023.07.13.11.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:05:31 -0700 (PDT)
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
Subject: [PATCH net v5 2/5] net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
Date: Thu, 13 Jul 2023 15:05:11 -0300
Message-Id: <20230713180514.592812-3-victor@mojatatu.com>
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

When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
operation done at u32_set_parms.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 net/sched/cls_u32.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d15d50de7980..ed358466d042 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -712,8 +712,23 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_FLAGS]		= { .type = NLA_U32 },
 };
 
+static void u32_unbind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			      struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID])
+		tcf_unbind_filter(tp, &n->res);
+}
+
+static void u32_bind_filter(struct tcf_proto *tp, struct tc_u_knode *n,
+			    unsigned long base, struct nlattr **tb)
+{
+	if (tb[TCA_U32_CLASSID]) {
+		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
+		tcf_bind_filter(tp, &n->res, base);
+	}
+}
+
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
-			 unsigned long base,
 			 struct tc_u_knode *n, struct nlattr **tb,
 			 struct nlattr *est, u32 flags, u32 fl_flags,
 			 struct netlink_ext_ack *extack)
@@ -760,10 +775,6 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		if (ht_old)
 			ht_old->refcnt--;
 	}
-	if (tb[TCA_U32_CLASSID]) {
-		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
-		tcf_bind_filter(tp, &n->res, base);
-	}
 
 	if (ifindex >= 0)
 		n->ifindex = ifindex;
@@ -903,17 +914,20 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (!new)
 			return -ENOMEM;
 
-		err = u32_set_parms(net, tp, base, new, tb,
-				    tca[TCA_RATE], flags, new->flags,
-				    extack);
+		err = u32_set_parms(net, tp, new, tb, tca[TCA_RATE],
+				    flags, new->flags, extack);
 
 		if (err) {
 			__u32_destroy_key(new);
 			return err;
 		}
 
+		u32_bind_filter(tp, new, base, tb);
+
 		err = u32_replace_hw_knode(tp, new, flags, extack);
 		if (err) {
+			u32_unbind_filter(tp, new, tb);
+
 			__u32_destroy_key(new);
 			return err;
 		}
@@ -1074,15 +1088,18 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	}
 #endif
 
-	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE],
+	err = u32_set_parms(net, tp, n, tb, tca[TCA_RATE],
 			    flags, n->flags, extack);
+
+	u32_bind_filter(tp, n, base, tb);
+
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
 		err = u32_replace_hw_knode(tp, n, flags, extack);
 		if (err)
-			goto errhw;
+			goto errunbind;
 
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
@@ -1100,7 +1117,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return 0;
 	}
 
-errhw:
+errunbind:
+	u32_unbind_filter(tp, n, tb);
+
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
 #endif
-- 
2.25.1


