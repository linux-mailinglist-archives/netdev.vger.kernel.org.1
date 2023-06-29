Return-Path: <netdev+bounces-14523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF80742428
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0FE1C20A19
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E729AC14D;
	Thu, 29 Jun 2023 10:45:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8310961
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:45:55 +0000 (UTC)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DE71FD7
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:55 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-765a7768f1dso57315285a.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035554; x=1690627554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ4RY/IF0/2FGn2l5ILgU9CCqZOHuGvuT5AQ/VhiInE=;
        b=wjcSWfHO8wXcD3+N6SEhrIbQ1bWlvtRmhwI2iC5Cl/vlypXi9jcarAjnYK95b8YFcx
         cDE0sP+PvqF/jy6YvwrCQ0CmguXeLCRtl/1j+ImiFtz4F9ijq74Iz408mK8H83NXdVXq
         hsRiaFEFxoZB2pr9RaR3SBdZwDNFe8eYsHMeSiiUKugos4fEySpONWWQ4w+y4jpebG4s
         Ffy2XR/f9QpeZgxBXaOvMVXLHdd8PVMPYG5ArvH0TvEAewQDGOQ2wRZen7lzuBoJ7N4q
         +bZgfg/CUxfPG8jqRd/dwZn5foP+xcR9xk4IRR1xnORfytWS4/uw8WuGS2mUcliatm5M
         rYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035554; x=1690627554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ4RY/IF0/2FGn2l5ILgU9CCqZOHuGvuT5AQ/VhiInE=;
        b=L42xTLXwXNF4REIwjq+frWtz/WuNE9CbL0J/+i/NNXX98NuIFVONxLEU8XcCGRtAVJ
         t2xgX5sej8cmk6lF5yIeUfCdTmWo9DSyeE7UVzy81NwSlAyta8538Nrw2w1rLT0mnlDh
         laUOyceSFvf0CUuGdQlFIXn5H71jfA3g1H3U4yQbUTx5elyx4E9pwaln9gO/saD7cQEx
         +i/uYxIa2hobaPmUqzaZTT2xm1AiYmch2+IgtFu1Znnel3FqaeymHHqNgfyAXjPIb4oS
         rLgVxk4V8KyFqf+5AZ3RDRSo9lsNrVXnb8G6gFxl5Z5jpR043AIaam96HaG43gIny3q7
         KPRw==
X-Gm-Message-State: AC+VfDw1z1Sy6MtzI0k2e3c8LKchOiAGO+XBA/d3DuySXEdibPYK9Qcc
	Y9lrOdhNhum4rMG+82DrNKNxYzFIbXXvxnSTHDg=
X-Google-Smtp-Source: ACHHUZ4R7hqlTFJNS2KLcubRuRdVg3mCZva1IPqQxkgZDHWN5waAjeO3uPMvRNdjutlr+ecnq+jqCQ==
X-Received: by 2002:a05:6214:e6c:b0:635:abf1:e93e with SMTP id jz12-20020a0562140e6c00b00635abf1e93emr14613744qvb.29.1688035553851;
        Thu, 29 Jun 2023 03:45:53 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:53 -0700 (PDT)
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
Subject: [PATCH RFC v3 net-next 05/21] net/sched: act_api: add struct p4tc_action_ops as a parameter to lookup callback
Date: Thu, 29 Jun 2023 06:45:22 -0400
Message-Id: <20230629104538.40863-6-jhs@mojatatu.com>
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
index c2236274a..19770e8af 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -115,7 +115,8 @@ struct tc_action_ops {
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
index 19d948fd0..42af73eaa 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -728,7 +728,7 @@ int __tcf_idr_search(struct net *net, const struct tc_action_ops *ops,
 	struct tc_action_net *tn = net_generic(net, ops->net_id);
 
 	if (unlikely(ops->lookup))
-		return ops->lookup(net, a, index);
+		return ops->lookup(net, ops, a, index);
 
 	return tcf_idr_search(tn, a, index);
 }
-- 
2.34.1


