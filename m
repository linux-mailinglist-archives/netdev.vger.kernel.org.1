Return-Path: <netdev+bounces-41219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152097CA441
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386041C20ACA
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D543E1CFA2;
	Mon, 16 Oct 2023 09:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="P9Vzc9Vd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D641CA94
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:05 +0000 (UTC)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DDE1
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:01 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d060aa2a4so29612726d6.2
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448960; x=1698053760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJCnnbiscQNc/ijxwkwgSSerw7SMU7NFUBWshZEc1a8=;
        b=P9Vzc9VdhjYA4TkBBiVEQ1uxXdEpN+N2MQ7TdNIR/A4WTIaqiRKy9tlS75CbdlTO/T
         pFJwvsRAhvckoYO5aetaIEFic4q73vxo3hGYXrzb5LpMPplSYD3LsBCCBv5FWXJF2NUI
         FFaO01KR1PoeN9oIvoZThjDQc0S3GlPSp8aMGEh7Ud/Od8C+bLHmOTfisAPQL0uwRONO
         6mIl5SRbSMYgFZjFyUaGmHxotpcAHojRdjZC4+hRNURAjnfIGDgUWQ3cxvBkOQqfJh0y
         DkI39bBDQM1n0dF+kWHjv8mpZLyxnSGGgAljQ6BD0ri4HeP+iZJ/jcKkc8dysZEuqGms
         4Dig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448960; x=1698053760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJCnnbiscQNc/ijxwkwgSSerw7SMU7NFUBWshZEc1a8=;
        b=HsAULuNpdH8UH5PsKo6shqYVWbavI+EkpTQDGC2+rei3JEqQB8uGbAajagxVevdgi/
         NZKdCMcnB1S4QtA0PmAEx37u8F+m0ueUMPYDPY9xywH3xcuGq7cnK2vUVVrDrmMQB4jb
         jyMspPQxskukr0qRLZDXURnJeMr8KutCvAHiGsEQWfyIj/SKYDWFzTpR82OFpEbRDFHD
         RY5i8tP7i1Uq2wlNMUd6n2+9S7hRyyNxqvmqj+3asVJr25ekBctcxrFvQUQQ44NPn0Wr
         4Mgiga9R76QlZ7zibn6tiWGdKvoKYUmwEXOXWLXRSgYOkkcln7gCYkRSB4E9dD6e5UQe
         ThdA==
X-Gm-Message-State: AOJu0Yzo0ngK8bj/v9Q6djQUZ4q9KHzm29BobHt19F8twYzMGk1ahhSl
	V7dzvMt/wQa7AZ5L8nkdJ8rHNCphr9a5TBjhse0=
X-Google-Smtp-Source: AGHT+IFZ0VW/g2POzZtO3iWId8R07TCrqEYQnRPhLW+hiVbnBvMdQbdTT+b2KrMVwQ9LmDWYqFPB1A==
X-Received: by 2002:a0c:bf4b:0:b0:656:3612:7954 with SMTP id b11-20020a0cbf4b000000b0065636127954mr33707162qvj.1.1697448960563;
        Mon, 16 Oct 2023 02:36:00 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:35:59 -0700 (PDT)
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
Subject: [PATCH v7 net-next 01/18] net: sched: act_api: Introduce dynamic actions list
Date: Mon, 16 Oct 2023 05:35:32 -0400
Message-Id: <20231016093549.181952-2-jhs@mojatatu.com>
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

In P4 we require to generate new actions "on the fly" based on the
specified P4 action definition. Dynamic action kinds, like the pipeline
they are attached to, must be per net namespace, as opposed to native
action kinds which are global. For that reason, we chose to create a
separate structure to store dynamic actions.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
---
 include/net/act_api.h |   7 ++-
 net/sched/act_api.c   | 123 +++++++++++++++++++++++++++++++++++++-----
 net/sched/cls_api.c   |   2 +-
 3 files changed, 115 insertions(+), 17 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4ae0580b6..3d40adef1 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -105,6 +105,7 @@ typedef void (*tc_action_priv_destructor)(void *priv);
 
 struct tc_action_ops {
 	struct list_head head;
+	struct list_head dyn_head;
 	char    kind[IFNAMSIZ];
 	enum tca_id  id; /* identifier should match kind */
 	unsigned int	net_id;
@@ -198,8 +199,10 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 int tcf_idr_release(struct tc_action *a, bool bind);
 
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
+int tcf_register_dyn_action(struct net *net, struct tc_action_ops *act);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+void tcf_unregister_dyn_action(struct net *net, struct tc_action_ops *act);
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
@@ -207,8 +210,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 		    struct nlattr *est,
 		    struct tc_action *actions[], int init_res[], size_t *attr_size,
 		    u32 flags, u32 fl_flags, struct netlink_ext_ack *extack);
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
+					 bool police, bool rtnl_held,
 					 struct netlink_ext_ack *extack);
 struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 				    struct nlattr *nla, struct nlattr *est,
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 9d3f26bf0..3f3837c12 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -57,6 +57,40 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
 	kfree(cookie);
 }
 
