Return-Path: <netdev+bounces-14532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6C0742440
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5DA1C2098A
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C1E1640D;
	Thu, 29 Jun 2023 10:46:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EA016408
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:46:10 +0000 (UTC)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1E51BFE
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:08 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-47169fc1a40so178298e0c.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035567; x=1690627567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hitOgdwPcbAX5DOATV4/9U48QXEwoVPWjPpSLoiwyZI=;
        b=plN70QX12EHYfZR4V9e6JRpcSlFicDUuIX27iye9y+o3H/L3yioKyaxxITDXS9CLw9
         IGoztQKwERf4RKqqT2NTXfgjqaLe4d7xAiRVlzpm3oTyHQCk7CTD0vAlWutluTn0yOXu
         QPDb3+roULnp2Vfl2ikJ67bM1YEjJf1yN342NmnNDfVj94MyGZmYd0pBTlLl1GJxLP6p
         68AnQB5UrBnk1kf+eWb8nc+m0QmjeAJrCkn1ZHX3yk22XKLE4iD+AwgfhcHtxue7FtV+
         7fYcvrBGfjXYvcOax2+vY/XzQ/oUCHGA78GXAgX+whTfqFZnDIbGgRTuOSSFNnGO4JfV
         sb5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035567; x=1690627567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hitOgdwPcbAX5DOATV4/9U48QXEwoVPWjPpSLoiwyZI=;
        b=LvBSzs24LnyHrsWcyeOazGG99p4MBGy9E4T0tOTK/9XBDJrK+AhSaX2aV+c1UA7vF4
         Q1WJiEZ0MEJ1WUx0ZAqw4NlPc0cXSwQNmaLl3ERQTL8EXH+A6TYJ+g0ZHgFzlSsZbjA5
         Tcfpk2eVT8qEktDZefpcXZmLE8/f8cXfY0SBhPhDib10rpKYsdhLBYrh31PHVcxAW3hi
         dZ/r0YI8XYTmVTOulqPnKAR2OlCCq1Wq9q5A0mkVwcOZMeCkHocNo7ShTtPlGcz0QIzX
         pCaTw0QOnmzQeCTLVeb1RINm+tl5gZqbWDw9lmOTdPvObTDLjpFcHP9jDupDVNCr/NQV
         G2iw==
X-Gm-Message-State: AC+VfDwOD7pxzPzpdSspp83D7jDXzRTR69asI2Q9Iy+4ZOyAhICn23pO
	wmdLtU1i/MTkGpXBULvDtfd6OvyGhcevBb51Ve0=
X-Google-Smtp-Source: ACHHUZ7M2e91ZG1NhmNjLlbDw5K2qvJEd0o4YyVMXyI7E7XSTl9o8qfWIVVGlJTn0bfVUXn45uWk9Q==
X-Received: by 2002:a67:e9c6:0:b0:443:68c0:44ad with SMTP id q6-20020a67e9c6000000b0044368c044admr4766252vso.25.1688035566495;
        Thu, 29 Jun 2023 03:46:06 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:46:05 -0700 (PDT)
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
Subject: [PATCH RFC v3 net-next 13/21] p4tc: add set of P4TC table lookup kfuncs
Date: Thu, 29 Jun 2023 06:45:30 -0400
Message-Id: <20230629104538.40863-14-jhs@mojatatu.com>
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

We add an initial set of kfuncs to allow interactions from eBPF programs
to the P4TC domain.

- bpf_skb_p4tc_tbl_lookup: Used to lookup a table entry from a BPF
program installed in TC. To find the table entry we take in an skb, the
pipeline ID, the table ID, a key and a key size.
We use the skb to get the network namespace structure where all the
pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- bpf_xdp_p4tc_tbl_lookup: Used to lookup a table entry from a BPF
program installed in XDP. To find the table entry we take in an skb, the
pipeline ID, the table ID, a key and a key size.
We use struct xdp_md to get the network namespace structure where all
the pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

