Return-Path: <netdev+bounces-301027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4HeTNBUNOWrulwcAu9opvQ
	(envelope-from <netdev+bounces-301027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:23:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E716AEA94
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:23:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dFcEKWz6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301027-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301027-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F6E0302AC28
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0710E3A5422;
	Mon, 22 Jun 2026 10:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B473A4F31
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 10:17:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123475; cv=none; b=b3Pd3PK+RhtDmKBaFxtLvu0zzbiwSJ/mdpCMd9KSN5I52aW3OfN7NxDgPy1ojLqxxENa595HjkExpCkTJaWGgxxWn/I4d4v+g8WnVFffSumu6+cq9CMxtbtccTdyiAlPi2arvAGfShoS0EZ06bSarZVGI2xXw/q6xo3Q1hMN1u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123475; c=relaxed/simple;
	bh=dXDUu0haClJGuUVUQW/Sc2XgZD7P5keFvQ4MPhBAdTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2NoZw0WtArFrRmk+t4dXJlJzKpWHegocROgWa2cWFvB3VFmsnAT7J06fW4UFjvgSx+V/kf+93UfbVRgd5/hLHAaT4ngzcYLsL8dne7c6C+fqiCynIA2aHaUT2C9w2NZD1u57OBz7+e55S54pMEM1itk0UHIypOlbHyBdc0J3PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dFcEKWz6; arc=none smtp.client-ip=198.175.65.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782123474; x=1813659474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dXDUu0haClJGuUVUQW/Sc2XgZD7P5keFvQ4MPhBAdTY=;
  b=dFcEKWz6S0dGjJhXcKgc5RcWokWP/FNrxe/7DbGNqoRW4rvfDiuTK7yA
   +zc9t5PNkBH8R/MPWjZJ2lA0AfRgdeUSQ2SW+lZZuDAcG8m6UTX2TkELt
   nG5PsnaIB70V28MRCKZdH3hZUk3ik5sCV5glvnksZXk7LuyjGglt0O5g7
   elrzH+SS7q0yGcz0z71eKmoL5oH5SV4JFe0OBL+qaAfe9QuTeJ+4vyQUv
   5Aruw2LPDz6CxTl1+TtJsDghDlgS2k7Tt0+1c5pFTXT7sv7skheNWcs71
   zwflSqlCtM3bXJxpQFIoqIYXgwA6KteGL1YJhbB/EN13Xe+8P3NpZM84y
   A==;
X-CSE-ConnectionGUID: hwYg3yMNSL20Xy1TvwMPaA==
X-CSE-MsgGUID: VelUzc1cQyil1wZor/NMMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86532094"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="86532094"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:17:54 -0700
X-CSE-ConnectionGUID: 5/CXqXC4R7m5v/SeAzHLAw==
X-CSE-MsgGUID: 55YPlrccRuKmGp3kuKqx8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; 
   d="scan'208";a="242832414"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 03:17:49 -0700
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
Subject: [PATCH v3 3/3] drm/xe/xe_ras: Add error-event support for CRI
Date: Mon, 22 Jun 2026 15:47:20 +0530
Message-ID: <20260622101716.3313496-8-riana.tauro@intel.com>
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301027-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,kernel.org,ffwll.ch,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:intel-xe@lists.freedesktop.org,m:dri-devel@lists.freedesktop.org,m:netdev@vger.kernel.org,m:aravind.iddamsetty@linux.intel.com,m:anshuman.gupta@intel.com,m:rodrigo.vivi@intel.com,m:joonas.lahtinen@linux.intel.com,m:kuba@kernel.org,m:simona.vetter@ffwll.ch,m:airlied@gmail.com,m:pratik.bari@intel.com,m:joshua.santosh.ranjan@intel.com,m:ashwin.kumar.kulkarni@intel.com,m:shubham.kumar@intel.com,m:ravi.kishore.koppuravuri@intel.com,m:raag.jadav@intel.com,m:maarten.lankhorst@linux.intel.com,m:mallesh.koujalagi@intel.com,m:soham.purkait@intel.com,m:riana.tauro@intel.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 26E716AEA94

Add error-event support for Correctable errors in CRI.
error-event is reported to  userspace for all errors that crossed
threshold on receiving an interrupt for correctable errors.

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_ras.c | 53 +++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 44f4e1a3455b..acf3207aa2fd 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -77,6 +77,18 @@ static u8 drm_to_xe_ras_severity(u8 severity)
 	}
 }
 
+static u8 xe_to_drm_ras_severity(u8 severity)
+{
+	switch (severity) {
+	case XE_RAS_SEV_CORRECTABLE:
+		return DRM_XE_RAS_ERR_SEV_CORRECTABLE;
+	case XE_RAS_SEV_UNCORRECTABLE:
+		return DRM_XE_RAS_ERR_SEV_UNCORRECTABLE;
+	default:
+		return DRM_XE_RAS_ERR_SEV_MAX;
+	}
+}
+
 static u8 drm_to_xe_ras_component(u8 component)
 {
 	switch (component) {
@@ -95,6 +107,24 @@ static u8 drm_to_xe_ras_component(u8 component)
 	}
 }
 
+static u8 xe_to_drm_ras_component(u8 component)
+{
+	switch (component) {
+	case XE_RAS_COMP_DEVICE_MEMORY:
+		return DRM_XE_RAS_ERR_COMP_DEVICE_MEMORY;
+	case XE_RAS_COMP_CORE_COMPUTE:
+		return DRM_XE_RAS_ERR_COMP_CORE_COMPUTE;
+	case XE_RAS_COMP_PCIE:
+		return DRM_XE_RAS_ERR_COMP_PCIE;
+	case XE_RAS_COMP_FABRIC:
+		return DRM_XE_RAS_ERR_COMP_FABRIC;
+	case XE_RAS_COMP_SOC_INTERNAL:
+		return DRM_XE_RAS_ERR_COMP_SOC_INTERNAL;
+	default:
+		return DRM_XE_RAS_ERR_COMP_MAX;
+	}
+}
+
 static int ras_status_to_errno(u32 status)
 {
 	switch (status) {
@@ -131,6 +161,27 @@ static inline const char *comp_to_str(u8 component)
 	return xe_ras_components[component];
 }
 
+static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 component)
+{
+	u8 drm_severity, drm_component;
+	u32 value;
+	int ret;
+
+	drm_severity = xe_to_drm_ras_severity(severity);
+	if (drm_severity == DRM_XE_RAS_ERR_SEV_MAX)
+		return;
+
+	drm_component = xe_to_drm_ras_component(component);
+	if (drm_component == DRM_XE_RAS_ERR_COMP_MAX)
+		return;
+
+	ret = xe_ras_get_counter(xe, severity, component, &value);
+	if (ret)
+		return;
+
+	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
+}
+
 void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 				      struct xe_sysctrl_event_response *response)
 {
@@ -152,6 +203,8 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 		severity = errors[id].common.severity;
 		component = errors[id].common.component;
 
+		ras_send_error_event(xe, severity, component);
+
 		xe_warn(xe, "[RAS]: %s %s detected\n",
 			comp_to_str(component), sev_to_str(severity));
 	}
-- 
2.47.1


