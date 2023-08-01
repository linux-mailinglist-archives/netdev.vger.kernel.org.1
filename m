Return-Path: <netdev+bounces-23164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4B376B374
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AF82810F1
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42162150C;
	Tue,  1 Aug 2023 11:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F4E20FB4
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:29 +0000 (UTC)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC65F1B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:28 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-63d09d886a3so38710566d6.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889907; x=1691494707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipZDLdA3pxeEaWJR7HGpFjoZ0xWBpJ/IjSjFORk3qBs=;
        b=mgRGbzPwPfF9Rn4LwBVKw+GJXFnZqFtjrJpJJPLEoF4CDgXIY+5IWPRzoz/ywutUO4
         3b4ygaGTF8eDOTA189ip+X4iY7df114dvxrLZ0QHUCscosTpO/rNuDP7L7yI/JyKOP3K
         XZy97lAKcSE/hv5zav1KysW6YTxvY2FpYvUa8RAVMJoO28Vd8jkJk2j0zJo47NxB0fvQ
         fz0Cz9GiRrmOP5I6R6BFabahZeO4gJ71MzuBm0rr4Z1s9INRawJmTi4wjtj/V7q14uIz
         C+hAeYu/ONtVAse9dSmxg4+MOd59WMoq0niDi1kX5VjEuhXUr3VkGuasbugJC3XxCm/h
         Nimg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889907; x=1691494707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipZDLdA3pxeEaWJR7HGpFjoZ0xWBpJ/IjSjFORk3qBs=;
        b=PW3yZo4AVGnXG8fDEo/T7KfpvWZDapfJVtH6Jyey8ELa+DGMCEc7tUsoaPrYlnjbwt
         Uum6S+Q3piQoLDYWUFO9Qbg8xLBHLD6wvConksl8YgPJMi7ezsSBBns8B3w0v0UxEmY+
         he1mNMAQdDWB8Yel2gFyxzz71Xi0reTU90O5R9CSD5/7URMn01u+3rsoFgw1tPkjddNA
         YtQUMQcZBcqpTd3O81TYs6+unWr5xeqcUmqyGUvHidj1vXDDL/KONI1JRDTkGoEpG1i+
         pAfH/l0kHKvrZZ+cgEkNruYlFZH4nI2tJ9SN2PV5/wkd+Jqblebx1AiXFAGQJR/5eOT4
         Yp0A==
X-Gm-Message-State: ABy/qLbmVTf3hRyONOSPTMZrwKHAf1EZY9Jmh1KFYw/s8zAoKB7RHX09
	6x5LhmdffoYIG+0DeV5TWHcEc/nkYpTw+eIJ3p/FbA==
X-Google-Smtp-Source: APBJJlH3AdK8HnWYtqat2eY0B4qP8URsXBkIjwy9MdbH5O2+pZxjUMNnejy1K4Z0haV3t4bZvV3CvA==
X-Received: by 2002:a0c:e3d4:0:b0:63d:7aa8:b59f with SMTP id e20-20020a0ce3d4000000b0063d7aa8b59fmr3034521qvl.7.1690889907444;
        Tue, 01 Aug 2023 04:38:27 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:26 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 06/23] net: sched: act_api: Add support for preallocated dynamic action instances
Date: Tue,  1 Aug 2023 07:37:50 -0400
Message-Id: <20230801113807.85473-7-jhs@mojatatu.com>
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

In P4, actions are assumed to pre exist and have an upper bound number of
instances.

Add the necessary code to preallocate actions instances for dynamic actions.

We add 2 new actions flags:
- TCA_ACT_FLAGS_PREALLOC: Which tells if the actions instance was
  preallocated.
- TCA_ACT_FLAGS_UNUSED: Which tells if the actions instance was
  preallocated but not used yet.

The rule is that preallocated actions can't be deleted by the tc actions
runtime commands and a dump or a get will only show preallocated actions
instances which are being used (TCA_ACT_FLAGS_UNUSED == false).