To load the eBPF program that uses the bpf_skb_p4tc_tbl_lookup kfunc into
TC, we issue the following command:

tc filter add dev $P0 ingress protocol any prio 1 p4 pname redirect_srcip \
     action bpf obj $PROGNAME.o section p4prog/tc

To load the eBPF program that uses the bpf_xdp_p4tc_tbl_lookup into XDP,
we first need to load it into XDP using, for example, the ip command:

ip link set $P0 xdp obj $PROGNAME.o section p4prog/xdp verbose

Then we pin it:

bpftool prog pin id $ID pin /tmp/

After that we create the P4 filter and reference the XDP program:

tc filter add dev $P0 ingress protocol any prio 1 p4 pname redirect_srcip \
     action bpf obj $PROGNAME.o section p4prog/tc

To load the eBPF program that uses the bpf_xdp_p4tc_tbl_lookup into XDP,
we first need to load it into XDP using, for example, the ip command:

ip link set $P0 xdp obj $PROGNAME.o section p4prog/xdp verbose

Then we pin it:

bpftool prog pin id $ID pin /tmp/

After that we create the P4 filter and reference the XDP program:

$TC filter add dev $P0 ingress protocol ip prio 1 p4 pname redirect_srcip \
     prog xdp pinned /tmp/xdp_p4prog prog_cookie 22

Note that we also specify a "prog_cookie", which is used to verify
whether the eBPF program has executed or not before we reach the P4
classifier. The eBPF program sets this cookie by using the kfunc
bpf_p4tc_set_cookie.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/bitops.h          |   1 +
 include/net/p4tc.h              |  54 ++++++++++-
 net/sched/Kconfig               |   1 +
 net/sched/p4tc/Makefile         |   2 +-
 net/sched/p4tc/p4tc_action.c    |   1 +
 net/sched/p4tc/p4tc_bpf.c       | 115 ++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c  |  46 +++++++++
 net/sched/p4tc/p4tc_table.c     |  19 ++++
 net/sched/p4tc/p4tc_tbl_entry.c | 164 +++++++++++++++++++++++++++++++-
 net/sched/p4tc/p4tc_tmpl_api.c  |   2 +
 10 files changed, 402 insertions(+), 3 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_bpf.c

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 2ba557e06..290c2399a 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -19,6 +19,7 @@
 #define BITS_TO_LONGS(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(long))
 #define BITS_TO_U64(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u64))
 #define BITS_TO_U32(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u32))
+#define BITS_TO_U16(nr)		__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(u16))
 #define BITS_TO_BYTES(nr)	__KERNEL_DIV_ROUND_UP(nr, BITS_PER_TYPE(char))
 
 extern unsigned int __sw_hweight8(unsigned int w);
diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 2b2e80f98..544a2cf8a 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -32,6 +32,12 @@
 
 #define P4TC_HDRFIELD_IS_VALIDITY_BIT 0x1
 
+struct p4tc_percpu_scratchpad {
+	u32 prog_cookie;
+};
+
+DECLARE_PER_CPU(struct p4tc_percpu_scratchpad, p4tc_percpu_scratchpad);
+
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
 	struct rhashtable_iter *iter;
@@ -91,8 +97,26 @@ struct p4tc_pipeline {
 	refcount_t                  p_hdrs_used;
 };
 
+#define P4TC_PIPELINE_MAX_ARRAY 32
+
+struct p4tc_table;
+
+struct p4tc_tbl_cache_key {
+	u32 pipeid;
+	u32 tblid;
+};
+
+extern const struct rhashtable_params tbl_cache_ht_params;
+
+int p4tc_tbl_cache_insert(struct net *net, u32 pipeid, struct p4tc_table *table);
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table);
+struct p4tc_table *p4tc_tbl_cache_lookup(struct net *net, u32 pipeid, u32 tblid);
+
+#define P4TC_TBLS_CACHE_SIZE 32
+
 struct p4tc_pipeline_net {
-	struct idr pipeline_idr;
+	struct list_head  tbls_cache[P4TC_TBLS_CACHE_SIZE];
+	struct idr        pipeline_idr;
 };
 
 int tcf_p4_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
