Return-Path: <netdev+bounces-22480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7316767996
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C128288A
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7986064F;
	Sat, 29 Jul 2023 00:32:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678B364C
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 00:32:22 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6458110CB
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 17:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690590740; x=1722126740;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IxxoaNp7UNt/KyXoeExTYZrIFjQUdv62vVvO3JcBYVo=;
  b=BnNdegfSZVeBqzU1hJgECHHuAJJmFabGlTfwargQmm8E/ntngTU2RcQF
   ++0tIrY9hIr0O6xMpDdFNl/qNhT7EEqO/PESq5bLVXjxlNhmasfjRhSMR
   eUtOGH7HNfV4amwVpa+a4Y0jmfD1j3Z4/n9+zMEtObrfO2JvUp0MVdr8q
   Mplh0eblMHv3YJXkRUN9BipuUvkc5GOttaDXujOAt4D7aLXVRai2UXgyl
   16rBuBPE6SKKvEom6iZg3uMAERNjnX9I4jVCyFVdqDo9tUxFfMyweIFxH
   /ManWxGo6HtJ1EWXjRb2Uc1Z9rMJpnql+Bk+lXXdhBqgJQfgNMzajJVSS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358742058"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="358742058"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 17:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="851403849"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="851403849"
Received: from anambiarhost.jf.intel.com ([10.166.29.163])
  by orsmga004.jf.intel.com with ESMTP; 28 Jul 2023 17:32:19 -0700
Subject: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
From: Amritha Nambiar <amritha.nambiar@intel.com>
To: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net
Cc: sridhar.samudrala@intel.com, amritha.nambiar@intel.com
Date: Fri, 28 Jul 2023 17:47:07 -0700
Message-ID: <169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
In-Reply-To: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
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
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add support in netlink spec(netdev.yaml) for napi related information.
Add code generated from the spec.

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 Documentation/netlink/specs/netdev.yaml |   46 ++++++
 include/uapi/linux/netdev.h             |   18 +++
 net/core/netdev-genl-gen.c              |   17 ++
 net/core/netdev-genl-gen.h              |    2 
 net/core/netdev-genl.c                  |   10 +
 tools/include/uapi/linux/netdev.h       |   18 +++
 tools/net/ynl/generated/netdev-user.c   |  220 +++++++++++++++++++++++++++++++
 tools/net/ynl/generated/netdev-user.h   |   63 +++++++++
 8 files changed, 394 insertions(+)

diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
index 1c7284fd535b..507cea4f2319 100644
--- a/Documentation/netlink/specs/netdev.yaml
+++ b/Documentation/netlink/specs/netdev.yaml
@@ -68,6 +68,38 @@ attribute-sets:
         type: u32
         checks:
           min: 1
+  -
+    name: napi-info-entry
+    attributes:
+      -
+        name: napi-id
+        doc: napi id
+        type: u32
+      -
+        name: rx-queues
+        doc: list of rx queues associated with a napi
+        type: u32
+        multi-attr: true
+      -
+        name: tx-queues
+        doc: list of tx queues associated with a napi
+        type: u32
+        multi-attr: true
+  -
+    name: napi
+    attributes:
+      -
+        name: ifindex
+        doc: netdev ifindex
+        type: u32
+        checks:
+          min: 1
+      -
+        name: napi-info
+        doc: napi information such as napi-id, napi queues etc.
+        type: nest
+        multi-attr: true
+        nested-attributes: napi-info-entry
 
 operations:
   list:
@@ -101,6 +133,20 @@ operations:
       doc: Notification about device configuration being changed.
       notify: dev-get
       mcgrp: mgmt