The preallocated actions will be deleted once the dynamic action kind to
which they belong to is deleted.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h |  3 +++
 net/sched/act_api.c   | 46 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index b83e058a3..a6331cc5d 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -68,6 +68,8 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_PREALLOC	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
+#define TCA_ACT_FLAGS_UNUSED	(1U << (TCA_ACT_FLAGS_USER_BITS + 6))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
@@ -202,6 +204,7 @@ int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
 			      const struct tc_action_ops *ops, int bind,
 			      u32 flags);
 void tcf_idr_insert_many(struct tc_action *actions[]);
+void tcf_idr_insert_n(struct tc_action *actions[], const u32 n);
 void tcf_idr_cleanup(struct tc_action_net *tn, u32 index);
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 			struct tc_action **a, int bind);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 3ce586331..bc9fab75b 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -560,6 +560,8 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 			continue;
 		if (IS_ERR(p))
 			continue;
+		if (p->tcfa_flags & TCA_ACT_FLAGS_UNUSED)
+			continue;
 
 		if (jiffy_since &&
 		    time_after(jiffy_since,
@@ -640,6 +642,9 @@ static int tcf_del_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 	idr_for_each_entry_ul(idr, p, tmp, id) {
 		if (IS_ERR(p))
 			continue;
+		if (p->tcfa_flags & TCA_ACT_FLAGS_PREALLOC)
+			continue;
+
 		ret = tcf_idr_release_unsafe(p);
 		if (ret == ACT_P_DELETED)
 			module_put(ops->owner);
@@ -1367,26 +1372,38 @@ static const struct nla_policy tcf_action_policy[TCA_ACT_MAX + 1] = {
 	[TCA_ACT_HW_STATS]	= NLA_POLICY_BITFIELD32(TCA_ACT_HW_STATS_ANY),
 };
 
+static void tcf_idr_insert_1(struct tc_action *a)
+{
+	struct tcf_idrinfo *idrinfo;
+
+	idrinfo = a->idrinfo;
+	mutex_lock(&idrinfo->lock);
+	/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc if
+	 * it is just created, otherwise this is just a nop.
+	 */
+	idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
+	mutex_unlock(&idrinfo->lock);
+}
+
 void tcf_idr_insert_many(struct tc_action *actions[])
 {
 	int i;
 
 	for (i = 0; i < TCA_ACT_MAX_PRIO; i++) {
-		struct tc_action *a = actions[i];
-		struct tcf_idrinfo *idrinfo;
-
-		if (!a)
+		if (!actions[i])
 			continue;
-		idrinfo = a->idrinfo;
-		mutex_lock(&idrinfo->lock);
-		/* Replace ERR_PTR(-EBUSY) allocated by tcf_idr_check_alloc if
-		 * it is just created, otherwise this is just a nop.
-		 */
-		idr_replace(&idrinfo->action_idr, a, a->tcfa_index);
-		mutex_unlock(&idrinfo->lock);
+		tcf_idr_insert_1(actions[i]);
 	}
 }
 
+void tcf_idr_insert_n(struct tc_action *actions[], const u32 n)
+{
+	int i;
+
+	for (i = 0; i < n; i++)
+		tcf_idr_insert_1(actions[i]);
+}
+
 struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
 					 bool police, bool rtnl_held,
 					 struct netlink_ext_ack *extack)
@@ -2033,6 +2050,13 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 			ret = PTR_ERR(act);
 			goto err;
 		}
+		if (event == RTM_DELACTION &&
+		    act->tcfa_flags & TCA_ACT_FLAGS_PREALLOC) {
+			ret = -EINVAL;
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Unable to delete preallocated action %s\n",
+					   act->ops->kind);
+		}
 		attr_size += tcf_action_fill_size(act);
 		actions[i - 1] = act;
 	}
-- 
2.34.1


