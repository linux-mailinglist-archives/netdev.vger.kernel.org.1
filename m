Return-Path: <netdev+bounces-14520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2C8742421
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E6C1C20967
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A96C14D;
	Thu, 29 Jun 2023 10:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40884C125
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:45:52 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AC81BFE
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:49 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635de03a85bso3492486d6.3
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035548; x=1690627548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryKoZJa0DVRn+JAWUgkXceH1gr1ZxFrlRYByAx+HaTw=;
        b=GSa3MHSS7IhnrboEnRyAw7a7YSxR+a56vasXEB2qshfyuoaddzy+p6aa4BwPb7axtI
         TFl+0nkq9vvJPGre1yqItbQDt9cI31HZXVT0XKsXtJqF9Xm5pzelgZUGgn7uFYZvInPD
         xOMbhPvcI9YgqpyhJXuGEdluDbU6tXUdQ34QehJuK4i0ooYQtzL3e9JMIt8C2YKb6kPd
         2ndPRQVW3duj8Czsyml/A9lN4Z8UTaYSZ61wv4vzZirFUzwFuJeMIo5yljGTPKFACfKv
         VYA068N9iOD5/sUfQCZxskhU+a76Ose/s2epuBf7DX1f93QdC4Vr39E5wSrzqX0265ZT
         mydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035548; x=1690627548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ryKoZJa0DVRn+JAWUgkXceH1gr1ZxFrlRYByAx+HaTw=;
        b=W1tbvcaCThCfzJsQUYNQObVsmusLqv2QNDGopR32gk/J5vfFx0h2bMieKPeYqR+426
         EfOMdc0pVQRpWOVw7PNRzYOS2fYp33ZkvuSEqaWhIPaiLA341HissFLOO1LVuGiSlP9y
         hs40beG9jYNXED1HUW122n7W5uqh51Q0nh1A5TM65ZxyVV9dSzu/YLvGD6Lmi8xnuIZD
         Cv3jifDjx4AQA4eXhuWD2HC59ZgplLK61uuvxw58ixgkwSzpcXMmfAKswPpAvy+F9T3Z
         1FV5Z86fdTl1x8NEdockoeTP6s39S/N7GoVw7S9nr1c7RVt513812vmOKx5pSZhBqCb/
         Ky+Q==
X-Gm-Message-State: AC+VfDzuB67VvIbuvmRGTAGmoyGjWS3rezLzB41MfqzsBwXmzclea6Nm
	CQv2Tadh64pUKmChxA11hKkZKZvABk+OJOoPolc=
X-Google-Smtp-Source: ACHHUZ58DL201pB9xJ3WY2DXOb0ZwimabAiL99KlMfVXP7HgBEK0Bj0F8cu7jMEp/z3lrZZTKGkedQ==
X-Received: by 2002:a05:6214:2a8f:b0:630:14e0:9827 with SMTP id jr15-20020a0562142a8f00b0063014e09827mr35690489qvb.28.1688035548678;
        Thu, 29 Jun 2023 03:45:48 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:48 -0700 (PDT)
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
Subject: [PATCH RFC v3 net-next 01/21] net: sched: act_api: Add dynamic actions IDR
Date: Thu, 29 Jun 2023 06:45:18 -0400
Message-Id: <20230629104538.40863-2-jhs@mojatatu.com>
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

Kernel native actions kinds, such as gact, etc, have a predefined action
ID that is statically defined; example TCA_ID_GACT (0x2) for gact. In P4
we would require to generate new actions "on the fly" based on the P4
program requirement. Dynamic action kinds, like the pipeline they are
attached to, must be per net namespace, as opposed to native action kinds
which are global. For that reason, we chose to create a separate structure
to store dynamic actions.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h        |   6 +-
 include/uapi/linux/pkt_cls.h |   2 +-
 net/sched/act_api.c          | 130 +++++++++++++++++++++++++++++++----
 net/sched/cls_api.c          |   2 +-
 4 files changed, 124 insertions(+), 16 deletions(-)

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 4ae0580b6..54754deed 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -198,8 +198,10 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 int tcf_idr_release(struct tc_action *a, bool bind);
 
 int tcf_register_action(struct tc_action_ops *a, struct pernet_operations *ops);
