Return-Path: <netdev+bounces-41220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9357CA443
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BA3B20E07
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97A91CFAD;
	Mon, 16 Oct 2023 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="cyHnu8vW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41EE1CA8E
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:06 +0000 (UTC)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF03B4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:05 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-66d0760cd20so36464046d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448964; x=1698053764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q2ukdnUomainY9G3Wv1+NuTe9h0v1yf8Rc8FT6OWMTo=;
        b=cyHnu8vWcj+WAi5tQAd9zO6d3PFpo1pXpVfQXuEnveNtC+u4haKw2nQNeWGqSKYV8+
         uWpiTldcibPtjdPCNYaZ2/W3s2rLnxPtqasHSe8u+cl9idGJxrUEFP1LAzifQb5RLHek
         UvoF1yfumQcZyMUBCFNcJzsmfnCkzMSvtmcQ0L4ATPvJibkYhRQq6o6pAAXrfcv9UgYp
         uIVP0N4ObEHvPByPGlWfI5+veZnkuE2zJ8ZI/34WWDzW69Lb9KtP6Uelvz5SMxEFCXXz
         D1faiXqvw8c8S2TkbJNkOIyb8nW3Yw+Enbir7QTbnKH13+mdlvzq+5zyuFYap1yVZ8/V
         8Glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448964; x=1698053764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2ukdnUomainY9G3Wv1+NuTe9h0v1yf8Rc8FT6OWMTo=;
        b=noDW1w8GYsuQvWYGhhE+5vl1BcjotD+HFS7sRnL+cVEbBKnlXmXV2eS6o2Vp9W89Sk
         0B5kEv6gvHwVuq4mFn6/x5OBGtyVpghCG9nq1amo8SLPjZTmATvm/7WzYMP8P8ttA3he
         imwKgI2VcH2kA1tPmMVPTtA2QyO6Ky805jbpwQBW4eqdQODRli/dz4SQchEYmYG7UALB
         +xMHOhsX5qtR7J2QE9U9UTkZN4KHFtZFCbThXkB4Y/InPSE3yVh6vVjy48pb/CcWrhuX
         3ZIdI/2GFFfXei6KcmN/qjgq/yJY0gRog0mP0aSv+GxxJebq+Jrg6SLLg5mxxZFb23mm
         NATQ==
X-Gm-Message-State: AOJu0YxOmhkcirxX7mybGtbZt2fNwBbslF2fHpGS0HlqGolNJuEmMFeX
	8ZqncDyb+odduVuHac4hoQ3AI7nQiHg4J2yzTsA=
X-Google-Smtp-Source: AGHT+IHimqf4w9hLaTaep60/oIw5coVQLBxi2icWcMmCx2If61VpNn8bAszrFKKdLLK2I54HMF917w==
X-Received: by 2002:a05:6214:2d07:b0:66d:2ce2:8651 with SMTP id mz7-20020a0562142d0700b0066d2ce28651mr9449567qvb.0.1697448964105;
        Mon, 16 Oct 2023 02:36:04 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:36:03 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	horms@kernel.org,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH v7 net-next 04/18] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Mon, 16 Oct 2023 05:35:35 -0400
Message-Id: <20231016093549.181952-5-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016093549.181952-1-jhs@mojatatu.com>
References: <20231016093549.181952-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

For P4TC dynamic actions, we require information from struct tc_action_ops,
specifically the action kind, to find and locate the dynamic action
information for the lookup operation.

Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h | 3 ++-
 net/sched/act_api.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 1fdf502a5..90e215f10 100644
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
index f0ec70b42..cfa74f521 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -726,7 +726,7 @@ static int __tcf_idr_search(struct net *net,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


