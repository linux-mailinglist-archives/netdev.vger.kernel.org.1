Return-Path: <netdev+bounces-23161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F7B76B36A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F9A28194F
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F27214F6;
	Tue,  1 Aug 2023 11:38:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4C046A0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:25 +0000 (UTC)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE24E6F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:24 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4866be648ffso2062339e0c.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889903; x=1691494703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTGYH7qyBlXp4Oj5yJOHzxaKUHfsesbXuk6VUwVP3pI=;
        b=g9Gk9Rx6Hg4CkmY9aO9uWGnRK2/lNbV5SI5ywXxtfkjdDfj8FTvqFn+aeAEGNpVh/l
         4oc4X+W2dwkwrBbK8O646zhShByXNEIJvOcdoAp5gE178koh8rdxoMJ76fmOKpifkTzq
         9BIdGLiRicDfuxPl/Ew6/PirLuF3xIQdoNUirwwIJ0LLU/uvaHo1Sf35sL/QOzPip5LL
         LNzzI1Gdt/DE20gLHhNfX6ebpQTFxL2beF2dWGdLgr8yZ87OM/B/NpbiLew6WlYCcsIu
         ZKT6WqPliE+WWk2AyMKHMrC0/BmUjs3tuKCXUzq9NYRivywyAsEVSpDqOCTnh+dg64YJ
         RfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889903; x=1691494703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTGYH7qyBlXp4Oj5yJOHzxaKUHfsesbXuk6VUwVP3pI=;
        b=gmAn/sUkWY3qvqssh0qY/im9cJ1jBvwDtgPBvx7LC70+xZMJDgPLsJvssB30I8ye3T
         /pBGOAO4gxMHbnR5snt+NG415nq2p6mJ+Vvrk+OlJHywQ2bkpSxMNwP/lF1MJF5miHPT
         Fs1zcsoojzRJFoQJsrvz/sQ8rmkvHEtZvwfDSQOhMDaYPVWwdL49WGWGDIesZW0y9uyd
         /G85hd7EeQ3MalypSwkhLJeJ78ScRITtJtbLdbsTvbF2r+Gxt2ZT2STVRsVKcmKmDP8C
         +P9lupoprEcQ+ywpW41y3J0clpq0+HCBJA/qMf6RlGAaJJ5HtN3sesftVGMby4aOMe5z
         XGfw==
X-Gm-Message-State: ABy/qLYaPaM3cEZMOJdPKk0YkwFf4oy9IumS1eX4ROpjfTp9bQAIP+AT
	gt0W7PMNZ5YsI3hzSDKWFjYTF3SwTk6FYmdM1weRfw==
X-Google-Smtp-Source: APBJJlHxuVxXjr4I16xbIlhAMbyoaUYbC9BrGp7nxmoW1ds8ufAMleyzBKDc64Tw60YQ14wUU04LDg==
X-Received: by 2002:a1f:5581:0:b0:486:3e05:da14 with SMTP id j123-20020a1f5581000000b004863e05da14mr1952673vkb.12.1690889902836;
        Tue, 01 Aug 2023 04:38:22 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:22 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 03/23] net/sched: act_api: Update tc_action_ops to account for dynamic actions
Date: Tue,  1 Aug 2023 07:37:47 -0400
Message-Id: <20230801113807.85473-4-jhs@mojatatu.com>
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
index b38a7029a..1fdf502a5 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -109,6 +109,7 @@ struct tc_action_ops {
 	char    kind[ACTNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
+	refcount_t dyn_ref;
 	size_t	size;
 	struct module		*owner;
 	int     (*act)(struct sk_buff *, const struct tc_action *,
@@ -120,6 +121,11 @@ struct tc_action_ops {
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
index a8cb71f05..c868ec0ea 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -1023,7 +1023,7 @@ int tcf_register_action(struct tc_action_ops *act,
 	struct tc_action_ops *a;
 	int ret;
 
-	if (!act->act || !act->dump || !act->init)
+	if (!act->act || !act->dump || (!act->init && !act->init_ops))
 		return -EINVAL;
 
 	/* We have to register pernet ops before making the action ops visible,
@@ -1484,8 +1484,16 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
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


