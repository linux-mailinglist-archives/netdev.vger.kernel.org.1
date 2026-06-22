Return-Path: <netdev+bounces-301026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hMV4JNILOWqmlwcAu9opvQ
	(envelope-from <netdev+bounces-301026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:17:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 677956AE9D5
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:17:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=E4vdFtQf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301026-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-301026-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EA091300C0E2
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5B43A4F47;
	Mon, 22 Jun 2026 10:17:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF83A5430
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:17:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123470; cv=none; b=Hk7iGYc8sOJ/kKY6ETo17UM8ZapT4Ea6cj+XPEDAbL9EWhsrEgTUWITpCHySi6dA4cOHbglUqXbyJM+nBcFgGCywHgSD1i5iOVDoYyWzilRn5TglGQakMC4K5P5SVREVUaOwXCr0nCCX2rHurD8sWcQP28Wzqw54O/45orOrNjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123470; c=relaxed/simple;
	bh=dpWdwD8glnaSaD0+Nt7C4cch4B/syPLuvEE2WAFcqGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8NMb5LaInVsv5aFRYsxjmcPno/+danAUPBaYp4wR6aEYGpWZkkifcbj6dQW04B+5c/pv/Rj9289nNM3yFMe3Paj6XvTBf6BhJDNtDGXM7Wa/6oRQMdc2reSw64jk+UDIVNivnatwlCoAG3LJQr2NOpzojshlUkT2bPz+gAvyVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4vdFtQf; arc=none smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782123468; x=1813659468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dpWdwD8glnaSaD0+Nt7C4cch4B/syPLuvEE2WAFcqGE=;
  b=E4vdFtQfCeVWtOX/+h0uHo8uEpiN0neDFZfsKXymhaKawrcBR6E4qs0f
   vzrChS7kQwwhVDVckqiflO3jRCeh/0VYlu90GBeBCmpbKJBMfZCZvMR0v
   lFhe/hRQiEeyBebQsS9+n4FxtJxL1VS7nKGvGzS/AN8tM/qMFReZ/Vj1Y
   vLZca4Ofw7cK8iFvfKQPf3h/TA1g25PHZ+QmgvRiLa1JuEirBKE+gfv6n
   QWRYIjMdV0Z+SyIAc+eL4i+9RTSIzjEQvdkwTveBe+qL+7MxjDn+KDflk
   3S8PbS6SjKzaRQHmT4yyYnPH0opjdL/i7n8evwm1l75ZcIjlGt61sZHuY
   w==;
X-CSE-ConnectionGUID: GsYUy/2PQBG9EQ1I5Rhflg==
X-CSE-MsgGUID: 3FUjr6wrTaOHJV+9vyYx3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86532071"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="86532071"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:17:48 -0700
X-CSE-ConnectionGUID: tJzNE0tJTVSR4sZtec9iqQ==
X-CSE-MsgGUID: sYQvSibyQvWqLp26PwjFww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="242832408"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:17:43 -0700
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
Subject: [PATCH v3 2/3] drm/xe/xe_drm_ras: Add error-event support for PVC
Date: Mon, 22 Jun 2026 15:47:19 +0530
Message-ID: <20260622101716.3313496-7-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622101716.3313496-5-riana.tauro@intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:riana.tauro@intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301026-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 677956AE9D5

Report drm_ras error event to userspace when an error occurs.
Add support for core-compute and SoC errors in PVC.

$ sudo ynl --family drm_ras --output-json --subscribe error-report

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
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v2: use ynl (Raag)
    use value as function parameter
    move error event call to hw_error_source_handler 

v3: add has_drm_ras check
---
 drivers/gpu/drm/xe/xe_drm_ras.c  | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h  |  3 +++
 drivers/gpu/drm/xe/xe_hw_error.c |  5 ++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 7937d8ba0ed9..36afdfb5e412 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -185,6 +185,36 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+/**
+ * xe_drm_ras_event() - Report drm-ras error event to userspace
+ * @xe: xe device structure
+ * @component: error component (see &enum drm_xe_ras_error_component)
+ * @severity: error severity (see &enum drm_xe_ras_error_severity)
+ * @value: value of error counter
+ * @flags: flags for allocation
+ *
+ * Report an error-event to userspace.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[severity];
+	struct drm_ras_node *node = &ras->node[severity];
+	int ret;
+
+	/* Event is supported only if drm_ras is enabled */
+	if (!xe->info.has_drm_ras)
+		return;
+
+	if (!info || !info[component].name)
+		return;
+
+	ret = drm_ras_nl_error_event(node, component, info[component].name, value, flags);
+	if (ret)
+		drm_err(&xe->drm, "RAS error-event failed: %d for %s %s\n", ret,
+			info[component].name, error_severity[severity]);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..2a694bf69478 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -5,11 +5,14 @@
 #ifndef _XE_DRM_RAS_H_
 #define _XE_DRM_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 
 #define for_each_error_severity(i)	\
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 4a4b363fc844..a833cecc74ec 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -432,7 +432,7 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 	struct xe_drm_ras *ras = &xe->ras;
 	struct xe_drm_ras_counter *info = ras->info[severity];
 	unsigned long flags, err_src;
-	u32 err_bit;
+	u32 err_bit, value;
 
 	if (!IS_DGFX(xe))
 		return;
@@ -495,6 +495,9 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 			gt_hw_error_handler(tile, hw_err, error_id);
 		if (err_bit == XE_SOC_ERROR)
 			soc_hw_error_handler(tile, hw_err, error_id);
+
+		value = atomic_read(&info[error_id].counter);
+		xe_drm_ras_event(xe, error_id, severity, value, GFP_ATOMIC);
 	}
 
 clear_reg:
-- 
2.47.1


