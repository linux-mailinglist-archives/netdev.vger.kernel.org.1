Return-Path: <netdev+bounces-17671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB955752A24
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 20:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58A7B281F0B
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 18:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92BB1F924;
	Thu, 13 Jul 2023 18:05:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09F200B3
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 18:05:37 +0000 (UTC)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676C0271F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:36 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-55e1ae72dceso736011eaf.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689271535; x=1691863535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OfaOeLsHcWm3y96PN9hXO8vYNt4DMjxwC7HGrF/Wk1k=;
        b=EWRp2gMhxH/PWxdwVAdB/hKa2K54IaT1apyX3lekEmTxlZgK0CeI4Da4vu/+KxJsx7
         YrruB238xt0/F5KZCYmzquszy4fW6/xTK72EGv/o0qAWlRi7I6RAsCK91xnhLolIsmCf
         jeFQTu/8ZXK1475ICectKjJ0RFxNI4VJJqtsGK7ZtoYOe309eGd43hJSZ8RTZml2jIAJ
         Hv3I30mAAyrGV+8B/972AH/v8y6O6nIGehlVGtXvGbX5AMHbDH9RcRX7R2LXtKH3/p+/
         VMART1msJKQzDvWp4ubUIaSgdZKly9lix4dlvlJmA47G+va+iB82ZDhyb65cijpYbsG1
         T0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271535; x=1691863535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OfaOeLsHcWm3y96PN9hXO8vYNt4DMjxwC7HGrF/Wk1k=;
        b=SoIAXm6IJ8duoQqO9qEeKUW5ts8SyQ/g77a5Qxj9jecjIqZgekkB1xZf0VGq+oUiHO
         A388AOo+t4Sh9Bd9rKSDjOTQH1WeQBSvC+04TGWU5puXElMon3gS1hU4U7dbN61L2faI
         D4pEG0o7NO4VulheZ6fEqhB7i+EEur2WfhYYMdhxDcxCGVcsCa2E42XWL+kyNuCmIBYM
         zKxcYM/qHqVlnEibjPQDQWYlJOcisGWHanAzRNK0yq/+QF8yhQW6iV/xpbZfEHKANm0r
         RWgiJcFu6ZgpHF30xU4o7pk3LD2htaReySBFWnNM94mnx13kL3aMgtdPJ5mW/vuGaow6
         Jmgg==
X-Gm-Message-State: ABy/qLZa/dc7dCmofnZz1PUGtnKiu0QIwDasAaCSB4zT/p4i2FETZ7Zu
	mQT+kY6UAV3/Cr2N5VxtR7Z6eGy4ssq8u5iUojw=
X-Google-Smtp-Source: APBJJlGPoWiuO3hRHsG9TCxkDD/IPFvC0+EHJ9dcpVOznssv59V4HfAyT/aA5hGGTdYCb440u3OoOA==
X-Received: by 2002:a4a:840c:0:b0:566:fafc:ce47 with SMTP id l12-20020a4a840c000000b00566fafcce47mr1967106oog.8.1689271535556;
        Thu, 13 Jul 2023 11:05:35 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c1:1622:34af:d3bb:8e9a:95c5])
        by smtp.gmail.com with ESMTPSA id t65-20020a4a5444000000b005660b585a00sm3175299ooa.22.2023.07.13.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 11:05:35 -0700 (PDT)
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
Subject: [PATCH net v5 3/5] net: sched: cls_u32: Undo refcount decrement in case update failed
Date: Thu, 13 Jul 2023 15:05:12 -0300
Message-Id: <20230713180514.592812-4-victor@mojatatu.com>
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
Reviewed-by: Simon Horman <simon.horman@corigine.com>
---
 net/sched/cls_u32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index ed358466d042..5abf31e432ca 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -928,6 +928,13 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 		if (err) {
 			u32_unbind_filter(tp, new, tb);
 
+			if (tb[TCA_U32_LINK]) {
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


