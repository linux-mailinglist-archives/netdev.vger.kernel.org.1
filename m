Return-Path: <netdev+bounces-49489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8277F2315
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10F21B213AA
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 01:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874976FA4;
	Tue, 21 Nov 2023 01:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KK43/EvQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121A4D8
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 17:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700530328; x=1732066328;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AzKviix/mh52ouO+kzJmJwKfcmsPzwvmNbjZKSF67es=;
  b=KK43/EvQyn9nwdgK7+XwMc4Of6uE0gd/1Tx5ZRSuyyZs0qlF4h1F7De/
   wfiS/vJqJ//wlMjy6ys/uFOLO3PRVmpJXA84aKsitKR0ZRfs/od2O3ulE
   cyES5qxeXua3UooXfeQwN4rHlF0zDBnaMyQXW72FCndRLzvTBzwfkh6Ok
   pdYsQ06K2BJCYpNloC/rJAYYlv8zYv3HsNp4t4KZPahhLjhz7rK6+QIiP
   OlzTHIKNUvfL8vwtynkZpWdnLXNmGTU4FK0zurAMaIYV0ASXARkdeRiRD
   7xMLfOtTzgDHyTUMU03WTZg/pbPTXQ1GQ+zucMZDaD9ZsfwZJmH/M2OE9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="456077777"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="456077777"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:32:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="742887425"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="742887425"
Received: from c3-1-server.sj.intel.com ([10.232.18.246])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 17:32:09 -0800
From: Pawel Kaminski <pawel.kaminski@intel.com>
To: intel-wired-lan@osuosl.org
Cc: netdev@vger.kernel.org,
	Pawel Kaminski <pawel.kaminski@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH iwl-next v1] ice: Improve logs for max ntuple errors
Date: Mon, 20 Nov 2023 17:32:06 -0800
Message-ID: <20231121013206.2321-1-pawel.kaminski@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Supported number of ntuple filters affect also maximum location value that
can be provided to ethtool command. Update error message to provide info
about max supported value.

Fix double spaces in the error messages.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index d151e5bacfec..3cc9d703428e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -668,7 +668,7 @@ ice_fdir_set_hw_fltr_rule(struct ice_pf *pf, struct ice_flow_seg_info *seg,
 		 * then return error.
 		 */
 		if (hw->fdir_fltr_cnt[flow]) {
-			dev_err(dev, "Failed to add filter.  Flow director filters on each port must have the same input set.\n");
+			dev_err(dev, "Failed to add filter. Flow director filters on each port must have the same input set.\n");
 			return -EINVAL;
 		}
 
@@ -770,7 +770,7 @@ ice_fdir_set_hw_fltr_rule(struct ice_pf *pf, struct ice_flow_seg_info *seg,
 	ice_flow_rem_entry(hw, ICE_BLK_FD, entry1_h);
 err_prof:
 	ice_flow_rem_prof(hw, ICE_BLK_FD, prof_id);
-	dev_err(dev, "Failed to add filter.  Flow director filters on each port must have the same input set.\n");
+	dev_err(dev, "Failed to add filter. Flow director filters on each port must have the same input set.\n");
 
 	return err;
 }
@@ -1853,6 +1853,7 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	struct ice_pf *pf;
 	struct ice_hw *hw;
 	int fltrs_needed;
+	u32 max_location;
 	u16 tunnel_port;
 	int ret;
 
@@ -1884,8 +1885,10 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	if (ret)
 		return ret;
 
-	if (fsp->location >= ice_get_fdir_cnt_all(hw)) {
-		dev_err(dev, "Failed to add filter.  The maximum number of flow director filters has been reached.\n");
+	max_location = ice_get_fdir_cnt_all(hw);
+	if (fsp->location >= max_location) {
+		dev_err(dev, "Failed to add filter. The number of ntuple filters or provided location exceed max %d.\n",
+			max_location);
 		return -ENOSPC;
 	}
 
@@ -1893,7 +1896,7 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	fltrs_needed = ice_get_open_tunnel_port(hw, &tunnel_port, TNL_ALL) ? 2 : 1;
 	if (!ice_fdir_find_fltr_by_idx(hw, fsp->location) &&
 	    ice_fdir_num_avail_fltr(hw, pf->vsi[vsi->idx]) < fltrs_needed) {
-		dev_err(dev, "Failed to add filter.  The maximum number of flow director filters has been reached.\n");
+		dev_err(dev, "Failed to add filter. The maximum number of flow director filters has been reached.\n");
 		return -ENOSPC;
 	}
 
-- 
2.41.0


