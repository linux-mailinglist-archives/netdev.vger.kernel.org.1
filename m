Return-Path: <netdev+bounces-53144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40930801754
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB17C281F40
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F6F3F8CF;
	Fri,  1 Dec 2023 23:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrMEeWm0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62419A
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 15:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701472342; x=1733008342;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=324w0I0IBQnxWZgRHhtQglnVAYapfn6RFCLgqhRKhAA=;
  b=ZrMEeWm0zIcL+0EZehkTtykngsmcLcXeDVzlx8JLVyGAb30BS9Wou0K2
   9adUu81e3/OdjssBDJgLjSpq6Si8pq5GkZyoEv7Gymo4bzTxHKR8QAFY2
   tSVLZEXhP7PkhYCYlMImXoq1OZg1WEUnpsZrl2EVMY4IYCcndF8+cXxRD
   7iluq6+7Pl/dbi9N9nIitxkPiYQcWB1o49KNPrwF1TsqeBp0453r4DCSj
   Aio+/Lc2xPTfq/4RqdDHMh5FbpFoQyzkcaGVFZhtuCl7HuTRc0n9V9KPj
   VoSkFTXyO/zLl/zFKKPn8P751JAgj6JFZJfpQ1NjHYMI94dNnztUOPIt8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="413030"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="413030"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 15:12:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="798893843"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="798893843"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 01 Dec 2023 15:12:23 -0800
Subject: [net-next PATCH v11 05/11] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: edumazet@google.com, ast@kernel.org, sdf@google.com, lorenzo@kernel.org,
 tariqt@nvidia.com, daniel@iogearbox.net, anthony.l.nguyen@intel.com,
 lucien.xin@gmail.com, michael.chan@broadcom.com, hawk@kernel.org,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 01 Dec 2023 15:28:51 -0800
Message-ID: <170147333119.5260.7050639053080529108.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
References: <170147307026.5260.9300080745237900261.stgit@anambiarhost.jf.intel.com>
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
index 719e6aafbfdb..76d6b2e15b67 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -213,6 +213,19 @@ attribute-sets:
         name: recycle-released-refcnt
         type: uint
 
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
@@ -359,6 +372,23 @@ operations:
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
index f857960a7f06..e7bdbcb01f22 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -109,6 +109,14 @@ enum {
 	NETDEV_A_PAGE_POOL_STATS_MAX = (__NETDEV_A_PAGE_POOL_STATS_MAX - 1)
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
@@ -130,6 +138,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index b1dcf88c82cf..be7f2ebd61b2 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -58,6 +58,16 @@ static const struct nla_policy netdev_queue_get_dump_nl_policy[NETDEV_A_QUEUE_IF
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
@@ -114,6 +124,20 @@ static const struct genl_split_ops netdev_nl_ops[] = {
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
index 086623c1797a..a47f2bcbe4fa 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -26,6 +26,8 @@ int netdev_nl_page_pool_stats_get_dumpit(struct sk_buff *skb,
 int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
 			       struct netlink_callback *cb);
+int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 3bc1661e6ebf..4c8ea6a4f015 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -155,6 +155,16 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
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
index f857960a7f06..e7bdbcb01f22 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -109,6 +109,14 @@ enum {
 	NETDEV_A_PAGE_POOL_STATS_MAX = (__NETDEV_A_PAGE_POOL_STATS_MAX - 1)
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
@@ -130,6 +138,7 @@ enum {
 	NETDEV_CMD_PAGE_POOL_CHANGE_NTF,
 	NETDEV_CMD_PAGE_POOL_STATS_GET,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index fbf7e24ade91..906b61554698 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -24,6 +24,7 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_PAGE_POOL_CHANGE_NTF] = "page-pool-change-ntf",
 	[NETDEV_CMD_PAGE_POOL_STATS_GET] = "page-pool-stats-get",
 	[NETDEV_CMD_QUEUE_GET] = "queue-get",
+	[NETDEV_CMD_NAPI_GET] = "napi-get",
 };
 
 const char *netdev_op_str(int op)
@@ -160,6 +161,16 @@ struct ynl_policy_nest netdev_queue_nest = {
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
 void netdev_page_pool_info_free(struct netdev_page_pool_info *obj)
 {
@@ -770,6 +781,119 @@ netdev_queue_get_dump(struct ynl_sock *ys,
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
index d7daf6df3df0..481c9e45b689 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -360,4 +360,79 @@ struct netdev_queue_get_list *
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


