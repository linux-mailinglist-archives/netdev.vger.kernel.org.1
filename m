Return-Path: <netdev+bounces-47549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9127EA74F
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 092561F235C8
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A032F55;
	Tue, 14 Nov 2023 00:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qyx14Avb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534612CA7
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:13:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445921A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920823; x=1731456823;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Zd18rE/o2nuUILpuT8zUkrupT47WWOEpURSb7056Ac=;
  b=Qyx14AvbyqHflMhGDyEW3T9Dd8EeV9NbdWdB4f9uYYUc57lwmb+V19XG
   F87GL/Yyy8EgTIibtmez9nVywlNU3NlJ8DDW9+XX2DjMYDMP/IjVn84d7
   BgB8qKB8OjAcefOeAN+x88AsKuRT02HpHVCrSVue9wNVksjgidGNIXoLJ
   wXS7y6wutG5xjKncRgriQCtXemXGQK5yvEjF/LZ2ZM6qMWRHGU7s7LeQw
   YpUXsSygJ0FwVlWulx1N23wNrDkoxdBrJBgmtMefLgzhbfsQVivMhfbjp
   7ivGTV6ay4bt4XBfNYQjoB38Nfv+hcxDmDf+Sj+F7WOXvEpzTR0IToz88
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="393397448"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="393397448"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:13:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011697855"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011697855"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2023 16:13:42 -0800
Subject: [net-next PATCH v7 05/10] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:29:58 -0800
Message-ID: <169992179806.3867.8730181527639625952.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
References: <169992138566.3867.856803351434134324.stgit@anambiarhost.jf.intel.com>
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
index e7bf6007d77f..3f50d7c40baf 100644
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
+        name: napi-id
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
+            - napi-id
+        reply: &napi-get-op
+          attributes:
+            - napi-id
+            - ifindex
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply: *napi-get-op
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index a3997efb6786..02e6594d0666 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -69,6 +69,14 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_NAPI_IFINDEX = 1,
+	NETDEV_A_NAPI_NAPI_ID,
+
+	__NETDEV_A_NAPI_MAX,
+	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -85,6 +93,7 @@ enum {
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index 85d556a051db..77a340f6c285 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -27,6 +27,16 @@ static const struct nla_policy netdev_queue_get_dump_nl_policy[NETDEV_A_QUEUE_IF
 	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_NAPI_GET - do */
+static const struct nla_policy netdev_napi_get_do_nl_policy[NETDEV_A_NAPI_NAPI_ID + 1] = {
+	[NETDEV_A_NAPI_NAPI_ID] = { .type = NLA_U32, },
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
+		.maxattr	= NETDEV_A_NAPI_NAPI_ID,
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
index a3e308bf74d5..27d7f9dff228 100644
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
index a3997efb6786..02e6594d0666 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -69,6 +69,14 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_NAPI_IFINDEX = 1,
+	NETDEV_A_NAPI_NAPI_ID,
+
+	__NETDEV_A_NAPI_MAX,
+	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
+};
+
 enum {
 	NETDEV_A_QUEUE_QUEUE_ID = 1,
 	NETDEV_A_QUEUE_IFINDEX,
@@ -85,6 +93,7 @@ enum {
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
 	NETDEV_CMD_QUEUE_GET,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 9d6f96d80ba1..32d8972f1569 100644
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
+	[NETDEV_A_NAPI_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
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
+		if (type == NETDEV_A_NAPI_NAPI_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.napi_id = 1;
+			dst->napi_id = mnl_attr_get_u32(attr);
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
+	if (req->_present.napi_id)
+		mnl_attr_put_u32(nlh, NETDEV_A_NAPI_NAPI_ID, req->napi_id);
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
index 7b06aeb4a4e2..7491af619e6f 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -187,4 +187,79 @@ struct netdev_queue_get_list *
 netdev_queue_get_dump(struct ynl_sock *ys,
 		      struct netdev_queue_get_req_dump *req);
 
+/* ============== NETDEV_CMD_NAPI_GET ============== */
+/* NETDEV_CMD_NAPI_GET - do */
+struct netdev_napi_get_req {
+	struct {
+		__u32 napi_id:1;
+	} _present;
+
+	__u32 napi_id;
+};
+
+static inline struct netdev_napi_get_req *netdev_napi_get_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_napi_get_req));
+}
+void netdev_napi_get_req_free(struct netdev_napi_get_req *req);
+
+static inline void
+netdev_napi_get_req_set_napi_id(struct netdev_napi_get_req *req, __u32 napi_id)
+{
+	req->_present.napi_id = 1;
+	req->napi_id = napi_id;
+}
+
+struct netdev_napi_get_rsp {
+	struct {
+		__u32 napi_id:1;
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 napi_id;
+	__u32 ifindex;
+};
+
+void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);
+
+/*
+ * napi information such as napi-id
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


