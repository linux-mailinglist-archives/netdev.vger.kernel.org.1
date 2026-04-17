Return-Path: <netdev+bounces-279429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INOFNquk4mk58gAAu9opvQ
	(envelope-from <netdev+bounces-279429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4546741EADE
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9818C309E804
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643CD368958;
	Fri, 17 Apr 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W3OrecfM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70B1514F8
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460913; cv=none; b=D7xq18afC5qYN261qAu8u1BCLvHZugJQ+eseLGI8fEuc8lDM6D3cRyLCpCkhc1lx1UhgRhHp/8pUQpbyd4ZDFZspsYuKTvO+msX4cXiaTIKA2B2Ns8gWNePMlQXNtOR+sjrJmhcZ61tDBwHwNPTI6bsUfloxYj/ww0GeEiIHKv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460913; c=relaxed/simple;
	bh=hOCkyHHebSupI8y/wtjJSjJ7UEfCPb8wrB7QzPBbVCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ioNC4qqRf9wFTFMDf0VwgQTbQ92fpswHYBlEjVQsE0NpGqdHWRvwk0VFn4Ih/ooPJYYPWCLxC6VXaWyFWUGbdVPKeqlANAcQbvBmeNG2GVx85mpkxnySn7yBG7O+g/e30aWST+sxRpjiUbR3zAJTRdUrWLwWp/zziAJ8Dorn/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W3OrecfM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776460912; x=1807996912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hOCkyHHebSupI8y/wtjJSjJ7UEfCPb8wrB7QzPBbVCg=;
  b=W3OrecfM2Iej3SYWSgb3Q11ReCXrOWg/xvBGFIW9dnfLKuGJDR7or1Wk
   +h24m80T4SH1CvH04Qmjedi9fY30JN3cjGqZLdxFMWNf54gRSHCVyNy2K
   H5F/J4Zu02Au4QnrWpe2KoDtmqjueuBQM7pE7aICUiM3c6/YeSMLd4aQj
   9N90eiO/54SgutyxrQQEqwFz/avsGtPxkzw/cJWhxJTDKuHFEz9mdPPht
   ia7tY2VAry24WRDip2ts3d+yiiZPEEmn7F+WmmF8wkdro2VSbcn0d03Sa
   tQA9unyjROBOIUUMVwJRVrmvGiLar0boUVLRpCUW4IVLcddz3jyDws4ek
   A==;
X-CSE-ConnectionGUID: yey3AFS9TQaYWIpuaxntjQ==
X-CSE-MsgGUID: W8EdPnruTB2gMOSDQWrGlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046185"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="95046185"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 14:21:51 -0700
X-CSE-ConnectionGUID: fU1v+olLSTSQeOTvyLr0Pg==
X-CSE-MsgGUID: XKNbI2zSTY24BO7pLROmxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="235503875"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:21:46 -0700
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
Subject: [PATCH v1 08/11] drm/xe/ras: Get error threshold support
Date: Sat, 18 Apr 2026 02:46:43 +0530
Message-ID: <20260417211730.837345-9-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279429-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,header.data:url]
X-Rspamd-Queue-Id: 4546741EADE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

System controller allows programming per error threshold value, which
it uses to raise error events to the driver. Get it using mailbox
command so that it can be exposed to the user.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c                   | 73 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  3 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 22 ++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
 4 files changed, 100 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 08e91348c459..3e93f838aa4a 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,11 +3,14 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include "xe_pm.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_ras_types.h"
 #include "xe_sysctrl.h"
 #include "xe_sysctrl_event_types.h"
+#include "xe_sysctrl_mailbox.h"
+#include "xe_sysctrl_mailbox_types.h"
 
 /* Severity of detected errors  */
 enum xe_ras_severity {
@@ -49,6 +52,23 @@ static const char *const xe_ras_components[] = {
 };
 static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMP_MAX);
 
