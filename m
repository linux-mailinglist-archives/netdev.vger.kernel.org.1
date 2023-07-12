Return-Path: <netdev+bounces-17213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121D6750CEE
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B181C211B7
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 15:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE024190;
	Wed, 12 Jul 2023 15:40:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60514F8D
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 15:40:31 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77DF51BFA
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:21 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-635fa79d7c0so4133106d6.1
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1689176419; x=1691768419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVUTLHnDiN6RX5T3ojEfvOR8aQbSJ9QSzO9kJqWAO94=;
        b=VEvaD56VsBVYDMArAncOCWMcYX4CbgnshGo/ytH0zWHXtW9mqY7KGMIsSGBhUoWFkH
         cPHGHJSRxlVlapYLGe7vl2C+oTYJLWlF5Kj9Fduf+IGglFMZ9bWV/Ls4hGKGvyj2npxX
         58V/ArTOnKJJCAi37qnVicUhq4KEwyZ2hcpLYXDE9q0V8nfYzK1pxf8mUjq6t5YhU0as
         xCTEv4dS0vIRFHjEty0613L5B/qNAl0kW8mds1Mu08960XCKtDiR65GPr6d2v/FpMxxf
         pgD1Y02TWecX1DRxOmw/+ou8ZlRddUK3mvOZ4zRcu0DYXK7iOoY0vfNbFnCDppF+JMHI
         r6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176419; x=1691768419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVUTLHnDiN6RX5T3ojEfvOR8aQbSJ9QSzO9kJqWAO94=;
        b=i5iPxI4UbUMhUeTESQGHsI1NUFJD4VzLVDafR1ZAOHLnXG3ZKLwDjLmNUVeG5ntEwx
         vPUBImISHYzgTwVPclJhfHFDklqygBvM8QgSL+4btCmLQKywX0tcoW256uWNg9IXUzbz
         yIMFxdPE52ip6hKlPBGKHFbVoTW75W68i6n0YEUnjK7K1+jIqn+0lstY93s3tauMxQlA
         /VN3sxsudpL0TBFJYvOG716gvRgUf1jcF6AGCFtY5Y7gsOPxVT3rQ+iGBj2JI76Qp/8/
         8Nkqp+BndnvVTSLLVUhV+ygsCDL3YIvMvya+0CoY0zoiWI9F7Co9ja69EUl3KsFpLtKp
         wSAw==
X-Gm-Message-State: ABy/qLbCjwpEthbSnLIlEMT+vsBUpPCsnpt1VTL5nno/ADf5KXGdwHh5
	sOBbOS6t/Ws0CXpM5YlmUqLzm5KxhOyHUHwczdoqlg==
X-Google-Smtp-Source: APBJJlEEv40zEtU5XjEn8lJLIBzGrLyXwJv/9WKTbXFdvPWkAb8+g/3L9FYLyquRD9n6dtUN8t1yNA==
X-Received: by 2002:a0c:e40b:0:b0:636:1d3f:3d77 with SMTP id o11-20020a0ce40b000000b006361d3f3d77mr2328487qvl.14.1689176418790;
        Wed, 12 Jul 2023 08:40:18 -0700 (PDT)
Received: from majuu.waya ([142.114.148.137])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2283827qvk.14.2023.07.12.08.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 08:40:17 -0700 (PDT)
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
Subject: [PATCH RFC v4 net-next 13/22] p4tc: add table entry create, update, get, delete, flush and dump
Date: Wed, 12 Jul 2023 11:39:40 -0400
Message-Id: <20230712153949.6894-14-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712153949.6894-1-jhs@mojatatu.com>
References: <20230712153949.6894-1-jhs@mojatatu.com>
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

Tables are conceptually similar to TCAMs and this implementation could be
labelled as an "algorithmic" TCAM. Tables have a key of a specific size,
maximum number of entries and masks allowed. The basic P4 key types
are supported (exact, LPM, ternary, and ranges) although the kernel side is
oblivious of all that and sees only bit blobs which it masks before a
lookup is performed.

This commit allows users to create, update, delete, get, flush and dump
table _entries_ (templates were described in earlier patch).

For example, a user issuing the following command:

tc p4runtime create myprog/table/cb/tname  \
  dstAddr 10.10.10.0/24 srcAddr 192.168.0.0/16 prio 16 \
  action send param port port1

indicates we are creating a table entry in table "tname" on a pipeline
named "myprog"

User space tc will create a key which has a value of 0x0a0a0a00c0a00000
(10.10.10.0 concatenated with 192.168.0.0) and a mask value of
0xffffff00ffff0000 (/24 concatenated with /16) that will be sent to the
kernel. In addition a priority field of 16 is passed to the kernel as
well as the action definition.
The priority field is needed to disambiguate in case two entries
match. In that case, the kernel will choose the one with lowest priority
number.

Note that table entries can only be created once the pipeline template is
sealed.

If the user wanted to, for example, add an action to our just created
entry, they'd issue the following command:

tc p4runtime update myprog/table/cb/tname srcAddr 10.10.10.0/24 \
  dstAddr 192.168.0.0/16 prio 16 action send param port port5

In this case, the user needs to specify the pipeline name, the table name,
the key and the priority, so that we can locate the table entry.

If the user wanted to, for example, get the table entry that we just
updated, they'd issue the following command:

tc p4runtime get myprog/table/cb/tname srcAddr 10.10.10.0/24 \
  dstAddr 192.168.0.0/16 prio 16

Note that, again, we need to specify the pipeline name, the table name,
the key and the priority, so that we can locate the table entry.

If the user wanted to delete the table entry we created, they'd issue the
following command:

tc p4runtime del myprog/table/cb/tname srcAddr 10.10.10.0/24 \
  dstAddr 192.168.0.0/16 prio 16

Note that, again, we need to specify the pipeline name, the table
name, the key and the priority, so that we can
locate the table entry.

We can also flush all the table entries from a specific table.
To flush the table entries of table tname ane pipeline ptables,
the user would issue the following command:

tc p4runtime del myprog/table/cb/tname

We can also dump all the table entries from a specific table .
To dump the table entries of table tname and pipeline myprog, the user
would issue the following command:

tc p4runtime get myprog/table/cb/tname

__Table Entry Permissions__

Table entries can have permissions specified when they are being added.
Caveat: we are doing a lot more than what P4 defines because we feel it is
necessary.

Table entry permissions build on the table permissions provided when a
table is created via the template (see earlier patch).

We have two types of permissions: Control path vs datapath.
The template definition can set either one. For example, one could allow
for adding table entries by the datapath in case of PNA add-on-miss is
needed. By default tables entries have control plane RUD, meaning the
control plane can Read, Update or Delete entries. By default, as well,
the control plane can create new entries unless specified otherwise by
the template.

Lets see an example of defining a table "tname" at template time:

tc p4template create table/ptables/cb/tname tblid 1 keysz 64 \
  permissions 0x3C9 ...

Above is setting the table tname's permission to be 0x3C9 is equivalent to
CRUD--R--X meaning:

The control plane can Create, Read, Update, Delete
The datapath can only Read and Execute table entries.
If one was to dump this table with:

tc p4template get table/ptables/cb/tname

The output would be the following:

pipeline name ptables id 22
table id 1
table name cb/tname
key_sz 64
max entries 256
masks 8
table entries 0
permissions CRUD--R--X

The expressed permissions above are probably the most practical for most
use cases.

__Constant Tables And P4-programmed Defined Entries__

If one wanted to restrict the table to be an equivalent to a "const" then
the permissions would be set to be: -R----R--X

In such a case, typically the P4 program will have some entries defined
(see the famous P4 calc example). The "initial entries" specified in the P4
program will have to be added by the template (as generated by the
compiler), as such:

tc p4template update table/ptables/cb/tname \
  entry srcAddr 10.10.10.10/24 dstAddr 1.1.1.0/24 prio 17

This table cannot be updated at runtime. Any attempt to add an entry of a
table which is read-only at runtime will get a permission denied response
back from the kernel.

Note: If one was to create an equivalent for PNA add-on-miss feature for
this table, then the template would issue table permissions as: -R---CR--X
PNA doesn't specify whether the datapath can also delete or update entries,
but if it did then more appropriate permissions will be: -R----XCRUDX

__Mix And Match of RW vs Constant Entries__
Lets look at other scenarios; lets say the table has CRUD--R--X permissions
as defined by the template...
At runtime the user could add entries which are "const" - by specifying the
entry's permission as -R---R--X example:

tc p4runtime create ptables/table/cb/tname srcAddr 10.10.10.10/24 \
  dstAddr 1.1.1.0/24 prio 17 permissions 0x109 action drop

or not specify permissions at all as such:

tc p4runtime create ptables/table/cb/tname srcAddr 10.10.10.10/24 \
  dstAddr 1.1.1.0/24 prio 17 \
  action drop

in which case the table's permissions defined at template time( CRUD--R--X)
are assumed; meaning the table entry can be deleted or updated by the
control plane.

__Entries permissions Allowed On A Table Entry Creation At Runtime__

When an entry is added with expressed permissions it has at most to have
what the template table definition expressed but could ask for less
permission. For example, assuming a table with templated specified
permissions of CR-D--R--X:
An entry created at runtime with permission of -R----R--X is allowed but an
entry with -RUD--R--X will be rejected.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h                |   88 +-
 include/uapi/linux/p4tc.h         |   44 +-
 include/uapi/linux/rtnetlink.h    |    7 +
 net/sched/p4tc/Makefile           |    3 +-
 net/sched/p4tc/p4tc_pipeline.c    |    1 +
 net/sched/p4tc/p4tc_runtime_api.c |  139 ++
 net/sched/p4tc/p4tc_table.c       |   52 +-
 net/sched/p4tc/p4tc_tbl_entry.c   | 2044 +++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_tmpl_api.c    |    4 +-
 security/selinux/nlmsgtab.c       |    5 +-
 10 files changed, 2378 insertions(+), 9 deletions(-)
 create mode 100644 net/sched/p4tc/p4tc_runtime_api.c
 create mode 100644 net/sched/p4tc/p4tc_tbl_entry.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 27a82b8eb..ca2df3530 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -145,6 +145,8 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 
 #define P4TC_PERMISSIONS_UNINIT (1 << P4TC_PERM_MAX_BIT)
 
