Return-Path: <netdev+bounces-15548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F23074854D
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 15:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B044281021
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03ADDB3;
	Wed,  5 Jul 2023 13:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8D100B4
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 13:43:57 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FD41719
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 06:43:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6b73b839025so5626661a34.1
        for <netdev@vger.kernel.org>; Wed, 05 Jul 2023 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688564635; x=1691156635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ANUAhFcurjSsn3tEP4sBTjW84lEZQCuYwTyCYWeoN8=;
        b=rQ9JDd5XLbqrBR147PjINFhd/QJMekTwwOtWxgGztmg42iaGIn4fdweIW14lPYH9Nq
         DCAk54S2QYVQWlUQ5MSZ8+aIjDpGaILR6IwZYpYxcnpyMGSI7toe9sWoIDTCdmdgo1PE
         3m9qw8kR5/n0+ETXXcxFbGx9Ncw54TgUOgs6WEF/EMMfOzYVlIIh0Io+kXbBOWXpthfz
         KkrTLZu71qkmNnnjwSh+dsMQt1yH1KXmemKxUpUqbpNOcChZgAmBdkOOD5W8/JdxhamE
         lvTW/SsJy6GYtDg66kuKfc48L2b3R/jAj5iWXBR/bpWnDtohTux5xzhh+03wgkcCWTsH
         kRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688564635; x=1691156635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ANUAhFcurjSsn3tEP4sBTjW84lEZQCuYwTyCYWeoN8=;
        b=Mgvjp86CJebe15TNCvZxMV6q4+Q+Sam/s+nVamw4oz/E7E9hKxAOOCb45/y9TJ9RQp
         XgVGAEyoHlOTMUoYrEAmtkTECH5WXVmd9RvKKURd7jT5jLnsRJE13k4Wg8BnSBZecFB9
         88AwpMiZ0tEpoO0+IJZrTzdLUHjVCTQqd7ag9Vfj6u9Uo7WMNmTQhc4Gg/RdggrnQfG5
         XTEo8EsLpcd71ZNz75cW/Lg3U+2o7rK0bZtCpHeyGAWenJi8zjCDlFfh75VBTR4GaSEk
         xGIMK+yNCsXLyQXh+Ja6nwv4B1hT4G8l6msngiuoE01WL7H0HvezU2ISmFlzL8xFIFKD
         7gxw==
X-Gm-Message-State: AC+VfDxAvtxA2FePn6NcR9Aq+GxxwgE1MXvqToCCg4t20mda3r+XSq2m
	vhhYKAayzif3iRl5Bjo0hoOvYD+InH4laK1RniQ=
X-Google-Smtp-Source: ACHHUZ4T6wa89oqydAuO/8gl4ul7nwnnW96mXM/a8w2hbd/h0FoEe91mbgHMn7nJ7BJg0WJENQvCeQ==
X-Received: by 2002:a9d:7483:0:b0:6b7:4e97:343 with SMTP id t3-20020a9d7483000000b006b74e970343mr16530098otk.27.1688564634964;
        Wed, 05 Jul 2023 06:43:54 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id n11-20020a9d740b000000b006b73b6b738esm4516450otk.36.2023.07.05.06.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 06:43:54 -0700 (PDT)
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
Subject: [PATCH net v2 5/5] net: sched: cls_flower: Undo tcf_bind_filter if fl_set_key fails
Date: Wed,  5 Jul 2023 10:43:29 -0300
Message-Id: <20230705134329.102345-6-victor@mojatatu.com>
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

if TCA_FLOWER_CLASSID is specified in the netlink message, the code will
call tcf_bind_filter. However, if any error occurs after that, the code
should undo this by calling tcf_unbind_filter.

When checking for TCA_FLOWER_CLASSID attribute, the code is calling for
tcf_bind_fitler.

Fixes: 77b9900ef53a ("tc: introduce Flower classifier")
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/cls_flower.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 56065cc5a661..644b0097e6ae 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -2169,7 +2169,7 @@ static int fl_set_parms(struct net *net, struct tcf_proto *tp,
 			struct nlattr *est,
 			struct fl_flow_tmplt *tmplt,
 			u32 flags, u32 fl_flags,
-			struct netlink_ext_ack *extack)
+			bool *bound_to_filter, struct netlink_ext_ack *extack)
 {
 	int err;
 
@@ -2185,18 +2185,20 @@ static int fl_set_parms(struct net *net, struct tcf_proto *tp,
 		tcf_bind_filter(tp, &f->res, base);
 		if (flags & TCA_ACT_FLAGS_NO_RTNL)
 			rtnl_unlock();
+		*bound_to_filter = true;
 	}
 
 	err = fl_set_key(net, tb, &f->key, &mask->key, extack);
 	if (err)
-		return err;
+		goto unbind_filter;
 
 	fl_mask_update_range(mask);
 	fl_set_masked_key(&f->mkey, &f->key, mask);
 
 	if (!fl_mask_fits_tmplt(tmplt, mask)) {
 		NL_SET_ERR_MSG_MOD(extack, "Mask does not fit the template");
-		return -EINVAL;
+		err = -EINVAL;
+		goto unbind_filter;
 	}
 
 	/* Enable tc skb extension if filter matches on data extracted from
@@ -2208,6 +2210,17 @@ static int fl_set_parms(struct net *net, struct tcf_proto *tp,
 	}
 
 	return 0;
+
+unbind_filter:
+	if (*bound_to_filter) {
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_lock();
+		tcf_unbind_filter(tp, &f->res);
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_unlock();
+		*bound_to_filter = false;
+	}
+	return err;
 }
 
 static int fl_ht_insert_unique(struct cls_fl_filter *fnew,
@@ -2241,6 +2254,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 	struct cls_fl_head *head = fl_head_dereference(tp);
 	bool rtnl_held = !(flags & TCA_ACT_FLAGS_NO_RTNL);
 	struct cls_fl_filter *fold = *arg;
+	bool bound_to_filter = false;
 	struct cls_fl_filter *fnew;
 	struct fl_flow_mask *mask;
 	struct nlattr **tb;
@@ -2327,7 +2341,7 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 
 	err = fl_set_parms(net, tp, fnew, mask, base, tb, tca[TCA_RATE],
 			   tp->chain->tmplt_priv, flags, fnew->flags,
-			   extack);
+			   &bound_to_filter, extack);
 	if (err)
 		goto errout_idr;
 
@@ -2425,6 +2439,13 @@ static int fl_change(struct net *net, struct sk_buff *in_skb,
 errout_mask:
 	fl_mask_put(head, fnew->mask);
 errout_idr:
+	if (bound_to_filter) {
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_lock();
+		tcf_unbind_filter(tp, &fnew->res);
+		if (flags & TCA_ACT_FLAGS_NO_RTNL)
+			rtnl_unlock();
+	}
 	if (!fold)
 		idr_remove(&head->handle_idr, fnew->handle);
 	__fl_put(fnew);
-- 
2.25.1


