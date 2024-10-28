Return-Path: <netdev+bounces-139671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E99B3C55
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 21:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4400281567
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777311E261C;
	Mon, 28 Oct 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYI021gZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149341E0488;
	Mon, 28 Oct 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730148773; cv=none; b=fi0irVG8b36EmrLZtVLGLQ95OIjVuJhrACxPYWosrFfKod7bz1GlEMGaL6rtkEPNH8WjTG5T22PEm9sBCCK5PIcsMcdNYIMC+2V4UqiWvdfbOqZGrJ4xmxVWp5b8aMXRMpDsH0fyhIhD7thCsqEih601UdlqVmgRY49Ro90sDgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730148773; c=relaxed/simple;
	bh=vHG/+J/Ny1T7zqLJ8jL0QkIvOQIbMwElsaBVWkJ8TE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sOvvHsucDmje1N/NP2r/lbmt1zl6Y+73KWD/MY92RiI+01zugnyFVXSKR+NyOKht7NdpGUD8VJu/d+GekBAordhmEvfds3GQDEIcq3DDHFOdeX2kc+jc0iQkWZ3tOwyMqnYycIG4yI7VA8TKUEioJerxzhzBqlqPXQkufTEp0YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYI021gZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730148771; x=1761684771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vHG/+J/Ny1T7zqLJ8jL0QkIvOQIbMwElsaBVWkJ8TE0=;
  b=ZYI021gZbXrL/VF8vCHDb6XDnuOdYrc4ddQ8ldM7Y4FmAkxbhb7odjUE
   s0Y4uB1wiP5+x552ppIwtf1ecCdMKkBzhZCbFJhOhxyz/pIXNM0Fh8JJe
   tX401Xb6xE5gKGnh6kxFtoik+ydKTLrS6zBebzbr/nMhiu3YocBibAS5x
   te3cMzkWaxRkdfnnuHArAAnmBg2SmNfxCImUwzae+Ivp2pR4WDKK9r3CP
   XBGDsdNdGR5TkWOImFDPv5EbANIY59Uh6WN9jxbDoyyCO39iyxOoLmmnx
   Qvh+IMBQNbtYG70+5DEwnE2fsDdAhiPkChvhFSBkJeygYP2YsmogtU1tj
   g==;
X-CSE-ConnectionGUID: 0/A+BVJIQDamiYjr8TAfeg==
X-CSE-MsgGUID: Ion3G/aaS5aZLr1wSFoCZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="40343553"
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="40343553"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 13:52:51 -0700
X-CSE-ConnectionGUID: T4e4+usLSCu1OmxFOt4zkQ==
X-CSE-MsgGUID: Gl2bQ5h/TkGmiEFrgHdOVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,240,1725346800"; 
   d="scan'208";a="81358574"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2024 13:52:48 -0700
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
Subject: [PATCH net-next v2 2/2] ice: ptp: add control over HW timestamp latch point
Date: Mon, 28 Oct 2024 21:47:55 +0100
Message-Id: <20241028204755.1514189-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241028204755.1514189-1-arkadiusz.kubalewski@intel.com>
References: <20241028204755.1514189-1-arkadiusz.kubalewski@intel.com>
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
* 0 - timestamp latched by PHY at the beginning of SFD,
* 1 - timestamp latched by PHY after the SFD,
* None - callback returns error to the user.

** Configure timestamp latch point at the beginning of SFD:
$ echo 0 > /sys/class/net/eth<N>/device/ptp/ts_point

** Configure timestamp latch point after the SFD:
$ echo 1 > /sys/class/net/eth<N>/device/ptp/ts_point

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
v2:
- add kernel doc return description on ice_get_ts_point(..),
- use enum ptp_ts_point directly, instead of additional bool to pass tx
  timestamp latch point from userspace callback up to ptp_hw
  configuration,
- fix bit logic.
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 44 +++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 59 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 3 files changed, 105 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a999fface272..21fc6b5e2d69 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2509,6 +2509,48 @@ static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
 	return 0;
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
+ * ice_set_ts_point - set the tx timestamp latch point
+ * @info: the driver's PTP info structure
+ * @point: requested tx timestamp latch point
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int
+ice_set_ts_point(struct ptp_clock_info *info, enum ptp_ts_point point)
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
index da88c6ccfaeb..0d2d3e36341e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -6303,3 +6303,62 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 
 	return 0;
 }
+
+/**
+ * ice_ptp_hw_ts_point_get - check if tx timestamping is latched on/post SFD
+ * @hw: pointer to the HW struct
+ * @point: return the configured tx timestamp latch point
+ *
+ * Verify if HW timestamping point is configured to measure at the beginning or
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
+ * @point: requested tx timestamp latch point
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
+	if ((val & PHY_MAC_XIF_TS_SFD_ENA_M && point == PTP_TS_POINT_SFD) ||
+	    (!(val & PHY_MAC_XIF_TS_SFD_ENA_M) &&
+	     point == PTP_TS_POINT_POST_SFD))
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
index 656daff3447e..f8e495b82653 100644
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


