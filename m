Return-Path: <netdev+bounces-35096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ADD7A6E8F
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 00:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146F21C204F8
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168283C6A9;
	Tue, 19 Sep 2023 22:15:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC183B7BA
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 22:15:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CDCF9
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695161732; x=1726697732;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DF+OgjOupW4yRX2XBuIjTF3HBVeVWPBrqe0UHutLPZM=;
  b=VvADazzLCedeeUtdbabrgeQgcm1FEQEKFh8hDewkoQxE8HRJGR/nuojR
   ODlie2GD/p5jZC5+B+eWvjk8iKIHAOSQANVy0mUIN1X3V2WWY0BZ02gme
   DQn7Cw04SnbJ4FQVafBKZdzkqSQ3X0TrokhI/xkNYmh3sncDbHTlFmbl+
   2HdLqK8o87lJuyJNPFmmtjfo4Y4fnKGRxrjNU8LtT/a50v5mX2oFKS0AJ
   AZZW4j7Zv9k2zrMnYKQAauD+RoUu6LoLyCIWa+1vB4OUIAGHy5NV8BE/Y
   E1YrUtkrravVCPnmRBb1p00pmthUFx9P1mlgb4YwC/ClCCRa0DaEnlqEu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="370378419"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="370378419"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 15:11:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="749644522"
X-IronPort-AV: E=Sophos;i="6.02,160,1688454000"; 
   d="scan'208";a="749644522"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by fmsmga007.fm.intel.com with ESMTP; 19 Sep 2023 15:11:51 -0700
Subject: [net-next PATCH v3 01/10] netdev-genl: spec: Extend netdev netlink
 spec in YAML for queue
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Tue, 19 Sep 2023 15:27:20 -0700
Message-ID: <169516244040.7377.16515332696427625794.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
References: <169516206704.7377.12938469824609831999.stgit@anambiarhost.jf.intel.com>
User-Agent: StGit/unknown-version
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support in netlink spec(netdev.yaml) for queue information.
Add code generated from the spec.

Note: The "q-type" attribute currently takes values 0 and 1 for rx
and tx queue type respectively. I haven't figured out the ynl
library changes to support string user input ("rx" and "tx") to
enum value conversion in the generated file.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |   52 ++++++++++
 include/uapi/linux/netdev.h             |   17 +++
 net/core/netdev-genl-gen.c              |   26 +++++
 net/core/netdev-genl-gen.h              |    3 +
 net/core/netdev-genl.c                  |   10 ++
 tools/include/uapi/linux/netdev.h       |   17 +++
 tools/net/ynl/generated/netdev-user.c   |  159 +++++++++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   |  101 ++++++++++++++++++++
 8 files changed, 385 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index c46fcc78fc04..7b5d4cdff48b 100644
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
@@ -89,6 +93,32 @@ attribute-sets:
         enum: xdp-rx-metadata
         enum-as-flags: true
 
+  -
+    name: queue
+    attributes:
+      -
+        name: q-id
+        doc: queue index
+        type: u32
+      -
+        name: ifindex
+        doc: netdev ifindex
+        type: u32
+        checks:
+          min: 1
+      -
+        name: q-type
+        doc: queue type as rx, tx
+        type: u32
+        enum: queue-type
+      -
+        name: napi-id
+        doc: napi id
+        type: u32
+      -
+        name: tx-maxrate
+        type: u32
+
 operations:
   list:
     -
@@ -122,6 +152,28 @@ operations:
       doc: Notification about device configuration being changed.
       notify: dev-get
       mcgrp: mgmt
