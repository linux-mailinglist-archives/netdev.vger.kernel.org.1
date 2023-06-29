Return-Path: <netdev+bounces-14529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F9A742432
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4CF01C20967
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F0F15491;
	Thu, 29 Jun 2023 10:46:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906C7154A8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:46:04 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB8E1BE8
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7672073e7b9so43293185a.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035560; x=1690627560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzcM6Lj+nQBoLTNmO9Gu5Ft9E493NlKvy8lnkILBqls=;
        b=V8VtQr0+pbWYUb5L11sPihlVTy48h0RjbSQz0+MKp7aTG6lxe+r+QCJycomBL3Atfx
         ZT076XFRlZVuYwt887jrsJ3xg7zzMaaWWIzTmVakRZqvYx5S88DtYJusDDFhTaJ6e8Ct
         Ddgo/dIY/VbblRG7dgzhnfoMAdWHQ+6pd1HufjnUON4zZY5TYkP+L00Q5wmMzzWevxqI
         asxT9FZcLg+Skn4eXirLL1uinohCjrM7Rn+EmERXemcZZf6jMNFQRyC+MkqnBFeBmIzF
         buXtb4xVljC0Sf9/6woLrg05QZ56yi1sFiJf0acKfJVhVY5LX98xkm++Na2CZkY+gJG4
         y4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035560; x=1690627560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzcM6Lj+nQBoLTNmO9Gu5Ft9E493NlKvy8lnkILBqls=;
        b=dgDhZIKhcPNKoWtXCyJDw6XOAgwiBVA4/XGGcARixr4ORXe9vo5k/d+IwVDa/ianGQ
         /HnqmgAqIQw9ZgvFx8exl47nbaOoN+f4ZenSdIPZBSKVs7yYrilIx+VwIZ2xbLXMQ3mr
         PxEpL6nEeYw+WIsJBtadX+BGdqP/DXdd7ifzizuVeUbQyr/Gey4lwAx6X6APpo8CRHkI
         Oeo5IvUuM9AACwDFPQqQxMQpFD0HIzGBotmfMg6LGWus1ouoVW7X231Fbe7Loogc8ocv
         9n/25o5/Ch/uakTu4sDad1BiKmGm2yMQbjkO82jdACGWLxkDB/Y0oh2tr4pdGlAGLKO7
         ksbA==
X-Gm-Message-State: AC+VfDyHc2/TQ2p6OlGdzHulp8Ec18GErBLvNKnMaZQIC8A133WUt3ed
	/njhmfhlXLX5MXUHufDUHYkFgVvhA406rn4hcLs=
X-Google-Smtp-Source: ACHHUZ7BxpVvF9pfsP1Cc+KxHk+Yvy33QaFlr74CK7oBXNt861WZKCsFazDCG9T6h0WGF9TuWNdxBQ==
X-Received: by 2002:a05:6214:410:b0:61b:79ab:7129 with SMTP id z16-20020a056214041000b0061b79ab7129mr51194270qvx.37.1688035559502;
        Thu, 29 Jun 2023 03:45:59 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:59 -0700 (PDT)
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
Subject: [PATCH RFC v3 net-next 09/21] p4tc: add header field create, get, delete, flush and dump
Date: Thu, 29 Jun 2023 06:45:26 -0400
Message-Id: <20230629104538.40863-10-jhs@mojatatu.com>
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

This commit allows control to create, get, delete, flush and dump header
field objects. The created header fields are retrieved at runtime by
the parser. From a control plane interaction, a header field can only be
created once the appropriate parser is instantiated.

Header fields are part of a pipeline and a parser instance and header
fields can only be created in an unsealed pipeline.

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
 include/net/p4tc.h               |  53 +++
 include/uapi/linux/p4tc.h        |  21 ++
 net/sched/p4tc/Makefile          |   3 +-
 net/sched/p4tc/p4tc_hdrfield.c   | 597 +++++++++++++++++++++++++++++++
 net/sched/p4tc/p4tc_parser_api.c | 146 ++++++++
 net/sched/p4tc/p4tc_pipeline.c   |   4 +
 net/sched/p4tc/p4tc_tmpl_api.c   |  19 +
 7 files changed, 842 insertions(+), 1 deletion(-)
 create mode 100644 net/sched/p4tc/p4tc_hdrfield.c
 create mode 100644 net/sched/p4tc/p4tc_parser_api.c

