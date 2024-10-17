Return-Path: <netdev+bounces-136430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE2D9A1B5A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EBE11C20DF3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A861C1AD6;
	Thu, 17 Oct 2024 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jbe0HXWL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B945018E04E
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148902; cv=none; b=tiqdDHDZp8rhJ6o/1bD1V/T0F3jMR4muJmgNl0913uHYXl2gm3CVtGgIazaLdw96E/GvmW5/4lB0UKEhV61/IsxHYD28iG3355mHfNN5DeWMk42TfoxbxKtdEg1nojEVRtNwHLG2tBLQo29eX31yrFO+d0+YagbDZkeA+G5VyNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148902; c=relaxed/simple;
	bh=C8il09Zid+NlX4kVgauTunq+ykY+xAP2npwH8kPEciM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ko5DfKDEKSgPx+aCit2dPYkwOeQeSEGw+mL6jlw1HHGyXzQMBYxQ1uzjgIn630rQJm8Kj2R/XWpD8XqcBB2gUPPRLj/kQ+ewi9voUn9zZty/C9vNdDiOdxYLivK503E0ZpXLjvw380Es2equxl5oEMTgsyCI60Gqo9UtPfTwDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jbe0HXWL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729148900; x=1760684900;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C8il09Zid+NlX4kVgauTunq+ykY+xAP2npwH8kPEciM=;
  b=Jbe0HXWLijpR3T/v6nbUwqrDK/siliMk7cO2NYdF/wROiFVoha7TeYCz
   dUOz4F9j5JYjKi9u2fSNMdWIJj1F74KEON9/hdyB3a4Fyd8vgH/4kxy6A
   NyiVJ1xk0EMRSZSzvdNOGVWHm2D27pfJr7jt0eTyA2UNR2DVeKTJGx5Lc
   i6hPJq3s+rukG7qhqm38oJ0qDBc4lu2S9MEqGY/W55yKA3mx8lAIyno0i
   4mTA7fyt0ramkfCeWFtN1vFshvWqe6foa5jIsltBrvYzqPKyQzHEY7c7V
   rrxy5mtq5TueA+RGXiS2yZbif7OJR0EG7TP/rNJxx7nNCDhlAN1FK3qoH
   A==;
X-CSE-ConnectionGUID: EPbnjEvcQwyqZfePpKOU8Q==
X-CSE-MsgGUID: +rCm30i3R86AbXtF6U6awA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28410637"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28410637"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 00:08:19 -0700
X-CSE-ConnectionGUID: vuccogX9Q8GCY1dADEMQhQ==
X-CSE-MsgGUID: Qr4Gmy39QZqU6aPPdNQtSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78494121"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa008.fm.intel.com with ESMTP; 17 Oct 2024 00:08:17 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	brett.creeley@amd.com,
	mateusz.polchlopek@intel.com
Subject: [iwl-next v1] ice: only allow Tx promiscuous for multicast
Date: Thu, 17 Oct 2024 09:08:16 +0200
Message-ID: <20241017070816.189630-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brett Creeley <brett.creeley@intel.com>

Currently when any VF is trusted and true promiscuous mode is enabled on
the PF, the VF will receive all unicast traffic directed to the device's
internal switch. This includes traffic external to the NIC and also from
other VSI (i.e. VFs). This does not match the expected behavior as
unicast traffic should only be visible from external sources in this
case. Disable the Tx promiscuous mode bits for unicast promiscuous mode.

Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Brett Creeley <brett.creeley@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h          |  6 ++---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 23 ++++++++++++++-----
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index d2235e8bfea4..cae5cac74389 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -182,11 +182,9 @@
 #define ice_for_each_chnl_tc(i)	\
 	for ((i) = ICE_CHNL_START_TC; (i) < ICE_CHNL_MAX_TC; (i)++)
 
-#define ICE_UCAST_PROMISC_BITS (ICE_PROMISC_UCAST_TX | ICE_PROMISC_UCAST_RX)
+#define ICE_UCAST_PROMISC_BITS ICE_PROMISC_UCAST_RX
 
