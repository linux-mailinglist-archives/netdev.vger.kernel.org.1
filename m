Return-Path: <netdev+bounces-279431-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NCxKJ6k4mk58gAAu9opvQ
	(envelope-from <netdev+bounces-279431-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3409F41EAD1
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33439301E733
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE2368974;
	Fri, 17 Apr 2026 21:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PKQ31+2o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75B36922D
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460925; cv=none; b=YhyxAlUUkEjDmjuY0XXJM7AYTOOm1gIc/Zk2nW+Rv+9yD6CjG5kOwzbiV3BciSr4oVSCYDApu7cSKq5ptMjum5xySnnkayVfyMhV4BKoq9Ku11vCEdqpUKfwaDPIKMYu0K9J1xXj1zq4X3/t9OIdigId8rv01JfT2Vr785P9Jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460925; c=relaxed/simple;
	bh=Oyt9MrhcLOpBiVDxuBegMnlAznf2Vvn3Nn3jGErX18s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joTRLj8zshsitjt0XWdNuwVtKHWo2OSsePkCylNTJVqYyg/DFNzEau+DIs5xfjkazVu96EudKSMOt98nmRiJrk03CEkjFBTzdhfPI4EzLSnI07DzmPQTH/g+Pl+Rd2N6NEr8n4lZ0jj0gNeL+fL8vTEAHYD7Jg23QIp7xDuSbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PKQ31+2o; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776460924; x=1807996924;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oyt9MrhcLOpBiVDxuBegMnlAznf2Vvn3Nn3jGErX18s=;
  b=PKQ31+2ofp1GNrZWFtvwZD2qSc5PTfvkQbj7GR79wt78HmFT6zrNwMnU
   WoXdoAEnyM4l1Py2OiWcwGWetiWcTv1qBuRlhwm4rP+MlQW+Om6e5250d
   Y7AiFCMmRwc06KaQkm79+vRogsqAQB7iwK+7zHVNoCn4OSUDmVj7JmNjH
   YO+GWfkMW8O3Q8qGlHUlta4QGKEtx4mXNoDFlOfWQ03dI2Me6RJ0cE5/j
   WVIy/kajFaiUv100BrwZSXnTfW6R3SGPLkJzlsghXKTFMgPtcpDLJo1tj
   yVMSgAK+OATeqvIz25smn9T3fLq9QSc5ZmEqMN1qwEDdck8eiXtztW9CG
   g==;
X-CSE-ConnectionGUID: zPSKnnhIT0Cvht/NW+Rt7A==
X-CSE-MsgGUID: Ob3X9uHqQrauvaKYCiFqMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046227"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="95046227"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 14:22:04 -0700
X-CSE-ConnectionGUID: wHxm8N5cQFCwS1Xisk5WZw==
X-CSE-MsgGUID: GlcMDf4NQf+KI2L+2XjM7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; 
   d="scan'208";a="235503920"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:21:58 -0700
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
Subject: [PATCH v1 10/11] drm/xe/drm_ras: Wire up error threshold callbacks
Date: Sat, 18 Apr 2026 02:46:45 +0530
Message-ID: <20260417211730.837345-11-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279431-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 3409F41EAD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that we have get/set error threshold support in xe driver, wire them
up to drm_ras so that the user can make use of both functionalities.

$ sudo ynl --family drm_ras --do get-error-threshold --json \
  '{"node-id":0, "error-id":2}'
{'error-id': 2, 'error-name': 'soc-internal', 'error-threshold': 0}

$ sudo ynl --family drm_ras --do set-error-threshold --json \
  '{"node-id":0, "error-id":2, "error-threshold":8}'
None

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index e07dc23a155e..824dabd5c29e 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -11,6 +11,7 @@
 
 #include "xe_device_types.h"
 #include "xe_drm_ras.h"
+#include "xe_ras.h"
 
 static const char * const error_components[] = DRM_XE_RAS_ERROR_COMPONENT_NAMES;
 static const char * const error_severity[] = DRM_XE_RAS_ERROR_SEVERITY_NAMES;
@@ -47,6 +48,27 @@ static int query_correctable_error_counter(struct drm_ras_node *ep, u32 error_id
 	return hw_query_error_counter(info, error_id, name, val);
 }
 
+static int query_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id,
+					     const char **name, u32 *val)
+{
+	struct xe_device *xe = ep->priv;
+
+	if (!xe->info.has_sysctrl)
+		return -EOPNOTSUPP;
+
+	return xe_ras_get_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
+}
+
+static int set_correctable_error_threshold(struct drm_ras_node *ep, u32 error_id, u32 val)
+{
+	struct xe_device *xe = ep->priv;
+
+	if (!xe->info.has_sysctrl)
+		return -EOPNOTSUPP;
+
+	return xe_ras_set_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id, val);
+}
+
 static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *xe)
 {
 	struct xe_drm_ras_counter *counter;
@@ -92,10 +114,13 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	if (IS_ERR(ras->info[severity]))
 		return PTR_ERR(ras->info[severity]);
 
-	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE)
+	if (severity == DRM_XE_RAS_ERR_SEV_CORRECTABLE) {
 		node->query_error_counter = query_correctable_error_counter;
-	else
+		node->query_error_threshold = query_correctable_error_threshold;
+		node->set_error_threshold = set_correctable_error_threshold;
+	} else {
 		node->query_error_counter = query_uncorrectable_error_counter;
+	}
 
 	return 0;
 }
-- 
2.43.0


