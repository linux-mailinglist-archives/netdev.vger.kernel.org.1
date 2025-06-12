Return-Path: <netdev+bounces-197039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE9AD768E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FBE164660
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CCE2D3205;
	Thu, 12 Jun 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZMtz17wg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA12D3209;
	Thu, 12 Jun 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749742486; cv=none; b=Bxt08ReH/RqY9zRSiGg+9PAA/rO2Sq/4SIwkuiSDtNH6pqHD5ubruvhi9sZlpSWzrFWhgC+mHBf8P/r9ThGVFx/8JBOIdmdC+j0xB13GBdaCcXghlC9Ns81iNYx6fShIF57BgbfDUAr7xt91TscZ2VJ3MNfWJrWm1HHrFVBG6vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749742486; c=relaxed/simple;
	bh=4Ax1CIXKHFAYOVj6YnQTFaocDQpTvLqh5wBBaU6pP4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TOWTqGl89oyyScfiLVXsdvVjdhlB9T3n+J8eT2xUL7AhodoUcS+5zDKwaIr44Nu4Red4zMLXVmI+WZbLFqTnekOrXAA6M/SD+tbJdK64VA6HOi/VPuOnmyJdkIRARTqCpwyDJRsK2ifTVcq1RQvUJcI1xtdVIXVGa+CrBSHU2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZMtz17wg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749742483; x=1781278483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4Ax1CIXKHFAYOVj6YnQTFaocDQpTvLqh5wBBaU6pP4A=;
  b=ZMtz17wgJREC/63WieF/2SVkDNnHr5o3ukNpKN09JbB0cuV+tmeB8gsa
   pCTJzBcExPAEC26tniWlgV3R+ycUAyYrRsykmZLJG7/C0b/sEQOcJAvP4
   5I1CzZQky46hNOWbBra9HBLcScVTpGv/QA4raUt2wNeSOpVS0LDgfIq1J
   UsTTGB1xZfCFtUw4dki6yx45pwbiQ+Cya50p9gFcNXmOo1pbApFIZpQLX
   PqFqIpIjdNTPFsEQOGASvAbmBP7/OE6NInFoipeONQYBC4h6D2K2Y2ayx
   gzv4VoP9+rPP824S2p4W6S11xzO8hlyTmRY1IXcDHORRFO+Ej+2+lAOc7
   w==;
X-CSE-ConnectionGUID: V8rGLWHsST2E35ZJpsCygQ==
X-CSE-MsgGUID: KCty4YEdR9eC+uvaQp0cSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51158637"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="51158637"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 08:34:42 -0700
X-CSE-ConnectionGUID: JrzIpQRLTg6XOetjR8fz0A==
X-CSE-MsgGUID: hGLqhkKbT2eelqeARiBd8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; 
   d="scan'208";a="152546847"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa004.jf.intel.com with ESMTP; 12 Jun 2025 08:34:38 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jiri@resnulli.us,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	aleksandr.loktionov@intel.com,
	milena.olech@intel.com,
	corbet@lwn.net
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-doc@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next v6 1/3] dpll: add phase-offset-monitor feature to netlink spec
Date: Thu, 12 Jun 2025 17:28:33 +0200
Message-Id: <20250612152835.1703397-2-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250612152835.1703397-1-arkadiusz.kubalewski@intel.com>
References: <20250612152835.1703397-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enum dpll_feature_state for control over features.

Add dpll device level attribute:
DPLL_A_PHASE_OFFSET_MONITOR - to allow control over a phase offset monitor
feature. Attribute is present and shall return current state of a feature
(enum dpll_feature_state), if the device driver provides such capability,
otherwie attribute shall not be present.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v6:
- rebase.
---
 Documentation/driver-api/dpll.rst     | 18 ++++++++++++++++++
 Documentation/netlink/specs/dpll.yaml | 24 ++++++++++++++++++++++++
 drivers/dpll/dpll_nl.c                |  5 +++--
 include/uapi/linux/dpll.h             | 12 ++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index e6855cd37e85..195e1e5d9a58 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -214,6 +214,24 @@ offset values are fractional with 3-digit decimal places and shell be
 divided with ``DPLL_PIN_PHASE_OFFSET_DIVIDER`` to get integer part and
 modulo divided to get fractional part.
 
