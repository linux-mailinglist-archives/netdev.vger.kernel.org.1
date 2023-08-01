Return-Path: <netdev+bounces-23170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F53076B386
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C536E281947
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D922EF3;
	Tue,  1 Aug 2023 11:38:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A1214E1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:44 +0000 (UTC)
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55964E4C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:39 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-794cddcab71so1931155241.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889918; x=1691494718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vsfOThItV2AAk5sv79+xMTJsnLEV+6iLe7p+BeBwAw=;
        b=ac3wI2lv36gpmdnEAE5LQx15sN8VTIrFUX6y69dgBfhM+m7vdNe8Emq3jnmRE5kZ33
         nMX73f6uCrbsvnSDJNNQHdX3N/DkTKhy2Cno2JwLKjTIry/12BQMvlEebvLWTynIDtmg
         00HA/bG9FXh+MNGRoFnKtSNpIohX5HAjanUSNzL1nACpugfvh0pPz9TsXOMzx+97m+sX
         HusxdByvWty6t6v6JzMh3vwuqM9fEbjnfvfJLYIPzJl/rKld3xsaxMsJQ9WbrxXVHW4r
         00meWfxOZPX8eejNrxPHMbMI+cQ39V7Og3KmDXsDGoxRO0MGzgpzJDrPupFfLmNZtF5w
         BnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889918; x=1691494718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vsfOThItV2AAk5sv79+xMTJsnLEV+6iLe7p+BeBwAw=;
        b=GXvPZN3oNGj56TtNXaafzCpQN5IqYRyVW3QxyLIOZUrmO0HnR85ePpk5xu9n0EtMZL
         aaUEBLLoODdYrLnIrAIVnXlE48Ui/C8QnZuTB1Im4WYH6S91lvy3jnJa2mLju9yEPUWF
         YZycTEFui3kALwr7n2/uBPEjUHn8S9w3PHIFwS7gCisQtaS3tz3s6MFWG9jZje+n+YG2
         7biNxuy6kX2Yd7XxxUGEEldNUx+iZFQHgJPsHehQlft6uoSyn1ZP576NzCVBqeH2lP5F
         GcSWg+Jt42RQcvKNdPTa5PCJeGzQyBc4HUu240cSAzivMr89Lwmb/NpWaYMltmWLfUvt
         uOHA==
X-Gm-Message-State: ABy/qLYzc61WGE3qpmC8ZMECQPkuam0Nmg/i4v7W2bszS479QDMHKHUe
	r1Opqw2WPuP05BxXPZeSFeFI/YplzDCZjQbrfWhokw==
X-Google-Smtp-Source: APBJJlGQUUDUZ5xJ4VP+Cj1syUxgb0nAZ72buY73fY+laEQwibk9yNea+JFu74B5yaDJmA1+8UPm8Q==
X-Received: by 2002:a05:6102:7c6:b0:447:6947:24dc with SMTP id y6-20020a05610207c600b00447694724dcmr1684105vsg.9.1690889917059;
        Tue, 01 Aug 2023 04:38:37 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:36 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 12/23] p4tc: add action template create, update, delete, get, flush and dump
Date: Tue,  1 Aug 2023 07:37:56 -0400
Message-Id: <20230801113807.85473-13-jhs@mojatatu.com>
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

This commit allows users to create, update, delete, get, flush and dump
dynamic actions based on P4 action definition.

At the moment dynamic actions are tied to P4 programs only and cannot be
used outside of a P4 program definition.

Visualize the following action in a P4 program:

action ipv4_forward(bit<48> dstAddr, bit<8> port)
{
     standard_metadata.egress_spec = port;
     hdr.ethernet.srcAddr = hdr.ethernet.dstAddr;
     hdr.ethernet.dstAddr = dstAddr;
     hdr.ipv4.ttl = hdr.ipv4.ttl - 1;
}

which is invoked on a P4 table match as such:

table mytable {
        key = {
            hdr.ipv4.dstAddr: lpm;
        }

        actions = {
            ipv4_forward;
            drop;
            NoAction;
        }

        size = 1024;
}

We don't have an equivalent built in "ipv4_forward" action in TC. So we
create this action dynamically.

The mechanics of dynamic actions follow the CRUD semantics.

___DYNAMIC CREATION___

In this stage we issue the creation command for the dynamic action which
specifies the action  name, its ID, parameters and the parameter types.
So for the ipv4_forward action, the creation would look something like
this:

tc p4template create action/aP4proggie/ipv4_forward \
  param dstAddr type macaddr id 1 param port type dev id 2

Note1: Although the P4 program defined dstAddr as type bit48 we use our
type called macaddr (likewise for port) - see commit on p4 types for
details.

Note that in the template creation op we usually just specify the action
name, the parameters and their respective types. Also see that we specify
a pipeline name during the template creation command. As an example, the
above command creates an action template that is bounded to
pipeline/program named aP4proggie.

___ACTION_ACTIVATION___

Once we provided all the necessary information for the new dynamic action,
we can go to the final stage, which is action activation. In this stage,
we activate the dynamic action and make it available for instantiation.
To activate the action template, we issue the following command:

tc p4template update action aP4proggie/ipv4_forward state active

After the above the command, the action is ready to be instantiated.

___RUNTIME___

This next section deals with the runtime part of action templates, which
handle action template instantiation and binding.

To instantiate a new action from a template, we use the following command:

tc actions add action aP4proggie/ipv4_forward \
param dstAddr AA:BB:CC:DD:EE:FF param port eth0 index 1

Observe these are the same semantics as what tc today already provides
with a caveat that we have a keyword "param" to precede the appropriate
parameters - as such specifying the index is optional (kernel provides
one when unspecified).

As previously stated, we refer to the action by it's "full name"
(pipeline_name/action_name). Here we are creating an instance of the
ipv4_forward action specifying as parameter values AA:BB:CC:DD:EE:FF for
dstAddr and eth0 for port. We can create as many instances for action
templates as we wish.

To bind the above instantiated action to a table entry, you can do use the
same classical approach used to bind ordinary actions to filters, for
example:

tc p4runtime create aP4proggie/table/mycontrol/mytable srcAddr 10.10.10.0/24 \
action ipv4_forward index 1

The above command will bind our newly instantiated action to a table
entry which is executed if there's a match.

Of course one could have created the table entry as:

tc p4runtime create aP4proggie/table/mycontrol/mytable srcAddr 10.10.10.0/24 \
action ipv4_forward param dstAddr AA:BB:CC:DD:EE:FF param port eth0

Actions from other control blocks might be referenced as the action
index is per pipeline.

___OTHER_CONTROL_COMMANDS___

The lifetime of the dynamic action is tied to its pipeline.
As with all pipeline components, write operations to action templates, such
as create, update and delete, can only be executed if the pipeline is not
sealed. Read/get can be issued even after the pipeline is sealed.

If, after we are done with our action template we want to delete it, we
should issue the following command:

tc p4template del action/aP4proggie/ipv4_forward

If we had created more action templates and wanted to flush all of the
action templates from pipeline aP4proggie, one would use the following
command:

tc p4template del action/aP4proggie/

After creating or updating a dynamic actions, if one wishes to verify that
the dynamic action was created correctly, one would use the following
command:

tc p4template get action/aP4proggie/ipv4_forward

The above command will display the relevant data for the action,
such as parameter names, types, etc.

If one wanted to check which action templates were associated to a specific
pipeline, one could use the following command:

tc p4template get action/aP4proggie/

Note that this command will only display the name of these action
templates. To verify their specific details, one should use the get
command, which was previously described.

Tested-by: "Khan, Mohd Arif" <mohd.arif.khan@intel.com>
Tested-by: "Pottimurthy, Sathya Narayana" <sathya.narayana.pottimurthy@intel.com>
Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/act_api.h          |    1 +
 include/net/p4tc.h             |  151 ++-
 include/net/tc_act/p4tc.h      |   27 +
 include/uapi/linux/p4tc.h      |   43 +
 net/sched/p4tc/Makefile        |    2 +-
 net/sched/p4tc/p4tc_action.c   | 2023 ++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c |   45 +-
 net/sched/p4tc/p4tc_tmpl_api.c |    2 +
 8 files changed, 2290 insertions(+), 4 deletions(-)
 create mode 100644 include/net/tc_act/p4tc.h
 create mode 100644 net/sched/p4tc/p4tc_action.c