+int tcf_register_dyn_action(struct net *net, struct tc_action_ops *act);
 int tcf_unregister_action(struct tc_action_ops *a,
 			  struct pernet_operations *ops);
+int tcf_unregister_dyn_action(struct net *net, struct tc_action_ops *act);
 int tcf_action_destroy(struct tc_action *actions[], int bind);
 int tcf_action_exec(struct sk_buff *skb, struct tc_action **actions,
 		    int nr_actions, struct tcf_result *res);
@@ -207,8 +209,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
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
index f7887f42d..5e5f299d2 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -57,6 +57,43 @@ static void tcf_free_cookie_rcu(struct rcu_head *p)
 	kfree(cookie);
 }
 
+static unsigned int dyn_act_net_id;
+
+struct tcf_dyn_act_net {
+	struct idr act_base;
+	rwlock_t act_mod_lock;
+};
+
+static __net_init int tcf_dyn_act_base_init_net(struct net *net)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	rwlock_t _act_mod_lock = __RW_LOCK_UNLOCKED(_act_mod_lock);
+
+	idr_init(&dyn_base_net->act_base);
+	dyn_base_net->act_mod_lock = _act_mod_lock;
+	return 0;
+}
+
+static void __net_exit tcf_dyn_act_base_exit_net(struct net *net)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	struct tc_action_ops *ops;
+	unsigned long opid, tmp;
+
+	idr_for_each_entry_ul(&dyn_base_net->act_base, ops, tmp, opid) {
+		idr_remove(&dyn_base_net->act_base, ops->id);
+	}
+
+	idr_destroy(&dyn_base_net->act_base);
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
@@ -941,6 +978,29 @@ static void tcf_pernet_del_id_list(unsigned int id)
 	mutex_unlock(&act_id_mutex);
 }
 
