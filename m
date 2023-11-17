Return-Path: <netdev+bounces-48518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B45E37EEA84
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 02:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9E1281263
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC8A80D;
	Fri, 17 Nov 2023 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF9fqcr6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7CC5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 17:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700182846; x=1731718846;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yLtlJyO0tkWDbKoFrAbENpmApFShStN3c3UUVwwIk8E=;
  b=LF9fqcr6xWftsk8srNjZONxPgOVXtpHlYw1h4r0Tv44CAjb+DI5f/X0C
   63t/cjZpfNtft+d1OCcm+44lgiSYiqrTgnOUm+CWLp0wnt9rBDiU93kJb
   IMFBQOi/M+8/VG2K/PpFc1q6SWReDk8gwtIr6DMU+HOT9u2LYWtFQVatN
   LYCJuAkzJhYbwIXGbONmCininA5feZtPwkkdPrV+w6uLXbq/F9cccQnBq
   7+1mQE6cLuisqH9Zt8+Jj5xT/a5FxRA5gg5YaLZLuoN7Tr12LfkcC+GM7
   1JWtHjehOgYe4q97fdAoNJOjzpJC4arNmoUFuxEm4A3JN2KLcHZsKaHX+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="381605241"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="381605241"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 17:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="759019599"
X-IronPort-AV: E=Sophos;i="6.04,205,1695711600"; 
   d="scan'208";a="759019599"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga007.jf.intel.com with ESMTP; 16 Nov 2023 17:00:45 -0800
Subject: [net-next PATCH v8 05/10] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Thu, 16 Nov 2023 17:17:04 -0800
Message-ID: <170018382407.3767.3366552744648120685.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add support in netlink spec(netdev.yaml) for napi related information.
Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |   30 ++++++++
 include/uapi/linux/netdev.h             |    9 ++
 net/core/netdev-genl-gen.c              |   24 ++++++
 net/core/netdev-genl-gen.h              |    2 +
 net/core/netdev-genl.c                  |   10 +++
 tools/include/uapi/linux/netdev.h       |    9 ++
 tools/net/ynl/generated/netdev-user.c   |  124 +++++++++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   |   75 +++++++++++++++++++
 8 files changed, 283 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index f9382b7705ab..d68ab270618e 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -91,6 +91,19 @@ attribute-sets:
         type: u64
         enum: xdp-rx-metadata
 
+  -
+    name: napi
+    attributes:
+      -
+        name: ifindex
+        doc: ifindex of the netdevice to which NAPI instance belongs.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: id
+        doc: ID of the NAPI instance.
+        type: u32
   -
     name: queue
     attributes:
@@ -172,6 +185,23 @@ operations:
           attributes:
             - ifindex
         reply: *queue-get-op