@@ -139,8 +163,20 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 
 #define P4TC_PERMISSIONS_UNINIT (1 << P4TC_PERM_MAX_BIT)
 
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
+struct p4tc_table_entry_act_bpf {
+	u32 act_id;
+	u8 params[P4TC_MAX_PARAM_DATA_SIZE];
+} __packed;
+
+struct p4tc_parser_buffer_act_bpf {
+	u16 hdrs[BITS_TO_U16(HEADER_MAX_LEN)];
+};
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
+	struct p4tc_table_entry_act_bpf *defact_bpf;
 	/* Will have 2 5 bits blocks containing CRUDX (Create, read, update,
 	 * delete, execute) permissions for control plane and data plane.
 	 * The first 5 bits are for control and the next five are for data plane.
@@ -157,6 +193,7 @@ struct p4tc_table_perm {
 
 struct p4tc_table {
 	struct p4tc_template_common         common;
+	struct list_head                    tbl_cache_node;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
 	struct ida                          tbl_prio_idr;
@@ -239,6 +276,11 @@ extern const struct p4tc_template_ops p4tc_act_ops;
 
 extern const struct rhashtable_params entry_hlt_params;
 
+struct p4tc_table_entry_act_bpf_params {
+	u32 pipeid;
+	u32 tblid;
+};
+
 struct p4tc_table_entry;
 struct p4tc_table_entry_work {
 	struct work_struct   work;
@@ -258,6 +300,7 @@ struct p4tc_table_entry_value {
 	u32                              prio;
 	int                              num_acts;
 	struct tc_action                 **acts;
+	struct p4tc_table_entry_act_bpf  *act_bpf;
 	refcount_t                       entries_ref;
 	u32                              permissions;
 	struct p4tc_table_entry_tm __rcu *tm;
@@ -290,10 +333,19 @@ static inline void *p4tc_table_entry_value(struct p4tc_table_entry *entry)
 extern const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1];
 extern const struct nla_policy p4tc_policy[P4TC_MAX + 1];
 
+struct p4tc_table_entry *
+p4tc_table_entry_lookup_direct(struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key);
+
+
 int __tcf_table_entry_del(struct p4tc_pipeline *pipeline,
 			  struct p4tc_table *table,
 			  struct p4tc_table_entry_key *key,
 			  struct p4tc_table_entry_mask *mask, u32 prio);
+struct p4tc_table_entry_act_bpf *
+tcf_table_entry_create_act_bpf(struct tc_action *action,
+			       struct netlink_ext_ack *extack);
+int register_p4tc_tbl_bpf(void);
 
 struct p4tc_parser {
 	char parser_name[PARSERNAMSIZ];
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index ea57a4c7b..d071f9075 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -678,6 +678,7 @@ config NET_EMATCH_IPT
 
 config NET_P4_TC
 	bool "P4 TC support"
+	depends on DEBUG_INFO_BTF
 	select NET_CLS_ACT
 	help
 	  Say Y here if you want to use P4 features on top of TC.
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index c9e2555a8..161a515ad 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -2,4 +2,4 @@
 
 obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
 	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o \
-	p4tc_tbl_entry.o p4tc_runtime_api.o
+	p4tc_tbl_entry.o p4tc_runtime_api.o p4tc_bpf.o
diff --git a/net/sched/p4tc/p4tc_action.c b/net/sched/p4tc/p4tc_action.c
index 676e1b0d9..abbf8cb83 100644
--- a/net/sched/p4tc/p4tc_action.c
+++ b/net/sched/p4tc/p4tc_action.c
@@ -28,6 +28,7 @@
 #include <net/p4tc.h>
 #include <net/sch_generic.h>
 #include <net/sock.h>
+
 #include <net/tc_act/p4tc.h>
 
 static LIST_HEAD(dynact_list);
diff --git a/net/sched/p4tc/p4tc_bpf.c b/net/sched/p4tc/p4tc_bpf.c
new file mode 100644
index 000000000..adfdc678f
--- /dev/null
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022, Mojatatu Networks
+ * Copyright (c) 2022, Intel Corporation.
+ * Authors:     Jamal Hadi Salim <jhs@mojatatu.com>
+ *              Victor Nogueira <victor@mojatatu.com>
+ *              Pedro Tammela <pctammela@mojatatu.com>
+ */
+
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include <linux/filter.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+#include <linux/btf_ids.h>
+#include <linux/net_namespace.h>
+#include <net/p4tc.h>
+#include <linux/netdevice.h>
+#include <net/sock.h>
+#include <linux/filter.h>
+
+BTF_ID_LIST(btf_p4tc_ids)
+BTF_ID(struct, p4tc_table_entry_act_bpf)
+BTF_ID(struct, p4tc_table_entry_act_bpf_params)
+
+#define ENTRY_KEY_OFFSET (offsetof(struct p4tc_table_entry_key, fa_key))
+
+struct p4tc_table_entry_act_bpf *
+__bpf_p4tc_tbl_lookup(struct net *caller_net,
+		      struct p4tc_table_entry_act_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	const u32 pipeid = params->pipeid;
+	const u32 tblid = params->tblid;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry *entry;
+	struct p4tc_table *table;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	table = p4tc_tbl_cache_lookup(caller_net, pipeid, tblid);
+	if (!table)
+		return NULL;
+
+	entry = p4tc_table_entry_lookup_direct(table, entry_key);
+	if (!entry) {
+		struct p4tc_table_defact *defact;
+
+		defact = rcu_dereference(table->tbl_default_missact);
+		return defact ? defact->defact_bpf : NULL;
+	}
+
+	value = p4tc_table_entry_value(entry);
+
+	return value->act_bpf;
+}
+
+struct p4tc_table_entry_act_bpf *
+bpf_skb_p4tc_tbl_lookup(struct __sk_buff *skb_ctx,
+			struct p4tc_table_entry_act_bpf_params *params,
+			void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *caller_net;
+
+	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_tbl_lookup(caller_net, params, key, key__sz);
+}
+
+struct p4tc_table_entry_act_bpf *
+bpf_xdp_p4tc_tbl_lookup(struct xdp_md *xdp_ctx,
+			struct p4tc_table_entry_act_bpf_params *params,
+			void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *caller_net;
+
+	caller_net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_tbl_lookup(caller_net, params, key, key__sz);
+}
+
+void bpf_p4tc_set_cookie(u32 cookie)
+{
+	struct p4tc_percpu_scratchpad *pad;
+
+	pad = this_cpu_ptr(&p4tc_percpu_scratchpad);
+	pad->prog_cookie = cookie;
+}
+
+BTF_SET8_START(p4tc_tbl_kfunc_set)
+BTF_ID_FLAGS(func, bpf_skb_p4tc_tbl_lookup, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_xdp_p4tc_tbl_lookup, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_p4tc_set_cookie, 0);
+BTF_SET8_END(p4tc_tbl_kfunc_set)
+
+static const struct btf_kfunc_id_set p4tc_table_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &p4tc_tbl_kfunc_set,
+};
+
+int register_p4tc_tbl_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					&p4tc_table_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					       &p4tc_table_kfunc_set);
+
+	return ret;
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 6c687ee54..b36035840 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -37,9 +37,52 @@ static __net_init int pipeline_init_net(struct net *net)
 
 	idr_init(&pipe_net->pipeline_idr);
 
