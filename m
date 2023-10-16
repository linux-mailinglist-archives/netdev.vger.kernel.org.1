Return-Path: <netdev+bounces-41227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA57CA44A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF29281616
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DE208BD;
	Mon, 16 Oct 2023 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1ZpYm0Jw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83212031F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 09:36:16 +0000 (UTC)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5CFAD
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:13 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-65b0e623189so25735666d6.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 02:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1697448972; x=1698053772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jcdTj7mP+fpIwGwZTbAe8apro/H7rd/qceG8snO570=;
        b=1ZpYm0JwXwcTOTZEm4f9hOvwjQa2QnJsxOuPOPjq52pb7mZnP2XPl/WKLNXTXCfcEz
         4mtt57sQJv4059kLM33LLUnPRonf0EjyGT4mLrq4jYMQjv6wrhKPh9gYP0kw59ItTydc
         6xgF3n3FUh4bB2EOuUA7LlffNPeVy2GsMx/eFH5BlIPg7XCnkpGEMdM15XF9pwweeeLI
         nO2Lh+9eQpL1eb5XVyWvPjZQ+SxwtFyj9qePFn5QNxrUIRRhT2y+svBSC6ePGpbW8Vif
         W9dcU369J9b+KCL12RPBBqFJ3ywKpHeqACXjp3iPISfO0kXf8Ui1VRtAFf4CwHmCXubH
         A+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697448972; x=1698053772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jcdTj7mP+fpIwGwZTbAe8apro/H7rd/qceG8snO570=;
        b=km424T7yDkums1l2/zoOsG6C7PDMIZK93hpBfpxT1Yu49V3GQEkhC9CO7lfQUjhGw5
         Wa1x1bXysloo/JdIo+eiZ6+1ig7XnQWwxpHlosRPT5/EuGf0PDFT9YBrUBplYHTGCXAZ
         9uiD61cFfDUsTi/T93G3J7TakwZVigbPrDgy5vPjjYjWnY7Gqwin0/xIIVolire65ktF
         YVPBLarwFHzAKKXGKNfoFw8Tr7GcKP937GhQk5wLsG5R4VWgzg6x3/ioKjhBGuT7jIge
         i62Q5FcASMOOxn5HbfOaJEbbQeU2YE27oDomYxyWn8kWIBuGnu3ZR8EqnlaXsMCeivTA
         DHmg==
X-Gm-Message-State: AOJu0YxV4uMPclWKbdLPuyelGQjuOaOn7X3l8EmpVcMf2ZyqMtB7SYoy
	iS8zSXvcyFgTc3QlmkXDdjrdDy8CqiKZF8yFVbE=
X-Google-Smtp-Source: AGHT+IG8lUN9a9+WzD6SHnlSPRQU1xz7uTRcoZHndDqILBqKi8Vuie07vnjSvTDHYf3hffzFhmTKFw==
X-Received: by 2002:ad4:5310:0:b0:653:5960:8959 with SMTP id y16-20020ad45310000000b0065359608959mr33503434qvr.41.1697448972179;
        Mon, 16 Oct 2023 02:36:12 -0700 (PDT)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id g4-20020a0cf844000000b0065b1bcd0d33sm3292551qvo.93.2023.10.16.02.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 02:36:11 -0700 (PDT)
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
Subject: [PATCH v7 net-next 10/18] p4tc: add template header field create, get, delete, flush and dump
Date: Mon, 16 Oct 2023 05:35:41 -0400
Message-Id: <20231016093549.181952-11-jhs@mojatatu.com>
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

Header fields are needed to allow for integration of parser value sets
(see spec for P4 16 v1.2.4).

To create a header field, the user must issue the equivalent of the
following command:

tc p4template create hdrfield/myprog/myparser/ipv4/dstAddr hdrfieldid 4 \
 type ipv4

where myprog is the name of a pipeline, myparser is a name of a parser
instance, ipv4/dstAddr is the name of header field which is of type ipv4.

To delete a header field, the user must issue the equivalent of the
following command:

tc p4template delete hdrfield/myprog/myparser/ipv4/dstAddr

where myprog is the name of pipeline, myparser is a name of a parser
instance, ipv4/dstAddr is the name of header field to be deleted.

To retrieve meta-information from a header field, such as length,
position and type, the user must issue the equivalent of the following
command:

tc p4template get hdrfield/myprog/myparser/ipv4/dstAddr

where myprog is the name of pipeline, myparser is a name of a parser
instance, ipv4/dstAddr is the name of header field to be deleted.

The user can also dump all the header fields available in a parser
instance using the equivalent of the following command:

