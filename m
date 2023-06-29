Return-Path: <netdev+bounces-14524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3654742429
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FB0A280DA9
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849B10976;
	Thu, 29 Jun 2023 10:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C91096A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:45:55 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911181FC1
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:52 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-635ed0114ecso4503216d6.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035551; x=1690627551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZaIidRj1ypHQBGnNOE0L2CTpwTQfJWuaAbBPz+11U9I=;
        b=E2msZnimXUswlAzaAapuQcVVEfMq1+H8WYfDzYwnBwblv1nBqnRshnG2nOOCTgOp0A
         XGY6S4sMJaiMKzYY57bYRrH7hFGjfN79CLPJ8WRM8+DyHVinK8PMhFMgY/LTJjE7NQBv
         nwOwp98JN3QRE1UA6buSDq8yqrSV2mGgtChbPqghg+x5/ElTDjGM2bzxUWyFmD0LsNDD
         S5svBVV0RsCi64+Ic4NaixPeSnAuDKmLwu2H1q3JP1MlGPsrnZRRDzTfq3poNDLJYRwU
         n1ZPKe71WyVDQ7AU8xnBdM7Q8Uuxk+vXig8ApjwNo3MoKuPd0WF2SdjUB3njjf6SumIL
         y3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035551; x=1690627551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZaIidRj1ypHQBGnNOE0L2CTpwTQfJWuaAbBPz+11U9I=;
        b=cfowcMIAWNsokmR0uIdhyPIOZIk8vucH3bfBiRcU9vVHPnORaPFbRq3+KY0eyLe6er
         xEfy6xgt45KgnBmSvULhRmKVxSthqTnimInNNsLn8Oe+lVkUb0C3QxOzZqJ4j3lckRHk
         DizaR6RJmt0vN4j8YHzQU+PV8R7oC0XVvIcUIEbXpQcCx/BDED4PD4qgCrfTHnbfRWQ0
         ScX+RQQnE+qKheGKoBpaIP9ck5RImmfmouYiRNrPjczYuqxOdrOVRXpc7YHGsccJR5cu
         2wuF7d31xyF1gW1RUZ/i2TFGkSIqzEE74YLPDGLUpQaP76I0QBCEAx7KLfRJQ9TD0jGm
         zcFw==
X-Gm-Message-State: AC+VfDyZ6k4in4z/+OeFCu2PdLuYte8ln5+jDsVjAYX4+Mh9+Mt+FtVK
	qi5Exs6qjfdsEBV/gbAurgKKL3BzjzrGupPD52I=
X-Google-Smtp-Source: ACHHUZ6e4bYn655iG+DvZoc85uxGAJd/yG8b0nixkno1KFTm5bzIbNKimepLxU1IfwA60yYgC8lwvQ==
X-Received: by 2002:ad4:5c4a:0:b0:635:f48d:5b7a with SMTP id a10-20020ad45c4a000000b00635f48d5b7amr8663906qva.23.1688035551248;
        Thu, 29 Jun 2023 03:45:51 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:50 -0700 (PDT)
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
Subject: [PATCH RFC v3 net-next 03/21] net/sched: act_api: add init_ops to struct tc_action_op
Date: Thu, 29 Jun 2023 06:45:20 -0400
Message-Id: <20230629104538.40863-4-jhs@mojatatu.com>
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

The initialisation of P4TC action instances require access to a struct p4tc_act
(which appears in later patches) to help us to retrieve information like the
dynamic action parameters etc. In order to retrieve struct p4tc_act we need the
pipeline name and the action name. Also recall that P4TC action IDs are dynamic
and  are net namespace specific. The init callback from tc_action_ops parameters
had no way of supplying us that information. To solve this issue, we decided to
create a new tc_action_ops callback (init_ops), that provides us with the
tc_action_ops struct which then provides us with the pipeline and action name.
In addition we add a new refcount to struct tc_action_ops called dyn_ref, which
accounts for how many action instances we have of a specific dynamic action.

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


