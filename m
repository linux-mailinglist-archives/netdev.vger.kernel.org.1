Return-Path: <netdev+bounces-23172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B4776B38A
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A381C20DAA
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A0622F15;
	Tue,  1 Aug 2023 11:38:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F29214E1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:47 +0000 (UTC)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B486E6F
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:43 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6bca6c06e56so1479146a34.1
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889922; x=1691494722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4JDCn7UWuIcdvVYkSRYjh02O9s3nsYvN98dRHmbvlk=;
        b=2LTrx0S11XJAps8L13D4nZor+W/EkYMqjMFiPSGJAtuuYBEx59sGpEnzLAJAa3NkKw
         m59le3BegoMN1nDBIP7At3PusRNmfXMLrINscniRS3VzDwi0QaPzXIqb5NZUyxSi0fhQ
         7+4TnnQOL5g6kiiWDI+Zk9TLkdx9Q0B17PTvZvLu+j3i4XQ/DhS4RwmkIU2pvXiFAK6P
         4Dn8SZEyIJ6Z+KDeY4/fJMX1auPht6guOvSZqpS6aB2PgpOAw6vK1XNuycWTyYCiAMBn
         RcagK5RZEHyydKj6rCjCIeCF5OhMmwTK+MCL7Z3WQzx79hr4+mcp25DhW0/4hoWrt86A
         IohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889922; x=1691494722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4JDCn7UWuIcdvVYkSRYjh02O9s3nsYvN98dRHmbvlk=;
        b=Tu0ffGN72heDZkF+ATAhVf4xqLLs6F+HHxS3zTlteoT4CwDaIP6JVUt7QYoDgk1TLC
         L7KXMkMNUx3BsUSGcwlzh3UH+Y9UxtzzwfZ1rfQbmBhRmLHQEHZZv2f/Noi5MBz/Ex17
         ttwIOwqcQS8CbGxQ38ps1dBs6mkxXrEb9YmFV2foycZaiK2cAH5e9zhSKD4OOy55/gz3
         MYIdRb0EveYkmCTMaZrTDbPuPpQAN4R4I8NO8SYB8MHnDSvqUD9rFBuDZIXmYR4igmHt
         wZVvVsf+WpJMo8ubCiYLXGaywjIM1LVW6z7F5hGM+nNCjXe5j//t8trjzMoXIyqFUovw
         geGg==
X-Gm-Message-State: ABy/qLad7a6dqt1JLXmU6EgODCtWK2fLsSrh3PUUR1iqU8UdClAQi3/B
	0uagdvpfCm2pnLrQYqzBdreprMZ2L/YLIeg5YGB9Nw==
X-Google-Smtp-Source: APBJJlHssAVF1j7GuEfxm8nOYcO3kj2ZfNlzXwMe4tptjGF1MwBtmZsRh381Sj6IYCH6d1XlO5KBKw==
X-Received: by 2002:a05:6358:9916:b0:134:211:e2f5 with SMTP id w22-20020a056358991600b001340211e2f5mr2295172rwa.29.1690889921318;
        Tue, 01 Aug 2023 04:38:41 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:40 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 15/23] p4tc: add set of P4TC table kfuncs
Date: Tue,  1 Aug 2023 07:37:59 -0400
Message-Id: <20230801113807.85473-16-jhs@mojatatu.com>
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

We add an initial set of kfuncs to allow interactions from eBPF programs
to the P4TC domain.

- bpf_skb_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in TC. To find the table entry we take in an skb, the
pipeline ID, the table ID, a key and a key size.
We use the skb to get the network namespace structure where all the
pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- bpf_xdp_p4tc_tbl_read: Used to lookup a table entry from a BPF
program installed in XDP. To find the table entry we take in an xdp_md,
the pipeline ID, the table ID, a key and a key size.
We use struct xdp_md to get the network namespace structure where all
the pipelines are stored. After that we use the pipeline ID and the table
ID, to find the table. We then use the key to search for the entry.
We return an entry on success and NULL on failure.

- bpf_skb_p4tc_entry_create: Used to create a table entry from a BPF
program installed in TC. To create the table entry we take an skb, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_xdp_p4tc_entry_create: Used to create a table entry from a BPF
program installed in XDP. To create the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_skb_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
First does a lookup using the passed key and upon a miss will add the entry to
the table.
We return 0 on success and a negative errno on failure

- bpf_xdp_p4tc_entry_create_on_miss: conforms to PNA "add on miss".
First does a lookup using the passed key and upon a miss will add the entry to
the table.
We return 0 on success and a negative errno on failure