+    -
+      name: queue-get
+      doc: queue information
+      attribute-set: queue
+      do:
+        request:
+          attributes:
+            - ifindex
+            - q-type
+            - q-id
+        reply: &queue-get-op
+          attributes:
+            - q-id
+            - q-type
+            - napi-id
+            - ifindex
+            - tx-maxrate
+      dump:
+        request:
+          attributes:
+            - ifindex
+        reply: *queue-get-op
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index 2943a151d4f1..bb3713231b0b 100644
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
@@ -64,11 +69,23 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_Q_ID = 1,
+	NETDEV_A_QUEUE_IFINDEX,
+	NETDEV_A_QUEUE_Q_TYPE,
+	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_TX_MAXRATE,
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
index ea9231378aa6..e3632ed597b4 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -15,6 +15,18 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_QUEUE_GET - do */
+static const struct nla_policy netdev_queue_get_do_nl_policy[NETDEV_A_QUEUE_Q_TYPE + 1] = {
+	[NETDEV_A_QUEUE_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+	[NETDEV_A_QUEUE_Q_TYPE] = NLA_POLICY_MAX(NLA_U32, 1),
+	[NETDEV_A_QUEUE_Q_ID] = { .type = NLA_U32, },
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
+		.maxattr	= NETDEV_A_QUEUE_Q_TYPE,
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
index 2943a151d4f1..bb3713231b0b 100644
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
@@ -64,11 +69,23 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_QUEUE_Q_ID = 1,
+	NETDEV_A_QUEUE_IFINDEX,
+	NETDEV_A_QUEUE_Q_TYPE,
+	NETDEV_A_QUEUE_NAPI_ID,
+	NETDEV_A_QUEUE_TX_MAXRATE,
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
index b5ffe8cd1144..749b4bea3c6c 100644
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
@@ -72,6 +85,19 @@ struct ynl_policy_nest netdev_dev_nest = {
 	.table = netdev_dev_policy,
 };
 
+struct ynl_policy_attr netdev_queue_policy[NETDEV_A_QUEUE_MAX + 1] = {
+	[NETDEV_A_QUEUE_Q_ID] = { .name = "q-id", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_Q_TYPE] = { .name = "q-type", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
+	[NETDEV_A_QUEUE_TX_MAXRATE] = { .name = "tx-maxrate", .type = YNL_PT_U32, },
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
@@ -197,6 +223,139 @@ void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
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
+		if (type == NETDEV_A_QUEUE_Q_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.q_id = 1;
+			dst->q_id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_QUEUE_Q_TYPE) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.q_type = 1;
+			dst->q_type = mnl_attr_get_u32(attr);
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
+		} else if (type == NETDEV_A_QUEUE_TX_MAXRATE) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.tx_maxrate = 1;
+			dst->tx_maxrate = mnl_attr_get_u32(attr);
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
+	if (req->_present.q_type)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_Q_TYPE, req->q_type);
+	if (req->_present.q_id)
+		mnl_attr_put_u32(nlh, NETDEV_A_QUEUE_Q_ID, req->q_id);
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
index b4351ff34595..cc938c6ba492 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -19,6 +19,7 @@ extern const struct ynl_family ynl_netdev_family;
 const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
 const char *netdev_xdp_rx_metadata_str(enum netdev_xdp_rx_metadata value);
+const char *netdev_queue_type_str(enum netdev_queue_type value);
 
 /* Common nested types */
 /* ============== NETDEV_CMD_DEV_GET ============== */
@@ -87,4 +88,104 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_QUEUE_GET ============== */
+/* NETDEV_CMD_QUEUE_GET - do */
+struct netdev_queue_get_req {
+	struct {
+		__u32 ifindex:1;
+		__u32 q_type:1;
+		__u32 q_id:1;
+	} _present;
+
+	__u32 ifindex;
+	enum netdev_queue_type q_type;
+	__u32 q_id;
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
+netdev_queue_get_req_set_q_type(struct netdev_queue_get_req *req,
+				enum netdev_queue_type q_type)
+{
+	req->_present.q_type = 1;
+	req->q_type = q_type;
+}
+static inline void
+netdev_queue_get_req_set_q_id(struct netdev_queue_get_req *req, __u32 q_id)
+{
+	req->_present.q_id = 1;
+	req->q_id = q_id;
+}
+
+struct netdev_queue_get_rsp {
+	struct {
+		__u32 q_id:1;
+		__u32 q_type:1;
+		__u32 napi_id:1;
+		__u32 ifindex:1;
+		__u32 tx_maxrate:1;
+	} _present;
+
+	__u32 q_id;
+	enum netdev_queue_type q_type;
+	__u32 napi_id;
+	__u32 ifindex;
+	__u32 tx_maxrate;
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
+	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void netdev_queue_get_list_free(struct netdev_queue_get_list *rsp);
+
+struct netdev_queue_get_list *
+netdev_queue_get_dump(struct ynl_sock *ys,
+		      struct netdev_queue_get_req_dump *req);
+
 #endif /* _LINUX_NETDEV_GEN_H */


