Return-Path: <netdev+bounces-240478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26095C75652
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECC1D4EEB2F
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CE36A033;
	Thu, 20 Nov 2025 16:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BrBCunHg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC632369205;
	Thu, 20 Nov 2025 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656102; cv=none; b=OQ7ma+Z7bEH12W02NDFP2ev7KYK4tB0n5c8T7xITruFFm6K5nLQ8e6VpD6wCV0G8v1ZJRsG0TICyUVEU5ceYUOnrzI6lWKzg1PoKCaaNro/+Vb5oaMRroez9kxONALXiL+Mgdsmx3zJGGyx5+WPqMZruQF8khcCWa2CJVO+laRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656102; c=relaxed/simple;
	bh=IlCI9jaErdowTVJH0J3loebUiNFI6chGcjpYkH/hVRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZfWuhT3EX1mXxN0DYV55TyiZLzd0tSgU8sEPD72B7m8I0nF6BaGYOWiSHLY94xIS5F4vwDIfc61a0qsIAeddX8eqZ9ec4+tSoMVyauLIbqxAg5hqgDoaNk5/48JkzioNN4ig5uDOlAPhEGNESqJVP1jPCVDp7Sw1XV4DyCZkkK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BrBCunHg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763656101; x=1795192101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IlCI9jaErdowTVJH0J3loebUiNFI6chGcjpYkH/hVRY=;
  b=BrBCunHgSY7xBNVekBBUbYWpZtsbw+06Mn1Ccd+JtHm8vXen5CJyRpxY
   IhYv4J2tMIK0v63bqeDs9UjY9hhRp5rl3fhdRC4m5JWJaJDlY4syil9UU
   G93HKSvdhAGuIQLhZZxScLXNPslytFZRrtbywBhPXO0hVjgSrHHeOVqHN
   d/7tLlr45UHBHiZCGY0OaODMrwN59IS96FkdZeCGm9/V2UIISg78N/tAw
   PRhNUPm4Y1WreoOAth4CcYjrl5G+kAYg84pA4DrOA6lBNefCHmzvcMoS/
   3DBv0QDybcxwXo5yqKd3G0QTKilZFs/wzkoV77hdKfBoZhzqsVXe0gKUB
   Q==;
X-CSE-ConnectionGUID: RMUHXwZXTJOQeXZzSfHXww==
X-CSE-MsgGUID: ilTSVWlWSxCIRQeSubTdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69599289"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69599289"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:28:20 -0800
X-CSE-ConnectionGUID: LTFylGsoRDiOnwfTmwZHoQ==
X-CSE-MsgGUID: DbeerV+WTZiNFO1gv6/IeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191531285"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 08:28:19 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com
Subject: [PATCH iwl-next 2/8] ice: allow creating mac,vlan filters along mac filters
Date: Thu, 20 Nov 2025 17:28:07 +0100
Message-ID: <20251120162813.37942-3-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120162813.37942-1-jakub.slepecki@intel.com>
References: <20251120162813.37942-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

Among other uses, MAC filters are currently used to forward loopback
traffic between VSIs.  However, they only match destination MAC addresses
making them prone to mistakes when handling traffic within multiple
VLANs and especially across the boundaries.

This patch allows the driver to create MAC,VLAN filters in the same
flow as MAC-only filters completely interchangeably.  This is intended
to be used to forward the loopback traffic only within the boundaries
of particular VLANs.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 48 ++++++++++++++++-----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 84848f0123e7..0275e2910c6b 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3606,6 +3606,29 @@ bool ice_vlan_fltr_exist(struct ice_hw *hw, u16 vlan_id, u16 vsi_handle)
 	return false;
 }
 