+#define P4TC_MAX_PARAM_DATA_SIZE 124
+
 struct p4tc_table_defact {
 	struct tc_action **default_acts;
 	/* Will have 2 5 bits blocks containing CRUDX (Create, read, update,
@@ -165,8 +167,9 @@ struct p4tc_table {
 	struct p4tc_template_common         common;
 	struct list_head                    tbl_acts_list;
 	struct idr                          tbl_masks_idr;
-	struct idr                          tbl_prio_idr;
+	struct ida                          tbl_prio_idr;
 	struct rhltable                     tbl_entries;
+	struct p4tc_table_entry             *tbl_const_entry;
 	struct p4tc_table_defact __rcu      *tbl_default_hitact;
 	struct p4tc_table_defact __rcu      *tbl_default_missact;
 	struct p4tc_table_perm __rcu        *tbl_permissions;
@@ -178,8 +181,10 @@ struct p4tc_table {
 	u32                                 tbl_max_entries;
 	u32                                 tbl_max_masks;
 	u32                                 tbl_curr_num_masks;
+	refcount_t                          tbl_entries_ref;
 	refcount_t                          tbl_ctrl_ref;
 	u16                                 tbl_type;
+	u16                                 PAD0;
 };
 
 extern const struct p4tc_template_ops p4tc_table_ops;
@@ -234,6 +239,71 @@ struct p4tc_table_act {
 
 extern const struct p4tc_template_ops p4tc_act_ops;
 
+extern const struct rhashtable_params entry_hlt_params;
+
+struct p4tc_table_entry;
+struct p4tc_table_entry_work {
+	struct work_struct   work;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+};
+
+struct p4tc_table_entry_key {
+	u32 keysz;
+	/* Key start */
+	u32 maskid;
+	unsigned char fa_key[] __aligned(8);
+};
+
+struct p4tc_table_entry_value {
+	u32                              prio;
+	int                              num_acts;
+	struct tc_action                 **acts;
+	refcount_t                       entries_ref;
+	u32                              permissions;
+	struct p4tc_table_entry_tm __rcu *tm;
+	struct p4tc_table_entry_work     *entry_work;
+};
+
+struct p4tc_table_entry_mask {
+	struct rcu_head	 rcu;
+	u32              sz;
+	u32              mask_index;
+	refcount_t       mask_ref;
+	u32              mask_id;
+	unsigned char fa_value[] __aligned(8);
+};
+
+struct p4tc_table_entry {
+	struct rcu_head rcu;
+	struct rhlist_head ht_node;
+	struct p4tc_table_entry_key key;
+	/* fallthrough: key data + value */
+};
+
+#define P4TC_KEYSZ_BYTES(bits) (round_up(BITS_TO_BYTES(bits), 8))
+
+static inline void *p4tc_table_entry_value(struct p4tc_table_entry *entry)
+{
+	return entry->key.fa_key + P4TC_KEYSZ_BYTES(entry->key.keysz);
+}
+
+static inline struct p4tc_table_entry_work *
+p4tc_table_entry_work(struct p4tc_table_entry *entry)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	return value->entry_work;
+}
+
+extern const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1];
+extern const struct nla_policy p4tc_policy[P4TC_MAX + 1];
+
+int __tcf_table_entry_del(struct p4tc_pipeline *pipeline,
+			  struct p4tc_table *table,
+			  struct p4tc_table_entry_key *key,
+			  struct p4tc_table_entry_mask *mask, u32 prio);
+
 struct p4tc_parser {
 	char parser_name[PARSERNAMSIZ];
 	struct idr hdr_fields_idr;
@@ -329,6 +399,22 @@ struct p4tc_table *tcf_table_find_get(struct p4tc_pipeline *pipeline,
 				      struct netlink_ext_ack *extack);
 void tcf_table_put_ref(struct p4tc_table *table);
 
+void tcf_table_entry_destroy_hash(void *ptr, void *arg);
+
+struct p4tc_table_entry *
+tcf_table_const_entry_cu(struct net *net, struct nlattr *arg,
+			 struct p4tc_pipeline *pipeline,
+			 struct p4tc_table *table,
+			 struct netlink_ext_ack *extack);
+int p4tc_tbl_entry_doit(struct net *net, struct sk_buff *skb,
+			struct nlmsghdr *n, int cmd,
+			struct netlink_ext_ack *extack);
+int p4tc_tbl_entry_dumpit(struct net *net, struct sk_buff *skb,
+			  struct netlink_callback *cb,
+			  struct nlattr *arg, char *p_name);
+int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
+			struct p4tc_table_entry *entry, u32 tbl_id);
+
 struct p4tc_parser *tcf_parser_create(struct p4tc_pipeline *pipeline,
 				      const char *parser_name,
 				      u32 parser_inst_id,
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 295c33f18..e020a4cf7 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -125,6 +125,14 @@ enum {
 };
 #define P4TC_OBJ_MAX __P4TC_OBJ_MAX
 
+/* P4 runtime Object types */
+enum {
+	P4TC_OBJ_RUNTIME_UNSPEC,
+	P4TC_OBJ_RUNTIME_TABLE,
+	__P4TC_OBJ_RUNTIME_MAX,
+};
+#define P4TC_OBJ_RUNTIMEMAX __P4TC_OBJ_RUNTIMEMAX
+
 /* P4 attributes */
 enum {
 	P4TC_UNSPEC,
@@ -204,7 +212,7 @@ enum {
 	P4TC_TABLE_INFO, /* struct tc_p4_table_type_parm */
 	P4TC_TABLE_DEFAULT_HIT, /* nested default hit action attributes */
 	P4TC_TABLE_DEFAULT_MISS, /* nested default miss action attributes */
-	P4TC_TABLE_OPT_ENTRY, /* nested const table entry*/
+	P4TC_TABLE_CONST_ENTRY, /* nested const table entry*/
 	P4TC_TABLE_ACTS_LIST, /* nested table actions list */
 	__P4TC_TABLE_MAX
 };
@@ -263,6 +271,40 @@ struct tc_act_dyna {
 	tc_gen;
 };
 
+struct p4tc_table_entry_tm {
+	__u64 created;
+	__u64 lastused;
+	__u64 firstused;
+	__u16 who_created;
+	__u16 who_updated;
+	__u16 permissions;
+};
+
+/* Table entry attributes */
+enum {
+	P4TC_ENTRY_UNSPEC,
+	P4TC_ENTRY_TBLNAME, /* string */
+	P4TC_ENTRY_KEY_BLOB, /* Key blob */
+	P4TC_ENTRY_MASK_BLOB, /* Mask blob */
+	P4TC_ENTRY_PRIO, /* u32 */
+	P4TC_ENTRY_ACT, /* nested actions */
+	P4TC_ENTRY_TM, /* entry data path timestamps */
+	P4TC_ENTRY_WHODUNNIT, /* tells who's modifying the entry */
+	P4TC_ENTRY_CREATE_WHODUNNIT, /* tells who created the entry */
+	P4TC_ENTRY_UPDATE_WHODUNNIT, /* tells who updated the entry last */
+	P4TC_ENTRY_PERMISSIONS, /* entry CRUDX permissions */
+	P4TC_ENTRY_PAD,
+	__P4TC_ENTRY_MAX
+};
+#define P4TC_ENTRY_MAX (__P4TC_ENTRY_MAX - 1)
+
+enum {
+	P4TC_ENTITY_UNSPEC,
+	P4TC_ENTITY_KERNEL,
+	P4TC_ENTITY_TC,
+	P4TC_ENTITY_MAX
+};
+
 #define P4TC_RTA(r) \
 	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
 
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 41a4046e7..c06fe3d8f 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -201,6 +201,13 @@ enum {
 	RTM_GETP4TEMPLATE,
 #define RTM_GETP4TEMPLATE	RTM_GETP4TEMPLATE
 
+	RTM_P4TC_CREATE = 128,
+#define RTM_P4TC_CREATE	RTM_P4TC_CREATE
+	RTM_P4TC_DEL,
+#define RTM_P4TC_DEL		RTM_P4TC_DEL
+	RTM_P4TC_GET,
+#define RTM_P4TC_GET		RTM_P4TC_GET
+
 	__RTM_MAX,
 #define RTM_MAX		(((__RTM_MAX + 3) & ~3) - 1)
 };
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 182ad141b..c9e2555a8 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
-	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o
+	p4tc_parser_api.o p4tc_hdrfield.o p4tc_action.o p4tc_table.o \
+	p4tc_tbl_entry.o p4tc_runtime_api.o
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 437c48989..464b150e0 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -276,6 +276,7 @@ static struct p4tc_pipeline *tcf_pipeline_create(struct net *net,
 	pipeline->net = net;
 
 	refcount_set(&pipeline->p_ctrl_ref, 1);
+	refcount_set(&pipeline->p_hdrs_used, 1);
 
 	pipeline->common.ops = (struct p4tc_template_ops *)&p4tc_pipeline_ops;
 
diff --git a/net/sched/p4tc/p4tc_runtime_api.c b/net/sched/p4tc/p4tc_runtime_api.c
new file mode 100644
index 000000000..b0a7a08fb
--- /dev/null
+++ b/net/sched/p4tc/p4tc_runtime_api.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_runtime_api.c P4 TC RUNTIME API
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
+static int tc_ctl_p4_root(struct sk_buff *skb, struct nlmsghdr *n, int cmd,
+			  struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+
+	switch (t->obj) {
+	case P4TC_OBJ_RUNTIME_TABLE: {
+		struct net *net = sock_net(skb->sk);
+
+		net = maybe_get_net(net);
+		if (!net) {
+			NL_SET_ERR_MSG(extack, "Net namespace is going down");
+			return -EBUSY;
+		}
+
+		return p4tc_tbl_entry_doit(net, skb, n, cmd, extack);
+	}
+	default:
+		NL_SET_ERR_MSG(extack, "Unknown P4 runtime object type");
+		return -EOPNOTSUPP;
+	}
+}
+
+static int tc_ctl_p4_get(struct sk_buff *skb, struct nlmsghdr *n,
+			 struct netlink_ext_ack *extack)
+{
+	return tc_ctl_p4_root(skb, n, RTM_P4TC_GET, extack);
+}
+
+static int tc_ctl_p4_delete(struct sk_buff *skb, struct nlmsghdr *n,
+			    struct netlink_ext_ack *extack)
+{
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	return tc_ctl_p4_root(skb, n, RTM_P4TC_DEL, extack);
+}
+
+static int tc_ctl_p4_cu(struct sk_buff *skb, struct nlmsghdr *n,
+			struct netlink_ext_ack *extack)
+{
+	int ret;
+
+	if (!netlink_capable(skb, CAP_NET_ADMIN))
+		return -EPERM;
+
+	ret = tc_ctl_p4_root(skb, n, RTM_P4TC_CREATE, extack);
+
+	return ret;
+}
+
+static int tc_ctl_p4_dump(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	struct p4tcmsg *t;
+	int ret = 0;
+
+	ret = nlmsg_parse(cb->nlh, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, cb->extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(cb->extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(cb->extack,
+			       "Netlink P4TC Runtime attributes missing");
+		return -EINVAL;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	t = nlmsg_data(cb->nlh);
+
+	switch (t->obj) {
+	case P4TC_OBJ_RUNTIME_TABLE: {
+		struct net *net = sock_net(skb->sk);
+
+		net = maybe_get_net(net);
+		if (!net) {
+			NL_SET_ERR_MSG(cb->extack,
+				       "Net namespace is going down");
+			return -EBUSY;
+		}
+
+		return p4tc_tbl_entry_dumpit(net, skb, cb, tb[P4TC_ROOT],
+					     p_name);
+	}
+	default:
+		NL_SET_ERR_MSG_FMT(cb->extack,
+				   "Unknown p4 runtime object type %u\n",
+				   t->obj);
+		return -ENOENT;
+	}
+}
+
+static int __init p4tc_tbl_init(void)
+{
+	rtnl_register(PF_UNSPEC, RTM_P4TC_CREATE, tc_ctl_p4_cu, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_DEL, tc_ctl_p4_delete, NULL,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+	rtnl_register(PF_UNSPEC, RTM_P4TC_GET, tc_ctl_p4_get, tc_ctl_p4_dump,
+		      RTNL_FLAG_DOIT_UNLOCKED);
+
+	return 0;
+}
+
+subsys_initcall(p4tc_tbl_init);
diff --git a/net/sched/p4tc/p4tc_table.c b/net/sched/p4tc/p4tc_table.c
index e8feb57bd..78c78c842 100644
--- a/net/sched/p4tc/p4tc_table.c
+++ b/net/sched/p4tc/p4tc_table.c
@@ -103,7 +103,7 @@ static const struct nla_policy p4tc_table_policy[P4TC_TABLE_MAX + 1] = {
 	[P4TC_TABLE_DEFAULT_HIT] = { .type = NLA_NESTED },
 	[P4TC_TABLE_DEFAULT_MISS] = { .type = NLA_NESTED },
 	[P4TC_TABLE_ACTS_LIST] = { .type = NLA_NESTED },
-	[P4TC_TABLE_OPT_ENTRY] = { .type = NLA_NESTED },
+	[P4TC_TABLE_CONST_ENTRY] = { .type = NLA_NESTED },
 };
 
 static int _tcf_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
@@ -132,6 +132,7 @@ static int _tcf_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 	parm.tbl_keysz = table->tbl_keysz;
 	parm.tbl_max_entries = table->tbl_max_entries;
 	parm.tbl_max_masks = table->tbl_max_masks;
+	parm.tbl_num_entries = refcount_read(&table->tbl_entries_ref) - 1;
 
 	tbl_perm = rcu_dereference_rtnl(table->tbl_permissions);
 	parm.tbl_permissions = tbl_perm->permissions;
@@ -203,6 +204,16 @@ static int _tcf_table_fill_nlmsg(struct sk_buff *skb, struct p4tc_table *table)
 	}
 	nla_nest_end(skb, nested_tbl_acts);
 
+	if (table->tbl_const_entry) {
+		struct nlattr *const_nest;
+
+		const_nest = nla_nest_start(skb, P4TC_TABLE_CONST_ENTRY);
+		p4tc_tbl_entry_fill(skb, table, table->tbl_const_entry,
+				    table->tbl_id);
+		nla_nest_end(skb, const_nest);
+	}
+	table->tbl_const_entry = NULL;
+
 	if (nla_put(skb, P4TC_TABLE_INFO, sizeof(parm), &parm))
 		goto out_nlmsg_trim;
 	nla_nest_end(skb, nest);
@@ -328,8 +339,11 @@ static inline int _tcf_table_put(struct net *net, struct nlattr **tb,
 
 	tcf_table_acts_list_destroy(&table->tbl_acts_list);
 
+	rhltable_free_and_destroy(&table->tbl_entries,
+				  tcf_table_entry_destroy_hash, table);
+
 	idr_destroy(&table->tbl_masks_idr);
-	idr_destroy(&table->tbl_prio_idr);
+	ida_destroy(&table->tbl_prio_idr);
 
 	perm = rcu_replace_pointer_rtnl(table->tbl_permissions, NULL);
 	kfree_rcu(perm, rcu);
@@ -729,6 +743,7 @@ static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
 					   struct p4tc_pipeline *pipeline,
 					   struct netlink_ext_ack *extack)
 {
+	struct rhashtable_params table_hlt_params = entry_hlt_params;
 	struct p4tc_table_parm *parm;
 	struct p4tc_table *table;
 	char *tblname;
@@ -926,15 +941,31 @@ static struct p4tc_table *tcf_table_create(struct net *net, struct nlattr **tb,
 		goto idr_rm;
 
 	idr_init(&table->tbl_masks_idr);
-	idr_init(&table->tbl_prio_idr);
+	ida_init(&table->tbl_prio_idr);
 	spin_lock_init(&table->tbl_masks_idr_lock);
 
+	table_hlt_params.max_size = table->tbl_max_entries;
+	if (table->tbl_max_entries > U16_MAX)
+		table_hlt_params.nelem_hint = U16_MAX / 4 * 3;
+	else
+		table_hlt_params.nelem_hint = table->tbl_max_entries / 4 * 3;
+
+	if (rhltable_init(&table->tbl_entries, &table_hlt_params) < 0) {
+		ret = -EINVAL;
+		goto defaultacts_destroy;
+	}
+
 	pipeline->curr_tables += 1;
 
 	table->common.ops = (struct p4tc_template_ops *)&p4tc_table_ops;
+	refcount_set(&table->tbl_entries_ref, 1);
 
 	return table;
 
+defaultacts_destroy:
+	p4tc_table_defact_destroy(table->tbl_default_missact);
+	p4tc_table_defact_destroy(table->tbl_default_hitact);
+
 idr_rm:
 	idr_remove(&pipeline->p_tbl_idr, table->tbl_id);
 
@@ -1083,6 +1114,21 @@ static struct p4tc_table *tcf_table_update(struct net *net, struct nlattr **tb,
 		}
 	}
 
+	if (tb[P4TC_TABLE_CONST_ENTRY]) {
+		struct p4tc_table_entry *entry;
+
+		/* Workaround to make this work */
+		entry = tcf_table_const_entry_cu(net,
+						 tb[P4TC_TABLE_CONST_ENTRY],
+						 pipeline, table, extack);
+		if (IS_ERR(entry)) {
+			ret = PTR_ERR(entry);
+			goto free_perm;
+		}
+
+		table->tbl_const_entry = entry;
+	}
+
 	if (default_hitact) {
 		struct p4tc_table_defact *hitact;
 
diff --git a/net/sched/p4tc/p4tc_tbl_entry.c b/net/sched/p4tc/p4tc_tbl_entry.c
new file mode 100644
index 000000000..5b6ef1efd
--- /dev/null
+++ b/net/sched/p4tc/p4tc_tbl_entry.c
@@ -0,0 +1,2044 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_tbl_api.c TC P4 TABLE API
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
+#define SIZEOF_MASKID (sizeof(((struct p4tc_table_entry_key *)0)->maskid))
+
+#define STARTOF_KEY(key) (&((key)->maskid))
+
+static u32 p4tc_entry_hash_fn(const void *data, u32 len, u32 seed)
+{
+	const struct p4tc_table_entry_key *key = data;
+	u32 keysz;
+
+	/* The key memory area is always zero allocated aligned to 8 */
+	keysz = round_up(SIZEOF_MASKID + (key->keysz >> 3), 4);
+
+	return jhash2(STARTOF_KEY(key), keysz / sizeof(u32), seed);
+}
+
+static int p4tc_entry_hash_cmp(struct rhashtable_compare_arg *arg,
+			       const void *ptr)
+{
+	const struct p4tc_table_entry_key *key = arg->key;
+	const struct p4tc_table_entry *entry = ptr;
+	u32 keysz;
+
+	keysz = SIZEOF_MASKID + (entry->key.keysz >> 3);
+
+	return memcmp(STARTOF_KEY(&entry->key), STARTOF_KEY(key), keysz);
+}
+
+static u32 p4tc_entry_obj_hash_fn(const void *data, u32 len, u32 seed)
+{
+	const struct p4tc_table_entry *entry = data;
+
+	return p4tc_entry_hash_fn(&entry->key, len, seed);
+}
+
+const struct rhashtable_params entry_hlt_params = {
+	.obj_cmpfn = p4tc_entry_hash_cmp,
+	.obj_hashfn = p4tc_entry_obj_hash_fn,
+	.hashfn = p4tc_entry_hash_fn,
+	.head_offset = offsetof(struct p4tc_table_entry, ht_node),
+	.key_offset = offsetof(struct p4tc_table_entry, key),
+	.automatic_shrinking = true,
+};
+
+static struct p4tc_table_entry *
+p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key,
+		  u32 prio) __must_hold(RCU)
+{
+	struct rhlist_head *tmp, *bucket_list;
+	struct p4tc_table_entry *entry;
+
+	bucket_list =
+		rhltable_lookup(&table->tbl_entries, key, entry_hlt_params);
+	if (!bucket_list)
+		return NULL;
+
+	rhl_for_each_entry_rcu(entry, tmp, bucket_list, ht_node) {
+		struct p4tc_table_entry_value *value =
+			p4tc_table_entry_value(entry);
+
+		if (value->prio == prio)
+			return entry;
+	}
+
+	return NULL;
+}
+
+static struct p4tc_table_entry *
+__p4tc_entry_lookup(struct p4tc_table *table, struct p4tc_table_entry_key *key)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry *entry = NULL;
+	struct rhlist_head *tmp, *bucket_list;
+	struct p4tc_table_entry *entry_curr;
+	u32 smallest_prio = U32_MAX;
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
+	const struct p4tc_table_entry_mask **masks_array;
+	struct p4tc_table_entry *entry = NULL;
+	u32 smallest_prio = U32_MAX;
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
+#define tcf_table_entry_mask_find_byid(table, id) \
+	(idr_find(&(table)->tbl_masks_idr, id))
+
+static void gen_exact_mask(u8 *mask, u32 mask_size)
+{
+	int i;
+
+	for (i = 0; i < mask_size; i++)
+		mask[i] = 0xFF;
+}
+
+static int p4tca_table_get_entry_keys(struct sk_buff *skb,
+				      struct p4tc_table *table,
+				      struct p4tc_table_entry *entry)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_table_entry_mask *mask;
+	int ret = -ENOMEM;
+	u32 key_sz_bytes;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT) {
+		u8 mask_value[BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+
+		key_sz_bytes = BITS_TO_BYTES(entry->key.keysz);
+		if (nla_put(skb, P4TC_ENTRY_KEY_BLOB, key_sz_bytes,
+			    entry->key.fa_key))
+			goto out_nlmsg_trim;
+
+		gen_exact_mask(mask_value, key_sz_bytes);
+		if (nla_put(skb, P4TC_ENTRY_MASK_BLOB, key_sz_bytes, mask_value))
+			goto out_nlmsg_trim;
+	} else {
+		key_sz_bytes = BITS_TO_BYTES(entry->key.keysz);
+		if (nla_put(skb, P4TC_ENTRY_KEY_BLOB, key_sz_bytes,
+			    entry->key.fa_key))
+			goto out_nlmsg_trim;
+
+		mask = tcf_table_entry_mask_find_byid(table, entry->key.maskid);
+		if (nla_put(skb, P4TC_ENTRY_MASK_BLOB, key_sz_bytes,
+			    mask->fa_value))
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
+static void p4tc_table_entry_tm_dump(struct p4tc_table_entry_tm *dtm,
+				     struct p4tc_table_entry_tm *stm)
+{
+	unsigned long now = jiffies;
+
+	dtm->created = stm->created ?
+		jiffies_to_clock_t(now - stm->created) : 0;
+	dtm->lastused = stm->lastused ?
+		jiffies_to_clock_t(now - stm->lastused) : 0;
+	dtm->firstused = stm->firstused ?
+		jiffies_to_clock_t(now - stm->firstused) : 0;
+}
+
+#define P4TC_ENTRY_MAX_IDS (P4TC_PATH_MAX - 1)
+
+int p4tc_tbl_entry_fill(struct sk_buff *skb, struct p4tc_table *table,
+			struct p4tc_table_entry *entry, u32 tbl_id)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_tm dtm, *tm;
+	struct nlattr *nest, *nest_acts;
+	u32 ids[P4TC_ENTRY_MAX_IDS];
+	int ret = -ENOMEM;
+
+	ids[P4TC_TBLID_IDX - 1] = tbl_id;
+
+	if (nla_put(skb, P4TC_PATH, P4TC_ENTRY_MAX_IDS * sizeof(u32), ids))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	value = p4tc_table_entry_value(entry);
+
+	if (nla_put_u32(skb, P4TC_ENTRY_PRIO, value->prio))
+		goto out_nlmsg_trim;
+
+	if (p4tca_table_get_entry_keys(skb, table, entry) < 0)
+		goto out_nlmsg_trim;
+
+	if (value->acts) {
+		nest_acts = nla_nest_start(skb, P4TC_ENTRY_ACT);
+		if (tcf_action_dump(skb, value->acts, 0, 0, false) < 0)
+			goto out_nlmsg_trim;
+		nla_nest_end(skb, nest_acts);
+	}
+
+	if (nla_put_u16(skb, P4TC_ENTRY_PERMISSIONS, value->permissions))
+		goto out_nlmsg_trim;
+
+	tm = rtnl_dereference(value->tm);
+
+	if (nla_put_u8(skb, P4TC_ENTRY_CREATE_WHODUNNIT, tm->who_created))
+		goto out_nlmsg_trim;
+
+	if (tm->who_updated) {
+		if (nla_put_u8(skb, P4TC_ENTRY_UPDATE_WHODUNNIT,
+			       tm->who_updated))
+			goto out_nlmsg_trim;
+	}
+
+	p4tc_table_entry_tm_dump(&dtm, tm);
+	if (nla_put_64bit(skb, P4TC_ENTRY_TM, sizeof(dtm), &dtm,
+			  P4TC_ENTRY_PAD))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, nest);
+
+	return skb->len;
+
+out_nlmsg_trim:
+	nlmsg_trim(skb, b);
+	return ret;
+}
+
+static const struct nla_policy p4tc_entry_policy[P4TC_ENTRY_MAX + 1] = {
+	[P4TC_ENTRY_TBLNAME] = { .type = NLA_STRING },
+	[P4TC_ENTRY_KEY_BLOB] = { .type = NLA_BINARY },
+	[P4TC_ENTRY_MASK_BLOB] = { .type = NLA_BINARY },
+	[P4TC_ENTRY_PRIO] = { .type = NLA_U32 },
+	[P4TC_ENTRY_ACT] = { .type = NLA_NESTED },
+	[P4TC_ENTRY_TM] = { .type = NLA_BINARY,
+			    .len = sizeof(struct p4tc_table_entry_tm) },
+	[P4TC_ENTRY_WHODUNNIT] = { .type = NLA_U8 },
+	[P4TC_ENTRY_CREATE_WHODUNNIT] = { .type = NLA_U8 },
+	[P4TC_ENTRY_UPDATE_WHODUNNIT] = { .type = NLA_U8 },
+	[P4TC_ENTRY_PERMISSIONS] = NLA_POLICY_MAX(NLA_U16, P4TC_MAX_PERMISSION),
+};
+
+static struct p4tc_table_entry_mask *
+tcf_table_entry_mask_find_byvalue(struct p4tc_table *table,
+				  struct p4tc_table_entry_mask *mask)
+{
+	struct p4tc_table_entry_mask *mask_cur;
+	unsigned long mask_id, tmp;
+
+	idr_for_each_entry_ul(&table->tbl_masks_idr, mask_cur, tmp, mask_id) {
+		if (mask_cur->sz == mask->sz) {
+			u32 mask_sz_bytes = BITS_TO_BYTES(mask->sz);
+			void *curr_mask_value = mask_cur->fa_value;
+			void *mask_value = mask->fa_value;
+
+			if (memcmp(curr_mask_value, mask_value, mask_sz_bytes) == 0)
+				return mask_cur;
+		}
+	}
+
+	return NULL;
+}
+
+static void __tcf_table_entry_mask_del(struct p4tc_table *table,
+				       struct p4tc_table_entry_mask *mask)
+{
+	if (table->tbl_type == P4TC_TABLE_TYPE_TERNARY) {
+		table->tbl_masks_array[mask->mask_index] = NULL;
+		bitmap_set(table->tbl_free_masks_bitmap, mask->mask_index, 1);
+	} else if (table->tbl_type == P4TC_TABLE_TYPE_LPM) {
+		int i;
+
+		for (i = mask->mask_index; i < table->tbl_curr_num_masks - 1; i++)
+			table->tbl_masks_array[i] = table->tbl_masks_array[i + 1];
+
+		table->tbl_masks_array[table->tbl_curr_num_masks - 1] = NULL;
+	}
+
+	table->tbl_curr_num_masks--;
+}
+
+static void tcf_table_entry_mask_del(struct p4tc_table *table,
+				     struct p4tc_table_entry *entry)
+{
+	struct p4tc_table_entry_mask *mask_found;
+	const u32 mask_id = entry->key.maskid;
+
+	/* Will always be found */
+	mask_found = tcf_table_entry_mask_find_byid(table, mask_id);
+
+	/* Last reference, can delete */
+	if (refcount_dec_if_one(&mask_found->mask_ref)) {
+		spin_lock_bh(&table->tbl_masks_idr_lock);
+		idr_remove(&table->tbl_masks_idr, mask_found->mask_id);
+		__tcf_table_entry_mask_del(table, mask_found);
+		spin_unlock_bh(&table->tbl_masks_idr_lock);
+		kfree_rcu(mask_found, rcu);
+	} else {
+		if (!refcount_dec_not_one(&mask_found->mask_ref))
+			pr_warn("Mask was deleted in parallel");
+	}
+}
+
+static inline u32 p4tc_ffs(u8 *ptr, size_t len)
+{
+	int i;
+
+	for (i = 0; i < len; i++) {
+		int pos = ffs(ptr[i]);
+
+		if (pos)
+			return (i * 8) + pos;
+	}
+
+	return 0;
+}
+
+static inline u32 p4tc_fls(u8 *ptr, size_t len)
+{
+	int i;
+
+	for (i = len - 1; i >= 0; i--) {
+		int pos = fls(ptr[i]);
+
+		if (pos)
+			return (i * 8) + pos;
+	}
+
+	return 0;
+}
+
+static inline u32 find_lpm_mask(struct p4tc_table *table, u8 *ptr)
+{
+	u32 ret;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	ret = p4tc_fls(ptr, BITS_TO_BYTES(table->tbl_keysz));
+#else
+	ret = p4tc_ffs(ptr, BITS_TO_BYTES(table->tbl_keysz));
+#endif
+	return ret ?: table->tbl_keysz;
+}
+
+static inline int p4tc_table_lpm_mask_insert(struct p4tc_table *table,
+					     struct p4tc_table_entry_mask *mask)
+{
+	const u32 nmasks = table->tbl_curr_num_masks ?: 1;
+	int pos;
+
+	for (pos = 0; pos < nmasks; pos++) {
+		u32 mask_value = find_lpm_mask(table, mask->fa_value);
+
+		if (table->tbl_masks_array[pos]) {
+			u32 array_mask_value;
+
+			array_mask_value =
+				find_lpm_mask(table, table->tbl_masks_array[pos]->fa_value);
+
+			if (mask_value > array_mask_value) {
+				/* shift masks to the right (will keep invariant) */
+				u32 tail = nmasks;
+
+				while (tail > pos + 1) {
+					table->tbl_masks_array[tail] =
+						table->tbl_masks_array[tail - 1];
+					tail--;
+				}
+				table->tbl_masks_array[pos + 1] =
+					table->tbl_masks_array[pos];
+				/* assign to pos */
+				break;
+			}
+		} else {
+			/* pos is empty, assign to pos */
+			break;
+		}
+	}
+
+	mask->mask_index = pos;
+	table->tbl_masks_array[pos] = mask;
+	table->tbl_curr_num_masks++;
+
+	return 0;
+}
+
+static inline int
+p4tc_table_ternary_mask_insert(struct p4tc_table *table,
+			       struct p4tc_table_entry_mask *mask)
+{
+	unsigned long pos =
+		find_first_bit(table->tbl_free_masks_bitmap, P4TC_MAX_TMASKS);
+	if (pos == P4TC_MAX_TMASKS)
+		return -ENOSPC;
+
+	mask->mask_index = pos;
+	table->tbl_masks_array[pos] = mask;
+	bitmap_clear(table->tbl_free_masks_bitmap, pos, 1);
+	table->tbl_curr_num_masks++;
+
+	return 0;
+}
+
+static inline int p4tc_table_add_mask_array(struct p4tc_table *table,
+					    struct p4tc_table_entry_mask *mask)
+{
+	if (table->tbl_max_masks < table->tbl_curr_num_masks + 1)
+		return -ENOSPC;
+
+	switch (table->tbl_type) {
+	case P4TC_TABLE_TYPE_TERNARY:
+		return p4tc_table_ternary_mask_insert(table, mask);
+	case P4TC_TABLE_TYPE_LPM:
+		return p4tc_table_lpm_mask_insert(table, mask);
+	default:
+		return -ENOSPC;
+	}
+}
+
+/* TODO: Ordering optimisation for LPM */
+static struct p4tc_table_entry_mask *
+tcf_table_entry_mask_add(struct p4tc_table *table,
+			 struct p4tc_table_entry *entry,
+			 struct p4tc_table_entry_mask *mask)
+{
+	struct p4tc_table_entry_mask *mask_found;
+	int ret;
+
+	mask_found = tcf_table_entry_mask_find_byvalue(table, mask);
+	/* Only add mask if it was not already added */
+	if (!mask_found) {
+		struct p4tc_table_entry_mask *nmask;
+		size_t mask_sz_bytes = BITS_TO_BYTES(mask->sz);
+
+		nmask = kzalloc(struct_size(mask_found, fa_value, mask_sz_bytes), GFP_ATOMIC);
+		if (unlikely(!nmask))
+			return ERR_PTR(-ENOMEM);
+
+		memcpy(nmask->fa_value, mask->fa_value, mask_sz_bytes);
+
+		nmask->mask_id = 1;
+		nmask->sz = mask->sz;
+		refcount_set(&nmask->mask_ref, 1);
+
+		spin_lock_bh(&table->tbl_masks_idr_lock);
+		ret = idr_alloc_u32(&table->tbl_masks_idr, nmask,
+				    &nmask->mask_id, UINT_MAX, GFP_ATOMIC);
+		if (ret < 0)
+			goto unlock;
+
+		ret = p4tc_table_add_mask_array(table, nmask);
+		if (ret < 0)
+			goto unlock;
+unlock:
+		spin_unlock_bh(&table->tbl_masks_idr_lock);
+		if (ret < 0) {
+			kfree(nmask);
+			return ERR_PTR(ret);
+		}
+		entry->key.maskid = nmask->mask_id;
+		mask_found = nmask;
+	} else {
+		if (!refcount_inc_not_zero(&mask_found->mask_ref))
+			return ERR_PTR(-EBUSY);
+		entry->key.maskid = mask_found->mask_id;
+	}
+
+	return mask_found;
+}
+
+static void tcf_table_entry_del_act_work(struct work_struct *work)
+{
+	struct p4tc_table_entry_work *entry_work =
+		container_of(work, typeof(*entry_work), work);
+	struct p4tc_pipeline *pipeline = entry_work->pipeline;
+	struct p4tc_table_entry *entry = entry_work->entry;
+	struct p4tc_table_entry_value *value;
+
+	value = p4tc_table_entry_value(entry);
+	p4tc_action_destroy(value->acts);
+
+	put_net(pipeline->net);
+	tcf_pipeline_put(pipeline);
+
+	kfree(entry_work);
+	kfree(entry);
+}
+
+static void tcf_table_entry_put(struct p4tc_table_entry *entry, bool deferred)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+	struct p4tc_table_entry_work *entry_work = value->entry_work;
+	struct p4tc_table_entry_tm *tm;
+
+	tm = rcu_dereference(value->tm);
+	kfree(tm);
+
+	if (value->acts) {
+		if (deferred) {
+			/* We have to free tc actions
+			 * in a sleepable context
+			 */
+			struct p4tc_pipeline *pipeline = entry_work->pipeline;
+
+			/* Avoid pipeline del before deferral ends */
+			tcf_pipeline_get(pipeline);
+			get_net(pipeline->net); /* avoid action cleanup */
+			schedule_work(&entry_work->work);
+		} else {
+			p4tc_action_destroy(value->acts);
+			kfree(entry_work);
+			kfree(entry);
+		}
+	} else {
+		kfree(entry_work);
+		kfree(entry);
+	}
+}
+
+static void tcf_table_entry_put_rcu(struct rcu_head *rcu)
+{
+	struct p4tc_table_entry *entry =
+		container_of(rcu, struct p4tc_table_entry, rcu);
+	struct p4tc_table_entry_work *entry_work =
+		p4tc_table_entry_work(entry);
+	struct p4tc_pipeline *pipeline = entry_work->pipeline;
+
+	tcf_table_entry_put(entry, true);
+
+	tcf_pipeline_put(pipeline);
+	put_net(pipeline->net);
+}
+
+static int __tcf_table_entry_destroy(struct p4tc_table *table,
+				     struct p4tc_table_entry *entry,
+				     bool remove_from_hash)
+{
+	/* !remove_from_hash and deferred deletion are incompatible
+	 * as entries that defer deletion after a GP __must__
+	 * be removed from the hash
+	 */
+	if (remove_from_hash)
+		rhltable_remove(&table->tbl_entries, &entry->ht_node,
+				entry_hlt_params);
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		tcf_table_entry_mask_del(table, entry);
+
+	if (remove_from_hash) {
+		struct p4tc_table_entry_work *entry_work =
+			p4tc_table_entry_work(entry);
+
+		/* guarantee net doesn't go down before async task runs */
+		get_net(entry_work->pipeline->net);
+		/* guarantee pipeline isn't deleted before async task runs */
+		tcf_pipeline_get(entry_work->pipeline);
+		call_rcu(&entry->rcu, tcf_table_entry_put_rcu);
+	} else {
+		tcf_table_entry_put(entry, false);
+	}
+
+	return 0;
+}
+
+static int tcf_table_entry_destroy(struct p4tc_table *table,
+				   struct p4tc_table_entry *entry,
+				   bool remove_from_hash)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	/* Entry was deleted in parallel */
+	if (!refcount_dec_if_one(&value->entries_ref))
+		return -EBUSY;
+
+	ida_free(&table->tbl_prio_idr, value->prio);
+
+	return __tcf_table_entry_destroy(table, entry, remove_from_hash);
+}
+
+static int tcf_table_entry_destroy_noida(struct p4tc_table *table,
+					 struct p4tc_table_entry *entry)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	/* Entry was deleted in parallel */
+	if (!refcount_dec_if_one(&value->entries_ref))
+		return -EBUSY;
+
+	return __tcf_table_entry_destroy(table, entry, true);
+}
+
+/* Only deletes entries when called from pipeline put */
+void tcf_table_entry_destroy_hash(void *ptr, void *arg)
+{
+	struct p4tc_table_entry *entry = ptr;
+	struct p4tc_table *table = arg;
+
+	tcf_table_entry_destroy(table, entry, false);
+}
+
+static void tcf_table_entry_put_table(struct p4tc_pipeline *pipeline,
+				      struct p4tc_table *table)
+{
+	tcf_table_put_ref(table);
+	tcf_pipeline_put(pipeline);
+}
+
+static int tcf_table_entry_get_table(struct net *net,
+				     struct p4tc_pipeline **pipeline,
+				     struct p4tc_table **table,
+				     struct nlattr **tb, u32 *ids, char *p_name,
+				     struct netlink_ext_ack *extack)
+	__must_hold(RCU)
+{
+	/* The following can only race with user driven events
+	 * Netns is guaranteed to be alive
+	 */
+	u32 pipeid, tbl_id;
+	char *tblname;
+	int ret;
+
+	pipeid = ids[P4TC_PID_IDX];
+
+	*pipeline = tcf_pipeline_find_get(net, p_name, pipeid, extack);
+	if (IS_ERR(*pipeline)) {
+		ret = PTR_ERR(*pipeline);
+		goto out;
+	}
+
+	tbl_id = ids[P4TC_TBLID_IDX];
+	tblname = tb[P4TC_ENTRY_TBLNAME] ? nla_data(tb[P4TC_ENTRY_TBLNAME]) : NULL;
+
+	*table = tcf_table_find_get(*pipeline, tblname, tbl_id, extack);
+	if (IS_ERR(*table)) {
+		ret = PTR_ERR(*table);
+		goto put;
+	}
+
+	return 0;
+
+put:
+	tcf_pipeline_put(*pipeline);
+
+out:
+	return ret;
+}
+
+static inline void
+tcf_table_entry_assign_key_exact(struct p4tc_table_entry_key *key, u8 *keyblob)
+{
+	memcpy(key->fa_key, keyblob, BITS_TO_BYTES(key->keysz));
+}
+
+static inline void
+tcf_table_entry_assign_key_generic(struct p4tc_table_entry_key *key,
+				   struct p4tc_table_entry_mask *mask,
+				   u8 *keyblob, u8 *maskblob)
+{
+	u32 keysz = BITS_TO_BYTES(key->keysz);
+
+	memcpy(key->fa_key, keyblob, keysz);
+	memcpy(mask->fa_value, maskblob, keysz);
+}
+
+static inline void
+tcf_table_entry_assign_key(struct p4tc_table *table,
+			   struct p4tc_table_entry_key *key,
+			   struct p4tc_table_entry_mask *mask,
+			   u8 *keyblob, u8 *maskblob)
+{
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT)
+		tcf_table_entry_assign_key_exact(key, keyblob);
+	else
+		tcf_table_entry_assign_key_generic(key, mask, keyblob,
+						   maskblob);
+}
+
+static int tcf_table_entry_extract_key(struct p4tc_table *table,
+				       struct nlattr **tb,
+				       struct p4tc_table_entry_key *key,
+				       struct p4tc_table_entry_mask *mask,
+				       struct netlink_ext_ack *extack)
+{
+	u32 keysz;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ENTRY_KEY_BLOB)) {
+		NL_SET_ERR_MSG(extack, "Must specify key blobs");
+		return -EINVAL;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ENTRY_MASK_BLOB)) {
+		NL_SET_ERR_MSG(extack, "Must specify mask blobs");
+		return -EINVAL;
+	}
+
+	keysz = nla_len(tb[P4TC_ENTRY_KEY_BLOB]);
+	if (BITS_TO_BYTES(key->keysz) != keysz) {
+		NL_SET_ERR_MSG(extack,
+			       "Key blob size and table key size differ");
+		return -EINVAL;
+	}
+
+	if (keysz != nla_len(tb[P4TC_ENTRY_MASK_BLOB])) {
+		NL_SET_ERR_MSG(extack,
+			       "Key and mask blob must have the same length");
+		return -EINVAL;
+	}
+
+	tcf_table_entry_assign_key(table, key, mask,
+				   nla_data(tb[P4TC_ENTRY_KEY_BLOB]),
+				   nla_data(tb[P4TC_ENTRY_MASK_BLOB]));
+
+	return 0;
+}
+
+static void tcf_table_entry_build_key(struct p4tc_table *table,
+				      struct p4tc_table_entry_key *key,
+				      struct p4tc_table_entry_mask *mask)
+{
+	int i;
+
+	if (table->tbl_type == P4TC_TABLE_TYPE_EXACT)
+		return;
+
+	key->maskid = mask->mask_id;
+
+	for (i = 0; i < BITS_TO_BYTES(key->keysz); i++)
+		key->fa_key[i] &= mask->fa_value[i];
+}
+
+static int ___tcf_table_entry_del(struct p4tc_pipeline *pipeline,
+				  struct p4tc_table *table,
+				  struct p4tc_table_entry *entry,
+				  bool from_control)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry_value *value = p4tc_table_entry_value(entry);
+
+	if (from_control) {
+		if (!p4tc_ctrl_delete_ok(value->permissions))
+			return -EPERM;
+	} else {
+		if (!p4tc_data_delete_ok(value->permissions))
+			return -EPERM;
+	}
+
+	if (tcf_table_entry_destroy(table, entry, true) < 0)
+		return -EBUSY;
+
+	return 0;
+}
+
+/* Internal function which will be called by the data path */
+int __tcf_table_entry_del(struct p4tc_pipeline *pipeline,
+			  struct p4tc_table *table,
+			  struct p4tc_table_entry_key *key,
+			  struct p4tc_table_entry_mask *mask, u32 prio)
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
+static int tcf_table_entry_gd(struct net *net, struct sk_buff *skb, bool del,
+			      struct nlattr *arg, u32 *ids,
+			      struct p4tc_nl_pname *nl_pname,
+			      struct netlink_ext_ack *extack)
+{
+	struct p4tc_table_entry_mask *mask = NULL, *new_mask;
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_table_entry *entry = NULL;
+	struct p4tc_pipeline *pipeline = NULL;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry_key *key;
+	struct p4tc_table *table;
+	u32 keysz_bytes;
+	u32 keysz_bits;
+	u32 prio;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg, p4tc_entry_policy,
+			       extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_ENTRY_PRIO)) {
+		NL_SET_ERR_MSG(extack, "Must specify table entry priority");
+		return -EINVAL;
+	}
+	prio = nla_get_u32(tb[P4TC_ENTRY_PRIO]);
+
+	rcu_read_lock();
+	ret = tcf_table_entry_get_table(net, &pipeline, &table, tb, ids,
+					nl_pname->data, extack);
+	rcu_read_unlock();
+	if (ret < 0)
+		return ret;
+
+	if (del && !pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to delete table entry in unsealed pipeline");
+		ret = -EINVAL;
+		goto table_put;
+	}
+
+	keysz_bits = table->tbl_keysz;
+	keysz_bytes = P4TC_KEYSZ_BYTES(table->tbl_keysz);
+
+	key = kzalloc(struct_size(key, fa_key, keysz_bytes), GFP_KERNEL);
+	if (unlikely(!key)) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate key");
+		ret = -ENOMEM;
+		goto table_put;
+	}
+
+	key->keysz = keysz_bits;
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		mask = kzalloc(struct_size(mask, fa_value, keysz_bytes),
+			       GFP_KERNEL);
+		if (unlikely(!mask)) {
+			NL_SET_ERR_MSG(extack, "Failed to allocate mask");
+			ret = -ENOMEM;
+			goto free_key;
+		}
+		mask->sz = key->keysz;
+	}
+
+	ret = tcf_table_entry_extract_key(table, tb, key, mask, extack);
+	if (unlikely(ret < 0)) {
+		if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+			kfree(mask);
+
+		goto free_key;
+	}
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		new_mask = tcf_table_entry_mask_find_byvalue(table, mask);
+		kfree(mask);
+		if (!new_mask) {
+			NL_SET_ERR_MSG(extack, "Unable to find entry");
+			ret = -ENOENT;
+			goto free_key;
+		} else {
+			mask = new_mask;
+		}
+	}
+
+	tcf_table_entry_build_key(table, key, mask);
+
+	rcu_read_lock();
+	entry = p4tc_entry_lookup(table, key, prio);
+	if (!entry) {
+		NL_SET_ERR_MSG(extack, "Unable to find entry");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	value = p4tc_table_entry_value(entry);
+	if (!del) {
+		if (!p4tc_ctrl_read_ok(value->permissions)) {
+			NL_SET_ERR_MSG(extack,
+				       "Permission denied: Unable to read table entry");
+			ret = -EINVAL;
+			goto unlock;
+		}
+	}
+
+	if (skb && p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id) <= 0) {
+		NL_SET_ERR_MSG(extack, "Unable to fill table entry attributes");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	if (del) {
+		ret = ___tcf_table_entry_del(pipeline, table, entry, true);
+		if (ret < 0)
+			goto unlock;
+
+		refcount_dec(&table->tbl_entries_ref);
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	ret = 0;
+
+	goto unlock;
+
+unlock:
+	rcu_read_unlock();
+
+free_key:
+	kfree(key);
+
+table_put:
+	tcf_table_entry_put_table(pipeline, table);
+
+	return ret;
+}
+
+static int tcf_table_entry_flush(struct net *net, struct sk_buff *skb,
+				 struct nlattr *arg, u32 *ids,
+				 struct p4tc_nl_pname *nl_pname,
+				 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 arg_ids[P4TC_PATH_MAX - 1];
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+	struct rhashtable_iter iter;
+	struct p4tc_table *table;
+	int ret = 0;
+	int i = 0;
+
+	if (arg) {
+		ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg,
+				       p4tc_entry_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	rcu_read_lock();
+	ret = tcf_table_entry_get_table(net, &pipeline, &table, tb, ids,
+					nl_pname->data, extack);
+	rcu_read_unlock();
+	if (ret < 0)
+		return ret;
+
+	if (!ids[P4TC_TBLID_IDX])
+		arg_ids[P4TC_TBLID_IDX - 1] = table->tbl_id;
+
+	if (skb && nla_put(skb, P4TC_PATH, sizeof(arg_ids), arg_ids)) {
+		ret = -ENOMEM;
+		goto out_nlmsg_trim;
+	}
+
+	rhltable_walk_enter(&table->tbl_entries, &iter);
+	do {
+		rhashtable_walk_start(&iter);
+
+		while ((entry = rhashtable_walk_next(&iter)) && !IS_ERR(entry)) {
+			struct p4tc_table_entry_value *value =
+				p4tc_table_entry_value(entry);
+			if (!p4tc_ctrl_delete_ok(value->permissions)) {
+				ret = -EPERM;
+				continue;
+			}
+
+			refcount_dec(&table->tbl_entries_ref);
+
+			if (tcf_table_entry_destroy(table, entry, true) < 0) {
+				ret = -EBUSY;
+				continue;
+			}
+			i++;
+		}
+
+		rhashtable_walk_stop(&iter);
+	} while (entry == ERR_PTR(-EAGAIN));
+
+	rhashtable_walk_exit(&iter);
+
+	if (skb)
+		nla_put_u32(skb, P4TC_COUNT, i);
+
+	if (ret < 0) {
+		if (i == 0) {
+			if (!extack->_msg)
+				NL_SET_ERR_MSG(extack,
+					       "Unable to flush any entries");
+			goto out_nlmsg_trim;
+		} else {
+			if (!extack->_msg)
+				NL_SET_ERR_MSG(extack,
+					       "Unable to flush all entries");
+		}
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	ret = 0;
+	goto table_put;
+
+out_nlmsg_trim:
+	if (skb)
+		nlmsg_trim(skb, b);
+
+table_put:
+	tcf_table_entry_put_table(pipeline, table);
+
+	return ret;
+}
+
+/* Invoked from both control and data path */
+static int __tcf_table_entry_create(struct p4tc_pipeline *pipeline,
+				    struct p4tc_table *table,
+				    struct p4tc_table_entry *entry,
+				    struct p4tc_table_entry_mask *mask,
+				    u16 whodunnit, bool from_control)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry_mask *mask_found = NULL;
+	struct p4tc_table_entry_work *entry_work;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_perm *tbl_perm;
+	struct p4tc_table_entry_tm *dtm;
+	u16 permissions;
+	int ret;
+
+	value = p4tc_table_entry_value(entry);
+	refcount_set(&value->entries_ref, 1);
+
+	tbl_perm = rcu_dereference(table->tbl_permissions);
+	permissions = tbl_perm->permissions;
+	if (from_control) {
+		if (!p4tc_ctrl_create_ok(permissions))
+			return -EPERM;
+	} else {
+		if (!p4tc_data_create_ok(permissions))
+			return -EPERM;
+	}
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		mask_found = tcf_table_entry_mask_add(table, entry, mask);
+		if (IS_ERR(mask_found)) {
+			ret = PTR_ERR(mask_found);
+			goto out;
+		}
+	}
+
+	tcf_table_entry_build_key(table, &entry->key, mask_found);
+
+	if (p4tc_entry_lookup(table, &entry->key, value->prio)) {
+		ret = -EEXIST;
+		goto rm_masks_idr;
+	}
+
+	dtm = kzalloc(sizeof(*dtm), GFP_ATOMIC);
+	if (unlikely(!dtm)) {
+		ret = -ENOMEM;
+		goto rm_masks_idr;
+	}
+
+	dtm->who_created = whodunnit;
+	dtm->created = jiffies;
+	dtm->firstused = 0;
+	dtm->lastused = jiffies;
+
+	rcu_assign_pointer(value->tm, dtm);
+
+	entry_work = kzalloc(sizeof(*entry_work), GFP_ATOMIC);
+	if (unlikely(!entry_work)) {
+		ret = -ENOMEM;
+		goto free_tm;
+	}
+
+	entry_work->pipeline = pipeline;
+	entry_work->entry = entry;
+	value->entry_work = entry_work;
+
+	INIT_WORK(&entry_work->work, tcf_table_entry_del_act_work);
+
+	refcount_inc(&table->tbl_entries_ref);
+
+	if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
+			    entry_hlt_params) < 0) {
+		ret = -EBUSY;
+		goto refcount_dec;
+	}
+
+	return 0;
+
+refcount_dec:
+	refcount_dec(&table->tbl_entries_ref);
+	kfree(entry_work);
+
+free_tm:
+	kfree(dtm);
+
+rm_masks_idr:
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		tcf_table_entry_mask_del(table, entry);
+
+out:
+	return ret;
+}
+
+/* Invoked from both control and data path  */
+static int __tcf_table_entry_update(struct p4tc_pipeline *pipeline,
+				    struct p4tc_table *table,
+				    struct p4tc_table_entry *entry,
+				    struct p4tc_table_entry_mask *mask,
+				    u16 whodunnit, bool from_control)
+	__must_hold(RCU)
+{
+	struct p4tc_table_entry_mask *mask_found = NULL;
+	struct p4tc_table_entry_work *entry_work;
+	struct p4tc_table_entry_value *value_old;
+	struct p4tc_table_entry_value *value;
+	struct p4tc_table_entry *entry_old;
+	struct p4tc_table_entry_tm *tm_old;
+	struct p4tc_table_entry_tm *tm;
+	int ret;
+
+	value = p4tc_table_entry_value(entry);
+	refcount_set(&value->entries_ref, 1);
+
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT) {
+		mask_found = tcf_table_entry_mask_add(table, entry, mask);
+		if (IS_ERR(mask_found)) {
+			ret = PTR_ERR(mask_found);
+			goto out;
+		}
+	}
+
+	tcf_table_entry_build_key(table, &entry->key, mask_found);
+
+	entry_old = p4tc_entry_lookup(table, &entry->key, value->prio);
+	if (!entry_old) {
+		ret = -ENOENT;
+		goto rm_masks_idr;
+	}
+
+	value_old = p4tc_table_entry_value(entry_old);
+
+	if (from_control) {
+		if (!p4tc_ctrl_update_ok(value_old->permissions)) {
+			ret = -EPERM;
+			goto rm_masks_idr;
+		}
+	} else {
+		if (!p4tc_data_update_ok(value_old->permissions)) {
+			ret = -EPERM;
+			goto rm_masks_idr;
+		}
+	}
+
+	if (refcount_read(&value_old->entries_ref) > 1) {
+		ret = -EBUSY;
+		goto rm_masks_idr;
+	}
+
+	tm = kzalloc(sizeof(*tm), GFP_ATOMIC);
+	if (unlikely(!tm)) {
+		ret = -ENOMEM;
+		goto rm_masks_idr;
+	}
+
+	tm_old = rcu_dereference_protected(value_old->tm, 1);
+	*tm = *tm_old;
+
+	tm->lastused = jiffies;
+	tm->who_updated = whodunnit;
+
+	if (value->permissions == P4TC_PERMISSIONS_UNINIT)
+		value->permissions = value_old->permissions;
+
+	rcu_assign_pointer(value->tm, tm);
+
+	entry_work = kzalloc(sizeof(*(entry_work)), GFP_ATOMIC);
+	if (unlikely(!entry_work)) {
+		ret = -ENOMEM;
+		goto free_tm;
+	}
+
+	entry_work->pipeline = pipeline;
+	entry_work->entry = entry;
+	value->entry_work = entry_work;
+
+	INIT_WORK(&entry_work->work, tcf_table_entry_del_act_work);
+
+	if (rhltable_insert(&table->tbl_entries, &entry->ht_node,
+			    entry_hlt_params) < 0) {
+		ret = -EEXIST;
+		goto free_entry_work;
+	}
+
+	if (tcf_table_entry_destroy_noida(table, entry_old) < 0) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	return 0;
+
+free_entry_work:
+	kfree(entry_work);
+
+free_tm:
+	kfree(tm);
+
+rm_masks_idr:
+	if (table->tbl_type != P4TC_TABLE_TYPE_EXACT)
+		tcf_table_entry_mask_del(table, entry);
+
+out:
+	return ret;
+}
+
+#define P4TC_DEFAULT_TENTRY_PERMISSIONS                           \
+	(P4TC_CTRL_PERM_R | P4TC_CTRL_PERM_U | P4TC_CTRL_PERM_D | \
+	 P4TC_DATA_PERM_R | P4TC_DATA_PERM_X)
+
+static bool tcf_table_check_entry_acts(struct p4tc_table *table,
+				       struct tc_action *entry_acts[],
+				       struct list_head *allowed_acts,
+				       int num_entry_acts)
+{
+	struct p4tc_table_act *table_act;
+	int i;
+
+	for (i = 0; i < num_entry_acts; i++) {
+		const struct tc_action *entry_act = entry_acts[i];
+
+		list_for_each_entry(table_act, allowed_acts, node) {
+			if (table_act->ops->id == entry_act->ops->id &&
+			    !(table_act->flags & BIT(P4TC_TABLE_ACTS_DEFAULT_ONLY)))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static struct p4tc_table_entry *
+__tcf_table_entry_cu(struct net *net, bool replace, struct nlattr **tb,
+		     struct p4tc_pipeline *pipeline, struct p4tc_table *table,
+		     struct netlink_ext_ack *extack)
+{
+	u8 __mask[sizeof(struct p4tc_table_entry_mask) +
+		  BITS_TO_BYTES(P4TC_MAX_KEYSZ)] = { 0 };
+	struct p4tc_table_entry_mask *mask = (void *)&__mask;
+	struct p4tc_table_entry_value *value;
+	u8 whodunnit = P4TC_ENTITY_UNSPEC;
+	struct p4tc_table_entry *entry;
+	u32 keysz_bytes;
+	u32 keysz_bits;
+	int ret = 0;
+	u32 entrysz;
+	u32 prio;
+
+	prio = tb[P4TC_ENTRY_PRIO] ? nla_get_u32(tb[P4TC_ENTRY_PRIO]) : 0;
+	if (replace) {
+		if (!prio) {
+			NL_SET_ERR_MSG(extack, "Must specify entry priority");
+			return ERR_PTR(-EINVAL);
+		}
+	} else {
+		if (prio)
+			ret = ida_alloc_range(&table->tbl_prio_idr, prio,
+					      prio, GFP_ATOMIC);
+		else
+			ret = ida_alloc_min(&table->tbl_prio_idr, 1,
+					    GFP_ATOMIC);
+		if (ret < 0) {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to allocate priority");
+			return ERR_PTR(ret);
+		}
+		prio = ret;
+
+		if (refcount_read(&table->tbl_entries_ref) > table->tbl_max_entries) {
+			NL_SET_ERR_MSG(extack,
+				       "Table max entries reached");
+			ret = -EINVAL;
+			goto idr_rm;
+		}
+	}
+
+	whodunnit = nla_get_u8(tb[P4TC_ENTRY_WHODUNNIT]);
+
+	keysz_bits = table->tbl_keysz;
+	keysz_bytes = P4TC_KEYSZ_BYTES(keysz_bits);
+
+	/* Entry memory layout:
+	 * { entry | key __aligned(8) | value }
+	 */
+	entrysz = sizeof(*entry) + keysz_bytes +
+		  sizeof(struct p4tc_table_entry_value);
+
+	entry = kzalloc(entrysz, GFP_KERNEL);
+	if (unlikely(!entry)) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate table entry");
+		ret = -ENOMEM;
+		goto idr_rm;
+	}
+
+	entry->key.keysz = keysz_bits;
+	mask->sz = keysz_bits;
+
+	ret = tcf_table_entry_extract_key(table, tb, &entry->key, mask, extack);
+	if (ret < 0)
+		goto free_entry;
+
+	value = p4tc_table_entry_value(entry);
+	value->prio = prio;
+
+	if (tb[P4TC_ENTRY_PERMISSIONS]) {
+		const u16 tblperm =
+			rcu_dereference(table->tbl_permissions)->permissions;
+		u16 nlperm;
+
+		nlperm = nla_get_u16(tb[P4TC_ENTRY_PERMISSIONS]);
+		if (p4tc_ctrl_create_ok(nlperm) ||
+		    p4tc_data_create_ok(nlperm)) {
+			NL_SET_ERR_MSG(extack,
+				       "Create permission for table entry doesn't make sense");
+			ret = -EINVAL;
+			goto free_entry;
+		}
+		if (!p4tc_data_read_ok(nlperm)) {
+			NL_SET_ERR_MSG(extack,
+				       "Data path read permission must be set");
+			ret = -EINVAL;
+			goto free_entry;
+		}
+		if (!p4tc_data_exec_ok(nlperm)) {
+			NL_SET_ERR_MSG(extack,
+				       "Data path execute permissions for entry must be set");
+			ret = -EINVAL;
+			goto free_entry;
+		}
+
+		if (~tblperm & nlperm) {
+			NL_SET_ERR_MSG(extack,
+				       "Trying to set permission bits which aren't allowed by table");
+			ret = -EINVAL;
+			goto free_entry;
+		}
+		value->permissions = nlperm;
+	} else {
+		if (replace)
+			value->permissions = P4TC_PERMISSIONS_UNINIT;
+		else
+			value->permissions = P4TC_DEFAULT_TENTRY_PERMISSIONS;
+	}
+
+	if (tb[P4TC_ENTRY_ACT]) {
+		value->acts = kcalloc(TCA_ACT_MAX_PRIO,
+				      sizeof(struct tc_action *), GFP_KERNEL);
+		if (unlikely(!value->acts)) {
+			ret = -ENOMEM;
+			goto free_entry;
+		}
+
+		ret = p4tc_action_init(net, tb[P4TC_ENTRY_ACT], value->acts,
+				       table->common.p_id,
+				       TCA_ACT_FLAGS_NO_RTNL, extack);
+		if (ret < 0) {
+			kfree(value->acts);
+			value->acts = NULL;
+			goto free_entry;
+		}
+
+		value->num_acts = ret;
+
+		if (!tcf_table_check_entry_acts(table, value->acts,
+						&table->tbl_acts_list, ret)) {
+			ret = -EPERM;
+			NL_SET_ERR_MSG(extack,
+				       "Action is not allowed as entry action");
+			goto free_acts;
+		}
+	}
+
+	rcu_read_lock();
+	if (replace)
+		ret = __tcf_table_entry_update(pipeline, table, entry, mask,
+					       whodunnit, true);
+	else
+		ret = __tcf_table_entry_create(pipeline, table, entry, mask,
+					       whodunnit, true);
+	if (ret < 0) {
+		rcu_read_unlock();
+		goto free_acts;
+	}
+	rcu_read_unlock();
+
+	return entry;
+
+free_acts:
+	p4tc_action_destroy(value->acts);
+
+free_entry:
+	kfree(entry);
+
+idr_rm:
+	if (!replace)
+		ida_free(&table->tbl_prio_idr, prio);
+
+	return ERR_PTR(ret);
+}
+
+static int tcf_table_entry_cu(struct net *net, struct sk_buff *skb,
+			      bool replace, struct nlattr *arg, u32 *ids,
+			      struct p4tc_nl_pname *nl_pname,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_table_entry *entry;
+	struct p4tc_table *table;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg, p4tc_entry_policy,
+			       extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_ENTRY_WHODUNNIT)) {
+		NL_SET_ERR_MSG(extack, "Must specify whodunnit attribute");
+		return -EINVAL;
+	}
+
+	rcu_read_lock();
+	ret = tcf_table_entry_get_table(net, &pipeline, &table, tb, ids,
+					nl_pname->data, extack);
+	rcu_read_unlock();
+	if (ret < 0)
+		return ret;
+
+	if (!pipeline_sealed(pipeline)) {
+		NL_SET_ERR_MSG(extack,
+			       "Need to seal pipeline before issuing runtime command");
+		ret = -EINVAL;
+		goto table_put;
+	}
+
+	entry = __tcf_table_entry_cu(net, replace, tb, pipeline, table, extack);
+	if (IS_ERR(entry)) {
+		ret = PTR_ERR(entry);
+		goto table_put;
+	}
+
+	if (skb && p4tc_tbl_entry_fill(skb, table, entry, table->tbl_id) <= 0)
+		NL_SET_ERR_MSG(extack, "Unable to fill table entry attributes");
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+table_put:
+	tcf_table_entry_put_table(pipeline, table);
+	return ret;
+}
+
+struct p4tc_table_entry *
+tcf_table_const_entry_cu(struct net *net,
+			 struct nlattr *arg,
+			 struct p4tc_pipeline *pipeline,
+			 struct p4tc_table *table,
+			 struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg, p4tc_entry_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_ENTRY_WHODUNNIT)) {
+		NL_SET_ERR_MSG(extack, "Must specify whodunnit attribute");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return __tcf_table_entry_cu(net, false, tb, pipeline, table, extack);
+}
+
+static int p4tc_tbl_entry_get_1(struct net *net, struct sk_buff *skb, u32 *ids,
+				struct nlattr *arg,
+				struct p4tc_nl_pname *nl_pname,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 *arg_ids;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, arg, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PARAMS)) {
+		NL_SET_ERR_MSG(extack, "Must specify parameters");
+		return -EINVAL;
+	}
+
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&ids[P4TC_TBLID_IDX], arg_ids, nla_len(tb[P4TC_PATH]));
+
+	return tcf_table_entry_gd(net, skb, false, tb[P4TC_PARAMS], ids,
+				  nl_pname, extack);
+}
+
+static int p4tc_tbl_entry_del_1(struct net *net, struct sk_buff *skb,
+				bool flush, struct nlattr *arg, u32 *ids,
+				struct p4tc_nl_pname *nl_pname,
+				struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 *arg_ids;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, arg, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&ids[P4TC_TBLID_IDX], arg_ids, nla_len(tb[P4TC_PATH]));
+	if (flush) {
+		ret = tcf_table_entry_flush(net, skb, tb[P4TC_PARAMS], ids,
+					    nl_pname, extack);
+	} else {
+		if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PARAMS)) {
+			NL_SET_ERR_MSG(extack, "Must specify parameters");
+			return -EINVAL;
+		}
+		ret = tcf_table_entry_gd(net, skb, true, tb[P4TC_PARAMS], ids,
+					 nl_pname, extack);
+	}
+
+	return ret;
+}
+
+static int p4tc_tbl_entry_cu_1(struct net *net, struct sk_buff *skb,
+			       bool replace, u32 *ids, struct nlattr *nla,
+			       struct p4tc_nl_pname *nl_pname,
+			       struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 *arg_ids;
+	int ret = 0;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, nla, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, P4TC_PARAMS)) {
+		NL_SET_ERR_MSG(extack, "Must specify object attributes");
+		return -EINVAL;
+	}
+
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&ids[P4TC_TBLID_IDX], arg_ids, nla_len(tb[P4TC_PATH]));
+
+	return tcf_table_entry_cu(net, skb, replace, tb[P4TC_PARAMS], ids,
+				  nl_pname, extack);
+}
+
+static int __p4tc_tbl_entry_doit(struct net *net, struct sk_buff *skb,
+				 struct nlmsghdr *n, int cmd, char *p_name,
+				 struct nlattr *p4tca[],
+				 struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	u32 portid = NETLINK_CB(skb).portid;
+	u32 ids[P4TC_PATH_MAX] = { 0 };
+	struct p4tc_nl_pname nl_pname;
+	int ret = 0, ret_send;
+	struct p4tcmsg *t_new;
+	struct sk_buff *nskb;
+	struct nlmsghdr *nlh;
+	struct nlattr *pnatt;
+	struct nlattr *root;
+	int i;
+
+	nskb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (unlikely(!nskb))
+		return -ENOBUFS;
+
+	nlh = nlmsg_put(nskb, portid, n->nlmsg_seq, cmd, sizeof(*t),
+			n->nlmsg_flags);
+	if (unlikely(!nlh))
+		goto out;
+
+	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
+	t_new->obj = t->obj;
+	ids[P4TC_PID_IDX] = t_new->pipeid;
+
+	pnatt = nla_reserve(nskb, P4TC_ROOT_PNAME, PIPELINENAMSIZ);
+	if (unlikely(!pnatt)) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	nl_pname.data = nla_data(pnatt);
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_pname.data, 0, PIPELINENAMSIZ);
+		nl_pname.passed = false;
+	} else {
+		strscpy(nl_pname.data, p_name, PIPELINENAMSIZ);
+		nl_pname.passed = true;
+	}
+
+	root = nla_nest_start(nskb, P4TC_ROOT);
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && p4tca[i]; i++) {
+		struct nlattr *nest = nla_nest_start(nskb, i);
+
+		if (cmd == RTM_P4TC_GET)
+			ret = p4tc_tbl_entry_get_1(net, nskb, ids, p4tca[i],
+						   &nl_pname, extack);
+		else if (cmd == RTM_P4TC_CREATE) {
+			bool replace = nlh->nlmsg_flags & NLM_F_REPLACE;
+
+			ret = p4tc_tbl_entry_cu_1(net, nskb, replace, ids,
+						  p4tca[i], &nl_pname, extack);
+		} else if (cmd == RTM_P4TC_DEL) {
+			bool flush = nlh->nlmsg_flags & NLM_F_ROOT;
+
+			ret = p4tc_tbl_entry_del_1(net, nskb, flush, p4tca[i],
+						   ids, &nl_pname, extack);
+		}
+
+		if (ret < 0) {
+			if (i == 1) {
+				goto free;
+			} else {
+				nla_nest_cancel(nskb, nest);
+				break;
+			}
+		}
+		nla_nest_end(nskb, nest);
+	}
+	nla_nest_end(nskb, root);
+
+	if (!t_new->pipeid)
+		t_new->pipeid = ids[P4TC_PID_IDX];
+
+	nlmsg_end(nskb, nlh);
+
+	if (cmd == RTM_P4TC_GET)
+		ret_send = rtnl_unicast(nskb, net, portid);
+	else
+		ret_send = rtnetlink_send(nskb, net, portid, RTNLGRP_TC,
+					  n->nlmsg_flags & NLM_F_ECHO);
+
+	return ret_send ? ret_send : ret;
+
+free:
+	kfree_skb(nskb);
+out:
+	return ret;
+}
+
+static int __p4tc_tbl_entry_doit_fast(struct net *net, struct nlmsghdr *n,
+				      int cmd, char *p_name,
+				      struct nlattr *p4tca[],
+				      struct netlink_ext_ack *extack)
+{
+	struct p4tcmsg *t = (struct p4tcmsg *)nlmsg_data(n);
+	char data[PIPELINENAMSIZ] = { 0 };
+	u32 ids[P4TC_PATH_MAX] = { 0 };
+	struct p4tc_nl_pname nl_pname;
+	int ret = 0;
+	int i;
+
+	ids[P4TC_PID_IDX] = t->pipeid;
+
+	nl_pname.data = data;
+	if (!p_name) {
+		/* Filled up by the operation or forced failure */
+		memset(nl_pname.data, 0, PIPELINENAMSIZ);
+		nl_pname.passed = false;
+	} else {
+		strscpy(nl_pname.data, p_name, PIPELINENAMSIZ);
+		nl_pname.passed = true;
+	}
+
+	for (i = 1; i < P4TC_MSGBATCH_SIZE + 1 && p4tca[i]; i++) {
+		if (cmd == RTM_P4TC_CREATE) {
+			bool replace = n->nlmsg_flags & NLM_F_REPLACE;
+
+			ret = p4tc_tbl_entry_cu_1(net, NULL, replace, ids,
+						  p4tca[i], &nl_pname, extack);
+		} else if (cmd == RTM_P4TC_DEL) {
+			bool flush = n->nlmsg_flags & NLM_F_ROOT;
+
+			ret = p4tc_tbl_entry_del_1(net, NULL, flush, p4tca[i],
+						   ids, &nl_pname, extack);
+		}
+
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
+int p4tc_tbl_entry_doit(struct net *net, struct sk_buff *skb,
+			struct nlmsghdr *n, int cmd,
+			struct netlink_ext_ack *extack)
+{
+	struct nlattr *p4tca[P4TC_MSGBATCH_SIZE + 1];
+	int echo = n->nlmsg_flags & NLM_F_ECHO;
+	struct nlattr *tb[P4TC_ROOT_MAX + 1];
+	char *p_name = NULL;
+	int listeners;
+	int ret = 0;
+
+	ret = nlmsg_parse(n, sizeof(struct p4tcmsg), tb, P4TC_ROOT_MAX,
+			  p4tc_root_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	if (NL_REQ_ATTR_CHECK(extack, NULL, tb, P4TC_ROOT)) {
+		NL_SET_ERR_MSG(extack, "Netlink P4TC table attributes missing");
+		return -EINVAL;
+	}
+
+	ret = nla_parse_nested(p4tca, P4TC_MSGBATCH_SIZE, tb[P4TC_ROOT], NULL,
+			       extack);
+	if (ret < 0)
+		goto put_net;
+
+	if (!p4tca[1]) {
+		NL_SET_ERR_MSG(extack, "No elements in root table array");
+		ret = -EINVAL;
+		goto put_net;
+	}
+
+	if (tb[P4TC_ROOT_PNAME])
+		p_name = nla_data(tb[P4TC_ROOT_PNAME]);
+
+	listeners = rtnl_has_listeners(net, RTNLGRP_TC);
+
+	if ((echo || listeners) || cmd == RTM_P4TC_GET)
+		ret = __p4tc_tbl_entry_doit(net, skb, n, cmd, p_name, p4tca,
+					    extack);
+	else
+		ret = __p4tc_tbl_entry_doit_fast(net, n, cmd, p_name, p4tca,
+						 extack);
+
+put_net:
+	put_net(net);
+
+	return ret;
+}
+
+static int tcf_table_entry_dump(struct net *net, struct sk_buff *skb,
+				struct nlattr *arg, u32 *ids,
+				struct netlink_callback *cb,
+				char **p_name, struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_ENTRY_MAX + 1] = { NULL };
+	struct p4tc_dump_ctx *ctx = (void *)cb->ctx;
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_pipeline *pipeline = NULL;
+	struct p4tc_table_entry *entry = NULL;
+	struct p4tc_table *table;
+	int i = 0;
+	int ret;
+
+	if (arg) {
+		ret = nla_parse_nested(tb, P4TC_ENTRY_MAX, arg,
+				       p4tc_entry_policy, extack);
+		if (ret < 0) {
+			kfree(ctx->iter);
+			goto net_put;
+		}
+	}
+
+	rcu_read_lock();
+	ret = tcf_table_entry_get_table(net, &pipeline, &table, tb, ids,
+					*p_name, extack);
+	rcu_read_unlock();
+	if (ret < 0) {
+		kfree(ctx->iter);
+		goto net_put;
+	}
+
+	if (!ctx->iter) {
+		ctx->iter = kzalloc(sizeof(*ctx->iter), GFP_KERNEL);
+		if (!ctx->iter) {
+			ret = -ENOMEM;
+			goto table_put;
+		}
+
+		rhltable_walk_enter(&table->tbl_entries, ctx->iter);
+	}
+
+	ret = -ENOMEM;
+	rhashtable_walk_start(ctx->iter);
+	do {
+		for (i = 0; i < P4TC_MSGBATCH_SIZE &&
+		     (entry = rhashtable_walk_next(ctx->iter)) &&
+		     !IS_ERR(entry); i++) {
+			struct p4tc_table_entry_value *value =
+				p4tc_table_entry_value(entry);
+			struct nlattr *count;
+
+			if (!p4tc_ctrl_read_ok(value->permissions)) {
+				i--;
+				continue;
+			}
+
+			count = nla_nest_start(skb, i + 1);
+			if (!count) {
+				rhashtable_walk_stop(ctx->iter);
+				goto table_put;
+			}
+
+			ret = p4tc_tbl_entry_fill(skb, table, entry,
+						  table->tbl_id);
+			if (ret == 0) {
+				NL_SET_ERR_MSG(extack,
+					       "Failed to fill notification attributes for table entry");
+				goto walk_done;
+			} else if (ret == -ENOMEM) {
+				ret = 1;
+				nla_nest_cancel(skb, count);
+				rhashtable_walk_stop(ctx->iter);
+				goto table_put;
+			}
+			nla_nest_end(skb, count);
+		}
+	} while (entry == ERR_PTR(-EAGAIN));
+	rhashtable_walk_stop(ctx->iter);
+
+	if (!i) {
+		rhashtable_walk_exit(ctx->iter);
+
+		ret = 0;
+		kfree(ctx->iter);
+
+		goto table_put;
+	}
+
+	if (!*p_name)
+		*p_name = pipeline->common.name;
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	ret = skb->len;
+
+	goto table_put;
+
+walk_done:
+	rhashtable_walk_stop(ctx->iter);
+	rhashtable_walk_exit(ctx->iter);
+	kfree(ctx->iter);
+
+	nlmsg_trim(skb, b);
+
+table_put:
+	tcf_table_entry_put_table(pipeline, table);
+
+net_put:
+	put_net(net);
+
+	return ret;
+}
+
+int p4tc_tbl_entry_dumpit(struct net *net, struct sk_buff *skb,
+			  struct netlink_callback *cb,
+			  struct nlattr *arg, char *p_name)
+{
+	struct netlink_ext_ack *extack = cb->extack;
+	u32 portid = NETLINK_CB(cb->skb).portid;
+	const struct nlmsghdr *n = cb->nlh;
+	struct nlattr *tb[P4TC_MAX + 1];
+	u32 ids[P4TC_PATH_MAX] = { 0 };
+	struct p4tcmsg *t_new;
+	struct nlmsghdr *nlh;
+	struct nlattr *root;
+	struct p4tcmsg *t;
+	u32 *arg_ids;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_MAX, arg, p4tc_policy, extack);
+	if (ret < 0)
+		return ret;
+
+	nlh = nlmsg_put(skb, portid, n->nlmsg_seq, RTM_P4TC_GET, sizeof(*t),
+			n->nlmsg_flags);
+	if (!nlh)
+		return -ENOSPC;
+
+	t = (struct p4tcmsg *)nlmsg_data(n);
+	t_new = nlmsg_data(nlh);
+	t_new->pipeid = t->pipeid;
+	t_new->obj = t->obj;
+
+	if (NL_REQ_ATTR_CHECK(extack, arg, tb, P4TC_PATH)) {
+		NL_SET_ERR_MSG(extack, "Must specify object path");
+		return -EINVAL;
+	}
+
+	ids[P4TC_PID_IDX] = t_new->pipeid;
+	arg_ids = nla_data(tb[P4TC_PATH]);
+	memcpy(&ids[P4TC_TBLID_IDX], arg_ids, nla_len(tb[P4TC_PATH]));
+
+	root = nla_nest_start(skb, P4TC_ROOT);
+	ret = tcf_table_entry_dump(net, skb, tb[P4TC_PARAMS], ids, cb, &p_name,
+				   extack);
+	if (ret <= 0)
+		goto out;
+	nla_nest_end(skb, root);
+
+	if (p_name) {
+		if (nla_put_string(skb, P4TC_ROOT_PNAME, p_name)) {
+			ret = -1;
+			goto out;
+		}
+	}
+
+	if (!t_new->pipeid)
+		t_new->pipeid = ids[P4TC_PID_IDX];
+
+	nlmsg_end(skb, nlh);
+
+	return skb->len;
+
+out:
+	nlmsg_cancel(skb, nlh);
+	return ret;
+}
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index b10baa787..faf312509 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -27,12 +27,12 @@
 #include <net/netlink.h>
 #include <net/flow_offload.h>
 
-static const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
+const struct nla_policy p4tc_root_policy[P4TC_ROOT_MAX + 1] = {
 	[P4TC_ROOT] = { .type = NLA_NESTED },
 	[P4TC_ROOT_PNAME] = { .type = NLA_STRING, .len = PIPELINENAMSIZ },
 };
 
-static const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
+const struct nla_policy p4tc_policy[P4TC_MAX + 1] = {
 	[P4TC_PATH] = { .type = NLA_BINARY,
 			.len = P4TC_PATH_MAX * sizeof(u32) },
 	[P4TC_PARAMS] = { .type = NLA_NESTED },
diff --git a/security/selinux/nlmsgtab.c b/security/selinux/nlmsgtab.c
index 0a8daf2f8..208e5e258 100644
--- a/security/selinux/nlmsgtab.c
+++ b/security/selinux/nlmsgtab.c
@@ -97,6 +97,9 @@ static const struct nlmsg_perm nlmsg_route_perms[] = {
 	{ RTM_CREATEP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_DELP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
 	{ RTM_GETP4TEMPLATE,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
+	{ RTM_P4TC_CREATE,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_P4TC_DEL,	NETLINK_ROUTE_SOCKET__NLMSG_WRITE },
+	{ RTM_P4TC_GET,	NETLINK_ROUTE_SOCKET__NLMSG_READ },
 };
 
 static const struct nlmsg_perm nlmsg_tcpdiag_perms[] = {
@@ -179,7 +182,7 @@ int selinux_nlmsg_lookup(u16 sclass, u16 nlmsg_type, u32 *perm)
 		 * structures at the top of this file with the new mappings
 		 * before updating the BUILD_BUG_ON() macro!
 		 */
-		BUILD_BUG_ON(RTM_MAX != (RTM_CREATEP4TEMPLATE + 3));
+		BUILD_BUG_ON(RTM_MAX != (RTM_P4TC_CREATE + 3));
 		err = nlmsg_perm(nlmsg_type, perm, nlmsg_route_perms,
 				 sizeof(nlmsg_route_perms));
 		break;
-- 
2.34.1


