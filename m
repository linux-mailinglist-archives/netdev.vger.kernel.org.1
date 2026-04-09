Return-Path: <netdev+bounces-276856-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB+zBc1O12mvMQgAu9opvQ
	(envelope-from <netdev+bounces-276856-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:01:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 743A03C6CCA
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 09:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8966C3006801
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 07:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8920A36E47E;
	Thu,  9 Apr 2026 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcMu0ljX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF9134CFC6
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775718088; cv=none; b=cu7HjAi3ZCMi1up0RPDiVVbFpaHUXqVvRAMgtqr9Rsl0NFNoMF5KpwVx7iJKvMNKln/+H7s2lkmHEBSNpE/KugfIyKhQaQ41ZMjKu9RksSiH9tjXjpKvm3WfyRISqDh6RdKJDO4pJBejum8iasr85Sz8gJI7zEBqJRjMDwtuVnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775718088; c=relaxed/simple;
	bh=HC0z3AjOAJIWLdmgIAhd2wWiJAFJS5oyoyGLy0gtNCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a+z+eEPJUK633O9pr3TkXxosGr2H0UVNXUf0M002rKZiJFSxVbWV3nVSCO1Wawb7Hl1VRR8fMDqMIAsjTEhNhKTUrMq9AIOheARhVHh5P+Y8WLpPdJyFV+wqWgiKRhpPtpQrzZs7tLPY5mtKDsyMqIwo8LiT/NItfpAqQsIdO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcMu0ljX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775718087; x=1807254087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HC0z3AjOAJIWLdmgIAhd2wWiJAFJS5oyoyGLy0gtNCs=;
  b=gcMu0ljXQBC5JR9BzJt/OfnyucwLgqnd6cyzuOc5t91HVPyyToplV8Wg
   ArZpgeaYUX/w7/NNJSBoQT5pIMWzJYku0tf+92Yo19UGffXolFUTZGM8v
   GhCTgX1d3Z89RYMM3Kwb7Plk6Ceo2kVe2wdQHVMLEIP6Znmhs+zFaHXMU
   o0kbAAyMQIgSxymUn+dMTbeYwsCKrrFvOsCPuwkKCF9LQQjNXZtfpEb7O
   W3SfcBfov8d7maTFptAxOGro1PUkAwvjvUlyrJdo91A+ZdozyZqHOLHi3
   Nj26JyOZJVxuF5UKlL+P3Ehdm2KGBYi0eceXm2aVgTKpmVWU+b2ts+Kug
   A==;
X-CSE-ConnectionGUID: vHhqixf5Rb2ebAUddMlJFA==
X-CSE-MsgGUID: ekN0yE5gTLeVjrT4kz9YEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76836488"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="76836488"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:01:27 -0700
X-CSE-ConnectionGUID: ktDHjhy9RwecRw5MbbFxig==
X-CSE-MsgGUID: GKnqbfbFQFCBkfnc1vu71w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="233576579"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 00:01:22 -0700
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
Subject: [PATCH v2 2/2] drm/xe/xe_drm_ras: Add support for clear-error-counter in XE drm_ras
Date: Thu,  9 Apr 2026 13:03:20 +0530
Message-ID: <20260409073318.2909379-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260409073318.2909379-4-riana.tauro@intel.com>
References: <20260409073318.2909379-4-riana.tauro@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.intel.com,intel.com,ffwll.ch,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276856-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RSPAMD_EMAILBL_FAIL(0.00)[raag.jadav.intel.com:server fail];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riana.tauro@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 743A03C6CCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for clear-error-counter command in XE drm_ras
This resets the counter value.

Usage:

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":1}'
None

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
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


