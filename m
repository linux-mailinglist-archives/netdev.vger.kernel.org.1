Return-Path: <netdev+bounces-16291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA3A74C662
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 18:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F42810EF
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC167C8D8;
	Sun,  9 Jul 2023 16:14:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB61E570
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 16:14:07 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A12FD
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 09:14:06 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a3b7f992e7so2556900b6e.2
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 09:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688919245; x=1691511245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROiy2swWI51OFRxPVukylUmtOl8kXv5G8fgZkxcUvKE=;
        b=SgCimg1EJVK1ByVg+YYBaSd315KEcVjY6PHWi7lJoA2GDAfSt0S2pEkP1v4yWBS6NO
         92eN3kpUX2qiVxUfneXVSQNztFkHQNk2GEZYOhfVmJvT247zJtRthqoC4J5z6WsFS6yB
         wFU9b8pTHCYsYFfWs0YWTP7i8+DqaZFE+nJQ4AeoeBurmAt33XSPo1cGA/kr3m0URNem
         vEB+rHkRiNR5u4DjzgRZCqk+NmOB5WubHbS1CWxgTZhQs5+j18m4SvpjXjVzCKE7uoNl
         aY5P5Bt28EDuriM1MGIIty1K7LdLJlid5bxdbluKEPtUdYiAl92N7ihluMTnl1PfDJ/o
         jplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688919245; x=1691511245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROiy2swWI51OFRxPVukylUmtOl8kXv5G8fgZkxcUvKE=;
        b=F0+uaC/gTEXydgiwzz+1QWoyuTISGmRdNQ4a/yaBOvkPJdxDzfxj1dSkDVor8W0YE/
         1t/Hhif5GMCPD0+ryHennljEU/7xV66tuPB/gqqsEHLCYJTYlz08AznrKcgiyJNDzgtf
         LNaTw7RhtZx9zv0GCK4+hZS32TaBY/Onn0CEynFeywedTGS69GfgPJeu1spv8VZ+ZUZ8
         walMgssN54d5aLznQl70v+tu3fJDUl9uSlMV4WvvBo2+6Rk2vqUegNmraER3n8m2BM46
         oSBf9NUHyCaQKAqLeuvoF08Pretbr4PuYyh7hqoCc8z4F5p9kFHdRW3Ahnv55OwgI4eQ
         6WYg==
X-Gm-Message-State: ABy/qLZbq+SLVFc2OoXN9UsfUgKiUuynfrz34v/GXiakOfow8C17TcsD
	rMj31u4N/imrSE451amSdHOnN40gF0m2S2c2AJA=
X-Google-Smtp-Source: APBJJlF1XoOS226218jedMxSdhWRLjPfFo84Oz+S8Fk+zrEia26JhrX0ip2ruMHITg2jSG9Adq53/g==
X-Received: by 2002:aca:110d:0:b0:3a3:7c33:9a0d with SMTP id 13-20020aca110d000000b003a37c339a0dmr8017366oir.48.1688919245747;
        Sun, 09 Jul 2023 09:14:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id w14-20020a056808140e00b003a1efec1a6esm3391617oiv.46.2023.07.09.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 09:14:05 -0700 (PDT)
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
Subject: [PATCH net v3 2/2] net: sched: cls_flower: Undo tcf_bind_filter if fl_set_key fails
Date: Sun,  9 Jul 2023 13:13:50 -0300
Message-Id: <20230709161350.347064-3-victor@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230709161350.347064-1-victor@mojatatu.com>
References: <20230709161350.347064-1-victor@mojatatu.com>
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
index 56065cc5a661..9a40010ccb9f 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2163,53 +2163,6 @@ static bool fl_needs_tc_skb_ext(const struct fl_flow_key *mask)
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
@@ -2241,6 +2194,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	struct cls_fl_head *head = fl_head_dereference(tp);
 	bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
 	struct cls_fl_filter *fold = *arg;
+	bool bound_to_filter = false;
 	struct cls_fl_filter *fnew;
 	struct fl_flow_mask *mask;
 	struct nlattr **tb;
@@ -2325,15 +2279,46 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
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
@@ -2424,6 +2409,16 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
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


