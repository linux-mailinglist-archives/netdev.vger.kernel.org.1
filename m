Return-Path: <netdev+bounces-14525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748C74242A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 778AB1C2098A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9B2111BC;
	Thu, 29 Jun 2023 10:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51411111B1
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:45:56 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522A1FCB
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:53 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6355e774d0aso4454396d6.1
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035552; x=1690627552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLJTf91kf9mBMFKTG4CoNQ02ft7+5tLeK9pmMvMG+Lc=;
        b=gViAHYjqGByZC302QIEO5tpzwomfDbYLCP391dbQkZ64W8X+Z2B9siZvvIxB8lgY87
         SAK9SdYOOVf6IBRpchiuBBDq/Tq1/46poBhj8QQsGwrKrSOQ59VDr8yRDCy30AZ17ZVo
         pvLoz/FvfCOndXf403WTYN3HCo44LbUzzu3ycmTBE8i4tekfF6NyNAAy7BWdEKAmCP6N
         yogVCM+4wuFMmiR7yOTWwLb7kUnrgh6Mt7mya+hck5muDCj9NE9ww6EzTThPwu/hqay0
         Nt0FsHD42bJqYmp7sehNNscWbVLYdaaJHAO6a/kiz7jQg/wHtIUjfjRNU9PjMYyKUUDK
         hMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035552; x=1690627552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLJTf91kf9mBMFKTG4CoNQ02ft7+5tLeK9pmMvMG+Lc=;
        b=LYgMJgQ3nyAgWRtb5JEp/j1kRLG99qbAhXcTodQHujIBwl/qlO6/ZwIStTMI0fkzHg
         yFrzy5WqaO7D5Tv8xfg382YPUukC6g+RX34Ur+AxJA65B8z4wm5mnL477ftN7hRgfBIq
         fMBuBcYEeLjgc5C0BLcvH4QQk2hk7hBxnEzcpKHSDXNkpTyc33+7J8Hzf7NjSkSk/9+u
         n0zQLV5RRJreaQqOIbVTrF87dsd6l/EOKhNk17AsFCIqaKJSCkShklXCqsr5bJQ9kuwI
         Q7Uu9udkVTmpXb4xnISw+R1b+RXuqy5A4MkKrlQM764cw34Cpl1TiyPA4eQb9ahmqfho
         YRtg==
X-Gm-Message-State: AC+VfDxS4U9AlkAvQS1hpcWp5ht193WVk2szM0OOSJXC/ksoNFrWj9k3
	ljGEBEOS7Onmsm4x6MTh8vgAKS5sHjY/yfe4QgY=
X-Google-Smtp-Source: ACHHUZ5Nm3EYR4CS1Zd3YpbdD+sI8gb+5XJx/8hF1U2F/1yDkfSwDb64SxK4E9gSbWNfw5m7lDiOoQ==
X-Received: by 2002:ad4:5aea:0:b0:630:228b:f83d with SMTP id c10-20020ad45aea000000b00630228bf83dmr39807592qvh.44.1688035552603;
        Thu, 29 Jun 2023 03:45:52 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:52 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	kernel@mojatatu.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v3 net-next 04/21] net/sched: act_api: export generic tc action searcher
Date: Thu, 29 Jun 2023 06:45:21 -0400
Message-Id: <20230629104538.40863-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230629104538.40863-1-jhs@mojatatu.com>
References: <20230629104538.40863-1-jhs@mojatatu.com>
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

In P4TC we need to query the tc actions directly in a net namespace.
Therefore export __tcf_idr_search().

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h | 2 ++
 net/sched/act_api.c   | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 363f7f8b5..c2236274a 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -190,6 +190,8 @@ int tcf_generic_walker(struct tc_action_net *tn, struct sk_buff *skb,
 		       const struct tc_action_ops *ops,
 		       struct netlink_ext_ack *extack);
 int tcf_idr_search(struct tc_action_net *tn, struct tc_action **a, u32 index);
+int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
+		     struct tc_action **a, u32 index);
 int tcf_idr_create(struct tc_action_net *tn, u32 index, struct nlattr *est,
 		   struct tc_action **a, const struct tc_action_ops *ops,
 		   int bind, bool cpustats, u32 flags);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 6749f8d94..19d948fd0 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -722,9 +722,8 @@ static int __tcf_generic_walker(struct net *net, struct sk_buff *skb,
 	return tcf_generic_walker(tn, skb, cb, type, ops, extack);
 }
 
-static int __tcf_idr_search(struct net *net,
-			    const struct tc_action_ops *ops,
-			    struct tc_action **a, u32 index)
+int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
+		     struct tc_action **a, u32 index)
 {
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
@@ -733,6 +732,7 @@ static int __tcf_idr_search(struct net *net,
 
 	return tcf_idr_search(tn, a, index);
 }
+EXPORT_SYMBOL(__tcf_idr_search);
 
 static int tcf_idr_delete_index(struct tcf_idrinfo *idrinfo, u32 index)
 {
-- 
2.34.1