+int tcf_register_dyn_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	int ret;
+
+	write_lock(&dyn_base_net->act_mod_lock);
+
+	/* Dynamic actions start counting after TCA_ID_MAX + 1*/
+	act->id = TCA_ID_MAX + 1;
+
+	ret = idr_alloc_u32(&dyn_base_net->act_base, act, &act->id,
+			    USHRT_MAX, GFP_ATOMIC);
+	if (ret < 0)
+		goto err_out;
+	write_unlock(&dyn_base_net->act_mod_lock);
+
+	return 0;
+
+err_out:
+	write_unlock(&dyn_base_net->act_mod_lock);
+	return ret;
+}
+
 int tcf_register_action(struct tc_action_ops *act,
 			struct pernet_operations *ops)
 {
@@ -1010,40 +1070,84 @@ int tcf_unregister_action(struct tc_action_ops *act,
 }
 EXPORT_SYMBOL(tcf_unregister_action);
 
+int tcf_unregister_dyn_action(struct net *net, struct tc_action_ops *act)
+{
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
+	int err = 0;
+
+	write_lock(&dyn_base_net->act_mod_lock);
+	if (!idr_remove(&dyn_base_net->act_base, act->id))
+		err = -EINVAL;
+
+	write_unlock(&dyn_base_net->act_mod_lock);
+
+	return err;
+}
+EXPORT_SYMBOL(tcf_unregister_dyn_action);
+
 /* lookup by name */
-static struct tc_action_ops *tc_lookup_action_n(char *kind)
+static struct tc_action_ops *tc_lookup_action_n(struct net *net, char *kind)
 {
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
 	struct tc_action_ops *a, *res = NULL;
 
 	if (kind) {
+		unsigned long tmp, id;
+
 		read_lock(&act_mod_lock);
 		list_for_each_entry(a, &act_base, head) {
+			if (strcmp(kind, a->kind) == 0) {
+				if (try_module_get(a->owner)) {
+					read_unlock(&act_mod_lock);
+					return a;
+				}
+			}
+		}
+		read_unlock(&act_mod_lock);
+
+		read_lock(&dyn_base_net->act_mod_lock);
+		idr_for_each_entry_ul(&dyn_base_net->act_base, a, tmp, id) {
 			if (strcmp(kind, a->kind) == 0) {
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
 
 /* lookup by nlattr */
-static struct tc_action_ops *tc_lookup_action(struct nlattr *kind)
+static struct tc_action_ops *tc_lookup_action(struct net *net,
+					      struct nlattr *kind)
 {
+	struct tcf_dyn_act_net *dyn_base_net = net_generic(net, dyn_act_net_id);
 	struct tc_action_ops *a, *res = NULL;
 
 	if (kind) {
+		unsigned long tmp, id;
+
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
+		idr_for_each_entry_ul(&dyn_base_net->act_base, a, tmp, id) {
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
@@ -1294,8 +1398,8 @@ void tcf_idr_insert_many(struct tc_action *actions[])
 	}
 }
 
-struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
-					 bool rtnl_held,
+struct tc_action_ops *tc_action_load_ops(struct net *net, struct nlattr *nla,
+					 bool police, bool rtnl_held,
 					 struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[TCA_ACT_MAX + 1];
@@ -1326,7 +1430,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 		}
 	}
 
-	a_o = tc_lookup_action_n(act_name);
+	a_o = tc_lookup_action_n(net, act_name);
 	if (a_o == NULL) {
 #ifdef CONFIG_MODULES
 		if (rtnl_held)
@@ -1335,7 +1439,7 @@ struct tc_action_ops *tc_action_load_ops(struct nlattr *nla, bool police,
 		if (rtnl_held)
 			rtnl_lock();
 
-		a_o = tc_lookup_action_n(act_name);
+		a_o = tc_lookup_action_n(net, act_name);
 
 		/* We dropped the RTNL semaphore in order to
 		 * perform the module load.  So, even if we
@@ -1445,7 +1549,8 @@ int tcf_action_init(struct net *net, struct tcf_proto *tp, struct nlattr *nla,
 	for (i = 1; i <= TCA_ACT_MAX_PRIO && tb[i]; i++) {
 		struct tc_action_ops *a_o;
 
-		a_o = tc_action_load_ops(tb[i], flags & TCA_ACT_FLAGS_POLICE,
+		a_o = tc_action_load_ops(net, tb[i],
+					 flags & TCA_ACT_FLAGS_POLICE,
 					 !(flags & TCA_ACT_FLAGS_NO_RTNL),
 					 extack);
 		if (IS_ERR(a_o)) {
@@ -1655,7 +1760,7 @@ static struct tc_action *tcf_action_get_1(struct net *net, struct nlattr *nla,
 	index = nla_get_u32(tb[TCA_ACT_INDEX]);
 
 	err = -EINVAL;
-	ops = tc_lookup_action(tb[TCA_ACT_KIND]);
+	ops = tc_lookup_action(net, tb[TCA_ACT_KIND]);
 	if (!ops) { /* could happen in batch of actions */
 		NL_SET_ERR_MSG(extack, "Specified TC action kind not found");
 		goto err_out;
@@ -1703,7 +1808,7 @@ static int tca_action_flush(struct net *net, struct nlattr *nla,
 
 	err = -EINVAL;
 	kind = tb[TCA_ACT_KIND];
-	ops = tc_lookup_action(kind);
+	ops = tc_lookup_action(net, kind);
 	if (!ops) { /*some idjot trying to flush unknown action */
 		NL_SET_ERR_MSG(extack, "Cannot flush unknown TC action");
 		goto err_out;
@@ -2109,7 +2214,7 @@ static int tc_dump_action(struct sk_buff *skb, struct netlink_callback *cb)
 		return 0;
 	}
 
-	a_o = tc_lookup_action(kind);
+	a_o = tc_lookup_action(net, kind);
 	if (a_o == NULL)
 		return 0;
 
@@ -2176,6 +2281,7 @@ static int __init tc_action_init(void)
 	rtnl_register(PF_UNSPEC, RTM_GETACTION, tc_ctl_action, tc_dump_action,
 		      0);
 
+	register_pernet_subsys(&tcf_dyn_act_base_net_ops);
 	return 0;
 }
 
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 2621550bf..4af48f76f 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -3271,7 +3271,7 @@ int tcf_exts_validate_ex(struct net *net, struct tcf_proto *tp, struct nlattr **
 		if (exts->police && tb[exts->police]) {
 			struct tc_action_ops *a_o;
 
-			a_o = tc_action_load_ops(tb[exts->police], true,
+			a_o = tc_action_load_ops(net, tb[exts->police], true,
 						 !(flags & TCA_ACT_FLAGS_NO_RTNL),
 						 extack);
 			if (IS_ERR(a_o))
-- 
2.34.1


