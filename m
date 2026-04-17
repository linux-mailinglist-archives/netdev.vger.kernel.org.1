Return-Path: <netdev+bounces-279424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P4gDIqk4mk58gAAu9opvQ
	(envelope-from <netdev+bounces-279424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6295341EAB0
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91C82301E78C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35636C9D2;
	Fri, 17 Apr 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F/aDmB1c"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0236922D
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460885; cv=none; b=W4runusikkokrkneYcrZmS2FmK7M1ZvRKiW2VI5qMNg+eFBLaDK9bz9hDslvx3Y8hJmv66wTLvXZNgWCi73NAW9fmfFoQjGUjktq/sdlOSoOjBAcWhcFVRfLGBb3HsUnJqipro8wjffY2A3fXfC3knF26jWEnIiGG1y0G/+Wn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460885; c=relaxed/simple;
	bh=G22Kyu9VEMxvL4heHi6swMjVWY+Q7RqxuTR+xuSOz8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpo/3NcaM8hdtzu/nLhF8pNwCdMgGf6LVoa7xNg1ZbFsDV2nJha/K3fgd+c5v6qNfrfZso6T12+XL5G3FI3xmlRo0S2S/hkEONeff90VH6G/22R48Z92XQ2hkZq5TPuDgoNC9b4zCNDSVkn6gQIMCb+W6X1CvxDE+35V7BDiVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F/aDmB1c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776460882; x=1807996882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G22Kyu9VEMxvL4heHi6swMjVWY+Q7RqxuTR+xuSOz8o=;
  b=F/aDmB1cZnYqVtKcrI+E5q7cn9rNq+d9Z+CW/CpyamYTSmBZ3uYjAqat
   x07JubjOl3rB21p6tnuo2sJAJSXmd9p2snyyFvVBkN07lvuAxKAs9HaAx
   F/F8cb/vOR7PBhvwfGtVNuW/mZ1qW0btdmQhW9T6n3P+MxNgWmtTD5nF8
   DMM3GRHlDM/TMfN4jjQaOi0L0obhx7hPwTX3OozQHx9dVcuyRVCw4Ot9i
   cmiM2LqF1n7oLW3jmLmGpNVxHvpXAc8IcwfBeafmrx3dYsVL16IGDe6f/
   9tZPckiYrXaWyrEhmTC3U1ut1NJsJIsuIxokJO2p4NI3Hatp9p4WtLbKP
   g==;
X-CSE-ConnectionGUID: sNy4rrMsSVWtxPocL6SkZg==
X-CSE-MsgGUID: zFswB6+MRNiHDhG1Q1xY/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046114"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="95046114"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 14:21:21 -0700
X-CSE-ConnectionGUID: 3+ZfSopiSSquM2EAzlzYMA==
X-CSE-MsgGUID: ww12e8vbRliTDQ84ZpKNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="235503799"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:21:16 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch,
	airlied@gmail.com,
	kuba@kernel.org,
	lijo.lazar@amd.com,
	Hawking.Zhang@amd.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	maarten@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 03/11] drm/ras: Introduce set-error-threshold
Date: Sat, 18 Apr 2026 02:46:38 +0530
Message-ID: <20260417211730.837345-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279424-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6295341EAB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add set-error-threshold command support which allows setting threshold
value of the error. Threshold in RAS context means the number of errors
the hardware is expected to accumulate before it raises them to software.
This is to have a fine grained control over error notifications that are
raised by the hardware.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 Documentation/gpu/drm-ras.rst            |  9 +++++
 Documentation/netlink/specs/drm_ras.yaml | 12 ++++++
 drivers/gpu/drm/drm_ras.c                | 48 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             | 14 +++++++
 drivers/gpu/drm/drm_ras_nl.h             |  2 +
 include/drm/drm_ras.h                    | 13 +++++++
 include/uapi/drm/drm_ras.h               |  1 +
 7 files changed, 99 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 6443dfd1677f..a819aa150604 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -54,6 +54,8 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Query specific error threshold value with the ``get-error-threshold`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Set specific error threshold value with the ``set-error-threshold`` command, using
+  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
 
 YAML-based Interface
 --------------------
@@ -109,3 +111,10 @@ Example: Query threshold value of a given error
 
     sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
     {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 0}
+
+Example: Set threshold value of a given error
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
+    None
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index 95a939fb987d..09824309cdff 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -150,3 +150,15 @@ operations:
             - error-id
             - error-name
             - error-threshold
+    -
+      name: set-error-threshold
+      doc: >-
+           Set threshold value of the error.
+      attribute-set: error-threshold-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+            - error-id
+            - error-threshold
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d2d853d5d69c..e4ff6d87f824 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,9 @@
  *    Userspace must provide Node ID and Error ID.
  *    Returns the threshold value of a specific error.
  *
+ * 4. SET_ERROR_THRESHOLD: Set threshold value of the error.
+ *    Userspace must provide Node ID, Error ID and Threshold value to be set.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -72,6 +75,8 @@
  *   operation, fetching a counter value from a specific node.
  * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
  *   operation, fetching the threshold value of a specific error.
+ * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
+ *   operation, setting the threshold value of a specific error.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -184,6 +189,21 @@ static int get_node_error_threshold(u32 node_id, u32 error_id,
 	return node->query_error_threshold(node, error_id, name, value);
 }
 
+static int set_node_error_threshold(u32 node_id, u32 error_id, u32 value)
+{
+	struct drm_ras_node *node;
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node || !node->set_error_threshold)
+		return -ENOENT;
+
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->set_error_threshold(node, error_id, value);
+}
+
 static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
 				   const char *error_name, u32 value)
 {
@@ -417,6 +437,34 @@ int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 	return doit_reply_threshold_value(info, node_id, error_id);
 }
 
+/**
+ * drm_ras_nl_set_error_threshold_doit() - Set threshold value of the error
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the node ID, error ID and threshold value from the netlink attributes
+ * and sets the threshold of the corresponding error.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
+				      struct genl_info *info)
+{
+	u32 node_id, error_id, value;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID]);
+	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID]);
+	value = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD]);
+
+	return set_node_error_threshold(node_id, error_id, value);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index 48e231734f4d..8b202d773dac 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -28,6 +28,13 @@ static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
+static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD + 1] = {
+	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -56,6 +63,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+		.doit		= drm_ras_nl_set_error_threshold_doit,
+		.policy		= drm_ras_set_error_threshold_nl_policy,
+		.maxattr	= DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family drm_ras_nl_family __ro_after_init = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index 540fe22e2312..9db7f5d00201 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -20,6 +20,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 					struct netlink_callback *cb);
 int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info);
 
 extern struct genl_family drm_ras_nl_family;
 
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index 50cee70bd065..7a69821b8b78 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -71,6 +71,19 @@ struct drm_ras_node {
 	 */
 	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
 				     const char **name, u32 *val);
+	/**
+	 * @set_error_threshold:
+	 *
+	 * This callback is used by drm-ras to set threshold value of a specific
+	 * error.
+	 *
+	 * Driver should expect set_error_threshold() to be called with error_id
+	 * from `error_counter_range.first` to `error_counter_range.last`.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id,
+				   u32 val);
 
 	/** @priv: Driver private data */
 	void *priv;
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 49c5ca497d73..8ff0311d0d63 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -52,6 +52,7 @@ enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0


