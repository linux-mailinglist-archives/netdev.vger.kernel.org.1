Return-Path: <netdev+bounces-23176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979276B393
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84B12818DD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8791D23BE0;
	Tue,  1 Aug 2023 11:38:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A080214EC
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:52 +0000 (UTC)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D61B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:47 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-63d0228d32bso30432986d6.2
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889926; x=1691494726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PwCmsOnu4VvaNBKyBiOHkIbil06vRQU6OrgBkl1outY=;
        b=qM3IeWmcpNbNxyJvMqxgIk5qkslEMb5UmKVet+4A1xcNEtBAmIVTfqweriigRk3GTq
         L1EPaJsWudQ/7mpL7GLpo3emZe3yxgVPSLkjr2Khvr9StLCfAXQrTYc9uMZ5YmL6nQVC
         Gh6JRfKUGrfq/Golb1EQyDv5KTYQYyTRZOoOPKtJ0tQx6g5+KTDhBWVq+ValQQ6nQ4X2
         SlAiL3RMvVclxmEMK0RpUjksfz6jKkF452Bclj5/4q4rd/3U1wPJ/FkbotTYpqbk9P77
         wOpAf0M6+mhLJF6Q+NTFCbos52wpNimx7rD/6ygwQKOU5saEMY8htyvGaRGTri60Ope/
         jA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889926; x=1691494726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwCmsOnu4VvaNBKyBiOHkIbil06vRQU6OrgBkl1outY=;
        b=JPwmHEsv5vqgFI37swy+fuJqoGMZuVx5gggvqdCaxOmQrMK45cEAKM/WV0qQNVgh9Z
         NhvBQvAWjqLNgyWPJnE2UbwtC6eKUNeTkRfoNGY9Ug63kFumH8s3xK8wEtnzSUzxdIU1
         fY9RyzBwH00kzrdtjIfssbV/eD+ruK5I1vsxI4PcyEhmDj/dQqXbZpczVBjfqvUY3HJJ
         fbZjC+vkB8l7AxDlfKO0wvSI0TQ4l1yJrIkpWv/lrdjmEyiAVdbEQb2Q0PT5UjdIvyBc
         +d4g+Zq0hAYKZBAv8lxPvs8M/cHBxzbYR/tuLtzdpG72espolc2pElXVNBMFuaO7dL+c
         v3UQ==
X-Gm-Message-State: ABy/qLYkYREmOrcZTi2/auHfI4JTFogAVkpiH0sbf8CypGLYRWEpwt3/
	jlxYCDyZaakakfgdfrzE9W3qvRjCPBgujyb7Nie9jA==
X-Google-Smtp-Source: APBJJlH/pr2E32Ysj9I4UB16cAwvjEcfpQABqO7ThyaHYaCwaXlLkH3QFpzAkabotzRneNXhaGuXpA==
X-Received: by 2002:ad4:45a8:0:b0:63d:3a7:3aa6 with SMTP id y8-20020ad445a8000000b0063d03a73aa6mr12005644qvu.44.1690889925037;
        Tue, 01 Aug 2023 04:38:45 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:44 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 17/23] p4tc: Add P4 extern interface
Date: Tue,  1 Aug 2023 07:38:01 -0400
Message-Id: <20230801113807.85473-18-jhs@mojatatu.com>
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

P4 externs are an abstraction in the language to call for extending
language functionality. For example, the function that sends a packet to a
specific port (send_to_port) in P4 PNA is an extern.

Externs can be seen as classes, which have constructors and methods.
Take, for example, the Register extern definition:

extern Register<T> {
    Register(@tc_numel bit<32> size);
    @tc_md_read T read(@tc_key bit<32> index);
    @tc_md_write void write(@tc_key bit<32> index, @tc_data T value);
}

@ControlPath {
       @tc_key bit<32> index;
       @tc_data T value;
    }
}

Which can then be instantiated within a P4 program as:
Register<bit<32>>(128) reg1;
Register<bit<16>>(1024) reg2;

Will be abstracted into the template by the P4C compiler for "reg1" as
follows:

tc p4template create extern/root/register extid 10 numinstances 2
tc p4template create extern_inst/aP4Proggie/register/reg1 instid 1 \
method read method_id 1 param index type bit32 \
method write method_id 2 param index type bit32 param value type bit32 \
control_path tc_key index type bit32 tc_data value type bit32 \
numelemens 128 default_value 22

=========================EXTERN RUNTIME COMMANDS=========================

Once we seal the pipeline, the index values will be assigned to the default
value specified on the template as "default_value". After sealing, we can
update the runtime instance element with the value 33, as is done below:

tc p4runtime update aP4proggie/extern/register/reg1 tc_key index 2 \
tc_data value 33

We can also get its value:

tc p4runtime get aP4proggie/extern/register/reg1 tc_key index 2

Which will yield the following output:

total exts 0
        extern order 1:
          tc_key index id 1 type bit32 value: 1
          tc_data value id 2 type bit32 value: 33

We can also dump all of the elements in this register:

tc p4runtime get aP4proggie/extern/register/reg1

Note that the only valid runtime operations are get and update.

=========================EXTERN P4 Runtime =========================

The generated ebpf code invokes the externs in the P4TC domain
using the md_read or md_write kfuncs, for example:
if the P4 program had this invocation:

tmp1 = reg1.read(index1);

Then equivalent generated ebpf code is as follows:

param.pipe_id = aP4Proggie_ID;
param.ext_id = EXTERN_REGISTER;
param.inst_id = EXTERN_REGISTER_INSTANCE_ID1;
param.index = index1;
param.param_id = EXTERN_REGISTER_PARAM_ID;
bpf_p4tc_extern_md_read_skb(skb, &res, &param);
tmp1 = (u32 *)res.params;

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h                |  133 ++
 include/net/p4tc_ext_api.h        |   97 ++
 include/uapi/linux/p4tc.h         |   64 +
 include/uapi/linux/p4tc_ext.h     |   39 +
 net/sched/p4tc/Makefile           |    3 +-
 net/sched/p4tc/p4tc_bpf.c         |   79 +-
 net/sched/p4tc/p4tc_ext.c         | 2035 ++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c    |   31 +-
 net/sched/p4tc/p4tc_runtime_api.c |    9 +
 net/sched/p4tc/p4tc_table.c       |    3 +-
 net/sched/p4tc/p4tc_tmpl_api.c    |    4 +
 net/sched/p4tc/p4tc_tmpl_ext.c    | 2415 +++++++++++++++++++++++++++++
 12 files changed, 4906 insertions(+), 6 deletions(-)
 create mode 100644 include/net/p4tc_ext_api.h
 create mode 100644 include/uapi/linux/p4tc_ext.h
 create mode 100644 net/sched/p4tc/p4tc_ext.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_ext.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index dbefaa305..8887e13ae 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -11,6 +11,7 @@
 #include <linux/rhashtable-types.h>
 #include <net/tc_act/p4tc.h>
 #include <net/p4tc_types.h>
+#include <linux/bpf.h>
 
 #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
 #define P4TC_DEFAULT_MAX_RULES 1
@@ -21,6 +22,10 @@
 #define P4TC_DEFAULT_TMASKS 8
 #define P4TC_MAX_T_AGING 864000000
 #define P4TC_DEFAULT_T_AGING 259200000
+#define P4TC_DEFAULT_NUM_EXT_INSTS 1
+#define P4TC_MAX_NUM_EXT_INSTS (1 << 10)
+#define P4TC_DEFAULT_NUM_EXT_INST_ELEMS 1
+#define P4TC_MAX_NUM_EXT_INST_ELEMS (1 << 10)
 
 #define P4TC_MAX_PERMISSION (GENMASK(P4TC_PERM_MAX_BIT, 0))
 
@@ -31,6 +36,8 @@
 #define P4TC_AID_IDX 1
 #define P4TC_PARSEID_IDX 1
 #define P4TC_HDRFIELDID_IDX 2
+#define P4TC_TMPL_EXT_IDX 1
+#define P4TC_TMPL_EXT_INST_IDX 2
 
 #define P4TC_HDRFIELD_IS_VALIDITY_BIT 0x1
 
@@ -82,10 +89,15 @@ struct p4tc_pipeline {
 	struct p4tc_template_common common;
 	struct idr                  p_act_idr;
 	struct idr                  p_tbl_idr;
+	/* IDR where the externs are stored globally in the root pipeline */
+	struct idr                  p_ext_idr;
+	/* IDR where the per user pipeline data related to externs is stored */
+	struct idr                  user_ext_idr;
 	struct rcu_head             rcu;
 	struct net                  *net;
 	struct p4tc_parser          *parser;
 	u32                         num_created_acts;
+	u32                         num_created_ext_elems;
 	refcount_t                  p_ctrl_ref;
 	u16                         num_tables;
 	u16                         curr_tables;
@@ -205,6 +217,27 @@ struct p4tc_table_entry_act_bpf {
 	u8 params[P4TC_MAX_PARAM_DATA_SIZE];
 } __packed;
 
+#define P4TC_EXT_FLAGS_UNSPEC 0x0
+#define P4TC_EXT_FLAGS_CONTROL_READ 0x1
+#define P4TC_EXT_FLAGS_CONTROL_WRITE 0x2
+
+struct p4tc_ext_bpf_params {
+	u32 pipe_id;
+	u32 ext_id;
+	u32 inst_id;
+	u32 index;
+	u32 method_id;
+	u32 param_id;
+	u8  in_params[128]; /* extern specific params if any */
+};
+
+struct p4tc_ext_bpf_res {
+	u32 ext_id;
+	u32 index_id;
+	u32 verdict;
+	u8 out_params[128]; /* specific values if any */
+};
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
 	struct p4tc_table_entry_act_bpf *defact_bpf;
@@ -636,9 +669,109 @@ static inline bool p4tc_runtime_msg_is_update(struct nlmsghdr *n)
 	return n->nlmsg_type == RTM_P4TC_UPDATE;
 }
 
+struct p4tc_user_pipeline_extern {
+	char			ext_name[EXTERNNAMSIZ];
+	struct idr		e_inst_idr;
+	struct p4tc_tmpl_extern	*tmpl_ext;
+	void (*free)(struct p4tc_user_pipeline_extern *pipe_ext,
+		     struct idr *tmpl_exts_idr);
+	u32			ext_id;
+	refcount_t		ext_ref;
+	refcount_t              curr_insts_num;
+};
+
+struct p4tc_tmpl_extern {
+	struct p4tc_template_common  common;
+	struct idr                   params_idr;
+	char                         mod_name[MODULE_NAME_LEN];
+	const struct p4tc_extern_ops *ops;
+	u32                          ext_id;
+	u32                          num_params;
+	u32                          max_num_insts;
+	refcount_t                   tmpl_ref;
+};
+
+struct p4tc_extern_method {
+	char		method_name[METHODNAMSIZ];
+	struct idr	params_idr;
+	struct rcu_head	rcu;
+	u32		method_id;
+	u32		num_params;
+};
+
+struct p4tc_extern_inst_common {
+	struct idr methods_idr;
+	struct idr control_params_idr;
+	struct idr control_elems_idr;
+	u32	   num_control_params;
+	u32        num_elems;
+	u32	   num_methods;
+};
+
+struct p4tc_ext_bpf_params_exec {
+	u8 *data; /* extern specific params if any */
+	u32 index;
+	u32 method_id;
+};
+
+struct p4tc_extern_inst {
+	struct p4tc_template_common	common;
+	struct p4tc_extern_inst_common	*inst_common;
+	const struct p4tc_extern_ops	*ops;
+	struct p4tc_user_pipeline_extern	*pipe_ext;
+	u32				ext_id;
+	u32				ext_inst_id;
+	u32                             max_num_elems;
+	refcount_t                      curr_num_elems;
+	refcount_t			inst_ref;
+	bool				is_scalar;
+};
+
+int p4tc_pipeline_create_extern_net(struct p4tc_tmpl_extern *tmpl_ext);
+int p4tc_pipeline_del_extern_net(struct p4tc_tmpl_extern *tmpl_ext);
+struct p4tc_user_pipeline_extern *
+p4tc_tmpl_extern_net_find_byid(struct net *net, const u32 ext_id);
+struct p4tc_extern_inst *
+p4tc_ext_inst_find_bynames(struct net *net, struct p4tc_pipeline *pipeline,
+			   const char *extname, const char *instname,
+			   struct netlink_ext_ack *extack);
+struct p4tc_extern_inst *
+p4tc_ext_inst_get_byids(struct net *net, struct p4tc_pipeline **pipeline,
+			const u32 pipe_id,
+			struct p4tc_user_pipeline_extern **pipe_ext,
+			const u32 ext_id, const u32 inst_id);
+struct p4tc_extern_ops *p4tc_extern_ops_get(char *kind);
+void p4tc_extern_ops_put(const struct p4tc_extern_ops *ops);
+
+int __bpf_p4tc_extern_md_write(struct net *net,
+			       struct p4tc_ext_bpf_params *params);
+int __bpf_p4tc_extern_md_read(struct net *net,
+			      struct p4tc_ext_bpf_res *res,
+			      struct p4tc_ext_bpf_params *params);
+
+int p4tc_register_extern(struct p4tc_extern_ops *ext);
+int p4tc_unregister_extern(struct p4tc_extern_ops *ext);
+
+extern const struct p4tc_template_ops p4tc_tmpl_ext_ops;
+extern const struct p4tc_template_ops p4tc_tmpl_ext_inst_ops;
+
+struct p4tc_extern_param {
+	char				name[EXTPARAMNAMSIZ];
+	struct rcu_head			rcu;
+	void				*value;
+	struct p4tc_type		*type;
+	struct p4tc_type_mask_shift	*mask_shift;
+	u32				id;
+	u32				index;
+	u8				flags;
+};
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
 #define to_hdrfield(t) ((struct p4tc_hdrfield *)t)
 #define to_act(t) ((struct p4tc_act *)t)
 #define to_table(t) ((struct p4tc_table *)t)
 
+#define to_extern(t) ((struct p4tc_tmpl_extern *)t)
+#define to_extern_inst(t) ((struct p4tc_extern_inst *)t)
+
 #endif
diff --git a/include/net/p4tc_ext_api.h b/include/net/p4tc_ext_api.h
new file mode 100644
index 000000000..ba6bfb167
--- /dev/null
+++ b/include/net/p4tc_ext_api.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_P4TC_EXT_API_H
+#define __NET_P4TC_EXT_API_H
+
+/*
+ * Public extern P4TC_EXT API
+ */
+
+#include <uapi/linux/p4tc_ext.h>
+#include <linux/refcount.h>
+#include <net/flow_offload.h>
+#include <net/sch_generic.h>
+#include <net/pkt_sched.h>
+#include <net/net_namespace.h>
+#include <net/netns/generic.h>
+#include <net/p4tc.h>
+
+struct p4tc_extern_ops;
+
+struct p4tc_extern_params {
+	struct idr params_idr;
+	rwlock_t params_lock;
+	u32 num_params;
+};
+
+struct p4tc_extern {
+	struct p4tc_extern_params	*params;
+	struct idr			*elems_idr;
+	const struct p4tc_extern_ops	*ops;
+	struct p4tc_extern_inst		*inst;
+	struct rcu_head			rcu;
+	size_t				attrs_size;
+	spinlock_t			p4tc_ext_lock;
+	u32				p4tc_ext_key;
+	refcount_t			p4tc_ext_refcnt;
+	u32				p4tc_ext_flags;
+};
+
+/* Reserve 16 bits for user-space. See P4TC_EXT_FLAGS_NO_PERCPU_STATS. */
+#define P4TC_EXT_FLAGS_USER_BITS 16
+#define P4TC_EXT_FLAGS_USER_MASK 0xffff
+
+struct p4tc_extern_ops {
+	struct list_head head;
+	char kind[P4TC_EXT_NAMSIZ];
+	size_t size;
+	struct module *owner;
+	struct p4tc_tmpl_extern *tmpl_ext;
+	int     (*exec)(struct sk_buff *skb,
+			struct p4tc_extern_inst_common *common,
+			struct p4tc_extern *e,
+			struct p4tc_ext_bpf_params_exec *params,
+			struct p4tc_ext_bpf_res *res);
+	u32 id; /* identifier should match kind */
+};
+
+#define P4TC_EXT_P_CREATED 1
+#define P4TC_EXT_P_DELETED 1
+
+int p4tc_register_extern(struct p4tc_extern_ops *ext);
+int p4tc_unregister_extern(struct p4tc_extern_ops *ext);
+
+int p4tc_ctl_extern_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			 struct nlattr **tb, const char *pname);
+void p4tc_ext_purge(struct idr *idr);
+
+int p4tc_ctl_extern(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
+		    struct netlink_ext_ack *extack);
+struct p4tc_extern_param *
+p4tc_extern_param_find_byanyattr(struct idr *params_idr,
+				 struct nlattr *name_attr,
+				 const u32 param_id,
+				 struct netlink_ext_ack *extack);
+struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_byany(struct p4tc_pipeline *pipeline,
+			 const char *extern_name, u32 ext_id,
+			 struct netlink_ext_ack *extack);
+struct p4tc_extern_param *
+p4tc_extern_param_find_byid(struct idr *params_idr, const u32 param_id);
+
+int
+p4tc_extern_exec_bpf(struct sk_buff *skb, struct p4tc_ext_bpf_params *params,
+		     struct p4tc_ext_bpf_res *res);
+
+int p4tc_ext_param_value_init(struct net *net,
+			      struct p4tc_extern_param *param,
+			      struct nlattr **tb, u32 typeid,
+			      bool value_required,
+			      struct netlink_ext_ack *extack);
+void p4tc_ext_param_value_free(struct p4tc_extern_param *param);
+int p4tc_ext_param_value_dump(struct sk_buff *skb,
+			      struct p4tc_extern_param *param);
+int p4tc_extern_inst_init_elems(struct idr *user_ext_idr);
+
+int p4tc_unregister_extern(struct p4tc_extern_ops *ext);
+
+#endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 512b3bff7..eca16f4a1 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -19,6 +19,9 @@ struct p4tcmsg {
 #define P4TC_MAXMETA_SZ 128
 #define P4TC_MSGBATCH_SIZE 16
 
+#define EXTPARAMNAMSIZ 256
+#define P4TC_MAX_EXTERN_METHODS 32
+
 #define P4TC_MAX_KEYSZ 512
 #define HEADER_MAX_LEN 512
 