- bpf_skb_p4tc_entry_update: Used to update a table entry from a BPF
program installed in TC. To update the table entry we take an skb, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_xdp_p4tc_entry_update: Used to update a table entry from a BPF
program installed in XDP. To update the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and its size, and an action which will
be associated with the new entry.
We return 0 on success and a negative errno on failure

- bpf_skb_p4tc_entry_delete: Used to delete a table entry from a BPF
program installed in TC. To delete the table entry we take an skb, the
pipeline ID, the table ID, a key and a key size.
We return 0 on success and a negative errno on failure

- bpf_xdp_p4tc_entry_delete: Used to delete a table entry from a BPF
program installed in XDP. To delete the table entry we take an xdp_md, the
pipeline ID, the table ID, a key and a key size.
We return 0 on success and a negative errno on failure

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/linux/bitops.h          |   1 +
 include/net/p4tc.h              |  71 +++++-
 net/sched/Kconfig               |   1 +
 net/sched/p4tc/Makefile         |   2 +-
 net/sched/p4tc/p4tc_action.c    |   1 +
 net/sched/p4tc/p4tc_bpf.c       | 351 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_pipeline.c  |  43 ++++
 net/sched/p4tc/p4tc_table.c     |  18 ++
 net/sched/p4tc/p4tc_tbl_entry.c | 384 +++++++++++++++++++++++++++++++-
 net/sched/p4tc/p4tc_tmpl_api.c  |   2 +
 10 files changed, 868 insertions(+), 6 deletions(-)
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
index b3e2b83bc..dbefaa305 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -93,8 +93,26 @@ struct p4tc_pipeline {
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
 
 static inline bool p4tc_tmpl_msg_is_update(struct nlmsghdr *n)
@@ -182,8 +200,14 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 
 #define P4TC_MAX_PARAM_DATA_SIZE 124
 
+struct p4tc_table_entry_act_bpf {
+	u32 act_id;
+	u8 params[P4TC_MAX_PARAM_DATA_SIZE];
+} __packed;
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
+	struct p4tc_table_entry_act_bpf *defact_bpf;
 	/* Will have 2 5 bits blocks containing CRUDX (Create, read, update,
 	 * delete, execute) permissions for control plane and data plane.
 	 * The first 5 bits are for control and the next five are for data plane.
@@ -200,6 +224,7 @@ struct p4tc_table_perm {
 
 struct p4tc_table {
 	struct p4tc_template_common         common;
+	struct list_head                    tbl_cache_node;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
 	struct ida                          tbl_prio_idr;
@@ -280,6 +305,17 @@ extern const struct p4tc_template_ops p4tc_act_ops;
 
 extern const struct rhashtable_params entry_hlt_params;
 
+struct p4tc_table_entry_act_bpf_params {
+	u32 pipeid;
+	u32 tblid;
+};
+
+struct p4tc_table_entry_create_bpf_params {
+	u64 aging_ms;
+	u32 pipeid;
+	u32 tblid;
+};
+
 struct p4tc_table_entry;
 struct p4tc_table_entry_work {
 	struct work_struct   work;
@@ -301,6 +337,7 @@ struct p4tc_table_entry_value {
 	u32                              prio;
 	int                              num_acts;
 	struct tc_action                 **acts;
+	struct p4tc_table_entry_act_bpf  *act_bpf;
 	refcount_t                       entries_ref;
 	u32                              permissions;
 	u32                              value_offset;
@@ -328,6 +365,13 @@ struct p4tc_table_entry {
 	/* fallthrough: key data + value */
 };
 
+struct p4tc_entry_key_bpf {
+	void *key;
+	u32 key_sz;
+	void *mask;
+	u32 mask_sz;
+};
+
 #define P4TC_KEYSZ_BYTES(bits) (round_up(BITS_TO_BYTES(bits), 8))
 
 #define ENTRY_KEY_OFFSET (offsetof(struct p4tc_table_entry_key, fa_key))
@@ -362,6 +406,29 @@ struct p4tc_table_entry *
 p4tc_table_entry_lookup_direct(struct p4tc_table *table,
 			       struct p4tc_table_entry_key *key);
 
