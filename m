Return-Path: <netdev+bounces-15546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A98A748549
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDBB1C20B4D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DCFD2FC;
	Wed,  5 Jul 2023 13:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243D7D512
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:43:51 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68CDBA
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 06:43:49 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-56584266c41so4596725eaf.2
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688564629; x=1691156629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCpSn7+3UdgcAnJYuktsHdgb0SDtmYa6u50lebB6KmE=;
        b=pu8EmGdXAwxavII1YFtmnO9/5nXSGj07VFNww2DcTvAr2T4X/o2rJl5ccwLCZrPNnK
         GnfUoWnHLi0/LHrzPo/ydXZC0YVAt/sC4q+atEbIrEi9zlLbBDLco+VLo/tyARf3iuGz
         YUANjcfF6UhI5/9TuVXS+hYHl880I/LNiC+7ykIwYtFX8bLXj1EV2PQi8FA3BwjppTvY
         xDMLIRqw0COcA4LKnkV1broG31aUoVQJmXSAI/MbnejnYRYY/We7f/n1QyM62opUENSn
         Q5sXe3jA2pSmlepli8ZwoQE8ITrvTchtdpw9ibg72YKBpt/2hhTj4ol7MfMqPWJKrabs
         qDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564629; x=1691156629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sCpSn7+3UdgcAnJYuktsHdgb0SDtmYa6u50lebB6KmE=;
        b=C/MTyH63lXXCbfeh1SBdzYtbvffxLXLtve13oGuYH3r3SYL9CRwyqB5pdWMTOrtHhJ
         K/Gprs6XJvDDFSbw/lHTIS7MMfrjEDualM7SuOH6quS9t9FcjhVYRknK+236Z53pZRBF
         hWW5KEKedDyCfRxDFzTjnFG6J+tFynz4RSyePohQd75xN5H+RxCSC1Kr1IO6YgAfjEQ+
         9tpIKj9A1MDQmMZOFVdA636X332tpTOIq74DONGHqliUCZQ/GY1iAWiEHgE9SnT2VzIa
         vFnWAKFbZq+uvxHLZ/LGZqlW1WAyR/GP7JIQx4mqlm4S5hDO9vpXQMfdbZcfo/Xq/wbC
         P9xw==
X-Gm-Message-State: AC+VfDwCEZPY/f0rnob3sC5WB/DTShneD4RpjDVLpgzXCeYzak+3T1ew
	lMjA9oESQlxC7rBaeLumCNp5m9lt1DSSFHaacMk=
X-Google-Smtp-Source: ACHHUZ650/JhBqV0ZGWHRo6LvE/60nZScvh0HczP4tcMm+bhN8wkg58MR6EexSZsEtGd+20AqPvdng==
X-Received: by 2002:a4a:1d81:0:b0:565:c862:ad77 with SMTP id 123-20020a4a1d81000000b00565c862ad77mr11797016oog.5.1688564628913;
        Wed, 05 Jul 2023 06:43:48 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d740b000000b006b73b6b738esm4516450otk.36.2023.07.05.06.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:43:48 -0700 (PDT)
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
Subject: [PATCH net v2 3/5] net: sched: cls_u32: Undo tcf_bind_filter if u32_replace_hw_knode
Date: Wed,  5 Jul 2023 10:43:27 -0300
Message-Id: <20230705134329.102345-4-victor@mojatatu.com>
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

When u32_replace_hw_knode fails, we need to undo the tcf_bind_filter
operation done at u32_set_parms.

Fixes: d34e3e181395 ("net: cls_u32: Add support for skip-sw flag to tc u32 classifier.")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_u32.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index d15d50de7980..7e32c018941f 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -712,11 +712,13 @@ static const struct nla_policy u32_policy[TCA_U32_MAX + 1] = {
 	[TCA_U32_FLAGS]		= { .type = NLA_U32 },
 };
 
+#define U32_SET_FLAGS_BOUND 0x1
+
 static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 			 unsigned long base,
 			 struct tc_u_knode *n, struct nlattr **tb,
 			 struct nlattr *est, u32 flags, u32 fl_flags,
-			 struct netlink_ext_ack *extack)
+			 u8 *set_flags, struct netlink_ext_ack *extack)
 {
 	int err, ifindex = -1;
 
@@ -763,6 +765,7 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 	if (tb[TCA_U32_CLASSID]) {
 		n->res.classid = nla_get_u32(tb[TCA_U32_CLASSID]);
 		tcf_bind_filter(tp, &n->res, base);
+		*set_flags |= U32_SET_FLAGS_BOUND;
 	}
 
 	if (ifindex >= 0)
@@ -859,6 +862,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_U32_MAX + 1];
 	u32 htid, userflags = 0;
+	u8 set_flags = 0;
 	size_t sel_size;
 	int err;
 
@@ -905,7 +909,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 		err = u32_set_parms(net, tp, base, new, tb,
 				    tca[TCA_RATE], flags, new->flags,
-				    extack);
+				    &set_flags, extack);
 
 		if (err) {
 			__u32_destroy_key(new);
@@ -914,6 +918,9 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 		err = u32_replace_hw_knode(tp, new, flags, extack);
 		if (err) {
+			if (set_flags & U32_SET_FLAGS_BOUND)
+				tcf_unbind_filter(tp, &new->res);
+
 			__u32_destroy_key(new);
 			return err;
 		}
@@ -1075,14 +1082,14 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 #endif
 
 	err = u32_set_parms(net, tp, base, n, tb, tca[TCA_RATE],
-			    flags, n->flags, extack);
+			    flags, n->flags, &set_flags, extack);
 	if (err == 0) {
 		struct tc_u_knode __rcu **ins;
 		struct tc_u_knode *pins;
 
 		err = u32_replace_hw_knode(tp, n, flags, extack);
 		if (err)
-			goto errhw;
+			goto errunbind;
 
 		if (!tc_in_hw(n->flags))
 			n->flags |= TCA_CLS_FLAGS_NOT_IN_HW;
@@ -1100,7 +1107,10 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		return 0;
 	}
 
-errhw:
+errunbind:
+	if (set_flags & U32_SET_FLAGS_BOUND)
+		tcf_unbind_filter(tp, &n->res);
+
 #ifdef CONFIG_CLS_U32_MARK
 	free_percpu(n->pcpu_success);
 #endif
-- 
2.25.1


