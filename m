Return-Path: <netdev+bounces-295392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xYTbHT/LIWocNwEAu9opvQ
	(envelope-from <netdev+bounces-295392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:00:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D32B6642C52
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:00:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=TrVG9e7f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295392-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73CDD3090D9A
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E239B482;
	Thu,  4 Jun 2026 18:53:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F46036A013
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 18:53:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599188; cv=none; b=DUDj6HwaOTiZAfwa9veqK7rKAuCVNwCLKW0/M4RMrtYj7eKAm16iPscwlDmEWUdZG0SLXtZNDqFSCw51sLD49MUQpwraaeeREpLNWgFogHDAE4RDsBQJ8quQK2rDB8s6E/YRBAApXCJF1P5y3G5EVvU6Jc24kDH77jcFQRx8a5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599188; c=relaxed/simple;
	bh=T2Mp4hF4Yw6J2gNirIQWDyYAHVRlVgJaBVx9WcIaMFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IPd5yWlZ61pUQ23XyHHsejSphrvFw0lN2a4lEXAcL4twk+a0hd5knlHApjSANEvO/APZFAo49znEMcwhlydcIvnDJhmO0yaTQXQF8e4j5WSm0W1x0dCUGg6DQfRPOkKLnS70Udgc/u4n6s3HaSTphRCII2VpZbVcUUM2W5jQbMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrVG9e7f; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780599186; x=1812135186;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T2Mp4hF4Yw6J2gNirIQWDyYAHVRlVgJaBVx9WcIaMFk=;
  b=TrVG9e7f43pL2NrRAsnOHubreoqWQcckipXGfofukKAk5vAGfkEB4uJ8
   oLyO2bPKPdeijPxlpZhNPjg4yD+GAxNULmmfbgofPoCwjibQnWxN/zVgJ
   bDPHC43rzhIwf3MYOn4p4E8Aa1VyiE7MsWpBMwpz/b2pjvy8+499EbSnz
   ghSEhy7NsF0u/0FyNzuqJMjqfKXXK6U0zUINctabBFgUfWXIP7E2ld6Zb
   7JmXQsXPyZ46Q+Yik+xxtZPkENg3r6ZvuLneIUNtEWOnitro9UoeJvN1R
   pFnr9jwC00p2WS8GV7om4Op5y6RS1rnW8LvNTSkjAif0bQ0CZ6zElACit
   g==;
X-CSE-ConnectionGUID: PpLIfbgPQb2xCmNfLtVmmA==
X-CSE-MsgGUID: Ea2I/ZEpRrmGERavLMlkVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81467824"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="81467824"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 11:53:06 -0700
X-CSE-ConnectionGUID: oaLe3KlmRO2suJKdOHhNiw==
X-CSE-MsgGUID: z+5+k8f3SVm+bR7brTsm9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="240162101"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa006.fm.intel.com with ESMTP; 04 Jun 2026 11:53:01 -0700
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
Subject: [PATCH v3 2/4] drm/xe/xe_ras: Add support for error counter
Date: Fri,  5 Jun 2026 00:16:41 +0530
Message-ID: <20260604184849.1011985-3-raag.jadav@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com];
	TAGGED_FROM(0.00)[bounces-295392-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,intel.com:mid,intel.com:dkim,intel.com:from_mime,intel.com:email,header.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D32B6642C52

From: Riana Tauro <riana.tauro@intel.com>

Do not review, CI only.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c                |  20 +-
 drivers/gpu/drm/xe/xe_device_types.h          |   2 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  41 ++--
 drivers/gpu/drm/xe/xe_hw_error.c              |  13 --
 drivers/gpu/drm/xe/xe_pci.c                   |   3 +
 drivers/gpu/drm/xe/xe_pci_types.h             |   1 +
 drivers/gpu/drm/xe/xe_ras.c                   | 192 ++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   5 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  51 +++++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c       |  28 +++
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h       |   3 +
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 include/uapi/drm/xe_drm.h                     |  11 +-
 13 files changed, 337 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index cea935c3ba67..879023133e46 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -62,6 +62,7 @@
 #include "xe_psmi.h"
 #include "xe_pxp.h"
 #include "xe_query.h"
+#include "xe_ras.h"
 #include "xe_shrinker.h"
 #include "xe_soc_remapper.h"
 #include "xe_survivability_mode.h"
@@ -742,6 +743,7 @@ static void vf_update_device_info(struct xe_device *xe)
 	xe->info.has_late_bind = 0;
 	xe->info.skip_guc_pc = 1;
 	xe->info.skip_pcode = 1;
+	xe->info.has_drm_ras = false;
 }
 
 static int xe_device_vram_alloc(struct xe_device *xe)