+struct p4tc_table_entry_act_bpf *
+tcf_table_entry_create_act_bpf(struct tc_action *action,
+			       struct netlink_ext_ack *extack);
+int register_p4tc_tbl_bpf(void);
+int tcf_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+			       struct p4tc_table *table,
+			       struct p4tc_entry_key_bpf *key,
+			       struct p4tc_table_entry_act_bpf *act_bpf,
+			       u64 aging_ms);
+int tcf_table_entry_create_on_miss(struct p4tc_pipeline *pipeline,
+				   struct p4tc_table *table,
+				   struct p4tc_table_entry_key *key,
+				   struct p4tc_table_entry_act_bpf *act_bpf,
+				   u64 aging_ms);
+int tcf_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+			       struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key,
+			       struct p4tc_table_entry_act_bpf *act_bpf,
+			       u64 aging_ms);
+
+int tcf_table_entry_del_bpf(struct p4tc_pipeline *pipeline,
+			    struct p4tc_table *table,
+			    struct p4tc_table_entry_key *key);
 struct p4tc_parser {
 	char parser_name[PARSERNAMSIZ];
 	struct idr hdrfield_idr;
@@ -474,6 +541,7 @@ static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
 {
 	if (defact) {
 		p4tc_action_destroy(defact->default_acts);
+		kfree(defact->defact_bpf);
 		kfree(defact);
 	}
 }
@@ -483,6 +551,7 @@ tcf_table_defacts_acts_copy(struct p4tc_table_defact *defact_copy,
 			    struct p4tc_table_defact *defact_orig)
 {
 	defact_copy->default_acts = defact_orig->default_acts;
+	defact_copy->defact_bpf = defact_orig->defact_bpf;
 }
 
 void
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
index 9d5f57ccf..7fe471808 100644
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
index 000000000..c7c77e5ed
--- /dev/null
+++ b/net/sched/p4tc/p4tc_bpf.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2022-2023, Mojatatu Networks
+ * Copyright (c) 2022-2023, Intel Corporation.
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
+BTF_ID(struct, p4tc_table_entry_act_bpf)
+BTF_ID(struct, p4tc_table_entry_create_bpf_params)
+
+static struct p4tc_table_entry_act_bpf *
+__bpf_p4tc_tbl_read(struct net *caller_net,
+		    struct p4tc_table_entry_act_bpf_params *params,
+		    void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_table_entry_value *value;
+	const u32 pipeid = params->pipeid;
+	const u32 tblid = params->tblid;
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
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in vmlinux BTF");
+__bpf_kfunc struct p4tc_table_entry_act_bpf *
+bpf_skb_p4tc_tbl_read(struct __sk_buff *skb_ctx,
+		      struct p4tc_table_entry_act_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *caller_net;
+
+	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+__bpf_kfunc struct p4tc_table_entry_act_bpf *
+bpf_xdp_p4tc_tbl_read(struct xdp_md *xdp_ctx,
+		      struct p4tc_table_entry_act_bpf_params *params,
+		      void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *caller_net;
+
+	caller_net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_tbl_read(caller_net, params, key, key__sz);
+}
+
+static int
+__bpf_p4tc_entry_create(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *bpf_key_mask, u32 bpf_key_mask__sz,
+			struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	const u32 bpf_key_sz = bpf_key_mask__sz / 2;
+	struct p4tc_entry_key_bpf key = {0};
+	const u32 bpf_mask_sz = bpf_key_sz;
+	const u32 pipeid = params->pipeid;
+	const u32 tblid = params->tblid;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	key.key = bpf_key_mask;
+	key.key_sz = bpf_key_sz;
+
+	key.mask = bpf_key_mask + bpf_key_sz;
+	key.mask_sz = bpf_mask_sz;
+
+	pipeline = tcf_pipeline_find_byid(net, pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, pipeid, tblid);
+	if (!table)
+		return -ENOENT;
+
+	return tcf_table_entry_create_bpf(pipeline, table, &key, act_bpf,
+					  params->aging_ms);
+}
+
+__bpf_kfunc int
+bpf_skb_p4tc_entry_create(struct __sk_buff *skb_ctx,
+			  struct p4tc_table_entry_create_bpf_params *params,
+			  void *bpf_key_mask, u32 bpf_key_mask__sz,
+			  struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create(net, params, bpf_key_mask,
+				       bpf_key_mask__sz, act_bpf);
+}
+
+__bpf_kfunc int
+bpf_xdp_p4tc_entry_create(struct xdp_md *xdp_ctx,
+			  struct p4tc_table_entry_create_bpf_params *params,
+			  void *bpf_key_mask, u32 bpf_key_mask__sz,
+			  struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, bpf_key_mask,
+				       bpf_key_mask__sz, act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_create_on_miss(struct net *net,
+				struct p4tc_table_entry_create_bpf_params *params,
+				void *key, const u32 key__sz,
+				struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_table_entry *entry;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	pipeline = tcf_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	entry = p4tc_table_entry_lookup_direct(table, entry_key);
+	/* Key already exists, so don't create it */
+	if (entry)
+		return -EEXIST;
+
+	return tcf_table_entry_create_on_miss(pipeline, table, entry_key,
+					      act_bpf, params->aging_ms);
+}
+
+__bpf_kfunc int
+bpf_skb_p4tc_entry_create_on_miss(struct __sk_buff *skb_ctx,
+				  struct p4tc_table_entry_create_bpf_params *params,
+				  void *key, const u32 key__sz,
+				  struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_create_on_miss(net, params, key, key__sz,
+					       act_bpf);
+}
+
+__bpf_kfunc int
+bpf_xdp_p4tc_entry_create_on_miss(struct xdp_md *xdp_ctx,
+				  struct p4tc_table_entry_create_bpf_params *params,
+				  void *bpf_key_mask, u32 bpf_key_mask__sz,
+				  struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_create(net, params, bpf_key_mask,
+				       bpf_key_mask__sz, act_bpf);
+}
+
+__bpf_kfunc int
+__bpf_p4tc_entry_update(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz,
+			struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	pipeline = tcf_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	return tcf_table_entry_update_bpf(pipeline, table, entry_key,
+					  act_bpf, params->aging_ms);
+}
+
+__bpf_kfunc int
+bpf_skb_p4tc_entry_update(struct __sk_buff *skb_ctx,
+			  struct p4tc_table_entry_create_bpf_params *params,
+			  void *key, const u32 key__sz,
+			  struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_update(net, params, key, key__sz, act_bpf);
+}
+
+__bpf_kfunc int
+bpf_xdp_p4tc_entry_update(struct xdp_md *xdp_ctx,
+			  struct p4tc_table_entry_create_bpf_params *params,
+			  void *key, const u32 key__sz,
+			  struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_update(net, params, key, key__sz, act_bpf);
+}
+
+static int
+__bpf_p4tc_entry_delete(struct net *net,
+			struct p4tc_table_entry_create_bpf_params *params,
+			void *key, const u32 key__sz)
+{
+	struct p4tc_table_entry_key *entry_key = (struct p4tc_table_entry_key *)key;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+
+	pipeline = tcf_pipeline_find_byid(net, params->pipeid);
+	if (!pipeline)
+		return -ENOENT;
+
+	table = p4tc_tbl_cache_lookup(net, params->pipeid, params->tblid);
+	if (!table)
+		return -ENOENT;
+
+	entry_key->keysz = (key__sz - ENTRY_KEY_OFFSET) << 3;
+
+	return tcf_table_entry_del_bpf(pipeline, table, entry_key);
+}
+
+__bpf_kfunc int
+bpf_skb_p4tc_entry_delete(struct __sk_buff *skb_ctx,
+			  struct p4tc_table_entry_create_bpf_params *params,
+			  void *key, const u32 key__sz)
+{
+	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
+	struct net *net;
+
+	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
+
+	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
+}
+
+__bpf_kfunc int
+bpf_xdp_p4tc_entry_delete(struct xdp_md *xdp_ctx,
+			  struct p4tc_table_entry_create_bpf_params *params,
+			  void *key, const u32 key__sz)
+{
+	struct xdp_buff *ctx = (struct xdp_buff *)xdp_ctx;
+	struct net *net;
+
+	net = dev_net(ctx->rxq->dev);
+
+	return __bpf_p4tc_entry_delete(net, params, key, key__sz);
+}
+
+__diag_pop();
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_skb)
+BTF_ID_FLAGS(func, bpf_skb_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_skb_p4tc_entry_create);
+BTF_ID_FLAGS(func, bpf_skb_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, bpf_skb_p4tc_entry_update);
+BTF_ID_FLAGS(func, bpf_skb_p4tc_entry_delete);
+BTF_SET8_END(p4tc_kfunc_check_tbl_set_skb)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_skb = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_skb,
+};
+
+BTF_SET8_START(p4tc_kfunc_check_tbl_set_xdp)
+BTF_ID_FLAGS(func, bpf_xdp_p4tc_tbl_read, KF_RET_NULL);
+BTF_ID_FLAGS(func, bpf_xdp_p4tc_entry_create);
+BTF_ID_FLAGS(func, bpf_xdp_p4tc_entry_create_on_miss);
+BTF_ID_FLAGS(func, bpf_xdp_p4tc_entry_update);
+BTF_ID_FLAGS(func, bpf_xdp_p4tc_entry_delete);
+BTF_SET8_END(p4tc_kfunc_check_tbl_set_xdp)
+
+static const struct btf_kfunc_id_set p4tc_kfunc_tbl_set_xdp = {
+	.owner = THIS_MODULE,
+	.set = &p4tc_kfunc_check_tbl_set_xdp,
+};
+
+int register_p4tc_tbl_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT,
+					&p4tc_kfunc_tbl_set_skb);
+	if (ret < 0)
+		return ret;
+
+	/* There is no unregister_btf_kfunc_id_set function */
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					 &p4tc_kfunc_tbl_set_xdp);
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 7db19ae51..3ab59a37a 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -37,6 +37,44 @@ static __net_init int pipeline_init_net(struct net *net)
 
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
 