diff --git a/include/net/p4tc.h b/include/net/p4tc.h
index a2c9d6cc1..5b8df17fb 100644
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
@@ -63,6 +67,7 @@ struct p4tc_pipeline {
 	struct p4tc_template_common common;
 	struct rcu_head             rcu;
 	struct net                  *net;
+	struct p4tc_parser          *parser;
 	refcount_t                  p_ref;
 	refcount_t                  p_ctrl_ref;
 	u16                         num_tables;
@@ -104,6 +109,54 @@ static inline int p4tc_action_destroy(struct tc_action **acts)
 	return ret;
 }
 
+struct p4tc_parser {
+	char parser_name[PARSERNAMSIZ];
+	struct idr hdr_fields_idr;
+	refcount_t parser_ref;
+	u32 parser_inst_id;
+};
+
+struct p4tc_hdrfield {
+	struct p4tc_template_common common;
+	struct p4tc_parser          *parser;
+	u32                         parser_inst_id;
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
+				      const char *parser_name,
+				      u32 parser_inst_id,
+				      struct netlink_ext_ack *extack);
+
+struct p4tc_parser *tcf_parser_find_byid(struct p4tc_pipeline *pipeline,
+					 const u32 parser_inst_id);
+struct p4tc_parser *tcf_parser_find_byany(struct p4tc_pipeline *pipeline,
+					  const char *parser_name,
+					  u32 parser_inst_id,
+					  struct netlink_ext_ack *extack);
+int tcf_parser_del(struct net *net, struct p4tc_pipeline *pipeline,
+		   struct p4tc_parser *parser, struct netlink_ext_ack *extack);
+
+struct p4tc_hdrfield *tcf_hdrfield_find_byid(struct p4tc_parser *parser,
+					     const u32 hdrfield_id);
+struct p4tc_hdrfield *tcf_hdrfield_find_byany(struct p4tc_parser *parser,
+					      const char *hdrfield_name,
+					      u32 hdrfield_id,
+					      struct netlink_ext_ack *extack);
+struct p4tc_hdrfield *tcf_hdrfield_get(struct p4tc_parser *parser,
+				       const char *hdrfield_name,
+				       u32 hdrfield_id,
+				       struct netlink_ext_ack *extack);
+void tcf_hdrfield_put_ref(struct p4tc_hdrfield *hdrfield);
+
 #define to_pipeline(t) ((struct p4tc_pipeline *)t)
+#define to_hdrfield(t) ((struct p4tc_hdrfield *)t)
 
 #endif
diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
index ef9e51b31..9c063235d 100644
--- a/include/uapi/linux/p4tc.h
+++ b/include/uapi/linux/p4tc.h
@@ -19,9 +19,12 @@ struct p4tcmsg {
 #define P4TC_MSGBATCH_SIZE 16
 
 #define P4TC_MAX_KEYSZ 512
+#define HEADER_MAX_LEN 512
 
 #define TEMPLATENAMSZ 256
 #define PIPELINENAMSIZ TEMPLATENAMSZ
+#define PARSERNAMSIZ TEMPLATENAMSZ
+#define HDRFIELDNAMSIZ TEMPLATENAMSZ
 
 /* Root attributes */
 enum {
@@ -48,6 +51,7 @@ enum {
 enum {
 	P4TC_OBJ_UNSPEC,
 	P4TC_OBJ_PIPELINE,
+	P4TC_OBJ_HDR_FIELD,
 	__P4TC_OBJ_MAX,
 };
 #define P4TC_OBJ_MAX __P4TC_OBJ_MAX
@@ -57,6 +61,7 @@ enum {
 	P4TC_UNSPEC,
 	P4TC_PATH,
 	P4TC_PARAMS,
+	P4TC_COUNT,
 	__P4TC_MAX,
 };
 #define P4TC_MAX __P4TC_MAX
@@ -100,6 +105,22 @@ enum {
 };
 #define P4T_MAX (__P4T_MAX - 1)
 
+struct p4tc_hdrfield_ty {
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
index 000000000..70565263a
--- /dev/null
+++ b/net/sched/p4tc/p4tc_hdrfield.c
@@ -0,0 +1,597 @@
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
+	[P4TC_HDRFIELD_DATA] = { .type = NLA_BINARY,
+				 .len = sizeof(struct p4tc_hdrfield_ty) },
+	[P4TC_HDRFIELD_NAME] = { .type = NLA_STRING, .len = HDRFIELDNAMSIZ },
+	[P4TC_HDRFIELD_PARSER_NAME] = { .type = NLA_STRING,
+					.len = PARSERNAMSIZ },
+};
+
+static int _tcf_hdrfield_put(struct p4tc_pipeline *pipeline,
+			     struct p4tc_parser *parser,
+			     struct p4tc_hdrfield *hdrfield,
+			     bool unconditional_purge,
+			     struct netlink_ext_ack *extack)
+{
+	if (!refcount_dec_if_one(&hdrfield->hdrfield_ref) &&
+	    !unconditional_purge) {
+		NL_SET_ERR_MSG(extack,
+			       "Unable to delete referenced header field");
+		return -EBUSY;
+	}
+	idr_remove(&parser->hdr_fields_idr, hdrfield->hdrfield_id);
+
+	WARN_ON(!refcount_dec_not_one(&parser->parser_ref));
+	kfree(hdrfield);
+
+	return 0;
+}
+
+static int tcf_hdrfield_put(struct net *net, struct p4tc_template_common *tmpl,
+			    bool unconditional_purge,
+			    struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_parser *parser;
+
+	pipeline = tcf_pipeline_find_byid(net, tmpl->p_id);
+
+	hdrfield = to_hdrfield(tmpl);
+	parser = pipeline->parser;
+
+	return _tcf_hdrfield_put(pipeline, parser, hdrfield,
+				 unconditional_purge, extack);
+}
+
+static struct p4tc_hdrfield *hdrfield_find_name(struct p4tc_parser *parser,
+						const char *hdrfield_name)
+{
+	struct p4tc_hdrfield *hdrfield;
+	unsigned long tmp, id;
+
+	idr_for_each_entry_ul(&parser->hdr_fields_idr, hdrfield, tmp, id)
+		if (hdrfield->common.name[0] &&
+		    strncmp(hdrfield->common.name, hdrfield_name,
+			    HDRFIELDNAMSIZ) == 0)
+			return hdrfield;
+
+	return NULL;
+}
+
+struct p4tc_hdrfield *tcf_hdrfield_find_byid(struct p4tc_parser *parser,
+					     const u32 hdrfield_id)
+{
+	return idr_find(&parser->hdr_fields_idr, hdrfield_id);
+}
+
+struct p4tc_hdrfield *tcf_hdrfield_find_byany(struct p4tc_parser *parser,
+					      const char *hdrfield_name,
+					      u32 hdrfield_id,
+					      struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield;
+	int err;
+
+	if (hdrfield_id) {
+		hdrfield = tcf_hdrfield_find_byid(parser, hdrfield_id);
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
+struct p4tc_hdrfield *tcf_hdrfield_get(struct p4tc_parser *parser,
+				       const char *hdrfield_name,
+				       u32 hdrfield_id,
+				       struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield;
+
+	hdrfield = tcf_hdrfield_find_byany(parser, hdrfield_name, hdrfield_id,
+					   extack);
+	if (IS_ERR(hdrfield))
+		return hdrfield;
+
+	/* Should never happen */
+	WARN_ON(!refcount_inc_not_zero(&hdrfield->hdrfield_ref));
+
+	return hdrfield;
+}
+
+void tcf_hdrfield_put_ref(struct p4tc_hdrfield *hdrfield)
+{
+	WARN_ON(!refcount_dec_not_one(&hdrfield->hdrfield_ref));
+}
+
+static struct p4tc_hdrfield *
+tcf_hdrfield_find_byanyattr(struct p4tc_parser *parser,
+			    struct nlattr *name_attr, u32 hdrfield_id,
+			    struct netlink_ext_ack *extack)
+{
+	char *hdrfield_name = NULL;
+
+	if (name_attr)
+		hdrfield_name = nla_data(name_attr);
+
+	return tcf_hdrfield_find_byany(parser, hdrfield_name, hdrfield_id,
+				       extack);
+}
+
+static struct p4tc_hdrfield *tcf_hdrfield_create(struct nlmsghdr *n,
+						 struct nlattr *nla,
+						 struct p4tc_pipeline *pipeline,
+						 u32 *ids,
+						 struct netlink_ext_ack *extack)
+{
+	u32 parser_id = ids[P4TC_PARSEID_IDX];
+	const char *parser_name = NULL;
+	char *hdrfield_name = NULL;
+	u32 hdrfield_id = 0;
+	struct nlattr *tb[P4TC_HDRFIELD_MAX + 1];
+	struct p4tc_hdrfield_ty *hdr_arg;
+	struct p4tc_hdrfield *hdrfield;
+	struct p4tc_parser *parser;
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
+	hdr_arg = nla_data(tb[P4TC_HDRFIELD_DATA]);
+
+	if (tb[P4TC_HDRFIELD_PARSER_NAME])
+		parser_name = nla_data(tb[P4TC_HDRFIELD_PARSER_NAME]);
+
+	rcu_read_lock();
+	parser = tcf_parser_find_byany(pipeline, parser_name, parser_id, NULL);
+	if (IS_ERR(parser)) {
+		rcu_read_unlock();
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
+		rcu_read_lock();
+	}
+
+	if (!refcount_inc_not_zero(&parser->parser_ref)) {
+		NL_SET_ERR_MSG(extack, "Parser is stale");
+		rcu_read_unlock();
+		return ERR_PTR(-EBUSY);
+	}
+	rcu_read_unlock();
+
+	if (tb[P4TC_HDRFIELD_NAME])
+		hdrfield_name = nla_data(tb[P4TC_HDRFIELD_NAME]);
+
+	if ((hdrfield_name && hdrfield_find_name(parser, hdrfield_name)) ||
+	    tcf_hdrfield_find_byid(parser, hdrfield_id)) {
+		NL_SET_ERR_MSG(extack,
+			       "Header field with same id or name was already inserted");
+		ret = -EEXIST;
+		goto refcount_dec_parser;
+	}
+
+	if (hdr_arg->startbit > hdr_arg->endbit) {
+		NL_SET_ERR_MSG(extack, "Header field startbit > endbit");
+		ret = -EINVAL;
+		goto refcount_dec_parser;
+	}
+
+	hdrfield = kzalloc(sizeof(*hdrfield), GFP_KERNEL);
+	if (!hdrfield) {
+		NL_SET_ERR_MSG(extack, "Failed to allocate hdrfield");
+		ret = -ENOMEM;
+		goto refcount_dec_parser;
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
+	hdrfield->parser_inst_id = parser->parser_inst_id;
+
+	ret = idr_alloc_u32(&parser->hdr_fields_idr, hdrfield, &hdrfield_id,
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
+refcount_dec_parser:
+	WARN_ON(!refcount_dec_not_one(&parser->parser_ref));
+	return ERR_PTR(ret);
+}
+
+static struct p4tc_template_common *
+tcf_hdrfield_cu(struct net *net, struct nlmsghdr *n, struct nlattr *nla,
+		struct p4tc_nl_pname *nl_pname, u32 *ids,
+		struct netlink_ext_ack *extack)
+{
+	u32 pipeid = ids[P4TC_PID_IDX];
+	struct p4tc_hdrfield *hdrfield;
+	struct p4tc_pipeline *pipeline;
+
+	if (n->nlmsg_flags & NLM_F_REPLACE) {
+		NL_SET_ERR_MSG(extack, "Header field update not supported");
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	pipeline = tcf_pipeline_find_byany_unsealed(net, nl_pname->data, pipeid,
+						    extack);
+	if (IS_ERR(pipeline))
+		return (void *)pipeline;
+
+	hdrfield = tcf_hdrfield_create(n, nla, pipeline, ids, extack);
+	if (IS_ERR(hdrfield))
+		goto out;
+
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (!ids[P4TC_PID_IDX])
+		ids[P4TC_PID_IDX] = pipeline->common.p_id;
+
+out:
+	return (struct p4tc_template_common *)hdrfield;
+}
+
+static int _tcf_hdrfield_fill_nlmsg(struct sk_buff *skb,
+				    struct p4tc_hdrfield *hdrfield)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	struct p4tc_hdrfield_ty hdr_arg = {0};
+	struct nlattr *nest;
+	/* Parser instance id + header field id */
+	u32 ids[2];
+
+	ids[0] = hdrfield->parser_inst_id;
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
+static int tcf_hdrfield_fill_nlmsg(struct net *net, struct sk_buff *skb,
+				   struct p4tc_template_common *template,
+				   struct netlink_ext_ack *extack)
+{
+	struct p4tc_hdrfield *hdrfield = to_hdrfield(template);
+
+	if (_tcf_hdrfield_fill_nlmsg(skb, hdrfield) <= 0) {
+		NL_SET_ERR_MSG(extack,
+			       "Failed to fill notification attributes for pipeline");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int tcf_hdrfield_flush(struct sk_buff *skb,
+			      struct p4tc_pipeline *pipeline,
+			      struct p4tc_parser *parser,
+			      struct netlink_ext_ack *extack)
+{
+	unsigned char *b = nlmsg_get_pos(skb);
+	int ret = 0;
+	int i = 0;
+	struct p4tc_hdrfield *hdrfield;
+	unsigned long tmp, hdrfield_id;
+	u32 path[2];
+
+	path[0] = parser->parser_inst_id;
+	path[1] = 0;
+
+	if (nla_put(skb, P4TC_PATH, sizeof(path), path))
+		goto out_nlmsg_trim;
+
+	if (idr_is_empty(&parser->hdr_fields_idr)) {
+		NL_SET_ERR_MSG(extack, "There are no header fields to flush");
+		goto out_nlmsg_trim;
+	}
+
+	idr_for_each_entry_ul(&parser->hdr_fields_idr, hdrfield, tmp, hdrfield_id) {
+		if (_tcf_hdrfield_put(pipeline, parser, hdrfield, false, extack) < 0) {
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
+				       "Unable to flush any table instance");
+			goto out_nlmsg_trim;
+		} else {
+			NL_SET_ERR_MSG(extack,
+				       "Unable to flush all table instances");
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
+static int tcf_hdrfield_gd(struct net *net, struct sk_buff *skb,
+			   struct nlmsghdr *n, struct nlattr *nla,
+			   struct p4tc_nl_pname *nl_pname, u32 *ids,
+			   struct netlink_ext_ack *extack)
+{
+	u32 parser_inst_id = ids[P4TC_PARSEID_IDX];
+	u32 hdrfield_id = ids[P4TC_HDRFIELDID_IDX];
+	unsigned char *b = nlmsg_get_pos(skb);
+	u32 pipeid = ids[P4TC_PID_IDX];
+	struct nlattr *tb[P4TC_HDRFIELD_MAX + 1];
+	struct p4tc_hdrfield *hdrfield;
+	struct p4tc_pipeline *pipeline;
+	struct p4tc_parser *parser;
+	char *parser_name;
+	int ret;
+
+	pipeline = tcf_pipeline_find_byany(net, nl_pname->data, pipeid, extack);
+	if (IS_ERR(pipeline))
+		return PTR_ERR(pipeline);
+
+	ret = nla_parse_nested(tb, P4TC_HDRFIELD_MAX, nla, tc_hdrfield_policy,
+			       extack);
+	if (ret < 0)
+		return ret;
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
+	if (!nl_pname->passed)
+		strscpy(nl_pname->data, pipeline->common.name, PIPELINENAMSIZ);
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE && n->nlmsg_flags & NLM_F_ROOT)
+		return tcf_hdrfield_flush(skb, pipeline, parser, extack);
+
+	hdrfield = tcf_hdrfield_find_byanyattr(parser, tb[P4TC_HDRFIELD_NAME],
+					       hdrfield_id, extack);
+	if (IS_ERR(hdrfield))
+		return PTR_ERR(hdrfield);
+
+	ret = _tcf_hdrfield_fill_nlmsg(skb, hdrfield);
+	if (ret < 0)
+		return -ENOMEM;
+
+	if (n->nlmsg_type == RTM_DELP4TEMPLATE) {
+		ret = _tcf_hdrfield_put(pipeline, parser, hdrfield, false,
+					extack);
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
+static int tcf_hdrfield_dump_1(struct sk_buff *skb,
+			       struct p4tc_template_common *common)
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
+	path[0] = hdrfield->parser_inst_id;
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
+static int tcf_hdrfield_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
+			     struct nlattr *nla, char **p_name, u32 *ids,
+			     struct netlink_ext_ack *extack)
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
+			tcf_pipeline_find_byany(net, *p_name, pipeid, extack);
+		if (IS_ERR(pipeline))
+			return PTR_ERR(pipeline);
+		ctx->ids[P4TC_PID_IDX] = pipeline->common.p_id;
+	} else {
+		pipeline = tcf_pipeline_find_byid(net, ctx->ids[P4TC_PID_IDX]);
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
+		ctx->ids[P4TC_PARSEID_IDX] = parser->parser_inst_id;
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
+	return tcf_p4_tmpl_generic_dump(skb, ctx, &parser->hdr_fields_idr,
+					P4TC_HDRFIELDID_IDX, extack);
+}
+
+const struct p4tc_template_ops p4tc_hdrfield_ops = {
+	.init = NULL,
+	.cu = tcf_hdrfield_cu,
+	.fill_nlmsg = tcf_hdrfield_fill_nlmsg,
+	.gd = tcf_hdrfield_gd,
+	.put = tcf_hdrfield_put,
+	.dump = tcf_hdrfield_dump,
+	.dump_1 = tcf_hdrfield_dump_1,
+};
diff --git a/net/sched/p4tc/p4tc_parser_api.c b/net/sched/p4tc/p4tc_parser_api.c
new file mode 100644
index 000000000..13e2a1d0e
--- /dev/null
+++ b/net/sched/p4tc/p4tc_parser_api.c
@@ -0,0 +1,146 @@
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
+static struct p4tc_parser *parser_find_name(struct p4tc_pipeline *pipeline,
+					    const char *parser_name)
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
+struct p4tc_parser *tcf_parser_find_byid(struct p4tc_pipeline *pipeline,
+					 const u32 parser_inst_id)
+{
+	if (unlikely(!pipeline->parser))
+		return NULL;
+
+	if (parser_inst_id == pipeline->parser->parser_inst_id)
+		return pipeline->parser;
+
+	return NULL;
+}
+
+static struct p4tc_parser *__parser_find(struct p4tc_pipeline *pipeline,
+					 const char *parser_name,
+					 u32 parser_inst_id,
+					 struct netlink_ext_ack *extack)
+{
+	struct p4tc_parser *parser;
+	int err;
+
+	if (parser_inst_id) {
+		parser = tcf_parser_find_byid(pipeline, parser_inst_id);
+		if (!parser) {
+			if (extack)
+				NL_SET_ERR_MSG(extack,
+					       "Unable to find parser by id");
+			err = -EINVAL;
+			goto out;
+		}
+	} else {
+		if (parser_name) {
+			parser = parser_find_name(pipeline, parser_name);
+			if (!parser) {
+				if (extack)
+					NL_SET_ERR_MSG(extack,
+						       "Parser name not found");
+				err = -EINVAL;
+				goto out;
+			}
+		} else {
+			if (extack)
+				NL_SET_ERR_MSG(extack,
+					       "Must specify parser name or id");
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
+struct p4tc_parser *tcf_parser_find_byany(struct p4tc_pipeline *pipeline,
+					  const char *parser_name,
+					  u32 parser_inst_id,
+					  struct netlink_ext_ack *extack)
+{
+	return __parser_find(pipeline, parser_name, parser_inst_id, extack);
+}
+
+struct p4tc_parser *
+tcf_parser_create(struct p4tc_pipeline *pipeline, const char *parser_name,
+		  u32 parser_inst_id, struct netlink_ext_ack *extack)
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
+	if (parser_inst_id)
+		parser->parser_inst_id = parser_inst_id;
+	else
+		parser->parser_inst_id = 1;
+
+	strscpy(parser->parser_name, parser_name, PARSERNAMSIZ);
+
+	refcount_set(&parser->parser_ref, 1);
+
+	idr_init(&parser->hdr_fields_idr);
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
+	idr_for_each_entry_ul(&parser->hdr_fields_idr, hdrfield, tmp, hdr_field_id)
+		hdrfield->common.ops->put(net, &hdrfield->common, true, extack);
+
+	idr_destroy(&parser->hdr_fields_idr);
+
+	pipeline->parser = NULL;
+
+	kfree(parser);
+
+	return 0;
+}
diff --git a/net/sched/p4tc/p4tc_pipeline.c b/net/sched/p4tc/p4tc_pipeline.c
index 4506ff2e1..8068a21f3 100644
--- a/net/sched/p4tc/p4tc_pipeline.c
+++ b/net/sched/p4tc/p4tc_pipeline.c
@@ -107,6 +107,8 @@ static int tcf_pipeline_put(struct net *net,
 	}
 
 	idr_remove(&pipe_net->pipeline_idr, pipeline->common.p_id);
+	if (pipeline->parser)
+		tcf_parser_del(net, pipeline, pipeline->parser, extack);
 
 	if (pipeline_net)
 		call_rcu(&pipeline->rcu, tcf_pipeline_destroy_rcu);
@@ -229,6 +231,8 @@ static struct p4tc_pipeline *tcf_pipeline_create(struct net *net,
 	else
 		pipeline->num_tables = P4TC_DEFAULT_NUM_TABLES;
 
+	pipeline->parser = NULL;
+
 	pipeline->p_state = P4TC_STATE_NOT_READY;
 
 	pipeline->net = net;
diff --git a/net/sched/p4tc/p4tc_tmpl_api.c b/net/sched/p4tc/p4tc_tmpl_api.c
index f844b7c29..a3d755bd2 100644
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
 
 static const struct p4tc_template_ops *p4tc_ops[P4TC_OBJ_MAX] = {
 	[P4TC_OBJ_PIPELINE] = &p4tc_pipeline_ops,
+	[P4TC_OBJ_HDR_FIELD] = &p4tc_hdrfield_ops,
 };
 
 int tcf_p4_tmpl_generic_dump(struct sk_buff *skb, struct p4tc_dump_ctx *ctx,
@@ -124,6 +126,12 @@ static int tc_ctl_p4_tmpl_gd_1(struct net *net, struct sk_buff *skb,
 
 	ids[P4TC_PID_IDX] = t->pipeid;
 
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
+
 	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
 
 	ret = op->gd(net, skb, n, tb[P4TC_PARAMS], nl_pname, ids, extack);
@@ -300,6 +308,12 @@ tcf_p4_tmpl_cu_1(struct sk_buff *skb, struct net *net, struct nlmsghdr *n,
 
 	ids[P4TC_PID_IDX] = t->pipeid;
 
+	if (tb[P4TC_PATH]) {
+		const u32 *arg_ids = nla_data(tb[P4TC_PATH]);
+
+		memcpy(&ids[P4TC_PID_IDX + 1], arg_ids, nla_len(tb[P4TC_PATH]));
+	}
+
 	op = (struct p4tc_template_ops *)p4tc_ops[t->obj];
 	tmpl = op->cu(net, n, tb[P4TC_PARAMS], nl_pname, ids, extack);
 	if (IS_ERR(tmpl))
@@ -486,6 +500,11 @@ static int tc_ctl_p4_tmpl_dump_1(struct sk_buff *skb, struct nlattr *arg,
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


