Return-Path: <netdev+bounces-43822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110637D4EE1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A077E281884
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73856262AB;
	Tue, 24 Oct 2023 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om3nEWGG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C63266B3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:34:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F3D79
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147287; x=1729683287;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNyGsXLuPM6ACKgLWe6U53AUDwuyxhPZp6uE5dhElZc=;
  b=Om3nEWGG5+qyQCF8oF/osCWfaUmvw11/7BKzpDStx9rNAg/623eaN/jm
   d/cnVSmIvFWy1ehuYoiERuLBX9KkKIkUlhkLeQem0/MbfCwymNjrGBGSc
   vdKdM+Qrj6WQf+Kw/e1qc6/Le99xWZ8/dU+x42nqaFS/LAe/l/WGRrzq0
   dJdVRzjmQni/9qr7cxT417/9psJqG0osVGVoVjuab2QRChYTdyzzrHOEv
   EK8yYrivUTXSyFv5K3yperQezjXzGUwxwmb50TN9IMLKDzBvhXN9PswXz
   fFI4Ghs7WbdqDsMrcx+HTDAtSD1FJ9THGXJ60EyeC60eSeWg36So4/G3j
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660525"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660525"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:34:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6145979"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:27 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 03/15] ice: remove unused control VSI parameter
Date: Tue, 24 Oct 2023 13:09:17 +0200
Message-ID: <20231024110929.19423-4-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It isn't used in ice_eswitch_release_reprs(). Probably leftover. Remove
it.

Commit that has removed usage of ctrl_vsi:
commit c1e5da5dd465 ("ice: improve switchdev's slow-path")

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.c b/drivers/net/ethernet/intel/ice/ice_eswitch.c
index fd8d59f4d97d..a862681c0f64 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.c
@@ -189,10 +189,9 @@ static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
 /**
  * ice_eswitch_release_reprs - clear PR VSIs configuration
  * @pf: poiner to PF struct
- * @ctrl_vsi: pointer to eswitch control VSI
  */
 static void
-ice_eswitch_release_reprs(struct ice_pf *pf, struct ice_vsi *ctrl_vsi)
+ice_eswitch_release_reprs(struct ice_pf *pf)
 {
 	struct ice_vf *vf;
 	unsigned int bkt;
@@ -286,7 +285,7 @@ static int ice_eswitch_setup_reprs(struct ice_pf *pf)
 	return 0;
 
 err:
-	ice_eswitch_release_reprs(pf, ctrl_vsi);
+	ice_eswitch_release_reprs(pf);
 
 	return -ENODEV;
 }
@@ -532,7 +531,7 @@ static void ice_eswitch_disable_switchdev(struct ice_pf *pf)
 	ice_eswitch_napi_disable(pf);
 	ice_eswitch_br_offloads_deinit(pf);
 	ice_eswitch_release_env(pf);
-	ice_eswitch_release_reprs(pf, ctrl_vsi);
+	ice_eswitch_release_reprs(pf);
 	ice_vsi_release(ctrl_vsi);
 	ice_repr_rem_from_all_vfs(pf);
 }
-- 
2.41.0