+/* uAPI mapping */
+static const int drm_to_xe_ras_components[] = {
+	[DRM_XE_RAS_ERR_COMP_CORE_COMPUTE]	= XE_RAS_COMP_CORE_COMPUTE,
+	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL]	= XE_RAS_COMP_SOC_INTERNAL,
+	[DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY]	= XE_RAS_COMP_DEVICE_MEMORY,
+	[DRM_XE_RAS_ERR_COMP_PCIE]		= XE_RAS_COMP_PCIE,
+	[DRM_XE_RAS_ERR_COMP_FABRIC]		= XE_RAS_COMP_FABRIC
+};
+static_assert(ARRAY_SIZE(drm_to_xe_ras_components) == DRM_XE_RAS_ERR_COMP_MAX);
+
+/* uAPI mapping */
+static const int drm_to_xe_ras_severities[] = {
+	[DRM_XE_RAS_ERR_SEV_CORRECTABLE]	= XE_RAS_SEV_CORRECTABLE,
+	[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE]	= XE_RAS_SEV_UNCORRECTABLE
+};
+static_assert(ARRAY_SIZE(drm_to_xe_ras_severities) == DRM_XE_RAS_ERR_SEV_MAX);
+
 static inline const char *sev_to_str(u8 sev)
 {
 	if (sev >= XE_RAS_SEV_MAX)
@@ -90,3 +110,56 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 			comp_to_str(component), sev_to_str(severity));
 	}
 }
+
+static void ras_command_prepare(struct xe_sysctrl_mailbox_command *command,
+				void *request, size_t request_len, void *response,
+				size_t response_len, u8 hdr_cmd)
+{
+	struct xe_sysctrl_app_msg_hdr header = {};
+
+	header.data = REG_FIELD_PREP(APP_HDR_GROUP_ID_MASK, XE_SYSCTRL_GROUP_GFSP) |
+		      REG_FIELD_PREP(APP_HDR_COMMAND_MASK, hdr_cmd);
+
+	command->header = header;
+	command->data_in = request;
+	command->data_in_len = request_len;
+	command->data_out = response;
+	command->data_out_len = response_len;
+}
+
+int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold)
+{
+	struct xe_ras_get_threshold_response response = {};
+	struct xe_ras_get_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class counter = {};
+	size_t len;
+	int ret;
+
+	counter.common.severity = drm_to_xe_ras_severities[severity];
+	counter.common.component = drm_to_xe_ras_components[component];
+	request.counter = counter;
+
+	ras_command_prepare(&command, &request, sizeof(request), &response,
+			    sizeof(response), XE_SYSCTRL_CMD_GET_THRESHOLD);
+
+	guard(xe_pm_runtime)(xe);
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to get threshold %d\n", ret);
+		return ret;
+	}
+
+	if (len != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected get threshold response length %zu (expected %zu)\n",
+		       len, sizeof(response));
+		return -EIO;
+	}
+
+	counter = response.counter;
+	*threshold = response.threshold;
+
+	xe_dbg(xe, "[RAS]: Get threshold %u for %s %s\n", response.threshold,
+	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index ea90593b62dc..982bbe61461e 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -6,10 +6,13 @@
 #ifndef _XE_RAS_H_
 #define _XE_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 struct xe_sysctrl_event_response;
 
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
+int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index 4e63c67f806a..d5da93d65cf5 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -70,4 +70,26 @@ struct xe_ras_threshold_crossed {
 	struct xe_ras_error_class counters[XE_RAS_NUM_COUNTERS];
 } __packed;
 
+/**
+ * struct xe_ras_get_threshold_request - Request structure for get threshold
+ */
+struct xe_ras_get_threshold_request {
+	/** @counter: Counter to get threshold for */
+	struct xe_ras_error_class counter;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_get_threshold_response - Response structure for get threshold
+ */
+struct xe_ras_get_threshold_response {
+	/** @counter: Counter id */
+	struct xe_ras_error_class counter;
+	/** @threshold: Threshold value */
+	u32 threshold;
+	/** @reserved: Reserved for future use */
+	u32 reserved[4];
+} __packed;
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 84d7c647e743..a1b71218deca 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -22,9 +22,11 @@ enum xe_sysctrl_group {
 /**
  * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
  *
+ * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
  */
 enum xe_sysctrl_gfsp_cmd {
+	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
 };
 
-- 
2.43.0


