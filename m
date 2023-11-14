Return-Path: <netdev+bounces-47545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC507EA74A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 01:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4401F23569
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F1A5B;
	Tue, 14 Nov 2023 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N0FxILpo"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EDA5E
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:13:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B9E1A6
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699920802; x=1731456802;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S3KBii+DoxgzvDUiIS4JW1pnBNDW9MxgDZhN0X2Omfg=;
  b=N0FxILpoxxS5wOc0KaqAoFDQWiQvprCu6tjyucZwJ+94w+XObhvlaeNX
   FlyRgP06ZyNLDffje8/SIgZsFMm0M/k61Mm/QTYInlCAai4db0kkCqMsr
   c3vYUxQvrSvwJHOIFkDpJGJ0V/DDlIjbgpWFaruBwZMdi74qaViFAFVYc
   7DKdVuK9h1v8xkbqWMs5f8ZZ51ftkSUgZx0O757mgLEogCsxgYYsXI5Kd
   uYAQXmNRiQbFIaahdqNOeQBr+iZeaQFVxjmpEFyWT+3JTil9BQPihBJ4F
   C2DcU0Tf6+Ut9vboPlY1iG28smjSlIwm1VnoI8PNeLQK0TiUvIBfdBeRd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="3618591"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="3618591"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 16:13:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="793569641"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="793569641"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga008.jf.intel.com with ESMTP; 13 Nov 2023 16:13:21 -0800
Subject: [net-next PATCH v7 01/10] netdev-genl: spec: Extend netdev netlink
 spec in YAML for queue
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Mon, 13 Nov 2023 16:29:37 -0800
Message-ID: <169992177699.3867.16531901770683676993.stgit@anambiarhost.jf.intel.com>
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
 tools/net/ynl/generated/netdev-user.h   |  100 ++++++++++++++++++++
 8 files changed, 376 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 14511b13f305..e7bf6007d77f 100644
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
+        name: queue-id
+        doc: Queue index for most queue types are indexed like a C array, with
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
+        name: queue-type
+        doc: queue type as rx, tx
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
+           queues).
+      attribute-set: queue
+      do:
+        request:
+          attributes:
+            - ifindex
+            - queue-type
+            - queue-id
+        reply: &queue-get-op
+          attributes:
+            - queue-id
+            - queue-type
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
index 2943a151d4f1..a3997efb6786 100644
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
+	NETDEV_A_QUEUE_QUEUE_ID = 1,
+	NETDEV_A_QUEUE_IFINDEX,
+	NETDEV_A_QUEUE_QUEUE_TYPE,
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
index ea9231378aa6..85d556a051db 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -15,6 +15,18 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_QUEUE_GET - do */
+static const struct nla_policy netdev_queue_get_do_nl_policy[NETDEV_A_QUEUE_QUEUE_TYPE + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_QUEUE_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_QUEUE_ID] = { .type = NLA_U32, },
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
+		.maxattr	= NETDEV_A_QUEUE_QUEUE_TYPE,
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
index 2943a151d4f1..a3997efb6786 100644
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
+	NETDEV_A_QUEUE_QUEUE_ID = 1,
+	NETDEV_A_QUEUE_IFINDEX,
+	NETDEV_A_QUEUE_QUEUE_TYPE,
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
index b5ffe8cd1144..9d6f96d80ba1 100644
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
+	[NETDEV_A_QUEUE_QUEUE_ID] = { .name = "queue-id", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_QUEUE_TYPE] = { .name = "queue-type", .type = YNL_PT_U32, },
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
+		if (type == NETDEV_A_QUEUE_QUEUE_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.queue_id = 1;
+			dst->queue_id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_QUEUE_QUEUE_TYPE) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.queue_type = 1;
+			dst->queue_type = mnl_attr_get_u32(attr);
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
+	if (req->_present.queue_type)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_QUEUE_TYPE, req->queue_type);
+	if (req->_present.queue_id)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_QUEUE_ID, req->queue_id);
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
index 4fafac879df3..7b06aeb4a4e2 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -19,6 +19,7 @@ extern const struct ynl_family ynl_netdev_family;
 const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
 const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value);
+const char *netdev_queue_type_str(enum netdev_queue_type value);
 
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
@@ -87,4 +88,103 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_QUEUE_GET ============== */
+/* NETDEV_CMD_QUEUE_GET - do */
+struct netdev_queue_get_req {
+	struct {
+		__u32 ifindex:1;
+		__u32 queue_type:1;
+		__u32 queue_id:1;
+	} _present;
+
+	__u32 ifindex;
+	enum netdev_queue_type queue_type;
+	__u32 queue_id;
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
+netdev_queue_get_req_set_queue_type(struct netdev_queue_get_req *req,
+				    enum netdev_queue_type queue_type)
+{
+	req->_present.queue_type = 1;
+	req->queue_type = queue_type;
+}
+static inline void
+netdev_queue_get_req_set_queue_id(struct netdev_queue_get_req *req,
+				  __u32 queue_id)
+{
+	req->_present.queue_id = 1;
+	req->queue_id = queue_id;
+}
+
+struct netdev_queue_get_rsp {
+	struct {
+		__u32 queue_id:1;
+		__u32 queue_type:1;
+		__u32 napi_id:1;
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 queue_id;
+	enum netdev_queue_type queue_type;
+	__u32 napi_id;
+	__u32 ifindex;
+};
+
+void netdev_queue_get_rsp_free(struct netdev_queue_get_rsp *rsp);
+
+/*
+ * queue information
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