diff --git a/include/net/act_api.h b/include/net/act_api.h
index a6331cc5d..4b97f03b2 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -70,6 +70,7 @@ struct tc_action {
 #define TCA_ACT_FLAGS_AT_INGRESS	(1U << (TCA_ACT_FLAGS_USER_BITS + 4))
 #define TCA_ACT_FLAGS_PREALLOC	(1U << (TCA_ACT_FLAGS_USER_BITS + 5))
 #define TCA_ACT_FLAGS_UNUSED	(1U << (TCA_ACT_FLAGS_USER_BITS + 6))
+#define TCA_ACT_FLAGS_FROM_P4TC	(1U << (TCA_ACT_FLAGS_USER_BITS + 7))
 
 /* Update lastuse only if needed, to avoid dirtying a cache line.
  * We use a temp variable to avoid fetching jiffies twice.
diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 3659fa725..6d6cfd2ac 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -9,6 +9,8 @@
 #include <linux/refcount.h>
 #include <linux/rhashtable.h>
 #include <linux/rhashtable-types.h>
+#include <net/tc_act/p4tc.h>
+#include <net/p4tc_types.h>
 
 #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
 #define P4TC_DEFAULT_MAX_RULES 1
@@ -17,6 +19,7 @@
 #define P4TC_KERNEL_PIPEID 0
 
 #define P4TC_PID_IDX 0
+#define P4TC_AID_IDX 1
 #define P4TC_PARSEID_IDX 1
 #define P4TC_HDRFIELDID_IDX 2
 
@@ -24,6 +27,7 @@
 
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
+	struct rhashtable_iter *iter;
 };
 
 struct p4tc_template_common;
@@ -67,13 +71,16 @@ extern const struct p4tc_template_ops p4tc_pipeline_ops;
 
 struct p4tc_pipeline {
 	struct p4tc_template_common common;
+	struct idr                  p_act_idr;
 	struct rcu_head             rcu;
 	struct net                  *net;
 	struct p4tc_parser          *parser;
+	u32                         num_created_acts;
 	refcount_t                  p_ctrl_ref;
 	u16                         num_tables;
 	u16                         curr_tables;
 	u8                          p_state;
+	refcount_t                  p_hdrs_used;
 };
 
 struct p4tc_pipeline_net {
@@ -109,18 +116,93 @@ tcf_pipeline_find_byany_unsealed(struct net *net, const char *p_name,
 				 const u32 pipeid,
 				 struct netlink_ext_ack *extack);
 
+struct p4tc_act *tcf_p4_find_act(struct net *net,
+				 const struct tc_action_ops *a_o);
+void
+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4_act);
+
 static inline int p4tc_action_destroy(struct tc_action **acts)
 {
+	struct tc_action *acts_non_prealloc[TCA_ACT_MAX_PRIO] = {NULL};
 	int ret = 0;
 
 	if (acts) {
-		ret = tcf_action_destroy(acts, TCA_ACT_UNBIND);
+		int j = 0;
+		int i;
+
+		for (i = 0; i < TCA_ACT_MAX_PRIO && acts[i]; i++) {
+			if (acts[i]->tcfa_flags & TCA_ACT_FLAGS_PREALLOC) {
+				const struct tc_action_ops *ops;
+				struct tcf_p4act *p4act;
+				struct p4tc_act *act;
+				struct net *net;
+
+				p4act = (struct tcf_p4act *)acts[i];
+				net = acts[i]->idrinfo->net;
+				ops = acts[i]->ops;
+
+				act = tcf_p4_find_act(net, ops);
+				tcf_p4_put_prealloc_act(act, p4act);
+			} else {
+				acts_non_prealloc[j] = acts[i];
+				j++;
+			}
+		}
+
+		ret = tcf_action_destroy(acts_non_prealloc, TCA_ACT_UNBIND);
 		kfree(acts);
 	}
 
 	return ret;
 }
 
+struct p4tc_ipv4_param_value {
+	u32 value;
+	u32 mask;
+};
+
+struct p4tc_act_param {
+	char            name[ACTPARAMNAMSIZ];
+	struct list_head head;
+	struct rcu_head	rcu;
+	void            *value;
+	void            *mask;
+	struct p4tc_type *type;
+	u32             id;
+	u32             index;
+	u8              flags;
+};
+
+struct p4tc_act_param_ops {
+	int (*init_value)(struct net *net, struct p4tc_act_param_ops *op,
+			  struct p4tc_act_param *nparam, struct nlattr **tb,
+			  struct netlink_ext_ack *extack);
+	int (*dump_value)(struct sk_buff *skb, struct p4tc_act_param_ops *op,
+			  struct p4tc_act_param *param);
+	void (*free)(struct p4tc_act_param *param);
+	u32 len;
+	u32 alloc_len;
+};
+
+struct p4tc_act {
+	struct p4tc_template_common common;
+	struct tc_action_ops        ops;
+	struct tc_action_net        *tn;
+	struct p4tc_pipeline        *pipeline;
+	struct idr                  params_idr;
+	struct tcf_exts             exts;
+	struct list_head            head;
+	struct list_head            prealloc_list;
+	spinlock_t                  list_lock;
+	u32                         a_id;
+	u32                         num_params;
+	u32                         num_prealloc_acts;
+	bool                        active;
+	refcount_t                  a_ref;
+};
+
+extern const struct p4tc_template_ops p4tc_act_ops;
+
 struct p4tc_parser {
 	char parser_name[PARSERNAMSIZ];
 	struct idr hdrfield_idr;
@@ -141,6 +223,63 @@ struct p4tc_hdrfield {
 
 extern const struct p4tc_template_ops p4tc_hdrfield_ops;
 
+static inline int p4tc_action_init(struct net *net, struct nlattr *nla,
+				   struct tc_action *acts[], u32 pipeid,
+				   u32 flags, struct netlink_ext_ack *extack)
+{
+	int init_res[TCA_ACT_MAX_PRIO];
+	size_t attrs_size;
+	int ret;
+	int i;
+
+	/* If action was already created, just bind to existing one*/
+	flags |= TCA_ACT_FLAGS_BIND;
+	flags |= TCA_ACT_FLAGS_FROM_P4TC;
+	ret = tcf_action_init(net, NULL, nla, NULL, acts, init_res, &attrs_size,
+			      flags, 0, extack);
+
+	/* Check if we are trying to bind to dynamic action from different pipeline */
+	for (i = 0; i < TCA_ACT_MAX_PRIO && acts[i]; i++) {
+		struct tc_action *a = acts[i];
+		struct tcf_p4act *p;
+
+		if (a->ops->id <= TCA_ID_MAX)
+			continue;
+
+		p = to_p4act(a);
+		if (p->p_id != pipeid) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to bind to dynact from different pipeline");
+			ret = -EPERM;
+			goto destroy_acts;
+		}
+	}
+
+	return ret;
+
+destroy_acts:
+	p4tc_action_destroy(acts);
+	return ret;
+}
+
+struct p4tc_act *tcf_action_find_get(struct p4tc_pipeline *pipeline,
+				     const char *act_name, const u32 a_id,
+				     struct netlink_ext_ack *extack);
+struct p4tc_act *tcf_action_find_byid(struct p4tc_pipeline *pipeline,
+				      const u32 a_id);
+
+static inline bool tcf_action_put(struct p4tc_act *act)
+{
+	return refcount_dec_not_one(&act->a_ref);
+}
+
+struct p4tc_act_param *tcf_param_find_byid(struct idr *params_idr,
+					   const u32 param_id);
+struct p4tc_act_param *tcf_param_find_byany(struct p4tc_act *act,
+					    const char *param_name,
+					    const u32 param_id,
+					    struct netlink_ext_ack *extack);
+
 struct p4tc_parser *tcf_parser_create(struct p4tc_pipeline *pipeline,
 				      const char *parser_name, u32 parser_id,
 				      struct netlink_ext_ack *extack);
@@ -180,7 +319,17 @@ static inline bool tcf_hdrfield_put_ref(struct p4tc_hdrfield *hdrfield)
 	return !refcount_dec_not_one(&hdrfield->hdrfield_ref);
 }
 
+int tcf_p4_prealloc_acts(struct p4tc_pipeline *pipeline,
+			 struct tc_action ***prealloc_acts,
+			 struct netlink_ext_ack *extack);
+void tcf_p4_prealloc_list_add(struct p4tc_pipeline *pipeline,
+			      struct tc_action **acts);
+struct tcf_p4act *
+tcf_p4_get_next_prealloc_act(struct p4tc_act *act);
+void tcf_p4_set_init_flags(struct tcf_p4act *p4act);
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
 #define to_hdrfield(t) ((struct p4tc_hdrfield *)t)
+#define to_act(t) ((struct p4tc_act *)t)
 
 #endif
