Return-Path: <netdev+bounces-142167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FBE9BDB03
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8715B2159D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13E01891AA;
	Wed,  6 Nov 2024 01:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOovRyxm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741F188737;
	Wed,  6 Nov 2024 01:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855568; cv=none; b=V03p4Ag2GvXJRD8uWerBC5FKkMKhrGD/ukLHCpI+lQtsszAmfbJ1D6whSaezogUfi1J6UcAGZ8Qc0XlKwaZuXeWecTEh4RIjKC0BqcY0l8/KqVycwUJ1DRYmF39xe+hcYgFxrhAiUhc/ke8oIBmazqX5qNse0sOLUtdJDvh0eig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855568; c=relaxed/simple;
	bh=4HF3rwA/AvxO3Knhf+XcS3MMF6XDQAoU3kzYc67y7fw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MElsk5tUoZNxRM4C9HwZaTeSxw7fdfjFlx8mDn0OdXIlnMYVcQMJk01etTPzaiXy2KJRUJ8MNa+/nlRlzZoQgZHUhOwTyJWxUKP1WoMkuXphE+AxjNxojw9k3qWEpzPUHyYHyK1nUn93oCYyjLm+C9py1jpo69fYDg5iVhRMkXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOovRyxm; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730855567; x=1762391567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4HF3rwA/AvxO3Knhf+XcS3MMF6XDQAoU3kzYc67y7fw=;
  b=gOovRyxmE0qQBXomfWWopldou2NQeFXPjdKtENpjyNxC3cyOlu+t7lDD
   F4ElqBm2+jrbcSW3ZFQPtcFmtcYKwEffoxWegl6HXuIdgw587LU2cJqA1
   kAzZ1HxL2yEX7jpGMZgnw68cWDHSgK6oLD0E8J50wr4V2nfTUfI4b+q+N
   i6JqS7bMlaXp6V8SwrlPMPT9TVY0C0R3i3+OIOltmRobU8etM8iah50qm
   aPmukA35bHWdeTs/KYNmfQvQmue/slf0rsrbPEHUBszoY6GZTw451kfV7
   eVIULZfGA76WOcLjUcDq3McBLGwGqTy4uI06m+VMN6MMBHS9WvJAi6HCU
   g==;
X-CSE-ConnectionGUID: UCYtPL2nShyI+Sk5Ia2a1w==
X-CSE-MsgGUID: xZ1H1HrfSYGNI8y/jAPaHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="18254765"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="18254765"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 17:12:46 -0800
X-CSE-ConnectionGUID: xEOV3UogSKqou3OpRiUuqg==
X-CSE-MsgGUID: 93TWSWv/Rb6U/eR9zWtyRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84362797"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa008.fm.intel.com with ESMTP; 05 Nov 2024 17:12:43 -0800
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
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v3 2/2] ice: ptp: add control over HW timestamp latch point
Date: Wed,  6 Nov 2024 02:07:56 +0100
Message-Id: <20241106010756.1588973-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
References: <20241106010756.1588973-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to control the latch point of ptp HW timestamps in E825
devices.

Usage, examples:

** Obtain current state:
$ cat /sys/class/net/eth<N>/device/ptp/ts_point
Command returns enum/integer:
* 1 - timestamp latched by PHY at the beginning of SFD,
* 2 - timestamp latched by PHY after the SFD,
* None - callback returns error to the user.

** Configure timestamp latch point at the beginning of SFD:
$ echo 1 > /sys/class/net/eth<N>/device/ptp/ts_point

** Configure timestamp latch point after the SFD:
$ echo 2 > /sys/class/net/eth<N>/device/ptp/ts_point

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v3:
- improve readability, for "nothing to do" logic
- /s/PTP/ptp
- remove 'tx' from docs description
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 44 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 60 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 3 files changed, 106 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a999fface272..c351c9707394 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2509,6 +2509,48 @@ static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
 	return 0;
 }
 