+Phase offset monitor
+====================
+
+Phase offset measurement is typically performed against the current active
+source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
+the capability to monitor phase offsets across all available inputs.
+The attribute and current feature state shall be included in the response
+message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
+In such cases, users can also control the feature using the
+``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
+values for the attribute.
+Once enabled the phase offset measurements for the input shall be returned
+in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
+
+  =============================== ========================
+  ``DPLL_A_PHASE_OFFSET_MONITOR`` attr state of a feature
+  =============================== ========================
+
 Embedded SYNC
 =============
 
diff --git a/Documentation/netlink/specs/dpll.yaml b/Documentation/netlink/specs/dpll.yaml
index 115d1a8f50bd..3bd6851c1d3c 100644
--- a/Documentation/netlink/specs/dpll.yaml
+++ b/Documentation/netlink/specs/dpll.yaml
@@ -240,6 +240,20 @@ definitions:
       integer part of a measured phase offset value.
       Value of (DPLL_A_PHASE_OFFSET % DPLL_PHASE_OFFSET_DIVIDER) is a
       fractional part of a measured phase offset value.
+  -
+    type: enum
+    name: feature-state
+    doc: |
+      Allow control (enable/disable) and status checking over features.
+    entries:
+      -
+        name: disable
+        doc: |
+          feature shall be disabled
+      -
+        name: enable
+        doc: |
+          feature shall be enabled
 
 attribute-sets:
   -
@@ -293,6 +307,14 @@ attribute-sets:
           be put to message multiple times to indicate possible parallel
           quality levels (e.g. one specified by ITU option 1 and another
           one specified by option 2).
+      -
+        name: phase-offset-monitor
+        type: u32
+        enum: feature-state
+        doc: Receive or request state of phase offset monitor feature.
+          If enabled, dpll device shall monitor and notify all currently
+          available inputs for changes of their phase offset against the
+          dpll device.
   -
     name: pin
     enum-name: dpll_a_pin
@@ -483,6 +505,7 @@ operations:
             - temp
             - clock-id
             - type
+            - phase-offset-monitor
 
       dump:
         reply: *dev-attrs
@@ -499,6 +522,7 @@ operations:
         request:
           attributes:
             - id
+            - phase-offset-monitor
     -
       name: device-create-ntf
       doc: Notification about device appearing
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index fe9b6893d261..8de90310c3be 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -37,8 +37,9 @@ static const struct nla_policy dpll_device_get_nl_policy[DPLL_A_ID + 1] = {
 };
 
 /* DPLL_CMD_DEVICE_SET - do */
-static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_ID + 1] = {
+static const struct nla_policy dpll_device_set_nl_policy[DPLL_A_PHASE_OFFSET_MONITOR + 1] = {
 	[DPLL_A_ID] = { .type = NLA_U32, },
+	[DPLL_A_PHASE_OFFSET_MONITOR] = NLA_POLICY_MAX(NLA_U32, 1),
 };
 
 /* DPLL_CMD_PIN_ID_GET - do */
@@ -105,7 +106,7 @@ static const struct genl_split_ops dpll_nl_ops[] = {
 		.doit		= dpll_nl_device_set_doit,
 		.post_doit	= dpll_post_doit,
 		.policy		= dpll_device_set_nl_policy,
-		.maxattr	= DPLL_A_ID,
+		.maxattr	= DPLL_A_PHASE_OFFSET_MONITOR,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index bf97d4b6d51f..349e1b3ca1ae 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -192,6 +192,17 @@ enum dpll_pin_capabilities {
 
 #define DPLL_PHASE_OFFSET_DIVIDER	1000
 
+/**
+ * enum dpll_feature_state - Allow control (enable/disable) and status checking
+ *   over features.
+ * @DPLL_FEATURE_STATE_DISABLE: feature shall be disabled
+ * @DPLL_FEATURE_STATE_ENABLE: feature shall be enabled
+ */
+enum dpll_feature_state {
+	DPLL_FEATURE_STATE_DISABLE,
+	DPLL_FEATURE_STATE_ENABLE,
+};
+
 enum dpll_a {
 	DPLL_A_ID = 1,
 	DPLL_A_MODULE_NAME,
@@ -204,6 +215,7 @@ enum dpll_a {
 	DPLL_A_TYPE,
 	DPLL_A_LOCK_STATUS_ERROR,
 	DPLL_A_CLOCK_QUALITY_LEVEL,
+	DPLL_A_PHASE_OFFSET_MONITOR,
 
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
-- 
2.38.1


