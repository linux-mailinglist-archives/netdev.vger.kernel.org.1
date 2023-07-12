Return-Path: <netdev+bounces-17199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F16C2750CC6
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8468E281543
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B73524195;
	Wed, 12 Jul 2023 15:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69224160
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:09 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A621BF2
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:05 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-403713e7344so50471071cf.2
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176404; x=1691768404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLEqBZv0yHse70T+YIr7i1j8Cjw/hXFYuk3GhrKwMuY=;
        b=1qgZnea37YItGGZjIlhQNi8B0rGgrIkheiq116Bc4Fndv6RJZ9wC27ikq+uzfQ8FgM
         ZnVzJR+Gt3t9iOLMr+ReLFKRP7jxwSvTj5uxACWP2Pclj6OehahlHHA/LkkZj8D423R5
         WGO4RFV1aDziUWvaNjk+5j1mbmpM8YVizwPNRZ5OPrI/2nWpIgiAjUchf/9l5mhjzCjp
         OWR+U04bNz1tU4UWKgDsCSmWynZcQtBNyQCnHtPqHJOo3i4MBN8fDcD3uqVz4BVHNzVI
         17DFhhu/c8o1Sh/PC1gpvJe82/f6npan2Mq2Es/mgMwEOSZvEs70YF44nJS2UZBiycc5
         Xz/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176404; x=1691768404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLEqBZv0yHse70T+YIr7i1j8Cjw/hXFYuk3GhrKwMuY=;
        b=YM2w6PECB4flc6ZRLk8Ye0s+w1WJDOA1+vAjNDO1sebeGBLUaDsbHb2IT8q6LCvdI/
         I3o9ZnfzMIc2oWq0+HIK0kfb7P8lZy268+wX3/W+3cz3nfL4M5UNUSnzsm5BXCXk4Zce
         ob+Lrflx4ZdvjOuxQWTzpJrwNWCMOHNWitiLvPd90AAx1CNUIrwsESxawu3KTj3OLhxH
         IxCRSeTX9HmjnHBFWkMoWOXIg6UYvsbipxxfvTFhXtJ+nKfMgTyMMHIW6cclqnS95JzJ
         vvRiX4xA15erfdjGsrZsmBJe06z5aHBwVCjCD6PU5IURIcnmGAhcO5ujWxNvjoQIJIJZ
         h9ZA==
X-Gm-Message-State: ABy/qLYUHVNJD7py/xQywGiIoLvFniiM+PFnfDYoZAOwYK3nUH69xrda
	zjbC3aCikqXNjKuN1citxc3kbuFQarxyhMplkNv0zg==
X-Google-Smtp-Source: APBJJlFVtjhlp1IWg01Mcb4FQVunj8XvLjxMt1QbSdyYVShW3Q/uSxMkGeCfS2ysDnPnETY3zN4r3w==
X-Received: by 2002:a0c:8d8a:0:b0:636:b0b5:3198 with SMTP id t10-20020a0c8d8a000000b00636b0b53198mr16522615qvb.50.1689176404214;
        Wed, 12 Jul 2023 08:40:04 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:03 -0700 (PDT)
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
Subject: [PATCH RFC v4 net-next 03/22] net/sched: act_api: add init_ops to struct tc_action_op
Date: Wed, 12 Jul 2023 11:39:30 -0400
Message-Id: <20230712153949.6894-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
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

The initialisation of P4TC action instances require access to a struct p4tc_act
(which appears in later patches) to help us to retrieve information like the
dynamic action parameters etc. In order to retrieve struct p4tc_act we need the
pipeline name or id and the action name or id. Also recall that P4TC
action IDs are dynamic and  are net namespace specific. The init callback from
tc_action_ops parameters had no way of supplying us that information. To solve
this issue, we decided to create a new tc_action_ops callback (init_ops), that
provides us with the tc_action_ops struct which then provides us with the
pipeline and action name. In addition we add a new refcount to struct
tc_action_ops called dyn_ref, which accounts for how many action instances we
have of a specific dynamic action.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h |  6 ++++++
 net/sched/act_api.c   | 14 +++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index a414c0f94..363f7f8b5 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -108,6 +108,7 @@ struct tc_action_ops {
 	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
+	refcount_t dyn_ref;
 	size_t	size;
 	struct module		*owner;
 	int     (*act)(struct sk_buff *, const struct tc_action *,
@@ -119,6 +120,11 @@ struct tc_action_ops {
 			struct nlattr *est, struct tc_action **act,
 			struct tcf_proto *tp,
 			u32 flags, struct netlink_ext_ack *extack);
+	/* This should be merged with the original init action */
+	int     (*init_ops)(struct net *net, struct nlattr *nla,
+			    struct nlattr *est, struct tc_action **act,
+			   struct tcf_proto *tp, struct tc_action_ops *ops,
+			   u32 flags, struct netlink_ext_ack *extack);
 	int     (*walk)(struct net *, struct sk_buff *,
 			struct netlink_callback *, int,
 			const struct tc_action_ops *,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 420cf2617..6749f8d94 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1007,7 +1007,7 @@ int tcf_register_action(struct tc_action_ops *act,
 	struct tc_action_ops *a;
 	int ret;
 
-	if (!act->act || !act->dump || !act->init)
+	if (!act->act || !act->dump || (!act->init && !act->init_ops))
 		return -EINVAL;
 
 	/* We have to register pernet ops before making the action ops visible,
@@ -1495,8 +1495,16 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 			}
 		}
 
-		err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
-				userflags.value | flags, extack);
+		/* When we arrive here we guarantee that a_o->init or
+		 * a_o->init_ops exist.
+		 */
+		if (a_o->init)
+			err = a_o->init(net, tb[TCA_ACT_OPTIONS], est, &a, tp,
+					userflags.value | flags, extack);
+		else
+			err = a_o->init_ops(net, tb[TCA_ACT_OPTIONS], est, &a,
+					    tp, a_o, userflags.value | flags,
+					    extack);
 	} else {
 		err = a_o->init(net, nla, est, &a, tp, userflags.value | flags,
 				extack);
-- 
2.34.1


