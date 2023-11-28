Return-Path: <netdev+bounces-51542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FC7FB06D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 04:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B24EBB2051E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDF3746F;
	Tue, 28 Nov 2023 03:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIjbAZwU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C6DC9
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 19:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701142385; x=1732678385;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSU9fGPGcBB2GI1yhCIzoHViPqgPSAHOgTazifZEbh0=;
  b=kIjbAZwUqd1zo/3h6ZharzvqMl4dMSDZZhO+xpHiNErbfbU9b69tkG63
   0zw6rs1ZGM+23+yHNx1uWPSNYSVSAW2MpQE7P/M5bfNbWZ/dWLAq2DgEP
   T0ipj+UWtcufIapFdaYhBog+KhJNmOq8mmbIRYIWbxjYXb/dAjiMIw6zL
   yDh9ahY6hKXkgC6AXaZDgDP7FJftA3T5HQcCe4MJFAMI2rQzfW2eIyt7S
   Oa1CYEWh58oEyyS8UZBtyGDJlulK2Kz/OKb0VRRKIjZQ2qlrA8D8PThJk
   BW8mn2EQXl5L/tKN5iYHWLSusNHUkgVdnCRXAOt5fm3+vOFY3IjvD8bd/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="389997231"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="389997231"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761820830"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="761820830"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2023 19:33:04 -0800
Subject: [net-next PATCH v9 01/11] netdev-genl: spec: Extend netdev netlink
 spec in YAML for queue
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 27 Nov 2023 19:49:30 -0800
Message-ID: <170114337087.10303.4221394669092217664.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
References: <170114286635.10303.8773144948795839629.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add support in netlink spec(netdev.yaml) for queue information.
Add code generated from the spec.

Note: The "queue-type" attribute takes values 0 and 1 for rx
and tx queue type respectively.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |   52 +++++++++++
 include/uapi/linux/netdev.h             |   16 +++
 net/core/netdev-genl-gen.c              |   26 +++++
 net/core/netdev-genl-gen.h              |    3 +
 net/core/netdev-genl.c                  |   10 ++
 tools/include/uapi/linux/netdev.h       |   16 +++
 tools/net/ynl/generated/netdev-user.c   |  153 +++++++++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   |   99 ++++++++++++++++++++
 8 files changed, 375 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 14511b13f305..f9382b7705ab 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -55,6 +55,10 @@ definitions:
         name: hash
         doc:
           Device is capable of exposing receive packet hash via bpf_xdp_metadata_rx_hash().
+  -
+    name: queue-type
+    type: enum
+    entries: [ rx, tx ]
 
 attribute-sets:
   -
@@ -87,6 +91,31 @@ attribute-sets:
         type: u64
         enum: xdp-rx-metadata
 
+  -
+    name: queue
+    attributes:
+      -
+        name: id
+        doc: Queue index; most queue types are indexed like a C array, with
+             indexes starting at 0 and ending at queue count - 1. Queue indexes
+             are scoped to an interface and queue type.
+        type: u32
+      -
+        name: ifindex
+        doc: ifindex of the netdevice to which the queue belongs.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: type
+        doc: Queue type as rx, tx. Each queue type defines a separate ID space.
+        type: u32
+        enum: queue-type
+      -
+        name: napi-id
+        doc: ID of the NAPI instance which services this queue.
+        type: u32
+
 operations:
   list:
     -
@@ -120,6 +149,29 @@ operations:
       doc: Notification about device configuration being changed.
       notify: dev-get
       mcgrp: mgmt
+    -
+      name: queue-get
+      doc: Get queue information from the kernel.
+           Only configured queues will be reported (as opposed to all available
+           hardware queues).
+      attribute-set: queue
+      do:
+        request:
+          attributes:
+            - ifindex
+            - type
+            - id
+        reply: &queue-get-op
+          attributes:
+            - id
+            - type
+            - napi-id
+            - ifindex
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply: *queue-get-op
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2943a151d4f1..c440017241f0 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -53,6 +53,11 @@ enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_MASK = 3,
 };
 
