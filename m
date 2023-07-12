Return-Path: <netdev+bounces-17312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105475127A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133CB1C2105B
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D4AEAF1;
	Wed, 12 Jul 2023 21:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC44F9C7
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:14:18 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB2C2D66
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:50 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b711c3ad1fso6158017a34.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689196423; x=1691788423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15knOmL3tWtvgoG9fedUyxn9UCvXhpGf0W+V6tVwy4A=;
        b=W5p3CAZb1UFDzXi2Vrh+TID/3QPef7nlZiJ+0j2AkTQI/HKXWuukn3oSjwVp8C2poa
         pACXTCYcdEpYxHHyHh+vNIYCIvtWZJZFKM0yh+pwuFOf3mCpEcRiXnYTJxgICjcFJTPK
         F/WJakQai1uaxCiCub4/Q0sAzk278y0WsyVg6RdIJ6vhm5hglz58hc52e5TArlUwUgfq
         XdkCaaMpRLCnfblw7QqSUnxHvWZ1LVG3vx379tUaboedRHNnhZRW/L8Akl4h8AUjWfqc
         GXc6vQxHgyQJSvRrC9V50n4I4cJWOsbGR1pfBbgguZYKTBYUPIxS5qFQrZbsqNVMiP1/
         yaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689196423; x=1691788423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15knOmL3tWtvgoG9fedUyxn9UCvXhpGf0W+V6tVwy4A=;
        b=Ic4rZEncYaEmXn5VpUQPn7QjSytPQZMFtbt/AZcOGEDEWGF3W6Yc6rozRUKDncL/db
         O1wBYses0s4X2L0QdPl8hnHQRSirFswmPAm5wqp/1wIG/xlnYEBwHmH85x0I+4tFeUX/
         k7tpAUqh7nfoMKaw5ZdzjWfciHfffV2Sf1qOkteOHOMCcVBUn/u89+N4jA1/Rem/Zdf3
         8Xm6Qlv2aIDY0eV0QPCFT1j5UOT8LBxhTuxPAUmjEaMbvNNHFtQW3PYvVrpbV169GMKP
         yK6gJQQnX1NYpT6gGVri96drgrBMiRghFeKOP4yJF19wAWCjrxbJomxfVC2YIREnBWhT
         Tacg==
X-Gm-Message-State: ABy/qLZRj0LTHaYl9zt4LL+PzSiMj60cZ474prk/Y0eSx5J/cFsOUowh
	d1XiS8okkw2J8hOgFT3zrvuA9ZNebLTGcYyh8ZQ=
X-Google-Smtp-Source: APBJJlGJNCicoIGy9PSgzdGA/F3nYeYKjrR69+gkWBKgJUL8hwySyuNI7GW6EOlFxvJZibLnaWp4mA==
X-Received: by 2002:a05:6870:c086:b0:1b6:a4e2:a284 with SMTP id c6-20020a056870c08600b001b6a4e2a284mr12976564oad.49.1689196423691;
        Wed, 12 Jul 2023 14:13:43 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id zh27-20020a0568716b9b00b001a663e49523sm2387213oab.36.2023.07.12.14.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 14:13:43 -0700 (PDT)
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
Subject: [PATCH net-next v4 5/5] net: sched: cls_flower: Undo tcf_bind_filter in case of an error
Date: Wed, 12 Jul 2023 18:13:13 -0300
Message-Id: <20230712211313.545268-6-victor@mojatatu.com>
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If TCA_FLOWER_CLASSID is specified in the netlink message, the code will
call tcf_bind_filter. However, if any error occurs after that, the code
should undo this by calling tcf_unbind_filter.

Fixes: 77b9900ef53a ("tc: introduce Flower classifier")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/cls_flower.c | 99 ++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 52 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index f2b0bc4142fe..8da9d039d964 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2173,53 +2173,6 @@ static bool fl_needs_tc_skb_ext(const struct fl_flow_key *mask)
 	return mask->meta.l2_miss;
 }
 
