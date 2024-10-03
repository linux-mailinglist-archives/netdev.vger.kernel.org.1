Return-Path: <netdev+bounces-131784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C03A98F91A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7C522826E0
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 21:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451EC1C9B68;
	Thu,  3 Oct 2024 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JgZb4LvO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911B1C7B6C;
	Thu,  3 Oct 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727991766; cv=none; b=bp9Eg4iHQUzWrAh+DJSVI1XGGCjNF/vugYUYteOkfTnl2xezRBtFumrmqcYOuBRSyJsJd8pwburUYC9TVIEUxtiGHNKDisVikR+tmmwgltTwMVjB/gqTmMbIN0Z6p+Z526S2JA+JD/wpeCqdQ0lJqd962+kdJppL9sVE70nzOeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727991766; c=relaxed/simple;
	bh=Lbp7yzL8xfWt8fCeDqPeZd+44YzF/aSgFZHHQtkLWLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qj0BHBKpDGz7aP9ThduKd7/iPlCnenaT4iLYYrbZoRldjc/MK52nEWbkFwheOl9CmCLKWRFvw+UZYZ/vuM8aGOB1RmttQxH/f0YZDhPCZOic4EqYATBAsHVvQk0hgj7HAZpMFDdB2QtbEluTQg92mOjho3k3ixK5de6SHME+XcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JgZb4LvO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727991764; x=1759527764;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lbp7yzL8xfWt8fCeDqPeZd+44YzF/aSgFZHHQtkLWLU=;
  b=JgZb4LvOxtO+V5ab9Br/RDQuUsb4jO1ds0qdkf2m47dSt3RAjdX7RPo5
   mSdaRxL11KHzf7/BDn4gksIEREFt+AF87K9seJglqi6dcnNtAoL29agKU
   LcNCFXvSNRHzMDZg1fdClU2RzD8aTsZJgszTANq6E+XSZ08sJ9E6rJnbu
   Q2+sfVnd/NiANOrDlo/dDP2e1dYkwLhk1bv68t1MwrwoOeGH6jbHmJ/HT
   F7F0RpXwgMop4QWfSa7LZgnpNmWcxkKKqEdujewO01LseoRjf8/VX87hV
   hVG4La5o0lOEqiJxxxBXjnDSTomXX8K7xE5ItN42FW1Dm8dDNyx5+Wgsl
   w==;
X-CSE-ConnectionGUID: 5nW+vsoTTAiye6YPy3YSdQ==
X-CSE-MsgGUID: GviciZvPRbSHH0FkqajcOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="27379839"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="27379839"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 14:42:44 -0700
X-CSE-ConnectionGUID: wFn8wlcUQD6Z7LqOJmOnyw==
X-CSE-MsgGUID: xTVehHqwShqSf+bp38GKRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="111952998"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by orviesa001.jf.intel.com with ESMTP; 03 Oct 2024 14:42:41 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [RFC PATCH 2/2] ice: ptp: add control over HW timestamp latch point
Date: Thu,  3 Oct 2024 23:37:54 +0200
Message-Id: <20241003213754.926691-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>
References: <20241003213754.926691-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement ptp HW timestamp latch points callbacks, allow user to control
the latch point of ptp timestamps in E825 devices.

Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 48 +++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 52 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  3 +-
 3 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index ef2e858f49bb..b37374dc7daf 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2494,6 +2494,50 @@ ice_ptp_setup_pins_e823(struct ice_pf *pf, struct ptp_clock_info *info)
 	info->n_ext_ts = 1;
 }
 
