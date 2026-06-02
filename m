Return-Path: <netdev+bounces-294010-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFOdLIJiHmrCiwkAu9opvQ
	(envelope-from <netdev+bounces-294010-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:56:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F836283E0
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D9B13043983
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD72DB78C;
	Tue,  2 Jun 2026 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LweYaMTA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA82D94BA
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376012; cv=none; b=lMB4xq6x0zliSWneIaQZuAMsqEq52oYitlnK+x2UUhMmke+r/fvpPtPV6fDwHEBOMK9xbhYfUbcuni2TJ1mYWvj/O2MhxD8c7blcr+2ZZoeSs8qfWDh5l54kjuLJcVRJSoRJA4QDlBLdqdMKpyrYVj5zdhRYroms3+vX5NzfIAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376012; c=relaxed/simple;
	bh=BsCP7ctx6l0Ln/OQfgG9XoaYhdWNrFR8mj3q8d2KZ5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mogZwtL8his6ZF3rdCD+5UYULVC8EqDgrRSlRn3KbHNno0tg2r6/gO9gOzwCEYuMeG4nmDBU/J6Vw3tjs8MVGjoqfc82m+xbDf2iWue36h8DBwyIDu+uZJizkBSvBXdfHt6acwrU3ssEtkuB7eSdURPKcQJgp7zgnUPXhz6gHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LweYaMTA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780376011; x=1811912011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BsCP7ctx6l0Ln/OQfgG9XoaYhdWNrFR8mj3q8d2KZ5A=;
  b=LweYaMTA76MDM2mtM+TXzHDMnps/r8genU5+HysM/gu69jChoSEnOWzK
   O02XasNL0scIqjXWZCaxYS83kLqoFW2k7DjngW/GFDYNe6HuyGvXuVGCx
   Thwg2oJD/HAXwLupfocLsp+e5i+Y63BYSTN46PHsyTGmsE0La1lM85sSC
   kzFIXD5BXCp6CC2vBqNqDTCAXiZQ24Vlk8H7tOFZCoifbyNSEkxysaJ3s
   Kzmb8ehjq7tGixDlmLyc/ctVDl0aP6NZN7gTeaEAIL3B8N2ORouY4uZlp
   NZjSAftpeAIZ8sj4PpCQRL704zxrrem2rzulfKHoaA6AEostwLXzPvkRz
   A==;
X-CSE-ConnectionGUID: KC28f0teSh+6GCPU6d4vhw==
X-CSE-MsgGUID: 4L2q4PT9STWqXPcZa3alYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120483"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81120483"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 21:53:30 -0700
X-CSE-ConnectionGUID: PshtVZZfQayor2JSflQoEQ==
X-CSE-MsgGUID: l5QpDHUvS8aIrf/2ONWIig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="245604125"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:27 -0700
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
Subject: [PATCH v3 3/4] drm/xe/drm_ras: Add per node cleanup action
Date: Tue,  2 Jun 2026 10:18:43 +0530
Message-ID: <20260602044919.702209-4-raag.jadav@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294010-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 16F836283E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cleanup_node_param() is not registered for previous node in case of counter
allocation failure, which results in stale memory of previous node that
isn't cleaned up on unwind. Add per node cleanup action which guarantees
cleanup on unwind and also simplifies the cleanup logic.

Fixes: b40db12b542f ("drm/xe/xe_drm_ras: Add support for XE DRM RAS")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v3: Prevent double free on drmm_add_action_or_reset() failure (Riana)
---
 drivers/gpu/drm/xe/xe_drm_ras.c | 58 +++++++++++++--------------------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c1d5ac198a7c..cd236f53699e 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -131,53 +131,47 @@ static int assign_node_params(struct xe_device *xe, struct drm_ras_node *node,
 	return 0;
 }
 
-static void cleanup_node_param(struct xe_drm_ras *ras, const enum drm_xe_ras_error_severity severity)
+static void cleanup_node_param(struct drm_ras_node *node)
 {
-	struct drm_ras_node *node = &ras->node[severity];
-
-	ras->info[severity] = NULL;
-
 	kfree(node->device_name);
 	node->device_name = NULL;
 }
 
+static void cleanup_node(struct drm_device *drm, void *node)
+{
+	drm_ras_node_unregister(node);
+	cleanup_node_param(node);
+}
+
 static int register_nodes(struct xe_device *xe)
 {
 	struct xe_drm_ras *ras = &xe->ras;
-	int i;
+	struct drm_ras_node *node;
+	int i, ret;
 
 	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
-		int ret;
+		node = &ras->node[i];
 
 		ret = assign_node_params(xe, node, i);
-		if (ret) {
-			cleanup_node_param(ras, i);
-			return ret;
-		}
+		if (ret)
+			goto free_param;
 
 		ret = drm_ras_node_register(node);
-		if (ret) {
-			cleanup_node_param(ras, i);
-			return ret;
-		}
+		if (ret)
+			goto free_param;
+
+		ret = drmm_add_action_or_reset(&xe->drm, cleanup_node, node);
+		if (ret)
+			goto null_info;
 	}
 
 	return 0;
-}
 
-static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
-{
-	struct xe_device *xe = arg;
-	struct xe_drm_ras *ras = &xe->ras;
-	int i;
-
-	for_each_error_severity(i) {
-		struct drm_ras_node *node = &ras->node[i];
-
-		drm_ras_node_unregister(node);
-		cleanup_node_param(ras, i);
-	}
+free_param:
+	cleanup_node_param(node);
+null_info:
+	ras->info[i] = NULL;
+	return ret;
 }
 
 /**
@@ -206,11 +200,5 @@ int xe_drm_ras_init(struct xe_device *xe)
 		return err;
 	}
 
-	err = drmm_add_action_or_reset(&xe->drm, xe_drm_ras_unregister_nodes, xe);
-	if (err) {
-		drm_err(&xe->drm, "Failed to add action for Xe DRM RAS (%pe)\n", ERR_PTR(err));
-		return err;
-	}
-
 	return 0;
 }
-- 
2.43.0