+enum netdev_queue_type {
+	NETDEV_QUEUE_TYPE_RX,
+	NETDEV_QUEUE_TYPE_TX,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
@@ -64,11 +69,22 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_ID = 1,
+	NETDEV_A_QUEUE_IFINDEX,
+	NETDEV_A_QUEUE_TYPE,
+	NETDEV_A_QUEUE_NAPI_ID,
+
+	__NETDEV_A_QUEUE_MAX,
+	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_QUEUE_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ea9231378aa6..97ee7ebbad57 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -15,6 +15,18 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_QUEUE_GET - do */
+static const struct nla_policy netdev_queue_get_do_nl_policy[NETDEV_A_QUEUE_TYPE + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_ID] = { .type = NLA_U32, },
+};
+
+/* NETDEV_CMD_QUEUE_GET - dump */
+static const struct nla_policy netdev_queue_get_dump_nl_policy[NETDEV_A_QUEUE_IFINDEX + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -29,6 +41,20 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.dumpit	= netdev_nl_dev_get_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_QUEUE_GET,
+		.doit		= netdev_nl_queue_get_doit,
+		.policy		= netdev_queue_get_do_nl_policy,
+		.maxattr	= NETDEV_A_QUEUE_TYPE,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= NETDEV_CMD_QUEUE_GET,
+		.dumpit		= netdev_nl_queue_get_dumpit,
+		.policy		= netdev_queue_get_dump_nl_policy,
+		.maxattr	= NETDEV_A_QUEUE_IFINDEX,
+		.flags		= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 7b370c073e7d..263c94f77bad 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,9 @@
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_queue_get_dumpit(struct sk_buff *skb,
+			       struct netlink_callback *cb);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index fe61f85bcf33..336c608e6a6b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -129,6 +129,16 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	return skb->len;
 }
 
+int netdev_nl_queue_get_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return -EOPNOTSUPP;
+}
+
+int netdev_nl_queue_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
+{
+	return -EOPNOTSUPP;
+}
+
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
 				       unsigned long event, void *ptr)
 {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index 2943a151d4f1..c440017241f0 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -53,6 +53,11 @@ enum netdev_xdp_rx_metadata {
 	NETDEV_XDP_RX_METADATA_MASK = 3,
 };
 
+enum netdev_queue_type {
+	NETDEV_QUEUE_TYPE_RX,
+	NETDEV_QUEUE_TYPE_TX,
+};
+
 enum {
 	NETDEV_A_DEV_IFINDEX = 1,
 	NETDEV_A_DEV_PAD,
@@ -64,11 +69,22 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_ID = 1,
+	NETDEV_A_QUEUE_IFINDEX,
+	NETDEV_A_QUEUE_TYPE,
+	NETDEV_A_QUEUE_NAPI_ID,
+
+	__NETDEV_A_QUEUE_MAX,
+	NETDEV_A_QUEUE_MAX = (__NETDEV_A_QUEUE_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_QUEUE_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index b5ffe8cd1144..87845c707b95 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -18,6 +18,7 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_DEV_ADD_NTF] = "dev-add-ntf",
 	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
 	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
+	[NETDEV_CMD_QUEUE_GET] = "queue-get",
 };
 
 const char *netdev_op_str(int op)
@@ -58,6 +59,18 @@ const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value)
 	return netdev_xdp_rx_metadata_strmap[value];
 }
 
