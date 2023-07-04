Return-Path: <netdev+bounces-15395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B0974751A
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 17:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DE11C20A78
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 15:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71A6AA1;
	Tue,  4 Jul 2023 15:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FCB6FA8
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 15:15:23 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B8210CF
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 08:15:22 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-19a427d7b57so3804407fac.2
        for <netdev@vger.kernel.org>; Tue, 04 Jul 2023 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688483721; x=1691075721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AufVbI+LN53/9t1CzZTIXtKk+s0F8FuozdcaUzNd83U=;
        b=t/JbsdRVOLNUkUNVeeYr5S7zTNMWiYtz/dEMIe6fD2fdof2FOSWNnfYuKJechqdoIb
         qBml2Yjb32ghB2EkUNzZAsY/9ETjhhiPWXRZFhipFHbBi1KI33/saNpYOommhPr5Vlke
         sAinyQlGGfSoIKlVD2p01js4l+W+a5s5d2i7lMQSBX0PkRN/F7wpU+29Xe2Ss3MRLxlB
         mMfbjhhp3bCVDbHFwOayuaDGJuJzSdxgmpjisXxPjEjgPpx/Pp2/XxRrrbjC/pOLSu1P
         51/A4qRLjVvZvZgsNOHlLm+0dBeOK9fCvJZWiCMuQgKMwqO+ndroFGcfBo7op09k6j2b
         7L7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688483721; x=1691075721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AufVbI+LN53/9t1CzZTIXtKk+s0F8FuozdcaUzNd83U=;
        b=U9KHOYMrMHgjA0kq1CcYpbbjhAavTFTGvBdptv6kBpDBYdCCaZL0lNAVnpPyKOZR68
         scAcs0ohH5YQYOJfwANoxxi0gFXgyE5cnui1s8XekZ1hmfFZnrcv+wzwsVthiapG6kK6
         wn8WpfQK74ZMkvOpRMy4ft5wMMfBHLC9+CYxVe2ssmjBmLw8OVLFl8LuargwS1BnWMqA
         4R6+RTU9uUTMNwBkNcspzZbBxnscQtjKIvnjOCh1QIuUlwEejWR+kMBcrswadmQKjbd1
         jR1pGFoQCCsdjwWczkSdZFwdkPCv7DyrQkCXvR5jUFHSZzH8N6iaRhQTrC9UvfYicZnc
         YCHQ==
X-Gm-Message-State: ABy/qLb/uicAPOTqLqEbSsWitTKATUUUgzh9oCkLURm531QIB6xX9Iit
	2JfNelL2/fjpcluzjImn3PkcCl8syn3zPlVapCE=
X-Google-Smtp-Source: APBJJlEfY0rU536f5gzWl03zNiWikZ1mP4EPbP94IL7y7hzKg0YeiM8mP69BMZCxTi3RX1u3mlOPmA==
X-Received: by 2002:a05:6871:84c7:b0:1b0:454b:1c3d with SMTP id sw7-20020a05687184c700b001b0454b1c3dmr10083409oab.36.1688483721151;
        Tue, 04 Jul 2023 08:15:21 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c0:f126:5457:8acf:73e7:5bf2])
        by smtp.gmail.com with ESMTPSA id s1-20020a9d7581000000b006b8abc7a738sm3946146otk.69.2023.07.04.08.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 08:15:20 -0700 (PDT)
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
Subject: [PATCH net 5/5] net: sched: cls_flower: Undo tcf_bind_filter if fl_set_key fails
Date: Tue,  4 Jul 2023 12:14:56 -0300
Message-Id: <20230704151456.52334-6-victor@mojatatu.com>
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

if TCA_FLOWER_CLASSID is specified in the netlink message, the code will
call tcf_bind_filter. However, if any error occurs after that, the code
should undo this by calling tcf_unbind_filter.

When checking for TCA_FLOWER_CLASSID attribute, the code is calling for
tcf_bind_fitler.

Fixes: 77b9900ef53a ("tc: introduce Flower classifier")

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
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