+static unsigned int dyn_act_net_id;
+
+struct tcf_dyn_act_net {
+	struct list_head act_base;
+	rwlock_t act_mod_lock;
+};
+
+static __net_init int tcf_dyn_act_base_init_net(struct net *net)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+
+	INIT_LIST_HEAD(&dyn_base_net->act_base);
+	rwlock_init(&dyn_base_net->act_mod_lock);
+
+	return 0;
+}
+
+static void __net_exit tcf_dyn_act_base_exit_net(struct net *net)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	struct tc_action_ops *ops, *tmp;
+
+	list_for_each_entry_safe(ops, tmp, &dyn_base_net->act_base, dyn_head) {
+		list_del(&ops->dyn_head);
+	}
+}
+
+static struct pernet_operations tcf_dyn_act_base_net_ops = {
+	.init = tcf_dyn_act_base_init_net,
+	.exit = tcf_dyn_act_base_exit_net,
+	.id = &dyn_act_net_id,
+	.size = sizeof(struct tc_action_ops),
+};
+
 static void tcf_set_action_cookie(struct tc_cookie __rcu **old_cookie,
 				  struct tc_cookie *new_cookie)
 {
@@ -941,6 +975,48 @@ static void tcf_pernet_del_id_list(unsigned int id)
 	mutex_unlock(&act_id_mutex);
 }
 
+static struct tc_action_ops *tc_lookup_dyn_action(struct net *net, char *kind)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	struct tc_action_ops *a, *res = NULL;
+
+	read_lock(&dyn_base_net->act_mod_lock);
+	list_for_each_entry(a, &dyn_base_net->act_base, dyn_head) {
+		if (strcmp(kind, a->kind) == 0) {
+			if (try_module_get(a->owner))
+				res = a;
+			break;
+		}
+	}
+	read_unlock(&dyn_base_net->act_mod_lock);
+
+	return res;
+}
+
+void tcf_unregister_dyn_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+
+	write_lock(&dyn_base_net->act_mod_lock);
+	list_del(&act->dyn_head);
+	write_unlock(&dyn_base_net->act_mod_lock);
+}
+EXPORT_SYMBOL(tcf_unregister_dyn_action);
+
+int tcf_register_dyn_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+
+	if (tc_lookup_dyn_action(net, act->kind))
+		return -EEXIST;
+
+	write_lock(&dyn_base_net->act_mod_lock);
+	list_add(&act->dyn_head, &dyn_base_net->act_base);
+	write_unlock(&dyn_base_net->act_mod_lock);
+
+	return 0;
+}
+
 int tcf_register_action(struct tc_action_ops *act,
 			struct pernet_operations *ops)
 {
@@ -1011,7 +1087,7 @@ int tcf_unregister_action(struct tc_action_ops *act,
 EXPORT_SYMBOL(tcf_unregister_action);
 
 /* lookup by name */
-static struct tc_action_ops *tc_lookup_action_n(char *kind)
+static struct tc_action_ops *tc_lookup_action_n(struct net *net, char *kind)
 {
 	struct tc_action_ops *a, *res = NULL;
 
@@ -1019,31 +1095,48 @@ static struct tc_action_ops *tc_lookup_action_n(char *kind)
 		read_lock(&act_mod_lock);
 		list_for_each_entry(a, &act_base, head) {
 			if (strcmp(kind, a->kind) == 0) {
-				if (try_module_get(a->owner))
-					res = a;
-				break;
+				if (try_module_get(a->owner)) {
+					read_unlock(&act_mod_lock);
+					return a;
+				}
 			}
 		}
 		read_unlock(&act_mod_lock);
+
+		return tc_lookup_dyn_action(net, kind);
 	}
+
 	return res;
 }
 
 /* lookup by nlattr */
-static struct tc_action_ops *tc_lookup_action(struct nlattr *kind)
+static struct tc_action_ops *tc_lookup_action(struct net *net,
+					      struct nlattr *kind)
 {
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
 	struct tc_action_ops *a, *res = NULL;
 
 	if (kind) {
 		read_lock(&act_mod_lock);
 		list_for_each_entry(a, &act_base, head) {
+			if (nla_strcmp(kind, a->kind) == 0) {
+				if (try_module_get(a->owner)) {
+					read_unlock(&act_mod_lock);
+					return a;
+				}
+			}
+		}
+		read_unlock(&act_mod_lock);
+
+		read_lock(&dyn_base_net->act_mod_lock);
+		list_for_each_entry(a, &dyn_base_net->act_base, dyn_head) {
 			if (nla_strcmp(kind, a->kind) == 0) {
 				if (try_module_get(a->owner))
 					res = a;
 				break;
 			}
 		}
-		read_unlock(&act_mod_lock);
+		read_unlock(&dyn_base_net->act_mod_lock);
 	}
 	return res;
 }
@@ -1294,8 +1387,8 @@ void tcf_idr_insert_many(struct tc_action *actions[])
 	}
 }
 
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
+					 bool police, bool rtnl_held,
 					 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[TCA_ACT_MAX + 1];