@@ -28,6 +31,9 @@ struct p4tcmsg {
 #define HDRFIELDNAMSIZ TEMPLATENAMSZ
 #define ACTPARAMNAMSIZ TEMPLATENAMSZ
 #define TABLENAMSIZ TEMPLATENAMSZ
+#define EXTERNNAMSIZ TEMPLATENAMSZ
+#define EXTERNINSTNAMSIZ TEMPLATENAMSZ
+#define METHODNAMSIZ 128
 
 #define P4TC_TABLE_FLAGS_KEYSZ 0x01
 #define P4TC_TABLE_FLAGS_MAX_ENTRIES 0x02
@@ -102,6 +108,8 @@ enum {
 	P4TC_ROOT_UNSPEC,
 	P4TC_ROOT, /* nested messages */
 	P4TC_ROOT_PNAME, /* string */
+	P4TC_ROOT_COUNT,
+	P4TC_ROOT_FLAGS,
 	__P4TC_ROOT_MAX,
 };
 #define P4TC_ROOT_MAX __P4TC_ROOT_MAX
@@ -123,6 +131,8 @@ enum {
 	P4TC_OBJ_HDR_FIELD,
 	P4TC_OBJ_ACT,
 	P4TC_OBJ_TABLE,
+	P4TC_OBJ_EXT,
+	P4TC_OBJ_EXT_INST,
 	__P4TC_OBJ_MAX,
 };
 #define P4TC_OBJ_MAX __P4TC_OBJ_MAX
@@ -131,6 +141,7 @@ enum {
 enum {
 	P4TC_OBJ_RUNTIME_UNSPEC,
 	P4TC_OBJ_RUNTIME_TABLE,
+	P4TC_OBJ_RUNTIME_EXTERN,
 	__P4TC_OBJ_RUNTIME_MAX,
 };
 #define P4TC_OBJ_RUNTIMEMAX __P4TC_OBJ_RUNTIMEMAX
@@ -323,6 +334,59 @@ enum {
 	P4TC_ENTITY_MAX
 };
 
+/* P4 Extern attributes */
+enum {
+	P4TC_TMPL_EXT_UNSPEC,
+	P4TC_TMPL_EXT_NAME, /* string */
+	P4TC_TMPL_EXT_NUM_INSTS, /* u16 */
+	__P4TC_TMPL_EXT_MAX
+};
+#define P4TC_TMPL_EXT_MAX (__P4TC_TMPL_EXT_MAX - 1)
+
+enum {
+	P4TC_TMPL_EXT_INST_UNSPEC,
+	P4TC_TMPL_EXT_INST_EXT_NAME, /* string */
+	P4TC_TMPL_EXT_INST_NAME, /* string */
+	P4TC_TMPL_EXT_INST_NUM_ELEMS, /* u32 */
+	P4TC_TMPL_EXT_INST_METHODS, /* nested methods */
+	P4TC_TMPL_EXT_INST_CONTROL_PARAMS, /* nested control params */
+	__P4TC_TMPL_EXT_INST_MAX
+};
+#define P4TC_TMPL_EXT_INST_MAX (__P4TC_TMPL_EXT_INST_MAX - 1)
+
+enum {
+	P4TC_TMPL_EXT_INST_METHOD_UNSPEC,
+	P4TC_TMPL_EXT_INST_METHOD_NAME, /* string */
+	P4TC_TMPL_EXT_INST_METHOD_ID, /* u32 */
+	P4TC_TMPL_EXT_INST_METHOD_PARAMS, /* nested params */
+	__P4TC_TMPL_EXT_INST_METHOD_MAX
+};
+#define P4TC_TMPL_EXT_INST_METHOD_MAX (__P4TC_TMPL_EXT_INST_METHOD_MAX - 1)
+
+/* Extern params attributes */
+enum {
+	P4TC_EXT_PARAMS_VALUE_UNSPEC,
+	P4TC_EXT_PARAMS_VALUE_RAW, /* binary */
+	__P4TC_EXT_PARAMS_VALUE_MAX
+};
+#define P4TC_EXT_VALUE_PARAMS_MAX __P4TC_EXT_PARAMS_VALUE_MAX
+
+#define P4TC_EXT_PARAMS_FLAG_ISKEY 0x1
+#define P4TC_EXT_PARAMS_FLAG_IS_DATASCALAR 0x2
+
+/* Extern params attributes */
+enum {
+	P4TC_EXT_PARAMS_UNSPEC,
+	P4TC_EXT_PARAMS_NAME, /* string */
+	P4TC_EXT_PARAMS_ID, /* u32 */
+	P4TC_EXT_PARAMS_VALUE, /* bytes */
+	P4TC_EXT_PARAMS_TYPE, /* u32 */
+	P4TC_EXT_PARAMS_BITSZ, /* u16 */
+	P4TC_EXT_PARAMS_FLAGS, /* u8 */
+	__P4TC_EXT_PARAMS_MAX
+};
+#define P4TC_EXT_PARAMS_MAX __P4TC_EXT_PARAMS_MAX
+
 #define P4TC_RTA(r) \
 	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
 
diff --git a/include/uapi/linux/p4tc_ext.h b/include/uapi/linux/p4tc_ext.h
new file mode 100644
index 000000000..4ae5e34d9
--- /dev/null
+++ b/include/uapi/linux/p4tc_ext.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef __LINUX_P4TC_EXT_H
+#define __LINUX_P4TC_EXT_H
+
+#include <linux/types.h>
+#include <linux/pkt_sched.h>
+
+#define P4TC_EXT_NAMSIZ 64
+
+/* Extern attributes */
+enum {
+	P4TC_EXT_UNSPEC,
+	P4TC_EXT_INST_NAME,
+	P4TC_EXT_KIND,
+	P4TC_EXT_PARAMS,
+	P4TC_EXT_KEY,
+	P4TC_EXT_FCNT,
+	P4TC_EXT_PAD,
+	P4TC_EXT_FLAGS,
+	__P4TC_EXT_MAX
+};
+
+#define P4TC_EXT_ID_DYN 0x01
+#define P4TC_EXT_ID_MAX 1023
+
+/* See other P4TC_EXT_FLAGS_ * flags in include/net/act_api.h. */
+#define P4TC_EXT_FLAGS_NO_PERCPU_STATS (1 << 0) /* Don't use percpu allocator
+						 * for externs stats.
+						 */
+#define P4TC_EXT_FLAGS_SKIP_HW	(1 << 1) /* don't offload action to HW */
+#define P4TC_EXT_FLAGS_SKIP_SW	(1 << 2) /* don't use action in SW */
+
+#define P4TC_EXT_FLAG_LARGE_DUMP_ON	(1 << 0)
+
+#define P4TC_EXT_MAX __P4TC_EXT_MAX
+#define P4TC_EXT_REPLACE		1
+#define P4TC_EXT_NOREPLACE	0
+
+#endif
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 03fd265a1..57f20b3f3 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -4,4 +4,5 @@ CFLAGS_trace.o := -I$(src)
 
 obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
 	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o \
-	p4tc_tbl_entry.o p4tc_runtime_api.o p4tc_bpf.o trace.o
+	p4tc_tbl_entry.o p4tc_runtime_api.o p4tc_bpf.o trace.o p4tc_ext.o \
+	p4tc_tmpl_ext.o
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
index c7c77e5ed..9905fd7ce 100644
--- a/net/sched/p4tc/p4tc_bpf.c
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -16,6 +16,7 @@
 #include <linux/btf_ids.h>
 #include <linux/net_namespace.h>
 #include <net/p4tc.h>
+#include <net/p4tc_ext_api.h>
 #include <linux/netdevice.h>
 #include <net/sock.h>
 #include <linux/filter.h>
@@ -25,6 +26,8 @@ BTF_ID(struct, p4tc_table_entry_act_bpf)
 BTF_ID(struct, p4tc_table_entry_act_bpf_params)
 BTF_ID(struct, p4tc_table_entry_act_bpf)
 BTF_ID(struct, p4tc_table_entry_create_bpf_params)
+BTF_ID(struct, p4tc_ext_bpf_params)
+BTF_ID(struct, p4tc_ext_bpf_res)
 
 static struct p4tc_table_entry_act_bpf *
 __bpf_p4tc_tbl_read(struct net *caller_net,
@@ -308,6 +311,50 @@ bpf_xdp_p4tc_entry_delete(struct xdp_md *xdp_ctx,
 	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
 }
 
+__bpf_kfunc int bpf_p4tc_extern_md_read_skb(struct __sk_buff *skb_ctx,
+					    struct p4tc_ext_bpf_res *res,
+					    struct p4tc_ext_bpf_params *params)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_extern_md_read(net, res, params);
+}
+
+__bpf_kfunc int bpf_p4tc_extern_md_write_skb(struct __sk_buff *skb_ctx,
+					     struct p4tc_ext_bpf_params *params)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_extern_md_write(net, params);
+}
+
+__bpf_kfunc int bpf_p4tc_extern_md_read_xdp(struct xdp_md *xdp_ctx,
+					    struct p4tc_ext_bpf_res *res,
+					    struct p4tc_ext_bpf_params *params)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_extern_md_read(net, res, params);
+}
+
+__bpf_kfunc int bpf_p4tc_extern_md_write_xdp(struct xdp_md *xdp_ctx,
+					     struct p4tc_ext_bpf_params *params)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_extern_md_write(net, params);
+}
+
 __diag_pop();
 
 BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
@@ -336,6 +383,26 @@ static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_xdp = {
 	.set = &p4tc_kfunc_check_tbl_set_xdp,
 };
 
+BTF_SET8_START(p4tc_kfunc_check_ext_set_skb)
+BTF_ID_FLAGS(func, bpf_p4tc_extern_md_write_skb);
+BTF_ID_FLAGS(func, bpf_p4tc_extern_md_read_skb);
+BTF_SET8_END(p4tc_kfunc_check_ext_set_skb)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_ext_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_ext_set_skb,
+};
+
+BTF_SET8_START(p4tc_kfunc_check_ext_set_xdp)
+BTF_ID_FLAGS(func, bpf_p4tc_extern_md_write_xdp);
+BTF_ID_FLAGS(func, bpf_p4tc_extern_md_read_xdp);
+BTF_SET8_END(p4tc_kfunc_check_ext_set_xdp)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_ext_set_xdp = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_ext_set_xdp,
+};
+
 int register_p4tc_tbl_bpf(void)
 {
 	int ret;
@@ -346,6 +413,16 @@ int register_p4tc_tbl_bpf(void)
 		return ret;
 
 	/* There is no unregister_btf_kfunc_id_set function */
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					&p4tc_kfunc_tbl_set_xdp);
+	if (ret < 0)
+		return ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					&p4tc_kfunc_ext_set_skb);
+	if (ret < 0)
+		return ret;
+
 	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
-					 &p4tc_kfunc_tbl_set_xdp);
+					 &p4tc_kfunc_ext_set_xdp);
 }
