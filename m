Return-Path: <netdev+bounces-37168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151F47B40F3
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 16:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 17B5A1C2099E
	for <lists+netdev@lfdr.de>; Sat, 30 Sep 2023 14:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5433EBE71;
	Sat, 30 Sep 2023 14:36:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB10156E6
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 14:36:03 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2A8100
	for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:00 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-4528cba7892so7221334137.0
        for <netdev@vger.kernel.org>; Sat, 30 Sep 2023 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1696084559; x=1696689359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMT7GpYY5wKVo9A9jnqGQCAThU2ktlVPWLpYbBTG3l0=;
        b=2tFBWYcntoGeXkbuUq+zjttQUMgRYR/aOsWPrVv7nmQuOzIxJvCbExOKbwZtKtUGLY
         WNEpbaf8sPeqedwT5W+nEbZ4mbY9pHJlU6wIVk88oouTIvPdgBZWORGgfSsX0N+znMKF
         ni4p8Lri0zvi/d2eEdJq7LVuPMr1QJVmPxfFQYz16e+76LR4lvKEMxpMwaUPcpBSWF1v
         0a7Ud8EBTBCGoMGOOyZXdXJB9FDVBKaQlDc0r6EdtzliC8q3IlXHuzez/K0gNxQmVIJv
         onjy2NYq2+Iyg3326Wf41d1oN1m9hibkbOKYzoC3Fh+RtQI5OVUJpXC0XrbUoBhlYwje
         /XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084559; x=1696689359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMT7GpYY5wKVo9A9jnqGQCAThU2ktlVPWLpYbBTG3l0=;
        b=v5H8Ug+GCOUCre06tiBcWge715+82OdKYZR+AJSSlKVyJRFF43zdAGGDK+iH8Oo1nc
         vZ8+162w+tJ5NuLRxemPc9Y053u04ZBh+ToBRwROfDKIW9JRHdzNYeepkxH7YSCYgttZ
         wZNV5zPymaBQG2jhrKIIK49SCAcaqA4fMYT3aciRNkh/8A/LMgKZy2AiWW6DPKCXYeNp
         27+Fulnw1yhtjDt+CWNFHqA/9x8phlnqO+pYMqQvPmHxQ05C/zOoQB2UdaKvcX7zW08x
         ewoG9mm20yjUAsbw+w6YLl8ZcruLqF0TWuXx0PDwQn+GHa006fUdtL8ZZ64DoTkT/9/5
         2iSg==
X-Gm-Message-State: AOJu0YwMoJWV0vDJVIk3ITOrS0w74CDsfWQZtsEfOWnM4EsIi4M5hDw2
	DsGWPAy630qSln7xQQIliXOpGyITjba1156z22g=
X-Google-Smtp-Source: AGHT+IGBER2PBO7IdIycsoi1wr8kXjehiRUiJ6Ymsv97/z5LkWkA9jQnR/6ny6RjrlAbk2kK6/kicg==
X-Received: by 2002:a05:6102:109:b0:452:5a95:16a with SMTP id z9-20020a056102010900b004525a95016amr6482433vsq.1.1696084559033;
        Sat, 30 Sep 2023 07:35:59 -0700 (PDT)
Received: from majuu.waya ([174.93.66.252])
        by smtp.gmail.com with ESMTPSA id vr25-20020a05620a55b900b0077434d0f06esm4466409qkn.52.2023.09.30.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 07:35:58 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
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
	kernel@mojatatu.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com
Subject: [PATCH RFC v6 net-next 05/17] net: sched: act_api: Add support for preallocated dynamic action instances
Date: Sat, 30 Sep 2023 10:35:30 -0400
Message-Id: <20230930143542.101000-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930143542.101000-1-jhs@mojatatu.com>
References: <20230930143542.101000-1-jhs@mojatatu.com>
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

In P4, actions are assumed to pre exist and have an upper bound number of
instances. Typically if you have 1M table entries you want to allocate
enough action instances to cover the 1M entries. However, this is a big
waste of memory if the action instances are not in use. So for our case,
we allow the user to specify a minimal amount of actions in the template
and then if more dynamic action instances are needed then they will be
added on demand as in the current approach with tc filter-action
relationship.

Add the necessary code to preallocate actions instances for dynamic
actions.