+	for (int i = 0; i < P4TC_TBLS_CACHE_SIZE; i++)
+		INIT_LIST_HEAD(&pipe_net->tbls_cache[i]);
+
+	return 0;
+}
+
+static inline size_t p4tc_tbl_cache_hash(u32 pipeid, u32 tblid)
+{
+	return (pipeid + tblid) % P4TC_TBLS_CACHE_SIZE;
+}
+
+struct p4tc_table *p4tc_tbl_cache_lookup(struct net *net, u32 pipeid, u32 tblid)
+{
+	size_t hash = p4tc_tbl_cache_hash(pipeid, tblid);
+	struct p4tc_pipeline_net *pipe_net;
+	struct p4tc_table *pos, *tmp;
+	struct net_generic *ng;
+
+	/* RCU read lock is already being held */
+	ng = rcu_dereference(net->gen);
+	pipe_net = ng->ptr[pipeline_net_id];
+
+	list_for_each_entry_safe(pos, tmp, &pipe_net->tbls_cache[hash],
+				 tbl_cache_node) {
+		if (pos->common.p_id == pipeid && pos->tbl_id == tblid)
+			return pos;
+	}
+
+	return NULL;
+}
+
+int p4tc_tbl_cache_insert(struct net *net, u32 pipeid, struct p4tc_table *table)
+{
+	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
+	size_t hash = p4tc_tbl_cache_hash(pipeid, table->tbl_id);
+
+	list_add_tail(&table->tbl_cache_node, &pipe_net->tbls_cache[hash]);
+
 	return 0;
 }
 
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table)
+{
+	list_del(&table->tbl_cache_node);
+}
+
 static int tcf_pipeline_put(struct net *net,
 			    struct p4tc_template_common *template,
 			    bool unconditional_purgeline,
@@ -618,6 +661,9 @@ static void tcf_pipeline_init(void)
 	__tcf_pipeline_init();
 }
 
