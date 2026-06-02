Return-Path: <netdev+bounces-294009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ON7tBW1iHmrCiwkAu9opvQ
	(envelope-from <netdev+bounces-294009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:56:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0266283D9
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB114303CA69
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3542D7DEF;
	Tue,  2 Jun 2026 04:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LMXKRQQW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4D2DB7BF
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 04:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376008; cv=none; b=fi2WbfDD5iMTCsojl7cHC13XgQPTnb8NuGMglE38LgAjQb4J79gt7hHPqCznTh+rShhM1EH3MfbB5xDEUBa6RW5qO7Fv/ypdfRUObjAd3zelMrEQuWE4HUamCuL11N4oCdQTgCzhP6f5RlmjYvmQ6KkD1NZpEdGaEmQ8XUuhghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376008; c=relaxed/simple;
	bh=tsvQCH73Wyi2zeslZOLlyP9kVbT4M3dBOFVXyyISIz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PO0gAJlg7kOYdFqKNFciYs4vD2rBOnt2XLa3ODNm5vaNhT1r9S/QkVR1mDLOox18qfR+OJUMuj7fJrX7m0bA0ZLCxE+6xpYh2vFYhmbWk7g1K24UErn213Y0DCBLGmjkHL00PwM3KQWiucwG0uJbckcW1PTujb57PLhhlqqlj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LMXKRQQW; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780376008; x=1811912008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tsvQCH73Wyi2zeslZOLlyP9kVbT4M3dBOFVXyyISIz8=;
  b=LMXKRQQWoosGZ38SahBOqNL8h4sUOiWnTSKZfL2lKm6a666cwi4pkn6w
   aItXYEFwCwU1YTwRedDXPcIckbWIAebP1lUqH282D6Gd5DwISoymxAyXH
   s994Fe5nFD/zjnyO04nZkR3RuOxYE0/wFxMBi7Sd5E313gkLHWM2QVlDr
   ZiiLxPC11S4taZp30nqtMvP5u+wk6/PQUDGYP5nDoq+ap0cLiCSuV7vqo
   db8kkSRLMlOwVVBMTUchwQx9zFH5SdYnm9+u97w7lqadp3VPw0kqVj7XT
   6UOxfKJPTRFazM5QzFcfYdjSo35qclRItiRAsogrwD1xOniEJiY70olP+
   g==;
X-CSE-ConnectionGUID: rK2yBhMBQQCxjIDNB870NQ==
X-CSE-MsgGUID: d+Wb4OCiQJyu4GMDlhNKsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120476"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81120476"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 21:53:27 -0700
X-CSE-ConnectionGUID: oxPirwg4Sdm3L9Dv3kFd/A==
X-CSE-MsgGUID: YjJiSmBaRJilT9jLZXwq7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="245604117"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:24 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	dev@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 2/4] drm/xe/drm_ras: Make counter allocation drm managed
Date: Tue,  2 Jun 2026 10:18:42 +0530
Message-ID: <20260602044919.702209-3-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602044919.702209-1-raag.jadav@intel.com>
References: <20260602044919.702209-1-raag.jadav@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294009-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 6E0266283D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cleanup_node_param() is not registered for previous node in case of counter
allocation failure, which results in stale memory of previous node that
isn't cleaned up on unwind. Fix this using drm managed allocation, which is
guaranteed to be cleaned up on unwind.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Retain info as NULL on failure (Riana)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c21c8b428de6..c1d5ac198a7c 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -80,7 +80,7 @@ static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_device *x
 	struct xe_drm_ras_counter *counter;
 	int i;
 
-	counter = kcalloc(DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
+	counter = drmm_kcalloc(&xe->drm, DRM_XE_RAS_ERR_COMP_MAX, sizeof(*counter), GFP_KERNEL);
 	if (!counter)
 		return ERR_PTR(-ENOMEM);
 
@@ -135,7 +135,6 @@ static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_err
 {
 	struct drm_ras_node *node = &ras->node[severity];
 
-	kfree(ras->info[severity]);
 	ras->info[severity] = NULL;
 
 	kfree(node->device_name);
-- 
2.43.0