@@ -990,6 +992,16 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		return err;
 
+	err = xe_soc_remapper_init(xe);
+	if (err)
+		return err;
+
+	err = xe_sysctrl_init(xe);
+	if (err)
+		return err;
+
+	xe_ras_init(xe);
+
 	/*
 	 * Now that GT is initialized (TTM in particular),
 	 * we can try to init display, and inherit the initial fb.
@@ -1030,10 +1042,6 @@ int xe_device_probe(struct xe_device *xe)
 
 	xe_nvm_init(xe);
 
-	err = xe_soc_remapper_init(xe);
-	if (err)
-		return err;
-
 	err = xe_heci_gsc_init(xe);
 	if (err)
 		return err;
@@ -1072,10 +1080,6 @@ int xe_device_probe(struct xe_device *xe)
 	if (err)
 		goto err_unregister_display;
 
-	err = xe_sysctrl_init(xe);
-	if (err)
-		goto err_unregister_display;
-
 	err = xe_device_sysfs_init(xe);
 	if (err)
 		goto err_unregister_display;
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 4e7f79c1d9f7..fae72310f060 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -156,6 +156,8 @@ struct xe_device {
 		u8 has_cached_pt:1;
 		/** @info.has_device_atomics_on_smem: Supports device atomics on SMEM */
 		u8 has_device_atomics_on_smem:1;
+		/** @info.has_drm_ras: Device supports drm_ras (Reliability, Availability, Serviceability) */
+		u8 has_drm_ras:1;
 		/** @info.has_fan_control: Device supports fan control */
 		u8 has_fan_control:1;
 		/** @info.has_flat_ccs: Whether flat CCS metadata is used */
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index cd236f53699e..7937d8ba0ed9 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -11,27 +11,46 @@
 
 #include "xe_device_types.h"
 #include "xe_drm_ras.h"
+#include "xe_ras.h"
 
 static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
 static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
 
-static int hw_query_error_counter(struct xe_drm_ras_counter *info,
-				  u32 error_id, const char **name, u32 *val)
+static int query_error_counter(struct xe_device *xe,
+			       enum drm_xe_ras_error_severity severity,
+			       u32 error_id, const char **name, u32 *val)
 {
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[severity];
+
 	if (!info || !info[error_id].name)
 		return -ENOENT;
 
 	*name = info[error_id].name;
+
+	/* Fetch counter from system controller if supported */
+	if (xe->info.has_sysctrl)
+		return xe_ras_get_counter(xe, severity, error_id, val);
+
 	*val = atomic_read(&info[error_id].counter);
 
 	return 0;
 }
 
