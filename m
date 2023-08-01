Return-Path: <netdev+bounces-23171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0210976B387
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DC4281992
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 11:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A922F0B;
	Tue,  1 Aug 2023 11:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8896C214E1
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 11:38:45 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00251B0
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:38:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76ad842d12fso455721485a.3
        for <netdev@vger.kernel.org>; Tue, 01 Aug 2023 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1690889919; x=1691494719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUhwj5SAA2khYdSYqxU9JWj3iPHgaaMCXz4R6Z9XYQw=;
        b=mHWdRCFsskzbz0CyK1hRlyzvg57Kc/b4Vnh/7OQmAK2dYQ288LRvXkPjkqJUImSAB8
         O0bLO3T3A27ClCkjh0Yd4X/BuhAcYN0B9oQpjBU4r4qjGeautYGmQxCtxJbn3AAfa26W
         y6oF84csZCvlloYwRP5ZY3nI9kGzURDiUAKjyAxdAK9bfzAsDu3R6G5gtLO9OcGIEtz8
         3EngLcEWy/lvfYPPSPAr64R8WNNDUzNHCIYKHysmwyjBrQ/Dj+OTiRYrHZCUQCASc+Cq
         dGmGPlLf/mNVSWkSlqPHraifsOf/uUBrSF3oLustUQ/XCKPp5rUs1UtcUhQIvKhTqXYO
         aETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690889919; x=1691494719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUhwj5SAA2khYdSYqxU9JWj3iPHgaaMCXz4R6Z9XYQw=;
        b=FmwOSoTOOH/p+g884diCA14Qi3SBb+xQUTBCo329mE/O3ogklua8YlAUb97PbRn/2s
         0pBarIm+pIhOpBXITslQuR6nPpz6HuDEUuGAQAgzaLN17nZ58Kp+aJFzCPpr0tReA+Un
         62zcqC2uRap7TCmqgYnGMAfHxB8bDNbevBWc/TYd1+hLsl9ErcXIjpMbQW6xaNSzqjq0
         6uGdrDxg0Dxyea1uifVAs5ozlgj52sK8J1LvGnf+xlpCgfroxlFnBETWDVcbvbRfH5ls
         EiyW8fwAAZeWIskOZeLWyXUxms8yROgYU1V/FelXtegvfg0N/Z5rnxxpHJ3jfRhd6uBB
         HrKg==
X-Gm-Message-State: ABy/qLY2VJP+Jyc1FWQ+SF4FQBnNbevWZX1MwCyNFhrMvGsVOiFcXCfF
	p3a8j36g81c1AGADxndni44BKqjVvKpu+ggCVCOE0g==
X-Google-Smtp-Source: APBJJlEymI+T7ydJWtLzs0FaO4l5FmWXIJ6/kX65KHxbe5cAO1OU61JbKwBZbONnmHysplcYRNjnYA==
X-Received: by 2002:a0c:df89:0:b0:635:eff8:2b4c with SMTP id w9-20020a0cdf89000000b00635eff82b4cmr13407430qvl.31.1690889918444;
        Tue, 01 Aug 2023 04:38:38 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id j1-20020a0cf501000000b0063d26033b74sm4643738qvm.39.2023.08.01.04.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 04:38:37 -0700 (PDT)
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
Subject: [PATCH RFC v5 net-next 13/23] p4tc: add table create, update, delete, get, flush and dump
Date: Tue,  1 Aug 2023 07:37:57 -0400
Message-Id: <20230801113807.85473-14-jhs@mojatatu.com>
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

This commit introduces code to create and maintain P4 tables defined in
a P4 program.

As with all other P4TC objects, tables' lifetimes conform to CRUD operations
and are maintained via templates.
It's important to note that write operations, such as create, update and
delete can only be made if the pipeline is not sealed.

Per the P4 specification, tables prefix their name with the control block
(although this could be overridden by P4 annotations).

As an example, if one were to create a table named table1 in a
pipeline named myprog1, on control block "mycontrol", one would use
the following command:

tc p4template create table/myprog1/mycontrol/table1 tblid 1 \
   keysz 32 nummasks 8 tentries 8192

Above says that we are creating a table (table1) attached to pipeline
myprog1 on control block mycontrol. Table1's key size is 32 bits wide
and it can have up to 8 associted masks and 8192 entries. The table id
for table1 is 1. The table id is typically provided by the compiler.

Parameters such as nummasks (number of masks this table may have) and
tentries (maximum number of entries this table may have) may also be
omitted in which case 8 masks and 256 entries will be assumed.

If one were to retrieve the table named table1 (before or after the
pipeline is sealed) one would use the following command:

tc p4template get table/myprog1/mycontrol/table1

If one were to dump all the tables from a pipeline named myprog1, one would
use the following command:

tc p4template get table/myprog1

If one were to update table1 (before the pipeline is sealed) one would use
the following command:

tc p4template update table/myprog1/mycontrol/table1 ....

If one were to delete table1 (before the pipeline is sealed) one would use
the following command:

tc p4template del table/myprog1/mycontrol/table1

If one were to flush all the tables from a pipeline named myprog1, control
block "mycontrol" one would use the following command:

tc p4template del table/myprog1/mycontrol/

___Table Permissions___

Tables can have permissions which apply to all the entries in the specified
table. Permissions are defined for both what the control plane (user space)
is allowed to do as well as datapath.

The permissions field is a 16bit value which will hold CRUDX (create,
read, update, delete and execute) permissions for control and data path.
Bits 9-5 will have the CRUDX values for control and bits 4-0 will have
CRUDX values for data path. By default each table has the following
permissions:

CRUD--R--X

Which means the control plane can perform CRUD operations whereas the data
path can only Read and execute on the entries.
The user can override these permissions when creating the table or when
updating.

For example, the following command will create a table which will not allow
the datapath to create, update or delete entries but give full CRUD
permissions for the control plane.

$TC p4template create table/aP4proggie/cb/tname tblid 1 keysz 64 type lpm
permissions 0x349 ...

Recall that these permissions come in the form of CRUDXCRUDX, where the
first CRUDX block is for control and the last is for data path.

So 0x349 is equivalent to CR-D--R--X

If we were to do a get with the following command:

$TC p4template get table/aP4proggie/cb/tname

The output would be the following:

pipeline name aP4proggie pipeline id 22
    table id 1
    table name cb/tname
    key_sz 64
    max entries 256
    masks 8
    table entries 0
    permissions CR-D--R--X

Note, the permissions concept is more powerful than classical const
definition currently taken by P4 which makes everything in a table
read-only.

___Initial Table Entries___

Templating can create initial table entries. For example:

tc p4template update table/myprog/cb/tname \
  entry srcAddr 10.10.10.10/24 dstAddr 1.1.1.0/24 prio 17

In this command we are "updating" table cb/tname with a new entry. This
entry has as its key srcAddr concatenated with dstAddr
(both IPv4 addresses) and prio 17.

If one was to read back the entry by issuing the following command:

tc p4template get table/myprog/cb/tname

They would get:

pipeline id 22
    table id 1
    table name cb/tname
    key_sz 64
    max entries 256
    masks 8
    table entries 1
    permissions CRUD--R--X
    entry:

        entry priority 17[permissions-RUD--R--X]
        entry key
            srcAddr id:1 size:32b type:ipv4 exact fieldval  10.10.10.10/32
            dstAddr id:2 size:32b type:ipv4 exact fieldval  1.1.1.0/24

___Table Actions List___

P4 tables allow certain actions but not other to be part of match entry on
a table or as default actions when there is a miss.

We also allow flags for each of the actions in this list that specify if
the action can be added only as a table entry (tableonly), or only as a
default action (defaultonly). If no flags are specified, it is assumed
that the action can be used in both contexts.

In P4TC we extend the concept of default action - which in P4 is mapped to
"a default miss action". Our extension is to add a "hit action" which is
executed every time there is a hit.

The default miss action will be executed whenever a table lookup doesn't
match any of the entries.

Both default hit and default miss are optional.

An example of specifying a default miss action is as follows:

tc p4template update table/myprog/cb/mytable \
    default_miss_action permissions 0x109 action drop

The above will drop packets if the entry is not found in mytable.
Note the above makes the default action a const. Meaning the control
plane can neither replace it nor delete it.

tc p4template update table/myprog/mytable \
  default_hit_action permissions 0x30F action ok

Whereas the above allows a default hit action to accept the packet.
The permission 0x30F (binary 1100001111) means we have only Create and Read
permissions in the control plane and Read, Update, Delete and eXecute
permissions in the data plane. This means, for example, that
now we can only delete the default hit action from the data plane.
Note: above permissions dont seem very practical and merely shown to
exemplify permission usage.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h             |  121 +++
 include/net/p4tc_types.h       |    2 +-
 include/uapi/linux/p4tc.h      |  104 +++
 net/sched/p4tc/Makefile        |    2 +-
 net/sched/p4tc/p4tc_pipeline.c |   30 +-
 net/sched/p4tc/p4tc_table.c    | 1497 ++++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c |    2 +
 7 files changed, 1747 insertions(+), 11 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_table.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 6d6cfd2ac..e45d864b9 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -15,10 +15,19 @@
 #define P4TC_DEFAULT_NUM_TABLES P4TC_MINTABLES_COUNT
 #define P4TC_DEFAULT_MAX_RULES 1
 #define P4TC_PATH_MAX 3