+    -
+      name: napi-get
+      doc: Get information about NAPI instances configured on the system.
+      attribute-set: napi
+      do:
+        request:
+          attributes:
+            - id
+        reply: &napi-get-op
+          attributes:
+            - id
+            - ifindex
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply: *napi-get-op
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index c440017241f0..ee590cbb9782 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -69,6 +69,14 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_NAPI_IFINDEX = 1,
+	NETDEV_A_NAPI_ID,
+
+	__NETDEV_A_NAPI_MAX,
+	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -85,6 +93,7 @@ enum {
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 97ee7ebbad57..0dc618a99304 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -27,6 +27,16 @@ static const struct nla_policy netdev_queue_get_dump_nl_policy[NETDEV_A_QUEUE_IF
 	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_NAPI_GET - do */
+static const struct nla_policy netdev_napi_get_do_nl_policy[NETDEV_A_NAPI_ID + 1] = {
+	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
+};
+
+/* NETDEV_CMD_NAPI_GET - dump */
+static const struct nla_policy netdev_napi_get_dump_nl_policy[NETDEV_A_NAPI_IFINDEX + 1] = {
+	[NETDEV_A_NAPI_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -55,6 +65,20 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.maxattr	= NETDEV_A_QUEUE_IFINDEX,
 		.flags		= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_NAPI_GET,
+		.doit		= netdev_nl_napi_get_doit,
+		.policy		= netdev_napi_get_do_nl_policy,
+		.maxattr	= NETDEV_A_NAPI_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NETDEV_CMD_NAPI_GET,
+		.dumpit		= netdev_nl_napi_get_dumpit,
+		.policy		= netdev_napi_get_dump_nl_policy,
+		.maxattr	= NETDEV_A_NAPI_IFINDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 263c94f77bad..ffc94956d1f5 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -16,6 +16,8 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
+int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fa64a4378166..9386058146a1 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -144,6 +144,16 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
 static int
 netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
 			 u32 q_idx, u32 q_type, const struct genl_info *info)
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index c440017241f0..ee590cbb9782 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -69,6 +69,14 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_NAPI_IFINDEX = 1,
+	NETDEV_A_NAPI_ID,
+
+	__NETDEV_A_NAPI_MAX,
+	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -85,6 +93,7 @@ enum {
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 87845c707b95..a49265f4f4d9 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -19,6 +19,7 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
 	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
 	[NETDEV_CMD_QUEUE_GET] = "queue-get",
+	[NETDEV_CMD_NAPI_GET] = "napi-get",
 };
 
 const char *netdev_op_str(int op)
@@ -97,6 +98,16 @@ struct ynl_policy_nest netdev_queue_nest = {
 	.table = netdev_queue_policy,
 };
 
+struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
+	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_ID] = { .name = "id", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest netdev_napi_nest = {
+	.max_attr = NETDEV_A_NAPI_MAX,
+	.table = netdev_napi_policy,
+};
+
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
@@ -350,6 +361,119 @@ netdev_queue_get_dump(struct ynl_sock *ys,
 	return NULL;
 }
 
+/* ============== NETDEV_CMD_NAPI_GET ============== */
+/* NETDEV_CMD_NAPI_GET - do */
+void netdev_napi_get_req_free(struct netdev_napi_get_req *req)
+{
+	free(req);
+}
+
+void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp)
+{
+	free(rsp);
+}
+
+int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct ynl_parse_arg *yarg = data;
+	struct netdev_napi_get_rsp *dst;
+	const struct nlattr *attr;
+
+	dst = yarg->data;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NETDEV_A_NAPI_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.id = 1;
+			dst->id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_IFINDEX) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.ifindex = 1;
+			dst->ifindex = mnl_attr_get_u32(attr);
+		}
+	}
+
+	return MNL_CB_OK;
+}
+
+struct netdev_napi_get_rsp *
+netdev_napi_get(struct ynl_sock *ys, struct netdev_napi_get_req *req)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct netdev_napi_get_rsp *rsp;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_NAPI_GET, 1);
+	ys->req_policy = &netdev_napi_nest;
+	yrs.yarg.rsp_policy = &netdev_napi_nest;
+
+	if (req->_present.id)
+		mnl_attr_put_u32(nlh, NETDEV_A_NAPI_ID, req->id);
+
+	rsp = calloc(1, sizeof(*rsp));
+	yrs.yarg.data = rsp;
+	yrs.cb = netdev_napi_get_rsp_parse;
+	yrs.rsp_cmd = NETDEV_CMD_NAPI_GET;
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		goto err_free;
+
+	return rsp;
+
+err_free:
+	netdev_napi_get_rsp_free(rsp);
+	return NULL;
+}
+
+/* NETDEV_CMD_NAPI_GET - dump */
+void netdev_napi_get_list_free(struct netdev_napi_get_list *rsp)
+{
+	struct netdev_napi_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp);
+	}
+}
+
+struct netdev_napi_get_list *
+netdev_napi_get_dump(struct ynl_sock *ys, struct netdev_napi_get_req_dump *req)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct netdev_napi_get_list);
+	yds.cb = netdev_napi_get_rsp_parse;
+	yds.rsp_cmd = NETDEV_CMD_NAPI_GET;
+	yds.rsp_policy = &netdev_napi_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NETDEV_CMD_NAPI_GET, 1);
+	ys->req_policy = &netdev_napi_nest;
+
+	if (req->_present.ifindex)
+		mnl_attr_put_u32(nlh, NETDEV_A_NAPI_IFINDEX, req->ifindex);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	netdev_napi_get_list_free(yds.first);
+	return NULL;
+}
+
 static const struct ynl_ntf_info netdev_ntf_info[] =  {
 	[NETDEV_CMD_DEV_ADD_NTF] =  {
 		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 50d214e8819d..33ba75905ee1 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -186,4 +186,79 @@ struct netdev_queue_get_list *
 netdev_queue_get_dump(struct ynl_sock *ys,
 		      struct netdev_queue_get_req_dump *req);
 
+/* ============== NETDEV_CMD_NAPI_GET ============== */
+/* NETDEV_CMD_NAPI_GET - do */
+struct netdev_napi_get_req {
+	struct {
+		__u32 id:1;
+	} _present;
+
+	__u32 id;
+};
+
+static inline struct netdev_napi_get_req *netdev_napi_get_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_napi_get_req));
+}
+void netdev_napi_get_req_free(struct netdev_napi_get_req *req);
+
+static inline void
+netdev_napi_get_req_set_id(struct netdev_napi_get_req *req, __u32 id)
+{
+	req->_present.id = 1;
+	req->id = id;
+}
+
+struct netdev_napi_get_rsp {
+	struct {
+		__u32 id:1;
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 id;
+	__u32 ifindex;
+};
+
+void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);
+
+/*
+ * Get information about NAPI instances configured on the system.
+ */
+struct netdev_napi_get_rsp *
+netdev_napi_get(struct ynl_sock *ys, struct netdev_napi_get_req *req);
+
+/* NETDEV_CMD_NAPI_GET - dump */
+struct netdev_napi_get_req_dump {
+	struct {
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 ifindex;
+};
+
+static inline struct netdev_napi_get_req_dump *
+netdev_napi_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_napi_get_req_dump));
+}
+void netdev_napi_get_req_dump_free(struct netdev_napi_get_req_dump *req);
+
+static inline void
+netdev_napi_get_req_dump_set_ifindex(struct netdev_napi_get_req_dump *req,
+				     __u32 ifindex)
+{
+	req->_present.ifindex = 1;
+	req->ifindex = ifindex;
+}
+
+struct netdev_napi_get_list {
+	struct netdev_napi_get_list *next;
+	struct netdev_napi_get_rsp obj __attribute__((aligned(8)));
+};
+
+void netdev_napi_get_list_free(struct netdev_napi_get_list *rsp);
+
+struct netdev_napi_get_list *
+netdev_napi_get_dump(struct ynl_sock *ys, struct netdev_napi_get_req_dump *req);
+
 #endif /* _LINUX_NETDEV_GEN_H */


