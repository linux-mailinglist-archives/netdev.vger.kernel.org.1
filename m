Return-Path: <netdev+bounces-287272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePs/KXt9A2pV6QEAu9opvQ
	(envelope-from <netdev+bounces-287272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:20:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F66E528814
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B6B43028545
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9087317162;
	Tue, 12 May 2026 19:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+JN8haW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9B625A359
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613600; cv=none; b=qpy08oNXmckXGnlC8IwYMKpszsPEpjCsVgh3nd79ldGGvcwaUlu+U4Jk250IsKkpZ0WLC9PUgg7NpoctgMdhZ7UWsFtxJOLETxXcn8DU5f7AjJcPnpF4sl2Q4Tz7xQGtlRDZJ10itRkM34KY0JIaFnw5YYT87rvfIYnCTzhz/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613600; c=relaxed/simple;
	bh=v1vqfOaYMuu2Ly9z68QWB/HFt0GqcmosMM2L2CKEIo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ0umaK1sSrWSTydatAhR7A3jhK+H00g99x+IZ39zDaSt/f/1Mxddp8B//Ys4psoeMBd3jN42ZU0zeuG+oU4tFXlzHxRkoWB4Pr9DaP6TKXYHu+St6RtK6/WT9IA8zu0pjtPTGlLt8r91KSRhhv3qVWKWVsMFgOyUZOjlOeDAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+JN8haW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778613599; x=1810149599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v1vqfOaYMuu2Ly9z68QWB/HFt0GqcmosMM2L2CKEIo8=;
  b=N+JN8haW12dVuoZEL6ZXOvmbPWIkyRHR5gMSOmhMSwNC19xlq670JJ0s
   pRY48feONC/FFXIDbzV7ff0KvbQgHojNAzXNUpxx0rB5F/s3SZGCsLH6L
   SgVthdgWzO4dwiC4N2FCronvkCvUeKzTv9rGeAlj9WWfA/RRSkuo0aaJ1
   VOsKBMhL3ArqQ0m6u1jji2LDXjSeToa2fkOLJRWKo6Uq/6ZrEFi77WLDR
   adyScuDDY++zgTpyIWxSrhLwdMWwuv1I+MezIjdi63gbQkBaeYBfnqPFd
   BPSd7TmIOwUJQ4qav747Ss5OC6OWSFR+XpozwyQ5CzCc61kTjG68hkkLm
   g==;
X-CSE-ConnectionGUID: wtHzKDPUReOnSmB0CHYMSw==
X-CSE-MsgGUID: rQVqG2GpTRegl+Zy/1xMqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406375"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83406375"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:19:58 -0700
X-CSE-ConnectionGUID: fZ/AkfkrQLq5ZBmtQmL4wQ==
X-CSE-MsgGUID: 8KrtBNmiT4KyxJMQy2gbaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237781474"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:19:53 -0700
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
	anoop.c.vijay@intel.com,
	aravind.iddamsetty@linux.intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 2/9] drm/ras: Introduce get-error-threshold
Date: Wed, 13 May 2026 00:46:03 +0530
Message-ID: <20260512191610.1817578-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512191610.1817578-1-raag.jadav@intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9F66E528814
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287272-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add get-error-threshold command support which allows querying threshold
value of an error. Threshold in RAS context means the number of errors
the hardware is expected to accumulate before it raises them to software.
This is to have a fine grained control over error notifications that are
raised by the hardware.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
---
 Documentation/gpu/drm-ras.rst            |   9 ++
 Documentation/netlink/specs/drm_ras.yaml |  28 +++++-
 drivers/gpu/drm/drm_ras.c                | 109 +++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  13 +++
 drivers/gpu/drm/drm_ras_nl.h             |   2 +
 include/drm/drm_ras.h                    |  15 ++++
 include/uapi/drm/drm_ras.h               |   2 +
 7 files changed, 176 insertions(+), 2 deletions(-)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 4636e68f5678..dfa72e8becda 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -54,6 +54,8 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Clear specific error counters with the ``clear-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Query specific error threshold value with the ``get-error-threshold`` command, using both
+  ``node-id`` and ``error-id`` as parameters.
 
 YAML-based Interface
 --------------------
@@ -109,3 +111,10 @@ Example: Clear an error counter for a given node
 
     sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
     None
+
+Example: Query threshold value of a given error
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
+    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index e113056f8c01..016d713069bb 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -8,8 +8,10 @@ doc: >-
   DRM RAS (Reliability, Availability, Serviceability) over Generic Netlink.
   Provides a standardized mechanism for DRM drivers to register "nodes"
   representing hardware/software components capable of reporting error counters.
