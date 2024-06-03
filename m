Return-Path: <netdev+bounces-100383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 616ED8FA492
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 23:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3F76B221BD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 21:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4331D13C9D8;
	Mon,  3 Jun 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZKi3Mp/A"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844C113C902
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717451491; cv=none; b=pb8/V5G0lAccysNtA3lQIlX+rHeaFLNWi2unQ+HX6L8G3QCTppih8jWza8ZFaxZiOwStIChfBqbFCsY2TiJWd5tNlEt6+JzFvoCCk0HKMzziEhZrf9xDTo2cbveSNDLQ2NHEO9or6+ZBg3gcbG/IEjvmWukA5YBB7VbERhKIwPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717451491; c=relaxed/simple;
	bh=xejJBuJfCnvJ2Ftf/CrSuuytHbdkklhI5ntg7Q7RETM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwwZyYmy0pt1ygLB0WtwN7gU7fOAwISdRo7l1qHjfLUsUrFMeBdOhShzFuKeN3cp6XYS+TGmk+PGNu3Englb1QR51+alXUeU2bkEW8lseTcW3azhAeCSCw39Kf2/4AW0RrKuY6qRXkTEhN3UDtEqBua3WrT+eDZs1dDKrfL7b9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZKi3Mp/A; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717451489; x=1748987489;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=xejJBuJfCnvJ2Ftf/CrSuuytHbdkklhI5ntg7Q7RETM=;
  b=ZKi3Mp/AhY3BLgwoNh5b8Cwn0iGZ3SlUiBVlJ+aEaLWYIwCgFDntvWui
   qNV8/Unkgn6EG/txjFI5oCMenCe0uFAjUlAQZCKyCIKuQUaFOAJfwDryC
   lyUaHVZW2TC6gdrBhxmt78yiiI1/or0jNHstljzLnkWculF//ukNBsbkC
   MkoQiPMq/nUoJX2vTws0JtzzA7V65WDobskMJv0e0PpnXshmIbKkEdqwj
   fNCMua2g59yyZQZKnTzJRNjK/9j8FKyOQ0dsW8cWYUrcft6SShmJMdhwc
   PUA/vTrA/MWc42Pqh9BsenCntitL8S9M5aY08tTc57IkivKwcIjYq4Rjk
   A==;
X-CSE-ConnectionGUID: CqmtgrasSHCH8LRTGYq9uA==
X-CSE-MsgGUID: DZ4dfssnTKmWpEvORRDGWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24547593"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24547593"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
X-CSE-ConnectionGUID: pyUK5LBXQyKzikYgp8gjfA==
X-CSE-MsgGUID: B8qKa1/ITouBk0PnoYCT0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37608247"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:51:25 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 03 Jun 2024 14:42:33 -0700
Subject: [PATCH net v2 4/6] ice: add flag to distinguish reset from
 .ndo_bpf in XDP rings config
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-net-2024-05-30-intel-net-fixes-v2-4-e3563aa89b0c@intel.com>
References: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
In-Reply-To: <20240603-net-2024-05-30-intel-net-fixes-v2-0-e3563aa89b0c@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>, Simon Horman <horms@kernel.org>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>
X-Mailer: b4 0.13.0

From: Larysa Zaremba <larysa.zaremba@intel.com>

Commit 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
has placed ice_vsi_free_q_vectors() after ice_destroy_xdp_rings() in
the rebuild process. The behaviour of the XDP rings config functions is
context-dependent, so the change of order has led to
ice_destroy_xdp_rings() doing additional work and removing XDP prog, when
it was supposed to be preserved.

Also, dependency on the PF state reset flags creates an additional,
fortunately less common problem:

* PFR is requested e.g. by tx_timeout handler
* .ndo_bpf() is asked to delete the program, calls ice_destroy_xdp_rings(),
  but reset flag is set, so rings are destroyed without deleting the
  program
* ice_vsi_rebuild tries to delete non-existent XDP rings, because the
  program is still on the VSI
* system crashes

With a similar race, when requested to attach a program,
ice_prepare_xdp_rings() can actually skip setting the program in the VSI
and nevertheless report success.

Instead of reverting to the old order of function calls, add an enum
argument to both ice_prepare_xdp_rings() and ice_destroy_xdp_rings() in
order to distinguish between calls from rebuild and .ndo_bpf().

Fixes: efc2214b6047 ("ice: Add support for XDP")
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h      | 11 +++++++++--
 drivers/net/ethernet/intel/ice/ice_lib.c  |  5 +++--
 drivers/net/ethernet/intel/ice/ice_main.c | 22 ++++++++++++----------
 3 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 5e51cb84b600..a5de6ef9c07e 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -930,9 +930,16 @@ int ice_down(struct ice_vsi *vsi);
 int ice_down_up(struct ice_vsi *vsi);
 int ice_vsi_cfg_lan(struct ice_vsi *vsi);
 struct ice_vsi *ice_lb_vsi_setup(struct ice_pf *pf, struct ice_port_info *pi);
