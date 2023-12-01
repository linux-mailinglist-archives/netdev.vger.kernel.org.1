Return-Path: <netdev+bounces-53034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADF80123D
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9655F1C20987
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C714F4F210;
	Fri,  1 Dec 2023 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gDxs6PLe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B23C10D
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701454138; x=1732990138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JhEuwEPn3CiIfFsxtFjmjadsVVwGQT1lv9z2oDsE0QA=;
  b=gDxs6PLeOtdJrsTU9kw6vx/adUttOOl/EuydXJrVrQhmfLBDsFEqAuNj
   ynf12lsUwn5n83AQPhK9I8CLaUorIfk4BedZ7clbz1f9y6z97IULEB7LU
   SN9RSm2vXaVRDl8m55DrgH7YLUGyE/eMAGwKXhiuRJ3/96yO35H5S1PDr
   locq+iK3Q5oHnKTGOpoRQLvF8RoaZ3Am2fNDTF1gumqNE+Ksn8sLQI/hc
   pGYoruWMVRPsZI9aelBjmfkMRj2mUIyH4hM07zxQPNPWvWc47nGfyfVy+
   MhTRMlDY3CERQ8kBAmlCLYoHdaL1C7FJmPTjcEGTds+HGkpeTAe7S5V6r
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="12244400"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="12244400"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 10:08:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10911"; a="893272444"
X-IronPort-AV: E=Sophos;i="6.04,242,1695711600"; 
   d="scan'208";a="893272444"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2023 10:08:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Pawel Kaminski <pawel.kaminski@intel.com>,
	anthony.l.nguyen@intel.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Simon Horman <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 3/6] ice: Improve logs for max ntuple errors
Date: Fri,  1 Dec 2023 10:08:41 -0800
Message-ID: <20231201180845.219494-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
References: <20231201180845.219494-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pawel Kaminski <pawel.kaminski@intel.com>

Supported number of ntuple filters affect also maximum location value that
can be provided to ethtool command. Update error message to provide info
about max supported value.

Fix double spaces in the error messages.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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