-static int hw_clear_error_counter(struct xe_drm_ras_counter *info, u32 error_id)
+static int clear_error_counter(struct xe_device *xe,
+			       enum drm_xe_ras_error_severity severity,
+			       u32 error_id)
 {
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[severity];
+
 	if (!info || !info[error_id].name)
 		return -ENOENT;
 
+	/* Clear counter from system controller if supported */
+	if (xe->info.has_sysctrl)
+		return xe_ras_clear_counter(xe, severity, error_id);
+
 	atomic_set(&info[error_id].counter, 0);
 
 	return 0;
@@ -41,38 +60,30 @@ static int query_uncorrectable_error_counter(struct drm_ras_node *ep, u32 error_
 					     const char **name, u32 *val)
 {
 	struct xe_device *xe = ep->priv;
-	struct xe_drm_ras *ras = &xe->ras;
-	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE];
 
-	return hw_query_error_counter(info, error_id, name, val);
+	return query_error_counter(xe, DRM_XE_RAS_ERR_SEV_UNCORRECTABLE, error_id, name, val);
 }
 
 static int clear_uncorrectable_error_counter(struct drm_ras_node *node, u32 error_id)
 {
 	struct xe_device *xe = node->priv;
-	struct xe_drm_ras *ras = &xe->ras;
-	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE];
 
-	return hw_clear_error_counter(info, error_id);
+	return clear_error_counter(xe, DRM_XE_RAS_ERR_SEV_UNCORRECTABLE, error_id);
 }
 
 static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id,
 					   const char **name, u32 *val)
 {
 	struct xe_device *xe = ep->priv;
-	struct xe_drm_ras *ras = &xe->ras;
-	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
 
-	return hw_query_error_counter(info, error_id, name, val);
+	return query_error_counter(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, name, val);
 }
 
 static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_id)
 {
 	struct xe_device *xe = node->priv;
-	struct xe_drm_ras *ras = &xe->ras;
-	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
 
-	return hw_clear_error_counter(info, error_id);
+	return clear_error_counter(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id);
 }
 
 static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 4b72959b2276..3c1dc9f83d1a 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -516,14 +516,6 @@ void xe_hw_error_irq_handler(struct xe_tile *tile, const u32 master_ctl)
 	}
 }
 
-static int hw_error_info_init(struct xe_device *xe)
-{
-	if (xe->info.platform != XE_PVC)
-		return 0;
-
-	return xe_drm_ras_init(xe);
-}
-
 /*
  * Process hardware errors during boot
  */
@@ -550,16 +542,11 @@ static void process_hw_errors(struct xe_device *xe)
 void xe_hw_error_init(struct xe_device *xe)
 {
 	struct xe_tile *tile = xe_device_get_root_tile(xe);
-	int ret;
 
 	if (!IS_DGFX(xe) || IS_SRIOV_VF(xe))
 		return;
 
 	INIT_WORK(&tile->csc_hw_error_work, csc_hw_error_work);
 
-	ret = hw_error_info_init(xe);
-	if (ret)
-		drm_err(&xe->drm, "Failed to initialize XE DRM RAS (%pe)\n", ERR_PTR(ret));
-
 	process_hw_errors(xe);
 }
diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
index 205ba01e713c..33bd9b9a6451 100644
--- a/drivers/gpu/drm/xe/xe_pci.c
+++ b/drivers/gpu/drm/xe/xe_pci.c
@@ -355,6 +355,7 @@ static const __maybe_unused struct xe_device_desc pvc_desc = {
 	PLATFORM(PVC),
 	.dma_mask_size = 52,
 	.has_display = false,
+	.has_drm_ras = true,
 	.has_gsc_nvm = 1,
 	.has_heci_gscfi = 1,
 	.max_gt_per_tile = 1,
@@ -457,6 +458,7 @@ static const struct xe_device_desc cri_desc = {
 	PLATFORM(CRESCENTISLAND),
 	.dma_mask_size = 52,
 	.has_display = false,
+	.has_drm_ras = true,
 	.has_flat_ccs = false,
 	.has_gsc_nvm = 1,
 	.has_i2c = true,
@@ -760,6 +762,7 @@ static int xe_info_init_early(struct xe_device *xe,
 
 	xe->info.is_dgfx = desc->is_dgfx;
 	xe->info.has_cached_pt = desc->has_cached_pt;
+	xe->info.has_drm_ras = desc->has_drm_ras;
 	xe->info.has_fan_control = desc->has_fan_control;
 	/* runtime fusing may force flat_ccs to disabled later */
 	xe->info.has_flat_ccs = desc->has_flat_ccs;
diff --git a/drivers/gpu/drm/xe/xe_pci_types.h b/drivers/gpu/drm/xe/xe_pci_types.h
index 5b85e2c24b7b..24d4a3d00517 100644
--- a/drivers/gpu/drm/xe/xe_pci_types.h
+++ b/drivers/gpu/drm/xe/xe_pci_types.h
@@ -40,6 +40,7 @@ struct xe_device_desc {
 
 	u8 has_cached_pt:1;
 	u8 has_display:1;
+	u8 has_drm_ras:1;
 	u8 has_fan_control:1;
 	u8 has_flat_ccs:1;
 	u8 has_gsc_nvm:1;
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 4cb16b419b0c..7cb6fcb1254a 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -4,11 +4,15 @@
  */
 
 #include "xe_device.h"
+#include "xe_drm_ras.h"
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
@@ -31,6 +35,17 @@ enum xe_ras_component {
 	XE_RAS_COMP_MAX
 };
 
+/* RAS response status codes */
+enum xe_ras_response_status {
+	XE_RAS_STATUS_SUCCESS = 0,
+	XE_RAS_STATUS_INVALID_PARAM,
+	XE_RAS_STATUS_OP_NOT_SUPPORTED,
+	XE_RAS_STATUS_TIMEOUT,
+	XE_RAS_STATUS_HARDWARE_FAILURE,
+	XE_RAS_STATUS_INSUFFICIENT_RESOURCES,
+	XE_RAS_STATUS_MAX
+};
+
 static const char *const xe_ras_severities[] = {
 	[XE_RAS_SEV_NOT_SUPPORTED]		= "Not Supported",
 	[XE_RAS_SEV_CORRECTABLE]		= "Correctable Error",
@@ -50,6 +65,56 @@ static const char *const xe_ras_components[] = {
 };
 static_assert(ARRAY_SIZE(xe_ras_components) == XE_RAS_COMP_MAX);
 
+static u8 drm_to_xe_ras_severity(u8 severity)
+{
+	switch (severity) {
+	case DRM_XE_RAS_ERR_SEV_CORRECTABLE:
+		return XE_RAS_SEV_CORRECTABLE;
+	case DRM_XE_RAS_ERR_SEV_UNCORRECTABLE:
+		return XE_RAS_SEV_UNCORRECTABLE;
+	default:
+		return XE_RAS_SEV_NOT_SUPPORTED;
+	}
+}
+
+static u8 drm_to_xe_ras_component(u8 component)
+{
+	switch (component) {
+	case DRM_XE_RAS_ERR_COMP_CORE_COMPUTE:
+		return XE_RAS_COMP_CORE_COMPUTE;
+	case DRM_XE_RAS_ERR_COMP_SOC_INTERNAL:
+		return XE_RAS_COMP_SOC_INTERNAL;
+	case DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY:
+		return XE_RAS_COMP_DEVICE_MEMORY;
+	case DRM_XE_RAS_ERR_COMP_PCIE:
+		return XE_RAS_COMP_PCIE;
+	case DRM_XE_RAS_ERR_COMP_FABRIC:
+		return XE_RAS_COMP_FABRIC;
+	default:
+		return XE_RAS_COMP_NOT_SUPPORTED;
+	}
+}
+
+static int ras_status_to_errno(u32 status)
+{
+	switch (status) {
+	case XE_RAS_STATUS_SUCCESS:
+		return 0;
+	case XE_RAS_STATUS_INVALID_PARAM:
+		return -EINVAL;
+	case XE_RAS_STATUS_OP_NOT_SUPPORTED:
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
+}
+
 static inline const char *sev_to_str(u8 severity)
 {
 	if (severity >= XE_RAS_SEV_MAX)
@@ -91,3 +156,130 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 			comp_to_str(component), sev_to_str(severity));
 	}
 }
+
+static int get_counter(struct xe_device *xe, struct xe_ras_error_class *counter, u32 *value)
+{
+	struct xe_ras_get_counter_response response = {0};
+	struct xe_ras_get_counter_request request = {0};
+	struct xe_sysctrl_mailbox_command command = {0};
+	struct xe_ras_error_common *common;
+	size_t rlen;
+	int ret;
+
+	request.counter = *counter;
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_GET_COUNTER,
+				  &request, sizeof(request), &response, sizeof(response));
+
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to get counter %d\n", ret);
+		return ret;
+	}
+
+	if (rlen != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected get counter response length %zu (expected %zu)\n",
+		       rlen, sizeof(response));
+		return -EIO;
+	}
+
+	common = &response.counter.common;
+	*value = response.value;
+
+	xe_dbg(xe, "[RAS]: get counter value %u for %s %s\n", *value,
+	       comp_to_str(common->component), sev_to_str(common->severity));
+
+	return 0;
+}
+
+/**
+ * xe_ras_get_counter() - Get error counter value
+ * @xe: Xe device instance
+ * @severity: Error severity to be queried (&enum drm_xe_ras_error_severity)
+ * @component: Error component to be queried (&enum drm_xe_ras_error_component)
+ * @value: Counter value
+ *
+ * This function retrieves the value of a specific error counter based on
+ * the error severity and component.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_ras_get_counter(struct xe_device *xe, u8 severity, u8 component, u32 *value)
+{
+	struct xe_ras_error_class counter = {0};
+
+	counter.common.severity = drm_to_xe_ras_severity(severity);
+	counter.common.component = drm_to_xe_ras_component(component);
+
+	guard(xe_pm_runtime)(xe);
+	return get_counter(xe, &counter, value);
+}
+
+/**
+ * xe_ras_clear_counter() - Clear error counter value
+ * @xe: Xe device instance
+ * @severity: Error severity to be cleared (&enum drm_xe_ras_error_severity)
+ * @component: Error component to be cleared (&enum drm_xe_ras_error_component)
+ *
+ * This function clears the value of a specific error counter based on
+ * the error severity and component.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component)
+{
+	struct xe_ras_clear_counter_response response = {0};
+	struct xe_ras_clear_counter_request request = {0};
+	struct xe_sysctrl_mailbox_command command = {0};
+	struct xe_ras_error_class *counter;
+	size_t rlen;
+	int ret;
+
+	counter = &request.counter;
+	counter->common.severity = drm_to_xe_ras_severity(severity);
+	counter->common.component = drm_to_xe_ras_component(component);
+
+	xe_sysctrl_create_command(&command, XE_SYSCTRL_GROUP_GFSP, XE_SYSCTRL_CMD_CLEAR_COUNTER,
+				  &request, sizeof(request), &response, sizeof(response));
+
+	guard(xe_pm_runtime)(xe);
+	ret = xe_sysctrl_send_command(&xe->sc, &command, &rlen);
+	if (ret) {
+		xe_err(xe, "sysctrl: failed to clear counter %d\n", ret);
+		return ret;
+	}
+
+	if (rlen != sizeof(response)) {
+		xe_err(xe, "sysctrl: unexpected clear counter response length %zu (expected %zu)\n",
+		       rlen, sizeof(response));
+		return -EIO;
+	}
+
+	ret = ras_status_to_errno(response.status);
+	if (ret) {
+		xe_err(xe, "sysctrl: clear counter command failed with status %#x\n",
+		       response.status);
+		return ret;
+	}
+
+	counter = &response.counter;
+
+	xe_dbg(xe, "[RAS]: clear counter value for %s %s\n", comp_to_str(counter->common.component),
+	       sev_to_str(counter->common.severity));
+
+	return 0;
+}
+
+/**
+ * xe_ras_init - Initialize Xe RAS
+ * @xe: xe device instance
+ *
+ * Register drm_ras nodes
+ */
+void xe_ras_init(struct xe_device *xe)
+{
+	if (!xe->info.has_drm_ras)
+		return;
+
+	xe_drm_ras_init(xe);
+}
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index ea90593b62dc..ba0b0224df23 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -6,10 +6,15 @@
 #ifndef _XE_RAS_H_
 #define _XE_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 struct xe_sysctrl_event_response;
 
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response);
+int xe_ras_get_counter(struct xe_device *xe, u8 severity, u8 component, u32 *value);
+int xe_ras_clear_counter(struct xe_device *xe, u8 severity, u8 component);
+void xe_ras_init(struct xe_device *xe);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_ras_types.h b/drivers/gpu/drm/xe/xe_ras_types.h
index 4e63c67f806a..c6392435d1c6 100644
--- a/drivers/gpu/drm/xe/xe_ras_types.h
+++ b/drivers/gpu/drm/xe/xe_ras_types.h
@@ -70,4 +70,55 @@ struct xe_ras_threshold_crossed {
 	struct xe_ras_error_class counters[XE_RAS_NUM_COUNTERS];
 } __packed;
 