diff --git a/net/sched/p4tc/p4tc_ext.c b/net/sched/p4tc/p4tc_ext.c
new file mode 100644
index 000000000..05153fdf8
--- /dev/null
+++ b/net/sched/p4tc/p4tc_ext.c
@@ -0,0 +1,2035 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_ext.c	P4 TC EXTERN API
+ *
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+#include <linux/kmod.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/p4tc_types.h>
+#include <net/p4tc_ext_api.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+#include <net/tc_wrapper.h>
+#include <uapi/linux/p4tc.h>
+
+static void p4tc_ext_put_param(struct p4tc_extern_param *param)
+{
+	kfree(param->value);
+	kfree(param);
+}
+
+static void p4tc_ext_put_many_params(struct idr *params_idr,
+				     struct p4tc_extern_param *params[],
+				     int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++)
+		p4tc_ext_put_param(params[i]);
+}
+
+static void p4tc_ext_insert_param(struct idr *params_idr,
+				  struct p4tc_extern_param *param)
+{
+	struct p4tc_extern_param *param_old;
+
+	param_old = idr_replace(params_idr, param, param->id);
+	if (param_old != ERR_PTR(-EBUSY))
+		p4tc_ext_put_param(param_old);
+}
+
+static void p4tc_ext_insert_many_params(struct idr *params_idr,
+					struct p4tc_extern_param *params[],
+					int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++)
+		p4tc_ext_insert_param(params_idr, params[i]);
+}
+
+static void __free_p4tc_ext_params(struct p4tc_extern_params *params)
+{
+	struct p4tc_extern_param *parm;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&params->params_idr, parm, tmp, id) {
+		idr_remove(&params->params_idr, id);
+		p4tc_ext_put_param(parm);
+	}
+}
+
+static void free_p4tc_ext_params(struct p4tc_extern_params *params)
+{
+	__free_p4tc_ext_params(params);
+	kfree(params);
+}
+
+static void free_p4tc_ext(struct p4tc_extern *p)
+{
+	if (p->params)
+		free_p4tc_ext_params(p->params);
+	refcount_dec(&p->inst->inst_ref);
+
+	kfree(p);
+}
+
+static void free_p4tc_ext_rcu(struct rcu_head *rcu)
+{
+	struct p4tc_extern *p;
+
+	p = container_of(rcu, struct p4tc_extern, rcu);
+
+	free_p4tc_ext(p);
+}
+
+static void p4tc_extern_cleanup(struct p4tc_extern *p)
+{
+	free_p4tc_ext_rcu(&p->rcu);
+}
+
+static int __p4tc_extern_put(struct p4tc_extern *p)
+{
+	if (refcount_dec_and_test(&p->p4tc_ext_refcnt)) {
+		idr_remove(p->elems_idr, p->p4tc_ext_key);
+
+		refcount_dec(&p->inst->curr_num_elems);
+		p4tc_extern_cleanup(p);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+static int __p4tc_ext_idr_release(struct p4tc_extern *p)
+{
+	int ret = 0;
+
+	if (p) {
+		if (__p4tc_extern_put(p))
+			ret = P4TC_EXT_P_DELETED;
+	}
+
+	return ret;
+}
+
+static int p4tc_ext_idr_release(struct p4tc_extern *e)
+{
+	struct p4tc_extern_inst *inst = e->inst;
+	int ret;
+
+	ret = __p4tc_ext_idr_release(e);
+	if (ret == P4TC_EXT_P_DELETED)
+		refcount_dec(&inst->curr_num_elems);
+
+	return ret;
+}
+
+static size_t p4tc_extern_shared_attrs_size(const struct p4tc_extern *ext)
+{
+	return  nla_total_size(0) /* extern number nested */
+		+ nla_total_size(EXTERNNAMSIZ)  /* P4TC_EXT_KIND */
+		+ nla_total_size(EXTERNINSTNAMSIZ) /* P4TC_EXT_INST_NAME */
+		+ nla_total_size(sizeof(struct nla_bitfield32)); /* P4TC_EXT_FLAGS */
+}
+
+static size_t p4tc_extern_full_attrs_size(size_t sz)
+{
+	return NLMSG_HDRLEN                     /* struct nlmsghdr */
+		+ sizeof(struct p4tcmsg)
+		+ nla_total_size(0)             /* P4TC_ROOT nested */
+		+ sz;
+}
+
+static size_t p4tc_extern_fill_size(const struct p4tc_extern *ext)
+{
+	size_t sz = p4tc_extern_shared_attrs_size(ext);
+
+	return sz;
+}
+
+struct p4tc_extern_param_ops {
+	int (*init_value)(struct net *net, struct p4tc_extern_param_ops *op,
+			  struct p4tc_extern_param *nparam, struct nlattr **tb,
+			  bool required_value, struct netlink_ext_ack *extack);
+	int (*dump_value)(struct sk_buff *skb, struct p4tc_extern_param_ops *op,
+			  struct p4tc_extern_param *param);
+	void (*free)(struct p4tc_extern_param *param);
+	u32 len;
+	u32 alloc_len;
+};
+
+static int
+generic_dump_ext_param_value(struct sk_buff *skb, struct p4tc_type *type,
+			     struct p4tc_extern_param *param)
+{
+	const u32 bytesz = BITS_TO_BYTES(type->container_bitsz);
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nla_value;
+
+	nla_value = nla_nest_start(skb, P4TC_EXT_PARAMS_VALUE);
+	if (nla_put(skb, P4TC_EXT_PARAMS_VALUE_RAW, bytesz,
+		    param->value))
+		goto out_nlmsg_trim;
+	nla_nest_end(skb, nla_value);
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static const struct nla_policy p4tc_extern_params_value_policy[P4TC_EXT_VALUE_PARAMS_MAX + 1] = {
+	[P4TC_EXT_PARAMS_VALUE_RAW] = { .type = NLA_BINARY },
+};
+
+static int dev_init_param_value(struct net *net, struct p4tc_extern_param_ops *op,
+				struct p4tc_extern_param *nparam,
+				struct nlattr **tb, bool required_value,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb_value[P4TC_EXT_VALUE_PARAMS_MAX + 1];
+	u32 value_len;
+	u32 *ifindex;
+	int err;
+
+	if (!tb[P4TC_EXT_PARAMS_VALUE]) {
+		if (required_value) {
+			NL_SET_ERR_MSG(extack, "Must specify param value");
+			return -EINVAL;
+		} else {
+			return 0;
+		}
+	}
+	err = nla_parse_nested(tb_value, P4TC_EXT_VALUE_PARAMS_MAX,
+			       tb[P4TC_EXT_PARAMS_VALUE],
+			       p4tc_extern_params_value_policy, extack);
+	if (err < 0)
+		return err;
+
+	value_len = nla_len(tb_value[P4TC_EXT_PARAMS_VALUE_RAW]);
+	if (value_len != sizeof(u32)) {
+		NL_SET_ERR_MSG(extack, "Value length differs from template's");
+		return -EINVAL;
+	}
+
+	ifindex = nla_data(tb_value[P4TC_EXT_PARAMS_VALUE_RAW]);
+	rcu_read_lock();
+	if (!dev_get_by_index_rcu(net, *ifindex)) {
+		NL_SET_ERR_MSG(extack, "Invalid ifindex");
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
+	nparam->value = kzalloc(sizeof(*ifindex), GFP_KERNEL);
+	if (!nparam->value)
+		return -EINVAL;
+
+	memcpy(nparam->value, ifindex, sizeof(*ifindex));
+
+	return 0;
+}
+
+static int dev_dump_param_value(struct sk_buff *skb,
+				struct p4tc_extern_param_ops *op,
+				struct p4tc_extern_param *param)
+{
+	struct nlattr *nest;
+	u32 *ifindex;
+	int ret;
+
+	nest = nla_nest_start(skb, P4TC_EXT_PARAMS_VALUE);
+	ifindex = (u32 *)param->value;
+
+	if (nla_put_u32(skb, P4TC_EXT_PARAMS_VALUE_RAW, *ifindex)) {
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
+static void dev_free_param_value(struct p4tc_extern_param *param)
+{
+	kfree(param->value);
+}
+
+static const struct p4tc_extern_param_ops ext_param_ops[P4T_MAX + 1] = {
+	[P4T_DEV] = {
+		.init_value = dev_init_param_value,
+		.dump_value = dev_dump_param_value,
+		.free = dev_free_param_value,
+	},
+};
+
+static int
+p4tc_extern_dump_1(struct sk_buff *skb, struct p4tc_extern *e, int ref)
+{
+	const char *kind = e->inst->pipe_ext->ext_name;
+	const char *instname = e->inst->common.name;
+	unsigned char *b = skb_tail_pointer(skb);
+	struct p4tc_extern_param *parm;
+	struct nlattr *nest_parms;
+	u32 flags;
+	int id;
+
+	if (nla_put_string(skb, P4TC_EXT_KIND, kind))
+		goto nla_put_failure;
+
+	if (nla_put_string(skb, P4TC_EXT_INST_NAME, instname))
+		goto nla_put_failure;
+
+	flags = e->p4tc_ext_flags & P4TC_EXT_FLAGS_USER_MASK;
+	if (flags &&
+	    nla_put_bitfield32(skb, P4TC_EXT_FLAGS,
+			       flags, flags))
+		goto nla_put_failure;
+
+	nest_parms = nla_nest_start(skb, P4TC_EXT_PARAMS);
+	if (e->params) {
+		int i = 1;
+
+		idr_for_each_entry(&e->params->params_idr, parm, id) {
+			struct p4tc_extern_param_ops *op;
+			struct nlattr *nest_count;
+
+			nest_count = nla_nest_start(skb, i);
+			if (!nest_count)
+				goto nla_put_failure;
+
+			if (nla_put_string(skb, P4TC_EXT_PARAMS_NAME,
+					   parm->name))
+				goto nla_put_failure;
+
+			if (nla_put_u32(skb, P4TC_EXT_PARAMS_ID, parm->id))
+				goto nla_put_failure;
+
+			op = (struct p4tc_extern_param_ops *)&ext_param_ops[parm->type->typeid];
+			read_lock_bh(&e->params->params_lock);
+			if (op->dump_value) {
+				if (op->dump_value(skb, op, parm) < 0) {
+					read_unlock_bh(&e->params->params_lock);
+					goto nla_put_failure;
+				}
+			} else {
+				if (generic_dump_ext_param_value(skb, parm->type, parm)) {
+					read_unlock_bh(&e->params->params_lock);
+					goto nla_put_failure;
+				}
+			}
+			read_unlock_bh(&e->params->params_lock);
+
+			if (nla_put_u32(skb, P4TC_EXT_PARAMS_TYPE, parm->type->typeid))
+				goto nla_put_failure;
+
+			if (nla_put_u32(skb, P4TC_EXT_PARAMS_FLAGS,
+					parm->flags))
+				goto nla_put_failure;
+
+			nla_nest_end(skb, nest_count);
+			i++;
+		}
+	}
+	nla_nest_end(skb, nest_parms);
+
+	return skb->len;
+
+nla_put_failure:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int p4tc_ext_dump_walker(struct p4tc_extern_inst *inst,
+				struct sk_buff *skb,
+				struct netlink_callback *cb)
+{
+	struct idr *idr = &inst->inst_common->control_elems_idr;
+	int err = 0, s_i = 0, n_i = 0;
+	u32 ext_flags = cb->args[2];
+	struct p4tc_extern *p;
+	unsigned long id = 1;
+	struct nlattr *nest;
+	unsigned long tmp;
+	int key = -1;
+
+	s_i = cb->args[0];
+
+	idr_for_each_entry_ul(idr, p, tmp, id) {
+		key++;
+		if (key < s_i)
+			continue;
+		if (IS_ERR(p))
+			continue;
+
+		nest = nla_nest_start_noflag(skb, n_i);
+		if (!nest) {
+			key--;
+			goto nla_put_failure;
+		}
+
+		err = p4tc_extern_dump_1(skb, p, 0);
+		if (err < 0) {
+			key--;
+			nlmsg_trim(skb, nest);
+			goto done;
+		}
+		nla_nest_end(skb, nest);
+		n_i++;
+		if (!(ext_flags & P4TC_EXT_FLAG_LARGE_DUMP_ON) &&
+		    n_i >= P4TC_MSGBATCH_SIZE)
+			goto done;
+	}
+done:
+	if (key >= 0)
+		cb->args[0] = key + 1;
+
+	if (n_i) {
+		if (ext_flags & P4TC_EXT_FLAG_LARGE_DUMP_ON)
+			cb->args[1] = n_i;
+	}
+	return n_i;
+
+nla_put_failure:
+	nla_nest_cancel(skb, nest);
+	goto done;
+}
+
+static void __p4tc_ext_idr_purge(struct p4tc_extern *p)
+{
+	refcount_dec(&p->inst->curr_num_elems);
+	p4tc_extern_cleanup(p);
+}
+
+static void p4tc_ext_idr_purge(struct p4tc_extern *p)
+{
+	idr_remove(p->elems_idr, p->p4tc_ext_key);
+	__p4tc_ext_idr_purge(p);
+}
+
+/* Called when pipeline is being purged */
+void p4tc_ext_purge(struct idr *idr)
+{
+	struct p4tc_extern *p;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(idr, p, tmp, id) {
+		if (IS_ERR(p))
+			continue;
+		p4tc_ext_idr_purge(p);
+	}
+}
+
+static int p4tc_ext_idr_search(struct p4tc_extern_inst *inst,
+			       struct p4tc_extern **e, u32 key)
+{
+	struct idr *elems_idr = &inst->inst_common->control_elems_idr;
+	struct p4tc_extern *p;
+
+	p = idr_find(elems_idr, key);
+	if (IS_ERR(p))
+		p = NULL;
+
+	if (p) {
+		*e = p;
+		return true;
+	}
+	return false;
+}
+
+static int __p4tc_ext_idr_search(struct p4tc_extern_inst *inst,
+				 struct p4tc_extern **e, u32 key)
+{
+	if (p4tc_ext_idr_search(inst, e, key)) {
+		refcount_inc(&((*e)->p4tc_ext_refcnt));
+		return true;
+	}
+
+	return false;
+}
+
+static int p4tc_copy_key_param(struct p4tc_extern_inst *inst,
+			       struct p4tc_extern_params *params_orig,
+			       struct p4tc_extern_params *params,
+			       const u32 key_param_id, const void *key_value)
+{
+	struct idr *params_idr = &params_orig->params_idr;
+	struct p4tc_extern_param *nparam;
+	struct p4tc_extern_param *param;
+	int err = 0;
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam)
+		return -ENOMEM;
+
+	/* We know this is the correct id because we checked before */
+	param = idr_find(params_idr, key_param_id);
+
+	nparam->value = kzalloc(BITS_TO_BYTES(param->type->container_bitsz),
+				GFP_KERNEL);
+	if (!nparam->value) {
+		err = -ENOMEM;
+		goto free_nparam;
+	}
+	nparam->id = key_param_id;
+
+	err = idr_alloc_u32(&params->params_idr, nparam, &nparam->id,
+			    nparam->id, GFP_KERNEL);
+	if (err < 0)
+		goto free_nparam_val;
+
+	strscpy(nparam->name, param->name, EXTPARAMNAMSIZ);
+	nparam->id = param->id;
+	nparam->type = param->type;
+	read_lock_bh(&params_orig->params_lock);
+	memcpy(nparam->value, param->value,
+	       BITS_TO_BYTES(param->type->container_bitsz));
+	read_unlock_bh(&params_orig->params_lock);
+
+	return 0;
+
+free_nparam_val:
+	kfree(nparam->value);
+
+free_nparam:
+	kfree(nparam);
+	return err;
+}
+
+static int p4tc_ext_copy(struct p4tc_extern_inst *inst,
+			 u32 key, struct p4tc_extern **e,
+			 struct p4tc_extern *e_orig,
+			 const struct p4tc_extern_ops *ops,
+			 u32 flags)
+{
+	struct p4tc_extern *p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	if (unlikely(!p))
+		return -ENOMEM;
+
+	spin_lock_init(&p->p4tc_ext_lock);
+	p->p4tc_ext_key = key;
+	p->p4tc_ext_flags = flags;
+	refcount_set(&p->p4tc_ext_refcnt,
+		     refcount_read(&e_orig->p4tc_ext_refcnt));
+
+	p->elems_idr = e_orig->elems_idr;
+	refcount_inc(&inst->inst_ref);
+	p->inst = inst;
+	p->ops = ops;
+	*e = p;
+	return 0;
+}
+
+static int p4tc_ext_idr_create(struct p4tc_extern_inst *inst,
+			       u32 key, struct p4tc_extern **e,
+			       const struct p4tc_extern_ops *ops,
+			       u32 flags)
+{
+	struct p4tc_extern *p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	if (unlikely(!p))
+		return -ENOMEM;
+
+	if (refcount_read(&inst->curr_num_elems) - 1 == inst->max_num_elems) {
+		kfree(p);
+		return -E2BIG;
+	}
+
+	refcount_inc(&inst->curr_num_elems);
+
+	refcount_set(&p->p4tc_ext_refcnt, 1);
+
+	spin_lock_init(&p->p4tc_ext_lock);
+	p->p4tc_ext_key = key;
+	p->p4tc_ext_flags = flags;
+
+	p->elems_idr = &inst->inst_common->control_elems_idr;
+	refcount_inc(&inst->inst_ref);
+	p->inst = inst;
+	p->ops = ops;
+	*e = p;
+	return 0;
+}
+
+/* Check if extern with specified key exists. If externs is found, increments
+ * its reference, and return 1. Otherwise insert temporary error pointer
+ * (to prevent concurrent users from inserting externs with same key) and
+ * return 0.
+ */
+
+static int p4tc_ext_idr_check_alloc(struct p4tc_extern_inst *inst,
+				    u32 key, struct p4tc_extern **e,
+				    struct netlink_ext_ack *extack)
+{
+	struct idr *elems_idr = &inst->inst_common->control_elems_idr;
+	struct p4tc_extern *p;
+	int ret;
+
+	p = idr_find(elems_idr, key);
+	if (p) {
+		refcount_inc(&p->p4tc_ext_refcnt);
+		*e = p;
+		ret = 1;
+	} else {
+		NL_SET_ERR_MSG_FMT(extack, "Unable to find element with key %u",
+				   key);
+		return -ENOENT;
+	}
+
+	return ret;
+}
+
+static struct p4tc_extern_inst *
+p4tc_skb_extern_find_inst(struct net *net,
+			  struct p4tc_pipeline **pipeline,
+			  struct p4tc_user_pipeline_extern **pipe_ext,
+			  struct p4tc_ext_bpf_params *params)
+{
+	return p4tc_ext_inst_get_byids(net, pipeline, params->pipe_id,
+				       pipe_ext, params->ext_id,
+				       params->inst_id);
+}
+
+static struct p4tc_extern *
+p4tc_skb_extern_find_elem(struct p4tc_extern_inst *inst,
+			  struct p4tc_ext_bpf_params *params)
+{
+	struct p4tc_extern *e;
+
+	e = idr_find(&inst->inst_common->control_elems_idr, params->index);
+	if (!e)
+		return ERR_PTR(-ENOENT);
+
+	return e;
+}
+
+int __bpf_p4tc_extern_md_write(struct net *net,
+			       struct p4tc_ext_bpf_params *params)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	u8 *params_data = params->in_params;
+	struct p4tc_extern_param *param;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+	struct p4tc_type *type;
+	struct p4tc_extern *e;
+	int err = 0;
+
+	inst = p4tc_skb_extern_find_inst(net, &pipeline, &pipe_ext,
+					 params);
+	if (IS_ERR(inst))
+		return PTR_ERR(inst);
+
+	e = p4tc_skb_extern_find_elem(inst, params);
+	if (IS_ERR(e)) {
+		err = PTR_ERR(e);
+		goto refcount_dec;
+	}
+
+	param = idr_find(&e->params->params_idr, params->param_id);
+	if (unlikely(!param)) {
+		err = -EINVAL;
+		goto refcount_dec;
+	}
+
+	if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY) {
+		err = -EINVAL;
+		goto refcount_dec;
+	}
+
+	type = param->type;
+	if (unlikely(!type->ops->host_read)) {
+		err = -EINVAL;
+		goto refcount_dec;
+	}
+
+	if (unlikely(!type->ops->host_write)) {
+		err = -EINVAL;
+		goto refcount_dec;
+	}
+
+	write_lock_bh(&e->params->params_lock);
+	p4t_copy(param->mask_shift, type, param->value,
+		 param->mask_shift, type, params_data);
+	write_unlock_bh(&e->params->params_lock);
+
+refcount_dec:
+	refcount_dec(&inst->inst_ref);
+	refcount_dec(&pipe_ext->ext_ref);
+	refcount_dec(&pipeline->p_ctrl_ref);
+
+	return err;
+}
+
+int __bpf_p4tc_extern_md_read(struct net *net,
+			      struct p4tc_ext_bpf_res *res,
+			      struct p4tc_ext_bpf_params *params)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	const struct p4tc_type_ops *ops;
+	struct p4tc_extern_param *param;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+	struct p4tc_extern *e;
+	int err = 0;
+
+	inst = p4tc_skb_extern_find_inst(net, &pipeline, &pipe_ext,
+					 params);
+	if (IS_ERR(inst))
+		return PTR_ERR(inst);
+
+	e = p4tc_skb_extern_find_elem(inst, params);
+	if (IS_ERR(e)) {
+		err = PTR_ERR(e);
+		goto refcount_dec;
+	}
+
+	param = idr_find(&e->params->params_idr, params->param_id);
+	if (unlikely(!param)) {
+		err = -ENOENT;
+		goto refcount_dec;
+	}
+
+	ops = param->type->ops;
+	if (unlikely(!ops->host_read)) {
+		err = -ENOENT;
+		goto refcount_dec;
+	}
+
+	read_lock_bh(&e->params->params_lock);
+	ops->host_read(param->type, param->mask_shift, param->value,
+		       res->out_params);
+	read_unlock_bh(&e->params->params_lock);
+
+refcount_dec:
+	refcount_dec(&inst->inst_ref);
+	refcount_dec(&pipe_ext->ext_ref);
+	refcount_dec(&pipeline->p_ctrl_ref);
+
+	return err;
+}
+
+static int p4tc_extern_destroy(struct p4tc_extern *externs[], int init_res[])
+{
+	const struct p4tc_extern_ops *ops;
+	struct p4tc_extern *e;
+	int ret = 0, i;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE && externs[i]; i++) {
+		e = externs[i];
+		externs[i] = NULL;
+		ops = e->ops;
+		if (init_res[i] == P4TC_EXT_P_CREATED) {
+			struct p4tc_extern_inst *inst = e->inst;
+
+			ret = __p4tc_ext_idr_release(e);
+			if (ret == P4TC_EXT_P_DELETED)
+				refcount_dec(&inst->curr_num_elems);
+			else if (ret < 0)
+				return ret;
+		} else {
+			free_p4tc_ext_rcu(&e->rcu);
+		}
+	}
+	return ret;
+}
+
+static int p4tc_extern_put(struct p4tc_extern *p)
+{
+	return __p4tc_extern_put(p);
+}
+
+/* Put all externs in this array, skip those NULL's. */
+static void p4tc_extern_put_many(struct p4tc_extern *externs[])
+{
+	int i;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE; i++) {
+		struct p4tc_extern *e = externs[i];
+		const struct p4tc_extern_ops *ops;
+
+		if (!e)
+			continue;
+		ops = e->ops;
+		p4tc_extern_put(e);
+	}
+}
+
+static int p4tc_extern_dump(struct sk_buff *skb, struct p4tc_extern *externs[],
+			    int ref)
+{
+	struct p4tc_extern *e;
+	int err = -EINVAL, i;
+	struct nlattr *nest;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE && externs[i]; i++) {
+		e = externs[i];
+		nest = nla_nest_start_noflag(skb, i + 1);
+		if (!nest)
+			goto nla_put_failure;
+		err = p4tc_extern_dump_1(skb, e, ref);
+		if (err < 0)
+			goto errout;
+		nla_nest_end(skb, nest);
+	}
+
+	return 0;
+
+nla_put_failure:
+	err = -EINVAL;
+errout:
+	nla_nest_cancel(skb, nest);
+	return err;
+}
+
+static void generic_free_param_value(struct p4tc_extern_param *param)
+{
+	kfree(param->value);
+}
+
+static int generic_init_param_value(struct p4tc_extern_param *nparam,
+				    struct p4tc_type *type, struct nlattr **tb,
+				    bool value_required,
+				    struct netlink_ext_ack *extack)
+{
+	const u32 alloc_len = BITS_TO_BYTES(type->container_bitsz);
+	struct nlattr *tb_value[P4TC_EXT_VALUE_PARAMS_MAX + 1];
+	const u32 len = BITS_TO_BYTES(type->bitsz);
+	void *value;
+	int err;
+
+	if (!tb[P4TC_EXT_PARAMS_VALUE]) {
+		if (value_required) {
+			NL_SET_ERR_MSG(extack, "Must specify param value");
+			return -EINVAL;
+		} else {
+			return 0;
+		}
+	}
+
+	err = nla_parse_nested(tb_value, P4TC_EXT_VALUE_PARAMS_MAX,
+			       tb[P4TC_EXT_PARAMS_VALUE],
+			       p4tc_extern_params_value_policy, extack);
+	if (err < 0)
+		return err;
+
+	value = nla_data(tb_value[P4TC_EXT_PARAMS_VALUE_RAW]);
+	if (type->ops->validate_p4t) {
+		err = type->ops->validate_p4t(type, value, 0, type->bitsz - 1,
+					      extack);
+		if (err < 0)
+			return err;
+	}
+
+	if (nla_len(tb_value[P4TC_EXT_PARAMS_VALUE_RAW]) != len)
+		return -EINVAL;
+
+	nparam->value = kzalloc(alloc_len, GFP_KERNEL);
+	if (!nparam->value)
+		return -ENOMEM;
+
+	memcpy(nparam->value, value, len);
+
+	return 0;
+}
+
+static const struct nla_policy p4tc_extern_policy[P4TC_EXT_MAX + 1] = {
+	[P4TC_EXT_INST_NAME] = {
+		.type = NLA_STRING,
+		.len = EXTERNINSTNAMSIZ
+	},
+	[P4TC_EXT_KIND]		= { .type = NLA_STRING },
+	[P4TC_EXT_PARAMS]	= { .type = NLA_NESTED },
+	[P4TC_EXT_KEY]		= { .type = NLA_NESTED },
+	[P4TC_EXT_FLAGS]	= { .type = NLA_BITFIELD32 },
+};
+
+static const struct nla_policy p4tc_extern_params_policy[P4TC_EXT_PARAMS_MAX + 1] = {
+	[P4TC_EXT_PARAMS_NAME] = { .type = NLA_STRING, .len = EXTPARAMNAMSIZ },
+	[P4TC_EXT_PARAMS_ID] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_VALUE] = { .type = NLA_NESTED },
+	[P4TC_EXT_PARAMS_TYPE] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_BITSZ] = { .type = NLA_U16 },
+	[P4TC_EXT_PARAMS_FLAGS] = { .type = NLA_U8 },
+};
+
+int p4tc_ext_param_value_init(struct net *net,
+			      struct p4tc_extern_param *param,
+			      struct nlattr **tb, u32 typeid,
+			      bool value_required,
+			      struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param_ops *op;
+
+	op = (struct p4tc_extern_param_ops *)&ext_param_ops[typeid];
+	if (op->init_value)
+		return op->init_value(net, op, param, tb, value_required,
+				      extack);
+
+	return generic_init_param_value(param, param->type, tb, value_required,
+					extack);
+}
+
+void p4tc_ext_param_value_free(struct p4tc_extern_param *param)
+{
+	const u32 typeid = param->type->typeid;
+	struct p4tc_extern_param_ops *op;
+
+	op = (struct p4tc_extern_param_ops *)&ext_param_ops[typeid];
+	if (op->free)
+		return op->free(param);
+
+	return generic_free_param_value(param);
+}
+
+int p4tc_ext_param_value_dump(struct sk_buff *skb,
+			      struct p4tc_extern_param *param)
+{
+	const u32 typeid = param->type->typeid;
+	struct p4tc_extern_param_ops *op;
+
+	op = (struct p4tc_extern_param_ops *)&ext_param_ops[typeid];
+	if (op->dump_value)
+		return op->dump_value(skb, op, param);
+
+	return generic_dump_ext_param_value(skb, param->type, param);
+}
+
+static struct p4tc_extern_param *
+p4tc_ext_create_param(struct net *net, struct p4tc_extern_params *params,
+		      struct p4tc_extern_inst_common *inst_common,
+		      struct nlattr **tb, size_t *attrs_size,
+		      struct netlink_ext_ack *extack)
+{
+	struct idr *params_idr = &inst_common->control_params_idr;
+	struct p4tc_extern_param *param, *nparam;
+	struct p4tc_extern_param_ops *op = NULL;
+	u32 param_id = 0;
+	int err;
+
+	if (tb[P4TC_EXT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_EXT_PARAMS_ID]);
+	*attrs_size += nla_total_size(sizeof(u32));
+
+	param = p4tc_extern_param_find_byanyattr(params_idr,
+						 tb[P4TC_EXT_PARAMS_NAME],
+						 param_id, extack);
+	if (IS_ERR(param))
+		return param;
+
+	if (tb[P4TC_EXT_PARAMS_TYPE]) {
+		u32 typeid = nla_get_u32(tb[P4TC_EXT_PARAMS_TYPE]);
+
+		if (param->type->typeid != typeid) {
+			NL_SET_ERR_MSG(extack,
+				       "Param type differs from template");
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		return ERR_PTR(-EINVAL);
+	}
+	*attrs_size += nla_total_size(sizeof(u32));
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam)
+		return ERR_PTR(-ENOMEM);
+
+	strscpy(nparam->name, param->name, EXTPARAMNAMSIZ);
+	nparam->type = param->type;
+
+	err = p4tc_ext_param_value_init(net, nparam, tb, param->type->typeid,
+					true, extack);
+	if (err < 0)
+		goto free;
+	*attrs_size += nla_total_size(BITS_TO_BYTES(param->type->container_bitsz));
+
+	nparam->id = param->id;
+
+	err = idr_alloc_u32(&params->params_idr, ERR_PTR(-EBUSY), &nparam->id,
+			    nparam->id, GFP_KERNEL);
+	if (err < 0)
+		goto free_val;
+
+	return nparam;
+
+free_val:
+	if (op && op->free)
+		op->free(nparam);
+	else
+		generic_free_param_value(nparam);
+
+free:
+	kfree(nparam);
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_param *
+p4tc_ext_init_param(struct net *net, struct p4tc_extern_inst *inst,
+		    struct p4tc_extern_params *params, struct nlattr *nla,
+		    size_t *attrs_size, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst_common *inst_common = inst->inst_common;
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return p4tc_ext_create_param(net, params, inst_common, tb, attrs_size,
+				     extack);
+}
+
+static int p4tc_ext_get_key_param_value(struct nlattr *nla,
+					u32 *key, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_VALUE_PARAMS_MAX];
+	u32 *value;
+	int err;
+
+	if (!nla) {
+		NL_SET_ERR_MSG(extack, "Must specify key param value");
+		return -EINVAL;
+	}
+
+	err = nla_parse_nested(tb, P4TC_EXT_VALUE_PARAMS_MAX,
+			       nla, p4tc_extern_params_value_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[P4TC_EXT_PARAMS_VALUE_RAW]) {
+		NL_SET_ERR_MSG(extack, "Must specify raw value attr");
+		return -EINVAL;
+	}
+
+	if (nla_len(tb[P4TC_EXT_PARAMS_VALUE_RAW]) > sizeof(*key)) {
+		NL_SET_ERR_MSG(extack,
+			       "Param value is bigger than 32 bits");
+		return -EINVAL;
+	}
+
+	value = nla_data(tb[P4TC_EXT_PARAMS_VALUE_RAW]);
+
+	*key = *value;
+
+	return 0;
+}
+
+static int p4tc_ext_get_key_param(struct p4tc_extern_inst *inst,
+				  struct nlattr *nla, u32 *key,
+				  struct netlink_ext_ack *extack)
+{
+	struct idr *params_idr = &inst->inst_common->control_params_idr;
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	struct p4tc_extern_param *index_param;
+	char *param_name;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (err < 0)
+		return err;
+
+	if (!tb[P4TC_EXT_PARAMS_NAME]) {
+		NL_SET_ERR_MSG(extack, "Must specify key param name");
+		return -EINVAL;
+	}
+	param_name = nla_data(tb[P4TC_EXT_PARAMS_NAME]);
+
+	index_param = p4tc_extern_param_find_byanyattr(params_idr,
+						       tb[P4TC_EXT_PARAMS_NAME],
+						       0, extack);
+	if (IS_ERR(index_param)) {
+		NL_SET_ERR_MSG(extack, "Key param name not found");
+		return -EINVAL;
+	}
+
+	if (!(index_param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY)) {
+		NL_SET_ERR_MSG_FMT(extack, "%s is not the key param name",
+				   param_name);
+		return -EINVAL;
+	}
+
+	err = p4tc_ext_get_key_param_value(tb[P4TC_EXT_PARAMS_VALUE], key,
+					   extack);
+	if (err < 0)
+		return err;
+
+	return index_param->id;
+}
+
+static int p4tc_ext_get_key_param_scalar(struct p4tc_extern_inst *inst,
+					 struct nlattr *nla, u32 *key,
+					 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (err < 0)
+		return err;
+
+	return p4tc_ext_get_key_param_value(tb[P4TC_EXT_PARAMS_VALUE], key,
+					    extack);
+}
+
+static int p4tc_ext_init_params(struct net *net, struct p4tc_extern_inst *inst,
+				struct p4tc_extern_params **params,
+				struct nlattr *nla, size_t *attrs_size,
+				struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *params_array[P4TC_MSGBATCH_SIZE] = { NULL };
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	int err;
+	int i;
+
+	if (!*params) {
+		*params = kzalloc(sizeof(*(*params)), GFP_KERNEL);
+		if (!*params)
+			return -ENOMEM;
+
+		idr_init(&((*params)->params_idr));
+		rwlock_init(&((*params)->params_lock));
+	}
+
+	err = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (err < 0) {
+		kfree(*params);
+		*params = NULL;
+		return err;
+	}
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		struct p4tc_extern_param *param;
+
+		param = p4tc_ext_init_param(net, inst, *params, tb[i],
+					    attrs_size, extack);
+		if (IS_ERR(param)) {
+			err = PTR_ERR(param);
+			goto params_del;
+		}
+		params_array[i - 1] = param;
+		*attrs_size = nla_total_size(0);  /* params array element nested */
+	}
+
+	p4tc_ext_insert_many_params(&((*params)->params_idr), params_array,
+				    i - 1);
+	return 0;
+
+params_del:
+	p4tc_ext_put_many_params(&((*params)->params_idr), params_array, i - 1);
+	kfree(*params);
+	*params = NULL;
+	return err;
+}
+
+static void p4tc_ext_idr_insert_many(struct p4tc_extern *externs[])
+{
+	int i;
+
+	for (i = 0; i < P4TC_MSGBATCH_SIZE; i++) {
+		struct p4tc_extern *e = externs[i];
+
+		if (!e)
+			continue;
+		/* Replace ERR_PTR(-EBUSY) allocated by p4tc_ext_idr_check_alloc
+		 * if it is just created. If it's updated, free previous extern.
+		 */
+		e = idr_replace(e->elems_idr, e, e->p4tc_ext_key);
+		if (e != ERR_PTR(-EBUSY))
+			call_rcu(&e->rcu, free_p4tc_ext_rcu);
+	}
+}
+
+static const char *
+p4tc_ext_get_kind(struct nlattr *nla, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_MAX + 1];
+	struct nlattr *kind;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_MAX, nla,
+			       p4tc_extern_policy, extack);
+	if (err < 0)
+		return ERR_PTR(err);
+	err = -EINVAL;
+	kind = tb[P4TC_EXT_KIND];
+	if (!kind) {
+		NL_SET_ERR_MSG(extack, "TC extern name must be specified");
+		return ERR_PTR(err);
+	}
+
+	return nla_data(kind);
+}
+
+static int p4tc_ext_init(struct net *net, struct nlattr **tb,
+			 struct p4tc_extern **e,
+			 struct p4tc_extern_inst *inst,
+			 u32 flags, size_t *attrs_size,
+			 struct netlink_ext_ack *extack)
+{
+	const struct p4tc_extern_ops *e_o = inst->ops;
+	struct p4tc_extern_params *params = NULL;
+	struct p4tc_extern *e_orig = NULL;
+	int ret = 0, err = 0;
+	u32 key_param_id = 0;
+	u32 key = 0;
+
+	if (!tb[P4TC_EXT_PARAMS]) {
+		NL_SET_ERR_MSG(extack, "Must specify extern params");
+		return -EINVAL;
+	}
+
+	if (inst->is_scalar) {
+		if (tb[P4TC_EXT_KEY]) {
+			err = p4tc_ext_get_key_param_scalar(inst,
+							    tb[P4TC_EXT_KEY],
+							    &key, extack);
+			if (err < 0)
+				return err;
+
+			if (key != 1) {
+				NL_SET_ERR_MSG(extack,
+					       "Key of scalar must be 1");
+				return -EINVAL;
+			}
+		} else {
+			key = 1;
+		}
+	} else {
+		if (tb[P4TC_EXT_KEY]) {
+			err = p4tc_ext_get_key_param(inst, tb[P4TC_EXT_KEY],
+						     &key, extack);
+			if (err < 0)
+				return err;
+			key_param_id = err;
+		}
+
+		if (!key) {
+			NL_SET_ERR_MSG(extack, "Must specify extern key");
+			return -EINVAL;
+		}
+	}
+
+	if (err < 0)
+		return err;
+
+	err = p4tc_ext_idr_check_alloc(inst, key, &e_orig, extack);
+	if (err < 0)
+		return err;
+
+	err = p4tc_ext_copy(inst, key, e, e_orig, e_o, flags);
+	if (err < 0)
+		return err;
+
+	err = p4tc_ext_init_params(net, inst, &params, tb[P4TC_EXT_PARAMS],
+				   attrs_size, extack);
+	if (err < 0)
+		goto release_idr;
+	*attrs_size = nla_total_size(0);  /* P4TC_EXT_PARAMS nested */
+
+	if (!inst->is_scalar) {
+		err = p4tc_copy_key_param(inst, e_orig->params, params,
+					  key_param_id, &key);
+		if (err < 0) {
+			free_p4tc_ext_params(params);
+			goto release_idr;
+		}
+	}
+
+	(*e)->params = params;
+
+	return ret;
+
+release_idr:
+	p4tc_ext_idr_release(*e);
+
+	return err;
+}
+
+static struct p4tc_extern_param *find_key_param(struct idr *params_idr)
+{
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY)
+			return param;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_extern_param *
+p4tc_ext_init_defval_param(struct p4tc_extern_param *param,
+			   void *value,
+			   struct netlink_ext_ack *extack)
+{
+	const u32 bytesz = BITS_TO_BYTES(param->type->container_bitsz);
+	struct p4tc_extern_param *nparam;
+	int err;
+
+	nparam = kzalloc(sizeof(*nparam), GFP_KERNEL);
+	if (!nparam) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	strscpy(nparam->name, param->name, EXTPARAMNAMSIZ);
+	nparam->type = param->type;
+	nparam->id = param->id;
+
+	nparam->value = kzalloc(bytesz, GFP_KERNEL);
+	if (!nparam->value) {
+		err = -ENOMEM;
+		goto free_param;
+	}
+
+	if (value)
+		memcpy(nparam->value, value, bytesz);
+
+	return nparam;
+
+free_param:
+	kfree(nparam);
+out:
+	return ERR_PTR(err);
+}
+
+static int p4tc_ext_init_defval_params(struct p4tc_extern_params *params,
+				       struct idr *control_params_idr,
+				       u32 key, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+	int err;
+
+	idr_for_each_entry_ul(control_params_idr, param, tmp, id) {
+		struct p4tc_extern_param *nparam;
+
+		if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY)
+			nparam = p4tc_ext_init_defval_param(param, &key,
+							    extack);
+		else
+			nparam = p4tc_ext_init_defval_param(param, param->value,
+							    extack);
+		if (IS_ERR(nparam)) {
+			err = PTR_ERR(nparam);
+			goto free_params;
+		}
+
+		err = idr_alloc_u32(&params->params_idr, nparam, &nparam->id,
+				    nparam->id, GFP_KERNEL);
+		if (err < 0) {
+			kfree(nparam);
+			goto free_params;
+		}
+		params->num_params++;
+	}
+
+	return 0;
+
+free_params:
+	__free_p4tc_ext_params(params);
+	return err;
+}
+
+static int p4tc_ext_init_defval(struct p4tc_extern **e,
+				struct p4tc_extern_inst *inst,
+				u32 key, struct netlink_ext_ack *extack)
+{
+	const struct p4tc_extern_ops *e_o = inst->ops;
+	struct p4tc_extern_params *params = NULL;
+	int err;
+
+	if (!inst->is_scalar) {
+		struct p4tc_extern_param *key_param;
+
+		key_param = find_key_param(&inst->inst_common->control_params_idr);
+		if (!key_param) {
+			NL_SET_ERR_MSG(extack, "Unable to find key param");
+			return -ENOENT;
+		}
+	}
+
+	err = p4tc_ext_idr_create(inst, key, e, e_o, 0);
+	if (err < 0)
+		return err;
+
+	/* We already store it in the IDR, because, when we arrive here, the
+	 * pipeline is still not sealed, and so no runtime command or data
+	 * path thread will be able to access the control_elems_idr yet. Also,
+	 * we arrive here with rtnl_lock, so this code is never accessed
+	 * concurrently from the template pipeline sealing command.
+	 */
+	err = idr_alloc_u32(&inst->inst_common->control_elems_idr, *e, &key,
+			    key, GFP_KERNEL);
+	if (err < 0) {
+		p4tc_ext_idr_purge(*e);
+		return err;
+	}
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params) {
+		err = -ENOMEM;
+		goto release_idr;
+	}
+
+	idr_init(&params->params_idr);
+	rwlock_init(&params->params_lock);
+
+	err = p4tc_ext_init_defval_params(params,
+					  &inst->inst_common->control_params_idr,
+					  key, extack);
+	if (err < 0)
+		goto free_params;
+
+	(*e)->params = params;
+
+	return 0;
+
+free_params:
+	kfree(params);
+
+release_idr:
+	p4tc_ext_idr_release(*e);
+	return err;
+}
+
+static void p4tc_extern_inst_destroy_elems(struct idr *insts_idr)
+{
+	struct p4tc_extern_inst *inst;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(insts_idr, inst, tmp, id) {
+		unsigned long tmp2, elem_id;
+		struct p4tc_extern *e;
+
+		idr_for_each_entry_ul(&inst->inst_common->control_elems_idr, e,
+				      tmp2, elem_id) {
+			p4tc_ext_idr_purge(e);
+		}
+	}
+}
+
+static void p4tc_user_pipe_ext_destroy_elems(struct idr *user_ext_idr)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(user_ext_idr, pipe_ext, tmp, id) {
+		p4tc_extern_inst_destroy_elems(&pipe_ext->e_inst_idr);
+	}
+}
+
+static int
+___p4tc_extern_inst_init_elems(struct p4tc_extern_inst *inst, u32 num_elems)
+{
+	int err = 0;
+	int i;
+
+	for (i = 0; i < num_elems; i++) {
+		struct p4tc_extern *e = NULL;
+
+		err = p4tc_ext_init_defval(&e, inst, i + 1, NULL);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int
+__p4tc_extern_inst_init_elems(struct idr *insts_idr)
+{
+	struct p4tc_extern_inst *inst;
+	unsigned long tmp, id;
+	int err = 0;
+
+	idr_for_each_entry_ul(insts_idr, inst, tmp, id) {
+		err = ___p4tc_extern_inst_init_elems(inst, inst->max_num_elems);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/* Called before sealing the pipeline */
+int p4tc_extern_inst_init_elems(struct idr *user_ext_idr)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long tmp, id;
+	int err;
+
+	idr_for_each_entry_ul(user_ext_idr, pipe_ext, tmp, id) {
+		err = __p4tc_extern_inst_init_elems(&pipe_ext->e_inst_idr);
+		if (err < 0)
+			goto destroy_ext_inst_elems;
+	}
+
+	return 0;
+
+destroy_ext_inst_elems:
+	p4tc_user_pipe_ext_destroy_elems(user_ext_idr);
+	return err;
+}
+
+static struct p4tc_extern_inst *
+__p4tc_ext_inst_find_bynames(struct net *net, struct p4tc_pipeline *pipeline,
+			     const char *extname, const char *instname,
+			     struct netlink_ext_ack *extack)
+{
+	return p4tc_ext_inst_find_bynames(net, pipeline, extname, instname,
+					  extack);
+}
+
+static struct p4tc_extern *
+p4tc_extern_init_1(struct net *net, struct p4tc_pipeline *pipeline,
+		   struct nlattr *nla, const char *kind,
+		   int *init_res, u32 flags, size_t *attrs_size,
+		   struct netlink_ext_ack *extack)
+{
+	struct nla_bitfield32 userflags = { 0, 0 };
+	struct nlattr *tb[P4TC_EXT_MAX + 1];
+	struct p4tc_extern_inst *inst;
+	struct p4tc_extern *e;
+	char *instname;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_MAX, nla,
+			       p4tc_extern_policy, extack);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	if (tb[P4TC_EXT_FLAGS])
+		userflags = nla_get_bitfield32(tb[P4TC_EXT_FLAGS]);
+
+	if (!tb[P4TC_EXT_INST_NAME]) {
+		NL_SET_ERR_MSG(extack,
+			       "TC extern inst name must be specified");
+		return ERR_PTR(-EINVAL);
+	}
+	instname = nla_data(tb[P4TC_EXT_INST_NAME]);
+
+	inst = __p4tc_ext_inst_find_bynames(net, pipeline, kind, instname,
+					    extack);
+	if (IS_ERR(inst))
+		return (void *)inst;
+
+	err = p4tc_ext_init(net, tb, &e, inst, userflags.value | flags,
+			    attrs_size, extack);
+	*init_res = err;
+
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return e;
+}
+
+/* Returns numbers of initialized externs or negative error. */
+static int p4tc_extern_init(struct net *net, struct p4tc_pipeline *pipeline,
+			    struct nlattr *nla, struct p4tc_extern *externs[],
+			    int init_res[], size_t *attrs_size, u32 flags,
+			    struct netlink_ext_ack *extack)
+{
+	const char *ekinds[P4TC_MSGBATCH_SIZE] = {0};
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	struct p4tc_extern *ext;
+	size_t sz = 0;
+	int err;
+	int i;
+
+	err = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL,
+			       extack);
+	if (err < 0)
+		return err;
+
+	for (i = 1; i <= P4TC_MSGBATCH_SIZE && tb[i]; i++) {
+		const char *ekind = p4tc_ext_get_kind(tb[i], extack);
+
+		if (IS_ERR(ekind)) {
+			err = PTR_ERR(ekind);
+			return err;
+		}
+		ekinds[i - 1] = ekind;
+	}
+
+	for (i = 1; i <= P4TC_MSGBATCH_SIZE && tb[i]; i++) {
+		size_t attrs_size_before = *attrs_size;
+		size_t extern_fill_size;
+
+		ext = p4tc_extern_init_1(net, pipeline, tb[i], ekinds[i - 1],
+					 &init_res[i - 1], flags, attrs_size,
+					 extack);
+		if (IS_ERR(ext)) {
+			err = PTR_ERR(ext);
+			goto err;
+		}
+		extern_fill_size = p4tc_extern_fill_size(ext);
+		ext->attrs_size = *attrs_size - attrs_size_before + extern_fill_size;
+		sz += extern_fill_size;
+		/* Start from key 0 */
+		externs[i - 1] = ext;
+	}
+
+	/* We have to commit them all together, because if any error happened in
+	 * between, we could not handle the failure gracefully.
+	 */
+	p4tc_ext_idr_insert_many(externs);
+
+	*attrs_size = p4tc_extern_full_attrs_size(sz);
+	err = i - 1;
+
+	return err;
+
+err:
+	p4tc_extern_destroy(externs, init_res);
+	return err;
+}
+
+static int tce_get_fill(struct sk_buff *skb, struct p4tc_extern *externs[],
+			u32 portid, u32 seq, u16 flags, u32 pipeid, int cmd,
+			int ref, struct netlink_ext_ack *extack)
+{
+	unsigned char *b = skb_tail_pointer(skb);
+	struct nlmsghdr *nlh;
+	struct nlattr *nest;
+	struct p4tcmsg *t;
+
+	nlh = nlmsg_put(skb, portid, seq, cmd, sizeof(*t), flags);
+	if (!nlh)
+		goto out_nlmsg_trim;
+	t = nlmsg_data(nlh);
+	t->pipeid = pipeid;
+	t->obj = P4TC_OBJ_RUNTIME_EXTERN;
+
+	nest = nla_nest_start(skb, P4TC_ROOT);
+	if (p4tc_extern_dump(skb, externs, ref) < 0)
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, nest);
+
+	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int
+p4tc_extern_get_respond(struct net *net, u32 portid, struct nlmsghdr *n,
+			struct p4tc_extern *externs[], u32 pipeid, int cmd,
+			size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
+			GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+	if (tce_get_fill(skb, externs, portid, n->nlmsg_seq, 0, pipeid, cmd,
+			 1, NULL) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill netlink attributes while adding TC extern");
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return rtnl_unicast(skb, net, portid);
+}
+
+static struct p4tc_extern *
+p4tc_extern_get_1(struct net *net, struct p4tc_pipeline *pipeline,
+		  struct nlattr *nla, struct nlmsghdr *n, u32 portid,
+		  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_MAX + 1];
+	struct p4tc_extern_inst *inst;
+	char *kind, *instname;
+	struct p4tc_extern *e;
+	u32 key = 0;
+	int err;
+
+	err = nla_parse_nested(tb, P4TC_EXT_MAX, nla,
+			       p4tc_extern_policy, extack);
+	if (err < 0)
+		goto err_out;
+
+	if (tb[P4TC_EXT_PARAMS]) {
+		NL_SET_ERR_MSG(extack,
+			       "TC extern params mustn't be specified");
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	if (!tb[P4TC_EXT_KIND]) {
+		NL_SET_ERR_MSG(extack,
+			       "TC extern inst name must be specified");
+		err = -EINVAL;
+		goto err_out;
+	}
+	kind = nla_data(tb[P4TC_EXT_KIND]);
+
+	if (!tb[P4TC_EXT_INST_NAME]) {
+		NL_SET_ERR_MSG(extack,
+			       "TC extern inst name must be specified");
+		return ERR_PTR(-EINVAL);
+	}
+	instname = nla_data(tb[P4TC_EXT_INST_NAME]);
+
+	err = -EINVAL;
+	inst = __p4tc_ext_inst_find_bynames(net, pipeline, kind, instname,
+					    extack);
+	if (IS_ERR(inst)) {
+		err = PTR_ERR(inst);
+		goto err_out;
+	}
+
+	if (inst->is_scalar) {
+		if (tb[P4TC_EXT_KEY]) {
+			err = p4tc_ext_get_key_param_scalar(inst,
+							    tb[P4TC_EXT_KEY],
+							    &key, extack);
+			if (err < 0)
+				goto err_out;
+
+			if (key != 1) {
+				NL_SET_ERR_MSG(extack,
+					       "Key of scalar must be 1");
+				err = -EINVAL;
+				goto err_out;
+			}
+		} else {
+			key = 1;
+		}
+	} else {
+		if (tb[P4TC_EXT_KEY]) {
+			err = p4tc_ext_get_key_param(inst, tb[P4TC_EXT_KEY],
+						     &key, extack);
+			if (err < 0)
+				goto err_out;
+		}
+
+		if (!key) {
+			NL_SET_ERR_MSG(extack, "Must specify extern key");
+			err = -EINVAL;
+			goto err_out;
+		}
+	}
+
+	if (__p4tc_ext_idr_search(inst, &e, key) == 0) {
+		err = -ENOENT;
+		NL_SET_ERR_MSG(extack, "TC extern with specified key not found");
+		goto err_out;
+	}
+
+	return e;
+
+err_out:
+	return ERR_PTR(err);
+}
+
+static int
+p4tc_extern_get(struct net *net, struct p4tc_pipeline *pipeline,
+		struct nlattr *nla, struct nlmsghdr *n,
+		u32 portid, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern *externs[P4TC_MSGBATCH_SIZE] = {};
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	struct p4tc_extern *ext;
+	size_t attr_size = 0;
+	u32 pipeid;
+	int i, ret;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL,
+			       extack);
+	if (ret < 0)
+		return ret;
+
+	for (i = 1; i <= P4TC_MSGBATCH_SIZE && tb[i]; i++) {
+		ext = p4tc_extern_get_1(net, pipeline, tb[i], n, portid,
+					extack);
+		if (IS_ERR(ext)) {
+			ret = PTR_ERR(ext);
+			goto err;
+		}
+		attr_size += ext->attrs_size;
+		externs[i - 1] = ext;
+	}
+
+	attr_size = p4tc_extern_full_attrs_size(attr_size);
+
+	pipeid = pipeline->common.p_id;
+	ret = p4tc_extern_get_respond(net, portid, n, externs, pipeid,
+				      RTM_P4TC_GET, attr_size, extack);
+err:
+	p4tc_extern_put_many(externs);
+	return ret;
+}
+
+static int
+p4tc_extern_add_notify(struct net *net, struct nlmsghdr *n,
+		       struct p4tc_extern *externs[], u32 portid, u32 pipeid,
+		       size_t attr_size, struct netlink_ext_ack *extack)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_skb(attr_size <= NLMSG_GOODSIZE ? NLMSG_GOODSIZE : attr_size,
+			GFP_KERNEL);
+	if (!skb)
+		return -ENOBUFS;
+
+	if (tce_get_fill(skb, externs, portid, n->nlmsg_seq, n->nlmsg_flags,
+			 pipeid, n->nlmsg_type, 0, extack) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill netlink attributes while adding TC extern");
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	return rtnetlink_send(skb, net, portid, RTNLGRP_TC,
+			      n->nlmsg_flags & NLM_F_ECHO);
+}
+
+static int p4tc_extern_add(struct net *net, struct p4tc_pipeline *pipeline,
+			   struct nlattr *nla, struct nlmsghdr *n, u32 portid,
+			   u32 flags, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern *externs[P4TC_MSGBATCH_SIZE] = {};
+	int init_res[P4TC_MSGBATCH_SIZE] = {};
+	size_t attr_size = 0;
+	int loop, ret, i;
+	u32 pipeid;
+
+	for (loop = 0; loop < 10; loop++) {
+		ret = p4tc_extern_init(net, pipeline, nla, externs,
+				       init_res, &attr_size, flags, extack);
+		if (ret != -EAGAIN)
+			break;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	pipeid = pipeline->common.p_id;
+	ret = p4tc_extern_add_notify(net, n, externs, portid, pipeid, attr_size,
+				     extack);
+
+	/* only put existing externs */
+	for (i = 0; i < P4TC_MSGBATCH_SIZE; i++)
+		if (init_res[i] == P4TC_EXT_P_CREATED)
+			externs[i] = NULL;
+	p4tc_extern_put_many(externs);
+
+	return ret;
+}
+
+static int parse_dump_ext_attrs(struct nlattr *nla,
+				struct nlattr **tb2)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+
+	if (nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL,
+			     NULL) < 0)
+		return -EINVAL;
+
+	if (!tb[1])
+		return -EINVAL;
+	if (nla_parse_nested(tb2, P4TC_EXT_MAX, tb[1],
+			     p4tc_extern_policy, NULL) < 0)
+		return -EINVAL;
+
+	if (!tb2[P4TC_EXT_KIND])
+		return -EINVAL;
+
+	if (!tb2[P4TC_EXT_INST_NAME])
+		return -EINVAL;
+
+	return 0;
+}
+
+int p4tc_ctl_extern_dump(struct sk_buff *skb, struct netlink_callback *cb,
+			 struct nlattr **tb, const char *pname)
+{
+	struct netlink_ext_ack *extack = cb->extack;
+	unsigned char *b = skb_tail_pointer(skb);
+	struct nlattr *tb2[P4TC_EXT_MAX + 1];
+	struct net *net = sock_net(skb->sk);
+	struct nlattr *count_attr = NULL;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+	char *kind_str, *instname;
+	struct nla_bitfield32 bf;
+	struct nlmsghdr *nlh;
+	struct nlattr *nest;
+	u32 ext_count = 0;
+	struct p4tcmsg *t;
+	int ret = 0;
+
+	pipeline = tcf_pipeline_find_byany(net, pname, 0, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Pipeline must be sealed for extern runtime ops");
+		return -EINVAL;
+	}
+
+	ret = parse_dump_ext_attrs(tb[P4TC_ROOT], tb2);
+	if (ret < 0)
+		return ret;
+
+	kind_str = nla_data(tb2[P4TC_EXT_KIND]);
+
+	instname = nla_data(tb2[P4TC_EXT_INST_NAME]);
+
+	inst = __p4tc_ext_inst_find_bynames(net, pipeline, kind_str, instname,
+					    extack);
+	if (IS_ERR(inst))
+		return PTR_ERR(inst);
+
+	cb->args[2] = 0;
+	if (tb[P4TC_ROOT_FLAGS]) {
+		bf = nla_get_bitfield32(tb[P4TC_ROOT_FLAGS]);
+		cb->args[2] = bf.value;
+	}
+
+	nlh = nlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
+			cb->nlh->nlmsg_type, sizeof(*t), 0);
+	if (!nlh)
+		goto err_out;
+
+	t = nlmsg_data(nlh);
+	t->pipeid = pipeline->common.p_id;
+	t->obj = P4TC_OBJ_RUNTIME_EXTERN;
+	count_attr = nla_reserve(skb, P4TC_ROOT_COUNT, sizeof(u32));
+	if (!count_attr)
+		goto err_out;
+
+	nest = nla_nest_start_noflag(skb, P4TC_ROOT);
+	if (!nest)
+		goto err_out;
+
+	ret = p4tc_ext_dump_walker(inst, skb, cb);
+	if (ret < 0)
+		goto err_out;
+
+	if (ret > 0) {
+		nla_nest_end(skb, nest);
+		ret = skb->len;
+		ext_count = cb->args[1];
+		memcpy(nla_data(count_attr), &ext_count, sizeof(u32));
+		cb->args[1] = 0;
+	} else {
+		nlmsg_trim(skb, b);
+	}
+
+	nlh->nlmsg_len = skb_tail_pointer(skb) - b;
+	if (NETLINK_CB(cb->skb).portid && ret)
+		nlh->nlmsg_flags |= NLM_F_MULTI;
+	return skb->len;
+
+err_out:
+	nlmsg_trim(skb, b);
+	return skb->len;
+}
+
+int p4tc_ctl_extern(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
+		    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	struct net *net = sock_net(skb->sk);
+	u32 portid = NETLINK_CB(skb).portid;
+	struct p4tc_pipeline *pipeline;
+	struct nlattr *root;
+	char *pname = NULL;
+	u32 flags = 0;
+	int ret = 0;
+
+	if (cmd != RTM_P4TC_GET &&
+	    !netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (tb[P4TC_ROOT_PNAME])
+		pname = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack, "Netlink P4TC extern attributes missing");
+		return -EINVAL;
+	}
+
+	root = tb[P4TC_ROOT];
+
+	pipeline = tcf_pipeline_find_byany(net, pname, 0, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Pipeline must be sealed for extern runtime ops");
+		return -EINVAL;
+	}
+
+	/* n->nlmsg_flags & NLM_F_CREATE */
+	switch (n->nlmsg_type) {
+	case RTM_P4TC_CREATE:
+		NL_SET_ERR_MSG(extack,
+			       "Create command is not supported");
+		return -EOPNOTSUPP;
+	case RTM_P4TC_UPDATE:
+		ret = p4tc_extern_add(net, pipeline, root, n, portid, flags,
+				      extack);
+		break;
+	case RTM_P4TC_DEL:
+		NL_SET_ERR_MSG(extack,
+			       "Delete command is not supported");
+		return -EOPNOTSUPP;
+	case RTM_P4TC_GET:
+		ret = p4tc_extern_get(net, pipeline, root, n, portid, extack);
+		break;
+	default:
+		WARN_ON_ONCE("Unknown extern command");
+		return -EOPNOTSUPP;
+	}
+
+	return ret;
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 3ab59a37a..25a05e160 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -27,6 +27,7 @@
 #include <net/netlink.h>
 #include <net/flow_offload.h>
 #include <net/p4tc_types.h>
