Return-Path: <netdev+bounces-288996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IHHBTTzCmpZ+QQAu9opvQ
	(envelope-from <netdev+bounces-288996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:08:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EACD56B424
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 13:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CC9D31FDAF5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98E2283FC8;
	Mon, 18 May 2026 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUTnaae/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B434B183
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779101287; cv=none; b=B9pBE/fa1bxltXuP1kE91sEqq51zSNAv5IRYKObyKy8I1TEO2A55QDtCizIIQDI/1ETRrdTbwlyLE8kcbxgMUagzW/M5skEJDwgOXCf41BDnLGot16c4j8FPY0ky0HfH9+cDFN6uuOOZGWYxPKxn9vY4mV0t5D0ojkeB4pYJlWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779101287; c=relaxed/simple;
	bh=Qqp/uUc8AMvfjWJmMdf+Dw67ntEZ8oxGXZYlwxpMdW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXM/udSnUv3rWycbinaDVbnHMOxhumNgiiEe+OOC3rjexzZTQ+pRoTEQMeHFHNEfFtjNlAzLjOwIOcsuzEbyD80U3yAnl78V8HggWTdZKxXhCbzlmLnlihVNExbHTRF+FzklAm0POv72GGPvATfiElLZzjNIz77mSI+bJysbc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUTnaae/; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779101281; x=1810637281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qqp/uUc8AMvfjWJmMdf+Dw67ntEZ8oxGXZYlwxpMdW8=;
  b=EUTnaae/bxUY9b7cKk8/ly56Jd0FliGYENcIJ6mQ4xz+a8Gryz7pNoJo
   /h2OpSRhAE2wFwYKUTwkWzduWGw7kf92oJUiNL86TYBNYGde9rTgriXm9
   WfrimAYmuuMTiQmhdhoP3DKWST0X6QBFwpEkFKjmA2tZLA1nBFynd6eK2
   JS2SyqM+0NAHdRNQv1JGXKjshdgssn7mtGPD/qMaHay88kBlPqQsgchuq
   MqSys8igH96W4w+Y2HI5YPrf9xRJspKzhFJGEgmWpRN+locbg1FKO+Ub0
   ta9cPXwYqVymG+/QzLm5LgxiqFHyNOKqM7SjOxG74+jK3pp3A3EVxjWY1
   w==;
X-CSE-ConnectionGUID: pJB/vy4USeedCzl0Vv68Tg==
X-CSE-MsgGUID: r+ZAOSMaQGKxglTZQxZq/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79802403"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79802403"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:47:59 -0700
X-CSE-ConnectionGUID: nRKpuH9AS1WuxBU8IjUZ0A==
X-CSE-MsgGUID: hhEWInr/RF+EpPev18YAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="243688595"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 03:47:54 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	kuba@kernel.org,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	maarten.lankhorst@linux.intel.com,
	mallesh.koujalagi@intel.com,
	soham.purkait@intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 2/2] drm/xe/xe_drm_ras: Add error-event support in XE drm_ras
Date: Mon, 18 May 2026 16:50:51 +0530
Message-ID: <20260518112048.1746280-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260518112048.1746280-4-riana.tauro@intel.com>
References: <20260518112048.1746280-4-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7EACD56B424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288996-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add error-event support in XE drm_ras to notify userspace
whenever a GT or SoC error occurs.

$ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --output-json \
--subscribe error-notify

{
    "name": "error-event",
     "msg": {
         "device-name": "0000:03:00.0",
         "node-id": 1,
         "node-name": "uncorrectable-errors",
         "error-id": 1,
         "error-name": "core-compute",
         "error-value": 1
     }
}

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c  | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h  |  6 ++++++
 drivers/gpu/drm/xe/xe_hw_error.c |  7 ++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c21c8b428de6..68d9f561d61d 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -181,6 +181,35 @@ static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
 	}
 }
 
+/**
+ * xe_drm_ras_event() - Notify userspace of an error event
+ * @xe: xe device structure
+ * @error_id: error id
+ * @severity: error severity
+ * @flags: flags for allocation
+ *
+ * Notifies userspace of an error.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u32 error_id,
+		      enum drm_xe_ras_error_severity severity, gfp_t flags)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct drm_ras_node *node = &ras->node[severity];
+	struct xe_drm_ras_counter *info = ras->info[severity];
+	u32 value;
+	int ret;
+
+	if (!info || !info[error_id].name)
+		return;
+
+	value = atomic_read(&info[error_id].counter);
+
+	ret = drm_ras_nl_error_event(node, error_id, info[error_id].name, value, flags);
+	if (ret)
+		drm_err(&xe->drm, "Failed to send RAS error event for error %s: %d\n",
+			info[error_id].name, ret);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..b9b8b541d591 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -5,11 +5,17 @@
 #ifndef _XE_DRM_RAS_H_
 #define _XE_DRM_RAS_H_
 
+#include <linux/types.h>
+
+#include <drm/xe_drm.h>
+
 struct xe_device;
 
 #define for_each_error_severity(i)	\
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+void xe_drm_ras_event(struct xe_device *xe, u32 error_id,
+		      enum drm_xe_ras_error_severity severity, gfp_t flags);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 5135e8e4093f..c0fda18601cd 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -279,7 +279,7 @@ static void gt_hw_error_handler(struct xe_tile *tile, const enum hardware_error
 	if (hw_err == HARDWARE_ERROR_NONFATAL) {
 		atomic_inc(&info[error_id].counter);
 		log_hw_error(tile, info[error_id].name, severity);
-		return;
+		goto notify;
 	}
 
 	for (i = 0; i < PVC_GT_VECTOR_LEN(hw_err); i++) {
@@ -336,6 +336,9 @@ static void gt_hw_error_handler(struct xe_tile *tile, const enum hardware_error
 
 		xe_mmio_write32(mmio, ERR_STAT_GT_VECTOR_REG(hw_err, i), vector);
 	}
+
+notify:
+	xe_drm_ras_event(xe, error_id, severity, GFP_ATOMIC);
 }
 
 static void soc_slave_ieh_handler(struct xe_tile *tile, const enum hardware_error hw_err, u32 error_id)
@@ -418,6 +421,8 @@ static void soc_hw_error_handler(struct xe_tile *tile, const enum hardware_error
 
 	xe_mmio_write32(mmio, SOC_GLOBAL_ERR_STAT_REG(master, hw_err), master_global_errstat);
 
+	xe_drm_ras_event(xe, error_id, severity, GFP_ATOMIC);
+
 unmask_gsysevtctl:
 	for (i = 0; i < XE_SOC_NUM_IEH; i++)
 		xe_mmio_write32(mmio, SOC_GSYSEVTCTL_REG(master, slave, i),
-- 
2.47.1