-static int fl_set_parms(struct net *net, struct tcf_proto *tp,
-			struct cls_fl_filter *f, struct fl_flow_mask *mask,
-			unsigned long base, struct nlattr **tb,
-			struct nlattr *est,
-			struct fl_flow_tmplt *tmplt,
-			u32 flags, u32 fl_flags,
-			struct netlink_ext_ack *extack)
-{
-	int err;
-
-	err = tcf_exts_validate_ex(net, tp, tb, est, &f->exts, flags,
-				   fl_flags, extack);
-	if (err < 0)
-		return err;
-
-	if (tb[TCA_FLOWER_CLASSID]) {
-		f->res.classid = nla_get_u32(tb[TCA_FLOWER_CLASSID]);
-		if (flags & TCA_ACT_FLAGS_NO_RTNL)
-			rtnl_lock();
-		tcf_bind_filter(tp, &f->res, base);
-		if (flags & TCA_ACT_FLAGS_NO_RTNL)
-			rtnl_unlock();
-	}
-
-	err = fl_set_key(net, tb, &f->key, &mask->key, extack);
-	if (err)
-		return err;
-
-	fl_mask_update_range(mask);
-	fl_set_masked_key(&f->mkey, &f->key, mask);
-
-	if (!fl_mask_fits_tmplt(tmplt, mask)) {
-		NL_SET_ERR_MSG_MOD(extack, "Mask does not fit the template");
-		return -EINVAL;
-	}
-
-	/* Enable tc skb extension if filter matches on data extracted from
-	 * this extension.
-	 */
-	if (fl_needs_tc_skb_ext(&mask->key)) {
-		f->needs_tc_skb_ext = 1;
-		tc_skb_ext_tc_enable();
-	}
-
-	return 0;
-}
-
 static int fl_ht_insert_unique(struct cls_fl_filter *fnew,
 			       struct cls_fl_filter *fold,
 			       bool *in_ht)
@@ -2251,6 +2204,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	struct cls_fl_head *head = fl_head_dereference(tp);
 	bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
 	struct cls_fl_filter *fold = *arg;
+	bool bound_to_filter = false;
 	struct cls_fl_filter *fnew;
 	struct fl_flow_mask *mask;
 	struct nlattr **tb;
@@ -2335,15 +2289,46 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	if (err < 0)
 		goto errout_idr;
 
-	err = fl_set_parms(net, tp, fnew, mask, base, tb, tca[TCA_RATE],
-			   tp->chain->tmplt_priv, flags, fnew->flags,
-			   extack);
-	if (err)
+	err = tcf_exts_validate_ex(net, tp, tb, tca[TCA_RATE],
+				   &fnew->exts, flags, fnew->flags,
+				   extack);
+	if (err < 0)
 		goto errout_idr;
 
+	if (tb[TCA_FLOWER_CLASSID]) {
+		fnew->res.classid = nla_get_u32(tb[TCA_FLOWER_CLASSID]);
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_lock();
+		tcf_bind_filter(tp, &fnew->res, base);
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_unlock();
+		bound_to_filter = true;
+	}
+
+	err = fl_set_key(net, tb, &fnew->key, &mask->key, extack);
+	if (err)
+		goto unbind_filter;
+
+	fl_mask_update_range(mask);
+	fl_set_masked_key(&fnew->mkey, &fnew->key, mask);
+
+	if (!fl_mask_fits_tmplt(tp->chain->tmplt_priv, mask)) {
+		NL_SET_ERR_MSG_MOD(extack, "Mask does not fit the template");
+		err = -EINVAL;
+		goto unbind_filter;
+	}
+
+	/* Enable tc skb extension if filter matches on data extracted from
+	 * this extension.
+	 */
+	if (fl_needs_tc_skb_ext(&mask->key)) {
+		fnew->needs_tc_skb_ext = 1;
+		tc_skb_ext_tc_enable();
+	}
+
 	err = fl_check_assign_mask(head, fnew, fold, mask);
 	if (err)
-		goto errout_idr;
+		goto unbind_filter;
 
 	err = fl_ht_insert_unique(fnew, fold, &in_ht);
 	if (err)
@@ -2434,6 +2419,16 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 				       fnew->mask->filter_ht_params);
 errout_mask:
 	fl_mask_put(head, fnew->mask);
+
+unbind_filter:
+	if (bound_to_filter) {
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_lock();
+		tcf_unbind_filter(tp, &fnew->res);
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_unlock();
+	}
+
 errout_idr:
 	if (!fold)
 		idr_remove(&head->handle_idr, fnew->handle);
-- 
2.25.1