-  Userspace tools can query the list of nodes or individual error counters
-  via the Generic Netlink interface.
+  Userspace tools can query the list of nodes or individual error counters or
+  their thresholds via the Generic Netlink interface. Threshold in RAS context
+  means the number of errors the hardware is expected to accumulate before it
+  raises them to software.
 
 definitions:
   -
@@ -69,6 +71,10 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the requested error counter.
+      -
+        name: error-threshold
+        type: u32
+        doc: Threshold value of the error counter.
 
 operations:
   list:
@@ -124,3 +130,21 @@ operations:
       do:
         request:
           attributes: *id-attrs
+    -
+      name: get-error-threshold
+      doc: >-
+           Retrieve threshold value of an error.
+           The response includes the id, the name, and current threshold
+           value of the error.
+      attribute-set: error-counter-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+            - error-id
+        reply:
+          attributes:
+            - error-id
+            - error-name
+            - error-threshold
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 03db53d03329..87e57bd1e8ad 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,10 @@
  *    Userspace must provide Node ID, Error ID.
  *    Clears specific error counter of a node if supported.
  *
+ * 4. GET_ERROR_THRESHOLD: Query threshold value of an error.
+ *    Userspace must provide Node ID and Error ID.
+ *    Returns the threshold value of a specific error.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -72,6 +76,8 @@
  *   operation, fetching a counter value from a specific node.
  * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
  *   operation, clearing a counter value from a specific node.
+ * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
+ *   operation, fetching the threshold value of a specific error.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -168,6 +174,25 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
+static int get_node_error_threshold(u32 node_id, u32 error_id,
+				    const char **name, u32 *value)
+{
+	struct drm_ras_node *node;
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node)
+		return -ENOENT;
+
+	if (!node->query_error_threshold)
+		return -EOPNOTSUPP;
+
+	if (error_id < node->error_counter_range.first ||
+	    error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->query_error_threshold(node, error_id, name, value);
+}
+
 static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
 				   const char *error_name, u32 value)
 {
@@ -186,6 +211,24 @@ static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
+static int msg_reply_threshold_value(struct sk_buff *msg, u32 error_id,
+				     const char *error_name, u32 value)
+{
+	int ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
+			     error_name);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
+			   value);
+}
+
 static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
 				    u32 error_id)
 {
@@ -222,6 +265,45 @@ static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
 	return genlmsg_reply(msg, info);
 }
 
+static int doit_reply_threshold_value(struct genl_info *info, u32 node_id,
+				      u32 error_id)
+{
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	const char *error_name;
+	u32 value;
+	int ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		nlmsg_free(msg);
+		return -EMSGSIZE;
+	}
+
+	ret = get_node_error_threshold(node_id, error_id,
+				       &error_name, &value);
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	ret = msg_reply_threshold_value(msg, error_id, error_name, value);
+	if (ret) {
+		genlmsg_cancel(msg, hdr);
+		nlmsg_free(msg);
+		return ret;
+	}
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+}
+
 /**
  * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
  * @skb: Netlink message buffer
@@ -355,6 +437,33 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	return node->clear_error_counter(node, error_id);
 }
 
+/**
+ * drm_ras_nl_get_error_threshold_doit() - Query threshold value of an error
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the Node ID and Error ID from the netlink attributes and
+ * retrieves the threshold value of the corresponding error. Sends the
+ * result back to the requesting user via the standard Genl reply.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info)
+{
+	u32 node_id, error_id;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
+	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
+
+	return doit_reply_threshold_value(info, node_id, error_id);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index dea1c1b2494e..ecec2041c758 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -28,6 +28,12 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
+static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -56,6 +62,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
 		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
+		.doit		= drm_ras_nl_get_error_threshold_doit,
+		.policy		= drm_ras_get_error_threshold_nl_policy,
+		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family drm_ras_nl_family __ro_after_init = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index a398643572a5..399280c2c6e1 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -20,6 +20,8 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 					struct netlink_callback *cb);
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info);
 
 extern struct genl_family drm_ras_nl_family;
 
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index f2a787bc4f64..7bb429d85f57 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -69,6 +69,21 @@ struct drm_ras_node {
 	 */
 	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
 
+	/**
+	 * @query_error_threshold:
+	 *
+	 * This callback is used by drm-ras to query threshold value of a
+	 * specific error.
+	 *
+	 * Driver should expect query_error_threshold() to be called with
+	 * error_id from `error_counter_range.first` to
+	 * `error_counter_range.last`.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
+				     const char **name, u32 *val);
+
 	/** @priv: Driver private data */
 	void *priv;
 };
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 218a3ee86805..59530f987ba2 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -33,6 +33,7 @@ enum {
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
+	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
 
 	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
@@ -42,6 +43,7 @@ enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0