+#define P4TC_MAX_TENTRIES (2 << 23)
+#define P4TC_DEFAULT_TENTRIES 256
+#define P4TC_MAX_TMASKS 1024
+#define P4TC_DEFAULT_TMASKS 8
+#define P4TC_MAX_T_AGING 864000000
+#define P4TC_DEFAULT_T_AGING 259200000
+
+#define P4TC_MAX_PERMISSION (GENMASK(P4TC_PERM_MAX_BIT, 0))
 
 #define P4TC_KERNEL_PIPEID 0
 
 #define P4TC_PID_IDX 0
+#define P4TC_TBLID_IDX 1
 #define P4TC_AID_IDX 1
 #define P4TC_PARSEID_IDX 1
 #define P4TC_HDRFIELDID_IDX 2
@@ -72,6 +81,7 @@ extern const struct p4tc_template_ops p4tc_pipeline_ops;
 struct p4tc_pipeline {
 	struct p4tc_template_common common;
 	struct idr                  p_act_idr;
+	struct idr                  p_tbl_idr;
 	struct rcu_head             rcu;
 	struct net                  *net;
 	struct p4tc_parser          *parser;
@@ -121,6 +131,11 @@ struct p4tc_act *tcf_p4_find_act(struct net *net,
 void
 tcf_p4_put_prealloc_act(struct p4tc_act *act, struct tcf_p4act *p4_act);
 
+static inline bool pipeline_sealed(struct p4tc_pipeline *pipeline)
+{
+	return pipeline->p_state == P4TC_STATE_READY;
+}
+
 static inline int p4tc_action_destroy(struct tc_action **acts)
 {
 	struct tc_action *acts_non_prealloc[TCA_ACT_MAX_PRIO] = {NULL};
@@ -156,6 +171,55 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 	return ret;
 }
 
+#define P4TC_CONTROL_PERMISSIONS (GENMASK(9, 5))
+#define P4TC_DATA_PERMISSIONS (GENMASK(4, 0))
+
+#define P4TC_TABLE_PERMISSIONS                                   \
+	((GENMASK(P4TC_CTRL_PERM_C_BIT, P4TC_CTRL_PERM_D_BIT)) | \
+	 P4TC_DATA_PERM_R | P4TC_DATA_PERM_X)
+
+#define P4TC_PERMISSIONS_UNINIT (1 << P4TC_PERM_MAX_BIT)
+
+struct p4tc_table_defact {
+	struct tc_action **default_acts;
+	/* Will have 2 5 bits blocks containing CRUDX (Create, read, update,
+	 * delete, execute) permissions for control plane and data plane.
+	 * The first 5 bits are for control and the next five are for data plane.
+	 * |crudxcrudx| if we were to denote it as UNIX permission flags.
+	 */
+	__u16 permissions;
+	struct rcu_head  rcu;
+};
+
+struct p4tc_table_perm {
+	__u16           permissions;
+	struct rcu_head rcu;
+};
+
+struct p4tc_table {
+	struct p4tc_template_common         common;
+	struct list_head                    tbl_acts_list;
+	struct idr                          tbl_masks_idr;
+	struct idr                          tbl_prio_idr;
+	struct rhltable                     tbl_entries;
+	struct p4tc_table_defact __rcu      *tbl_default_hitact;
+	struct p4tc_table_defact __rcu      *tbl_default_missact;
+	struct p4tc_table_perm __rcu        *tbl_permissions;
+	struct p4tc_table_entry_mask __rcu  **tbl_masks_array;
+	unsigned long __rcu                 *tbl_free_masks_bitmap;
+	u64                                 tbl_aging;
+	spinlock_t                          tbl_masks_idr_lock;
+	u32                                 tbl_keysz;
+	u32                                 tbl_id;
+	u32                                 tbl_max_entries;
+	u32                                 tbl_max_masks;
+	u32                                 tbl_curr_num_masks;
+	refcount_t                          tbl_ctrl_ref;
+	u16                                 tbl_type;
+};
+
+extern const struct p4tc_template_ops p4tc_table_ops;
+
 struct p4tc_ipv4_param_value {
 	u32 value;
 	u32 mask;
@@ -201,6 +265,12 @@ struct p4tc_act {
 	refcount_t                  a_ref;
 };
 
+struct p4tc_table_act {
+	struct list_head node;
+	struct tc_action_ops *ops;
+	u8     flags;
+};
+
 extern const struct p4tc_template_ops p4tc_act_ops;
 
 struct p4tc_parser {
@@ -280,6 +350,56 @@ struct p4tc_act_param *tcf_param_find_byany(struct p4tc_act *act,
 					    const u32 param_id,
 					    struct netlink_ext_ack *extack);
 
+struct p4tc_table *tcf_table_find_byany(struct p4tc_pipeline *pipeline,
+					const char *tblname, const u32 tbl_id,
+					struct netlink_ext_ack *extack);
+struct p4tc_table *tcf_table_find_byid(struct p4tc_pipeline *pipeline,
+				       const u32 tbl_id);
+int tcf_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
+				  struct netlink_ext_ack *extack);
+void tcf_table_put_mask_array(struct p4tc_pipeline *pipeline);
+struct p4tc_table *tcf_table_find_get(struct p4tc_pipeline *pipeline,
+				      const char *tblname, const u32 tbl_id,
+				      struct netlink_ext_ack *extack);
+
+static inline bool tcf_table_put_ref(struct p4tc_table *table)
+{
+	return refcount_dec_not_one(&table->tbl_ctrl_ref);
+}
+
+struct p4tc_table_default_act_params {
+	struct p4tc_table_defact *default_hitact;
+	struct p4tc_table_defact *default_missact;
+	struct nlattr *default_hit_attr;
+	struct nlattr *default_miss_attr;
+};
+
+int
+tcf_table_init_default_acts(struct net *net,
+			    struct p4tc_table_default_act_params *def_params,
+			    struct p4tc_table *table,
+			    struct list_head *acts_list,
+			    struct netlink_ext_ack *extack);
+
+static inline void
+tcf_table_defacts_acts_copy(struct p4tc_table_defact *defact_copy,
+			    struct p4tc_table_defact *defact_orig)
+{
+	defact_copy->default_acts = defact_orig->default_acts;
+}
+
+void
+tcf_table_replace_default_acts(struct p4tc_table *table,
+			       struct p4tc_table_default_act_params *def_params,
+			       bool lock_rtnl);
+
+struct p4tc_table_perm *
+tcf_table_init_permissions(struct p4tc_table *table, u16 permissions,
+			   struct netlink_ext_ack *extack);
+void tcf_table_replace_permissions(struct p4tc_table *table,
+				   struct p4tc_table_perm *tbl_perm,
+				   bool lock_rtnl);
+
 struct p4tc_parser *tcf_parser_create(struct p4tc_pipeline *pipeline,
 				      const char *parser_name, u32 parser_id,
 				      struct netlink_ext_ack *extack);
@@ -331,5 +451,6 @@ void tcf_p4_set_init_flags(struct tcf_p4act *p4act);
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
 #define to_hdrfield(t) ((struct p4tc_hdrfield *)t)
 #define to_act(t) ((struct p4tc_act *)t)
+#define to_table(t) ((struct p4tc_table *)t)
 
 #endif
diff --git a/include/net/p4tc_types.h b/include/net/p4tc_types.h
index 232399533..254ddad9f 100644
--- a/include/net/p4tc_types.h
+++ b/include/net/p4tc_types.h
@@ -8,7 +8,7 @@
 
 #include <uapi/linux/p4tc.h>
 
-#define P4T_MAX_BITSZ 128
+#define P4T_MAX_BITSZ P4TC_MAX_KEYSZ
 
 struct p4tc_type_mask_shift {
 	void *mask;
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 4d471519a..c36c1aea4 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -27,6 +27,73 @@ struct p4tcmsg {
 #define PARSERNAMSIZ TEMPLATENAMSZ
 #define HDRFIELDNAMSIZ TEMPLATENAMSZ
 #define ACTPARAMNAMSIZ TEMPLATENAMSZ
+#define TABLENAMSIZ TEMPLATENAMSZ
+
+#define P4TC_TABLE_FLAGS_KEYSZ 0x01
+#define P4TC_TABLE_FLAGS_MAX_ENTRIES 0x02
+#define P4TC_TABLE_FLAGS_MAX_MASKS 0x04
+#define P4TC_TABLE_FLAGS_DEFAULT_KEY 0x08
+#define P4TC_TABLE_FLAGS_PERMISSIONS 0x10
+#define P4TC_TABLE_FLAGS_TYPE 0x20
+#define P4TC_TABLE_FLAGS_AGING 0x40
+
+enum {
+	P4TC_TABLE_TYPE_EXACT = 1,
+	P4TC_TABLE_TYPE_LPM = 2,
+	P4TC_TABLE_TYPE_TERNARY = 3,
+	__P4TC_TABLE_TYPE_MAX,
+};
+#define P4TC_TABLE_TYPE_MAX (__P4TC_TABLE_TYPE_MAX - 1)
+
+#define P4TC_CTRL_PERM_C_BIT 9
+#define P4TC_CTRL_PERM_R_BIT 8
+#define P4TC_CTRL_PERM_U_BIT 7
+#define P4TC_CTRL_PERM_D_BIT 6
+#define P4TC_CTRL_PERM_X_BIT 5
+
+#define P4TC_DATA_PERM_C_BIT 4
+#define P4TC_DATA_PERM_R_BIT 3
+#define P4TC_DATA_PERM_U_BIT 2
+#define P4TC_DATA_PERM_D_BIT 1
+#define P4TC_DATA_PERM_X_BIT 0
+
+#define P4TC_PERM_MAX_BIT P4TC_CTRL_PERM_C_BIT
+
+#define P4TC_CTRL_PERM_C (1 << P4TC_CTRL_PERM_C_BIT)
+#define P4TC_CTRL_PERM_R (1 << P4TC_CTRL_PERM_R_BIT)
+#define P4TC_CTRL_PERM_U (1 << P4TC_CTRL_PERM_U_BIT)
+#define P4TC_CTRL_PERM_D (1 << P4TC_CTRL_PERM_D_BIT)
+#define P4TC_CTRL_PERM_X (1 << P4TC_CTRL_PERM_X_BIT)
+
+#define P4TC_DATA_PERM_C (1 << P4TC_DATA_PERM_C_BIT)
+#define P4TC_DATA_PERM_R (1 << P4TC_DATA_PERM_R_BIT)
+#define P4TC_DATA_PERM_U (1 << P4TC_DATA_PERM_U_BIT)
+#define P4TC_DATA_PERM_D (1 << P4TC_DATA_PERM_D_BIT)
+#define P4TC_DATA_PERM_X (1 << P4TC_DATA_PERM_X_BIT)
+
+#define p4tc_ctrl_create_ok(perm)   (perm & P4TC_CTRL_PERM_C)
+#define p4tc_ctrl_read_ok(perm)     (perm & P4TC_CTRL_PERM_R)
+#define p4tc_ctrl_update_ok(perm)   (perm & P4TC_CTRL_PERM_U)
+#define p4tc_ctrl_delete_ok(perm)   (perm & P4TC_CTRL_PERM_D)
+#define p4tc_ctrl_exec_ok(perm)     (perm & P4TC_CTRL_PERM_X)
+
+#define p4tc_data_create_ok(perm)   (perm & P4TC_DATA_PERM_C)
+#define p4tc_data_read_ok(perm)     (perm & P4TC_DATA_PERM_R)
+#define p4tc_data_update_ok(perm)   (perm & P4TC_DATA_PERM_U)
+#define p4tc_data_delete_ok(perm)   (perm & P4TC_DATA_PERM_D)
+#define p4tc_data_exec_ok(perm)     (perm & P4TC_DATA_PERM_X)
+
+struct p4tc_table_parm {
+	__u64 tbl_aging;
+	__u32 tbl_keysz;
+	__u32 tbl_max_entries;
+	__u32 tbl_max_masks;
+	__u32 tbl_flags;
+	__u32 tbl_num_entries;
+	__u16 tbl_permissions;
+	__u8  tbl_type;
+	__u8  PAD0;
+};
 
 #define LABELNAMSIZ 32
 
@@ -55,6 +122,7 @@ enum {
 	P4TC_OBJ_PIPELINE,
 	P4TC_OBJ_HDR_FIELD,
 	P4TC_OBJ_ACT,
+	P4TC_OBJ_TABLE,
 	__P4TC_OBJ_MAX,
 };
 #define P4TC_OBJ_MAX __P4TC_OBJ_MAX
@@ -108,6 +176,42 @@ enum {
 };
 #define P4T_MAX (__P4T_MAX - 1)
 
+enum {
+	P4TC_TABLE_DEFAULT_UNSPEC,
+	P4TC_TABLE_DEFAULT_ACTION,
+	P4TC_TABLE_DEFAULT_PERMISSIONS,
+	__P4TC_TABLE_DEFAULT_MAX
+};
+#define P4TC_TABLE_DEFAULT_MAX (__P4TC_TABLE_DEFAULT_MAX - 1)
+
+enum {
+	P4TC_TABLE_ACTS_DEFAULT_ONLY,
+	P4TC_TABLE_ACTS_TABLE_ONLY,
+	__P4TC_TABLE_ACTS_FLAGS_MAX,
+};
+#define P4TC_TABLE_ACTS_FLAGS_MAX (__P4TC_TABLE_ACTS_FLAGS_MAX - 1)
+
+enum {
+	P4TC_TABLE_ACT_UNSPEC,
+	P4TC_TABLE_ACT_FLAGS, /* u8 */
+	P4TC_TABLE_ACT_NAME, /* string */
+	__P4TC_TABLE_ACT_MAX
+};
+#define P4TC_TABLE_ACT_MAX (__P4TC_TABLE_ACT_MAX - 1)
+
+/* Table type attributes */
+enum {
+	P4TC_TABLE_UNSPEC,
+	P4TC_TABLE_NAME, /* string */
+	P4TC_TABLE_INFO, /* struct tc_p4_table_type_parm */
+	P4TC_TABLE_DEFAULT_HIT, /* nested default hit action attributes */
+	P4TC_TABLE_DEFAULT_MISS, /* nested default miss action attributes */
+	P4TC_TABLE_OPT_ENTRY, /* nested const table entry*/
+	P4TC_TABLE_ACTS_LIST, /* nested table actions list */
+	__P4TC_TABLE_MAX
+};
+#define P4TC_TABLE_MAX __P4TC_TABLE_MAX
+
 struct p4tc_hdrfield_ty {
 	__u16 startbit;
 	__u16 endbit;
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index f4a96efca..182ad141b 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
-	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o
+	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 94169a52d..9ece4689c 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -75,6 +75,7 @@ static const struct nla_policy tc_pipeline_policy[P4TC_PIPELINE_MAX + 1] = {
 static void tcf_pipeline_destroy(struct p4tc_pipeline *pipeline)
 {
 	idr_destroy(&pipeline->p_act_idr);
+	idr_destroy(&pipeline->p_tbl_idr);
 
 	kfree(pipeline);
 }
@@ -97,9 +98,13 @@ static void tcf_pipeline_teardown(struct p4tc_pipeline *pipeline,
 	struct net *net = pipeline->net;
 	struct p4tc_pipeline_net *pipe_net = net_generic(net, pipeline_net_id);
 	struct net *pipeline_net = maybe_get_net(net);
-	unsigned long iter_act_id;
+	unsigned long iter_act_id, tmp;
+	struct p4tc_table *table;
 	struct p4tc_act *act;
-	unsigned long tmp;
+	unsigned long tbl_id;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, tbl_id)
+		table->common.ops->put(pipeline, &table->common, extack);
 
 	idr_for_each_entry_ul(&pipeline->p_act_idr, act, tmp, iter_act_id)
 		act->common.ops->put(pipeline, &act->common, extack);
@@ -164,10 +169,16 @@ static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 		return -EINVAL;
 	}
 
+	ret = tcf_table_try_set_state_ready(pipeline, extack);
+	if (ret < 0)
+		return ret;
+
 	prealloc_acts = kcalloc(pipeline->num_created_acts,
 				sizeof(*prealloc_acts), GFP_KERNEL);
-	if (!prealloc_acts)
-		return -ENOMEM;
+	if (!prealloc_acts) {
+		ret = -ENOMEM;
+		goto unset_table_state_ready;
+	}
 
 	act_kinds_with_prealloc = tcf_p4_prealloc_acts(pipeline, prealloc_acts,
 						       extack);
@@ -190,12 +201,10 @@ static inline int pipeline_try_set_state_ready(struct p4tc_pipeline *pipeline,
 free_prealloc_acts:
 	kfree(prealloc_acts);
 
-	return ret;
-}
+unset_table_state_ready:
+	tcf_table_put_mask_array(pipeline);
 
-static inline bool pipeline_sealed(struct p4tc_pipeline *pipeline)
-{
-	return pipeline->p_state == P4TC_STATE_READY;
+	return ret;
 }
 
 struct p4tc_pipeline *tcf_pipeline_find_byid(struct net *net, const u32 pipeid)
@@ -291,6 +300,9 @@ static struct p4tc_pipeline *tcf_pipeline_create(struct net *net,
 
 	idr_init(&pipeline->p_act_idr);
 
+	idr_init(&pipeline->p_tbl_idr);
+	pipeline->curr_tables = 0;
+
 	pipeline->num_created_acts = 0;
 
 	pipeline->p_state = P4TC_STATE_NOT_READY;
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
new file mode 100644
index 000000000..84c05782d
--- /dev/null
+++ b/net/sched/p4tc/p4tc_table.c
@@ -0,0 +1,1497 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_table.c	P4 TC TABLE
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
+#include <linux/bitmap.h>
+#include <net/net_namespace.h>
+#include <net/sock.h>
+#include <net/sch_generic.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+#include <net/flow_offload.h>
+
+#define P4TC_P_UNSPEC 0
+#define P4TC_P_CREATED 1
+
+static int __tcf_table_try_set_state_ready(struct p4tc_table *table,
+					   struct netlink_ext_ack *extack)
+{
+	table->tbl_masks_array = kcalloc(table->tbl_max_masks,
+					 sizeof(*table->tbl_masks_array),
+					 GFP_KERNEL);
+	if (!table->tbl_masks_array)
+		return -ENOMEM;
+
+	table->tbl_free_masks_bitmap =
+		bitmap_alloc(P4TC_MAX_TMASKS, GFP_KERNEL);
+	if (!table->tbl_free_masks_bitmap) {
+		kfree(table->tbl_masks_array);
+		return -ENOMEM;
+	}
+
+	bitmap_fill(table->tbl_free_masks_bitmap, P4TC_MAX_TMASKS);
+
+	return 0;
+}
+
+static void free_table_cache_array(struct p4tc_table **set_tables,
+				   int num_tables)
+{
+	int i;
+
+	for (i = 0; i < num_tables; i++) {
+		struct p4tc_table *table = set_tables[i];
+
+		kfree(table->tbl_masks_array);
+		bitmap_free(table->tbl_free_masks_bitmap);
+	}
+}
+
+int tcf_table_try_set_state_ready(struct p4tc_pipeline *pipeline,
+				  struct netlink_ext_ack *extack)
+{
+	struct p4tc_table **set_tables;
+	struct p4tc_table *table;
+	unsigned long tmp, id;
+	int i = 0;
+	int ret;
+
+	set_tables = kcalloc(pipeline->num_tables, sizeof(*set_tables),
+			     GFP_KERNEL);
+	if (!set_tables)
+		return -ENOMEM;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, id) {
+		ret = __tcf_table_try_set_state_ready(table, extack);
+		if (ret < 0)
+			goto free_set_tables;
+		set_tables[i] = table;
+		i++;
+	}
+	kfree(set_tables);
+
+	return 0;
+
+free_set_tables:
+	free_table_cache_array(set_tables, i);
+	kfree(set_tables);
+	return ret;
+}
+
+static const struct nla_policy p4tc_table_policy[P4TC_TABLE_MAX + 1] = {
+	[P4TC_TABLE_NAME] = { .type = NLA_STRING, .len = TABLENAMSIZ },
+	[P4TC_TABLE_INFO] = { .type = NLA_BINARY,
+			      .len = sizeof(struct p4tc_table_parm) },
+	[P4TC_TABLE_DEFAULT_HIT] = { .type = NLA_NESTED },
+	[P4TC_TABLE_DEFAULT_MISS] = { .type = NLA_NESTED },
+	[P4TC_TABLE_ACTS_LIST] = { .type = NLA_NESTED },
+	[P4TC_TABLE_OPT_ENTRY] = { .type = NLA_NESTED },
+};
+
+static int _tcf_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_table_parm parm = {0};
+	struct p4tc_table_perm *tbl_perm;
+	struct p4tc_table_act *table_act;
+	struct nlattr *nested_tbl_acts;
+	struct nlattr *default_missact;
+	struct nlattr *default_hitact;
+	struct nlattr *nested_count;
+	struct nlattr *nest;
+	int i = 1;
+
+	if (nla_put_u32(skb, P4TC_PATH, table->tbl_id))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	if (nla_put_string(skb, P4TC_TABLE_NAME, table->common.name))
+		goto out_nlmsg_trim;
+
+	parm.tbl_keysz = table->tbl_keysz;
+	parm.tbl_max_entries = table->tbl_max_entries;
+	parm.tbl_max_masks = table->tbl_max_masks;
+	parm.tbl_type = table->tbl_type;
+	parm.tbl_aging = table->tbl_aging;
+
+	tbl_perm = rcu_dereference_rtnl(table->tbl_permissions);
+	parm.tbl_permissions = tbl_perm->permissions;
+
+	if (table->tbl_default_hitact) {
+		struct p4tc_table_defact *hitact;
+
+		default_hitact = nla_nest_start(skb, P4TC_TABLE_DEFAULT_HIT);
+		rcu_read_lock();
+		hitact = rcu_dereference_rtnl(table->tbl_default_hitact);
+		if (hitact->default_acts) {
+			struct nlattr *nest;
+
+			nest = nla_nest_start(skb, P4TC_TABLE_DEFAULT_ACTION);
+			if (tcf_action_dump(skb, hitact->default_acts, 0, 0,
+					    false) < 0) {
+				rcu_read_unlock();
+				goto out_nlmsg_trim;
+			}
+			nla_nest_end(skb, nest);
+		}
+		if (nla_put_u16(skb, P4TC_TABLE_DEFAULT_PERMISSIONS,
+				hitact->permissions) < 0) {
+			rcu_read_unlock();
+			goto out_nlmsg_trim;
+		}
+		rcu_read_unlock();
+		nla_nest_end(skb, default_hitact);
+	}
+
+	if (table->tbl_default_missact) {
+		struct p4tc_table_defact *missact;
+
+		default_missact = nla_nest_start(skb, P4TC_TABLE_DEFAULT_MISS);
+		rcu_read_lock();
+		missact = rcu_dereference_rtnl(table->tbl_default_missact);
+		if (missact->default_acts) {
+			struct nlattr *nest;
+
+			nest = nla_nest_start(skb, P4TC_TABLE_DEFAULT_ACTION);
+			if (tcf_action_dump(skb, missact->default_acts, 0, 0,
+					    false) < 0) {
+				rcu_read_unlock();
+				goto out_nlmsg_trim;
+			}
+			nla_nest_end(skb, nest);
+		}
+		if (nla_put_u16(skb, P4TC_TABLE_DEFAULT_PERMISSIONS,
+				missact->permissions) < 0) {
+			rcu_read_unlock();
+			goto out_nlmsg_trim;
+		}
+		rcu_read_unlock();
+		nla_nest_end(skb, default_missact);
+	}
+
+	nested_tbl_acts = nla_nest_start(skb, P4TC_TABLE_ACTS_LIST);
+	list_for_each_entry(table_act, &table->tbl_acts_list, node) {
+		nested_count = nla_nest_start(skb, i);
+		if (nla_put_string(skb, P4TC_TABLE_ACT_NAME,
+				   table_act->ops->kind) < 0)
+			goto out_nlmsg_trim;
+		if (nla_put_u32(skb, P4TC_TABLE_ACT_FLAGS,
+				table_act->flags) < 0)
+			goto out_nlmsg_trim;
+
+		nla_nest_end(skb, nested_count);
+		i++;
+	}
+	nla_nest_end(skb, nested_tbl_acts);
+
+	if (nla_put(skb, P4TC_TABLE_INFO, sizeof(parm), &parm))
+		goto out_nlmsg_trim;
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return -1;
+}
+
+static int tcf_table_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				struct p4tc_template_common *template,
+				struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table = to_table(template);
+
+	if (_tcf_table_fill_nlmsg(skb, table) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for table");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline void p4tc_table_defact_destroy(struct p4tc_table_defact *defact)
+{
+	if (defact) {
+		p4tc_action_destroy(defact->default_acts);
+		kfree(defact);
+	}
+}
+
+static void tcf_table_acts_list_destroy(struct list_head *acts_list)
+{
+	struct p4tc_table_act *table_act, *tmp;
+
+	list_for_each_entry_safe(table_act, tmp, acts_list, node) {
+		struct p4tc_act *act;
+
+		act = container_of(table_act->ops, typeof(*act), ops);
+		list_del(&table_act->node);
+		kfree(table_act);
+		tcf_action_put(act);
+	}
+}
+
+static void __tcf_table_put_mask_array(struct p4tc_table *table)
+{
+	kfree(table->tbl_masks_array);
+	bitmap_free(table->tbl_free_masks_bitmap);
+}
+
+void tcf_table_put_mask_array(struct p4tc_pipeline *pipeline)
+{
+	struct p4tc_table *table;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, id) {
+		__tcf_table_put_mask_array(table);
+	}
+}
+
+static inline int _tcf_table_put(struct net *net, struct nlattr **tb,
+				 struct p4tc_pipeline *pipeline,
+				 struct p4tc_table *table,
+				 struct netlink_ext_ack *extack)
+{
+	bool default_act_del = false;
+	struct p4tc_table_perm *perm;
+
+	if (tb)
+		default_act_del = tb[P4TC_TABLE_DEFAULT_HIT] ||
+				  tb[P4TC_TABLE_DEFAULT_MISS];
+
+	if (!default_act_del) {
+		if (!refcount_dec_if_one(&table->tbl_ctrl_ref)) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to delete referenced table");
+			return -EBUSY;
+		}
+	}
+
+	if (tb && tb[P4TC_TABLE_DEFAULT_HIT]) {
+		struct p4tc_table_defact *hitact;
+
+		rcu_read_lock();
+		hitact = rcu_dereference(table->tbl_default_hitact);
+		if (hitact && !p4tc_ctrl_delete_ok(hitact->permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Permission denied: Unable to delete default hitact");
+			rcu_read_unlock();
+			return -EPERM;
+		}
+		rcu_read_unlock();
+	}
+
+	if (tb && tb[P4TC_TABLE_DEFAULT_MISS]) {
+		struct p4tc_table_defact *missact;
+
+		rcu_read_lock();
+		missact = rcu_dereference(table->tbl_default_missact);
+		if (missact && !p4tc_ctrl_delete_ok(missact->permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Permission denied: Unable to delete default missact");
+			rcu_read_unlock();
+			return -EPERM;
+		}
+		rcu_read_unlock();
+	}
+
+	if (!default_act_del || tb[P4TC_TABLE_DEFAULT_HIT]) {
+		struct p4tc_table_defact *hitact;
+
+		hitact = rtnl_dereference(table->tbl_default_hitact);
+		if (hitact) {
+			rcu_replace_pointer_rtnl(table->tbl_default_hitact,
+						 NULL);
+			synchronize_rcu();
+			p4tc_table_defact_destroy(hitact);
+		}
+	}
+
+	if (!default_act_del || tb[P4TC_TABLE_DEFAULT_MISS]) {
+		struct p4tc_table_defact *missact;
+
+		missact = rtnl_dereference(table->tbl_default_missact);
+		if (missact) {
+			rcu_replace_pointer_rtnl(table->tbl_default_missact,
+						 NULL);
+			synchronize_rcu();
+			p4tc_table_defact_destroy(missact);
+		}
+	}
+
+	if (default_act_del)
+		return 0;
+
+	tcf_table_acts_list_destroy(&table->tbl_acts_list);
+
+	idr_destroy(&table->tbl_masks_idr);
+	idr_destroy(&table->tbl_prio_idr);
+
+	perm = rcu_replace_pointer_rtnl(table->tbl_permissions, NULL);
+	kfree_rcu(perm, rcu);
+
+	idr_remove(&pipeline->p_tbl_idr, table->tbl_id);
+	pipeline->curr_tables -= 1;
+
+	kfree(table->tbl_masks_array);
+	bitmap_free(table->tbl_free_masks_bitmap);
+
+	kfree(table);
+
+	return 0;
+}
+
+static int tcf_table_put(struct p4tc_pipeline *pipeline,
+			 struct p4tc_template_common *tmpl,
+			 struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table = to_table(tmpl);
+
+	return _tcf_table_put(pipeline->net, NULL, pipeline, table, extack);
+}
+
+struct p4tc_table *tcf_table_find_byid(struct p4tc_pipeline *pipeline,
+				       const u32 tbl_id)
+{
+	return idr_find(&pipeline->p_tbl_idr, tbl_id);
+}
+
+static struct p4tc_table *tcf_table_find_byname(const char *tblname,
+						struct p4tc_pipeline *pipeline)
+{
+	struct p4tc_table *table;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, id)
+		if (strncmp(table->common.name, tblname, TABLENAMSIZ) == 0)
+			return table;
+
+	return NULL;
+}
+
+#define SEPARATOR '/'
+struct p4tc_table *tcf_table_find_byany(struct p4tc_pipeline *pipeline,
+					const char *tblname, const u32 tbl_id,
+					struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table;
+	int err;
+
+	if (tbl_id) {
+		table = tcf_table_find_byid(pipeline, tbl_id);
+		if (!table) {
+			NL_SET_ERR_MSG(extack, "Unable to find table by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (tblname) {
+			table = tcf_table_find_byname(tblname, pipeline);
+			if (!table) {
+				NL_SET_ERR_MSG(extack, "Table name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack, "Must specify table name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return table;
+out:
+	return ERR_PTR(err);
+}
+
+static int tcf_table_get(struct p4tc_table *table)
+{
+	return refcount_inc_not_zero(&table->tbl_ctrl_ref);
+}
+
+struct p4tc_table *tcf_table_find_get(struct p4tc_pipeline *pipeline,
+				      const char *tblname, const u32 tbl_id,
+				      struct netlink_ext_ack *extack)
+{
+	struct p4tc_table *table;
+
+	table = tcf_table_find_byany(pipeline, tblname, tbl_id, extack);
+	if (IS_ERR(table))
+		return table;
+
+	if (!tcf_table_get(table)) {
+		NL_SET_ERR_MSG(extack, "Table is marked for deletion");
+		return ERR_PTR(-EBUSY);
+	}
+
+	return table;
+}
+
+static int __tcf_table_init_default_act(struct net *net, struct nlattr **tb,
+					struct p4tc_table_defact **default_act,
+					u32 pipeid, __u16 curr_permissions,
+					struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	*default_act = kzalloc(sizeof(**default_act), GFP_KERNEL);
+	if (!(*default_act))
+		return -ENOMEM;
+
+	if (tb[P4TC_TABLE_DEFAULT_PERMISSIONS]) {
+		__u16 *permissions;
+
+		permissions = nla_data(tb[P4TC_TABLE_DEFAULT_PERMISSIONS]);
+		if (!p4tc_ctrl_read_ok(*permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Default action must have ctrl path read permissions");
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		if (!p4tc_data_read_ok(*permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Default action must have data path read permissions");
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		if (!p4tc_data_exec_ok(*permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Default action must have data path execute permissions");
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		(*default_act)->permissions = *permissions;
+	} else {
+		(*default_act)->permissions = curr_permissions;
+	}
+
+	if (tb[P4TC_TABLE_DEFAULT_ACTION]) {
+		struct tc_action **default_acts;
+
+		if (!p4tc_ctrl_update_ok(curr_permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Permission denied: Unable to update default hit action");
+			ret = -EPERM;
+			goto default_act_free;
+		}
+
+		default_acts = kcalloc(TCA_ACT_MAX_PRIO,
+				       sizeof(struct tc_action *), GFP_KERNEL);
+		if (!default_acts) {
+			ret = -ENOMEM;
+			goto default_act_free;
+		}
+
+		ret = p4tc_action_init(net, tb[P4TC_TABLE_DEFAULT_ACTION],
+				       default_acts, pipeid, 0, extack);
+		if (ret < 0) {
+			kfree(default_acts);
+			goto default_act_free;
+		} else if (ret > 1) {
+			NL_SET_ERR_MSG(extack, "Can only have one hit action");
+			p4tc_action_destroy(default_acts);
+			kfree(default_acts);
+			ret = -EINVAL;
+			goto default_act_free;
+		}
+		(*default_act)->default_acts = default_acts;
+	}
+
+	return 0;
+
+default_act_free:
+	kfree(*default_act);
+
+	return ret;
+}
+
+static int tcf_table_check_defacts(struct tc_action *defact,
+				   struct list_head *acts_list)
+{
+	struct p4tc_table_act *table_act;
+
+	list_for_each_entry(table_act, acts_list, node) {
+		if (table_act->ops->id == defact->ops->id &&
+		    !(table_act->flags & BIT(P4TC_TABLE_ACTS_TABLE_ONLY)))
+			return true;
+	}
+
+	return false;
+}
+
+static struct nla_policy p4tc_table_default_policy[P4TC_TABLE_DEFAULT_MAX + 1] = {
+	[P4TC_TABLE_DEFAULT_ACTION] = { .type = NLA_NESTED },
+	[P4TC_TABLE_DEFAULT_PERMISSIONS] =
+		NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
+};
+
+static int
+tcf_table_init_default_act(struct net *net, struct nlattr *nla,
+			   struct p4tc_table *table,
+			   u16 curr_permissions,
+			   struct p4tc_table_defact **default_act,
+			   struct list_head *acts_list,
+			   struct netlink_ext_ack *extack)
+{
+	u16 permissions = P4TC_CONTROL_PERMISSIONS | P4TC_DATA_PERMISSIONS;
+	struct nlattr *tb[P4TC_TABLE_DEFAULT_MAX + 1];
+	int ret;
+
+	if (curr_permissions)
+		permissions = curr_permissions;
+
+	ret = nla_parse_nested(tb, P4TC_TABLE_DEFAULT_MAX, nla,
+			       p4tc_table_default_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (!tb[P4TC_TABLE_DEFAULT_ACTION] &&
+	    !tb[P4TC_TABLE_DEFAULT_PERMISSIONS])
+		return 0;
+
+	ret = __tcf_table_init_default_act(net, tb,
+					   default_act,
+					   table->common.p_id, permissions,
+					   extack);
+	if (ret < 0)
+		return ret;
+	if ((*default_act)->default_acts &&
+	    !tcf_table_check_defacts((*default_act)->default_acts[0],
+				     acts_list)) {
+		NL_SET_ERR_MSG(extack,
+			       "Action is not allowed as default hit action");
+		p4tc_table_defact_destroy(*default_act);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+struct p4tc_table_perm *
+tcf_table_init_permissions(struct p4tc_table *table, u16 permissions,
+			   struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_perm *tbl_perm;
+	int ret;
+
+	if (permissions > P4TC_MAX_PERMISSION) {
+		NL_SET_ERR_MSG(extack,
+			       "Permission may only have 10 bits turned on");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (!p4tc_ctrl_read_ok(permissions)) {
+		NL_SET_ERR_MSG(extack,
+			       "Table must have read permissions");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (!p4tc_data_exec_ok(permissions)) {
+		NL_SET_ERR_MSG(extack,
+			       "Table must have execute permissions");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (!p4tc_data_read_ok(permissions)) {
+		NL_SET_ERR_MSG(extack,
+			       "Data path read permissions must be set");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tbl_perm = kzalloc(sizeof(*tbl_perm), GFP_KERNEL);
+	if (!tbl_perm) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tbl_perm->permissions = permissions;
+
+	return tbl_perm;
+
+out:
+	return ERR_PTR(ret);
+}
+
+void tcf_table_replace_permissions(struct p4tc_table *table,
+				   struct p4tc_table_perm *tbl_perm,
+				   bool lock_rtnl)
+{
+	if (!tbl_perm)
+		return;
+
+	if (lock_rtnl)
+		rtnl_lock();
+	tbl_perm = rcu_replace_pointer_rtnl(table->tbl_permissions, tbl_perm);
+	if (lock_rtnl)
+		rtnl_unlock();
+	kfree_rcu(tbl_perm, rcu);
+}
+
+int
+tcf_table_init_default_acts(struct net *net,
+			    struct p4tc_table_default_act_params *def_params,
+			    struct p4tc_table *table,
+			    struct list_head *acts_list,
+			    struct netlink_ext_ack *extack)
+{
+	u16 permissions;
+	int ret;
+
+	def_params->default_missact = NULL;
+	def_params->default_hitact = NULL;
+
+	if (def_params->default_hit_attr) {
+		struct p4tc_table_defact *tmp_default_hitact;
+
+		permissions = P4TC_CONTROL_PERMISSIONS | P4TC_DATA_PERMISSIONS;
+
+		rcu_read_lock();
+		if (table->tbl_default_hitact) {
+			tmp_default_hitact = rcu_dereference(table->tbl_default_hitact);
+			permissions = tmp_default_hitact->permissions;
+		}
+		rcu_read_unlock();
+
+		ret = tcf_table_init_default_act(net,
+						 def_params->default_hit_attr,
+						 table, permissions,
+						 &def_params->default_hitact,
+						 acts_list, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (def_params->default_miss_attr) {
+		struct p4tc_table_defact *tmp_default_missact;
+
+		permissions = P4TC_CONTROL_PERMISSIONS | P4TC_DATA_PERMISSIONS;
+
+		rcu_read_lock();
+		if (table->tbl_default_missact) {
+			tmp_default_missact = rcu_dereference(table->tbl_default_missact);
+			permissions = tmp_default_missact->permissions;
+		}
+		rcu_read_unlock();
+
+		ret = tcf_table_init_default_act(net,
+						 def_params->default_miss_attr,
+						 table, permissions,
+						 &def_params->default_missact,
+						 acts_list, extack);
+		if (ret < 0)
+			goto default_hitacts_free;
+	}
+
+	return 0;
+
+default_hitacts_free:
+	p4tc_table_defact_destroy(def_params->default_hitact);
+
+	return ret;
+}
+
+static const struct nla_policy p4tc_acts_list_policy[P4TC_TABLE_MAX + 1] = {
+	[P4TC_TABLE_ACT_FLAGS] =
+		NLA_POLICY_RANGE(NLA_U8, 0, BIT(P4TC_TABLE_ACTS_FLAGS_MAX)),
+	[P4TC_TABLE_ACT_NAME] = { .type = NLA_STRING, .len = ACTNAMSIZ },
+};
+
+static struct p4tc_table_act *tcf_table_act_init(struct nlattr *nla,
+						 struct p4tc_pipeline *pipeline,
+						 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_TABLE_ACT_MAX + 1];
+	struct p4tc_table_act *table_act;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_TABLE_ACT_MAX, nla,
+			       p4tc_acts_list_policy, extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	table_act = kzalloc(sizeof(*table_act), GFP_KERNEL);
+	if (unlikely(!table_act))
+		return ERR_PTR(-ENOMEM);
+
+	if (tb[P4TC_TABLE_ACT_NAME]) {
+		const char *actname = nla_data(tb[P4TC_TABLE_ACT_NAME]);
+		char *act_name_clone, *act_name, *p_name;
+		struct p4tc_act *act;
+
+		act_name_clone = act_name = kstrdup(actname, GFP_KERNEL);
+		if (unlikely(!act_name)) {
+			ret = -ENOMEM;
+			goto free_table_act;
+		}
+
+		p_name = strsep(&act_name, "/");
+		act = tcf_action_find_get(pipeline, act_name, 0, extack);
+		kfree(act_name_clone);
+		if (IS_ERR(act)) {
+			ret = PTR_ERR(act);
+			goto free_table_act;
+		}
+
+		table_act->ops = &act->ops;
+	} else {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify allowed table action name");
+		ret = -EINVAL;
+		goto free_table_act;
+	}
+
+	if (tb[P4TC_TABLE_ACT_FLAGS]) {
+		u8 *flags = nla_data(tb[P4TC_TABLE_ACT_FLAGS]);
+
+		table_act->flags = *flags;
+	}
+
+	return table_act;
+
+free_table_act:
+	kfree(table_act);
+	return ERR_PTR(ret);
+}
+
+void
+tcf_table_replace_default_acts(struct p4tc_table *table,
+			       struct p4tc_table_default_act_params *def_params,
+			       bool lock_rtnl)
+{
+	if (def_params->default_hitact) {
+		bool updated_actions = !!def_params->default_hitact->default_acts;
+		struct p4tc_table_defact *hitact;
+
+		if (lock_rtnl)
+			rtnl_lock();
+		if (!updated_actions) {
+			hitact = rcu_dereference_rtnl(table->tbl_default_hitact);
+			tcf_table_defacts_acts_copy(def_params->default_hitact,
+						    hitact);
+		}
+		hitact = rcu_replace_pointer_rtnl(table->tbl_default_hitact,
+						  def_params->default_hitact);
+		if (lock_rtnl)
+			rtnl_unlock();
+		if (hitact) {
+			synchronize_rcu();
+			if (updated_actions)
+				p4tc_table_defact_destroy(hitact);
+			else
+				kfree(hitact);
+		}
+	}
+
+	if (def_params->default_missact) {
+		bool updated_actions = !!def_params->default_missact->default_acts;
+		struct p4tc_table_defact *missact;
+
+		if (lock_rtnl)
+			rtnl_lock();
+		if (!updated_actions) {
+			missact = rcu_dereference_rtnl(table->tbl_default_missact);
+			tcf_table_defacts_acts_copy(def_params->default_missact,
+						    missact);
+		}
+		missact = rcu_replace_pointer_rtnl(table->tbl_default_missact,
+						   def_params->default_missact);
+		if (lock_rtnl)
+			rtnl_unlock();
+		if (missact) {
+			synchronize_rcu();
+			if (updated_actions)
+				p4tc_table_defact_destroy(missact);
+			else
+				kfree(missact);
+		}
+	}
+}
+
+static int tcf_table_acts_list_init(struct nlattr *nla,
+				    struct p4tc_pipeline *pipeline,
+				    struct list_head *acts_list,
+				    struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MSGBATCH_SIZE + 1];
+	struct p4tc_table_act *table_act;
+	int ret;
+	int i;
+
+	ret = nla_parse_nested(tb, P4TC_MSGBATCH_SIZE, nla, NULL, extack);
+	if (ret < 0)
+		return ret;
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && tb[i]; i++) {
+		table_act = tcf_table_act_init(tb[i], pipeline, extack);
+		if (IS_ERR(table_act)) {
+			ret = PTR_ERR(table_act);
+			goto free_acts_list_list;
+		}
+		list_add_tail(&table_act->node, acts_list);
+	}
+
+	return 0;
+
+free_acts_list_list:
+	tcf_table_acts_list_destroy(acts_list);
+
+	return ret;
+}
+
+static struct p4tc_table *
+tcf_table_find_byanyattr(struct p4tc_pipeline *pipeline,
+			 struct nlattr *name_attr, const u32 tbl_id,
+			 struct netlink_ext_ack *extack)
+{
+	char *tblname = NULL;
+
+	if (name_attr)
+		tblname = nla_data(name_attr);
+
+	return tcf_table_find_byany(pipeline, tblname, tbl_id, extack);
+}
+
+static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
+					   u32 tbl_id,
+					   struct p4tc_pipeline *pipeline,
+					   struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_default_act_params def_params = {0};
+	struct p4tc_table_parm *parm;
+	struct p4tc_table *table;
+	char *tblname;
+	int ret;
+
+	if (pipeline->curr_tables == pipeline->num_tables) {
+		NL_SET_ERR_MSG(extack,
+			       "Table range exceeded max allowed value");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_TABLE_NAME)) {
+		NL_SET_ERR_MSG(extack, "Must specify table name");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tblname =
+		strnchr(nla_data(tb[P4TC_TABLE_NAME]), TABLENAMSIZ, SEPARATOR);
+	if (!tblname) {
+		NL_SET_ERR_MSG(extack, "Table name must contain control block");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tblname += 1;
+	if (tblname[0] == '\0') {
+		NL_SET_ERR_MSG(extack, "Control block name is too big");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	table = tcf_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
+					 NULL);
+	if (!IS_ERR(table)) {
+		NL_SET_ERR_MSG(extack, "Table already exists");
+		ret = -EEXIST;
+		goto out;
+	}
+
+	table = kzalloc(sizeof(*table), GFP_KERNEL);
+	if (!table) {
+		NL_SET_ERR_MSG(extack, "Unable to create table");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	table->common.p_id = pipeline->common.p_id;
+	strscpy(table->common.name, nla_data(tb[P4TC_TABLE_NAME]), TABLENAMSIZ);
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_TABLE_INFO)) {
+		ret = -EINVAL;
+		NL_SET_ERR_MSG(extack, "Missing table info");
+		goto free;
+	}
+	parm = nla_data(tb[P4TC_TABLE_INFO]);
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_KEYSZ) {
+		if (!parm->tbl_keysz) {
+			NL_SET_ERR_MSG(extack, "Table keysz cannot be zero");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (parm->tbl_keysz > P4TC_MAX_KEYSZ) {
+			NL_SET_ERR_MSG(extack,
+				       "Table keysz exceeds maximum keysz");
+			ret = -EINVAL;
+			goto free;
+		}
+		table->tbl_keysz = parm->tbl_keysz;
+	} else {
+		NL_SET_ERR_MSG(extack, "Must specify table key size");
+		ret = -EINVAL;
+		goto free;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_ENTRIES) {
+		if (!parm->tbl_max_entries) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_entries cannot be zero");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (parm->tbl_max_entries > P4TC_MAX_TENTRIES) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_entries exceeds maximum value");
+			ret = -EINVAL;
+			goto free;
+		}
+		table->tbl_max_entries = parm->tbl_max_entries;
+	} else {
+		table->tbl_max_entries = P4TC_DEFAULT_TENTRIES;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_MASKS) {
+		if (!parm->tbl_max_masks) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_masks cannot be zero");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (parm->tbl_max_masks > P4TC_MAX_TMASKS) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_masks exceeds maximum value");
+			ret = -EINVAL;
+			goto free;
+		}
+		table->tbl_max_masks = parm->tbl_max_masks;
+	} else {
+		table->tbl_max_masks = P4TC_DEFAULT_TMASKS;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_PERMISSIONS) {
+		u16 tbl_perms = parm->tbl_permissions;
+
+		table->tbl_permissions = tcf_table_init_permissions(table,
+								    tbl_perms,
+								    extack);
+	} else {
+		u16 tbl_perms = P4TC_TABLE_PERMISSIONS;
+
+		table->tbl_permissions = tcf_table_init_permissions(table,
+								    tbl_perms,
+								    extack);
+	}
+	if (IS_ERR(table->tbl_permissions)) {
+		ret = PTR_ERR(table->tbl_permissions);
+		goto free;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_TYPE) {
+		if (parm->tbl_type > P4TC_TABLE_TYPE_MAX) {
+			NL_SET_ERR_MSG(extack, "Table type can only be exact or LPM");
+			ret = -EINVAL;
+			goto free_permissions;
+		}
+		table->tbl_type = parm->tbl_type;
+	} else {
+		table->tbl_type = P4TC_TABLE_TYPE_EXACT;
+	}
+
+	if (parm->tbl_flags & P4TC_TABLE_FLAGS_AGING) {
+		if (!parm->tbl_aging) {
+			NL_SET_ERR_MSG(extack,
+				       "Table aging can't be zero");
+			ret = -EINVAL;
+			goto free;
+		}
+		if (parm->tbl_aging > P4TC_MAX_T_AGING) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max_masks exceeds maximum value");
+			ret = -EINVAL;
+			goto free;
+		}
+		table->tbl_aging = parm->tbl_aging;
+	} else {
+		table->tbl_aging = P4TC_DEFAULT_T_AGING;
+	}
+
+	refcount_set(&table->tbl_ctrl_ref, 1);
+
+	if (tbl_id) {
+		table->tbl_id = tbl_id;
+		ret = idr_alloc_u32(&pipeline->p_tbl_idr, table, &table->tbl_id,
+				    table->tbl_id, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate table id");
+			goto free_permissions;
+		}
+	} else {
+		table->tbl_id = 1;
+		ret = idr_alloc_u32(&pipeline->p_tbl_idr, table, &table->tbl_id,
+				    UINT_MAX, GFP_KERNEL);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack, "Unable to allocate table id");
+			goto free_permissions;
+		}
+	}
+
+	INIT_LIST_HEAD(&table->tbl_acts_list);
+	if (tb[P4TC_TABLE_ACTS_LIST]) {
+		ret = tcf_table_acts_list_init(tb[P4TC_TABLE_ACTS_LIST],
+					       pipeline, &table->tbl_acts_list,
+					       extack);
+		if (ret < 0)
+			goto idr_rm;
+	}
+
+	def_params.default_hit_attr = tb[P4TC_TABLE_DEFAULT_HIT];
+	def_params.default_miss_attr = tb[P4TC_TABLE_DEFAULT_MISS];
+
+	ret = tcf_table_init_default_acts(net, &def_params, table,
+					  &table->tbl_acts_list, extack);
+	if (ret < 0)
+		goto idr_rm;
+
+	table->tbl_default_hitact = def_params.default_hitact;
+	table->tbl_default_missact = def_params.default_missact;
+
+	if (table->tbl_default_hitact &&
+	    !table->tbl_default_hitact->default_acts) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify defaults_hit_actions's action values");
+		ret = -EINVAL;
+		goto defaultacts_destroy;
+	}
+
+	if (table->tbl_default_missact &&
+	    !table->tbl_default_missact->default_acts) {
+		NL_SET_ERR_MSG(extack,
+			       "Must specify defaults_miss_actions's action values");
+		ret = -EINVAL;
+		goto defaultacts_destroy;
+	}
+
+	idr_init(&table->tbl_masks_idr);
+	idr_init(&table->tbl_prio_idr);
+	spin_lock_init(&table->tbl_masks_idr_lock);
+
+	pipeline->curr_tables += 1;
+
+	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
+
+	return table;
+
+defaultacts_destroy:
+	p4tc_table_defact_destroy(table->tbl_default_missact);
+	p4tc_table_defact_destroy(table->tbl_default_hitact);
+
+idr_rm:
+	idr_remove(&pipeline->p_tbl_idr, table->tbl_id);
+
+free_permissions:
+	kfree(table->tbl_permissions);
+
+	tcf_table_acts_list_destroy(&table->tbl_acts_list);
+
+free:
+	kfree(table);
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_table *tcf_table_update(struct net *net, struct nlattr **tb,
+					   u32 tbl_id,
+					   struct p4tc_pipeline *pipeline,
+					   u32 flags,
+					   struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_default_act_params def_params = {0};
+	struct list_head *tbl_acts_list = NULL;
+	struct p4tc_table_perm *perm = NULL;
+	struct p4tc_table_parm *parm = NULL;
+	struct p4tc_table *table;
+	u64 tbl_aging = 0;
+	int ret = 0;
+
+	table = tcf_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
+					 extack);
+	if (IS_ERR(table))
+		return table;
+
+	if (tb[P4TC_TABLE_ACTS_LIST]) {
+		tbl_acts_list = kzalloc(sizeof(*tbl_acts_list), GFP_KERNEL);
+		if (!tbl_acts_list) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		INIT_LIST_HEAD(tbl_acts_list);
+		ret = tcf_table_acts_list_init(tb[P4TC_TABLE_ACTS_LIST],
+					       pipeline, tbl_acts_list, extack);
+		if (ret < 0)
+			goto table_acts_destroy;
+	}
+
+	def_params.default_hit_attr = tb[P4TC_TABLE_DEFAULT_HIT];
+	def_params.default_miss_attr = tb[P4TC_TABLE_DEFAULT_MISS];
+
+	if (tbl_acts_list)
+		ret = tcf_table_init_default_acts(net, &def_params, table,
+						  tbl_acts_list, extack);
+	else
+		ret = tcf_table_init_default_acts(net, &def_params, table,
+						  &table->tbl_acts_list,
+						  extack);
+	if (ret < 0)
+		goto table_acts_destroy;
+
+	if (tb[P4TC_TABLE_INFO]) {
+		parm = nla_data(tb[P4TC_TABLE_INFO]);
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_KEYSZ) {
+			if (!parm->tbl_keysz) {
+				NL_SET_ERR_MSG(extack,
+					       "Table keysz cannot be zero");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			if (parm->tbl_keysz > P4TC_MAX_KEYSZ) {
+				NL_SET_ERR_MSG(extack,
+					       "Table keysz exceeds maximum keysz");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			table->tbl_keysz = parm->tbl_keysz;
+		}
+
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_ENTRIES) {
+			if (!parm->tbl_max_entries) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_entries cannot be zero");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			if (parm->tbl_max_entries > P4TC_MAX_TENTRIES) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_entries exceeds maximum value");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			table->tbl_max_entries = parm->tbl_max_entries;
+		}
+
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_MAX_MASKS) {
+			if (!parm->tbl_max_masks) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_masks cannot be zero");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			if (parm->tbl_max_masks > P4TC_MAX_TMASKS) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_masks exceeds maximum value");
+				ret = -EINVAL;
+				goto defaultacts_destroy;
+			}
+			table->tbl_max_masks = parm->tbl_max_masks;
+		}
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_PERMISSIONS) {
+			perm = tcf_table_init_permissions(table,
+							  parm->tbl_permissions,
+							  extack);
+			if (IS_ERR(perm)) {
+				ret = PTR_ERR(perm);
+				goto defaultacts_destroy;
+			}
+		}
+
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_TYPE) {
+			if (parm->tbl_type > P4TC_TABLE_TYPE_MAX) {
+				NL_SET_ERR_MSG(extack, "Table type can only be exact or LPM");
+				ret = -EINVAL;
+				goto free_perm;
+			}
+			table->tbl_type = parm->tbl_type;
+		}
+		if (parm->tbl_flags & P4TC_TABLE_FLAGS_AGING) {
+			if (!parm->tbl_aging) {
+				NL_SET_ERR_MSG(extack,
+					       "Table aging can't be zero");
+				ret = -EINVAL;
+				goto free_perm;
+			}
+			if (parm->tbl_aging > P4TC_MAX_T_AGING) {
+				NL_SET_ERR_MSG(extack,
+					       "Table max_masks exceeds maximum value");
+				ret = -EINVAL;
+				goto free_perm;
+			}
+			tbl_aging = parm->tbl_aging;
+		}
+	}
+
+	tcf_table_replace_default_acts(table, &def_params, false);
+	tcf_table_replace_permissions(table, perm, false);
+
+	if (tbl_aging)
+		table->tbl_aging = tbl_aging;
+
+	return table;
+
+free_perm:
+	kfree(perm);
+
+defaultacts_destroy:
+	p4tc_table_defact_destroy(def_params.default_missact);
+	p4tc_table_defact_destroy(def_params.default_hitact);
+
+table_acts_destroy:
+	if (tbl_acts_list) {
+		tcf_table_acts_list_destroy(tbl_acts_list);
+		kfree(tbl_acts_list);
+	}
+
+out:
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+tcf_table_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+	     struct p4tc_nl_pname *nl_pname, u32 *ids,
+	     struct netlink_ext_ack *extack)
+{
+	u32 pipeid = ids[P4TC_PID_IDX], tbl_id = ids[P4TC_TBLID_IDX];
+	struct nlattr *tb[P4TC_TABLE_MAX + 1];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+	int ret;
+
+	pipeline = tcf_pipeline_find_byany(net, nl_pname->data, pipeid, extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	ret = nla_parse_nested(tb, P4TC_TABLE_MAX, nla, p4tc_table_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Only default action updates are allowed in sealed pipeline");
+		return ERR_PTR(-EINVAL);
+	}
+
+	switch (n->nlmsg_type) {
+	case RTM_CREATEP4TEMPLATE:
+		table = tcf_table_create(net, tb, tbl_id, pipeline, extack);
+		break;
+	case RTM_UPDATEP4TEMPLATE:
+		table = tcf_table_update(net, tb, tbl_id, pipeline,
+					 n->nlmsg_flags, extack);
+		break;
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	if (IS_ERR(table))
+		goto out;
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!ids[P4TC_TBLID_IDX])
+		ids[P4TC_TBLID_IDX] = table->tbl_id;
+
+out:
+	return (struct p4tc_template_common *)table;
+}
+
+static int tcf_table_flush(struct net *net, struct sk_buff *skb,
+			   struct p4tc_pipeline *pipeline,
+			   struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	unsigned long tmp, tbl_id;
+	struct p4tc_table *table;
+	int ret = 0;
+	int i = 0;
+
+	if (nla_put_u32(skb, P4TC_PATH, 0))
+		goto out_nlmsg_trim;
+
+	if (idr_is_empty(&pipeline->p_tbl_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no tables to flush");
+		goto out_nlmsg_trim;
+	}
+
+	idr_for_each_entry_ul(&pipeline->p_tbl_idr, table, tmp, tbl_id) {
+		if (_tcf_table_put(net, NULL, pipeline, table, extack) < 0) {
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
+			NL_SET_ERR_MSG(extack, "Unable to flush any table");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG(extack, "Unable to flush all tables");
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
+static int tcf_table_gd(struct net *net, struct sk_buff *skb,
+			struct nlmsghdr *n, struct nlattr *nla,
+			struct p4tc_nl_pname *nl_pname, u32 *ids,
+			struct netlink_ext_ack *extack)
+{
+	u32 pipeid = ids[P4TC_PID_IDX], tbl_id = ids[P4TC_TBLID_IDX];
+	struct nlattr *tb[P4TC_TABLE_MAX + 1] = {};
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table *table;
+	int ret = 0;
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_TABLE_MAX, nla,
+				       p4tc_table_policy, extack);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	if (n->nlmsg_type == RTM_GETP4TEMPLATE)
+		pipeline = tcf_pipeline_find_byany(net, nl_pname->data, pipeid,
+						   extack);
+	else
+		pipeline = tcf_pipeline_find_byany_unsealed(net, nl_pname->data,
+							    pipeid, extack);
+
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && (n->nlmsg_flags & NLM_F_ROOT))
+		return tcf_table_flush(net, skb, pipeline, extack);
+
+	table = tcf_table_find_byanyattr(pipeline, tb[P4TC_TABLE_NAME], tbl_id,
+					 extack);
+	if (IS_ERR(table))
+		return PTR_ERR(table);
+
+	if (_tcf_table_fill_nlmsg(skb, table) < 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for table");
+		return -EINVAL;
+	}
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = _tcf_table_put(net, tb, pipeline, table, extack);
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
+static int tcf_table_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			  struct nlattr *nla, char **p_name, u32 *ids,
+			  struct netlink_ext_ack *extack)
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
+	return tcf_p4_tmpl_generic_dump(skb, ctx, &pipeline->p_tbl_idr,
+					P4TC_TBLID_IDX, extack);
+}
+
+static int tcf_table_dump_1(struct sk_buff *skb,
+			    struct p4tc_template_common *common)
+{
+	struct nlattr *nest = nla_nest_start(skb, P4TC_PARAMS);
+	struct p4tc_table *table = to_table(common);
+
+	if (!nest)
+		return -ENOMEM;
+
+	if (nla_put_string(skb, P4TC_TABLE_NAME, table->common.name)) {
+		nla_nest_cancel(skb, nest);
+		return -ENOMEM;
+	}
+
+	nla_nest_end(skb, nest);
+
+	return 0;
+}
+
+const struct p4tc_template_ops p4tc_table_ops = {
+	.init = NULL,
+	.cu = tcf_table_cu,
+	.fill_nlmsg = tcf_table_fill_nlmsg,
+	.gd = tcf_table_gd,
+	.put = tcf_table_put,
+	.dump = tcf_table_dump,
+	.dump_1 = tcf_table_dump_1,
+};
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index 042a540a6..117828baf 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -44,6 +44,7 @@ static bool obj_is_valid(u32 obj)
 	case P4TC_OBJ_PIPELINE:
 	case P4TC_OBJ_HDR_FIELD:
 	case P4TC_OBJ_ACT:
+	case P4TC_OBJ_TABLE:
 		return true;
 	default:
 		return false;
@@ -54,6 +55,7 @@ static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX] = {
 	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
 	[P4TC_OBJ_HDR_FIELD] = &p4tc_hdrfield_ops,
 	[P4TC_OBJ_ACT] = &p4tc_act_ops,
+	[P4TC_OBJ_TABLE] = &p4tc_table_ops,
 };
 
 int tcf_p4_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
-- 
2.34.1