+static const char * const netdev_queue_type_strmap[] = {
+	[0] = "rx",
+	[1] = "tx",
+};
+
+const char *netdev_queue_type_str(enum netdev_queue_type value)
+{
+	if (value < 0 || value >= (int)MNL_ARRAY_SIZE(netdev_queue_type_strmap))
+		return NULL;
+	return netdev_queue_type_strmap[value];
+}
+
 /* Policies */
 struct ynl_policy_attr netdev_dev_policy[NETDEV_A_DEV_MAX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
@@ -72,6 +85,18 @@ struct ynl_policy_nest netdev_dev_nest = {
 	.table = netdev_dev_policy,
 };
 
+struct ynl_policy_attr netdev_queue_policy[NETDEV_A_QUEUE_MAX + 1] = {
+	[NETDEV_A_QUEUE_ID] = { .name = "id", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_TYPE] = { .name = "type", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest netdev_queue_nest = {
+	.max_attr = NETDEV_A_QUEUE_MAX,
+	.table = netdev_queue_policy,
+};
+
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
@@ -197,6 +222,134 @@ void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
 	free(rsp);
 }
 
+/* ============== NETDEV_CMD_QUEUE_GET ============== */
+/* NETDEV_CMD_QUEUE_GET - do */
+void netdev_queue_get_req_free(struct netdev_queue_get_req *req)
+{
+	free(req);
+}
+
+void netdev_queue_get_rsp_free(struct netdev_queue_get_rsp *rsp)
+{
+	free(rsp);
+}
+
+int netdev_queue_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct ynl_parse_arg *yarg = data;
+	struct netdev_queue_get_rsp *dst;
+	const struct nlattr *attr;
+
+	dst = yarg->data;
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NETDEV_A_QUEUE_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.id = 1;
+			dst->id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_QUEUE_TYPE) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.type = 1;
+			dst->type = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_QUEUE_NAPI_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.napi_id = 1;
+			dst->napi_id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_QUEUE_IFINDEX) {
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
+struct netdev_queue_get_rsp *
+netdev_queue_get(struct ynl_sock *ys, struct netdev_queue_get_req *req)
+{
+	struct ynl_req_state yrs = { .yarg = { .ys = ys, }, };
+	struct netdev_queue_get_rsp *rsp;
+	struct nlmsghdr *nlh;
+	int err;
+
+	nlh = ynl_gemsg_start_req(ys, ys->family_id, NETDEV_CMD_QUEUE_GET, 1);
+	ys->req_policy = &netdev_queue_nest;
+	yrs.yarg.rsp_policy = &netdev_queue_nest;
+
+	if (req->_present.ifindex)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_IFINDEX, req->ifindex);
+	if (req->_present.type)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_TYPE, req->type);
+	if (req->_present.id)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_ID, req->id);
+
+	rsp = calloc(1, sizeof(*rsp));
+	yrs.yarg.data = rsp;
+	yrs.cb = netdev_queue_get_rsp_parse;
+	yrs.rsp_cmd = NETDEV_CMD_QUEUE_GET;
+
+	err = ynl_exec(ys, nlh, &yrs);
+	if (err < 0)
+		goto err_free;
+
+	return rsp;
+
+err_free:
+	netdev_queue_get_rsp_free(rsp);
+	return NULL;
+}
+
+/* NETDEV_CMD_QUEUE_GET - dump */
+void netdev_queue_get_list_free(struct netdev_queue_get_list *rsp)
+{
+	struct netdev_queue_get_list *next = rsp;
+
+	while ((void *)next != YNL_LIST_END) {
+		rsp = next;
+		next = rsp->next;
+
+		free(rsp);
+	}
+}
+
+struct netdev_queue_get_list *
+netdev_queue_get_dump(struct ynl_sock *ys,
+		      struct netdev_queue_get_req_dump *req)
+{
+	struct ynl_dump_state yds = {};
+	struct nlmsghdr *nlh;
+	int err;
+
+	yds.ys = ys;
+	yds.alloc_sz = sizeof(struct netdev_queue_get_list);
+	yds.cb = netdev_queue_get_rsp_parse;
+	yds.rsp_cmd = NETDEV_CMD_QUEUE_GET;
+	yds.rsp_policy = &netdev_queue_nest;
+
+	nlh = ynl_gemsg_start_dump(ys, ys->family_id, NETDEV_CMD_QUEUE_GET, 1);
+	ys->req_policy = &netdev_queue_nest;
+
+	if (req->_present.ifindex)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_IFINDEX, req->ifindex);
+
+	err = ynl_exec_dump(ys, nlh, &yds);
+	if (err < 0)
+		goto free_list;
+
+	return yds.first;
+
+free_list:
+	netdev_queue_get_list_free(yds.first);
+	return NULL;
+}
+
 static const struct ynl_ntf_info netdev_ntf_info[] =  {
 	[NETDEV_CMD_DEV_ADD_NTF] =  {
 		.alloc_sz	= sizeof(struct netdev_dev_get_ntf),
diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
index 4fafac879df3..50d214e8819d 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -19,6 +19,7 @@ extern const struct ynl_family ynl_netdev_family;
 const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
 const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value);
+const char *netdev_queue_type_str(enum netdev_queue_type value);
 
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
@@ -87,4 +88,102 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_QUEUE_GET ============== */
+/* NETDEV_CMD_QUEUE_GET - do */
+struct netdev_queue_get_req {
+	struct {
+		__u32 ifindex:1;
+		__u32 type:1;
+		__u32 id:1;
+	} _present;
+
+	__u32 ifindex;
+	enum netdev_queue_type type;
+	__u32 id;
+};
+
+static inline struct netdev_queue_get_req *netdev_queue_get_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_queue_get_req));
+}
+void netdev_queue_get_req_free(struct netdev_queue_get_req *req);
+
+static inline void
+netdev_queue_get_req_set_ifindex(struct netdev_queue_get_req *req,
+				 __u32 ifindex)
+{
+	req->_present.ifindex = 1;
+	req->ifindex = ifindex;
+}
+static inline void
+netdev_queue_get_req_set_type(struct netdev_queue_get_req *req,
+			      enum netdev_queue_type type)
+{
+	req->_present.type = 1;
+	req->type = type;
+}
+static inline void
+netdev_queue_get_req_set_id(struct netdev_queue_get_req *req, __u32 id)
+{
+	req->_present.id = 1;
+	req->id = id;
+}
+
+struct netdev_queue_get_rsp {
+	struct {
+		__u32 id:1;
+		__u32 type:1;
+		__u32 napi_id:1;
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 id;
+	enum netdev_queue_type type;
+	__u32 napi_id;
+	__u32 ifindex;
+};
+
+void netdev_queue_get_rsp_free(struct netdev_queue_get_rsp *rsp);
+
+/*
+ * Get queue information from the kernel. Only configured queues will be reported (as opposed to all available hardware queues).
+ */
+struct netdev_queue_get_rsp *
+netdev_queue_get(struct ynl_sock *ys, struct netdev_queue_get_req *req);
+
+/* NETDEV_CMD_QUEUE_GET - dump */
+struct netdev_queue_get_req_dump {
+	struct {
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 ifindex;
+};
+
+static inline struct netdev_queue_get_req_dump *
+netdev_queue_get_req_dump_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_queue_get_req_dump));
+}
+void netdev_queue_get_req_dump_free(struct netdev_queue_get_req_dump *req);
+
+static inline void
+netdev_queue_get_req_dump_set_ifindex(struct netdev_queue_get_req_dump *req,
+				      __u32 ifindex)
+{
+	req->_present.ifindex = 1;
+	req->ifindex = ifindex;
+}
+
+struct netdev_queue_get_list {
+	struct netdev_queue_get_list *next;
+	struct netdev_queue_get_rsp obj __attribute__((aligned(8)));
+};
+
+void netdev_queue_get_list_free(struct netdev_queue_get_list *rsp);
+
+struct netdev_queue_get_list *
+netdev_queue_get_dump(struct ynl_sock *ys,
+		      struct netdev_queue_get_req_dump *req);
+
 #endif /* _LINUX_NETDEV_GEN_H */


