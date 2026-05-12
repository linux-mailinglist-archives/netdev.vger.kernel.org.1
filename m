Return-Path: <netdev+bounces-287276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIJ9FX19A2pV6QEAu9opvQ
	(envelope-from <netdev+bounces-287276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:20:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4452881F
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BD003037439
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 19:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15898360EFD;
	Tue, 12 May 2026 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kkc10hM7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBB0317162
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613627; cv=none; b=WQShZfIenH+JWeqQeBoJSNBF/x+FWsMtyC9bit0dyri43HjbqucIPN9n7/Nm3gBCyr7FO3LqLiDrcYcLdAYjuXmC0x6lrjZ8/0EhtwYHxjeA9f2Mwj+zcA7XrbICV7FcBqeV2oChwM/9c7+MQ4QelvMmqK3IV9z/9WA+YRaQrJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613627; c=relaxed/simple;
	bh=dKt54H2rIkdQPk6NmrBQ/14MGjE76a2zw1lBgYqTIcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXKsMgZDf3PA2ds4wIoQ5KooYWamTs8CUQvtC7zQIfF3Rsg5Mo5uve0QZ5g9pDG7/oZkEBb4g7VtC3m0xRsWrdcny13yJSIwbX3JjXHh9YaMjzZeZqyRTetllu82JH2JMPRQFmpULypYyy2W5OsPG7N2qz6oCEP8pelwDgmiUdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kkc10hM7; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778613625; x=1810149625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dKt54H2rIkdQPk6NmrBQ/14MGjE76a2zw1lBgYqTIcE=;
  b=Kkc10hM7fybzUa7dieEa4VwDZftfgqvoFuFhK5QmhKf9POkmXcNohnVG
   jV1DPlf0NsWFNy1j8GUUGLSL1NLOzDEhKOMpUkZ8EBoQgV9kBUpQ9SQiC
   EZzzH0NgRJA6L4PFwx1wfxuTZJ1Q6cuyiBDBJJx11M/1ROq3qYlzbJlAG
   SLIuD3MsKsLfymm9STcHCtDkdOWCwCFPb0uAWA7O3Y3ikeUUXVMcDqCmn
   Aeh0EE1fKJXoM1a4Ua4j7P8N9CYy13rXBEnaWlCSA33NqNV5egHXazh19
   5AufQSXk+3mc2bw2/xKu9Ab9ORLsPUE+bsMX7zJUt90Ahu+2+6XW60O6D
   w==;
X-CSE-ConnectionGUID: LJf3kt/ISiCK8BOSETOuyw==
X-CSE-MsgGUID: TbZFaNNzRM6EH3+9LlHy7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406449"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="83406449"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 12:20:24 -0700
X-CSE-ConnectionGUID: dgOw/JsfQzy8Fu71anPbdw==
X-CSE-MsgGUID: 1JYQfoXRQ7+ZKEYAdr3hzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="237781553"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:20:17 -0700
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
Subject: [PATCH v2 6/9] drm/xe/ras: Set error threshold support
Date: Wed, 13 May 2026 00:46:07 +0530
Message-ID: <20260512191610.1817578-7-raag.jadav@intel.com>
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
X-Rspamd-Queue-Id: C8E4452881F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287276-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

System controller allows programming per error threshold value, which
it uses to raise error events to the driver. Set it using mailbox
command so that it can be programmed by the user.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Add RAS operation status codes (Riana)
---
 drivers/gpu/drm/xe/xe_ras.c                   | 72 +++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |  1 +
 drivers/gpu/drm/xe/xe_ras_types.h             | 28 ++++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |  2 +
 4 files changed, 103 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 434dea8bbdb1..4548e5cb08b9 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -34,6 +34,17 @@ enum xe_ras_component {
 	XE_RAS_COMP_MAX
 };
 
+/* RAS operation status codes */
+enum xe_ras_status {
+	XE_RAS_STATUS_SUCCESS = 0,
+	XE_RAS_STATUS_INVALID_PARAM,
+	XE_RAS_STATUS_NOT_SUPPORTED,
+	XE_RAS_STATUS_TIMEOUT,
+	XE_RAS_STATUS_HARDWARE_FAILURE,
+	XE_RAS_STATUS_INSUFFICIENT_RESOURCES,
+	XE_RAS_STATUS_MAX
+};
+
 static const char *const xe_ras_severities[] = {
 	[XE_RAS_SEV_NOT_SUPPORTED]		= "Not Supported",
 	[XE_RAS_SEV_CORRECTABLE]		= "Correctable Error",
@@ -70,6 +81,24 @@ static const int drm_to_xe_ras_severities[] = {
 };
 static_assert(ARRAY_SIZE(drm_to_xe_ras_severities) == DRM_XE_RAS_ERR_SEV_MAX);
 
+static int ras_status_to_errno(u32 status)
+{
+	switch (status) {
+	case XE_RAS_STATUS_INVALID_PARAM:
+		return -EINVAL;
+	case XE_RAS_STATUS_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	case XE_RAS_STATUS_TIMEOUT:
+		return -ETIMEDOUT;
+	case XE_RAS_STATUS_HARDWARE_FAILURE:
+		return -EIO;
+	case XE_RAS_STATUS_INSUFFICIENT_RESOURCES:
+		return -ENOSPC;
+	default:
+		return -EPROTO;
+	}
+};
+
 static inline const char *sev_to_str(u8 severity)
 {
 	if (severity >= XE_RAS_SEV_MAX)
@@ -149,3 +178,46 @@ int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32
 	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
 	return 0;
 }
+
+int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold)
+{
+	struct xe_ras_set_threshold_response response = {};
+	struct xe_ras_set_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class counter = {};
+	size_t len;
+	int ret;
+
+	counter.common.severity = drm_to_xe_ras_severities[severity];
+	counter.common.component = drm_to_xe_ras_components[component];
+	request.counter = counter;
+	request.threshold = threshold;
+
+	xe_sysctrl_populate_command(&command, &request, &response, sizeof(request),
+				    sizeof(response), XE_SYSCTRL_GROUP_GFSP,
+				    XE_SYSCTRL_CMD_SET_THRESHOLD);
+
+	guard(xe_pm_runtime)(xe);
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &len);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to set threshold %d\n", ret);
+		return ret;
+	}
+
+	if (len != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected set threshold response length %zu (expected %zu)\n",
+		       len, sizeof(response));
+		return -EIO;
+	}
+
+	if (response.status) {
+		xe_err(xe, "sysctrl: set threshold operation failed %#x\n", response.status);
+		return ras_status_to_errno(response.status);
+	}
+
+	counter = response.counter;
+
+	xe_dbg(xe, "[RAS]: set threshold %u for %s %s\n", response.threshold,
+	       comp_to_str(counter.common.component), sev_to_str(counter.common.severity));
+	return 0;
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index 982bbe61461e..d1f71b1de723 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -14,5 +14,6 @@ struct xe_sysctrl_event_response;
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
 int xe_ras_get_threshold(struct xe_device *xe, u32 severity, u32 component, u32 *threshold);