+DEFINE_PER_CPU(struct p4tc_percpu_scratchpad, p4tc_percpu_scratchpad);
+EXPORT_PER_CPU_SYMBOL_GPL(p4tc_percpu_scratchpad);
+
 const struct p4tc_template_ops p4tc_pipeline_ops = {
 	.init = tcf_pipeline_init,
 	.cu = tcf_pipeline_cu,
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index 3ef76a84e..dfc93278b 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -244,6 +244,7 @@ static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
 {
 	if (defact) {
 		p4tc_action_destroy(defact->default_acts);
+		kfree(defact->defact_bpf);
 		kfree(defact);
 	}
 }
@@ -351,6 +352,7 @@ static inline int _tcf_table_put(struct net *net, struct nlattr **tb,
 
 	rhltable_free_and_destroy(&table->tbl_entries,
 				  tcf_table_entry_destroy_hash, table);
+	p4tc_tbl_cache_remove(net, table);
 
 	idr_destroy(&table->tbl_masks_idr);
 	ida_destroy(&table->tbl_prio_idr);
@@ -483,6 +485,7 @@ static int tcf_table_init_default_act(struct net *net, struct nlattr **tb,
 	}
 
 	if (tb[P4TC_TABLE_DEFAULT_ACTION]) {
+		struct p4tc_table_entry_act_bpf *act_bpf;
 		struct tc_action **default_acts;
 
 		if (!p4tc_ctrl_update_ok(curr_permissions)) {
@@ -511,6 +514,15 @@ static int tcf_table_init_default_act(struct net *net, struct nlattr **tb,
 			ret = -EINVAL;
 			goto default_act_free;
 		}
+		act_bpf = tcf_table_entry_create_act_bpf(default_acts[0],
+							 extack);
+		if (IS_ERR(act_bpf)) {
+			tcf_action_destroy(default_acts, TCA_ACT_UNBIND);
+			kfree(default_acts);
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		(*default_act)->defact_bpf = act_bpf;
 		(*default_act)->default_acts = default_acts;
 	}
 
@@ -972,12 +984,19 @@ static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
 		goto defaultacts_destroy;
 	}
 
+	ret = p4tc_tbl_cache_insert(net, pipeline->common.p_id, table);
+	if (ret < 0)
+		goto entries_hashtable_destroy;
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
 
 	return table;
 
+entries_hashtable_destroy:
+	rhltable_destroy(&table->tbl_entries);
+
 defaultacts_destroy:
 	p4tc_table_defact_destroy(table->tbl_default_missact);
 	p4tc_table_defact_destroy(table->tbl_default_hitact);
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index 999167a10..f8acff389 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -94,6 +94,103 @@ p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key,
 	return NULL;
 }
 
+static struct p4tc_table_entry *
+__p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry *entry = NULL;
+	u32 smallest_prio = U32_MAX;
+	struct rhlist_head *tmp, *bucket_list;
+	struct p4tc_table_entry *entry_curr;
+
+	bucket_list =
+		rhltable_lookup(&table->tbl_entries, key, entry_hlt_params);
+	if (!bucket_list)
+		return NULL;
+
+	rhl_for_each_entry_rcu(entry_curr, tmp, bucket_list, ht_node) {
+		struct p4tc_table_entry_value *value =
+			p4tc_table_entry_value(entry_curr);
+		if (value->prio <= smallest_prio) {
+			smallest_prio = value->prio;
+			entry = entry_curr;
+		}
+	}
+
+	return entry;
+}
+
+static struct p4tc_table_entry *
+__p4tc_entry_lookup_fast(struct p4tc_table *table, struct p4tc_table_entry_key *key)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry *entry_curr;
+	struct rhlist_head *bucket_list;
+
+	bucket_list =
+		rhltable_lookup(&table->tbl_entries, key, entry_hlt_params);
+	if (!bucket_list)
+		return NULL;
+
+	rht_entry(entry_curr, bucket_list, ht_node);
+
+	return entry_curr;
+}
+
+static void mask_key(const struct p4tc_table_entry_mask *mask, u8 *masked_key,
+		     u8 *skb_key)
+{
+	int i;
+
+	for (i = 0; i < BITS_TO_BYTES(mask->sz); i++)
+		masked_key[i] = skb_key[i] & mask->fa_value[i];
+}
+
+struct p4tc_table_entry *
+p4tc_table_entry_lookup_direct(struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key)
+{
+	struct p4tc_table_entry *entry = NULL;
+	u32 smallest_prio = U32_MAX;
+	const struct p4tc_table_entry_mask **masks_array;
+	int i;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT)
+		return __p4tc_entry_lookup_fast(table, key);
+
+	masks_array =
+		(const struct p4tc_table_entry_mask **)rcu_dereference(table->tbl_masks_array);
+	for (i = 0; i < table->tbl_curr_num_masks; i++) {
+		u8 __mkey[sizeof(*key) + BITS_TO_BYTES(P4TC_MAX_KEYSZ)];
+		const struct p4tc_table_entry_mask *mask = masks_array[i];
+		struct p4tc_table_entry_key *mkey = (void *)&__mkey;
+		struct p4tc_table_entry *entry_curr = NULL;
+
+		mkey->keysz = key->keysz;
+		mkey->maskid = mask->mask_id;
+		mask_key(mask, mkey->fa_key, key->fa_key);
+
+		if (table->tbl_type == P4TC_TABLE_TYPE_LPM) {
+			entry_curr = __p4tc_entry_lookup_fast(table, mkey);
+			if (entry_curr)
+				return entry_curr;
+		} else {
+			entry_curr = __p4tc_entry_lookup(table, mkey);
+
+			if (entry_curr) {
+				struct p4tc_table_entry_value *value =
+					p4tc_table_entry_value(entry_curr);
+				if (value->prio <= smallest_prio) {
+					smallest_prio = value->prio;
+					entry = entry_curr;
+				}
+			}
+		}
+	}
+
+	return entry;
+}
+
 #define tcf_table_entry_mask_find_byid(table, id) \
 	(idr_find(&(table)->tbl_masks_idr, id))
 