We add 2 new actions flags:
- TCA_ACT_FLAGS_PREALLOC: Indicates the action instance is a dynamic action
  and was preallocated for future use the templating phase of P4TC
- TCA_ACT_FLAGS_UNREFERENCED: Indicates the action instance was
  preallocated and is currently not being referenced by any other object.
  Which means it won't show up in an action instance dump.

Once an action instance is created we don't free it when the last table
entry referring to it is deleted.
Instead we add it to the pool/cache of action instances for
that specific action i.e it counts as if it is preallocated.
Preallocated actions can't be deleted by the tc actions runtime commands
and a dump or a get will only show preallocated actions
instances which are being used (TCA_ACT_FLAGS_UNREFERENCED == false).

The preallocated actions will be deleted once the pipeline is deleted
(which will purge the dynamic action kind and its instances).

For example, if we were to create a dynamic action that preallocates 128
elements and dumped:

$ tc -j p4template get action/myprog/send_nh | jq .

We'd see the following:

[
  {
    "obj": "action template",
    "pname": "myprog",
    "pipeid": 1
  },
  {
    "templates": [
      {
        "aname": "myprog/send_nh",
        "actid": 1,
        "params": [
          {
            "name": "port",
            "type": "dev",
            "id": 1
          }
        ],
        "prealloc": 128
      }
    ]
  }
]

If we try to dump the dynamic action instances, we won't see any:

$ tc -j actions ls action myprog/send_nh | jq .

[]

However, if we create a table entry which references this action kind:

$ tc p4ctrl create myprog/table/cb/FDB \
   dstAddr d2:96:91:5d:02:86 action myprog/send_nh \
   param port type dev dummy0

Dumping the action instance will now show this one instance which is
associated with the table entry:

$ tc -j actions ls action myprog/send_nh | jq .

[
  {
    "total acts": 1
  },
  {
    "actions": [
      {
        "order": 0,
        "kind": "myprog/send_nh",
        "index": 1,
        "ref": 1,
        "bind": 1,
        "params": [
          {
            "name": "port",
            "type": "dev",
            "value": "dummy0",
            "id": 1
          }
        ],
        "not_in_hw": true
      }
    ]
  }
]

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h |  3 +++
 net/sched/act_api.c   | 50 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 90e215f10..cd5a8e86f 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -68,6 +68,8 @@ struct tc_action {
 #define TCA_ACT_FLAGS_REPLACE	(1U << (TCA_ACT_FLAGS_USER_BITS + 2))
 #define TCA_ACT_FLAGS_NO_RTNL	(1U << (TCA_ACT_FLAGS_USER_BITS + 3))
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
+#define TCA_ACT_FLAGS_PREALLOC	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
+#define TCA_ACT_FLAGS_UNREFERENCED	(1U << (TCA_ACT_FLAGS_USER_BITS + 6))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
@@ -200,6 +202,7 @@ int tcf_idr_create_from_flags(struct tc_action_net *tn, u32 index,
 			      const struct tc_action_ops *ops, int bind,
 			      u32 flags);
 void tcf_idr_insert_many(struct tc_action *actions[]);
+void tcf_idr_insert_n(struct tc_action *actions[], const u32 n);
 void tcf_idr_cleanup(struct tc_action_net *tn, u32 index);
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 			struct tc_action **a, int bind);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index cfa74f521..6f4c29e90 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -560,6 +560,8 @@ static int tcf_dump_walker(struct tcf_idrinfo *idrinfo, struct sk_buff *skb,
 			continue;
 		if (IS_ERR(p))
 			continue;
+		if (p->tcfa_flags & TCA_ACT_FLAGS_UNREFERENCED)
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
@@ -2033,8 +2050,17 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 			ret = PTR_ERR(act);
 			goto err;
 		}
-		attr_size += tcf_action_fill_size(act);
 		actions[i - 1] = act;
+
+		if (event == RTM_DELACTION &&
+		    act->tcfa_flags & TCA_ACT_FLAGS_PREALLOC) {
+			ret = -EINVAL;
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Unable to delete preallocated action %s",
+					   act->ops->kind);
+			goto err;
+		}
+		attr_size += tcf_action_fill_size(act);
 	}
 
 	attr_size = tcf_action_full_attrs_size(attr_size);
-- 
2.34.1