-#define ICE_UCAST_VLAN_PROMISC_BITS (ICE_PROMISC_UCAST_TX | \
-				     ICE_PROMISC_UCAST_RX | \
-				     ICE_PROMISC_VLAN_TX  | \
+#define ICE_UCAST_VLAN_PROMISC_BITS (ICE_PROMISC_UCAST_RX | \
 				     ICE_PROMISC_VLAN_RX)
 
 #define ICE_MCAST_PROMISC_BITS (ICE_PROMISC_MCAST_TX | ICE_PROMISC_MCAST_RX)
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 466e44a33c43..2fda7be60fb7 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -2231,17 +2231,27 @@ static bool ice_is_vlan_promisc_allowed(struct ice_vf *vf)
 
 /**
  * ice_vf_ena_vlan_promisc - Enable Tx/Rx VLAN promiscuous for the VLAN
+ * @vf: VF to enable VLAN promisc on
  * @vsi: VF's VSI used to enable VLAN promiscuous mode
  * @vlan: VLAN used to enable VLAN promiscuous
  *
  * This function should only be called if VLAN promiscuous mode is allowed,
  * which can be determined via ice_is_vlan_promisc_allowed().
  */
-static int ice_vf_ena_vlan_promisc(struct ice_vsi *vsi, struct ice_vlan *vlan)
+static int ice_vf_ena_vlan_promisc(struct ice_vf *vf, struct ice_vsi *vsi,
+				   struct ice_vlan *vlan)
 {
-	u8 promisc_m = ICE_PROMISC_VLAN_TX | ICE_PROMISC_VLAN_RX;
+	u8 promisc_m = 0;
 	int status;
 
+	if (test_bit(ICE_VF_STATE_UC_PROMISC, vf->vf_states))
+		promisc_m |= ICE_UCAST_VLAN_PROMISC_BITS;
+	if (test_bit(ICE_VF_STATE_MC_PROMISC, vf->vf_states))
+		promisc_m |= ICE_MCAST_VLAN_PROMISC_BITS;
+
+	if (!promisc_m)
+		return 0;
+
 	status = ice_fltr_set_vsi_promisc(&vsi->back->hw, vsi->idx, promisc_m,
 					  vlan->vid);
 	if (status && status != -EEXIST)
@@ -2260,7 +2270,7 @@ static int ice_vf_ena_vlan_promisc(struct ice_vsi *vsi, struct ice_vlan *vlan)
  */
 static int ice_vf_dis_vlan_promisc(struct ice_vsi *vsi, struct ice_vlan *vlan)
 {
-	u8 promisc_m = ICE_PROMISC_VLAN_TX | ICE_PROMISC_VLAN_RX;
+	u8 promisc_m = ICE_UCAST_VLAN_PROMISC_BITS | ICE_MCAST_VLAN_PROMISC_BITS;
 	int status;
 
 	status = ice_fltr_clear_vsi_promisc(&vsi->back->hw, vsi->idx, promisc_m,
@@ -2415,7 +2425,7 @@ static int ice_vc_process_vlan_msg(struct ice_vf *vf, u8 *msg, bool add_v)
 					goto error_param;
 				}
 			} else if (vlan_promisc) {
-				status = ice_vf_ena_vlan_promisc(vsi, &vlan);
+				status = ice_vf_ena_vlan_promisc(vf, vsi, &vlan);
 				if (status) {
 					v_ret = VIRTCHNL_STATUS_ERR_PARAM;
 					dev_err(dev, "Enable Unicast/multicast promiscuous mode on VLAN ID:%d failed error-%d\n",
@@ -3224,7 +3234,7 @@ ice_vc_add_vlans(struct ice_vf *vf, struct ice_vsi *vsi,
 				return err;
 
 			if (vlan_promisc) {
-				err = ice_vf_ena_vlan_promisc(vsi, &vlan);
+				err = ice_vf_ena_vlan_promisc(vf, vsi, &vlan);
 				if (err)
 					return err;
 			}
@@ -3252,7 +3262,8 @@ ice_vc_add_vlans(struct ice_vf *vf, struct ice_vsi *vsi,
 			 */
 			if (!ice_is_dvm_ena(&vsi->back->hw)) {
 				if (vlan_promisc) {
-					err = ice_vf_ena_vlan_promisc(vsi, &vlan);
+					err = ice_vf_ena_vlan_promisc(vf, vsi,
+								      &vlan);
 					if (err)
 						return err;
 				}
-- 
2.42.0