@@ -498,6 +595,8 @@ static void tcf_table_entry_put(struct p4tc_table_entry *entry)
 		struct p4tc_pipeline *pipeline = entry_work->pipeline;
 		struct net *net;
 
+		kfree(value->act_bpf);
+
 		if (entry_work->defer_deletion) {
 			net = get_net(pipeline->net);
 			refcount_inc(&entry_work->pipeline->p_entry_deferal_ref);
@@ -1379,6 +1478,8 @@ static struct p4tc_table_entry *__tcf_table_entry_cu(struct net *net, u32 flags,
 	}
 
 	if (tb[P4TC_ENTRY_ACT]) {
+		struct p4tc_table_entry_act_bpf *act_bpf;
+
 		value->acts = kcalloc(TCA_ACT_MAX_PRIO,
 				      sizeof(struct tc_action *), GFP_KERNEL);
 		if (!value->acts) {
@@ -1404,6 +1505,14 @@ static struct p4tc_table_entry *__tcf_table_entry_cu(struct net *net, u32 flags,
 				       "Action is not allowed as entry action");
 			goto free_acts;
 		}
+
+		act_bpf = tcf_table_entry_create_act_bpf(value->acts[0],
+							 extack);
+		if (IS_ERR(act_bpf)) {
+			ret = PTR_ERR(act_bpf);
+			goto free_acts;
+		}
+		value->act_bpf = act_bpf;
 	}
 
 	rcu_read_lock();
@@ -1415,12 +1524,15 @@ static struct p4tc_table_entry *__tcf_table_entry_cu(struct net *net, u32 flags,
 					       whodunnit, true);
 	if (ret < 0) {
 		rcu_read_unlock();
-		goto free_acts;
+		goto free_act_bpf;
 	}
 	rcu_read_unlock();
 
 	return entry;
 
+free_act_bpf:
+	kfree(value->act_bpf);
+
 free_acts:
 	p4tc_action_destroy(value->acts);
 
@@ -1434,6 +1546,56 @@ static struct p4tc_table_entry *__tcf_table_entry_cu(struct net *net, u32 flags,
 	return ERR_PTR(ret);
 }
 
+struct p4tc_table_entry_act_bpf *
+tcf_table_entry_create_act_bpf(struct tc_action *action,
+			       struct netlink_ext_ack *extack)
+{
+	size_t tot_params_sz = 0;
+	int num_params = 0;
+	struct p4tc_act_param *params[P4TC_MSGBATCH_SIZE];
+	struct p4tc_table_entry_act_bpf *act_bpf;
+	struct tcf_p4act_params *act_params;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	struct tcf_p4act *p4act;
+	u8 *params_cursor;
+	int i;
+
+	p4act = to_p4act(action);
+
+	act_params = rcu_dereference(p4act->params);
+
+	idr_for_each_entry_ul(&act_params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+
+		if (tot_params_sz > P4TC_MAX_PARAM_DATA_SIZE) {
+			NL_SET_ERR_MSG(extack, "Maximum parameter byte size reached");
+			return ERR_PTR(-EINVAL);
+		}
+
+		tot_params_sz += BITS_TO_BYTES(type->container_bitsz);
+		params[num_params] = param;
+		num_params++;
+	}
+
+	act_bpf = kzalloc(sizeof(*act_bpf), GFP_KERNEL);
+	if (!act_bpf)
+		return ERR_PTR(-ENOMEM);
+
+	act_bpf->act_id = p4act->act_id;
+	params_cursor = (u8 *)act_bpf + sizeof(act_bpf->act_id);
+	for (i = 0; i < num_params; i++) {
+		const struct p4tc_act_param *param = params[i];
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		memcpy(params_cursor, param->value, type_bytesz);
+		params_cursor += type_bytesz;
+	}
+
+	return act_bpf;
+}
+
 static int tcf_table_entry_cu(struct sk_buff *skb, struct net *net, u32 flags,
 			      struct nlattr *arg, u32 *ids,
 			      struct p4tc_nl_pname *nl_pname,
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index ddc7a3ea8..71d7b2a78 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -582,6 +582,8 @@ static int __init p4tc_template_init(void)
 			op->init();
 	}
 
+	register_p4tc_tbl_bpf();
+
 	return 0;
 }
 
-- 
2.34.1


