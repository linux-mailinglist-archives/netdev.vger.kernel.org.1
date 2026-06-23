Return-Path: <netdev+bounces-301328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 85mQB8tcOmqL7AcAu9opvQ
	(envelope-from <netdev+bounces-301328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:15:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 885446B629A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=Yc1vb7Ed;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301328-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F6663013EDE
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 10:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A677370D43;
	Tue, 23 Jun 2026 10:15:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50436371D05
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:15:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782209704; cv=none; b=PqkeM33KI2Nxrm8LtPw+aXKdLbRZTX+7wBlJaOzaRSuQApHShh/4e3poKC17ZtsEdRjOGDcrxXehfmsKtLLmgr48fFQ9IssV/ufHrBMJromJp+VaI8tvNC3iqhwWXlOupdHi2ly+6cVQ0xlwGC1IXFUw0Jjtj+XavyE5aLKuMzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782209704; c=relaxed/simple;
	bh=KHVb5amGCiOVyZ3hob0z0Edzl37bwdXo7Ts5KMKuH0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bi1iBtcq63OHPrKxgoZ+pC9PxYyEhYfZp4UHYEBMvbKr8ve5CdoeyF6cYFLguPjo2Om9gd/H937xtYqZvIpZTgELIFsU24EPlRObY9rLg07gebTs11egTdGmrb1ma+7hLkkdr+RuQDUbCUao6AR2B3U4uA9fqMdcEAAd6a8aYFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yc1vb7Ed; arc=none smtp.client-ip=192.198.163.18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782209702; x=1813745702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KHVb5amGCiOVyZ3hob0z0Edzl37bwdXo7Ts5KMKuH0o=;
  b=Yc1vb7EddTWSluwwiKTnfCgS/P1mCLHzfMeob2AKPbviHL7p5inGASlU
   bk5fFEwgJiMZ578rPMAziAF/3BuQYDM7nguAcmiFOC2I93YhG53KwSk63
   XqjjExWYoGad/ZTrRfSpHJI53aPoNrkiDBzNYQG0MNCbWRRmAd06PFz0/
   LVkx40VP6YW8ET6fnL0X3ReXD8ndxJcRv+P2iv5f6Obup7CV6VIPUIN8G
   HY0eDb0I35E/HiMWIh9nRRDf7oFKY0j4oOzMMfUPyaiJXBMsZSN1JYAU4
   y5IHUjfobCK1Vggtfhgyqvu4IK+z6nnON9W/b3CgpER58CRWGm/NeKpeV
   Q==;
X-CSE-ConnectionGUID: CiMiky53TPSxrPDchL8Npw==
X-CSE-MsgGUID: UKRWqM7WTxu2hPok1rQ+fA==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82053169"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="82053169"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 03:15:02 -0700
X-CSE-ConnectionGUID: w0xksBozTniM84Wdz0CsDQ==
X-CSE-MsgGUID: BoarUubiT0SOOAeoEXlJ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="273175500"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa002.fm.intel.com with ESMTP; 23 Jun 2026 03:14:57 -0700
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
	dev@lankhorst.se,
	zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com,
	mallesh.koujalagi@intel.com,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 2/5] drm/ras: Introduce error threshold
Date: Tue, 23 Jun 2026 15:39:56 +0530
Message-ID: <20260623101043.255897-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623101043.255897-1-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301328-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:riana.tauro@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,m:raag.jadav@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 885446B629A

Add get-error-threshold and set-error-threshold command support which
allows querying/setting error threshold of the counter. Threshold in RAS
context means the number of errors the hardware is expected to accumulate
before it raises them to software. This is to have a fine grained control
over error notifications that are raised by the hardware.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
    Document threshold bounds checking responsibility (Riana)
v3: Move documentation from yaml to rst file (Riana)
    s/value/threshold (Riana)
    Use goto for error handling (Riana)
v4: Clarify 0 threshold expectations (Riana)
    Drop redundant wrapping (Riana)
---
 Documentation/gpu/drm-ras.rst            |  18 +++
 Documentation/netlink/specs/drm_ras.yaml |  32 +++++
 drivers/gpu/drm/drm_ras.c                | 161 +++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
 drivers/gpu/drm/drm_ras_nl.h             |   4 +
 include/drm/drm_ras.h                    |  28 ++++
 include/uapi/drm/drm_ras.h               |   3 +
 7 files changed, 273 insertions(+)

diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
index 83c21853b74b..2718f8aee09d 100644
--- a/Documentation/gpu/drm-ras.rst
+++ b/Documentation/gpu/drm-ras.rst
@@ -56,6 +56,10 @@ User space tools can:
   ``node-id`` and ``error-id`` as parameters.
 * Clear specific error counters with the ``clear-error-counter`` command, using both
   ``node-id`` and ``error-id`` as parameters.
+* Query specific error counter threshold with the ``get-error-threshold`` command, using both
+  ``node-id`` and ``error-id`` as parameters.
+* Set specific error counter threshold with the ``set-error-threshold`` command, using
+  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
 
 YAML-based Interface
 --------------------
@@ -111,3 +115,17 @@ Example: Clear an error counter for a given node
 
     sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
     None
+
+Example: Query error threshold of a given counter
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
+    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
+
+Example: Set error threshold of a given counter
+
+.. code-block:: bash
+
+    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
+    None
diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
index e113056f8c01..9cf7f9cde242 100644
--- a/Documentation/netlink/specs/drm_ras.yaml
+++ b/Documentation/netlink/specs/drm_ras.yaml
@@ -69,6 +69,10 @@ attribute-sets:
         name: error-value
         type: u32
         doc: Current value of the requested error counter.
+      -
+        name: error-threshold
+        type: u32
+        doc: Error threshold of the counter.
 
 operations:
   list:
@@ -124,3 +128,31 @@ operations:
       do:
         request:
           attributes: *id-attrs
+    -
+      name: get-error-threshold
+      doc: >-
+           Retrieve error threshold of a given counter.
+           The response includes the id, the name, and current threshold
+           of the counter.
+      attribute-set: error-counter-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes: *id-attrs
+        reply:
+          attributes:
+            - error-id
+            - error-name
+            - error-threshold
+    -
+      name: set-error-threshold
+      doc: >-
+           Set error threshold of a given counter.
+      attribute-set: error-counter-attrs
+      flags: [admin-perm]
+      do:
+        request:
+          attributes:
+            - node-id
+            - error-id
+            - error-threshold
diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 467a169026fc..d60c40ac5427 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -41,6 +41,13 @@
  *    Userspace must provide Node ID, Error ID.
  *    Clears specific error counter of a node if supported.
  *
+ * 4. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
+ *    Userspace must provide Node ID and Error ID.
+ *    Returns the error threshold of a specific counter.
+ *
+ * 5. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
+ *    Userspace must provide Node ID, Error ID and threshold to be set.
+ *
  * Node registration:
  *
  * - drm_ras_node_register(): Registers a new node and assigns
@@ -61,6 +68,16 @@
  *     + The error counters in the driver doesn't need to be contiguous, but the
  *       driver must return -ENOENT to the query_error_counter as an indication
  *       that the ID should be skipped and not listed in the netlink API.
+ *     + The driver can optionally implement query_error_threshold() and
+ *       set_error_threshold() callbacks to facilitate getting/setting error
+ *       threshold of the counter. Threshold in RAS context means the number of
+ *       errors the hardware is expected to accumulate before it raises them to
+ *       software. This is to have a fine grained control over error notifications
+ *       that are raised by the hardware.
+ *     + The driver is responsible for error threshold bounds checking.
+ *     + Threshold of 0 can mean invalid threshold or act as a disable notifications
+ *       toggle for that counter depending on usecase and the driver is responsible
+ *       for handling it as needed.
  *
  * Netlink handlers:
  *
@@ -72,6 +89,10 @@
  *   operation, fetching a counter value from a specific node.
  * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
  *   operation, clearing a counter value from a specific node.
+ * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
+ *   operation, fetching the error threshold of a specific counter.
+ * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
+ *   operation, setting the error threshold of a specific counter.
  */
 
 static DEFINE_XARRAY_ALLOC(drm_ras_xa);
@@ -168,6 +189,40 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
+static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
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
+	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->query_error_threshold(node, error_id, name, threshold);
+}
+
+static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
+{
+	struct drm_ras_node *node;
+
+	node = xa_load(&drm_ras_xa, node_id);
+	if (!node)
+		return -ENOENT;
+
+	if (!node->set_error_threshold)
+		return -EOPNOTSUPP;
+
+	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
+		return -EINVAL;
+
+	return node->set_error_threshold(node, error_id, threshold);
+}
+
 static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   const char *error_name, u32 value)
 {
@@ -186,6 +241,22 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
+static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *error_name,
+			       u32 threshold)
+{
+	int ret;
+
+	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
+	if (ret)
+		return ret;
+
+	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, error_name);
+	if (ret)
+		return ret;
+
+	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, threshold);
+}
+
 static int doit_reply_value(struct genl_info *info, u32 node_id,
 			    u32 error_id)
 {
@@ -225,6 +296,43 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	return ret;
 }
 