+#include <net/p4tc_ext_api.h>
 
 static unsigned int pipeline_net_id;
 static struct p4tc_pipeline *root_pipeline;
@@ -99,6 +100,7 @@ static void __net_exit pipeline_exit_net(struct net *net)
 		__tcf_pipeline_put(pipeline, &pipeline->common, NULL);
 	}
 	idr_destroy(&pipe_net->pipeline_idr);
+
 	rtnl_unlock();
 }
 
@@ -119,6 +121,7 @@ static void tcf_pipeline_destroy(struct p4tc_pipeline *pipeline)
 {
 	idr_destroy(&pipeline->p_act_idr);
 	idr_destroy(&pipeline->p_tbl_idr);
+	idr_destroy(&pipeline->user_ext_idr);
 
 	kfree(pipeline);
 }
@@ -141,7 +144,8 @@ static void tcf_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	struct net *net = pipeline->net;
 	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
 	struct net *pipeline_net = maybe_get_net(net);
-	unsigned long iter_act_id, tmp;
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long iter_act_id, ext_id, tmp;
 	struct p4tc_table *table;
 	struct p4tc_act *act;
 	unsigned long tbl_id;
@@ -152,6 +156,17 @@ static void tcf_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, iter_act_id)
 		act->common.ops->put(pipeline, &act->common, extack);
 