+
+enum ice_xdp_cfg {
+	ICE_XDP_CFG_FULL,	/* Fully apply new config in .ndo_bpf() */
+	ICE_XDP_CFG_PART,	/* Save/use part of config in VSI rebuild */
+};
+
 int ice_vsi_determine_xdp_res(struct ice_vsi *vsi);
-int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog);
-int ice_destroy_xdp_rings(struct ice_vsi *vsi);
+int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
+			  enum ice_xdp_cfg cfg_type);
+int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type);
 int
 ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	     u32 flags);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index c0a7ff6c7e87..dd8b374823ee 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2285,7 +2285,8 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 			ret = ice_vsi_determine_xdp_res(vsi);
 			if (ret)
 				goto unroll_vector_base;
-			ret = ice_prepare_xdp_rings(vsi, vsi->xdp_prog);
+			ret = ice_prepare_xdp_rings(vsi, vsi->xdp_prog,
+						    ICE_XDP_CFG_PART);
 			if (ret)
 				goto unroll_vector_base;
 		}
@@ -2429,7 +2430,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 		/* return value check can be skipped here, it always returns
 		 * 0 if reset is in progress
 		 */
-		ice_destroy_xdp_rings(vsi);
+		ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_PART);
 
 	ice_vsi_clear_rings(vsi);
 	ice_vsi_free_q_vectors(vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..2a270aacd24a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2711,10 +2711,12 @@ static void ice_vsi_assign_bpf_prog(struct ice_vsi *vsi, struct bpf_prog *prog)
  * ice_prepare_xdp_rings - Allocate, configure and setup Tx rings for XDP
  * @vsi: VSI to bring up Tx rings used by XDP
  * @prog: bpf program that will be assigned to VSI
+ * @cfg_type: create from scratch or restore the existing configuration
  *
  * Return 0 on success and negative value on error
  */
-int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
+int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog,
+			  enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	int xdp_rings_rem = vsi->num_xdp_txq;
@@ -2790,7 +2792,7 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
 	 * taken into account at the end of ice_vsi_rebuild, where
 	 * ice_cfg_vsi_lan is being called
 	 */
-	if (ice_is_reset_in_progress(pf->state))
+	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
 	/* tell the Tx scheduler that right now we have
@@ -2842,22 +2844,21 @@ int ice_prepare_xdp_rings(struct ice_vsi *vsi, struct bpf_prog *prog)
 /**
  * ice_destroy_xdp_rings - undo the configuration made by ice_prepare_xdp_rings
  * @vsi: VSI to remove XDP rings
+ * @cfg_type: disable XDP permanently or allow it to be restored later
  *
  * Detach XDP rings from irq vectors, clean up the PF bitmap and free
  * resources
  */
-int ice_destroy_xdp_rings(struct ice_vsi *vsi)
+int ice_destroy_xdp_rings(struct ice_vsi *vsi, enum ice_xdp_cfg cfg_type)
 {
 	u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
 	struct ice_pf *pf = vsi->back;
 	int i, v_idx;
 
 	/* q_vectors are freed in reset path so there's no point in detaching
-	 * rings; in case of rebuild being triggered not from reset bits
-	 * in pf->state won't be set, so additionally check first q_vector
-	 * against NULL
+	 * rings
 	 */
-	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
+	if (cfg_type == ICE_XDP_CFG_PART)
 		goto free_qmap;
 
 	ice_for_each_q_vector(vsi, v_idx) {
@@ -2898,7 +2899,7 @@ int ice_destroy_xdp_rings(struct ice_vsi *vsi)
 	if (static_key_enabled(&ice_xdp_locking_key))
 		static_branch_dec(&ice_xdp_locking_key);
 
-	if (ice_is_reset_in_progress(pf->state) || !vsi->q_vectors[0])
+	if (cfg_type == ICE_XDP_CFG_PART)
 		return 0;
 
 	ice_vsi_assign_bpf_prog(vsi, NULL);
@@ -3009,7 +3010,8 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 		if (xdp_ring_err) {
 			NL_SET_ERR_MSG_MOD(extack, "Not enough Tx resources for XDP");
 		} else {
-			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog);
+			xdp_ring_err = ice_prepare_xdp_rings(vsi, prog,
+							     ICE_XDP_CFG_FULL);
 			if (xdp_ring_err)
 				NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Tx resources failed");
 		}
@@ -3020,7 +3022,7 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Rx resources failed");
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
 		xdp_features_clear_redirect_target(vsi->netdev);
-		xdp_ring_err = ice_destroy_xdp_rings(vsi);
+		xdp_ring_err = ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_FULL);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Tx resources failed");
 		/* reallocate Rx queues that were used for zero-copy */

-- 
2.44.0.53.g0f9d4d28b7e6