@@ -1326,7 +1419,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 		}
 	}
 
-	a_o = tc_lookup_action_n(act_name);
+	a_o = tc_lookup_action_n(net, act_name);
 	if (a_o == NULL) {
 #ifdef CONFIG_MODULES
 		if (rtnl_held)
@@ -1335,7 +1428,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 		if (rtnl_held)
 			rtnl_lock();
 
-		a_o = tc_lookup_action_n(act_name);
+		a_o = tc_lookup_action_n(net, act_name);
 
 		/* We dropped the RTNL semaphore in order to
 		 * perform the module load.  So, even if we
@@ -1445,7 +1538,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-		a_o = tc_action_load_ops(tb[i], flags & TCA_ACT_FLAGS_POLICE,
+		a_o = tc_action_load_ops(net, tb[i],
+					 flags & TCA_ACT_FLAGS_POLICE,
 					 !(flags & TCA_ACT_FLAGS_NO_RTNL),
 					 extack);
 		if (IS_ERR(a_o)) {
@@ -1655,7 +1749,7 @@ static struct tc_action *tcf_action_get_1(struct net *net, struct nlattr *nla,
 	index = nla_get_u32(tb[TCA_ACT_INDEX]);
 
 	err = -EINVAL;
-	ops = tc_lookup_action(tb[TCA_ACT_KIND]);
+	ops = tc_lookup_action(net, tb[TCA_ACT_KIND]);
 	if (!ops) { /* could happen in batch of actions */
 		NL_SET_ERR_MSG(extack, "Specified TC action kind not found");
 		goto err_out;
@@ -1703,7 +1797,7 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
 
 	err = -EINVAL;
 	kind = tb[TCA_ACT_KIND];
-	ops = tc_lookup_action(kind);
+	ops = tc_lookup_action(net, kind);
 	if (!ops) { /*some idjot trying to flush unknown action */
 		NL_SET_ERR_MSG(extack, "Cannot flush unknown TC action");
 		goto err_out;
@@ -2109,7 +2203,7 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 		return 0;
 	}
 
-	a_o = tc_lookup_action(kind);
+	a_o = tc_lookup_action(net, kind);
 	if (a_o == NULL)
 		return 0;
 
@@ -2176,6 +2270,7 @@ static int __init tc_action_init(void)
 	rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action,
 		      0);
 
+	register_pernet_subsys(&tcf_dyn_act_base_net_ops);
 	return 0;
 }
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index a193cc7b3..8c430c3f6 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3272,7 +3272,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 		if (exts->police && tb[exts->police]) {
 			struct tc_action_ops *a_o;
 
-			a_o = tc_action_load_ops(tb[exts->police], true,
+			a_o = tc_action_load_ops(net, tb[exts->police], true,
 						 !(flags & TCA_ACT_FLAGS_NO_RTNL),
 						 extack);
 			if (IS_ERR(a_o))
-- 
2.34.1