+	idr_for_each_entry_ul(&pipeline->user_ext_idr, pipe_ext, tmp, ext_id) {
+		unsigned long tmp_in, inst_id;
+		struct p4tc_extern_inst *inst;
+
+		idr_for_each_entry_ul(&pipe_ext->e_inst_idr, inst, tmp_in, inst_id) {
+			inst->common.ops->put(pipeline, &inst->common, extack);
+		}
+
+		pipe_ext->free(pipe_ext, &pipeline->user_ext_idr);
+	}
+
 	if (pipeline->parser)
 		tcf_parser_del(net, pipeline, pipeline->parser, extack);
 
@@ -230,6 +245,10 @@ static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 		goto free_prealloc_acts;
 	}
 
+	ret = p4tc_extern_inst_init_elems(&pipeline->user_ext_idr);
+	if (ret < 0)
+		goto destroy_prealloc_acts;
+
 	pipeline->p_state = P4TC_STATE_READY;
 
 	for (i = 0; i < act_kinds_with_prealloc; i++) {
@@ -241,12 +260,15 @@ static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 
 	return true;
 
+destroy_prealloc_acts:
+	for (i = 0; i < act_kinds_with_prealloc; i++)
+		tcf_action_destroy(prealloc_acts[i], 0);
+
 free_prealloc_acts:
 	kfree(prealloc_acts);
 
 unset_table_state_ready:
 	tcf_table_put_mask_array(pipeline);
-
 	return ret;
 }
 