+/**
+ * ice_get_ts_point - get the tx timestamp latch point
+ * @info: the driver's PTP info structure
+ * @point: return the configured tx timestamp latch point
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int
+ice_get_ts_point(struct ptp_clock_info *info, enum ptp_ts_point *point)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_hw *hw = &pf->hw;
+	bool sfd_ena;
+	int ret;
+
+	ice_ptp_lock(hw);
+	ret = ice_ptp_hw_ts_point_get(hw, &sfd_ena);
+	ice_ptp_unlock(hw);
+	if (!ret)
+		*point = sfd_ena ? PTP_TS_POINT_SFD : PTP_TS_POINT_POST_SFD;
+
+	return ret;
+}
+
+/**
+ * ice_set_ts_point - set the tx timestamp latch point
+ * @info: the driver's PTP info structure
+ * @point: requested tx timestamp latch point
+ */
+static int
+ice_set_ts_point(struct ptp_clock_info *info, enum ptp_ts_point point)
+{
+	bool sfd_ena = point == PTP_TS_POINT_SFD ? true : false;
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_hw *hw = &pf->hw;
+	int ret;
+
+	ice_ptp_lock(hw);
+	ret = ice_ptp_hw_ts_point_set(hw, sfd_ena);
+	ice_ptp_unlock(hw);
+
+	return ret;
+}
+
 /**
  * ice_ptp_set_funcs_e82x - Set specialized functions for E82x support
  * @pf: Board private structure
@@ -2512,6 +2556,10 @@ ice_ptp_set_funcs_e82x(struct ice_pf *pf, struct ptp_clock_info *info)
 	    boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ))
 		info->getcrosststamp = ice_ptp_getcrosststamp_e82x;
 #endif /* CONFIG_ICE_HWTS */
+	if (ice_is_e825c(&pf->hw)) {
+		info->set_ts_point = ice_set_ts_point;
+		info->get_ts_point = ice_get_ts_point;
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a33e6b9b313..65a31c1bc335 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -6220,3 +6220,55 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 
 	return 0;
 }
+
+/**
+ * ice_ptp_hw_ts_point_get - check if tx timestamping is latched on/post SFD
+ * @hw: pointer to the HW struct
+ * @sfd_ena: on success true if tx timestamping latched at beginning of SFD,
+ *	false if post sfd
+ *
+ * Return: 0 on success, negative on error
+ */
+int ice_ptp_hw_ts_point_get(struct ice_hw *hw, bool *sfd_ena)
+{
+	u8 port = hw->port_info->lport;
+	u32 val;
+	int err;
+
+	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	if (err)
+		return err;
+	if (val | PHY_MAC_XIF_TS_SFD_ENA_M)
+		*sfd_ena = true;
+	else
+		*sfd_ena = false;
+
+	return err;
+}
+
+/**
+ * ice_ptp_hw_tx_ts_point_set - configure timestamping on/post SFD
+ * @hw: pointer to the HW struct
+ * @sfd_ena: true to enable timestamping at beginning of SFD, false post sfd
+ *
+ * Configure timestamping to measure at the beginning/post SFD
+ * (start frame delimiter).
+ */
+int ice_ptp_hw_ts_point_set(struct ice_hw *hw, bool sfd_ena)
+{
+	u8 port = hw->port_info->lport;
+	int err, val;
+
+	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	if (err)
+		return err;
+	if ((val | PHY_MAC_XIF_TS_SFD_ENA_M && sfd_ena) ||
+	    (!(val | PHY_MAC_XIF_TS_SFD_ENA_M) && !sfd_ena))
+		return -EINVAL;
+	if (sfd_ena)
+		val |= PHY_MAC_XIF_TS_SFD_ENA_M;
+	else
+		val &= ~PHY_MAC_XIF_TS_SFD_ENA_M;
+
+	return ice_write_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, val);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 0852a34ade91..3cfe7431c1b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -346,7 +346,8 @@ void ice_ptp_init_hw(struct ice_hw *hw);
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
 int ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
 			 enum ice_ptp_tmr_cmd configured_cmd);
-
+int ice_ptp_hw_ts_point_get(struct ice_hw *hw, bool *sfd_ena);
+int ice_ptp_hw_ts_point_set(struct ice_hw *hw, bool sfd_ena);
 /* E822 family functions */
 int ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val);
 int ice_write_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 val);
-- 
2.38.1