tc p4template get hdrfield/myprog/myparser/

With that, the user will get all the header field names available in a
specific parser instance.

The user can also flush all the header fields available in a parser
instance using the equivalent of the following command:

tc p4template del hdrfield/myprog/myparser/

Header fields do not support update operations.

Co-developed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/p4tc.h               |  65 ++++
 include/uapi/linux/p4tc.h        |  21 ++
 net/sched/p4tc/Makefile          |   3 +-
 net/sched/p4tc/p4tc_hdrfield.c   | 586 +++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_parser_api.c | 150 ++++++++
 net/sched/p4tc/p4tc_pipeline.c   |   5 +
 net/sched/p4tc/p4tc_tmpl_api.c   |  18 +
 7 files changed, 847 insertions(+), 1 deletion(-)
 create mode 100644 net/sched/p4tc/p4tc_hdrfield.c
 create mode 100644 net/sched/p4tc/p4tc_parser_api.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index 0512e489a..2af61e404 100644
--- a/include/net/p4tc.h
+++ b/include/net/p4tc.h
@@ -17,6 +17,10 @@
 #define P4TC_KERNEL_PIPEID 0
 
 #define P4TC_PID_IDX 0
+#define P4TC_PARSEID_IDX 1
+#define P4TC_HDRFIELDID_IDX 2
+
+#define P4TC_HDRFIELD_IS_VALIDITY_BIT 0x1
 
 struct p4tc_dump_ctx {
 	u32 ids[P4TC_PATH_MAX];
@@ -65,6 +69,7 @@ struct p4tc_pipeline {
 	struct p4tc_template_common common;
 	struct rcu_head             rcu;
 	struct net                  *net;
+	struct p4tc_parser          *parser;
 	/* Accounts for how many entities are referencing this pipeline.
 	 * As for now only P4 filters can refer to pipelines.
 	 */
@@ -119,6 +124,66 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 	return ret;
 }
 
+struct p4tc_parser {
+	char parser_name[PARSERNAMSIZ];
+	struct idr hdrfield_idr;
+	refcount_t parser_ref;
+	u32 parser_id;
+};
+
+struct p4tc_hdrfield {
+	struct p4tc_template_common common;
+	struct p4tc_parser          *parser;
+	u32                         hdrfield_id;
+	refcount_t                  hdrfield_ref;
+	u16                         startbit;
+	u16                         endbit;
+	u8                          datatype; /* T_XXX */
+	u8                          flags;  /* P4TC_HDRFIELD_FLAGS_* */
+};
+
+extern const struct p4tc_template_ops p4tc_hdrfield_ops;
+
+struct p4tc_parser *tcf_parser_create(struct p4tc_pipeline *pipeline,
+				      const char *parser_name, u32 parser_id,
+				      struct netlink_ext_ack *extack);
+
+struct p4tc_parser *tcf_parser_find_byid(struct p4tc_pipeline *pipeline,
+					 const u32 parser_inst_id);
+struct p4tc_parser *tcf_parser_find_byany(struct p4tc_pipeline *pipeline,
+					  const char *parser_name,
+					  u32 parser_inst_id,
+					  struct netlink_ext_ack *extack);
+struct p4tc_parser *tcf_parser_find_get(struct p4tc_pipeline *pipeline,
+					const char *parser_name,
+					u32 parser_inst_id,
+					struct netlink_ext_ack *extack);
+
+static inline bool tcf_parser_put(struct p4tc_parser *parser)
+{
+	return refcount_dec_not_one(&parser->parser_ref);
+}
+
+int tcf_parser_del(struct net *net, struct p4tc_pipeline *pipeline,
+		   struct p4tc_parser *parser, struct netlink_ext_ack *extack);
+
+struct p4tc_hdrfield *p4tc_hdrfield_find_byid(struct p4tc_parser *parser,
+					     const u32 hdrfield_id);
+struct p4tc_hdrfield *p4tc_hdrfield_find_byany(struct p4tc_parser *parser,
+					      const char *hdrfield_name,
+					      u32 hdrfield_id,
+					      struct netlink_ext_ack *extack);
+struct p4tc_hdrfield *p4tc_hdrfield_find_get(struct p4tc_parser *parser,
+					    const char *hdrfield_name,
+					    u32 hdrfield_id,
+					    struct netlink_ext_ack *extack);
+
+static inline bool p4tc_hdrfield_put_ref(struct p4tc_hdrfield *hdrfield)
+{
+	return !refcount_dec_not_one(&hdrfield->hdrfield_ref);
+}
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
+#define to_hdrfield(t) ((struct p4tc_hdrfield *)t)
 
 #endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index 0fdc8f9b4..b3dbdb338 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -17,9 +17,12 @@ struct p4tcmsg {
 #define P4TC_MSGBATCH_SIZE 16
 
 #define P4TC_MAX_KEYSZ 512
+#define HEADER_MAX_LEN 512
 
 #define TEMPLATENAMSZ 32
 #define PIPELINENAMSIZ TEMPLATENAMSZ
+#define PARSERNAMSIZ TEMPLATENAMSZ
+#define HDRFIELDNAMSIZ TEMPLATENAMSZ
 
 /* Root attributes */
 enum {
@@ -34,6 +37,7 @@ enum {
 enum {
 	P4TC_OBJ_UNSPEC,
 	P4TC_OBJ_PIPELINE,
+	P4TC_OBJ_HDR_FIELD,
 	__P4TC_OBJ_MAX,
 };
 #define P4TC_OBJ_MAX (__P4TC_OBJ_MAX - 1)
@@ -43,6 +47,7 @@ enum {
 	P4TC_UNSPEC,
 	P4TC_PATH,
 	P4TC_PARAMS,
+	P4TC_COUNT,
 	__P4TC_MAX,
 };
 #define P4TC_MAX (__P4TC_MAX - 1)
@@ -88,6 +93,22 @@ enum {
 };
 #define P4T_MAX (__P4T_MAX - 1)
 
+struct p4tc_hdrfield_type {
+	__u16 startbit;
+	__u16 endbit;
+	__u8  datatype; /* P4T_* */
+};
+
+/* Header field attributes */
+enum {
+	P4TC_HDRFIELD_UNSPEC,
+	P4TC_HDRFIELD_DATA,
+	P4TC_HDRFIELD_NAME,
+	P4TC_HDRFIELD_PARSER_NAME,
+	__P4TC_HDRFIELD_MAX
+};
+#define P4TC_HDRFIELD_MAX (__P4TC_HDRFIELD_MAX - 1)
+
 #define P4TC_RTA(r) \
 	((struct rtattr *)(((char *)(r)) + NLMSG_ALIGN(sizeof(struct p4tcmsg))))
 
diff --git a/net/sched/p4tc/Makefile b/net/sched/p4tc/Makefile
index 0881a7563..2bcafcc2b 100644
--- a/net/sched/p4tc/Makefile
+++ b/net/sched/p4tc/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y := p4tc_types.o p4tc_tmpl_api.o p4tc_pipeline.o
+obj-y := p4tc_types.o p4tc_pipeline.o p4tc_tmpl_api.o \
+	p4tc_parser_api.o p4tc_hdrfield.o
diff --git a/net/sched/p4tc/p4tc_hdrfield.c b/net/sched/p4tc/p4tc_hdrfield.c
new file mode 100644
index 000000000..65c579d0b
--- /dev/null
+++ b/net/sched/p4tc/p4tc_hdrfield.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_hdrfield.c	P4 TC HEADER FIELD
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
+
+static const struct nla_policy tc_hdrfield_policy[P4TC_HDRFIELD_MAX + 1] = {
+	[P4TC_HDRFIELD_DATA] =
+		NLA_POLICY_EXACT_LEN(sizeof(struct p4tc_hdrfield_type)),
+	[P4TC_HDRFIELD_NAME] = { .type = NLA_STRING, .len = HDRFIELDNAMSIZ },
+	[P4TC_HDRFIELD_PARSER_NAME] = { .type = NLA_STRING,
+					.len = PARSERNAMSIZ },
+};
+
+static int __p4tc_hdrfield_put(struct p4tc_pipeline *pipeline,
+			       struct p4tc_hdrfield *hdrfield, bool teardown,
+			       struct netlink_ext_ack *extack)
+{
+	struct p4tc_parser *parser;
+
+	if (!teardown && !p4tc_hdrfield_put_ref(hdrfield)) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to delete referenced header field");
+		return -EBUSY;
+	}
+
+	parser = pipeline->parser;
+	idr_remove(&parser->hdrfield_idr, hdrfield->hdrfield_id);
+	tcf_parser_put(parser);
+
+	kfree(hdrfield);
+
+	return 0;
+}
+
+static int p4tc_hdrfield_put(struct p4tc_pipeline *pipeline,
+			     struct p4tc_template_common *tmpl,
+			     struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield;
+
+	hdrfield = to_hdrfield(tmpl);
+
+	return __p4tc_hdrfield_put(pipeline, hdrfield, true, extack);
+}
+
+static struct p4tc_hdrfield *hdrfield_find_name(struct p4tc_parser *parser,
+						const char *hdrfield_name)
+{
+	struct p4tc_hdrfield *hdrfield;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&parser->hdrfield_idr, hdrfield, tmp, id)
+		if (strncmp(hdrfield->common.name, hdrfield_name,
+			    HDRFIELDNAMSIZ) == 0)
+			return hdrfield;
+
+	return NULL;
+}
+
+struct p4tc_hdrfield *p4tc_hdrfield_find_byid(struct p4tc_parser *parser,
+					      const u32 hdrfield_id)
+{
+	return idr_find(&parser->hdrfield_idr, hdrfield_id);
+}
+
+struct p4tc_hdrfield *p4tc_hdrfield_find_byany(struct p4tc_parser *parser,
+					       const char *hdrfield_name,
+					       u32 hdrfield_id,
+					       struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield;
+	int err;
+
+	if (hdrfield_id) {
+		hdrfield = p4tc_hdrfield_find_byid(parser, hdrfield_id);
+		if (!hdrfield) {
+			NL_SET_ERR_MSG(extack, "Unable to find hdrfield by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (hdrfield_name) {
+			hdrfield = hdrfield_find_name(parser, hdrfield_name);
+			if (!hdrfield) {
+				NL_SET_ERR_MSG(extack,
+					       "Header field name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify hdrfield name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return hdrfield;
+
+out:
+	return ERR_PTR(err);
+}
+
+struct p4tc_hdrfield *p4tc_hdrfield_find_get(struct p4tc_parser *parser,
+					     const char *hdrfield_name,
+					     u32 hdrfield_id,
+					     struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield;
+
+	hdrfield = p4tc_hdrfield_find_byany(parser, hdrfield_name, hdrfield_id,
+					    extack);
+	if (IS_ERR(hdrfield))
+		return hdrfield;
+
+	if (!refcount_inc_not_zero(&hdrfield->hdrfield_ref)) {
+		NL_SET_ERR_MSG(extack, "Header field is stale");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return hdrfield;
+}
+
+static struct p4tc_hdrfield *
+p4tc_hdrfield_find_byanyattr(struct p4tc_parser *parser,
+			     struct nlattr *name_attr, u32 hdrfield_id,
+			     struct netlink_ext_ack *extack)
+{
+	char *hdrfield_name = NULL;
+
+	if (name_attr)
+		hdrfield_name = nla_data(name_attr);
+
+	return p4tc_hdrfield_find_byany(parser, hdrfield_name, hdrfield_id,
+					extack);
+}
+
+static struct p4tc_hdrfield *p4tc_hdrfield_create(struct nlmsghdr *n,
+						  struct nlattr *nla,
+						  struct p4tc_pipeline *pipeline,
+						  u32 *ids,
+						  struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_HDRFIELD_MAX + 1];
+	u32 parser_id = ids[P4TC_PARSEID_IDX];
+	struct p4tc_hdrfield_type *hdr_arg;
+	const char *parser_name = NULL;
+	struct p4tc_hdrfield *hdrfield;
+	struct p4tc_parser *parser;
+	char *hdrfield_name = NULL;
+	u32 hdrfield_id = 0;
+	char *s;
+	int ret;
+
+	ret = nla_parse_nested(tb, P4TC_HDRFIELD_MAX, nla, tc_hdrfield_policy,
+			       extack);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	hdrfield_id = ids[P4TC_HDRFIELDID_IDX];
+	if (!hdrfield_id) {
+		NL_SET_ERR_MSG(extack, "Must specify header field id");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (NL_REQ_ATTR_CHECK(extack, nla, tb, P4TC_HDRFIELD_DATA)) {
+		NL_SET_ERR_MSG(extack, "Must supply header field data");
+		return ERR_PTR(-EINVAL);
+	}
+
+	hdr_arg = nla_data(tb[P4TC_HDRFIELD_DATA]);
+
+	if (tb[P4TC_HDRFIELD_PARSER_NAME])
+		parser_name = nla_data(tb[P4TC_HDRFIELD_PARSER_NAME]);
+
+	rcu_read_lock();
+	parser = tcf_parser_find_get(pipeline, parser_name, parser_id, NULL);
+	rcu_read_unlock();
+	if (IS_ERR(parser)) {
+		if (!parser_name) {
+			NL_SET_ERR_MSG(extack, "Must supply parser name");
+			return ERR_PTR(-EINVAL);
+		}
+
+		/* If the parser instance wasn't created, let's create it here */
+		parser = tcf_parser_create(pipeline, parser_name, parser_id,
+					   extack);
+
+		if (IS_ERR(parser))
+			return (void *)parser;
+	}
+
+	if (tb[P4TC_HDRFIELD_NAME])
+		hdrfield_name = nla_data(tb[P4TC_HDRFIELD_NAME]);
+
+	if (IS_ERR(p4tc_hdrfield_find_byany(parser, hdrfield_name, hdrfield_id,
+					    extack))) {
+		NL_SET_ERR_MSG(extack, "Header field exists");
+		ret = -EEXIST;
+		goto put_parser;
+	}
+
+	if (hdr_arg->startbit > hdr_arg->endbit) {
+		NL_SET_ERR_MSG(extack, "Header field startbit > endbit");
+		ret = -EINVAL;
+		goto put_parser;
+	}
+
+	hdrfield = kzalloc(sizeof(*hdrfield), GFP_KERNEL);
+	if (!hdrfield) {
+		NL_SET_ERR_MSG(extack, "Failed to allocate hdrfield");
+		ret = -ENOMEM;
+		goto put_parser;
+	}
+
+	hdrfield->hdrfield_id = hdrfield_id;
+
+	s = strnchr(hdrfield_name, HDRFIELDNAMSIZ, '/');
+	if (s++ && strncmp(s, "isValid", HDRFIELDNAMSIZ) == 0) {
+		if (hdr_arg->datatype != P4T_U8 || hdr_arg->startbit != 0 ||
+		    hdr_arg->endbit != 0) {
+			NL_SET_ERR_MSG(extack,
+				       "isValid data type must be bit1");
+			ret = -EINVAL;
+			goto free_hdr;
+		}
+		hdrfield->datatype = hdr_arg->datatype;
+		hdrfield->flags = P4TC_HDRFIELD_IS_VALIDITY_BIT;
+	} else {
+		if (!p4type_find_byid(hdr_arg->datatype)) {
+			NL_SET_ERR_MSG(extack, "Invalid hdrfield data type");
+			ret = -EINVAL;
+			goto free_hdr;
+		}
+		hdrfield->datatype = hdr_arg->datatype;
+	}
+
+	hdrfield->startbit = hdr_arg->startbit;
+	hdrfield->endbit = hdr_arg->endbit;
+
+	ret = idr_alloc_u32(&parser->hdrfield_idr, hdrfield, &hdrfield_id,
+			    hdrfield_id, GFP_KERNEL);
+	if (ret < 0) {
+		NL_SET_ERR_MSG(extack, "Unable to allocate ID for hdrfield");
+		goto free_hdr;
+	}
+
+	hdrfield->common.p_id = pipeline->common.p_id;
+	hdrfield->common.ops = (struct p4tc_template_ops *)&p4tc_hdrfield_ops;
+	hdrfield->parser = parser;
+	refcount_set(&hdrfield->hdrfield_ref, 1);
+
+	if (hdrfield_name)
+		strscpy(hdrfield->common.name, hdrfield_name, HDRFIELDNAMSIZ);
+
+	return hdrfield;
+
+free_hdr:
+	kfree(hdrfield);
+
+put_parser:
+	tcf_parser_put(parser);
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+p4tc_hdrfield_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		 struct p4tc_path_nlattrs *nl_path_attrs,
+		 struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	u32 pipeid = ids[P4TC_PID_IDX];
+	struct p4tc_hdrfield *hdrfield;
+	struct p4tc_pipeline *pipeline;
+
+	if (p4tc_tmpl_msg_is_update(n)) {
+		NL_SET_ERR_MSG(extack, "Header field update not supported");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	pipeline = p4tc_pipeline_find_byany_unsealed(net, nl_path_attrs->pname,
+						     pipeid, extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	hdrfield = p4tc_hdrfield_create(n, nla, pipeline, ids, extack);
+	if (IS_ERR(hdrfield))
+		goto out;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+out:
+	return (struct p4tc_template_common *)hdrfield;
+}
+
+static int _p4tc_hdrfield_fill_nlmsg(struct sk_buff *skb,
+				     struct p4tc_hdrfield *hdrfield)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_hdrfield_type hdr_arg = {0};
+	struct nlattr *nest;
+	/* Parser instance id + header field id */
+	u32 ids[2];
+
+	ids[0] = hdrfield->parser->parser_id;
+	ids[1] = hdrfield->hdrfield_id;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(ids), ids))
+		goto out_nlmsg_trim;
+
+	nest = nla_nest_start(skb, P4TC_PARAMS);
+	if (!nest)
+		goto out_nlmsg_trim;
+
+	hdr_arg.datatype = hdrfield->datatype;
+	hdr_arg.startbit = hdrfield->startbit;
+	hdr_arg.endbit = hdrfield->endbit;
+
+	if (hdrfield->common.name[0]) {
+		if (nla_put_string(skb, P4TC_HDRFIELD_NAME,
+				   hdrfield->common.name))
+			goto out_nlmsg_trim;
+	}
+
+	if (nla_put(skb, P4TC_HDRFIELD_DATA, sizeof(hdr_arg), &hdr_arg))
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
+static int p4tc_hdrfield_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				    struct p4tc_template_common *template,
+				    struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield = to_hdrfield(template);
+
+	if (_p4tc_hdrfield_fill_nlmsg(skb, hdrfield) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for pipeline");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int p4tc_hdrfield_flush(struct sk_buff *skb,
+			       struct p4tc_pipeline *pipeline,
+			       struct p4tc_parser *parser,
+			       struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_hdrfield *hdrfield;
+	unsigned long tmp, hdrfield_id;
+	int ret = 0;
+	u32 path[2];
+	int i = 0;
+
+	path[0] = parser->parser_id;
+	path[1] = 0;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	if (idr_is_empty(&parser->hdrfield_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no header fields to flush");
+		goto out_nlmsg_trim;
+	}
+
+	idr_for_each_entry_ul(&parser->hdrfield_idr, hdrfield, tmp,
+			      hdrfield_id) {
+		if (__p4tc_hdrfield_put(pipeline, hdrfield, false, extack) < 0) {
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
+				       "Unable to flush any header fields");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Flush only %u header fields", i);
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
+static int p4tc_hdrfield_gd(struct net *net, struct sk_buff *skb,
+			    struct nlmsghdr *n, struct nlattr *nla,
+			    struct p4tc_path_nlattrs *nl_path_attrs,
+			    struct netlink_ext_ack *extack)
+{
+	u32 *ids = nl_path_attrs->ids;
+	struct nlattr *tb[P4TC_HDRFIELD_MAX + 1] = {NULL};
+	u32 parser_inst_id = ids[P4TC_PARSEID_IDX];
+	u32 hdrfield_id = ids[P4TC_HDRFIELDID_IDX];
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 pipeid = ids[P4TC_PID_IDX];
+	struct p4tc_hdrfield *hdrfield;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_parser *parser;
+	char *parser_name;
+	int ret;
+
+	pipeline = p4tc_pipeline_find_byany(net, nl_path_attrs->pname, pipeid,
+					    extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	if (nla) {
+		ret = nla_parse_nested(tb, P4TC_HDRFIELD_MAX, nla,
+				       tc_hdrfield_policy, extack);
+		if (ret < 0)
+			return ret;
+	}
+
+	parser_name = tb[P4TC_HDRFIELD_PARSER_NAME] ?
+		nla_data(tb[P4TC_HDRFIELD_PARSER_NAME]) : NULL;
+
+	parser = tcf_parser_find_byany(pipeline, parser_name, parser_inst_id,
+				       extack);
+	if (IS_ERR(parser))
+		return PTR_ERR(parser);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!nl_path_attrs->pname_passed)
+		strscpy(nl_path_attrs->pname, pipeline->common.name,
+			PIPELINENAMSIZ);
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && n->nlmsg_flags & NLM_F_ROOT)
+		return p4tc_hdrfield_flush(skb, pipeline, parser, extack);
+
+	hdrfield = p4tc_hdrfield_find_byanyattr(parser, tb[P4TC_HDRFIELD_NAME],
+						hdrfield_id, extack);
+	if (IS_ERR(hdrfield))
+		return PTR_ERR(hdrfield);
+
+	ret = _p4tc_hdrfield_fill_nlmsg(skb, hdrfield);
+	if (ret < 0)
+		return -ENOMEM;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = __p4tc_hdrfield_put(pipeline, hdrfield, false, extack);
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
+static int p4tc_hdrfield_dump_1(struct sk_buff *skb,
+				struct p4tc_template_common *common)
+{
+	struct nlattr *param = nla_nest_start(skb, P4TC_PARAMS);
+	struct p4tc_hdrfield *hdrfield = to_hdrfield(common);
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 path[2];
+
+	if (!param)
+		goto out_nlmsg_trim;
+
+	if (hdrfield->common.name[0] &&
+	    nla_put_string(skb, P4TC_HDRFIELD_NAME, hdrfield->common.name))
+		goto out_nlmsg_trim;
+
+	nla_nest_end(skb, param);
+
+	path[0] = hdrfield->parser->parser_id;
+	path[1] = hdrfield->hdrfield_id;
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
+static int p4tc_hdrfield_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			      struct nlattr *nla, char **p_name, u32 *ids,
+			      struct netlink_ext_ack *extack)
+{
+	struct nlattr *tb[P4TC_HDRFIELD_MAX + 1] = { NULL };
+	const u32 pipeid = ids[P4TC_PID_IDX];
+	struct net *net = sock_net(skb->sk);
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_parser *parser;
+	int ret;
+
+	if (!ctx->ids[P4TC_PID_IDX]) {
+		pipeline =
+			p4tc_pipeline_find_byany(net, *p_name, pipeid, extack);
+		if (IS_ERR(pipeline))
+			return PTR_ERR(pipeline);
+		ctx->ids[P4TC_PID_IDX] = pipeline->common.p_id;
+	} else {
+		pipeline = p4tc_pipeline_find_byid(net, ctx->ids[P4TC_PID_IDX]);
+	}
+
+	if (!ctx->ids[P4TC_PARSEID_IDX]) {
+		if (nla) {
+			ret = nla_parse_nested(tb, P4TC_HDRFIELD_MAX, nla,
+					       tc_hdrfield_policy, extack);
+			if (ret < 0)
+				return ret;
+		}
+
+		parser = tcf_parser_find_byany(pipeline,
+					       nla_data(tb[P4TC_HDRFIELD_PARSER_NAME]),
+					       ids[P4TC_PARSEID_IDX], extack);
+		if (IS_ERR(parser))
+			return PTR_ERR(parser);
+
+		ctx->ids[P4TC_PARSEID_IDX] = parser->parser_id;
+	} else {
+		parser = pipeline->parser;
+	}
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+	if (!(*p_name))
+		*p_name = pipeline->common.name;
+
+	return p4tc_tmpl_generic_dump(skb, ctx, &parser->hdrfield_idr,
+				      P4TC_HDRFIELDID_IDX, extack);
+}
+
+const struct p4tc_template_ops p4tc_hdrfield_ops = {
+	.init = NULL,
+	.cu = p4tc_hdrfield_cu,
+	.fill_nlmsg = p4tc_hdrfield_fill_nlmsg,
+	.gd = p4tc_hdrfield_gd,
+	.put = p4tc_hdrfield_put,
+	.dump = p4tc_hdrfield_dump,
+	.dump_1 = p4tc_hdrfield_dump_1,
+};
diff --git a/net/sched/p4tc/p4tc_parser_api.c b/net/sched/p4tc/p4tc_parser_api.c
new file mode 100644
index 000000000..2d79156ab
--- /dev/null
+++ b/net/sched/p4tc/p4tc_parser_api.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * net/sched/p4tc_parser_api.c	P4 TC PARSER API
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
+#include <linux/err.h>
+#include <linux/module.h>
+#include <net/net_namespace.h>
+#include <net/pkt_cls.h>
+#include <net/p4tc.h>
+#include <net/netlink.h>
+
+static struct p4tc_parser *
+p4tc_parser_find_byname(struct p4tc_pipeline *pipeline, const char *parser_name)
+{
+	if (unlikely(!pipeline->parser))
+		return NULL;
+
+	if (!strncmp(pipeline->parser->parser_name, parser_name, PARSERNAMSIZ))
+		return pipeline->parser;
+
+	return NULL;
+}
+
+static struct p4tc_parser *
+p4tc_parser_find_byid(struct p4tc_pipeline *pipeline, const u32 parser_id)
+{
+	if (unlikely(!pipeline->parser))
+		return NULL;
+
+	if (parser_id == pipeline->parser->parser_id)
+		return pipeline->parser;
+
+	return NULL;
+}
+
+struct p4tc_parser *tcf_parser_find_byany(struct p4tc_pipeline *pipeline,
+					  const char *parser_name,
+					  u32 parser_id,
+					  struct netlink_ext_ack *extack)
+{
+	struct p4tc_parser *parser;
+	int err;
+
+	if (parser_id) {
+		parser = p4tc_parser_find_byid(pipeline, parser_id);
+		if (!parser) {
+			NL_SET_ERR_MSG(extack, "Unable to find parser by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (parser_name) {
+			parser = p4tc_parser_find_byname(pipeline, parser_name);
+			if (!parser) {
+				NL_SET_ERR_MSG(extack, "Parser name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Must specify parser name or id");
+			err = -EINVAL;
+			goto out;
+		}
+	}
+
+	return parser;
+
+out:
+	return ERR_PTR(err);
+}
+
+struct p4tc_parser *tcf_parser_find_get(struct p4tc_pipeline *pipeline,
+					const char *parser_name, u32 parser_id,
+					struct netlink_ext_ack *extack)
+{
+	struct p4tc_parser *parser;
+
+	parser =
+		tcf_parser_find_byany(pipeline, parser_name, parser_id, extack);
+	if (IS_ERR(parser))
+		return parser;
+
+	if (!refcount_inc_not_zero(&parser->parser_ref)) {
+		NL_SET_ERR_MSG(extack, "Parser is stale");
+		return ERR_PTR(-EINVAL);
+	}
+
+	return parser;
+}
+
+struct p4tc_parser *tcf_parser_create(struct p4tc_pipeline *pipeline,
+				      const char *parser_name, u32 parser_id,
+				      struct netlink_ext_ack *extack)
+{
+	struct p4tc_parser *parser;
+
+	if (pipeline->parser) {
+		NL_SET_ERR_MSG(extack,
+			       "Can only have one parser instance per pipeline");
+		return ERR_PTR(-EEXIST);
+	}
+
+	parser = kzalloc(sizeof(*parser), GFP_KERNEL);
+	if (!parser)
+		return ERR_PTR(-ENOMEM);
+
+	parser->parser_id = parser_id ?: 1;
+
+	strscpy(parser->parser_name, parser_name, PARSERNAMSIZ);
+
+	refcount_set(&parser->parser_ref, 1);
+
+	idr_init(&parser->hdrfield_idr);
+
+	pipeline->parser = parser;
+
+	return parser;
+}
+
+int tcf_parser_del(struct net *net, struct p4tc_pipeline *pipeline,
+		   struct p4tc_parser *parser, struct netlink_ext_ack *extack)
+{
+	unsigned long hdr_field_id, tmp;
+	struct p4tc_hdrfield *hdrfield;
+
+	idr_for_each_entry_ul(&parser->hdrfield_idr, hdrfield, tmp,
+			      hdr_field_id)
+		hdrfield->common.ops->put(pipeline, &hdrfield->common, extack);
+
+	idr_destroy(&parser->hdrfield_idr);
+
+	pipeline->parser = NULL;
+
+	kfree(parser);
+
+	return 0;
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index fc6e49573..8e4e2320f 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -98,6 +98,9 @@ static void p4tc_pipeline_teardown(struct p4tc_pipeline *pipeline,
 
 	idr_remove(&pipe_net->pipeline_idr, pipeline->common.p_id);
 
+	if (pipeline->parser)
+		tcf_parser_del(net, pipeline, pipeline->parser, extack);
+
 	/* If we are on netns cleanup we can't touch the pipeline_idr.
 	 * On pre_exit we will destroy the idr but never call into teardown
 	 * if filters are active which makes pipeline pointers dangle until
@@ -248,6 +251,8 @@ static struct p4tc_pipeline *p4tc_pipeline_create(struct net *net,
 	else
 		pipeline->num_tables = P4TC_DEFAULT_NUM_TABLES;
 
+	pipeline->parser = NULL;
+
 	pipeline->p_state = P4TC_STATE_NOT_READY;
 
 	pipeline->net = net;
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index c6eaaf47b..e6f3a1ca1 100644
--- a/net/sched/p4tc/p4tc_tmpl_api.c
+++ b/net/sched/p4tc/p4tc_tmpl_api.c
@@ -42,6 +42,7 @@ static bool obj_is_valid(u32 obj)
 {
 	switch (obj) {
 	case P4TC_OBJ_PIPELINE:
+	case P4TC_OBJ_HDR_FIELD:
 		return true;
 	default:
 		return false;
@@ -50,6 +51,7 @@ static bool obj_is_valid(u32 obj)
 
 static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX + 1] = {
 	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
+	[P4TC_OBJ_HDR_FIELD] = &p4tc_hdrfield_ops,
 };
 
 int p4tc_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
@@ -124,6 +126,11 @@ static int tc_ctl_p4_tmpl_gd_1(struct net *net, struct sk_buff *skb,
 
 	ids[P4TC_PID_IDX] = t->pipeid;
 
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
 	nl_path_attrs->ids = ids;
 
 	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
@@ -311,6 +318,12 @@ p4tc_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
 	}
 
 	ids[P4TC_PID_IDX] = t->pipeid;
+
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
 	nl_path_attrs->ids = ids;
 
 	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
@@ -504,6 +517,11 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
 	root = nla_nest_start(skb, P4TC_ROOT);
 
 	ids[P4TC_PID_IDX] = t->pipeid;
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
 
 	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
 	ret = op->dump(skb, ctx, tb[P4TC_PARAMS], &p_name, ids, extack);
-- 
2.34.1