+    -
+      name: napi-get
+      doc: napi information such as napi-id, napi queues etc.
+      attribute-set: napi
+      do:
+        request:
+          attributes:
+            - ifindex
+        reply: &napi-all
+          attributes:
+            - ifindex
+            - napi-info
+      dump:
+        reply: *napi-all
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
index c1634b95c223..bc06f692d9fd 100644
--- a/include/uapi/linux/netdev.h
+++ b/include/uapi/linux/netdev.h
@@ -48,11 +48,29 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID = 1,
+	NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES,
+	NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES,
+
+	__NETDEV_A_NAPI_INFO_ENTRY_MAX,
+	NETDEV_A_NAPI_INFO_ENTRY_MAX = (__NETDEV_A_NAPI_INFO_ENTRY_MAX - 1)
+};
+
+enum {
+	NETDEV_A_NAPI_IFINDEX = 1,
+	NETDEV_A_NAPI_NAPI_INFO,
+
+	__NETDEV_A_NAPI_MAX,
+	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
index ea9231378aa6..d09ce5db8b79 100644
--- a/net/core/netdev-genl-gen.c
+++ b/net/core/netdev-genl-gen.c
@@ -15,6 +15,11 @@ static const struct nla_policy netdev_dev_get_nl_policy[NETDEV_A_DEV_IFINDEX + 1
 	[NETDEV_A_DEV_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* NETDEV_CMD_NAPI_GET - do */
+static const struct nla_policy netdev_napi_get_nl_policy[NETDEV_A_NAPI_IFINDEX + 1] = {
+	[NETDEV_A_NAPI_IFINDEX] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for netdev */
 static const struct genl_split_ops netdev_nl_ops[] = {
 	{
@@ -29,6 +34,18 @@ static const struct genl_split_ops netdev_nl_ops[] = {
 		.dumpit	= netdev_nl_dev_get_dumpit,
 		.flags	= GENL_CMD_CAP_DUMP,
 	},
+	{
+		.cmd		= NETDEV_CMD_NAPI_GET,
+		.doit		= netdev_nl_napi_get_doit,
+		.policy		= netdev_napi_get_nl_policy,
+		.maxattr	= NETDEV_A_NAPI_IFINDEX,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd	= NETDEV_CMD_NAPI_GET,
+		.dumpit	= netdev_nl_napi_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group netdev_nl_mcgrps[] = {
diff --git a/net/core/netdev-genl-gen.h b/net/core/netdev-genl-gen.h
index 7b370c073e7d..46dab8ccd568 100644
--- a/net/core/netdev-genl-gen.h
+++ b/net/core/netdev-genl-gen.h
@@ -13,6 +13,8 @@
 
 int netdev_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
+int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info);
+int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 
 enum {
 	NETDEV_NLGRP_MGMT,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 797c813c7c77..e35cfa3cd173 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -120,6 +120,16 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
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
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
 				       unsigned long event, void *ptr)
 {
diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux/netdev.h
index c1634b95c223..bc06f692d9fd 100644
--- a/tools/include/uapi/linux/netdev.h
+++ b/tools/include/uapi/linux/netdev.h
@@ -48,11 +48,29 @@ enum {
 	NETDEV_A_DEV_MAX = (__NETDEV_A_DEV_MAX - 1)
 };
 
+enum {
+	NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID = 1,
+	NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES,
+	NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES,
+
+	__NETDEV_A_NAPI_INFO_ENTRY_MAX,
+	NETDEV_A_NAPI_INFO_ENTRY_MAX = (__NETDEV_A_NAPI_INFO_ENTRY_MAX - 1)
+};
+
+enum {
+	NETDEV_A_NAPI_IFINDEX = 1,
+	NETDEV_A_NAPI_NAPI_INFO,
+
+	__NETDEV_A_NAPI_MAX,
+	NETDEV_A_NAPI_MAX = (__NETDEV_A_NAPI_MAX - 1)
+};
+
 enum {
 	NETDEV_CMD_DEV_GET = 1,
 	NETDEV_CMD_DEV_ADD_NTF,
 	NETDEV_CMD_DEV_DEL_NTF,
 	NETDEV_CMD_DEV_CHANGE_NTF,
+	NETDEV_CMD_NAPI_GET,
 
 	__NETDEV_CMD_MAX,
 	NETDEV_CMD_MAX = (__NETDEV_CMD_MAX - 1)
diff --git a/tools/net/ynl/generated/netdev-user.c b/tools/net/ynl/generated/netdev-user.c
index 68b408ca0f7f..e9a6c8cb5c68 100644
--- a/tools/net/ynl/generated/netdev-user.c
+++ b/tools/net/ynl/generated/netdev-user.c
@@ -18,6 +18,7 @@ static const char * const netdev_op_strmap[] = {
 	[NETDEV_CMD_DEV_ADD_NTF] = "dev-add-ntf",
 	[NETDEV_CMD_DEV_DEL_NTF] = "dev-del-ntf",
 	[NETDEV_CMD_DEV_CHANGE_NTF] = "dev-change-ntf",
+	[NETDEV_CMD_NAPI_GET] = "napi-get",
 };
 
 const char *netdev_op_str(int op)
@@ -46,6 +47,17 @@ const char *netdev_xdp_act_str(enum netdev_xdp_act value)
 }
 
 /* Policies */
+struct ynl_policy_attr netdev_napi_info_entry_policy[NETDEV_A_NAPI_INFO_ENTRY_MAX + 1] = {
+	[NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID] = { .name = "napi-id", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES] = { .name = "rx-queues", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES] = { .name = "tx-queues", .type = YNL_PT_U32, },
+};
+
+struct ynl_policy_nest netdev_napi_info_entry_nest = {
+	.max_attr = NETDEV_A_NAPI_INFO_ENTRY_MAX,
+	.table = netdev_napi_info_entry_policy,
+};
+
 struct ynl_policy_attr netdev_dev_policy[NETDEV_A_DEV_MAX + 1] = {
 	[NETDEV_A_DEV_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
 	[NETDEV_A_DEV_PAD] = { .name = "pad", .type = YNL_PT_IGNORE, },
@@ -58,7 +70,78 @@ struct ynl_policy_nest netdev_dev_nest = {
 	.table = netdev_dev_policy,
 };
 
+struct ynl_policy_attr netdev_napi_policy[NETDEV_A_NAPI_MAX + 1] = {
+	[NETDEV_A_NAPI_IFINDEX] = { .name = "ifindex", .type = YNL_PT_U32, },
+	[NETDEV_A_NAPI_NAPI_INFO] = { .name = "napi-info", .type = YNL_PT_NEST, .nest = &netdev_napi_info_entry_nest, },
+};
+
+struct ynl_policy_nest netdev_napi_nest = {
+	.max_attr = NETDEV_A_NAPI_MAX,
+	.table = netdev_napi_policy,
+};
+
 /* Common nested types */
+void netdev_napi_info_entry_free(struct netdev_napi_info_entry *obj)
+{
+	free(obj->rx_queues);
+	free(obj->tx_queues);
+}
+
+int netdev_napi_info_entry_parse(struct ynl_parse_arg *yarg,
+				 const struct nlattr *nested)
+{
+	struct netdev_napi_info_entry *dst = yarg->data;
+	unsigned int n_rx_queues = 0;
+	unsigned int n_tx_queues = 0;
+	const struct nlattr *attr;
+	int i;
+
+	if (dst->rx_queues)
+		return ynl_error_parse(yarg, "attribute already present (napi-info-entry.rx-queues)");
+	if (dst->tx_queues)
+		return ynl_error_parse(yarg, "attribute already present (napi-info-entry.tx-queues)");
+
+	mnl_attr_for_each_nested(attr, nested) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NETDEV_A_NAPI_INFO_ENTRY_NAPI_ID) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.napi_id = 1;
+			dst->napi_id = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES) {
+			n_rx_queues++;
+		} else if (type == NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES) {
+			n_tx_queues++;
+		}
+	}
+
+	if (n_rx_queues) {
+		dst->rx_queues = calloc(n_rx_queues, sizeof(*dst->rx_queues));
+		dst->n_rx_queues = n_rx_queues;
+		i = 0;
+		mnl_attr_for_each_nested(attr, nested) {
+			if (mnl_attr_get_type(attr) == NETDEV_A_NAPI_INFO_ENTRY_RX_QUEUES) {
+				dst->rx_queues[i] = mnl_attr_get_u32(attr);
+				i++;
+			}
+		}
+	}
+	if (n_tx_queues) {
+		dst->tx_queues = calloc(n_tx_queues, sizeof(*dst->tx_queues));
+		dst->n_tx_queues = n_tx_queues;
+		i = 0;
+		mnl_attr_for_each_nested(attr, nested) {
+			if (mnl_attr_get_type(attr) == NETDEV_A_NAPI_INFO_ENTRY_TX_QUEUES) {
+				dst->tx_queues[i] = mnl_attr_get_u32(attr);
+				i++;
+			}
+		}
+	}
+
+	return 0;
+}
+
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
 void netdev_dev_get_req_free(struct netdev_dev_get_req *req)
@@ -178,6 +261,143 @@ void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp)
 	free(rsp);
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
+	unsigned int i;
+
+	for (i = 0; i < rsp->n_napi_info; i++)
+		netdev_napi_info_entry_free(&rsp->napi_info[i]);
+	free(rsp->napi_info);
+	free(rsp);
+}
+
+int netdev_napi_get_rsp_parse(const struct nlmsghdr *nlh, void *data)
+{
+	struct ynl_parse_arg *yarg = data;
+	struct netdev_napi_get_rsp *dst;
+	unsigned int n_napi_info = 0;
+	const struct nlattr *attr;
+	struct ynl_parse_arg parg;
+	int i;
+
+	dst = yarg->data;
+	parg.ys = yarg->ys;
+
+	if (dst->napi_info)
+		return ynl_error_parse(yarg, "attribute already present (napi.napi-info)");
+
+	mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+		unsigned int type = mnl_attr_get_type(attr);
+
+		if (type == NETDEV_A_NAPI_IFINDEX) {
+			if (ynl_attr_validate(yarg, attr))
+				return MNL_CB_ERROR;
+			dst->_present.ifindex = 1;
+			dst->ifindex = mnl_attr_get_u32(attr);
+		} else if (type == NETDEV_A_NAPI_NAPI_INFO) {
+			n_napi_info++;
+		}
+	}
+
+	if (n_napi_info) {
+		dst->napi_info = calloc(n_napi_info, sizeof(*dst->napi_info));
+		dst->n_napi_info = n_napi_info;
+		i = 0;
+		parg.rsp_policy = &netdev_napi_info_entry_nest;
+		mnl_attr_for_each(attr, nlh, sizeof(struct genlmsghdr)) {
+			if (mnl_attr_get_type(attr) == NETDEV_A_NAPI_NAPI_INFO) {
+				parg.data = &dst->napi_info[i];
+				if (netdev_napi_info_entry_parse(&parg, attr))
+					return MNL_CB_ERROR;
+				i++;
+			}
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
+	if (req->_present.ifindex)
+		mnl_attr_put_u32(nlh, NETDEV_A_NAPI_IFINDEX, req->ifindex);
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
+		unsigned int i;
+
+		rsp = next;
+		next = rsp->next;
+
+		for (i = 0; i < rsp->obj.n_napi_info; i++)
+			netdev_napi_info_entry_free(&rsp->obj.napi_info[i]);
+		free(rsp->obj.napi_info);
+		free(rsp);
+	}
+}
+
+struct netdev_napi_get_list *netdev_napi_get_dump(struct ynl_sock *ys)
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
index 0952d3261f4d..9274711bd862 100644
--- a/tools/net/ynl/generated/netdev-user.h
+++ b/tools/net/ynl/generated/netdev-user.h
@@ -20,6 +20,18 @@ const char *netdev_op_str(int op);
 const char *netdev_xdp_act_str(enum netdev_xdp_act value);
 
 /* Common nested types */
+struct netdev_napi_info_entry {
+	struct {
+		__u32 napi_id:1;
+	} _present;
+
+	__u32 napi_id;
+	unsigned int n_rx_queues;
+	__u32 *rx_queues;
+	unsigned int n_tx_queues;
+	__u32 *tx_queues;
+};
+
 /* ============== NETDEV_CMD_DEV_GET ============== */
 /* NETDEV_CMD_DEV_GET - do */
 struct netdev_dev_get_req {
@@ -84,4 +96,55 @@ struct netdev_dev_get_ntf {
 
 void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
 
+/* ============== NETDEV_CMD_NAPI_GET ============== */
+/* NETDEV_CMD_NAPI_GET - do */
+struct netdev_napi_get_req {
+	struct {
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 ifindex;
+};
+
+static inline struct netdev_napi_get_req *netdev_napi_get_req_alloc(void)
+{
+	return calloc(1, sizeof(struct netdev_napi_get_req));
+}
+void netdev_napi_get_req_free(struct netdev_napi_get_req *req);
+
+static inline void
+netdev_napi_get_req_set_ifindex(struct netdev_napi_get_req *req, __u32 ifindex)
+{
+	req->_present.ifindex = 1;
+	req->ifindex = ifindex;
+}
+
+struct netdev_napi_get_rsp {
+	struct {
+		__u32 ifindex:1;
+	} _present;
+
+	__u32 ifindex;
+	unsigned int n_napi_info;
+	struct netdev_napi_info_entry *napi_info;
+};
+
+void netdev_napi_get_rsp_free(struct netdev_napi_get_rsp *rsp);
+
+/*
+ * napi information such as napi-id, napi queues etc.
+ */
+struct netdev_napi_get_rsp *
+netdev_napi_get(struct ynl_sock *ys, struct netdev_napi_get_req *req);
+
+/* NETDEV_CMD_NAPI_GET - dump */
+struct netdev_napi_get_list {
+	struct netdev_napi_get_list *next;
+	struct netdev_napi_get_rsp obj __attribute__ ((aligned (8)));
+};
+
+void netdev_napi_get_list_free(struct netdev_napi_get_list *rsp);
+
+struct netdev_napi_get_list *netdev_napi_get_dump(struct ynl_sock *ys);
+
 #endif /* _LINUX_NETDEV_GEN_H */