+int xe_ras_set_threshold(struct xe_device *xe, u32 severity, u32 component, u32 threshold);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index c29e9a3d43ce..6047fd891022 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -92,4 +92,32 @@ struct xe_ras_get_threshold_response {
 	u32 reserved[4];
 } __packed;
 
+/**
+ * struct xe_ras_set_threshold_request - Request structure for set threshold
+ */
+struct xe_ras_set_threshold_request {
+	/** @counter: Counter to set threshold for */
+	struct xe_ras_error_class counter;
+	/** @threshold: Threshold value to set */
+	u32 threshold;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_set_threshold_response - Response structure for set threshold
+ */
+struct xe_ras_set_threshold_response {
+	/** @counter: Counter ID */
+	struct xe_ras_error_class counter;
+	/** @threshold_prev: Previous threshold value */
+	u32 threshold_prev;
+	/** @threshold: Updated threshold value */
+	u32 threshold;
+	/** @status: Set threshold operation status */
+	u32 status;
+	/** @reserved: Reserved for future use */
+	u32 reserved[2];
+} __packed;
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index a1b71218deca..b865768e903b 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -23,10 +23,12 @@ enum xe_sysctrl_group {
  * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
  *
  * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
+ * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
  */
 enum xe_sysctrl_gfsp_cmd {
 	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
+	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
 };
 
-- 
2.43.0


