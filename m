Return-Path: <netdev+bounces-295393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rIXOAYrLIWo/NwEAu9opvQ
	(envelope-from <netdev+bounces-295393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:01:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AB642C5E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:01:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=LumFtbBA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295393-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295393-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69EB930380D1
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797CD36A013;
	Thu,  4 Jun 2026 18:53:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D99367B90
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 18:53:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599192; cv=none; b=hGS4MwwudsvRKCkZJNaJNtDUD26OwbePR0rB/HWC49wlc/S23dMxr+JvDwE2YAZcC8wcQL9Fn9h6npxcG1P8uexM+oBLly9YC/+14blIMuNowY/+dNPO+DTAdAhgqLyg0Read2Vi1qzr7t1qdVhzPpvzqLw71H9SEe23eVwiWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599192; c=relaxed/simple;
	bh=LGYL+UiYYpaOrkqKI/qlDUPS1Ic3IHgQBBGMP+lxkEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKQEZwiFl3Y+dckfyK/qr4e3gGXfft2GPYVfExfcYjFrTCs0qM8buKgvWH8lvuL79AsWaNWNIDB2RWXr/+6WBoSV4s48oV/UV6VRebYMJpsKj83HfT+C+qxCXaZixG7aTR9JpUdPmn1LM1uR03MPBHzLHb7kVJrXmY0kFfssMVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LumFtbBA; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780599191; x=1812135191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LGYL+UiYYpaOrkqKI/qlDUPS1Ic3IHgQBBGMP+lxkEY=;
  b=LumFtbBA/7ucy/1N0UKbiLggA4GFO2tcBiMckZnVg0gMCMDGEZ1+/YB/
   PqRsnBqLhpqTcZQz5Utdh9UNWO8HlkFjOyxsipsRNWPkumKW03yLso4Rx
   NMFqevRQoqSBrt1CC5sCvhsbCXinwB2ut1NvJKbK/dQvRhZhwNrafuNtm
   9hDiyBiJd0bvyWBqQt5nM08sQdyc2xmdK1mlNnsd3u3tCqSC+BqwkxQsU
   nLzSW6V+hUEfRnDj9aIav5ICJStVUFcZYDa1gxGwjf/XK9LYNVl0NccIN
   ELmCsc9Z6DEA0IIuXRZdtdkuH5QnhvNEUTIHbmvA095DeMGv95UsE7dIL
   A==;
X-CSE-ConnectionGUID: Id1OV3p+S/mu6AQj6Ax/DQ==
X-CSE-MsgGUID: WGbffeG+TJWtKUT1bK8FNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81467844"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81467844"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:53:11 -0700
X-CSE-ConnectionGUID: kOyZSeJCSeKeYcuiJLfHTA==
X-CSE-MsgGUID: gpZJFiaxSiiEsWsvIy5pOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="240162109"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2026 11:53:06 -0700
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
Subject: [PATCH v3 3/4] drm/xe/ras: Add support for error threshold
Date: Fri,  5 Jun 2026 00:16:42 +0530
Message-ID: <20260604184849.1011985-4-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604184849.1011985-1-raag.jadav@intel.com>
References: <20260604184849.1011985-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	TAGGED_FROM(0.00)[bounces-295393-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:kuba@kernel.org,m:lijo.lazar@amd.com,m:Hawking.Zhang@amd.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:dev@lankhorst.se,m:zachary.mckevitt@oss.qualcomm.com,m:rodrigo.vivi@intel.com,m:riana.tauro@intel.com,m:michal.wajdeczko@intel.com,m:matthew.d.roper@intel.com,m:mallesh.koujalagi@intel.com,m:raag.jadav@intel.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 075AB642C5E

System controller allows getting/setting per counter threshold, which it
uses to raise error events to the driver. Get/set it using the respective
mailbox command.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Add RAS operation status codes (Riana)
v3: Reuse status codes and uapi mapping from counter series (Riana)
    Access request/response counter using local pointer (Riana)
    Mark unused field as reserved (Riana)
---
 drivers/gpu/drm/xe/xe_ras.c                   | 105 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  51 +++++++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 4 files changed, 162 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 7cb6fcb1254a..d6f89b429cec 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -270,6 +270,111 @@ int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component)
 	return 0;
 }
 