+/**
+ * ice_get_ts_point - get the timestamp latch point
+ * @info: the driver's ptp info structure
+ * @point: returns the configured timestamp latch point
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int ice_get_ts_point(struct ptp_clock_info *info,
+			    enum ptp_ts_point *point)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_hw *hw = &pf->hw;
+	int ret;
+
+	ice_ptp_lock(hw);
+	ret = ice_ptp_hw_ts_point_get(hw, point);
+	ice_ptp_unlock(hw);
+
+	return ret;
+}
+
+/**
+ * ice_set_ts_point - set the timestamp latch point
+ * @info: the driver's ptp info structure
+ * @point: requested timestamp latch point
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int ice_set_ts_point(struct ptp_clock_info *info,
+			    enum ptp_ts_point point)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_hw *hw = &pf->hw;
+	int ret;
+
+	ice_ptp_lock(hw);
+	ret = ice_ptp_hw_ts_point_set(hw, point);
+	ice_ptp_unlock(hw);
+
+	return ret;
+}
+
 /**
  * ice_ptp_set_funcs_e82x - Set specialized functions for E82X support
  * @pf: Board private structure
@@ -2529,6 +2571,8 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 	if (ice_is_e825c(&pf->hw)) {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
 		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+		pf->ptp.info.set_ts_point = ice_set_ts_point;
+		pf->ptp.info.get_ts_point = ice_get_ts_point;
 	} else {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
 		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index dfd49732bd5b..06c32f180932 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -6320,3 +6320,63 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 
 	return 0;
 }
+
+/**
+ * ice_ptp_hw_ts_point_get - check if timestamps are latched on/post SFD
+ * @hw: pointer to the HW struct
+ * @point: return the configured timestamp latch point
+ *
+ * Verify if HW timestamping point is configured to latch at the beginning or
+ * post of SFD (Start of Frame Delimiter)
+ *
+ * Return: 0 on success, negative on error
+ */
+int ice_ptp_hw_ts_point_get(struct ice_hw *hw, enum ptp_ts_point *point)
+{
+	u8 port = hw->port_info->lport;
+	u32 val;
+	int err;
+
+	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	if (err)
+		return err;
+	if (val & PHY_MAC_XIF_TS_SFD_ENA_M)
+		*point = PTP_TS_POINT_SFD;
+	else
+		*point = PTP_TS_POINT_POST_SFD;
+
+	return err;
+}
+
+/**
+ * ice_ptp_hw_ts_point_set - configure timestamping on/post SFD
+ * @hw: pointer to the HW struct
+ * @point: requested timestamp latch point
+ *
+ * Configure timestamping to measure at the beginning/post SFD (Start of Frame
+ * Delimiter)
+ *
+ * Return: 0 on success, negative on error
+ */
+int ice_ptp_hw_ts_point_set(struct ice_hw *hw, enum ptp_ts_point point)
+{
+	u8 port = hw->port_info->lport;
+	int err, val;
+
+	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	if (err)
+		return err;
+	if ((val & PHY_MAC_XIF_TS_SFD_ENA_M) && point == PTP_TS_POINT_SFD)
+		return -EINVAL;
+	if (!(val & PHY_MAC_XIF_TS_SFD_ENA_M) &&
+	    point == PTP_TS_POINT_POST_SFD)
+		return -EINVAL;
+	if (point == PTP_TS_POINT_SFD)
+		val |= PHY_MAC_XIF_TS_SFD_ENA_M;
+	else if (point == PTP_TS_POINT_POST_SFD)
+		val &= ~PHY_MAC_XIF_TS_SFD_ENA_M;
+	else
+		return -EINVAL;
+
+	return ice_write_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, val);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 47af7c5c79b8..5e4edaee063e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -348,6 +348,8 @@ void ice_ptp_init_hw(struct ice_hw *hw);
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
 int ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
 			 enum ice_ptp_tmr_cmd configured_cmd);
+int ice_ptp_hw_ts_point_get(struct ice_hw *hw, enum ptp_ts_point *point);
+int ice_ptp_hw_ts_point_set(struct ice_hw *hw, enum ptp_ts_point point);
 
 /* E822 family functions */
 int ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val);
-- 
2.38.1