+/**
+ * ice_fltr_mac_address - Find MAC in filter
+ * @dst: output MAC address
+ * @info: information struct for the filter in question
+ *
+ * Return: 0 for success, %-ENXIO if no address was found in the filter
+ * information.
+ */
+static
+int ice_fltr_mac_address(u8 *dst, struct ice_fltr_info *info)
+{
+	switch (info->lkup_type) {
+	case ICE_SW_LKUP_MAC:
+		ether_addr_copy(dst, info->l_data.mac.mac_addr);
+		return 0;
+	case ICE_SW_LKUP_MAC_VLAN:
+		ether_addr_copy(dst, info->l_data.mac_vlan.mac_addr);
+		return 0;
+	default:
+		return -ENXIO;
+	}
+}
+
 /**
  * ice_add_mac - Add a MAC address based filter rule
  * @hw: pointer to the hardware structure
@@ -3614,16 +3637,19 @@ bool ice_vlan_fltr_exist(struct ice_hw *hw, u16 vlan_id, u16 vsi_handle)
 int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 {
 	struct ice_fltr_list_entry *m_list_itr;
-	int status = 0;
+	int err;
 
 	if (!m_list || !hw)
 		return -EINVAL;
 
 	list_for_each_entry(m_list_itr, m_list, list_entry) {
-		u8 *add = &m_list_itr->fltr_info.l_data.mac.mac_addr[0];
+		u8 addr[ETH_ALEN];
 		u16 vsi_handle;
 		u16 hw_vsi_id;
 
+		err = ice_fltr_mac_address(addr, &m_list_itr->fltr_info);
+		if (err || is_zero_ether_addr(addr))
+			return -EINVAL;
 		m_list_itr->fltr_info.flag = ICE_FLTR_TX;
 		vsi_handle = m_list_itr->fltr_info.vsi_handle;
 		if (!ice_is_vsi_valid(hw, vsi_handle))
@@ -3634,17 +3660,19 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 		if (m_list_itr->fltr_info.src_id != ICE_SRC_ID_VSI)
 			return -EINVAL;
 		m_list_itr->fltr_info.src = hw_vsi_id;
-		if (m_list_itr->fltr_info.lkup_type != ICE_SW_LKUP_MAC ||
-		    is_zero_ether_addr(add))
+		if (m_list_itr->fltr_info.lkup_type != ICE_SW_LKUP_MAC &&
+		    m_list_itr->fltr_info.lkup_type != ICE_SW_LKUP_MAC_VLAN)
 			return -EINVAL;
 
-		m_list_itr->status = ice_add_rule_internal(hw, ICE_SW_LKUP_MAC,
-							   m_list_itr);
+		m_list_itr->status =
+			ice_add_rule_internal(hw,
+					      m_list_itr->fltr_info.lkup_type,
+					      m_list_itr);
 		if (m_list_itr->status)
 			return m_list_itr->status;
 	}
 
-	return status;
+	return 0;
 }
 
 /**
@@ -4055,7 +4083,7 @@ int ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
 		enum ice_sw_lkup_type l_type = list_itr->fltr_info.lkup_type;
 		u16 vsi_handle;
 
-		if (l_type != ICE_SW_LKUP_MAC)
+		if (l_type != ICE_SW_LKUP_MAC && l_type != ICE_SW_LKUP_MAC_VLAN)
 			return -EINVAL;
 
 		vsi_handle = list_itr->fltr_info.vsi_handle;
@@ -4066,7 +4094,7 @@ int ice_remove_mac(struct ice_hw *hw, struct list_head *m_list)
 					ice_get_hw_vsi_num(hw, vsi_handle);
 
 		list_itr->status = ice_remove_rule_internal(hw,
-							    ICE_SW_LKUP_MAC,
+							    l_type,
 							    list_itr);
 		if (list_itr->status)
 			return list_itr->status;
@@ -4507,6 +4535,7 @@ ice_remove_vsi_lkup_fltr(struct ice_hw *hw, u16 vsi_handle,
 
 	switch (lkup) {
 	case ICE_SW_LKUP_MAC:
+	case ICE_SW_LKUP_MAC_VLAN:
 		ice_remove_mac(hw, &remove_list_head);
 		break;
 	case ICE_SW_LKUP_VLAN:
@@ -4516,7 +4545,6 @@ ice_remove_vsi_lkup_fltr(struct ice_hw *hw, u16 vsi_handle,
 	case ICE_SW_LKUP_PROMISC_VLAN:
 		ice_remove_promisc(hw, lkup, &remove_list_head);
 		break;
-	case ICE_SW_LKUP_MAC_VLAN:
 	case ICE_SW_LKUP_ETHERTYPE:
 	case ICE_SW_LKUP_ETHERTYPE_MAC:
 	case ICE_SW_LKUP_DFLT:
-- 
2.43.0