+/**
+ * struct xe_ras_get_counter_request - Request structure for get counter
+ */
+struct xe_ras_get_counter_request {
+	/** @counter: Error counter to be queried */
+	struct xe_ras_error_class counter;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_get_counter_response - Response structure for get counter
+ */
+struct xe_ras_get_counter_response {
+	/** @counter: Error counter that was queried */
+	struct xe_ras_error_class counter;
+	/** @value: Current counter value */
+	u32 value;
+	/** @timestamp: Timestamp when counter was last updated */
+	u64 timestamp;
+	/** @threshold: Threshold value for the counter */
+	u32 threshold;
+	/** @reserved: Reserved */
+	u32 reserved[57];
+} __packed;
+
+/**
+ * struct xe_ras_clear_counter_request - Request structure for clear counter
+ */
+struct xe_ras_clear_counter_request {
+	/** @counter: Counter class to be cleared */
+	struct xe_ras_error_class counter;
+	/** @reserved: Reserved for future use */
+	u32 reserved;
+} __packed;
+
+/**
+ * struct xe_ras_clear_counter_response - Response structure for clear counter
+ */
+struct xe_ras_clear_counter_response {
+	/** @counter: Counter class that was cleared */
+	struct xe_ras_error_class counter;
+	/** @reserved: Reserved */
+	u32 reserved;
+	/** @timestamp: Timestamp when the counter was cleared */
+	u64 timestamp;
+	/** @status: Status of the clear operation */
+	u32 status;
+	/** @reserved1: Reserved for future use */
+	u32 reserved1[3];
+} __packed;
 #endif
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
index 3caa9f15875f..e13eebaac1d0 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.c
@@ -293,6 +293,34 @@ static int sysctrl_send_command(struct xe_sysctrl *sc,
 	return 0;
 }
 
+/**
+ * xe_sysctrl_create_command() - Create system controller command
+ * @command: Sysctrl command structure
+ * @group_id: Command group ID
+ * @cmd_id: Command ID
+ * @request: Pointer to request buffer (can be NULL)
+ * @request_len: Size of request buffer
+ * @response: Pointer to response buffer
+ * @response_len: Size of response buffer
+ *
+ * Helper function to create sysctrl command to be sent via %xe_sysctrl_send_command()
+ */
+void xe_sysctrl_create_command(struct xe_sysctrl_mailbox_command *command, u8 group_id, u8 cmd_id,
+			       void *request, size_t request_len, void *response,
+			       size_t response_len)
+{
+	struct xe_sysctrl_app_msg_hdr header = {0};
+
+	header.data = FIELD_PREP(APP_HDR_GROUP_ID_MASK, group_id) |
+		      FIELD_PREP(APP_HDR_COMMAND_MASK, cmd_id);
+
+	command->header = header;
+	command->data_in = request;
+	command->data_in_len = request_len;
+	command->data_out = response;
+	command->data_out_len = response_len;
+}
+
 /**
  * xe_sysctrl_mailbox_init - Initialize System Controller mailbox interface
  * @sc: System controller structure
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
index f67e9234de48..fb434cc165b2 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox.h
@@ -23,6 +23,9 @@ struct xe_sysctrl_mailbox_command;
 #define XE_SYSCTRL_APP_HDR_VERSION(hdr) \
 	FIELD_GET(APP_HDR_VERSION_MASK, (hdr)->data)
 
+void xe_sysctrl_create_command(struct xe_sysctrl_mailbox_command *command, u8 group_id, u8 cmd_id,
+			       void *request, size_t request_len, void *response,
+			       size_t response_len);
 void xe_sysctrl_mailbox_init(struct xe_sysctrl *sc);
 int xe_sysctrl_send_command(struct xe_sysctrl *sc,
 			    struct xe_sysctrl_mailbox_command *cmd,
diff --git a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
index 84d7c647e743..6e3753554510 100644
--- a/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
+++ b/drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h
@@ -22,9 +22,13 @@ enum xe_sysctrl_group {
 /**
  * enum xe_sysctrl_gfsp_cmd - Commands supported by GFSP group
  *
+ * @XE_SYSCTRL_CMD_GET_COUNTER: Get error counter value
+ * @XE_SYSCTRL_CMD_CLEAR_COUNTER: Clear error counter value
  * @XE_SYSCTRL_CMD_GET_PENDING_EVENT: Retrieve pending event
  */
 enum xe_sysctrl_gfsp_cmd {
+	XE_SYSCTRL_CMD_GET_COUNTER		= 0x03,
+	XE_SYSCTRL_CMD_CLEAR_COUNTER		= 0x04,
 	XE_SYSCTRL_CMD_GET_PENDING_EVENT	= 0x07,
 };
 
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 48e9f1fdb78d..50c80af4ad4e 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -2589,6 +2589,12 @@ enum drm_xe_ras_error_component {
 	DRM_XE_RAS_ERR_COMP_CORE_COMPUTE = 1,
 	/** @DRM_XE_RAS_ERR_COMP_SOC_INTERNAL: SoC Internal Error */
 	DRM_XE_RAS_ERR_COMP_SOC_INTERNAL,
+	/** @DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY: Device Memory Error */
+	DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY,
+	/** @DRM_XE_RAS_ERR_COMP_PCIE: PCIe Subsystem Error */
+	DRM_XE_RAS_ERR_COMP_PCIE,
+	/** @DRM_XE_RAS_ERR_COMP_FABRIC: Fabric Subsystem Error */
+	DRM_XE_RAS_ERR_COMP_FABRIC,
 	/** @DRM_XE_RAS_ERR_COMP_MAX: Max Error */
 	DRM_XE_RAS_ERR_COMP_MAX	/* non-ABI */
 };
@@ -2606,7 +2612,10 @@ enum drm_xe_ras_error_component {
  */
 #define DRM_XE_RAS_ERROR_COMPONENT_NAMES {				\
 	[DRM_XE_RAS_ERR_COMP_CORE_COMPUTE] = "core-compute",		\
-	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL] = "soc-internal"		\
+	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL] = "soc-internal",		\
+	[DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY] = "device-memory",		\
+	[DRM_XE_RAS_ERR_COMP_PCIE] = "pcie",				\
+	[DRM_XE_RAS_ERR_COMP_FABRIC] = "fabric",			\
 }
 
 #if defined(__cplusplus)
-- 
2.43.0


