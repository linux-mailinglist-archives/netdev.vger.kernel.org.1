Return-Path: <netdev+bounces-241440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1E0C8402D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 09:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C11E334DB8D
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D4330214E;
	Tue, 25 Nov 2025 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q1osl69p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595D3019BA;
	Tue, 25 Nov 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764059715; cv=none; b=Ujdx/NzA/Lew69MaVTkz/YNZxnSK/XIKWsOGdjSpgWJ3tDkqr1cSlGf650rAqzrGYurAhnu9Lb9+W5rgESRTdPEryv/iKegox+PPNyJLMN+DXTbHHZUE7W9s8Gbg+w5PQNiK2GfWzz6wviHFsQEwjpzH/JCC06CyX2cBZdcbP3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764059715; c=relaxed/simple;
	bh=QnuibCi06y3kAvMvHiJfgcBcNmBpeHEyvC1u7Dlu7c0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Alhm1tCBPnYQecqxgZ8z2OgT+UsfcQsrsH98uT203qUKGaaDg+AtuMKYQmRl9LnWOMbLdZSk/1cnu8Wx/VpUQ4iVf0J/ymqnFynf+/9OPGHfsyiR2eoOCb8Iun7cNJZm8J6WsEtWLVLoM5yBREZNkY56eRhh4eyug4aO9j7jkD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q1osl69p; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764059713; x=1795595713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QnuibCi06y3kAvMvHiJfgcBcNmBpeHEyvC1u7Dlu7c0=;
  b=Q1osl69pSBxaY9DGo4WNnXGEN4BX9SSHehvHzsO/huxu8ZiLJ+H4fJk9
   KtQCLfKzpqZG1PKanC/HjEOqiuTXbTG5DOIAssGTBLRRbiLKfLbiSIDxM
   I2HkiUU8YFc/0CpOf4hSmCD1X9iHH4nKXRFQU4JrPDNfTGJEEeq1aAC45
   R/AcumMuzY3GqDRq+BhElBDh1YggKDb8HjLszPKBLN37hz3fSzQS2UHqg
   c93N/JfRkBDJzCYUEtGGwlJ2Z4T+0cnOWMH5alOcmFifbrWbgpUTuIegY
   2V1zpKHlXAeKbKfcFl67sU/g7EilkIJLeMdiUHX+/bFV7z6d7R+aU5/OE
   w==;
X-CSE-ConnectionGUID: 5NbYSHs1SyOqoSJ/GIP1ww==
X-CSE-MsgGUID: oEVAh+QDRsGBWeULSbTr/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76694460"
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="76694460"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2025 00:35:13 -0800
X-CSE-ConnectionGUID: tqGKKAbVTjKPW88qtD1oyQ==
X-CSE-MsgGUID: EjLNB/d4QriELPvLsODJAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,225,1758610800"; 
   d="scan'208";a="196749941"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa003.jf.intel.com with ESMTP; 25 Nov 2025 00:35:11 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v2 6/8] ice: add functions to query for vsi's pvids
Date: Tue, 25 Nov 2025 09:34:54 +0100
Message-ID: <20251125083456.28822-7-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125083456.28822-1-jakub.slepecki@intel.com>
References: <20251125083456.28822-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

PVID information is set across two structs and several members depending
primarily on DVM support and VSI type.  This commit adds function that
guess whether PVID is set and where and allow to access raw VLAN ID set.
This is intended to be used later on to decide what MAC{,VLAN} filters
to set for a VSI.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
No changes in v2.
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 56 ++++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_lib.h |  2 +
 2 files changed, 58 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 44f3c2bab308..55ba043f8f5e 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -4059,3 +4059,59 @@ void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel)
 		wr32(hw, qrx_context_offset, regval);
 	}
 }
+
+/**
+ * ice_vsi_has_outer_pvid - check if VSI has outer Port VLAN ID assigned
+ * @info: props of VSI in question
+ *
+ * Return: true if VSI has outer PVID, false otherwise.
+ */
+static bool
+ice_vsi_has_outer_pvid(const struct ice_aqc_vsi_props *info)
+{
+	return info->outer_vlan_flags & ICE_AQ_VSI_OUTER_VLAN_PORT_BASED_INSERT;
+}
+
+/**
+ * ice_vsi_has_inner_pvid - check if VSI has inner Port VLAN ID assigned
+ * @info: props of VSI in question
+ *
+ * Return: true if VSI has inner PVID, false otherwise.
+ */
+static bool
+ice_vsi_has_inner_pvid(const struct ice_aqc_vsi_props *info)
+{
+	return info->inner_vlan_flags & ICE_AQ_VSI_INNER_VLAN_INSERT_PVID;
+}
+
+/**
+ * ice_vsi_has_pvid - check if VSI has Port VLAN ID assigned
+ * @vsi: VSI in question
+ *
+ * Return: true if VSI has either outer or inner PVID, false otherwise.
+ */
+bool
+ice_vsi_has_pvid(struct ice_vsi *vsi)
+{
+	return ice_vsi_has_outer_pvid(&vsi->info) ||
+	       ice_vsi_has_inner_pvid(&vsi->info);
+}
+
+/**
+ * ice_vsi_pvid - retrieve VSI's Port VLAN ID
+ * @vsi: VSI in question
+ *
+ * Return: VSI's PVID; it is valid only if ice_vsi_has_pvid is true.
+ */
+u16
+ice_vsi_pvid(struct ice_vsi *vsi)
+{
+	__le16 vlan_info = 0;
+
+	if (ice_vsi_has_outer_pvid(&vsi->info))
+		vlan_info = vsi->info.port_based_outer_vlan;
+	else if (ice_vsi_has_inner_pvid(&vsi->info))
+		vlan_info = vsi->info.port_based_inner_vlan;
+
+	return le16_to_cpu(vlan_info) & VLAN_VID_MASK;
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 2cb1eb98b9da..c28c69963946 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -124,4 +124,6 @@ void ice_clear_feature_support(struct ice_pf *pf, enum ice_feature f);
 void ice_init_feature_support(struct ice_pf *pf);
 bool ice_vsi_is_rx_queue_active(struct ice_vsi *vsi);
 void ice_vsi_update_l2tsel(struct ice_vsi *vsi, enum ice_l2tsel l2tsel);
+bool ice_vsi_has_pvid(struct ice_vsi *vsi);
+u16 ice_vsi_pvid(struct ice_vsi *vsi);
 #endif /* !_ICE_LIB_H_ */
-- 
2.43.0


