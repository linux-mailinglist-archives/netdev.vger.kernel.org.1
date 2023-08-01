Return-Path: <netdev+bounces-23163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BD276B370
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D6E280E49
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0672150D;
	Tue,  1 Aug 2023 11:38:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B222150B
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:28 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B35C1B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:27 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d3583d0efso38381156d6.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889906; x=1691494706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lcubvgp2h2A7YrGcdAvcz8shDpuHOnRDCsGQOHEkabM=;
        b=e9CVijgvlDel7QC86UPIcz8ZvXugWJsCV/XCSIatUpU7ByT9YlwQZ3L28Y179Q9dvw
         y/Wkk9jSOq5KrJgmsjCs9/QqB4lm6m/niBznM8lkUwD2czEK3yB/QmrFUC0hvLHTew7r
         XAZ/vmEc9tT4GsA8f/Ac8rw6leECnf7m5bmgMtNmElDkMpoxolzEwnZmSbvZUPSMPsKB
         zto8TeFrdUGVlcXI3lVgmrO6nVisxE3/3FMvtDZ1K7nopl6pjatNnTyA1NtzYfSia48j
         6rI/pFkvzgKnG9IoF+85jvkshRzGCKNKd1X7ElEfD3dR9vcSIu24hm+mHfr7YNyIQqKC
         JbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889906; x=1691494706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lcubvgp2h2A7YrGcdAvcz8shDpuHOnRDCsGQOHEkabM=;
        b=H5GUWJYx9pdVyAxbCQqcetTu248noao+Ofku/KV8MSP4BQLiCuBTweKrSKZKrwROzX
         anIODjBSbqHGV8Eon24ZcYBW3tscKlhx2A2Gh81DRuzO2Tywegkjq+qA7oHkted3dLer
         Tr0KhWLS+hacao96gAK2Y1RcaP0NkD4doZNsuaH5nveLj6HSuRyHr4Co37iAp13l6Nzd
         eef8RTkxkpeZA+WuZBe+G6GjyR8P//XQvxJwPKbvZM5tz22LxWKpW7zMo2RjCKKZFBz0
         OQ6tX2ZoQXAL/ks8Ssg3m38pCb8jRw6YxAESonQfRGRPQbGam/U5o/sJ3hz5cZUnH0wP
         tmcw==
X-Gm-Message-State: ABy/qLZWPIvxkMh7urA5Fqh39/+QL1KgX/CMEaNY6WbbnssjvY/QTwlx
	PToPVtiRMMcV/WeT/qPC7WoNnKzPlmz6JL9+nOuk2w==
X-Google-Smtp-Source: APBJJlEwpCfyRpg4piPPvnMWJN+kb4H60It9OJsSdxL9W/QqglFoMRLVSUCUeFGYUzRNaUBSxd3pnA==
X-Received: by 2002:a0c:eeca:0:b0:63d:657:4cb9 with SMTP id h10-20020a0ceeca000000b0063d06574cb9mr12783371qvs.42.1690889906022;
        Tue, 01 Aug 2023 04:38:26 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:25 -0700 (PDT)
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
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v5 net-next 05/23] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Tue,  1 Aug 2023 07:37:49 -0400
Message-Id: <20230801113807.85473-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801113807.85473-1-jhs@mojatatu.com>
References: <20230801113807.85473-1-jhs@mojatatu.com>
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

For P4TC dynamic actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the dynamic action
information for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 395b68865..b83e058a3 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -116,7 +116,8 @@ struct tc_action_ops {
 		       struct tcf_result *); /* called under RCU BH lock*/
 	int     (*dump)(struct sk_buff *, struct tc_action *, int, int);
 	void	(*cleanup)(struct tc_action *);
-	int     (*lookup)(struct net *net, struct tc_action **a, u32 index);
+	int     (*lookup)(struct net *net, const struct tc_action_ops *ops,
+			  struct tc_action **a, u32 index);
 	int     (*init)(struct net *net, struct nlattr *nla,
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index bb8a00cc1..3ce586331 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -725,7 +725,7 @@ int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


