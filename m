Return-Path: <netdev+bounces-15394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51110747519
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF006280F68
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BE63D9;
	Tue,  4 Jul 2023 15:15:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633D6FA8
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:15:19 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48510CF
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:15:18 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b5d1498670so4525902a34.1
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688483718; x=1691075718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa92uouHaP//RU+Bd2IOoGN0WdyRO3Fdk5xN14EG3dg=;
        b=PzQTotYi6914jcILhN+vcsXZE7ZKsHCtWmqhdx8ET5M6piwyLnVURlbnYs4gQScs0C
         2VrAdMjdAQBqizBEC7WdKzqRitSdCQjXobFsrD/xkfMxAME6csznAWXQhj3EFthPBxrW
         zQR/rFUJjzzFR8ifLoITW/mcsVwDWH9X0S7PZevTST7Yvuy5xLFC99pVyi275StSS6LF
         7zGng+dVp2LJQtbKAnpivqzWYMLv7N/FhjoXqTHO638UGxfTiX9PzQhoT6sQ1b5Sy24p
         hpdphjgxd0DyJCCjzdmNsSjX2Ol90KGtP1O3uFMAMWiQjQuFQf92bfTJr9FTfweVsfCQ
         p+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483718; x=1691075718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fa92uouHaP//RU+Bd2IOoGN0WdyRO3Fdk5xN14EG3dg=;
        b=iyUhlDnRbDX55q6YPjxLNUGRbsafMb148qF9A75NOkDEA/zF9hfsgNz5KAR1WSjPkL
         NbFEhypZhtVyLX7ibQauhT/qzHOzHTjJhXukkhpVYXQH0dJ6icH/hsjSfkQ0tPOnNW41
         one4J7lxba2wN81VuzquVHxEqF2QpxHPKhggseMih+JTxRaRYgSF1ZLzcY+YkNLQRc9f
         gLFZoirS98gsuvjRqMsRahW3GQ/D0LAcnjJf8Ux1gtoDRXzhJwnXjy0oyOMCptYYzyzs
         f9mHtIOhqJ6gcCS4YqYodawHOV2ewmdvWEqZn1cxu39DcGJBBhtXebEY+BYL526osqwg
         QNLw==
X-Gm-Message-State: AC+VfDyTmoBZvyHUJ3JspQa/wdnCcg2ryft9WOvff48izMnNcl2/3bCS
	rZ/N4CL10FNJBlnJSPMza8PN/E500NW/IAH7csI=
X-Google-Smtp-Source: ACHHUZ6i54qfWfc5B/trVlvTWsSzDWnkC7IJ3SQU62Zg6SWgae5SM2rs8mDQWLDgO45/FP1+ppQLBA==
X-Received: by 2002:a05:6830:1315:b0:6b8:8c15:5249 with SMTP id p21-20020a056830131500b006b88c155249mr12099790otq.24.1688483718108;
        Tue, 04 Jul 2023 08:15:18 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id s1-20020a9d7581000000b006b8abc7a738sm3946146otk.69.2023.07.04.08.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:15:17 -0700 (PDT)
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
	kernel@mojatatu.com
Subject: [PATCH net 4/5] net: sched: cls_u32: Undo refcount decrement in case update failed
Date: Tue,  4 Jul 2023 12:14:55 -0300
Message-Id: <20230704151456.52334-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704151456.52334-1-victor@mojatatu.com>
References: <20230704151456.52334-1-victor@mojatatu.com>
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

In the case of an update, when TCA_U32_LINK is set, u32_set_parms will
decrement the refcount of the ht_down (struct tc_u_hnode) pointer
present in the older u32 filter which we are replacing. However, if
u32_replace_hw_knode errors out, the update command fails and that
ht_down pointer continues decremented. To fix that, when
u32_replace_hw_knode fails, check if ht_down's refcount was decremented
and undo the decrement.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_u32.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index e193db39bee2..5dc401e4baa6 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -713,6 +713,7 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 };
 
 #define U32_SET_FLAGS_BOUND 0x1
+#define U32_SET_FLAGS_DECR_HTDOWN 0x2
 
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 unsigned long base,
@@ -759,8 +760,10 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 		ht_old = rtnl_dereference(n->ht_down);
 		rcu_assign_pointer(n->ht_down, ht_down);
 
-		if (ht_old)
+		if (ht_old) {
+			*set_flags |= U32_SET_FLAGS_DECR_HTDOWN;
 			ht_old->refcnt--;
+		}
 	}
 	if (tb[TCA_U32_CLASSID]) {
 		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
@@ -921,6 +924,13 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 			if (set_flags & U32_SET_FLAGS_BOUND)
 				tcf_unbind_filter(tp, &new->res);
 
+			if (set_flags & U32_SET_FLAGS_DECR_HTDOWN) {
+				struct tc_u_hnode *ht_old;
+
+				ht_old = rtnl_dereference(n->ht_down);
+				if (ht_old)
+					ht_old->refcnt++;
+			}
 			__u32_destroy_key(new);
 			return err;
 		}
-- 
2.25.1