+static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
+{
+	const char *error_name;
+	struct sk_buff *msg;
+	struct nlattr *hdr;
+	u32 threshold;
+	int ret;
+
+	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_iput(msg, info);
+	if (!hdr) {
+		ret = -EMSGSIZE;
+		goto free_msg;
+	}
+
+	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
+	if (ret)
+		goto cancel_msg;
+
+	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
+	if (ret)
+		goto cancel_msg;
+
+	genlmsg_end(msg, hdr);
+
+	return genlmsg_reply(msg, info);
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
+}
+
 /**
  * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
  * @skb: Netlink message buffer
@@ -358,6 +466,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 	return node->clear_error_counter(node, error_id);
 }
 
+/**
+ * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the Node ID and Error ID from the netlink attributes and retrieves
+ * the error threshold of the corresponding counter. Sends the result back to
+ * the requesting user via the standard Genl reply.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
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
+	return doit_reply_threshold(info, node_id, error_id);
+}
+
+/**
+ * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a counter
+ * @skb: Netlink message buffer
+ * @info: Generic Netlink info containing attributes of the request
+ *
+ * Extracts the Node ID, Error ID and threshold from the netlink attributes and
+ * sets the error threshold of the corresponding counter.
+ *
+ * Return: 0 on success, or negative errno on failure.
+ */
+int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	u32 node_id, error_id, threshold;
+
+	if (!info->attrs ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
+	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
+		return -EINVAL;
+
+	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
+	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
+	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
+
+	return set_node_error_threshold(node_id, error_id, threshold);
+}
+
 /**
  * drm_ras_node_register() - Register a new RAS node
  * @node: Node structure to register
diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
index dea1c1b2494e..02e8e5054d05 100644
--- a/drivers/gpu/drm/drm_ras_nl.c
+++ b/drivers/gpu/drm/drm_ras_nl.c
@@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
 	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
 };
 
+/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
+static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
+};
+
+/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
+static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
+	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
+};
+
 /* Ops table for drm_ras */
 static const struct genl_split_ops drm_ras_nl_ops[] = {
 	{
@@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
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
+	{
+		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
+		.doit		= drm_ras_nl_set_error_threshold_doit,
+		.policy		= drm_ras_set_error_threshold_nl_policy,
+		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
+		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
+	},
 };
 
 struct genl_family drm_ras_nl_family __ro_after_init = {
diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
index a398643572a5..57b1e647d833 100644
--- a/drivers/gpu/drm/drm_ras_nl.h
+++ b/drivers/gpu/drm/drm_ras_nl.h
@@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 					struct netlink_callback *cb);
 int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
 					struct genl_info *info);
+int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info);
+int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
+					struct genl_info *info);
 
 extern struct genl_family drm_ras_nl_family;
 
diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
index f2a787bc4f64..683a3844f84f 100644
--- a/include/drm/drm_ras.h
+++ b/include/drm/drm_ras.h
@@ -69,6 +69,34 @@ struct drm_ras_node {
 	 */
 	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
 
+	/**
+	 * @query_error_threshold:
+	 *
+	 * This callback is used by drm-ras to query error threshold of a
+	 * specific counter.
+	 *
+	 * Driver should expect query_error_threshold() to be called with
+	 * error_id from `error_counter_range.first` to
+	 * `error_counter_range.last`.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
+				     u32 *threshold);
+	/**
+	 * @set_error_threshold:
+	 *
+	 * This callback is used by drm-ras to set error threshold of a specific
+	 * counter.
+	 *
+	 * Driver should expect set_error_threshold() to be called with error_id
+	 * from `error_counter_range.first` to `error_counter_range.last`.
+	 * Driver is responsible for error threshold bounds checking.
+	 *
+	 * Returns: 0 on success, negative error code on failure.
+	 */
+	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
+
 	/** @priv: Driver private data */
 	void *priv;
 };
diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
index 218a3ee86805..27c68956495f 100644
--- a/include/uapi/drm/drm_ras.h
+++ b/include/uapi/drm/drm_ras.h
@@ -33,6 +33,7 @@ enum {
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
+	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
 
 	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
 	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
@@ -42,6 +43,8 @@ enum {
 	DRM_RAS_CMD_LIST_NODES = 1,
 	DRM_RAS_CMD_GET_ERROR_COUNTER,
 	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
+	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
+	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
 
 	__DRM_RAS_CMD_MAX,
 	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
-- 
2.43.0