@@ -44,6 +82,11 @@ static int __tcf_pipeline_put(struct p4tc_pipeline *pipeline,
 			      struct p4tc_template_common *template,
 			      struct netlink_ext_ack *extack);
 
+void p4tc_tbl_cache_remove(struct net *net, struct p4tc_table *table)
+{
+	list_del(&table->tbl_cache_node);
+}
+
 static void __net_exit pipeline_exit_net(struct net *net)
 {
 	struct p4tc_pipeline_net *pipe_net;
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index eb61d36a1..1d2ada740 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -351,6 +351,7 @@ static inline int _tcf_table_put(struct net *net, struct nlattr **tb,
 
 	rhltable_free_and_destroy(&table->tbl_entries,
 				  tcf_table_entry_destroy_hash, table);
+	p4tc_tbl_cache_remove(net, table);
 
 	idr_destroy(&table->tbl_masks_idr);
 	ida_destroy(&table->tbl_prio_idr);
@@ -494,6 +495,7 @@ static int __tcf_table_init_default_act(struct net *net, struct nlattr **tb,
 	}
 
 	if (tb[P4TC_TABLE_DEFAULT_ACTION]) {
+		struct p4tc_table_entry_act_bpf *act_bpf;
 		struct tc_action **default_acts;
 
 		if (!p4tc_ctrl_update_ok(curr_permissions)) {
@@ -522,6 +524,15 @@ static int __tcf_table_init_default_act(struct net *net, struct nlattr **tb,
 			ret = -EINVAL;
 			goto default_act_free;
 		}
+		act_bpf = tcf_table_entry_create_act_bpf(default_acts[0],
+							 extack);
+		if (IS_ERR(act_bpf)) {
+			p4tc_action_destroy(default_acts);
+			kfree(default_acts);
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		(*default_act)->defact_bpf = act_bpf;
 		(*default_act)->default_acts = default_acts;
 	}
 
@@ -1118,6 +1129,10 @@ static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
 		goto defaultacts_destroy;
 	}
 
+	ret = p4tc_tbl_cache_insert(net, pipeline->common.p_id, table);
+	if (ret < 0)
+		goto entries_hashtable_destroy;
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
@@ -1125,6 +1140,9 @@ static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
 
 	return table;
 
+entries_hashtable_destroy:
+	rhltable_destroy(&table->tbl_entries);
+
 defaultacts_destroy:
 	p4tc_table_defact_destroy(table->tbl_default_missact);
 	p4tc_table_defact_destroy(table->tbl_default_hitact);
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
index fcd4f53e0..590a31b2b 100644
--- a/net/sched/p4tc/p4tc_tbl_entry.c
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -674,8 +674,10 @@ static void __tcf_table_entry_put(struct p4tc_table_entry *entry)
 
 	value = p4tc_table_entry_value(entry);
 
-	if (value->acts)
+	if (value->acts) {
 		p4tc_action_destroy(value->acts);
+		kfree(value->act_bpf);
+	}
 
 	kfree(value->entry_work);
 	tm = rcu_dereference(value->tm);
@@ -1004,6 +1006,48 @@ static int ___tcf_table_entry_del(struct p4tc_pipeline *pipeline,
 	return 0;
 }
 
+/* Internal function which will be called by the data path */
+static int __tcf_table_entry_del(struct p4tc_pipeline *pipeline,
+				 struct p4tc_table *table,
+				 struct p4tc_table_entry_key *key,
+				 struct p4tc_table_entry_mask *mask, u32 prio)
+{
+	struct p4tc_table_entry *entry;
+	int ret;
+
+	tcf_table_entry_build_key(table, key, mask);
+
+	entry = p4tc_entry_lookup(table, key, prio);
+	if (!entry)
+		return -ENOENT;
+
+	ret = ___tcf_table_entry_del(pipeline, table, entry, false);
+
+	return ret;
+}
+
+int tcf_table_entry_del_bpf(struct p4tc_pipeline *pipeline,
+			    struct p4tc_table *table,
+			    struct p4tc_table_entry_key *key)
+{
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	const u32 keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	const u32 keysz_bits = table->tbl_keysz;
+	struct p4tc_table_entry entry = {0};
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		return -EINVAL;
+
+	if (keysz_bytes != P4TC_KEYSZ_BYTES(key->keysz))
+		return -EINVAL;
+
+	entry.key.keysz = keysz_bits;
+
+	return __tcf_table_entry_del(pipeline, table, key, mask, 0);
+}
+
 static int tcf_table_entry_gd(struct net *net, struct sk_buff *skb, bool del,
 			      struct nlattr *arg, u32 *ids,
 			      struct p4tc_nl_pname *nl_pname,
@@ -1259,6 +1303,49 @@ static int tcf_table_entry_flush(struct net *net, struct sk_buff *skb,
 	return ret;
 }
 
+static int
+tcf_table_tc_act_from_bpf_act(struct tcf_p4act *p4act,
+			      struct p4tc_table_entry_value *value,
+			      struct p4tc_table_entry_act_bpf *act_bpf)
+{
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	u8 *params_cursor;
+	int err;
+
+	/* Skip act_id */
+	params_cursor = (u8 *)act_bpf + sizeof(act_bpf->act_id);
+	idr_for_each_entry_ul(&p4act->params->params_idr, param, tmp, param_id) {
+		const struct p4tc_type *type = param->type;
+		const u32 type_bytesz = BITS_TO_BYTES(type->container_bitsz);
+
+		memcpy(param->value, params_cursor, type_bytesz);
+		params_cursor += type_bytesz;
+	}
+
+	value->act_bpf = kzalloc(sizeof(*act_bpf), GFP_ATOMIC);
+	if (unlikely(!value->act_bpf))
+		return -ENOMEM;
+
+	value->acts = kcalloc(TCA_ACT_MAX_PRIO, sizeof(struct tc_action *),
+			      GFP_ATOMIC);
+	if (unlikely(!value->acts)) {
+		err = -ENOMEM;
+		goto free_act_bpf;
+	}
+
+	value->num_acts = 1;
+	value->acts[0] = (struct tc_action *)p4act;
+
+	*value->act_bpf = *act_bpf;
+
+	return 0;
+
+free_act_bpf:
+	kfree(value->act_bpf);
+	return err;
+}
+
 static enum hrtimer_restart entry_timer_handle(struct hrtimer *timer)
 {
 	struct p4tc_table_entry_value *value =
@@ -1393,6 +1480,119 @@ static int __tcf_table_entry_create(struct p4tc_pipeline *pipeline,
 	return ret;
 }
 
+struct p4tc_table_entry_create_state {
+	struct p4tc_act *act;
+	struct tcf_p4act *p4_act;
+	struct p4tc_table_entry *entry;
+	u64 aging_ms;
+	u16 permissions;
+};
+
+static int
+tcf_table_entry_init_bpf(struct p4tc_pipeline *pipeline,
+			 struct p4tc_table *table, u32 entry_key_sz,
+			 struct p4tc_table_entry_act_bpf *act_bpf,
+			 struct p4tc_table_entry_create_state *state)
+{
+	const u32 keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+	struct p4tc_table_entry_value *entry_value;
+	const u32 keysz_bits = table->tbl_keysz;
+	struct p4tc_table_entry *entry;
+	u32 act_id = act_bpf->act_id;
+	struct tcf_p4act *p4_act;
+	struct p4tc_act *act;
+	u32 entrysz;
+	int err;
+
+	err = -EINVAL;
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		goto out;
+
+	if (keysz_bytes != P4TC_KEYSZ_BYTES(entry_key_sz))
+		goto out;
+
+	if (refcount_read(&table->tbl_entries_ref) > table->tbl_max_entries)
+		goto out;
+
+	act = tcf_action_find_byid(pipeline, act_id);
+	if (!act) {
+		err = -ENOENT;
+		goto out;
+	}
+
+	if (!refcount_inc_not_zero(&act->a_ref)) {
+		err = -EBUSY;
+		goto out;
+	}
+
+	entrysz = sizeof(*entry) + keysz_bytes +
+		  sizeof(struct p4tc_table_entry_value);
+
+	entry = kzalloc(entrysz, GFP_ATOMIC);
+	if (unlikely(!entry)) {
+		err = -ENOMEM;
+		goto act_ref_dec;
+	}
+	entry->key.keysz = keysz_bits;
+
+	entry_value = p4tc_table_entry_value(entry);
+	err = tcf_table_entry_alloc_new_prio(table);
+	if (err < 0)
+		goto free_entry;
+	entry_value->prio = err;
+	entry_value->permissions = state->permissions;
+	entry_value->aging_ms = state->aging_ms;
+
+	p4_act = tcf_p4_get_next_prealloc_act(act);
+	if (!p4_act) {
+		err = -ENOENT;
+		goto idr_rm;
+	}
+
+	err = tcf_table_tc_act_from_bpf_act(p4_act, entry_value, act_bpf);
+	if (err < 0)
+		goto free_prealloc;
+
+	state->act = act;
+	state->p4_act = p4_act;
+	state->entry = entry;
+
+	return 0;
+
+free_prealloc:
+	tcf_p4_put_prealloc_act(act, p4_act);
+
+idr_rm:
+	tcf_table_entry_free_prio(table, entry_value->prio);
+
+free_entry:
+	kfree(entry);
+
+act_ref_dec:
+	WARN_ON_ONCE(!refcount_dec_not_one(&act->a_ref));
+out:
+	return err;
+}
+
+static inline void
+tcf_table_entry_create_state_put(struct p4tc_table *table,
+				 struct p4tc_table_entry_create_state *state)
+{
+	struct p4tc_table_entry_value *value;
+
+	tcf_p4_put_prealloc_act(state->act, state->p4_act);
+
+	value = p4tc_table_entry_value(state->entry);
+	tcf_table_entry_free_prio(table, value->prio);
+
+	kfree(value->act_bpf);
+	kfree(value->acts);
+
+	kfree(state->entry);
+
+	WARN_ON_ONCE(!refcount_dec_not_one(&state->act->a_ref));
+}
+
 /* Invoked from both control and data path  */
 static int __tcf_table_entry_update(struct p4tc_pipeline *pipeline,
 				    struct p4tc_table *table,
@@ -1531,6 +1731,119 @@ static int __tcf_table_entry_update(struct p4tc_pipeline *pipeline,
 	(P4TC_CTRL_PERM_R | P4TC_CTRL_PERM_U | P4TC_CTRL_PERM_D | \
 	 P4TC_DATA_PERM_R | P4TC_DATA_PERM_X)
 
+int tcf_table_entry_create_on_miss(struct p4tc_pipeline *pipeline,
+				   struct p4tc_table *table,
+				   struct p4tc_table_entry_key *key,
+				   struct p4tc_table_entry_act_bpf *act_bpf,
+				   u64 aging_ms)
+{
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_create_state state = {0};
+	int err;
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		return -EINVAL;
+
+	state.aging_ms = aging_ms;
+	state.permissions = P4TC_DEFAULT_TENTRY_PERMISSIONS;
+	err = tcf_table_entry_init_bpf(pipeline, table, key->keysz,
+				       act_bpf, &state);
+	if (err < 0)
+		return err;
+
+	tcf_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
+
+	err = __tcf_table_entry_create(pipeline, table, state.entry, mask,
+				       P4TC_ENTITY_KERNEL, false);
+	if (err < 0)
+		goto put_state;
+
+	tcf_p4_set_init_flags(state.p4_act);
+
+	return 0;
+
+put_state:
+	tcf_table_entry_create_state_put(table, &state);
+
+	return err;
+}
+
+int tcf_table_entry_create_bpf(struct p4tc_pipeline *pipeline,
+			       struct p4tc_table *table,
+			       struct p4tc_entry_key_bpf *key,
+			       struct p4tc_table_entry_act_bpf *act_bpf,
+			       u64 aging_ms)
+{
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_create_state state = {0};
+	int err;
+
+	state.aging_ms = aging_ms;
+	state.permissions = P4TC_DEFAULT_TENTRY_PERMISSIONS;
+	err = tcf_table_entry_init_bpf(pipeline, table, key->key_sz,
+				       act_bpf, &state);
+	if (err < 0)
+		return err;
+
+	tcf_table_entry_assign_key(table, &state.entry->key, mask, key->key,
+				   key->mask);
+
+	err = __tcf_table_entry_create(pipeline, table, state.entry, mask,
+				       P4TC_ENTITY_KERNEL, false);
+	if (err < 0)
+		goto put_state;
+
+	tcf_p4_set_init_flags(state.p4_act);
+
+	return 0;
+
+put_state:
+	tcf_table_entry_create_state_put(table, &state);
+
+	return err;
+}
+
+int tcf_table_entry_update_bpf(struct p4tc_pipeline *pipeline,
+			       struct p4tc_table *table,
+			       struct p4tc_table_entry_key *key,
+			       struct p4tc_table_entry_act_bpf *act_bpf,
+			       u64 aging_ms)
+{
+	struct p4tc_table_entry_create_state state = {0};
+	struct p4tc_table_entry_value *value;
+	int err;
+
+	state.aging_ms = aging_ms;
+	state.permissions = P4TC_PERMISSIONS_UNINIT;
+	err = tcf_table_entry_init_bpf(pipeline, table, key->keysz, act_bpf,
+				       &state);
+	if (err < 0)
+		return err;
+
+	tcf_table_entry_assign_key_exact(&state.entry->key, key->fa_key);
+
+	value = p4tc_table_entry_value(state.entry);
+	value->is_static = false;
+	err = __tcf_table_entry_update(pipeline, table, state.entry, NULL,
+				       P4TC_ENTITY_KERNEL, false);
+
+	if (err < 0)
+		goto put_state;
+
+	tcf_p4_set_init_flags(state.p4_act);
+
+	return 0;
+
+put_state:
+	tcf_table_entry_create_state_put(table, &state);
+
+	return err;
+}
+
 static bool tcf_table_check_entry_acts(struct p4tc_table *table,
 				       struct tc_action *entry_acts[],
 				       int num_entry_acts)
@@ -1554,6 +1867,56 @@ static bool tcf_table_check_entry_acts(struct p4tc_table *table,
 	return false;
 }
 
+struct p4tc_table_entry_act_bpf *
+tcf_table_entry_create_act_bpf(struct tc_action *action,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_act_param *params[P4TC_MSGBATCH_SIZE];
+	struct p4tc_table_entry_act_bpf *act_bpf;
+	struct tcf_p4act_params *act_params;
+	struct p4tc_act_param *param;
+	unsigned long param_id, tmp;
+	size_t tot_params_sz = 0;
+	struct tcf_p4act *p4act;
+	int num_params = 0;
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
 static struct nla_policy p4tc_table_attrs_policy[P4TC_ENTRY_TBL_ATTRS_MAX + 1] = {
 	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_HIT] = { .type = NLA_NESTED },
 	[P4TC_ENTRY_TBL_ATTRS_DEFAULT_MISS] = { .type = NLA_NESTED },
@@ -1733,6 +2096,8 @@ __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 	}
 
 	if (tb[P4TC_ENTRY_ACT]) {
+		struct p4tc_table_entry_act_bpf *act_bpf;
+
 		value->acts = kcalloc(TCA_ACT_MAX_PRIO,
 				      sizeof(struct tc_action *), GFP_KERNEL);
 		if (unlikely(!value->acts)) {
@@ -1757,6 +2122,14 @@ __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
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
 
 	if (tb[P4TC_ENTRY_AGING]) {
@@ -1765,14 +2138,14 @@ __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 		ret = -EINVAL;
 		if (!aging_ms) {
 			NL_SET_ERR_MSG(extack, "Aging time can't be zero");
-			goto free_acts;
+			goto free_act_bpf;
 		}
 
 		if (aging_ms > P4TC_MAX_T_AGING) {
 			NL_SET_ERR_MSG_FMT(extack,
 					   "Aging time can't be larger then %llu\n",
 					   aging_ms);
-			goto free_acts;
+			goto free_act_bpf;
 		}
 
 		value->aging_ms = aging_ms;
@@ -1793,11 +2166,14 @@ __tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
 		if (replace && ret == -EAGAIN)
 			NL_SET_ERR_MSG(extack, "Entry was being updated in parallel");
 
-		goto free_acts;
+		goto free_act_bpf;
 	}
 
 	return entry;
 
+free_act_bpf:
+	kfree(value->act_bpf);
+
 free_acts:
 	p4tc_action_destroy(value->acts);
 
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 0e48a7b37..5cff66dcd 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -594,6 +594,8 @@ static int __init p4tc_template_init(void)
 			op->init();
 	}
 
+	register_p4tc_tbl_bpf();
+
 	return 0;
 }
 
-- 
2.34.1