diff --git a/include/net/tc_act/p4tc.h b/include/net/tc_act/p4tc.h
new file mode 100644
index 000000000..6b4666972
--- /dev/null
+++ b/include/net/tc_act/p4tc.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_TC_ACT_P4_H
+#define __NET_TC_ACT_P4_H
+
+#include <net/pkt_cls.h>
+#include <net/act_api.h>
+
+struct tcf_p4act_params {
+	struct tcf_exts exts;
+	struct idr params_idr;
+	struct p4tc_act_param **params_array;
+	struct rcu_head rcu;
+	u32 num_params;
+	u32 tot_params_sz;
+};
+
+struct tcf_p4act {
+	struct tc_action common;
+	/* Params IDR reference passed during runtime */
+	struct tcf_p4act_params __rcu *params;
+	u32 p_id;
+	u32 act_id;
+	struct list_head node;
+};
+#define to_p4act(a) ((struct tcf_p4act *)a)
+
+#endif /* __NET_TC_ACT_P4_H */
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index f723d1a71..4d471519a 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/pkt_sched.h>
+#include <linux/pkt_cls.h>
 
 /* pipeline header */
 struct p4tcmsg {
@@ -25,6 +26,9 @@ struct p4tcmsg {
 #define PIPELINENAMSIZ TEMPLATENAMSZ
 #define PARSERNAMSIZ TEMPLATENAMSZ
 #define HDRFIELDNAMSIZ TEMPLATENAMSZ
+#define ACTPARAMNAMSIZ TEMPLATENAMSZ
+
+#define LABELNAMSIZ 32
 
 /* Root attributes */
 enum {
@@ -50,6 +54,7 @@ enum {
 	P4TC_OBJ_UNSPEC,
 	P4TC_OBJ_PIPELINE,
 	P4TC_OBJ_HDR_FIELD,
+	P4TC_OBJ_ACT,
 	__P4TC_OBJ_MAX,
 };
 #define P4TC_OBJ_MAX __P4TC_OBJ_MAX
@@ -119,6 +124,44 @@ enum {
 };
 #define P4TC_HDRFIELD_MAX (__P4TC_HDRFIELD_MAX - 1)
 
+/* Action attributes */
+enum {
+	P4TC_ACT_UNSPEC,
+	P4TC_ACT_NAME, /* string */
+	P4TC_ACT_PARMS, /* nested params */
+	P4TC_ACT_OPT, /* action opt */
+	P4TC_ACT_TM, /* action tm */
+	P4TC_ACT_ACTIVE, /* u8 */
+	P4TC_ACT_NUM_PREALLOC, /* u32 num preallocated action instances */
+	P4TC_ACT_PAD,
+	__P4TC_ACT_MAX
+};
+#define P4TC_ACT_MAX __P4TC_ACT_MAX
+
+/* Action params attributes */
+enum {
+	P4TC_ACT_PARAMS_VALUE_UNSPEC,
+	P4TC_ACT_PARAMS_VALUE_RAW, /* binary */
+	__P4TC_ACT_PARAMS_VALUE_MAX
+};
+#define P4TC_ACT_VALUE_PARAMS_MAX __P4TC_ACT_PARAMS_VALUE_MAX
+
+/* Action params attributes */
+enum {
+	P4TC_ACT_PARAMS_UNSPEC,
+	P4TC_ACT_PARAMS_NAME, /* string */
+	P4TC_ACT_PARAMS_ID, /* u32 */
+	P4TC_ACT_PARAMS_VALUE, /* bytes */
+	P4TC_ACT_PARAMS_MASK, /* bytes */
+	P4TC_ACT_PARAMS_TYPE, /* u32 */
+	__P4TC_ACT_PARAMS_MAX
+};
+#define P4TC_ACT_PARAMS_MAX __P4TC_ACT_PARAMS_MAX
+
+struct tc_act_dyna {
+	tc_gen;
+};
+
 #define P4TC_RTA(r) \
 	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
 
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 2bcafcc2b..f4a96efca 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
-	p4tc_parser_api.o p4tc_hdrfield.o
+	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
new file mode 100644
index 000000000..9d5f57ccf
--- /dev/null
+++ b/net/sched/p4tc/p4tc_action.c
@@ -0,0 +1,2023 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_action.c	P4 TC ACTION TEMPLATES
+ *
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <net/flow_offload.h>
+#include <net/net_namespace.h>
+#include <net/netlink.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/sch_generic.h>
+#include <net/sock.h>
+#include <net/tc_act/p4tc.h>
+
+static LIST_HEAD(dynact_list);
+
+#define SEPARATOR "/"
+
+static void set_param_indices(struct p4tc_act *act)
+{
+	struct p4tc_act_param *param;
+	unsigned long tmp, id;
+	int i = 0;
+
+	idr_for_each_entry_ul(&act->params_idr, param, tmp, id) {
+		param->index = i;
+		i++;
+	}
+}
+
+static int __tcf_p4_dyna_init(struct net *net, struct nlattr *est,
+			      struct p4tc_act *act, struct tc_act_dyna *parm,
+			      struct tc_action **a, struct tcf_proto *tp,
+			      struct tc_action_ops *a_o,
+			      struct tcf_chain **goto_ch, u32 flags,
+			      struct netlink_ext_ack *extack)
+{
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct p4tc_pipeline *pipeline;
+	bool exists = false;
+	int ret = 0;
+	u32 index;
+	int err;
+
+	index = parm->index;
+
+	err = tcf_idr_check_alloc(act->tn, &index, a, bind);
+	if (err < 0)
+		return err;
+
+	exists = err;
+	if (!exists) {
+		struct tcf_p4act *p;
+
+		ret = tcf_idr_create(act->tn, index, est, a, a_o, bind, true,
+				     flags);
+		if (ret) {
+			tcf_idr_cleanup(act->tn, index);
+			return ret;
+		}
+
+		/* dyn_ref here should never be 0, because if we are here, it
+		 * means that a template action of this kind was created. Thus
+		 * dyn_ref should be at least 1. Also since this operation and
+		 * others that add or delete action templates run with
+		 * rtnl_lock held, we cannot do this op and a deletion op in
+		 * parallel.
+		 */
+		WARN_ON(!refcount_inc_not_zero(&a_o->dyn_ref));
+
+		pipeline = act->pipeline;
+
+		p = to_p4act(*a);
+		p->p_id = pipeline->common.p_id;
+		p->act_id = act->a_id;
+
+		ret = ACT_P_CREATED;
+	} else {
+		if (bind) /* dont override defaults */
+			return 0;
+		if (!(flags & TCA_ACT_FLAGS_REPLACE)) {
+			tcf_idr_cleanup(act->tn, index);
+			return -EEXIST;
+		}
+	}
+
+	err = tcf_action_check_ctrlact(parm->action, tp, goto_ch, extack);
+	if (err < 0) {
+		tcf_idr_release(*a, bind);
+		return err;
+	}
+
+	return ret;
+}
+
+static void generic_free_param_value(struct p4tc_act_param *param)
+{
+	kfree(param->value);
+	kfree(param->mask);
+}
+
+static const struct nla_policy p4tc_act_params_value_policy[P4TC_ACT_VALUE_PARAMS_MAX + 1] = {
+	[P4TC_ACT_PARAMS_VALUE_RAW] = { .type = NLA_BINARY },
+};
+
+static int dev_init_param_value(struct net *net, struct p4tc_act_param_ops *op,
+				struct p4tc_act_param *nparam,
+				struct nlattr **tb,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb_value[P4TC_ACT_VALUE_PARAMS_MAX + 1];
+	u32 value_len;
+	u32 *ifindex;
+	int err;
+
+	if (!tb[P4TC_ACT_PARAMS_VALUE]) {
+		NL_SET_ERR_MSG(extack, "Must specify param value");
+		return -EINVAL;
+	}
+	err = nla_parse_nested(tb_value, P4TC_ACT_VALUE_PARAMS_MAX,
+			       tb[P4TC_ACT_PARAMS_VALUE],
+			       p4tc_act_params_value_policy, extack);
+	if (err < 0)
+		return err;
+
+	value_len = nla_len(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]);
+	if (value_len != sizeof(u32)) {
+		NL_SET_ERR_MSG(extack, "Value length differs from template's");
+		return -EINVAL;
+	}
+
+	ifindex = nla_data(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]);
+	rcu_read_lock();
+	if (!dev_get_by_index_rcu(net, *ifindex)) {
+		NL_SET_ERR_MSG(extack, "Invalid ifindex");
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
+	nparam->value = kmemdup(ifindex, sizeof(*ifindex), GFP_KERNEL);
+	if (!nparam->value)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int dev_dump_param_value(struct sk_buff *skb,
+				struct p4tc_act_param_ops *op,
+				struct p4tc_act_param *param)
+{
+	const u32 *ifindex = param->value;
+	struct nlattr *nest;
+	int ret;
+
+	nest = nla_nest_start(skb, P4TC_ACT_PARAMS_VALUE);
+	if (nla_put_u32(skb, P4TC_ACT_PARAMS_VALUE_RAW, *ifindex)) {
+		ret = -EINVAL;
+		goto out_nla_cancel;
+	}
+	nla_nest_end(skb, nest);
+
+	return 0;
+
+out_nla_cancel:
+	nla_nest_cancel(skb, nest);
+	return ret;
+}
+
+static void dev_free_param_value(struct p4tc_act_param *param)
+{
+	kfree(param->value);
+}
+
+static const struct p4tc_act_param_ops param_ops[P4T_MAX + 1] = {
+	[P4T_DEV] = {
+		.init_value = dev_init_param_value,
+		.dump_value = dev_dump_param_value,
+		.free = dev_free_param_value,
+	},
+};
+
+static void tcf_p4_act_params_destroy(struct tcf_p4act_params *params)
+{
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+
+	idr_for_each_entry_ul(&params->params_idr, param, tmp, param_id) {
+		struct p4tc_act_param_ops *op;
+
+		idr_remove(&params->params_idr, param_id);
+		op = (struct p4tc_act_param_ops *)&param_ops[param->type->typeid];
+		if (op->free)
+			op->free(param);
+		else
+			generic_free_param_value(param);
+		kfree(param);
+	}
+
+	kfree(params->params_array);
+	idr_destroy(&params->params_idr);
+
+	kfree(params);
+}
+
+static void tcf_p4_act_params_destroy_rcu(struct rcu_head *head)
+{
+	struct tcf_p4act_params *params;
+
+	params = container_of(head, struct tcf_p4act_params, rcu);
+	tcf_p4_act_params_destroy(params);
+}
+
+static int __tcf_p4_dyna_init_set(struct p4tc_act *act, struct tc_action **a,
+				  struct tcf_p4act_params *params,
+				  struct tcf_chain *goto_ch,
+				  struct tc_act_dyna *parm, bool exists,
+				  struct netlink_ext_ack *extack)
+{
+	struct tcf_p4act_params *params_old;
+	struct tcf_p4act *p;
+
+	p = to_p4act(*a);
+
+	if (exists)
+		spin_lock_bh(&p->tcf_lock);
+
+	goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
+
+	params_old = rcu_replace_pointer(p->params, params, 1);
+	if (exists)
+		spin_unlock_bh(&p->tcf_lock);
+
+	if (goto_ch)
+		tcf_chain_put_by_act(goto_ch);
+
+	if (params_old)
+		call_rcu(&params_old->rcu, tcf_p4_act_params_destroy_rcu);
+
+	return 0;
+}
+
+int tcf_p4_dyna_template_init(struct net *net, struct tc_action **a,
+			      struct p4tc_act *act,
+			      struct list_head *params_list,
+			      struct tc_act_dyna *parm, u32 flags,
+			      struct netlink_ext_ack *extack);
+
+static struct tcf_p4act_params *tcf_p4_act_params_init(struct p4tc_act *act)
+{
+	struct tcf_p4act_params *params;
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
+
+	params->params_array = kcalloc(act->num_params,
+				       sizeof(struct p4tc_act_param *),
+				       GFP_KERNEL);
+	if (!params->params_array) {
+		kfree(params);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return params;
+}
+
+static struct p4tc_act_param *
+init_prealloc_param(struct p4tc_act *act, unsigned long *param_id,
+		    struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *nparam;
+	struct p4tc_act_param *param;
+	void *value;
+
+	param = idr_get_next_ul(&act->params_idr, param_id);
+	if (!param) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Act has less runtime parameters than passed in call");
+		return ERR_PTR(-EINVAL);
+	}
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam)
+		return ERR_PTR(-ENOMEM);
+
+	value = kzalloc(BITS_TO_BYTES(param->type->container_bitsz),
+			GFP_KERNEL);
+	if (!value) {
+		kfree(nparam);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	strscpy(nparam->name, param->name, ACTPARAMNAMSIZ);
+	nparam->id = *param_id;
+	nparam->value = value;
+	nparam->type = param->type;
+
+	return nparam;
+}
+
+static int init_prealloc_params(struct p4tc_act *act,
+				struct list_head *params_lst,
+				struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *params[P4TC_MSGBATCH_SIZE] = { NULL };
+	struct p4tc_act_param *param;
+	unsigned long param_id = 0;
+	unsigned long tmp;
+	int i = 0;
+	int err;
+
+	idr_for_each_entry_ul(&act->params_idr, param, tmp, param_id) {
+		struct p4tc_act_param *nparam;
+
+		nparam = init_prealloc_param(act, &param_id, extack);
+		if (IS_ERR(nparam)) {
+			err = PTR_ERR(nparam);
+			goto free_params;
+		}
+
+		params[i] = nparam;
+		list_add_tail(&nparam->head, params_lst);
+		i++;
+	}
+
+	return 0;
+
+free_params:
+	while (i--)
+		kfree(params[i]);
+
+	return err;
+}
+
+struct p4tc_act *tcf_action_find_byid(struct p4tc_pipeline *pipeline,
+				      const u32 a_id)
+{
+	return idr_find(&pipeline->p_act_idr, a_id);
+}
+
+void tcf_p4_prealloc_list_add(struct p4tc_pipeline *pipeline,
+			      struct tc_action **acts)
+{
+	struct tcf_p4act *first_p4act = to_p4act(acts[0]);
+	u32 num_prealloc_acts;
+	struct p4tc_act *act;
+	int i;
+
+	/* Will never return NULL */
+	act = tcf_action_find_byid(pipeline, first_p4act->act_id);
+	num_prealloc_acts = act->num_prealloc_acts;
+
+	for (i = 0; i < num_prealloc_acts; i++) {
+		struct tcf_p4act *p4act = to_p4act(acts[i]);
+
+		list_add_tail(&p4act->node, &act->prealloc_list);
+	}
+
+	tcf_idr_insert_n(acts, num_prealloc_acts);
+}
+
+static void free_intermediate_param(struct p4tc_act_param *param)
+{
+	kfree(param->value);
+	kfree(param);
+}
+
+static void free_intermediate_params_list(struct list_head *params_list)
+{
+	struct p4tc_act_param *nparam, *p;
+
+	list_for_each_entry_safe(nparam, p, params_list, head) {
+		free_intermediate_param(nparam);
+	}
+}
+
+static int __tcf_p4_prealloc_acts(struct net *net, struct p4tc_act *act,
+				  struct tc_action **acts,
+				  struct netlink_ext_ack *extack)
+{
+	u32 flags = TCA_ACT_FLAGS_PREALLOC | TCA_ACT_FLAGS_UNUSED;
+	int err;
+	int i;
+
+	for (i = 0; i < act->num_prealloc_acts; i++) {
+		struct tc_action *a = acts[i];
+		struct tc_act_dyna parm = {0};
+		struct list_head params_list;
+		struct tcf_p4act *p4act;
+
+		parm.index = i + 1;
+		parm.action = TC_ACT_PIPE;
+
+		INIT_LIST_HEAD(&params_list);
+
+		err = init_prealloc_params(act, &params_list, extack);
+		if (err < 0)
+			goto destroy_acts;
+
+		err = tcf_p4_dyna_template_init(net, &a, act, &params_list,
+						&parm, flags, extack);
+		if (err < 0) {
+			free_intermediate_params_list(&params_list);
+			goto destroy_acts;
+		}
+
+		acts[i] = a;
+		p4act = to_p4act(a);
+	}
+
+	return 0;
+
+destroy_acts:
+	tcf_action_destroy(acts, false);
+
+	return err;
+}
+
+int tcf_p4_prealloc_acts(struct p4tc_pipeline *pipeline,
+			 struct tc_action ***prealloc_acts,
+			 struct netlink_ext_ack *extack)
+{
+	unsigned long tmp, act_id;
+	struct p4tc_act *act;
+	int i = 0;
+	int err;
+
+	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, act_id) {
+		struct tc_action **acts;
+
+		if (!act->num_prealloc_acts)
+			continue;
+
+		acts = kcalloc(act->num_prealloc_acts, sizeof(*acts),
+			       GFP_KERNEL);
+		if (!acts) {
+			err = -ENOMEM;
+			goto free_prealloc_acts;
+		}
+
+		err = __tcf_p4_prealloc_acts(pipeline->net, act, acts, extack);
+		if (err < 0) {
+			kfree(acts);
+			goto free_prealloc_acts;
+		}
+		prealloc_acts[i] = acts;
+		i++;
+	}
+
+	return i;
+
+free_prealloc_acts:
+	while (prealloc_acts[i]) {
+		tcf_action_destroy(prealloc_acts[i], 0);
+		i--;
+	}
+	kfree(prealloc_acts);
+	return err;
+}
+
+/* Need to implement after preallocating */
+struct tcf_p4act *
+tcf_p4_get_next_prealloc_act(struct p4tc_act *act)
+{
+	struct tcf_p4act *p4_act;
+
+	spin_lock(&act->list_lock);
+	p4_act = list_first_entry_or_null(&act->prealloc_list, struct tcf_p4act,
+					  node);
+	if (p4_act) {
+		list_del_init(&p4_act->node);
+		refcount_set(&p4_act->common.tcfa_refcnt, 1);
+		atomic_set(&p4_act->common.tcfa_bindcnt, 1);
+	}
+	spin_unlock(&act->list_lock);
+
+	return p4_act;
+}
+
+void tcf_p4_set_init_flags(struct tcf_p4act *p4act)
+{
+	struct tc_action *a;
+
+	a = (struct tc_action *)p4act;
+	a->tcfa_flags &= ~TCA_ACT_FLAGS_UNUSED;
+}
+
+static void __tcf_p4_put_prealloc_act(struct p4tc_act *act,
+				      struct tcf_p4act *p4act)
+{
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+
+	idr_for_each_entry_ul(&p4act->params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		memset(param->value, 0, type_bytesz);
+	}
+	p4act->common.tcfa_flags |= TCA_ACT_FLAGS_UNUSED;
+
+	spin_lock(&act->list_lock);
+	list_add_tail(&p4act->node, &act->prealloc_list);
+	spin_unlock(&act->list_lock);
+}
+
+void
+tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4act)
+{
+	if (refcount_read(&p4act->common.tcfa_refcnt) == 1) {
+		__tcf_p4_put_prealloc_act(act, p4act);
+	} else {
+		refcount_dec(&p4act->common.tcfa_refcnt);
+		atomic_dec(&p4act->common.tcfa_bindcnt);
+	}
+}
+
+static const struct nla_policy p4tc_act_params_policy[P4TC_ACT_PARAMS_MAX + 1] = {
+	[P4TC_ACT_PARAMS_NAME] = { .type = NLA_STRING, .len = ACTPARAMNAMSIZ },
+	[P4TC_ACT_PARAMS_ID] = { .type = NLA_U32 },
+	[P4TC_ACT_PARAMS_VALUE] = { .type = NLA_NESTED },
+	[P4TC_ACT_PARAMS_MASK] = { .type = NLA_BINARY },
+	[P4TC_ACT_PARAMS_TYPE] = { .type = NLA_U32 },
+};
+
+static int generic_dump_param_value(struct sk_buff *skb, struct p4tc_type *type,
+				    struct p4tc_act_param *param)
+{
+	const u32 bytesz = BITS_TO_BYTES(type->container_bitsz);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nla_value;
+
+	nla_value = nla_nest_start(skb, P4TC_ACT_PARAMS_VALUE);
+	if (nla_put(skb, P4TC_ACT_PARAMS_VALUE_RAW, bytesz,
+		    param->value))
+		goto out_nlmsg_trim;
+	nla_nest_end(skb, nla_value);
+
+	if (param->mask &&
+	    nla_put(skb, P4TC_ACT_PARAMS_MASK, bytesz, param->mask))
+		goto out_nlmsg_trim;
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int generic_init_param_value(struct p4tc_act_param *nparam,
+				    struct p4tc_type *type, struct nlattr **tb,
+				    struct netlink_ext_ack *extack)
+{
+	const u32 alloc_len = BITS_TO_BYTES(type->container_bitsz);
+	struct nlattr *tb_value[P4TC_ACT_VALUE_PARAMS_MAX + 1];
+	const u32 len = BITS_TO_BYTES(type->bitsz);
+	void *value;
+	int err;
+
+	if (!tb[P4TC_ACT_PARAMS_VALUE]) {
+		NL_SET_ERR_MSG(extack, "Must specify param value");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb_value, P4TC_ACT_VALUE_PARAMS_MAX,
+			       tb[P4TC_ACT_PARAMS_VALUE],
+			       p4tc_act_params_value_policy, extack);
+	if (err < 0)
+		return err;
+
+	value = nla_data(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]);
+	if (type->ops->validate_p4t) {
+		err = type->ops->validate_p4t(type, value, 0, type->bitsz - 1,
+					      extack);
+		if (err < 0)
+			return err;
+	}
+
+	if (nla_len(tb_value[P4TC_ACT_PARAMS_VALUE_RAW]) != len)
+		return -EINVAL;
+
+	nparam->value = kzalloc(alloc_len, GFP_KERNEL);
+	if (!nparam->value)
+		return -ENOMEM;
+
+	memcpy(nparam->value, value, len);
+
+	if (tb[P4TC_ACT_PARAMS_MASK]) {
+		const void *mask = nla_data(tb[P4TC_ACT_PARAMS_MASK]);
+
+		if (nla_len(tb[P4TC_ACT_PARAMS_MASK]) != len) {
+			NL_SET_ERR_MSG(extack,
+				       "Mask length differs from template's");
+			err = -EINVAL;
+			goto free_value;
+		}
+
+		nparam->mask = kzalloc(alloc_len, GFP_KERNEL);
+		if (!nparam->mask) {
+			err = -ENOMEM;
+			goto free_value;
+		}
+
+		memcpy(nparam->mask, mask, len);
+	}
+
+	return 0;
+
+free_value:
+	kfree(nparam->value);
+	return err;
+}
+
+static struct p4tc_act_param *param_find_byname(struct idr *params_idr,
+						const char *param_name)
+{
+	struct p4tc_act_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		if (param == ERR_PTR(-EBUSY))
+			continue;
+		if (strncmp(param->name, param_name, ACTPARAMNAMSIZ) == 0)
+			return param;
+	}
+
+	return NULL;
+}
+
+struct p4tc_act_param *tcf_param_find_byid(struct idr *params_idr,
+					   const u32 param_id)
+{
+	return idr_find(params_idr, param_id);
+}
+
+struct p4tc_act_param *tcf_param_find_byany(struct p4tc_act *act,
+					    const char *param_name,
+					    const u32 param_id,
+					    struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *param;
+	int err;
+
+	if (param_id) {
+		param = tcf_param_find_byid(&act->params_idr, param_id);
+		if (!param) {
+			NL_SET_ERR_MSG(extack, "Unable to find param by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (param_name) {
+			param = param_find_byname(&act->params_idr, param_name);
+			if (!param) {
+				NL_SET_ERR_MSG(extack, "Param name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack, "Must specify param name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return param;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_act_param *
+tcf_param_find_byanyattr(struct p4tc_act *act, struct nlattr *name_attr,
+			 const u32 param_id, struct netlink_ext_ack *extack)
+{
+	char *param_name = NULL;
+
+	if (name_attr)
+		param_name = nla_data(name_attr);
+
+	return tcf_param_find_byany(act, param_name, param_id, extack);
+}
+
+static int tcf_p4_act_init_param(struct net *net,
+				 struct tcf_p4act_params *params,
+				 struct p4tc_act *act, struct nlattr *nla,
+				 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ACT_PARAMS_MAX + 1];
+	struct p4tc_act_param *param, *nparam;
+	struct p4tc_act_param_ops *op;
+	u32 param_id = 0;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_ACT_PARAMS_MAX, nla,
+			       p4tc_act_params_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (tb[P4TC_ACT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_ACT_PARAMS_ID]);
+
+	param = tcf_param_find_byanyattr(act, tb[P4TC_ACT_PARAMS_NAME],
+					 param_id, extack);
+	if (IS_ERR(param))
+		return PTR_ERR(param);
+
+	if (tb[P4TC_ACT_PARAMS_TYPE]) {
+		u32 typeid = nla_get_u32(tb[P4TC_ACT_PARAMS_TYPE]);
+
+		if (param->type->typeid != typeid) {
+			NL_SET_ERR_MSG(extack,
+				       "Param type differs from template");
+			return -EINVAL;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		return -EINVAL;
+	}
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam)
+		return -ENOMEM;
+
+	strscpy(nparam->name, param->name, ACTPARAMNAMSIZ);
+	nparam->type = param->type;
+
+	op = (struct p4tc_act_param_ops *)&param_ops[param->type->typeid];
+	if (op->init_value)
+		err = op->init_value(net, op, nparam, tb, extack);
+	else
+		err = generic_init_param_value(nparam, nparam->type, tb, extack);
+
+	if (err < 0)
+		goto free;
+
+	nparam->id = param->id;
+	nparam->index = param->index;
+
+	err = idr_alloc_u32(&params->params_idr, nparam, &nparam->id,
+			    nparam->id, GFP_KERNEL);
+	if (err < 0)
+		goto free_val;
+
+	params->params_array[param->index] = nparam;
+
+	return 0;
+
+free_val:
+	if (op->free)
+		op->free(nparam);
+	else
+		generic_free_param_value(nparam);
+
+free:
+	kfree(nparam);
+	return err;
+}
+
+static int tcf_p4_act_init_params(struct net *net,
+				  struct tcf_p4act_params *params,
+				  struct p4tc_act *act, struct nlattr *nla,
+				  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	int err;
+	int i;
+
+	err = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, NULL);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		err = tcf_p4_act_init_param(net, params, act, tb[i], extack);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static struct p4tc_act *tcf_action_find_byname(const char *act_name,
+					       struct p4tc_pipeline *pipeline)
+{
+	char full_act_name[ACTPARAMNAMSIZ];
+	unsigned long tmp, id;
+	struct p4tc_act *act;
+
+	snprintf(full_act_name, ACTNAMSIZ, "%s/%s", pipeline->common.name,
+		 act_name);
+	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, id)
+		if (strncmp(act->common.name, full_act_name, ACTNAMSIZ) == 0)
+			return act;
+
+	return NULL;
+}
+
+struct p4tc_act *tcf_p4_find_act(struct net *net,
+				 const struct tc_action_ops *a_o)
+{
+	char *act_name_clone, *act_name, *p_name;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_act *act;
+	int err;
+
+	act_name_clone = act_name = kstrdup(a_o->kind, GFP_KERNEL);
+	if (!act_name)
+		return ERR_PTR(-ENOMEM);
+
+	p_name = strsep(&act_name, SEPARATOR);
+	pipeline = tcf_pipeline_find_byany(net, p_name, 0, NULL);
+	if (IS_ERR(pipeline)) {
+		err = -ENOENT;
+		goto free_act_name;
+	}
+
+	act = tcf_action_find_byname(act_name, pipeline);
+	if (!act) {
+		err = -ENOENT;
+		goto free_act_name;
+	}
+	kfree(act_name_clone);
+
+	return act;
+
+free_act_name:
+	kfree(act_name_clone);
+	return ERR_PTR(err);
+}
+
+static int tcf_p4_dyna_init(struct net *net, struct nlattr *nla,
+			    struct nlattr *est, struct tc_action **a,
+			    struct tcf_proto *tp, struct tc_action_ops *a_o,
+			    u32 flags, struct netlink_ext_ack *extack)
+{
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct nlattr *tb[P4TC_ACT_MAX + 1];
+	struct tcf_chain *goto_ch = NULL;
+	struct tcf_p4act_params *params;
+	struct tc_act_dyna *parm;
+	struct p4tc_act *act;
+	bool exists = false;
+	int ret = 0;
+	int err;
+
+	if (flags & TCA_ACT_FLAGS_BIND &&
+	    !(flags & TCA_ACT_FLAGS_FROM_P4TC)) {
+		NL_SET_ERR_MSG(extack,
+			       "Can only bind to dynamic action from P4TC objects");
+		return -EPERM;
+	}
+
+	if (unlikely(!nla)) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify action netlink attributes");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb, P4TC_ACT_MAX, nla, NULL, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[P4TC_ACT_OPT]) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify option netlink attributes");
+		return -EINVAL;
+	}
+
+	act = tcf_p4_find_act(net, a_o);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	if (!act->active) {
+		NL_SET_ERR_MSG(extack,
+			       "Dynamic action must be active to create instance");
+		return -EINVAL;
+	}
+
+	parm = nla_data(tb[P4TC_ACT_OPT]);
+
+	ret = __tcf_p4_dyna_init(net, est, act, parm, a, tp, a_o, &goto_ch,
+				 flags, extack);
+	if (ret < 0)
+		return ret;
+	if (bind && !ret)
+		return 0;
+
+	err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
+	if (err < 0)
+		goto release_idr;
+
+	params = tcf_p4_act_params_init(act);
+	if (IS_ERR(params)) {
+		err = PTR_ERR(params);
+		goto release_idr;
+	}
+
+	idr_init(&params->params_idr);
+	if (tb[P4TC_ACT_PARMS]) {
+		err = tcf_p4_act_init_params(net, params, act,
+					     tb[P4TC_ACT_PARMS], extack);
+		if (err < 0)
+			goto release_params;
+	} else {
+		if (!idr_is_empty(&act->params_idr)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify action parameters");
+			err = -EINVAL;
+			goto release_params;
+		}
+	}
+
+	exists = ret != ACT_P_CREATED;
+	err = __tcf_p4_dyna_init_set(act, a, params, goto_ch, parm, exists,
+				     extack);
+	if (err < 0)
+		goto release_params;
+
+	return ret;
+
+release_params:
+	tcf_p4_act_params_destroy(params);
+
+release_idr:
+	tcf_idr_release(*a, bind);
+	return err;
+}
+
+static int tcf_p4_act_init_params_list(struct p4tc_act *act,
+				       struct tcf_p4act_params *params,
+				       struct list_head *params_list)
+{
+	struct p4tc_act_param *nparam, *tmp;
+	u32 tot_params_sz = 0;
+	int err;
+
+	list_for_each_entry_safe(nparam, tmp, params_list, head) {
+		err = idr_alloc_u32(&params->params_idr, nparam, &nparam->id,
+				    nparam->id, GFP_KERNEL);
+		if (err < 0)
+			return err;
+		list_del(&nparam->head);
+		params->num_params++;
+		tot_params_sz += nparam->type->container_bitsz;
+	}
+	/* Sum act_id */
+	params->tot_params_sz = tot_params_sz + (sizeof(u32) << 3);
+
+	return 0;
+}
+
+/* This is the action instantiation that is invoked from the template code,
+ * specifically when initialising preallocated dynamic actions.
+ * This functions is analogous to tcf_p4_dyna_init.
+ */
+int tcf_p4_dyna_template_init(struct net *net, struct tc_action **a,
+			      struct p4tc_act *act,
+			      struct list_head *params_list,
+			      struct tc_act_dyna *parm, u32 flags,
+			      struct netlink_ext_ack *extack)
+{
+	bool bind = flags & TCA_ACT_FLAGS_BIND;
+	struct tc_action_ops *a_o = &act->ops;
+	struct tcf_chain *goto_ch = NULL;
+	struct tcf_p4act_params *params;
+	bool exists = false;
+	int ret;
+	int err;
+
+	if (!act->active) {
+		NL_SET_ERR_MSG(extack,
+			       "Dynamic action must be active to create instance");
+		return -EINVAL;
+	}
+
+	ret = __tcf_p4_dyna_init(net, NULL, act, parm, a, NULL, a_o, &goto_ch,
+				 flags, extack);
+	if (ret < 0)
+		return ret;
+
+	err = tcf_action_check_ctrlact(parm->action, NULL, &goto_ch, extack);
+	if (err < 0)
+		goto release_idr;
+
+	params = tcf_p4_act_params_init(act);
+	if (IS_ERR(params)) {
+		err = PTR_ERR(params);
+		goto release_idr;
+	}
+
+	idr_init(&params->params_idr);
+	if (params_list) {
+		err = tcf_p4_act_init_params_list(act, params, params_list);
+		if (err < 0)
+			goto release_params;
+	} else {
+		if (!idr_is_empty(&act->params_idr)) {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify action parameters");
+			err = -EINVAL;
+			goto release_params;
+		}
+	}
+
+	exists = ret != ACT_P_CREATED;
+	err = __tcf_p4_dyna_init_set(act, a, params, goto_ch, parm, exists,
+				     extack);
+	if (err < 0)
+		goto release_params;
+
+	return err;
+
+release_params:
+	tcf_p4_act_params_destroy(params);
+
+release_idr:
+	tcf_idr_release(*a, bind);
+	return err;
+}
+
+static int tcf_p4_dyna_act(struct sk_buff *skb, const struct tc_action *a,
+			   struct tcf_result *res)
+{
+	struct tcf_p4act *dynact = to_p4act(a);
+
+	tcf_lastuse_update(&dynact->tcf_tm);
+	tcf_action_update_bstats(&dynact->common, skb);
+
+	return 0;
+}
+
+static int tcf_p4_dyna_dump(struct sk_buff *skb, struct tc_action *a, int bind,
+			    int ref)
+{
+	struct tcf_p4act *dynact = to_p4act(a);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct tc_act_dyna opt = {
+		.index = dynact->tcf_index,
+		.refcnt = refcount_read(&dynact->tcf_refcnt) - ref,
+		.bindcnt = atomic_read(&dynact->tcf_bindcnt) - bind,
+	};
+	struct tcf_p4act_params *params;
+	struct p4tc_act_param *parm;
+	struct nlattr *nest_parms;
+	struct tcf_t t;
+	int i = 1;
+	int id;
+
+	spin_lock_bh(&dynact->tcf_lock);
+
+	opt.action = dynact->tcf_action;
+	if (nla_put(skb, P4TC_ACT_OPT, sizeof(opt), &opt))
+		goto nla_put_failure;
+
+	if (nla_put_string(skb, P4TC_ACT_NAME, a->ops->kind))
+		goto nla_put_failure;
+
+	tcf_tm_dump(&t, &dynact->tcf_tm);
+	if (nla_put_64bit(skb, P4TC_ACT_TM, sizeof(t), &t, P4TC_ACT_PAD))
+		goto nla_put_failure;
+
+	nest_parms = nla_nest_start(skb, P4TC_ACT_PARMS);
+	if (!nest_parms)
+		goto nla_put_failure;
+
+	params = rcu_dereference_protected(dynact->params, 1);
+	if (params) {
+		idr_for_each_entry(&params->params_idr, parm, id) {
+			struct p4tc_act_param_ops *op;
+			struct nlattr *nest_count;
+
+			nest_count = nla_nest_start(skb, i);
+			if (!nest_count)
+				goto nla_put_failure;
+
+			if (nla_put_string(skb, P4TC_ACT_PARAMS_NAME,
+					   parm->name))
+				goto nla_put_failure;
+
+			if (nla_put_u32(skb, P4TC_ACT_PARAMS_ID, parm->id))
+				goto nla_put_failure;
+
+			op = (struct p4tc_act_param_ops *)&param_ops[parm->type->typeid];
+			if (op->dump_value) {
+				if (op->dump_value(skb, op, parm) < 0)
+					goto nla_put_failure;
+			} else {
+				if (generic_dump_param_value(skb, parm->type, parm))
+					goto nla_put_failure;
+			}
+
+			if (nla_put_u32(skb, P4TC_ACT_PARAMS_TYPE, parm->type->typeid))
+				goto nla_put_failure;
+
+			nla_nest_end(skb, nest_count);
+			i++;
+		}
+	}
+	nla_nest_end(skb, nest_parms);
+
+	spin_unlock_bh(&dynact->tcf_lock);
+
+	return skb->len;
+
+nla_put_failure:
+	spin_unlock_bh(&dynact->tcf_lock);
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int tcf_p4_dyna_lookup(struct net *net, const struct tc_action_ops *ops,
+			      struct tc_action **a, u32 index)
+{
+	struct p4tc_act *act;
+	int err;
+
+	act = tcf_p4_find_act(net, ops);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	err = tcf_idr_search(act->tn, a, index);
+	if (!err)
+		return err;
+
+	if ((*a)->tcfa_flags & TCA_ACT_FLAGS_UNUSED)
+		return false;
+
+	return err;
+}
+
+static int tcf_p4_dyna_walker(struct net *net, struct sk_buff *skb,
+			      struct netlink_callback *cb, int type,
+			      const struct tc_action_ops *ops,
+			      struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act;
+
+	act = tcf_p4_find_act(net, ops);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	return tcf_generic_walker(act->tn, skb, cb, type, ops, extack);
+}
+
+static void tcf_p4_dyna_cleanup(struct tc_action *a)
+{
+	struct tc_action_ops *ops = (struct tc_action_ops *)a->ops;
+	struct tcf_p4act *m = to_p4act(a);
+	struct tcf_p4act_params *params;
+
+	params = rcu_dereference_protected(m->params, 1);
+
+	if (refcount_read(&ops->dyn_ref) > 1)
+		refcount_dec(&ops->dyn_ref);
+
+	if (params)
+		call_rcu(&params->rcu, tcf_p4_act_params_destroy_rcu);
+}
+
+static struct p4tc_act *
+tcf_action_find_byany(struct p4tc_pipeline *pipeline,
+		      const char *act_name, const u32 a_id,
+		      struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act;
+	int err;
+
+	if (a_id) {
+		act = tcf_action_find_byid(pipeline, a_id);
+		if (!act) {
+			NL_SET_ERR_MSG(extack, "Unable to find action by id");
+			err = -ENOENT;
+			goto out;
+		}
+	} else {
+		if (act_name) {
+			act = tcf_action_find_byname(act_name, pipeline);
+			if (!act) {
+				NL_SET_ERR_MSG(extack, "Action name not found");
+				err = -ENOENT;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify action name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return act;
+
+out:
+	return ERR_PTR(err);
+}
+
+struct p4tc_act *tcf_action_find_get(struct p4tc_pipeline *pipeline,
+				     const char *act_name, const u32 a_id,
+				     struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act;
+
+	act = tcf_action_find_byany(pipeline, act_name, a_id, extack);
+	if (IS_ERR(act))
+		return act;
+
+	if (!refcount_inc_not_zero(&act->a_ref)) {
+		NL_SET_ERR_MSG(extack, "Action is stale");
+		return ERR_PTR(-EBUSY);
+	}
+
+	return act;
+}
+
+static struct p4tc_act *
+tcf_action_find_byanyattr(struct nlattr *act_name_attr, const u32 a_id,
+			  struct p4tc_pipeline *pipeline,
+			  struct netlink_ext_ack *extack)
+{
+	char *act_name = NULL;
+
+	if (act_name_attr)
+		act_name = nla_data(act_name_attr);
+
+	return tcf_action_find_byany(pipeline, act_name, a_id, extack);
+}
+
+static void p4_put_param(struct idr *params_idr, struct p4tc_act_param *param)
+{
+	kfree(param);
+}
+
+static void p4_put_many_params(struct idr *params_idr,
+			       struct p4tc_act_param *params[],
+			       int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++)
+		p4_put_param(params_idr, params[i]);
+}
+
+static struct p4tc_act_param *p4_create_param(struct p4tc_act *act,
+					      struct nlattr **tb, u32 param_id,
+					      struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *param;
+	char *name;
+	int ret;
+
+	if (tb[P4TC_ACT_PARAMS_NAME]) {
+		name = nla_data(tb[P4TC_ACT_PARAMS_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	param = kmalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (tcf_param_find_byid(&act->params_idr, param_id) ||
+	    param_find_byname(&act->params_idr, name)) {
+		NL_SET_ERR_MSG(extack, "Param already exists");
+		ret = -EEXIST;
+		goto free;
+	}
+
+	if (tb[P4TC_ACT_PARAMS_TYPE]) {
+		u32 typeid;
+
+		typeid = nla_get_u32(tb[P4TC_ACT_PARAMS_TYPE]);
+		param->type = p4type_find_byid(typeid);
+		if (!param->type) {
+			NL_SET_ERR_MSG(extack, "Param type is invalid");
+			ret = -EINVAL;
+			goto free;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (param_id) {
+		ret = idr_alloc_u32(&act->params_idr, param, &param_id,
+				    param_id, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free;
+		}
+		param->id = param_id;
+	} else {
+		param->id = 1;
+
+		ret = idr_alloc_u32(&act->params_idr, param, &param->id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free;
+		}
+	}
+
+	strscpy(param->name, name, ACTPARAMNAMSIZ);
+
+	return param;
+
+free:
+	kfree(param);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_act_param *p4_update_param(struct p4tc_act *act,
+					      struct nlattr **tb,
+					      const u32 param_id,
+					      struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *param_old, *param;
+	int ret;
+
+	param_old = tcf_param_find_byanyattr(act, tb[P4TC_ACT_PARAMS_NAME],
+					     param_id, extack);
+	if (IS_ERR(param_old))
+		return param_old;
+
+	param = kmalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	strscpy(param->name, param_old->name, ACTPARAMNAMSIZ);
+	param->id = param_old->id;
+
+	if (tb[P4TC_ACT_PARAMS_TYPE]) {
+		u32 typeid;
+
+		typeid = nla_get_u32(tb[P4TC_ACT_PARAMS_TYPE]);
+		param->type = p4type_find_byid(typeid);
+		if (!param->type) {
+			NL_SET_ERR_MSG(extack, "Param type is invalid");
+			ret = -EINVAL;
+			goto free;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	return param;
+
+free:
+	kfree(param);
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_act_param *p4_act_init_param(struct p4tc_act *act,
+						struct nlattr *nla, bool update,
+						struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ACT_PARAMS_MAX + 1];
+	u32 param_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ACT_PARAMS_MAX, nla, NULL, extack);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tb[P4TC_ACT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_ACT_PARAMS_ID]);
+
+	if (update)
+		return p4_update_param(act, tb, param_id, extack);
+	else
+		return p4_create_param(act, tb, param_id, extack);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static int p4_act_init_params(struct p4tc_act *act, struct nlattr *nla,
+			      struct p4tc_act_param *params[], bool update,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	int ret;
+	int i;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (ret < 0)
+		return -EINVAL;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		struct p4tc_act_param *param;
+
+		param = p4_act_init_param(act, tb[i], update, extack);
+		if (IS_ERR(param)) {
+			ret = PTR_ERR(param);
+			goto params_del;
+		}
+		params[i - 1] = param;
+	}
+
+	return i - 1;
+
+params_del:
+	p4_put_many_params(&act->params_idr, params, i - 1);
+	return ret;
+}
+
+static int p4_act_init(struct p4tc_act *act, struct nlattr *nla,
+		       struct p4tc_act_param *params[],
+		       struct netlink_ext_ack *extack)
+{
+	int num_params = 0;
+	int ret;
+
+	idr_init(&act->params_idr);
+
+	if (nla) {
+		num_params =
+			p4_act_init_params(act, nla, params, false, extack);
+		if (num_params < 0) {
+			ret = num_params;
+			goto idr_destroy;
+		}
+	}
+
+	return num_params;
+
+idr_destroy:
+	p4_put_many_params(&act->params_idr, params, num_params);
+	idr_destroy(&act->params_idr);
+	return ret;
+}
+
+static const struct nla_policy p4tc_act_policy[P4TC_ACT_MAX + 1] = {
+	[P4TC_ACT_NAME] = { .type = NLA_STRING, .len = ACTNAMSIZ },
+	[P4TC_ACT_PARMS] = { .type = NLA_NESTED },
+	[P4TC_ACT_OPT] = { .type = NLA_BINARY,
+			   .len = sizeof(struct tc_act_dyna) },
+	[P4TC_ACT_NUM_PREALLOC] = { .type = NLA_U32 },
+	[P4TC_ACT_ACTIVE] = { .type = NLA_U8 },
+};
+
+static inline void p4tc_action_net_exit(struct tc_action_net *tn)
+{
+	tcf_idrinfo_destroy(tn->ops, tn->idrinfo);
+	kfree(tn->idrinfo);
+	kfree(tn);
+}
+
+static int __tcf_act_put(struct net *net, struct p4tc_pipeline *pipeline,
+			 struct p4tc_act *act, bool teardown,
+			 struct netlink_ext_ack *extack)
+{
+	struct tcf_p4act *p4act, *tmp_act;
+	struct p4tc_act_param *act_param;
+	unsigned long param_id, tmp;
+	struct tc_action_net *tn;
+
+	if (!teardown && (refcount_read(&act->ops.dyn_ref) > 1 ||
+			  refcount_read(&act->a_ref) > 1)) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to delete referenced action template");
+		return -EBUSY;
+	}
+
+	tn = net_generic(net, act->ops.net_id);
+
+	idr_for_each_entry_ul(&act->params_idr, act_param, tmp, param_id) {
+		idr_remove(&act->params_idr, param_id);
+		kfree(act_param);
+	}
+
+	tcf_unregister_dyn_action(net, &act->ops);
+	/* Free preallocated acts */
+	list_for_each_entry_safe(p4act, tmp_act, &act->prealloc_list, node) {
+		list_del(&p4act->node);
+		tcf_idr_release(&p4act->common, true);
+	}
+	p4tc_action_net_exit(act->tn);
+
+	idr_remove(&pipeline->p_act_idr, act->a_id);
+
+	list_del(&act->head);
+
+	kfree(act);
+
+	pipeline->num_created_acts--;
+
+	return 0;
+}
+
+static int _tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
+			       struct p4tc_act *act)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_act_param *param;
+	struct nlattr *nest, *parms;
+	unsigned long param_id, tmp;
+	int i = 1;
+
+	if (nla_put_u32(skb, P4TC_PATH, act->a_id))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	if (nla_put_string(skb, P4TC_ACT_NAME, act->common.name))
+		goto out_nlmsg_trim;
+
+	parms = nla_nest_start(skb, P4TC_ACT_PARMS);
+	if (!parms)
+		goto out_nlmsg_trim;
+
+	idr_for_each_entry_ul(&act->params_idr, param, tmp, param_id) {
+		struct nlattr *nest_count;
+
+		nest_count = nla_nest_start(skb, i);
+		if (!nest_count)
+			goto out_nlmsg_trim;
+
+		if (nla_put_string(skb, P4TC_ACT_PARAMS_NAME, param->name))
+			goto out_nlmsg_trim;
+
+		if (nla_put_u32(skb, P4TC_ACT_PARAMS_ID, param->id))
+			goto out_nlmsg_trim;
+
+		if (nla_put_u32(skb, P4TC_ACT_PARAMS_TYPE, param->type->typeid))
+			goto out_nlmsg_trim;
+
+		nla_nest_end(skb, nest_count);
+		i++;
+	}
+	nla_nest_end(skb, parms);
+
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int tcf_act_fill_nlmsg(struct net *net, struct sk_buff *skb,
+			      struct p4tc_template_common *tmpl,
+			      struct netlink_ext_ack *extack)
+{
+	return _tcf_act_fill_nlmsg(net, skb, to_act(tmpl));
+}
+
+static int tcf_act_flush(struct sk_buff *skb, struct net *net,
+			 struct p4tc_pipeline *pipeline,
+			 struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	unsigned long tmp, act_id;
+	struct p4tc_act *act;
+	int ret = 0;
+	int i = 0;
+
+	if (nla_put_u32(skb, P4TC_PATH, 0))
+		goto out_nlmsg_trim;
+
+	if (idr_is_empty(&pipeline->p_act_idr)) {
+		NL_SET_ERR_MSG(extack,
+			       "There are not action templates to flush");
+		goto out_nlmsg_trim;
+	}
+
+	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, act_id) {
+		if (__tcf_act_put(net, pipeline, act, false, extack) < 0) {
+			ret = -EBUSY;
+			continue;
+		}
+		i++;
+	}
+
+	nla_put_u32(skb, P4TC_COUNT, i);
+
+	if (ret < 0) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush any action template");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush all action templates");
+		}
+	}
+
+	return i;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static int tcf_act_gd(struct net *net, struct sk_buff *skb, struct nlmsghdr *n,
+		      struct nlattr *nla, struct p4tc_nl_pname *nl_pname,
+		      u32 *ids, struct netlink_ext_ack *extack)
+{
+	const u32 pipeid = ids[P4TC_PID_IDX], a_id = ids[P4TC_AID_IDX];
+	struct nlattr *tb[P4TC_ACT_MAX + 1] = { NULL };
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_act *act;
+	int ret = 0;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE)
+		pipeline = tcf_pipeline_find_byany_unsealed(net, nl_pname->data,
+							    pipeid, extack);
+	else
+		pipeline = tcf_pipeline_find_byany(net, nl_pname->data, pipeid,
+						   extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_ACT_MAX, nla, p4tc_act_policy,
+				       extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && (n->nlmsg_flags & NLM_F_ROOT))
+		return tcf_act_flush(skb, net, pipeline, extack);
+
+	act = tcf_action_find_byanyattr(tb[P4TC_ACT_NAME], a_id, pipeline,
+					extack);
+	if (IS_ERR(act))
+		return PTR_ERR(act);
+
+	if (_tcf_act_fill_nlmsg(net, skb, act) < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for template action");
+		return -EINVAL;
+	}
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = __tcf_act_put(net, pipeline, act, false, extack);
+		if (ret < 0)
+			goto out_nlmsg_trim;
+	}
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static int tcf_act_put(struct p4tc_pipeline *pipeline,
+		       struct p4tc_template_common *tmpl,
+		       struct netlink_ext_ack *extack)
+{
+	struct p4tc_act *act = to_act(tmpl);
+
+	return __tcf_act_put(pipeline->net, pipeline, act, true, extack);
+}
+
+static void p4tc_params_replace_many(struct idr *params_idr,
+				     struct p4tc_act_param *params[],
+				     int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++) {
+		struct p4tc_act_param *param = params[i];
+
+		param = idr_replace(params_idr, param, param->id);
+		kfree(param);
+	}
+}
+
+static struct p4tc_act *tcf_act_create(struct net *net, struct nlattr **tb,
+				       struct p4tc_pipeline *pipeline, u32 *ids,
+				       struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *params[P4TC_MSGBATCH_SIZE] = { NULL };
+	u32 a_id = ids[P4TC_AID_IDX];
+	struct p4tc_act *act;
+	int num_params = 0;
+	char *act_name;
+	int ret = 0;
+
+	if (tb[P4TC_ACT_NAME]) {
+		act_name = nla_data(tb[P4TC_ACT_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must supply action name");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if ((tcf_action_find_byname(act_name, pipeline))) {
+		NL_SET_ERR_MSG(extack, "Action already exists with same name");
+		return ERR_PTR(-EEXIST);
+	}
+
+	if (tcf_action_find_byid(pipeline, a_id)) {
+		NL_SET_ERR_MSG(extack, "Action already exists with same id");
+		return ERR_PTR(-EEXIST);
+	}
+
+	act = kzalloc(sizeof(*act), GFP_KERNEL);
+	if (!act)
+		return ERR_PTR(-ENOMEM);
+
+	act->ops.owner = THIS_MODULE;
+	act->ops.act = tcf_p4_dyna_act;
+	act->ops.dump = tcf_p4_dyna_dump;
+	act->ops.cleanup = tcf_p4_dyna_cleanup;
+	act->ops.init_ops = tcf_p4_dyna_init;
+	act->ops.lookup = tcf_p4_dyna_lookup;
+	act->ops.walk = tcf_p4_dyna_walker;
+	act->ops.size = sizeof(struct tcf_p4act);
+	INIT_LIST_HEAD(&act->head);
+
+	act->tn = kzalloc(sizeof(*act->tn), GFP_KERNEL);
+	if (!act->tn) {
+		ret = -ENOMEM;
+		goto free_act_ops;
+	}
+
+	ret = tc_action_net_init(net, act->tn, &act->ops);
+	if (ret < 0) {
+		kfree(act->tn);
+		goto free_act_ops;
+	}
+	act->tn->ops = &act->ops;
+
+	snprintf(act->ops.kind, ACTNAMSIZ, "%s/%s", pipeline->common.name,
+		 act_name);
+
+	if (a_id) {
+		ret = idr_alloc_u32(&pipeline->p_act_idr, act, &a_id, a_id,
+				    GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to alloc action id");
+			goto free_action_net;
+		}
+
+		act->a_id = a_id;
+	} else {
+		act->a_id = 1;
+
+		ret = idr_alloc_u32(&pipeline->p_act_idr, act, &act->a_id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to alloc action id");
+			goto free_action_net;
+		}
+	}
+
+	if (tb[P4TC_ACT_NUM_PREALLOC]) {
+		u32 *num_prealloc_acts = nla_data(tb[P4TC_ACT_NUM_PREALLOC]);
+
+		act->num_prealloc_acts = *num_prealloc_acts;
+	}
+
+	refcount_set(&act->ops.dyn_ref, 1);
+	ret = tcf_register_dyn_action(net, &act->ops);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to register new action template");
+		goto idr_rm;
+	}
+
+	num_params = p4_act_init(act, tb[P4TC_ACT_PARMS], params, extack);
+	if (num_params < 0) {
+		ret = num_params;
+		goto unregister;
+	}
+	act->num_params = num_params;
+
+	set_param_indices(act);
+
+	act->pipeline = pipeline;
+
+	pipeline->num_created_acts++;
+
+	act->common.p_id = pipeline->common.p_id;
+	snprintf(act->common.name, ACTNAMSIZ, "%s/%s", pipeline->common.name,
+		 act_name);
+	act->common.ops = (struct p4tc_template_ops *)&p4tc_act_ops;
+
+	refcount_set(&act->a_ref, 1);
+
+	list_add_tail(&act->head, &dynact_list);
+	INIT_LIST_HEAD(&act->prealloc_list);
+	spin_lock_init(&act->list_lock);
+
+	return act;
+
+unregister:
+	rtnl_unlock();
+	tcf_unregister_dyn_action(net, &act->ops);
+	rtnl_lock();
+
+idr_rm:
+	idr_remove(&pipeline->p_act_idr, act->a_id);
+
+free_action_net:
+	p4tc_action_net_exit(act->tn);
+
+free_act_ops:
+	kfree(act);
+
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_act *tcf_act_update(struct net *net, struct nlattr **tb,
+				       struct p4tc_pipeline *pipeline, u32 *ids,
+				       u32 flags,
+				       struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *params[P4TC_MSGBATCH_SIZE] = { NULL };
+	const u32 a_id = ids[P4TC_AID_IDX];
+	u32 *num_prealloc_acts = NULL;
+	struct p4tc_act *act;
+	int num_params = 0;
+	s8 active = -1;
+	int ret = 0;
+
+	act = tcf_action_find_byanyattr(tb[P4TC_ACT_NAME], a_id, pipeline,
+					extack);
+	if (IS_ERR(act))
+		return act;
+
+	if (tb[P4TC_ACT_ACTIVE])
+		active = nla_get_u8(tb[P4TC_ACT_ACTIVE]);
+
+	if (act->active) {
+		if (!active) {
+			if (refcount_read(&act->ops.dyn_ref) > 1) {
+				NL_SET_ERR_MSG(extack,
+					       "Unable to inactivate referenced action");
+				return ERR_PTR(-EINVAL);
+			}
+			act->active = false;
+			return act;
+		}
+		NL_SET_ERR_MSG(extack, "Unable to update active action");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (tb[P4TC_ACT_PARMS]) {
+		num_params = p4_act_init_params(act, tb[P4TC_ACT_PARMS], params,
+						true, extack);
+		if (num_params < 0) {
+			ret = num_params;
+			goto out;
+		}
+		set_param_indices(act);
+	}
+
+	if (tb[P4TC_ACT_NUM_PREALLOC])
+		num_prealloc_acts = nla_data(tb[P4TC_ACT_NUM_PREALLOC]);
+
+	act->pipeline = pipeline;
+	if (active == 1) {
+		act->active = true;
+	} else if (!active) {
+		NL_SET_ERR_MSG(extack, "Action is already inactive");
+		ret = -EINVAL;
+		goto params_del;
+	}
+
+	if (num_prealloc_acts)
+		act->num_prealloc_acts = *num_prealloc_acts;
+
+	p4tc_params_replace_many(&act->params_idr, params, num_params);
+	return act;
+
+params_del:
+	p4_put_many_params(&act->params_idr, params, num_params);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+tcf_act_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+	   struct p4tc_nl_pname *nl_pname, u32 *ids,
+	   struct netlink_ext_ack *extack)
+{
+	const u32 pipeid = ids[P4TC_PID_IDX];
+	struct nlattr *tb[P4TC_ACT_MAX + 1];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_act *act;
+	int ret;
+
+	pipeline = tcf_pipeline_find_byany_unsealed(net, nl_pname->data, pipeid,
+						    extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	ret = nla_parse_nested(tb, P4TC_ACT_MAX, nla, p4tc_act_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+		act = tcf_act_create(net, tb, pipeline, ids, extack);
+		break;
+	case RTM_UPDATEP4TEMPLATE:
+		act = tcf_act_update(net, tb, pipeline, ids, n->nlmsg_flags,
+				     extack);
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR(act))
+		goto out;
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+out:
+	return (struct p4tc_template_common *)act;
+}
+
+static int tcf_act_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			struct nlattr *nla, char **p_name, u32 *ids,
+			struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+
+	if (!ctx->ids[P4TC_PID_IDX]) {
+		pipeline = tcf_pipeline_find_byany(net, *p_name,
+						   ids[P4TC_PID_IDX], extack);
+		if (IS_ERR(pipeline))
+			return PTR_ERR(pipeline);
+		ctx->ids[P4TC_PID_IDX] = pipeline->common.p_id;
+	} else {
+		pipeline = tcf_pipeline_find_byid(net, ctx->ids[P4TC_PID_IDX]);
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	return tcf_p4_tmpl_generic_dump(skb, ctx, &pipeline->p_act_idr,
+					P4TC_AID_IDX, extack);
+}
+
+static int tcf_act_dump_1(struct sk_buff *skb,
+			  struct p4tc_template_common *common)
+{
+	struct nlattr *param = nla_nest_start(skb, P4TC_PARAMS);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_act *act = to_act(common);
+
+	if (!param)
+		goto out_nlmsg_trim;
+
+	if (nla_put_string(skb, P4TC_ACT_NAME, act->common.name))
+		goto out_nlmsg_trim;
+
+	if (nla_put_u8(skb, P4TC_ACT_ACTIVE, act->active))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, param);
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+const struct p4tc_template_ops p4tc_act_ops = {
+	.init = NULL,
+	.cu = tcf_act_cu,
+	.put = tcf_act_put,
+	.gd = tcf_act_gd,
+	.fill_nlmsg = tcf_act_fill_nlmsg,
+	.dump = tcf_act_dump,
+	.dump_1 = tcf_act_dump_1,
+};
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 9d6d5ba3e..94169a52d 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -74,6 +74,8 @@ static const struct nla_policy tc_pipeline_policy[P4TC_PIPELINE_MAX + 1] = {
 
 static void tcf_pipeline_destroy(struct p4tc_pipeline *pipeline)
 {
+	idr_destroy(&pipeline->p_act_idr);
+
 	kfree(pipeline);
 }
 
@@ -95,8 +97,12 @@ static void tcf_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	struct net *net = pipeline->net;
 	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
 	struct net *pipeline_net = maybe_get_net(net);
+	unsigned long iter_act_id;
+	struct p4tc_act *act;
+	unsigned long tmp;
 
-	idr_remove(&pipe_net->pipeline_idr, pipeline->common.p_id);
+	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, iter_act_id)
+		act->common.ops->put(pipeline, &act->common, extack);
 
 	if (pipeline->parser)
 		tcf_parser_del(net, pipeline, pipeline->parser, extack);
@@ -147,14 +153,44 @@ static int __tcf_pipeline_put(struct p4tc_pipeline *pipeline,
 static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 					       struct netlink_ext_ack *extack)
 {
+	struct tc_action ***prealloc_acts;
+	int act_kinds_with_prealloc;
+	int ret;
+	int i;
+
 	if (pipeline->curr_tables != pipeline->num_tables) {
 		NL_SET_ERR_MSG(extack,
 			       "Must have all table defined to update state to ready");
 		return -EINVAL;
 	}
 
+	prealloc_acts = kcalloc(pipeline->num_created_acts,
+				sizeof(*prealloc_acts), GFP_KERNEL);
+	if (!prealloc_acts)
+		return -ENOMEM;
+
+	act_kinds_with_prealloc = tcf_p4_prealloc_acts(pipeline, prealloc_acts,
+						       extack);
+	if (act_kinds_with_prealloc < 0) {
+		ret = act_kinds_with_prealloc;
+		goto free_prealloc_acts;
+	}
+
 	pipeline->p_state = P4TC_STATE_READY;
+
+	for (i = 0; i < act_kinds_with_prealloc; i++) {
+		tcf_p4_prealloc_list_add(pipeline, prealloc_acts[i]);
+		kfree(prealloc_acts[i]);
+	}
+
+	kfree(prealloc_acts);
+
 	return true;
+
+free_prealloc_acts:
+	kfree(prealloc_acts);
+
+	return ret;
 }
 
 static inline bool pipeline_sealed(struct p4tc_pipeline *pipeline)
@@ -253,6 +289,10 @@ static struct p4tc_pipeline *tcf_pipeline_create(struct net *net,
 
 	pipeline->parser = NULL;
 
+	idr_init(&pipeline->p_act_idr);
+
+	pipeline->num_created_acts = 0;
+
 	pipeline->p_state = P4TC_STATE_NOT_READY;
 
 	pipeline->net = net;
@@ -501,7 +541,8 @@ static int tcf_pipeline_gd(struct net *net, struct sk_buff *skb,
 		return PTR_ERR(pipeline);
 
 	tmpl = (struct p4tc_template_common *)pipeline;
-	if (tcf_pipeline_fill_nlmsg(net, skb, tmpl, extack) < 0)
+	ret = tcf_pipeline_fill_nlmsg(net, skb, tmpl, extack);
+	if (ret < 0)
 		return -1;
 
 	if (!ids[P4TC_PID_IDX])
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index ad1a22a29..042a540a6 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -43,6 +43,7 @@ static bool obj_is_valid(u32 obj)
 	switch (obj) {
 	case P4TC_OBJ_PIPELINE:
 	case P4TC_OBJ_HDR_FIELD:
+	case P4TC_OBJ_ACT:
 		return true;
 	default:
 		return false;
@@ -52,6 +53,7 @@ static bool obj_is_valid(u32 obj)
 static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX] = {
 	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
 	[P4TC_OBJ_HDR_FIELD] = &p4tc_hdrfield_ops,
+	[P4TC_OBJ_ACT] = &p4tc_act_ops,
 };
 
 int tcf_p4_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
-- 
2.34.1


