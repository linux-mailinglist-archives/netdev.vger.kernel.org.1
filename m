Return-Path: <netdev+bounces-266591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAO1Dj9CsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A026204F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14C5A308156C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339803BB9E2;
	Wed, 11 Mar 2026 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8BoiLEN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88E63B8D6B
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 09:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223115; cv=none; b=YyYvHCN7ZzZbCMW3c1K3mqdZa3u3+Cy7d6rRSQmZTdfNx449q+yI8vFToEVvs1FtnFDKEk17We3ehSE690z9/uWb2SR/GLGD+welcB0CiRkPIBPXlk+2PRL05eD9oG/zpzWz0yGMVhGd+zW4f1vsMNh/X4YiEFMPD6/Hq+pI7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223115; c=relaxed/simple;
	bh=HzPj4fT4BTPw6WA53cGERH2WgByckd4BKoG2vrd/YnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWkzx7CFZnDG9bz/RSUKaWpKMS0yPq7qmD0PVGMhW9WfReQhDJo6JsLnBShiXCmTpsYntg+2jq0+avW3Tx3nEutd8Y7NgWoVioJs7asP6k+CN/CLakvFRDBl+GQeP33GoyW6o2F74T3WlZ9CXwmhZ9nvQ044JkScQXAMG+MvKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8BoiLEN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773223114; x=1804759114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzPj4fT4BTPw6WA53cGERH2WgByckd4BKoG2vrd/YnE=;
  b=I8BoiLENtnp7jdJUQPUPzWEsUNozWMqG2i4O5g4+bVIR1XuSK8/jSQ5s
   +bn4NhH6gPLAeY8f2Jsg9P/HFl6dYcHTG8LVc71TePjS42WzzZ3rxFyc6
   FYDKMQB/12ZNGbv5xQZmkqf/z6fu6LY4MDMW7P49J/HyYwN7fbZms7/Jc
   sP508gGVWOHiC7gqwpu0sKNy5ihdayO4qWOgK/SI/9MWh113VjEkpYBvP
   C3j5QoED7LjMCbt4kQt8euIX+CSHvzT31JyfaG2KxU0ksSzUXXqupp9qp
   bdTZI2cCoVElDrn2DCT5LpC9DK5n+KoOxRxrJtkqFjvSW3stvPqb5x6na
   Q==;
X-CSE-ConnectionGUID: MIKBoPEMQbeK77AxKR+J7g==
X-CSE-MsgGUID: uqHDuYPJQ1SThkMowct09w==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74326041"
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="74326041"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:58:29 -0700
X-CSE-ConnectionGUID: dw6oik6XQXeAF+bYkMIWNg==
X-CSE-MsgGUID: GfffPN51QkCdZ1iOiBQVrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,113,1770624000"; 
   d="scan'208";a="217095830"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 02:58:24 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com,
	anshuman.gupta@intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	simona.vetter@ffwll.ch,
	airlied@gmail.com,
	pratik.bari@intel.com,
	joshua.santosh.ranjan@intel.com,
	ashwin.kumar.kulkarni@intel.com,
	shubham.kumar@intel.com,
	ravi.kishore.koppuravuri@intel.com,
	raag.jadav@intel.com,
	anvesh.bakwad@intel.com,
	maarten.lankhorst@linux.intel.com,
	Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 2/4] drm/xe/xe_drm_ras: Add support for clear-error-counter in XE DRM RAS
Date: Wed, 11 Mar 2026 15:59:16 +0530
Message-ID: <20260311102913.3387468-8-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260311102913.3387468-6-riana.tauro@intel.com>
References: <20260311102913.3387468-6-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4A3A026204F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ffwll.ch,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266591-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add support for clear-error-counter command in XE DRM RAS.
This resets the counter value.

Usage:

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":1}'
None

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 35 +++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index e07dc23a155e..c21c8b428de6 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -27,6 +27,16 @@ static int hw_query_error_counter(struct xe_drm_ras_counter *info,
 	return 0;
 }
 
+static int hw_clear_error_counter(struct xe_drm_ras_counter *info, u32 error_id)
+{
+	if (!info || !info[error_id].name)
+		return -ENOENT;
+
+	atomic_set(&info[error_id].counter, 0);
+
+	return 0;
+}
+
 static int query_uncorrectable_error_counter(struct drm_ras_node *ep, u32 error_id,
 					     const char **name, u32 *val)
 {
@@ -37,6 +47,15 @@ static int query_uncorrectable_error_counter(struct drm_ras_node *ep, u32 error_
 	return hw_query_error_counter(info, error_id, name, val);
 }
 
+static int clear_uncorrectable_error_counter(struct drm_ras_node *node, u32 error_id)
+{
+	struct xe_device *xe = node->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_UNCORRECTABLE];
+
+	return hw_clear_error_counter(info, error_id);
+}
+
 static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id,
 					   const char **name, u32 *val)
 {
@@ -47,6 +66,15 @@ static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id
 	return hw_query_error_counter(info, error_id, name, val);
 }
 
+static int clear_correctable_error_counter(struct drm_ras_node *node, u32 error_id)
+{
+	struct xe_device *xe = node->priv;
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[DRM_XE_RAS_ERR_SEV_CORRECTABLE];
+
+	return hw_clear_error_counter(info, error_id);
+}
+
 static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
 {
 	struct xe_drm_ras_counter *counter;
@@ -92,10 +120,13 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	if (IS_ERR(ras->info[severity]))
 		return PTR_ERR(ras->info[severity]);
 
-	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
+	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
 		node->query_error_counter = query_correctable_error_counter;
-	else
+		node->clear_error_counter = clear_correctable_error_counter;
+	} else {
 		node->query_error_counter = query_uncorrectable_error_counter;
+		node->clear_error_counter = clear_uncorrectable_error_counter;
+	}
 
 	return 0;
 }
-- 
2.47.1