@@ -345,6 +367,9 @@ static struct p4tc_pipeline *tcf_pipeline_create(struct net *net,
 
 	idr_init(&pipeline->p_tbl_idr);
 	pipeline->curr_tables = 0;
+	idr_init(&pipeline->p_tbl_idr);
+
+	idr_init(&pipeline->user_ext_idr);
 
 	pipeline->num_created_acts = 0;
 
@@ -676,6 +701,8 @@ static void __tcf_pipeline_init(void)
 
 	strscpy(root_pipeline->common.name, "kernel", PIPELINENAMSIZ);
 
+	idr_init(&root_pipeline->p_ext_idr);
+
 	root_pipeline->common.ops =
 		(struct p4tc_template_ops *)&p4tc_pipeline_ops;
 
diff --git a/net/sched/p4tc/p4tc_runtime_api.c b/net/sched/p4tc/p4tc_runtime_api.c
index 6c4f54a7c..862e30429 100644
--- a/net/sched/p4tc/p4tc_runtime_api.c
+++ b/net/sched/p4tc/p4tc_runtime_api.c
@@ -27,11 +27,13 @@
 #include <net/p4tc.h>
 #include <net/netlink.h>
 #include <net/flow_offload.h>
+#include <net/p4tc_ext_api.h>
 
 static int tc_ctl_p4_root(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
 			  struct netlink_ext_ack *extack)
 {
 	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	int ret;
 
 	switch (t->obj) {
 	case P4TC_OBJ_RUNTIME_TABLE: {
@@ -45,6 +47,11 @@ static int tc_ctl_p4_root(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
 
 		return p4tc_tbl_entry_doit(net, skb, n, cmd, extack);
 	}
+	case P4TC_OBJ_RUNTIME_EXTERN:
+		rtnl_lock();
+		ret = p4tc_ctl_extern(skb, n, cmd, extack);
+		rtnl_unlock();
+		return ret;
 	default:
 		NL_SET_ERR_MSG(extack, "Unknown P4 runtime object type");
 		return -EOPNOTSUPP;
@@ -116,6 +123,8 @@ static int tc_ctl_p4_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		return p4tc_tbl_entry_dumpit(net, skb, cb, tb[P4TC_ROOT],
 					     p_name);
 	}
+	case P4TC_OBJ_RUNTIME_EXTERN:
+		return p4tc_ctl_extern_dump(skb, cb, tb, p_name);
 	default:
 		NL_SET_ERR_MSG_FMT(cb->extack,
 				   "Unknown p4 runtime object type %u\n",
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index 1d2ada740..d401aea39 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -362,8 +362,7 @@ static inline int _tcf_table_put(struct net *net, struct nlattr **tb,
 	idr_remove(&pipeline->p_tbl_idr, table->tbl_id);
 	pipeline->curr_tables -= 1;
 
-	kfree(table->tbl_masks_array);
-	bitmap_free(table->tbl_free_masks_bitmap);
+	__tcf_table_put_mask_array(table);
 
 	kfree(table);
 
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 5cff66dcd..f929da5df 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -45,6 +45,8 @@ static bool obj_is_valid(u32 obj)
 	case P4TC_OBJ_HDR_FIELD:
 	case P4TC_OBJ_ACT:
 	case P4TC_OBJ_TABLE:
+	case P4TC_OBJ_EXT:
+	case P4TC_OBJ_EXT_INST:
 		return true;
 	default:
 		return false;
@@ -56,6 +58,8 @@ static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX] = {
 	[P4TC_OBJ_HDR_FIELD] = &p4tc_hdrfield_ops,
 	[P4TC_OBJ_ACT] = &p4tc_act_ops,
 	[P4TC_OBJ_TABLE] = &p4tc_table_ops,
+	[P4TC_OBJ_EXT] = &p4tc_tmpl_ext_ops,
+	[P4TC_OBJ_EXT_INST] = &p4tc_tmpl_ext_inst_ops,
 };
 
 int tcf_p4_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
diff --git a/net/sched/p4tc/p4tc_tmpl_ext.c b/net/sched/p4tc/p4tc_tmpl_ext.c
new file mode 100644
index 000000000..d25ca3b6b
--- /dev/null
+++ b/net/sched/p4tc/p4tc_tmpl_ext.c
@@ -0,0 +1,2415 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_tmpl_extern.c	P4 TC EXTERN TEMPLATE
+ *
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/skbuff.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <net/net_namespace.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/p4tc_types.h>
+#include <net/sock.h>
+#include <net/p4tc_ext_api.h>
+
+static LIST_HEAD(ext_base);
+static DEFINE_RWLOCK(ext_mod_lock);
+
+static const struct nla_policy tc_extern_inst_policy[P4TC_TMPL_EXT_INST_MAX + 1] = {
+	[P4TC_TMPL_EXT_INST_EXT_NAME] = {
+		.type = NLA_STRING,
+		.len =  EXTERNNAMSIZ
+	},
+	[P4TC_TMPL_EXT_INST_NAME] = {
+		.type = NLA_STRING,
+		.len =  EXTERNINSTNAMSIZ
+	},
+	[P4TC_TMPL_EXT_INST_NUM_ELEMS] = NLA_POLICY_RANGE(NLA_U32, 1,
+							  P4TC_MAX_NUM_EXT_INST_ELEMS),
+	[P4TC_TMPL_EXT_INST_METHODS] = { .type = NLA_NESTED },
+	[P4TC_TMPL_EXT_INST_CONTROL_PARAMS] = { .type = NLA_NESTED }
+};
+
+static const struct nla_policy tc_extern_policy[P4TC_TMPL_EXT_MAX + 1] = {
+	[P4TC_TMPL_EXT_NAME] = { .type = NLA_STRING, .len =  EXTERNNAMSIZ },
+	[P4TC_TMPL_EXT_NUM_INSTS] = NLA_POLICY_RANGE(NLA_U16, 1,
+						     P4TC_MAX_NUM_EXT_INSTS),
+};
+
+static const struct nla_policy tc_method_policy[P4TC_TMPL_EXT_INST_METHOD_MAX + 1] = {
+	[P4TC_TMPL_EXT_INST_METHOD_NAME] = { .type = NLA_STRING, .len = METHODNAMSIZ },
+	[P4TC_TMPL_EXT_INST_METHOD_ID] = { .type = NLA_U32 },
+	[P4TC_TMPL_EXT_INST_METHOD_PARAMS] = { .type = NLA_NESTED },
+};
+
+static const struct nla_policy p4tc_extern_params_policy[P4TC_EXT_PARAMS_MAX + 1] = {
+	[P4TC_EXT_PARAMS_NAME] = { .type = NLA_STRING, .len = EXTPARAMNAMSIZ },
+	[P4TC_EXT_PARAMS_ID] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_VALUE] = { .type = NLA_NESTED },
+	[P4TC_EXT_PARAMS_TYPE] = { .type = NLA_U32 },
+	[P4TC_EXT_PARAMS_BITSZ] = { .type = NLA_U16 },
+	[P4TC_EXT_PARAMS_FLAGS] = { .type = NLA_U8 },
+};
+
+static void p4tc_extern_put_param(struct p4tc_extern_param *param)
+{
+	if (param->mask_shift)
+		p4t_release(param->mask_shift);
+	if (param->value)
+		p4tc_ext_param_value_free(param);
+	kfree(param);
+}
+
+static void p4tc_extern_put_param_idr(struct idr *params_idr,
+				      struct p4tc_extern_param *param)
+{
+	idr_remove(params_idr, param->id);
+	p4tc_extern_put_param(param);
+}
+
+static void p4tc_extern_put_method(struct p4tc_extern_method *method)
+{
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&method->params_idr, param, tmp, id) {
+		idr_remove(&method->params_idr, id);
+		p4tc_extern_put_param(param);
+	}
+	idr_destroy(&method->params_idr);
+	kfree(method);
+}
+
+static void
+p4tc_user_pipeline_ext_free(struct p4tc_user_pipeline_extern *pipe_ext,
+			    struct idr *tmpl_exts_idr)
+{
+	idr_remove(tmpl_exts_idr, pipe_ext->ext_id);
+	idr_destroy(&pipe_ext->e_inst_idr);
+	refcount_dec(&pipe_ext->tmpl_ext->tmpl_ref);
+	kfree(pipe_ext);
+}
+
+static void
+p4tc_user_pipeline_ext_put(struct p4tc_pipeline *pipeline,
+			   struct p4tc_user_pipeline_extern *pipe_ext,
+			   bool release, struct idr *tmpl_exts_idr)
+{
+	if (refcount_dec_and_test(&pipe_ext->ext_ref) && release)
+		p4tc_user_pipeline_ext_free(pipe_ext, tmpl_exts_idr);
+}
+
+static void
+_p4tc_tmpl_ext_inst_common_put(struct p4tc_extern_inst_common *common)
+{
+	struct p4tc_extern_method *method;
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+
+	p4tc_ext_purge(&common->control_elems_idr);
+
+	idr_for_each_entry_ul(&common->methods_idr, method, tmp, id) {
+		idr_remove(&common->methods_idr, id);
+		p4tc_extern_put_method(method);
+	}
+
+	idr_for_each_entry_ul(&common->control_params_idr, param, tmp, id) {
+		idr_remove(&common->control_params_idr, id);
+		p4tc_extern_put_param(param);
+	}
+
+	kfree(common);
+}
+
+static int _p4tc_tmpl_ext_inst_put(struct p4tc_pipeline *pipeline,
+				   struct p4tc_user_pipeline_extern *pipe_ext,
+				   struct p4tc_extern_inst *inst,
+				   bool unconditional_purge, bool release,
+				   struct netlink_ext_ack *extack)
+{
+	if (!unconditional_purge && !refcount_dec_if_one(&inst->inst_ref)) {
+		NL_SET_ERR_MSG(extack,
+			       "Can't delete referenced extern instance template");
+		return -EBUSY;
+	}
+
+	_p4tc_tmpl_ext_inst_common_put(inst->inst_common);
+
+	idr_remove(&pipe_ext->e_inst_idr, inst->ext_inst_id);
+	refcount_dec(&pipe_ext->curr_insts_num);
+
+	p4tc_user_pipeline_ext_put(pipeline, pipe_ext, release,
+				   &pipeline->user_ext_idr);
+
+	kfree(inst);
+
+	return 0;
+}
+
+static int _p4tc_tmpl_ext_put(struct p4tc_pipeline *pipeline,
+			      struct p4tc_tmpl_extern *ext,
+			      bool unconditional_purge,
+			      struct netlink_ext_ack *extack)
+{
+	if (!unconditional_purge && !refcount_dec_if_one(&ext->tmpl_ref)) {
+		NL_SET_ERR_MSG(extack,
+			       "Can't delete referenced extern template");
+		return -EBUSY;
+	}
+
+	idr_remove(&pipeline->p_ext_idr, ext->ext_id);
+	p4tc_extern_ops_put(ext->ops);
+
+	kfree(ext);
+
+	return 0;
+}
+
+static int p4tc_tmpl_ext_put(struct p4tc_pipeline *pipeline,
+			     struct p4tc_template_common *tmpl,
+			     struct netlink_ext_ack *extack)
+{
+	struct p4tc_tmpl_extern *ext;
+
+	ext = to_extern(tmpl);
+
+	return _p4tc_tmpl_ext_put(pipeline, ext, true, extack);
+}
+
+static int p4tc_tmpl_ext_inst_put(struct p4tc_pipeline *pipeline,
+				  struct p4tc_template_common *tmpl,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst *inst;
+
+	inst = to_extern_inst(tmpl);
+
+	return _p4tc_tmpl_ext_inst_put(pipeline, inst->pipe_ext, inst,
+				       true, false, extack);
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_name(struct p4tc_pipeline *pipeline, const char *extern_name)
+{
+	struct p4tc_tmpl_extern *ext;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&pipeline->p_ext_idr, ext, tmp, id)
+		if (ext->common.name[0] &&
+		    strncmp(ext->common.name, extern_name,
+			    EXTERNNAMSIZ) == 0)
+			return ext;
+
+	return NULL;
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_byid(struct p4tc_pipeline *pipeline, const u32 ext_id)
+{
+	return idr_find(&pipeline->p_ext_idr, ext_id);
+}
+
+struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_byany(struct p4tc_pipeline *pipeline,
+			 const char *extern_name, u32 ext_id,
+			 struct netlink_ext_ack *extack)
+{
+	struct p4tc_tmpl_extern *ext;
+	int err;
+
+	if (ext_id) {
+		ext = p4tc_tmpl_ext_find_byid(pipeline, ext_id);
+		if (!ext) {
+			NL_SET_ERR_MSG(extack, "Unable to find ext by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (extern_name) {
+			ext = p4tc_tmpl_ext_find_name(pipeline, extern_name);
+			if (!ext) {
+				NL_SET_ERR_MSG(extack,
+					       "Extern name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify ext name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return ext;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byid(struct p4tc_user_pipeline_extern *pipe_ext,
+			const u32 inst_id)
+{
+	struct p4tc_extern_inst *ext_inst;
+
+	ext_inst = idr_find(&pipe_ext->e_inst_idr, inst_id);
+
+	return ext_inst;
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byname(struct p4tc_user_pipeline_extern *pipe_ext,
+			  const char *instname)
+{
+	struct p4tc_extern_inst *ext_inst;
+	unsigned long tmp, inst_id;
+
+	idr_for_each_entry_ul(&pipe_ext->e_inst_idr, ext_inst, tmp, inst_id) {
+		if (strncmp(ext_inst->common.name, instname, EXTERNINSTNAMSIZ) == 0)
+			return ext_inst;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byany(struct p4tc_user_pipeline_extern *pipe_ext,
+			 const char *instname, u32 instid,
+			 struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst *inst;
+	int err;
+
+	if (instid) {
+		inst = p4tc_ext_inst_find_byid(pipe_ext, instid);
+		if (!inst) {
+			NL_SET_ERR_MSG(extack, "Unable to find instance by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (instname) {
+			inst = p4tc_ext_inst_find_byname(pipe_ext, instname);
+			if (!inst) {
+				NL_SET_ERR_MSG_FMT(extack,
+						   "Instance name not found %s\n",
+						   instname);
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify instance name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return inst;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_inst *
+p4tc_ext_inst_find_byanyattr(struct p4tc_user_pipeline_extern *pipe_ext,
+			     struct nlattr *name_attr, u32 instid,
+			     struct netlink_ext_ack *extack)
+{
+	char *instname = NULL;
+
+	if (name_attr)
+		instname = nla_data(name_attr);
+
+	return p4tc_ext_inst_find_byany(pipe_ext, instname, instid,
+					extack);
+}
+
+static void p4tc_extern_put_many_params(struct idr *params_idr,
+					struct p4tc_extern_param *params[],
+					bool remove_from_idr,
+					int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++) {
+		if (remove_from_idr)
+			idr_remove(params_idr, params[i]->id);
+		p4tc_extern_put_param(params[i]);
+	}
+}
+
+static void p4tc_extern_put_many_methods(struct idr *methods_idr,
+					 struct p4tc_extern_method *methods[],
+					 bool remove_from_idr,
+					 int methods_count)
+{
+	int i;
+
+	for (i = 0; i < methods_count; i++) {
+		if (remove_from_idr)
+			idr_remove(methods_idr, methods[i]->method_id);
+		p4tc_extern_put_method(methods[i]);
+	}
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_param_find_byname(struct idr *params_idr, const char *param_name)
+{
+	struct p4tc_extern_param *param;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		if (param == ERR_PTR(-EBUSY))
+			continue;
+		if (strncmp(param->name, param_name, EXTPARAMNAMSIZ) == 0)
+			return param;
+	}
+
+	return NULL;
+}
+
+struct p4tc_extern_param *
+p4tc_extern_param_find_byid(struct idr *params_idr, const u32 param_id)
+{
+	return idr_find(params_idr, param_id);
+}
+EXPORT_SYMBOL(p4tc_extern_param_find_byid);
+
+static struct p4tc_extern_param *
+p4tc_extern_param_find_byany(struct idr *params_idr, const char *param_name,
+			     const u32 param_id, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	int err;
+
+	if (param_id) {
+		param = p4tc_extern_param_find_byid(params_idr, param_id);
+		if (!param) {
+			NL_SET_ERR_MSG(extack, "Unable to find param by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (param_name) {
+			param = p4tc_extern_param_find_byname(params_idr,
+							      param_name);
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
+struct p4tc_extern_param *
+p4tc_extern_param_find_byanyattr(struct idr *params_idr,
+				 struct nlattr *name_attr,
+				 const u32 param_id,
+				 struct netlink_ext_ack *extack)
+{
+	char *param_name = NULL;
+
+	if (name_attr)
+		param_name = nla_data(name_attr);
+
+	return p4tc_extern_param_find_byany(params_idr, param_name, param_id,
+					    extack);
+}
+
+static void p4tc_extern_params_replace_many(struct idr *params_idr,
+					    struct p4tc_extern_param *params[],
+					    int params_count)
+{
+	int i;
+
+	for (i = 0; i < params_count; i++) {
+		struct p4tc_extern_param *param;
+
+		param = idr_replace(params_idr, params[i], params[i]->id);
+		if (param != ERR_PTR(-EBUSY))
+			p4tc_extern_put_param(param);
+	}
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_create_param(struct idr *params_idr, struct nlattr **tb,
+			 u32 param_id, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	u8 *flags = NULL;
+	char *name;
+	int ret;
+
+	if (tb[P4TC_EXT_PARAMS_NAME]) {
+		name = nla_data(tb[P4TC_EXT_PARAMS_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if ((param_id && p4tc_extern_param_find_byid(params_idr, param_id)) ||
+	    p4tc_extern_param_find_byname(params_idr, name)) {
+		NL_SET_ERR_MSG_FMT(extack, "Param already exists %s", name);
+		ret = -EEXIST;
+		goto free;
+	}
+
+	if ((tb[P4TC_EXT_PARAMS_TYPE] && !tb[P4TC_EXT_PARAMS_BITSZ]) ||
+	    (!tb[P4TC_EXT_PARAMS_TYPE] && tb[P4TC_EXT_PARAMS_BITSZ])) {
+		NL_SET_ERR_MSG(extack, "Must specify type with bit size");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (tb[P4TC_EXT_PARAMS_TYPE]) {
+		struct p4tc_type_mask_shift *mask_shift = NULL;
+		struct p4tc_type *type;
+		u32 typeid;
+		u16 bitsz;
+
+		typeid = nla_get_u32(tb[P4TC_EXT_PARAMS_TYPE]);
+		bitsz = nla_get_u16(tb[P4TC_EXT_PARAMS_BITSZ]);
+
+		type = p4type_find_byid(typeid);
+		if (!type) {
+			NL_SET_ERR_MSG(extack, "Param type is invalid");
+			ret = -EINVAL;
+			goto free;
+		}
+		param->type = type;
+		if (bitsz > param->type->bitsz) {
+			NL_SET_ERR_MSG(extack, "Bit size is bigger than type");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (type->ops->create_bitops) {
+			mask_shift = type->ops->create_bitops(bitsz, 0,
+							      bitsz - 1,
+							      extack);
+			if (IS_ERR(mask_shift)) {
+				ret = PTR_ERR(mask_shift);
+				goto free;
+			}
+		}
+		param->mask_shift = mask_shift;
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify param type");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (tb[P4TC_EXT_PARAMS_FLAGS]) {
+		flags = nla_data(tb[P4TC_EXT_PARAMS_FLAGS]);
+		param->flags = *flags;
+	}
+
+	if (flags && *flags & P4TC_EXT_PARAMS_FLAG_ISKEY) {
+		switch (param->type->typeid) {
+		case P4T_U8:
+		case P4T_U16:
+		case P4T_U32:
+			break;
+		default: {
+			NL_SET_ERR_MSG(extack,
+				       "Key must be an unsigned integer");
+			ret = -EINVAL;
+			goto free_mask_shift;
+		}
+		}
+	}
+
+	if (param_id) {
+		ret = idr_alloc_u32(params_idr, ERR_PTR(-EBUSY), &param_id,
+				    param_id, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free_mask_shift;
+		}
+		param->id = param_id;
+	} else {
+		param->id = 1;
+
+		ret = idr_alloc_u32(params_idr, ERR_PTR(-EBUSY), &param->id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate param id");
+			goto free_mask_shift;
+		}
+	}
+
+	strscpy(param->name, name, EXTPARAMNAMSIZ);
+
+	return param;
+
+free_mask_shift:
+	p4t_release(param->mask_shift);
+
+free:
+	kfree(param);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_create_param_value(struct net *net, struct idr *params_idr,
+			       struct nlattr **tb, u32 param_id,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	int err;
+
+	param = p4tc_extern_create_param(params_idr, tb, param_id, extack);
+	if (IS_ERR(param))
+		return param;
+
+	err = p4tc_ext_param_value_init(net, param, tb, param->type->typeid,
+					false, extack);
+	if (err < 0) {
+		p4tc_extern_put_param_idr(params_idr, param);
+		return ERR_PTR(err);
+	}
+
+	return param;
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_update_param(struct idr *params_idr, struct nlattr **tb,
+			 const u32 param_id, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param_old, *param;
+	int ret;
+
+	param_old = p4tc_extern_param_find_byanyattr(params_idr,
+						     tb[P4TC_EXT_PARAMS_NAME],
+						     param_id, extack);
+	if (IS_ERR(param_old))
+		return param_old;
+
+	param = kzalloc(sizeof(*param), GFP_KERNEL);
+	if (!param) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	strscpy(param->name, param_old->name, EXTPARAMNAMSIZ);
+	param->id = param_old->id;
+
+	if (tb[P4TC_EXT_PARAMS_TYPE]) {
+		u32 typeid;
+
+		typeid = nla_get_u32(tb[P4TC_EXT_PARAMS_TYPE]);
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
+	if (param_old->flags & P4TC_EXT_PARAMS_FLAG_ISKEY) {
+		switch (param->type->typeid) {
+		case P4T_U8:
+		case P4T_U16:
+		case P4T_U32:
+			break;
+		default: {
+			NL_SET_ERR_MSG(extack,
+				       "Key must be an unsigned integer");
+			ret = -EINVAL;
+			goto free;
+		}
+		}
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
+static struct p4tc_extern_param *
+p4tc_extern_update_param_value(struct net *net, struct idr *params_idr,
+			       struct nlattr **tb, u32 param_id,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *param;
+	int err;
+
+	param = p4tc_extern_update_param(params_idr, tb, param_id, extack);
+	if (IS_ERR(param))
+		return param;
+
+	err = p4tc_ext_param_value_init(net, param, tb, param->type->typeid,
+					false, extack);
+	if (err < 0) {
+		p4tc_extern_put_param(param);
+		return ERR_PTR(err);
+	}
+
+	return param;
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_init_param(struct net *net, struct idr *params_idr,
+		       struct nlattr *nla, bool update,
+		       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	u32 param_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tb[P4TC_EXT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_EXT_PARAMS_ID]);
+
+	if (update) {
+		return p4tc_extern_update_param(params_idr, tb, param_id,
+						extack);
+	} else {
+		return p4tc_extern_create_param(params_idr, tb, param_id,
+						extack);
+	}
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_param *
+p4tc_extern_init_param_value(struct net *net, struct idr *params_idr,
+			     struct nlattr *nla, bool update,
+			     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_EXT_PARAMS_MAX + 1];
+	u32 param_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_EXT_PARAMS_MAX, nla,
+			       p4tc_extern_params_policy, extack);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tb[P4TC_EXT_PARAMS_ID])
+		param_id = nla_get_u32(tb[P4TC_EXT_PARAMS_ID]);
+
+	if (update)
+		return p4tc_extern_update_param_value(net, params_idr, tb,
+						      param_id, extack);
+	else
+		return p4tc_extern_create_param_value(net, params_idr, tb,
+						      param_id, extack);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static int p4tc_extern_init_params(struct net *net, struct idr *params_idr,
+				   struct nlattr *nla,
+				   struct p4tc_extern_param *params[],
+				   bool update,
+				   struct netlink_ext_ack *extack)
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
+		struct p4tc_extern_param *param;
+
+		param = p4tc_extern_init_param(net, params_idr, tb[i], update,
+					       extack);
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
+	p4tc_extern_put_many_params(params_idr, params, !update, i - 1);
+	return ret;
+}
+
+static int p4tc_extern_init_params_value(struct net *net,
+					 struct p4tc_extern_inst *inst,
+					 struct nlattr *nla,
+					 struct p4tc_extern_param *params[],
+					 bool update,
+					 struct netlink_ext_ack *extack)
+{
+	struct idr *params_idr = &inst->inst_common->control_params_idr;
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	bool has_scalar_param = false;
+	bool has_key_param = false;
+	int num_params_added = 0;
+	int ret;
+	int i;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (ret < 0)
+		return -EINVAL;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		struct p4tc_extern_param *param;
+
+		param = p4tc_extern_init_param_value(net, params_idr, tb[i],
+						     update, extack);
+		if (IS_ERR(param)) {
+			ret = PTR_ERR(param);
+			goto params_del;
+		}
+
+		params[num_params_added] = param;
+		num_params_added++;
+
+		if (has_key_param) {
+			if (param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY) {
+				NL_SET_ERR_MSG(extack,
+					       "There can't be 2 key params");
+				ret = -EINVAL;
+				goto params_del;
+			}
+		} else {
+			has_key_param = param->flags & P4TC_EXT_PARAMS_FLAG_ISKEY;
+		}
+		if (has_scalar_param) {
+			if (!param->flags ||
+			    (param->flags & P4TC_EXT_PARAMS_FLAG_IS_DATASCALAR)) {
+				NL_SET_ERR_MSG(extack,
+					       "All data parameters must be scalars");
+				ret = -EINVAL;
+				goto params_del;
+			}
+		} else {
+			has_scalar_param = param->flags & P4TC_EXT_PARAMS_FLAG_IS_DATASCALAR;
+		}
+	}
+	inst->is_scalar = has_scalar_param;
+
+	return num_params_added;
+
+params_del:
+	p4tc_extern_put_many_params(params_idr, params, !update,
+				    num_params_added);
+	return ret;
+}
+
+static void
+p4tc_extern_methods_replace_many(struct idr *methods_idr,
+				 struct p4tc_extern_method *methods[],
+				 int methods_count)
+{
+	int i;
+
+	for (i = 0; i < methods_count; i++) {
+		struct p4tc_extern_method *method = methods[i];
+
+		method = idr_replace(methods_idr, method, method->method_id);
+		if (method != ERR_PTR(-EBUSY))
+			p4tc_extern_put_method(method);
+	}
+}
+
+static struct p4tc_extern_method *
+method_find_byid(struct idr *methods_idr, const u32 method_id)
+{
+	return idr_find(methods_idr, method_id);
+}
+
+static struct p4tc_extern_method *
+method_find_byname(struct idr *methods_idr, const char *method_name)
+{
+	struct p4tc_extern_method *method;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(methods_idr, method, tmp, id) {
+		if (method == ERR_PTR(-EBUSY))
+			continue;
+		if (strncmp(method->method_name, method_name,
+			    METHODNAMSIZ) == 0)
+			return method;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_extern_method *
+method_find_byany(struct idr *methods_idr, const char *method_name,
+		  const u32 method_id, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_method *method;
+	int err;
+
+	if (method_id) {
+		method = method_find_byid(methods_idr, method_id);
+		if (!method) {
+			NL_SET_ERR_MSG(extack, "Unable to find method by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (method_name) {
+			method = method_find_byname(methods_idr, method_name);
+			if (!method) {
+				NL_SET_ERR_MSG(extack,
+					       "Method name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify method name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return method;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_method *
+p4tc_extern_create_method(struct net *net, struct idr *methods_idr,
+			  struct nlattr **tb, u32 method_id,
+			  struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *params[P4TC_MSGBATCH_SIZE] = { NULL };
+	struct p4tc_extern_method *method;
+	int num_params;
+	char *name;
+	int ret;
+
+	if (tb[P4TC_TMPL_EXT_INST_METHOD_NAME]) {
+		name = nla_data(tb[P4TC_TMPL_EXT_INST_METHOD_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify method name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	method = kzalloc(sizeof(*method), GFP_KERNEL);
+	if (!method) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (method_find_byid(methods_idr, method_id) ||
+	    (method_find_byname(methods_idr, name))) {
+		NL_SET_ERR_MSG(extack, "Method already exists");
+		ret = -EEXIST;
+		goto free_method;
+	}
+
+	idr_init(&method->params_idr);
+	if (method_id) {
+		ret = idr_alloc_u32(methods_idr, ERR_PTR(-EBUSY), &method_id,
+				    method_id, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate method id");
+			goto free_method;
+		}
+		method->method_id = method_id;
+	} else {
+		method->method_id = 1;
+
+		ret = idr_alloc_u32(methods_idr, ERR_PTR(-EBUSY),
+				    &method->method_id, UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate method id");
+			goto free_method;
+		}
+	}
+
+	if (tb[P4TC_TMPL_EXT_INST_METHOD_PARAMS]) {
+		num_params = p4tc_extern_init_params(net, &method->params_idr,
+						     tb[P4TC_TMPL_EXT_INST_METHOD_PARAMS],
+						     params, false, extack);
+		if (num_params < 0) {
+			ret = num_params;
+			goto idr_rm;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify method name");
+		ret = -EINVAL;
+		goto free_method;
+	}
+
+	strscpy(method->method_name, name, METHODNAMSIZ);
+	p4tc_extern_params_replace_many(&method->params_idr, params,
+					num_params);
+
+	return method;
+
+idr_rm:
+	idr_remove(methods_idr, method->method_id);
+
+free_method:
+	kfree(method);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_method *
+p4tc_extern_update_method(struct net *net, struct idr *methods_idr,
+			  struct nlattr **tb, u32 method_id,
+			  struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *params[P4TC_MSGBATCH_SIZE] = { NULL };
+	struct p4tc_extern_method *method_old, *method;
+	char *method_name;
+	int num_params;
+	int ret;
+
+	if (tb[P4TC_TMPL_EXT_INST_METHOD_NAME]) {
+		method_name = nla_data(tb[P4TC_TMPL_EXT_INST_METHOD_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify method name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	method_old = method_find_byany(methods_idr, method_name, method_id,
+				       extack);
+	if (IS_ERR(method_old))
+		return method_old;
+
+	method = kzalloc(sizeof(*method), GFP_KERNEL);
+	if (!method) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	strscpy(method->method_name, method_old->method_name, METHODNAMSIZ);
+	method->method_id = method_old->method_id;
+
+	idr_init(&method->params_idr);
+	if (tb[P4TC_TMPL_EXT_INST_METHOD_PARAMS]) {
+		num_params = p4tc_extern_init_params(net, &method->params_idr,
+						     tb[P4TC_TMPL_EXT_INST_METHOD_PARAMS],
+						     params, false, extack);
+		if (num_params < 0) {
+			ret = num_params;
+			goto free_method;
+		}
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify method name");
+		ret = -EINVAL;
+		goto free_method;
+	}
+
+	p4tc_extern_params_replace_many(&method->params_idr, params,
+					num_params);
+
+	return method;
+
+free_method:
+	kfree(method);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_method *
+p4tc_extern_init_method(struct net *net, struct idr *methods_idr,
+			struct nlattr *nla, bool update,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_METHOD_MAX + 1];
+	u32 method_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TMPL_EXT_INST_METHOD_MAX, nla,
+			       tc_method_policy, extack);
+	if (ret < 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (tb[P4TC_TMPL_EXT_INST_METHOD_ID])
+		method_id = nla_get_u32(tb[P4TC_TMPL_EXT_INST_METHOD_ID]);
+
+	if (update)
+		return p4tc_extern_update_method(net, methods_idr, tb,
+						 method_id, extack);
+
+	return p4tc_extern_create_method(net, methods_idr, tb,
+					 method_id, extack);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static int p4tc_extern_init_methods(struct net *net,
+				    struct idr *methods_idr,
+				    struct p4tc_extern_method **methods,
+				    struct nlattr *nla, bool update,
+				    struct netlink_ext_ack *extack)
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
+		struct p4tc_extern_method *method;
+
+		method = p4tc_extern_init_method(net, methods_idr, tb[i],
+						 update, extack);
+		if (IS_ERR(method)) {
+			ret = PTR_ERR(method);
+			goto methods_del;
+		}
+		methods[i - 1] = method;
+	}
+
+	return i - 1;
+
+methods_del:
+	p4tc_extern_put_many_methods(methods_idr, methods, !update, i - 1);
+	return ret;
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_find_byanyattr(struct p4tc_pipeline *pipeline,
+			     struct nlattr *name_attr, u32 ext_id,
+			     struct netlink_ext_ack *extack)
+{
+	char *extern_name = NULL;
+
+	if (name_attr)
+		extern_name = nla_data(name_attr);
+
+	return p4tc_tmpl_ext_find_byany(pipeline, extern_name, ext_id,
+				       extack);
+}
+
+static struct p4tc_extern_ops *p4tc_extern_lookup_n(char *kind)
+{
+	struct p4tc_extern_ops *a = NULL;
+
+	read_lock(&ext_mod_lock);
+	list_for_each_entry(a, &ext_base, head) {
+		if (strcmp(kind, a->kind) == 0) {
+			read_unlock(&ext_mod_lock);
+			return a;
+		}
+	}
+	read_unlock(&ext_mod_lock);
+
+	return NULL;
+}
+
+/* lookup by name */
+struct p4tc_extern_ops *p4tc_extern_ops_get(char *kind)
+{
+	char prepended_kind[EXTERNNAMSIZ] = {0};
+	struct p4tc_extern_ops *a = NULL;
+	int num_bytes_written;
+
+	if (!kind)
+		return NULL;
+
+	num_bytes_written = snprintf(prepended_kind, EXTERNNAMSIZ, "ext_%s",
+				     kind);
+	/* Extern name was too long */
+	if (num_bytes_written == EXTERNNAMSIZ)
+		return NULL;
+
+	a = p4tc_extern_lookup_n(prepended_kind);
+	if (a) {
+		if (try_module_get(a->owner))
+			return a;
+	}
+
+	return a;
+}
+
+void p4tc_extern_ops_put(const struct p4tc_extern_ops *ops)
+{
+	if (ops)
+		module_put(ops->owner);
+}
+
+int p4tc_register_extern(struct p4tc_extern_ops *ext)
+{
+	if (p4tc_extern_lookup_n(ext->kind))
+		return -EEXIST;
+
+	write_lock(&ext_mod_lock);
+	list_add_tail(&ext->head, &ext_base);
+	write_unlock(&ext_mod_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(p4tc_register_extern);
+
+int p4tc_unregister_extern(struct p4tc_extern_ops *ext)
+{
+	struct p4tc_extern_ops *a;
+	int err = -ENOENT;
+
+	write_lock(&ext_mod_lock);
+	list_for_each_entry(a, &ext_base, head) {
+		if (a == ext) {
+			list_del(&ext->head);
+			err = 0;
+			break;
+		}
+	}
+	write_unlock(&ext_mod_lock);
+	return err;
+}
+EXPORT_SYMBOL(p4tc_unregister_extern);
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byid(struct p4tc_pipeline *pipeline,
+				 const u32 ext_id)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+
+	pipe_ext = idr_find(&pipeline->user_ext_idr, ext_id);
+
+	return pipe_ext;
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byname(struct p4tc_pipeline *pipeline,
+				   const char *extname)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	unsigned long tmp, ext_id;
+
+	idr_for_each_entry_ul(&pipeline->user_ext_idr, pipe_ext, tmp, ext_id) {
+		if (strncmp(pipe_ext->ext_name, extname, EXTERNNAMSIZ) == 0)
+			return pipe_ext;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byany(struct p4tc_pipeline *pipeline,
+				  const char *extname, u32 ext_id,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	int err;
+
+	if (ext_id) {
+		pipe_ext = p4tc_user_pipeline_ext_find_byid(pipeline, ext_id);
+		if (!pipe_ext) {
+			NL_SET_ERR_MSG(extack, "Unable to find extern");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (extname) {
+			pipe_ext = p4tc_user_pipeline_ext_find_byname(pipeline,
+								      extname);
+			if (!pipe_ext) {
+				NL_SET_ERR_MSG(extack,
+					       "Extern name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify extern name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return pipe_ext;
+
+out:
+	return ERR_PTR(err);
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_byanyattr(struct p4tc_pipeline *pipeline,
+				      struct nlattr *name_attr, u32 ext_id,
+				      struct netlink_ext_ack *extack)
+{
+	char *extname = NULL;
+
+	if (name_attr)
+		extname = nla_data(name_attr);
+
+	return p4tc_user_pipeline_ext_find_byany(pipeline, extname, ext_id,
+						 extack);
+}
+
+static inline bool
+p4tc_user_pipeline_insts_exceeded(struct p4tc_user_pipeline_extern *pipe_ext)
+{
+	const u32 max_num_insts = pipe_ext->tmpl_ext->max_num_insts;
+
+	if (refcount_read(&pipe_ext->curr_insts_num) - 1 == max_num_insts)
+		return true;
+
+	return false;
+}
+
+static struct p4tc_user_pipeline_extern *
+p4tc_user_pipeline_ext_find_or_create(struct p4tc_pipeline *pipeline,
+				      struct p4tc_tmpl_extern *tmpl_ext,
+				      bool *allocated_pipe_ext,
+				      struct netlink_ext_ack *extack)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	int err;
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byid(pipeline, tmpl_ext->ext_id);
+	if (pipe_ext) {
+		bool exceeded_max_insts;
+
+		exceeded_max_insts = p4tc_user_pipeline_insts_exceeded(pipe_ext);
+		if (exceeded_max_insts) {
+			NL_SET_ERR_MSG(extack,
+				       "Maximum number of instances exceeded");
+			return ERR_PTR(-EINVAL);
+		}
+
+		refcount_inc(&pipe_ext->ext_ref);
+		refcount_inc(&pipe_ext->curr_insts_num);
+		return pipe_ext;
+	}
+
+	pipe_ext = kzalloc(sizeof(*pipe_ext), GFP_KERNEL);
+	if (!pipe_ext)
+		return ERR_PTR(-ENOMEM);
+	pipe_ext->ext_id = tmpl_ext->ext_id;
+	err = idr_alloc_u32(&pipeline->user_ext_idr, pipe_ext,
+			    &pipe_ext->ext_id, pipe_ext->ext_id, GFP_KERNEL);
+	if (err < 0)
+		goto free_pipe_ext;
+
+	strscpy(pipe_ext->ext_name, tmpl_ext->common.name, EXTERNNAMSIZ);
+	idr_init(&pipe_ext->e_inst_idr);
+	refcount_set(&pipe_ext->ext_ref, 1);
+	refcount_set(&pipe_ext->curr_insts_num, 1);
+	refcount_inc(&tmpl_ext->tmpl_ref);
+	pipe_ext->tmpl_ext = tmpl_ext;
+	pipe_ext->free = p4tc_user_pipeline_ext_free;
+
+	*allocated_pipe_ext = true;
+
+	return pipe_ext;
+
+free_pipe_ext:
+	kfree(pipe_ext);
+	return ERR_PTR(err);
+}
+
+struct p4tc_extern_inst *
+p4tc_ext_inst_find_bynames(struct net *net, struct p4tc_pipeline *pipeline,
+			   const char *extname, const char *instname,
+			   struct netlink_ext_ack *extack)
+{
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	struct p4tc_extern_inst *inst;
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byany(pipeline, extname, 0,
+						     extack);
+	if (IS_ERR(pipe_ext))
+		return (void *)pipe_ext;
+
+	inst = p4tc_ext_inst_find_byany(pipe_ext, instname, 0, extack);
+	if (IS_ERR(inst))
+		return inst;
+
+	return inst;
+}
+
+struct p4tc_extern_inst *
+p4tc_ext_inst_get_byids(struct net *net, struct p4tc_pipeline **pipeline,
+			const u32 pipe_id,
+			struct p4tc_user_pipeline_extern **pipe_ext,
+			const u32 ext_id, const u32 inst_id)
+{
+	struct p4tc_extern_inst *inst;
+	int err;
+
+	*pipeline = tcf_pipeline_find_byid(net, pipe_id);
+	if (!*pipeline)
+		return ERR_PTR(-ENOENT);
+
+	/* Pipeline was deleted in parallel */
+	if (!refcount_inc_not_zero(&((*pipeline)->p_ctrl_ref)))
+		return ERR_PTR(-EBUSY);
+
+	*pipe_ext = p4tc_user_pipeline_ext_find_byid(*pipeline, ext_id);
+	if (!*pipe_ext) {
+		err = -ENOENT;
+		goto refcount_dec_pipeline;
+	}
+
+	/* Pipeline extern template was deleted in parallel */
+	if (!refcount_inc_not_zero(&((*pipe_ext)->ext_ref))) {
+		err = -EBUSY;
+		goto refcount_dec_pipeline;
+	}
+
+	inst = p4tc_ext_inst_find_byid(*pipe_ext, inst_id);
+	if (!inst) {
+		err = -EBUSY;
+		goto refcount_dec_pipe_tmpl_ext;
+	}
+
+	/* Extern instance was deleted in parallel */
+	if (!refcount_inc_not_zero(&inst->inst_ref)) {
+		err = -EBUSY;
+		goto refcount_dec_pipe_tmpl_ext;
+	}
+
+	return inst;
+
+refcount_dec_pipe_tmpl_ext:
+	refcount_dec(&((*pipe_ext)->ext_ref));
+
+refcount_dec_pipeline:
+	refcount_dec(&((*pipeline)->p_ctrl_ref));
+
+	return ERR_PTR(err);
+}
+
+static struct p4tc_extern_inst *
+p4tc_tmpl_ext_inst_update(struct net *net, struct nlmsghdr *n,
+			  struct nlattr *nla, struct p4tc_pipeline *pipeline,
+			  u32 *ids, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *control_params[P4TC_MSGBATCH_SIZE] = { NULL };
+	struct p4tc_extern_method *methods[P4TC_MAX_EXTERN_METHODS] = { NULL };
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1];
+	struct p4tc_extern_inst_common *inst_common;
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	struct p4tc_pipeline *root_pipeline;
+	int num_params = 0, num_methods = 0;
+	struct p4tc_extern_inst *inst;
+	struct p4tc_tmpl_extern *ext;
+	u32 ext_id = 0, inst_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TMPL_EXT_INST_MAX, nla,
+			       tc_extern_inst_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ext_id = ids[P4TC_TMPL_EXT_IDX];
+
+	root_pipeline = tcf_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	ext = p4tc_tmpl_ext_find_byanyattr(root_pipeline,
+					   tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+					   ext_id, extack);
+	if (IS_ERR(ext))
+		return (struct p4tc_extern_inst *)ext;
+
+	inst_id = ids[P4TC_TMPL_EXT_INST_IDX];
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byid(pipeline, ext->ext_id);
+	if (!pipe_ext) {
+		NL_SET_ERR_MSG(extack, "Unable to find pipeline extern by id");
+		return ERR_PTR(-ENOENT);
+	}
+	inst = p4tc_ext_inst_find_byanyattr(pipe_ext,
+					    tb[P4TC_TMPL_EXT_INST_NAME],
+					    inst_id, extack);
+	if (IS_ERR(inst))
+		return ERR_PTR(-ENOMEM);
+
+	if (tb[P4TC_TMPL_EXT_INST_NUM_ELEMS]) {
+		u32 *num_elems;
+
+		num_elems = nla_data(tb[P4TC_TMPL_EXT_INST_NUM_ELEMS]);
+		inst->max_num_elems = *num_elems;
+	}
+
+	inst_common = inst->inst_common;
+	if (tb[P4TC_TMPL_EXT_INST_METHODS]) {
+		num_methods = p4tc_extern_init_methods(net, &inst_common->methods_idr,
+						       methods,
+						       tb[P4TC_TMPL_EXT_INST_METHODS],
+						       true, extack);
+		if (num_methods < 0)
+			return ERR_PTR(num_methods);
+		inst_common->num_methods = num_methods;
+	}
+
+	if (tb[P4TC_TMPL_EXT_INST_CONTROL_PARAMS]) {
+		num_params = p4tc_extern_init_params_value(net, inst,
+							   tb[P4TC_TMPL_EXT_INST_CONTROL_PARAMS],
+							   control_params, true,
+							   extack);
+		if (num_params < 0) {
+			ret = num_params;
+			goto free_methods;
+		}
+		inst_common->num_control_params = num_params;
+	}
+
+	p4tc_extern_methods_replace_many(&inst_common->methods_idr, methods,
+					 num_methods);
+	p4tc_extern_params_replace_many(&inst_common->control_params_idr,
+					control_params, num_params);
+
+	return inst;
+
+free_methods:
+	p4tc_extern_put_many_methods(&inst_common->methods_idr, methods, false,
+				     num_methods);
+
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_extern_inst *
+p4tc_tmpl_ext_inst_create(struct net *net, struct nlmsghdr *n,
+			  struct nlattr *nla, struct p4tc_pipeline *pipeline,
+			  u32 *ids, struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_param *control_params[P4TC_MSGBATCH_SIZE] = { NULL };
+	struct p4tc_extern_method *methods[P4TC_MAX_EXTERN_METHODS] = { NULL };
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1];
+	struct p4tc_extern_inst_common *inst_common;
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	struct p4tc_pipeline *root_pipeline;
+	int num_params = 0, num_methods = 0;
+	bool allocated_pipe_ext = false;
+	struct p4tc_extern_inst *inst;
+	struct p4tc_tmpl_extern *ext;
+	u32 ext_id = 0, inst_id = 0;
+	char *inst_name = NULL;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TMPL_EXT_INST_MAX, nla,
+			       tc_extern_inst_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ext_id = ids[P4TC_TMPL_EXT_IDX];
+
+	root_pipeline = tcf_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	ext = p4tc_tmpl_ext_find_byanyattr(root_pipeline,
+					   tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+					   ext_id, extack);
+	if (IS_ERR(ext))
+		return (struct p4tc_extern_inst *)ext;
+
+	if (tb[P4TC_TMPL_EXT_INST_NAME]) {
+		inst_name = nla_data(tb[P4TC_TMPL_EXT_INST_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify extern name");
+		return ERR_PTR(-EEXIST);
+	}
+
+	inst_id = ids[P4TC_TMPL_EXT_INST_IDX];
+	if (!inst_id) {
+		NL_SET_ERR_MSG(extack, "Must specify extern instance id");
+		return ERR_PTR(-EINVAL);
+	}
+
+	pipe_ext = p4tc_user_pipeline_ext_find_or_create(pipeline, ext,
+							 &allocated_pipe_ext,
+							 extack);
+	if (IS_ERR(pipe_ext))
+		return (struct p4tc_extern_inst *)pipe_ext;
+
+	if (p4tc_ext_inst_find_byname(pipe_ext, inst_name) ||
+	    p4tc_ext_inst_find_byid(pipe_ext, inst_id)) {
+		NL_SET_ERR_MSG(extack,
+			       "Extern instance with same name or ID already exists");
+		ret = -EEXIST;
+		goto dec_pipe_ext_ref;
+	}
+
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
+	if (!inst) {
+		NL_SET_ERR_MSG(extack, "Failed to allocate ext inst");
+		ret = -ENOMEM;
+		goto dec_pipe_ext_ref;
+	}
+
+	inst_common = kzalloc(sizeof(*inst_common), GFP_KERNEL);
+	if (!inst_common) {
+		ret = -ENOMEM;
+		goto free_extern;
+	}
+
+	if (tb[P4TC_TMPL_EXT_INST_NUM_ELEMS]) {
+		u32 *num_elems;
+
+		num_elems = nla_data(tb[P4TC_TMPL_EXT_INST_NUM_ELEMS]);
+		inst->max_num_elems = *num_elems;
+	} else {
+		inst->max_num_elems = P4TC_DEFAULT_NUM_EXT_INST_ELEMS;
+	}
+	refcount_set(&inst->curr_num_elems, 1);
+
+	idr_init(&inst_common->methods_idr);
+	if (tb[P4TC_TMPL_EXT_INST_METHODS]) {
+		num_methods = p4tc_extern_init_methods(net, &inst_common->methods_idr,
+						       methods,
+						       tb[P4TC_TMPL_EXT_INST_METHODS],
+						       false, extack);
+		if (num_methods < 0) {
+			idr_destroy(&inst_common->methods_idr);
+			ret = num_methods;
+			goto free_extern_common;
+		}
+		inst_common->num_methods = num_methods;
+	}
+
+	idr_init(&inst_common->control_params_idr);
+	idr_init(&inst_common->control_elems_idr);
+	inst->inst_common = inst_common;
+	if (tb[P4TC_TMPL_EXT_INST_CONTROL_PARAMS]) {
+		num_params = p4tc_extern_init_params_value(net, inst,
+							   tb[P4TC_TMPL_EXT_INST_CONTROL_PARAMS],
+							   control_params, false,
+							   extack);
+		if (num_params < 0) {
+			ret = num_params;
+			idr_destroy(&inst_common->control_params_idr);
+			goto free_methods;
+		}
+		inst_common->num_control_params = num_params;
+	}
+
+	inst->ext_inst_id = inst_id;
+	ret = idr_alloc_u32(&pipe_ext->e_inst_idr, inst, &inst->ext_inst_id,
+			    inst->ext_inst_id, GFP_KERNEL);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to allocate ID for extern instance");
+		goto free_control_params;
+	}
+
+	if (allocated_pipe_ext)
+		refcount_inc(&pipe_ext->curr_insts_num);
+
+	inst->ext_id = ext->ext_id;
+	inst->ext_inst_id = inst_id;
+	inst->ops = ext->ops;
+
+	strscpy(inst->common.name, inst_name, EXTERNINSTNAMSIZ);
+
+	inst->common.p_id = pipeline->common.p_id;
+	inst->common.ops = (struct p4tc_template_ops *)&p4tc_tmpl_ext_inst_ops;
+	inst->pipe_ext = pipe_ext;
+	refcount_set(&inst->inst_ref, 1);
+
+	p4tc_extern_methods_replace_many(&inst_common->methods_idr, methods,
+					 num_methods);
+	p4tc_extern_params_replace_many(&inst_common->control_params_idr,
+					control_params, num_params);
+
+	return inst;
+
+free_control_params:
+	p4tc_extern_put_many_params(&inst_common->control_params_idr,
+				    control_params, true, num_params);
+	idr_destroy(&inst_common->control_elems_idr);
+
+free_methods:
+	p4tc_extern_put_many_methods(&inst_common->methods_idr, methods, true,
+				     num_methods);
+	idr_destroy(&inst_common->methods_idr);
+
+free_extern_common:
+	kfree(inst_common);
+
+free_extern:
+	kfree(inst);
+
+dec_pipe_ext_ref:
+	if (!allocated_pipe_ext)
+		refcount_dec(&pipe_ext->ext_ref);
+
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4tc_tmpl_ext_inst_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		      struct p4tc_nl_pname *nl_pname, u32 *ids,
+		      struct netlink_ext_ack *extack)
+{
+	u32 pipeid = ids[P4TC_PID_IDX];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+
+	pipeline = tcf_pipeline_find_byany_unsealed(net, nl_pname->data,
+						    pipeid, extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+		inst = p4tc_tmpl_ext_inst_create(net, n, nla, pipeline, ids,
+						 extack);
+		break;
+	case RTM_UPDATEP4TEMPLATE:
+		inst = p4tc_tmpl_ext_inst_update(net, n, nla, pipeline, ids,
+						 extack);
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR(inst))
+		goto out;
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!ids[P4TC_TMPL_EXT_IDX])
+		ids[P4TC_TMPL_EXT_IDX] = inst->ext_id;
+
+	if (!ids[P4TC_TMPL_EXT_INST_IDX])
+		ids[P4TC_TMPL_EXT_INST_IDX] = inst->ext_inst_id;
+
+out:
+	return (struct p4tc_template_common *)inst;
+}
+
+static struct p4tc_tmpl_extern *
+p4tc_tmpl_ext_create(struct nlmsghdr *n, struct nlattr *nla,
+		     struct p4tc_pipeline *pipeline, u32 *ids,
+		     struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_MAX + 1];
+	struct p4tc_tmpl_extern *ext;
+	char *extern_name = NULL;
+	u32 ext_id = 0;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TMPL_EXT_MAX, nla, tc_extern_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	ext_id = ids[P4TC_TMPL_EXT_IDX];
+	if (!ext_id) {
+		NL_SET_ERR_MSG(extack, "Must specify extern id");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (tb[P4TC_TMPL_EXT_NAME]) {
+		extern_name = nla_data(tb[P4TC_TMPL_EXT_NAME]);
+	} else {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify extern name");
+		return ERR_PTR(-EEXIST);
+	}
+
+	if ((p4tc_tmpl_ext_find_name(pipeline, extern_name)) ||
+	    p4tc_tmpl_ext_find_byid(pipeline, ext_id)) {
+		NL_SET_ERR_MSG(extack,
+			       "Extern with same id or name was already inserted");
+		return ERR_PTR(-EEXIST);
+	}
+
+	ext = kzalloc(sizeof(*ext), GFP_KERNEL);
+	if (!ext) {
+		NL_SET_ERR_MSG(extack, "Failed to allocate ext");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	if (tb[P4TC_TMPL_EXT_NUM_INSTS]) {
+		u16 *num_insts = nla_data(tb[P4TC_TMPL_EXT_NUM_INSTS]);
+
+		ext->max_num_insts = *num_insts;
+	} else {
+		ext->max_num_insts = P4TC_DEFAULT_NUM_EXT_INSTS;
+	}
+
+	ret = idr_alloc_u32(&pipeline->p_ext_idr, ext, &ext_id,
+			    ext_id, GFP_KERNEL);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate ID for extern");
+		goto free_extern;
+	}
+
+	ext->ext_id = ext_id;
+
+	strscpy(ext->common.name, extern_name, EXTERNNAMSIZ);
+
+	refcount_set(&ext->tmpl_ref, 1);
+
+	ext->common.p_id = pipeline->common.p_id;
+	ext->common.ops = (struct p4tc_template_ops *)&p4tc_tmpl_ext_ops;
+
+	/* Extern module is not mandatory */
+	ext->ops = p4tc_extern_ops_get(extern_name);
+
+	return ext;
+
+free_extern:
+	kfree(ext);
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4tc_tmpl_ext_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		 struct p4tc_nl_pname *nl_pname, u32 *ids,
+		 struct netlink_ext_ack *extack)
+{
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_tmpl_extern *ext;
+
+	if (p4tc_tmpl_msg_is_update(n)) {
+		NL_SET_ERR_MSG(extack, "Extern update not supported");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	pipeline = tcf_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	ext = p4tc_tmpl_ext_create(n, nla, pipeline, ids, extack);
+	if (IS_ERR(ext))
+		goto out;
+
+out:
+	return (struct p4tc_template_common *)ext;
+}
+
+static int ext_inst_param_fill_nlmsg(struct sk_buff *skb,
+				     struct idr *params_idr)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_extern_param *param;
+	struct nlattr *nest_count;
+	unsigned long id, tmp;
+	int i = 1;
+
+	idr_for_each_entry_ul(params_idr, param, tmp, id) {
+		nest_count = nla_nest_start(skb, i);
+		if (!nest_count)
+			goto out_nlmsg_trim;
+
+		if (nla_put_string(skb, P4TC_EXT_PARAMS_NAME, param->name))
+			goto out_nlmsg_trim;
+
+		if (nla_put_u32(skb, P4TC_EXT_PARAMS_ID, param->id))
+			goto out_nlmsg_trim;
+
+		if (nla_put_u32(skb, P4TC_EXT_PARAMS_TYPE, param->type->typeid))
+			goto out_nlmsg_trim;
+
+		if (param->value && p4tc_ext_param_value_dump(skb, param))
+			goto out_nlmsg_trim;
+
+		nla_nest_end(skb, nest_count);
+		i++;
+	}
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int ext_method_fill_nlmsg(struct sk_buff *skb,
+				 struct p4tc_extern_method *method)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *parms;
+
+	if (nla_put_string(skb, P4TC_TMPL_EXT_INST_METHOD_NAME,
+			   method->method_name))
+		goto out_nlmsg_trim;
+
+	if (nla_put_u32(skb, P4TC_TMPL_EXT_INST_METHOD_ID, method->method_id))
+		goto out_nlmsg_trim;
+
+	parms = nla_nest_start(skb, P4TC_TMPL_EXT_INST_METHOD_PARAMS);
+	if (!parms)
+		goto out_nlmsg_trim;
+
+	if (ext_inst_param_fill_nlmsg(skb, &method->params_idr) < 0)
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, parms);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int _p4tc_tmpl_ext_inst_fill_nlmsg(struct sk_buff *skb,
+					  struct p4tc_extern_inst *inst)
+{
+	struct p4tc_extern_inst_common *common = inst->inst_common;
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nest, *methods, *parms;
+	struct p4tc_user_pipeline_extern *ext;
+	struct p4tc_extern_method *method;
+	unsigned long method_id, tmp;
+	/* Parser instance id + header field id */
+	u32 ids[2];
+	int i = 1;
+
+	ids[0] = inst->ext_id;
+	ids[1] = inst->ext_inst_id;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(ids), &ids))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	ext = inst->pipe_ext;
+	if (ext->ext_name[0]) {
+		if (nla_put_string(skb, P4TC_TMPL_EXT_INST_EXT_NAME,
+				   ext->ext_name))
+			goto out_nlmsg_trim;
+	}
+
+	if (inst->common.name[0]) {
+		if (nla_put_string(skb, P4TC_TMPL_EXT_INST_NAME,
+				   inst->common.name))
+			goto out_nlmsg_trim;
+	}
+
+	if (nla_put_u32(skb, P4TC_TMPL_EXT_INST_NUM_ELEMS, inst->max_num_elems))
+		goto out_nlmsg_trim;
+
+	methods = nla_nest_start(skb, P4TC_TMPL_EXT_INST_METHODS);
+	if (!methods)
+		goto out_nlmsg_trim;
+
+	idr_for_each_entry_ul(&common->methods_idr, method, tmp, method_id) {
+		struct nlattr *nest_count = nla_nest_start(skb, i);
+
+		if (ext_method_fill_nlmsg(skb, method) <= 0)
+			goto out_nlmsg_trim;
+
+		nla_nest_end(skb, nest_count);
+		i++;
+	}
+	nla_nest_end(skb, methods);
+
+	parms = nla_nest_start(skb, P4TC_TMPL_EXT_INST_CONTROL_PARAMS);
+	if (!parms)
+		goto out_nlmsg_trim;
+
+	if (ext_inst_param_fill_nlmsg(skb, &common->control_params_idr) < 0)
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, parms);
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int _p4tc_tmpl_ext_fill_nlmsg(struct sk_buff *skb,
+				     struct p4tc_tmpl_extern *ext)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct nlattr *nest;
+	/* Parser instance id + header field id */
+	u32 id;
+
+	id = ext->ext_id;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(id), &id))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	if (ext->common.name[0]) {
+		if (nla_put_string(skb, P4TC_TMPL_EXT_NAME, ext->common.name))
+			goto out_nlmsg_trim;
+	}
+
+	if (nla_put_u16(skb, P4TC_TMPL_EXT_NUM_INSTS, ext->max_num_insts))
+		goto out_nlmsg_trim;
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
+static int p4tc_tmpl_ext_inst_fill_nlmsg(struct net *net, struct sk_buff *skb,
+					 struct p4tc_template_common *template,
+					 struct netlink_ext_ack *extack)
+{
+	struct p4tc_extern_inst *inst = to_extern_inst(template);
+
+	if (_p4tc_tmpl_ext_inst_fill_nlmsg(skb, inst) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for extern instance");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4tc_tmpl_ext_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				    struct p4tc_template_common *template,
+				    struct netlink_ext_ack *extack)
+{
+	struct p4tc_tmpl_extern *ext = to_extern(template);
+
+	if (_p4tc_tmpl_ext_fill_nlmsg(skb, ext) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for extern");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4tc_tmpl_ext_flush(struct sk_buff *skb,
+			       struct p4tc_pipeline *pipeline,
+			       struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_tmpl_extern *ext;
+	unsigned long tmp, ext_id;
+	int ret = 0;
+	u32 path[1];
+	int i = 0;
+
+	path[0] = 0;
+
+	if (idr_is_empty(&pipeline->p_ext_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no externs to flush");
+		goto out_nlmsg_trim;
+	}
+
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	idr_for_each_entry_ul(&pipeline->p_ext_idr, ext, tmp, ext_id) {
+		if (_p4tc_tmpl_ext_put(pipeline, ext, false, extack) < 0) {
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
+				       "Unable to flush any externs");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush all externs");
+		}
+	}
+
+	return i;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return 0;
+}
+
+static int p4tc_tmpl_ext_inst_flush(struct sk_buff *skb,
+				    struct p4tc_pipeline *pipeline,
+				    struct p4tc_user_pipeline_extern *pipe_ext,
+				    struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_extern_inst *inst;
+	unsigned long tmp, inst_id;
+	int ret = 0;
+	u32 path[2];
+	int i = 0;
+
+	path[0] = pipe_ext->ext_id;
+	path[1] = 0;
+
+	if (idr_is_empty(&pipe_ext->e_inst_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no externs to flush");
+		goto out_nlmsg_trim;
+	}
+
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	idr_for_each_entry_ul(&pipe_ext->e_inst_idr, inst, tmp, inst_id) {
+		if (_p4tc_tmpl_ext_inst_put(pipeline, pipe_ext, inst, false,
+					    false, extack) < 0) {
+			ret = -EBUSY;
+			continue;
+		}
+		i++;
+	}
+
+	/* We don't release pipe_ext in the loop to avoid use-after-free whilst
+	 * iterating through e_inst_idr. We free it here only if flush
+	 * succeeded, that is, all instances were deleted and thus ext_ref == 1
+	 */
+	if (refcount_read(&pipe_ext->ext_ref) == 1)
+		p4tc_user_pipeline_ext_free(pipe_ext, &pipeline->user_ext_idr);
+
+	nla_put_u32(skb, P4TC_COUNT, i);
+
+	if (ret < 0) {
+		if (i == 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush any externs instance");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush all extern instances");
+		}
+	}
+
+	return i;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return 0;
+}
+
+static int p4tc_tmpl_ext_inst_gd(struct net *net, struct sk_buff *skb,
+				 struct nlmsghdr *n, struct nlattr *nla,
+				 struct p4tc_nl_pname *nl_pname, u32 *ids,
+				 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1] = {NULL};
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	u32 inst_id = ids[P4TC_TMPL_EXT_INST_IDX];
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 ext_id = ids[P4TC_TMPL_EXT_IDX];
+	u32 pipe_id = ids[P4TC_PID_IDX];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_extern_inst *inst;
+	int ret;
+
+	if (n->nlmsg_type == RTM_GETP4TEMPLATE)
+		pipeline = tcf_pipeline_find_byany(net, nl_pname->data,
+						   pipe_id, extack);
+	else
+		pipeline = tcf_pipeline_find_byany_unsealed(net, nl_pname->data,
+							    pipe_id, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TMPL_EXT_MAX, nla,
+				       tc_extern_inst_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byanyattr(pipeline,
+							 tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+							 ext_id, extack);
+	if (IS_ERR(pipe_ext))
+		return PTR_ERR(pipe_ext);
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!ids[P4TC_TMPL_EXT_IDX])
+		ids[P4TC_TMPL_EXT_IDX] = pipe_ext->ext_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && n->nlmsg_flags & NLM_F_ROOT)
+		return p4tc_tmpl_ext_inst_flush(skb, pipeline, pipe_ext,
+						extack);
+
+	inst = p4tc_ext_inst_find_byanyattr(pipe_ext,
+					    tb[P4TC_TMPL_EXT_INST_NAME],
+					    inst_id, extack);
+	if (IS_ERR(inst))
+		return PTR_ERR(inst);
+
+	ret = _p4tc_tmpl_ext_inst_fill_nlmsg(skb, inst);
+	if (ret < 0)
+		return -ENOMEM;
+
+	if (!ids[P4TC_TMPL_EXT_INST_IDX])
+		ids[P4TC_TMPL_EXT_INST_IDX] = inst->ext_inst_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = _p4tc_tmpl_ext_inst_put(pipeline, pipe_ext, inst, false,
+					      true, extack);
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
+static int p4tc_tmpl_ext_gd(struct net *net, struct sk_buff *skb,
+			    struct nlmsghdr *n, struct nlattr *nla,
+			    struct p4tc_nl_pname *nl_pname, u32 *ids,
+			    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_MAX + 1] = {NULL};
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 ext_id = ids[P4TC_TMPL_EXT_IDX];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_tmpl_extern *ext;
+	int ret;
+
+	pipeline = tcf_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TMPL_EXT_MAX, nla,
+				       tc_extern_policy, extack);
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
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && n->nlmsg_flags & NLM_F_ROOT)
+		return p4tc_tmpl_ext_flush(skb, pipeline, extack);
+
+	ext = p4tc_tmpl_ext_find_byanyattr(pipeline, tb[P4TC_TMPL_EXT_NAME],
+					   ext_id, extack);
+	if (IS_ERR(ext))
+		return PTR_ERR(ext);
+
+	ret = _p4tc_tmpl_ext_fill_nlmsg(skb, ext);
+	if (ret < 0)
+		return -ENOMEM;
+
+	if (!ids[P4TC_TMPL_EXT_IDX])
+		ids[P4TC_TMPL_EXT_IDX] = ext->ext_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = _p4tc_tmpl_ext_put(pipeline, ext, false, extack);
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
+static int p4tc_tmpl_ext_dump_1(struct sk_buff *skb,
+				struct p4tc_template_common *common)
+{
+	struct nlattr *param = nla_nest_start(skb, P4TC_PARAMS);
+	struct p4tc_tmpl_extern *ext = to_extern(common);
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 path[2];
+
+	if (!param)
+		goto out_nlmsg_trim;
+
+	if (ext->common.name[0] &&
+	    nla_put_string(skb, P4TC_TMPL_EXT_NAME, ext->common.name))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, param);
+
+	path[0] = ext->ext_id;
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+static int p4tc_tmpl_ext_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			      struct nlattr *nla, char **p_name, u32 *ids,
+			      struct netlink_ext_ack *extack)
+{
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+
+	pipeline = tcf_pipeline_find_byid(net, P4TC_KERNEL_PIPEID);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	return tcf_p4_tmpl_generic_dump(skb, ctx, &pipeline->p_ext_idr,
+					P4TC_TMPL_EXT_IDX, extack);
+}
+
+static int p4tc_tmpl_ext_inst_dump_1(struct sk_buff *skb,
+				     struct p4tc_template_common *common)
+{
+	struct nlattr *param = nla_nest_start(skb, P4TC_PARAMS);
+	struct p4tc_extern_inst *inst = to_extern_inst(common);
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 path[2];
+
+	if (!param)
+		goto out_nlmsg_trim;
+
+	if (inst->common.name[0] &&
+	    nla_put_string(skb, P4TC_TMPL_EXT_NAME, inst->common.name))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, param);
+
+	path[0] = inst->pipe_ext->ext_id;
+	path[1] = inst->ext_inst_id;
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	return 0;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -ENOMEM;
+}
+
+static int p4tc_tmpl_ext_inst_dump(struct sk_buff *skb,
+				   struct p4tc_dump_ctx *ctx,
+				   struct nlattr *nla, char **p_name,
+				   u32 *ids, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TMPL_EXT_INST_MAX + 1] = {NULL};
+	struct p4tc_user_pipeline_extern *pipe_ext;
+	u32 ext_id = ids[P4TC_TMPL_EXT_IDX];
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+	u32 pipeid = ids[P4TC_PID_IDX];
+	int ret;
+
+	pipeline = tcf_pipeline_find_byany_unsealed(net, *p_name,
+						    pipeid, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TMPL_EXT_INST_MAX, nla,
+				       tc_extern_inst_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	pipe_ext = p4tc_user_pipeline_ext_find_byanyattr(pipeline,
+							 tb[P4TC_TMPL_EXT_INST_EXT_NAME],
+							 ext_id, extack);
+	if (IS_ERR(pipe_ext))
+		return PTR_ERR(pipe_ext);
+
+	return tcf_p4_tmpl_generic_dump(skb, ctx, &pipe_ext->e_inst_idr,
+					P4TC_TMPL_EXT_INST_IDX, extack);
+}
+
+const struct p4tc_template_ops p4tc_tmpl_ext_inst_ops = {
+	.cu = p4tc_tmpl_ext_inst_cu,
+	.fill_nlmsg = p4tc_tmpl_ext_inst_fill_nlmsg,
+	.gd = p4tc_tmpl_ext_inst_gd,
+	.put = p4tc_tmpl_ext_inst_put,
+	.dump = p4tc_tmpl_ext_inst_dump,
+	.dump_1 = p4tc_tmpl_ext_inst_dump_1,
+};
+
+const struct p4tc_template_ops p4tc_tmpl_ext_ops = {
+	.cu = p4tc_tmpl_ext_cu,
+	.fill_nlmsg = p4tc_tmpl_ext_fill_nlmsg,
+	.gd = p4tc_tmpl_ext_gd,
+	.put = p4tc_tmpl_ext_put,
+	.dump = p4tc_tmpl_ext_dump,
+	.dump_1 = p4tc_tmpl_ext_dump_1,
+};
-- 
2.34.1