+/**
+ * xe_ras_get_threshold() - Get error counter threshold
+ * @xe: Xe device instance
+ * @severity: Error severity to be queried (&enum drm_xe_ras_error_severity)
+ * @component: Error component to be queried (&enum drm_xe_ras_error_component)
+ * @threshold: Counter threshold
+ *
+ * This function retrieves the error threshold of a specific counter based on
+ * severity and component.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold)
+{
+	struct xe_ras_get_threshold_response response = {};
+	struct xe_ras_get_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class *counter;
+	size_t len;
+	int ret;
+
+	counter = &request.counter;
+	counter->common.severity = drm_to_xe_ras_severity(severity);
+	counter->common.component = drm_to_xe_ras_component(component);
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_THRESHOLD,
+				  &request, sizeof(request), &response, sizeof(response));
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
+	counter = &response.counter;
+	*threshold = response.threshold;
+
+	xe_dbg(xe, "[RAS]: get counter threshold %u for %s %s\n", *threshold,
+	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
+	return 0;
+}
+
+/**
+ * xe_ras_set_threshold() - Set error counter threshold
+ * @xe: Xe device instance
+ * @severity: Error severity to be set (&enum drm_xe_ras_error_severity)
+ * @component: Error component to be set (&enum drm_xe_ras_error_component)
+ * @threshold: Counter threshold
+ *
+ * This function sets the error threshold of a specific counter based on
+ * severity and component.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold)
+{
+	struct xe_ras_set_threshold_response response = {};
+	struct xe_ras_set_threshold_request request = {};
+	struct xe_sysctrl_mailbox_command command = {};
+	struct xe_ras_error_class *counter;
+	size_t len;
+	int ret;
+
+	counter = &request.counter;
+	counter->common.severity = drm_to_xe_ras_severity(severity);
+	counter->common.component = drm_to_xe_ras_component(component);
+	request.threshold = threshold;
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_SET_THRESHOLD,
+				  &request, sizeof(request), &response, sizeof(response));
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
+	ret = ras_status_to_errno(response.status);
+	if (ret) {
+		xe_err(xe, "sysctrl: set threshold command failed with status %#x\n",
+		       response.status);
+		return ret;
+	}
+
+	counter = &response.counter;
+
+	xe_dbg(xe, "[RAS]: set counter threshold %u for %s %s\n", response.threshold,
+	       comp_to_str(counter->common.component), sev_to_str(counter->common.severity));
+	return 0;
+}
+
 /**
  * xe_ras_init - Initialize Xe RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index ba0b0224df23..1aa43c54b710 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -15,6 +15,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
 int xe_ras_get_counter(struct xe_device *xe, u8 severity, u8 component, u32 *value);
 int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component);
+int xe_ras_get_threshold(struct xe_device *xe, u8 severity, u8 component, u32 *threshold);
+int xe_ras_set_threshold(struct xe_device *xe, u8 severity, u8 component, u32 threshold);
 void xe_ras_init(struct xe_device *xe);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index c6392435d1c6..8ea817583eed 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -121,4 +121,55 @@ struct xe_ras_clear_counter_response {
 	/** @reserved1: Reserved for future use */
 	u32 reserved1[3];
 } __packed;
+
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
+	/** @counter: Counter ID */
+	struct xe_ras_error_class counter;
+	/** @threshold: Threshold value */
+	u32 threshold;
+	/** @reserved: Reserved for future use */
+	u32 reserved[4];
+} __packed;
+
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
+	/** @reserved: Reserved */
+	u32 reserved;
+	/** @threshold: Updated threshold value */
+	u32 threshold;
+	/** @status: Set threshold operation status */
+	u32 status;
+	/** @reserved1: Reserved for future use */
+	u32 reserved1[2];
+} __packed;
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 6e3753554510..10f06aa5c4b5 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -24,11 +24,15 @@ enum xe_sysctrl_group {
  *
  * @XE_SYSCTRL_CMD_GET_COUNTER: Get error counter value
  * @XE_SYSCTRL_CMD_CLEAR_COUNTER: Clear error counter value
+ * @XE_SYSCTRL_CMD_GET_THRESHOLD: Retrieve error threshold
+ * @XE_SYSCTRL_CMD_SET_THRESHOLD: Set error threshold
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
  */
 enum xe_sysctrl_gfsp_cmd {
 	XE_SYSCTRL_CMD_GET_COUNTER		= 0x03,
 	XE_SYSCTRL_CMD_CLEAR_COUNTER		= 0x04,
+	XE_SYSCTRL_CMD_GET_THRESHOLD		= 0x05,
+	XE_SYSCTRL_CMD_SET_THRESHOLD		= 0x06,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
 };
 
-- 
2.43.0


