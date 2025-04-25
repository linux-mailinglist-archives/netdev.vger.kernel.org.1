Return-Path: <netdev+bounces-186167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F34A9D578
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310761BA7FBE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800522918EF;
	Fri, 25 Apr 2025 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOuV51CA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C741A291174
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745620009; cv=none; b=ugzs9qMkIkBalaLk6G3Oo2d/TknfwqPNsqdEsWDBh+VdUToTIkGqKJPo8ytVcCy6VYjwnTuajfWGEQb3pwa5w2/g8T7yoVM0oG14+FjgPjNlVKmi77WjX+ZVoTqo5dJ697HeOwJTfoQarpKApooRz5ySDC0M8gOYXFJYDKAGv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745620009; c=relaxed/simple;
	bh=AkPA9+ChKNYGyL88tncLplFeiHuntjhi9ZHBYl7nTqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdNtLllmMsc/aTQnZP/FwoR8QYULA41x/YE++u/sqZmdNgLNRLEsAaAQhtFrAsa1LGOLrlOMNWjpG9nDmltHlRRn8YLVd9FyeWZRixGbkqW5Hl2Y6rlljhMJ26Qahp10SPeDe+UjLbYJiz5QGFaYqMfkuZrt4WY4sNoJn+ylYJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOuV51CA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745620008; x=1777156008;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AkPA9+ChKNYGyL88tncLplFeiHuntjhi9ZHBYl7nTqc=;
  b=NOuV51CAcfgkj73YkV3d1tl6sdWowKNPuCDOIViBz3wAfvlGDXlkwipr
   s7Nq60q8i++tUBCak0kbgYHEXlhKJ1oocnR42Yn2BuRnwteverR2M1G3o
   ci2T1rF9aqiamIalGzzJJ/YcFN9JJXbUhSScEBb32oFZJYKB4PSZnpaYT
   JGFCPWKpglBX+H0rpYL0Jb/qg3c0VCsHcfobuVrdi0QyJyJJ9nAnjFUDy
   l749qA5YaiGqth4YiIdNa7GL9Pk/TMACrMLz1ybUE4t2sB0JVWA1d9J6v
   c9kXyL5Ow5i3NcQl7esyQ5MOZOMjywujx4AUPJ5FmNLuth0P0yntqBmoA
   w==;
X-CSE-ConnectionGUID: 1cSaBuMRSeeJ+FKiXlPkxA==
X-CSE-MsgGUID: jxoZ9bhkSWG7KqoUODCrrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="50961382"
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="50961382"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 15:26:45 -0700
X-CSE-ConnectionGUID: JNvzgV5+QjylEeXdFA60DA==
X-CSE-MsgGUID: OoPlcZ9XQ+easNDFeQJ3xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,240,1739865600"; 
   d="scan'208";a="133533703"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 25 Apr 2025 15:26:45 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2 2/3] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
Date: Fri, 25 Apr 2025 15:26:32 -0700
Message-ID: <20250425222636.3188441-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
References: <20250425222636.3188441-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
pointer values"), we need to perform a null pointer check on the return
value of ice_get_vf_vsi() before using it.

Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 7752920d7a8e..1cca9b2262e8 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -2097,6 +2097,11 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	pf = vf->pf;
 	dev = ice_pf_to_dev(pf);
 	vf_vsi = ice_get_vf_vsi(vf);
+	if (!vf_vsi) {
+		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err_exit;
+	}
 
 #define ICE_VF_MAX_FDIR_FILTERS	128
 	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
-- 
2.47.1


