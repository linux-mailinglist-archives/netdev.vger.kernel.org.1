Return-Path: <netdev+bounces-108493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F024B923F57
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6648C1F22E0E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1861B580F;
	Tue,  2 Jul 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdWA3dCr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A46519F49D
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927914; cv=none; b=TtEwMtKlxeydiSXau05e66q+lYoiZh0xv1G73FLkA+XdV73FMGtlci7QqWqKP00LcU7m7Z8Sk7BOLBWWMLgUUT3FAw7+EhhZhNBBHBYo00AqvyQxlwaDP6jcFtu/7r1NuoOn/1Z7adKauQnXlI79acbxlUdDn0u73ldum/HKFP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927914; c=relaxed/simple;
	bh=7SFDDXFpHqGUQddHeHjcsdcr2pOj5KTCvACLolxvAm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ssfjf7RpDVlsQtnUi3ylgf2riCODlxecJrs7IIbBnkhxED8eJxJRKnBd92ft3FsJlGHd9AOfyXVBBDiDQY1Ht+o87gxauLxV7FCfurAlvtXf3ixmVDnmnLDhC0AQpB302+OMWjXt2FjbWngdvOAyBCk3dx86JoGQ0wUFEvnorbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdWA3dCr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719927913; x=1751463913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7SFDDXFpHqGUQddHeHjcsdcr2pOj5KTCvACLolxvAm0=;
  b=bdWA3dCrDb1n5U3KyXAtWQ7jtf2I5FqADlvfTvWGIBxyDABWvnc2PzZI
   QsdkNcquwbqVWk/6SwEYhFRsh9E11RiCYk9sVMvD2J3FA8iuT5bCqe0GU
   Xk/lSl8KYcPFJEBM6++VrdMHuMI2zdv4s4hA7IH9kM7q+KL3npBtmtvtR
   hJy4Eorr+ynqSbIj5rRsLOI3ZhN9Q/o8hxW7D+CmxdBO0z41QdhnMJm3L
   Yi58bawd8QNdZ2rEVNYhgaG/q5rdaFgquAZEBBvQfbAKb6zB/duYuf7Mw
   H/pWj/a5fPzQLN4L+/0VCdK4YTyc880Zy9Hj6pubuvFS1WXKz9wVYugtK
   w==;
X-CSE-ConnectionGUID: jMwi5nr1TziHVzilwRPD5Q==
X-CSE-MsgGUID: DntyPZ41QEy2Xaiuunho8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16826455"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16826455"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:45:13 -0700
X-CSE-ConnectionGUID: OOUin8nsR7C+CGKVloLV0A==
X-CSE-MsgGUID: qW/DPDclTjW8iI3vIYrU2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="83460586"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.132])
  by orviesa001.jf.intel.com with ESMTP; 02 Jul 2024 06:45:10 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 7/7] ice: Enable 1PPS out from CGU for E825C products
Date: Tue,  2 Jul 2024 15:41:36 +0200
Message-ID: <20240702134448.132374-16-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702134448.132374-9-karol.kolacinski@intel.com>
References: <20240702134448.132374-9-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Temerkhanov <sergey.temerkhanov@intel.com>

Implement configuring 1PPS signal output from CGU. Use maximal amplitude
because Linux PTP pin API does not have any way for user to set signal
level.

This change is necessary for E825C products to properly output any
signal from 1PPS pin.

Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
---
V1 -> V2: Added return value description, renamed the function and
          enable parameter. Reworded commit message.

 drivers/net/ethernet/intel/ice/ice_ptp.c    | 10 +++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 23 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  1 +
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index e324d96c34c6..11fbf2bbcae7 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -4,6 +4,7 @@
 #include "ice.h"
 #include "ice_lib.h"
 #include "ice_trace.h"
+#include "ice_cgu_regs.h"
 
 static const char ice_pin_names[][64] = {
 	"SDP0",
@@ -1709,6 +1710,15 @@ static int ice_ptp_write_perout(struct ice_hw *hw, unsigned int chan,
 	/* 0. Reset mode & out_en in AUX_OUT */
 	wr32(hw, GLTSYN_AUX_OUT(chan, tmr_idx), 0);
 
+	if (ice_is_e825c(hw)) {
+		int err;
+
+		/* Enable/disable CGU 1PPS output for E825C */
+		err = ice_cgu_cfg_pps_out(hw, !!period);
+		if (err)
+			return err;
+	}
+
 	/* 1. Write perout with half of required period value.
 	 * HW toggles output when source clock hits the TGT and then adds
 	 * GLTSYN_CLKO value to the target, so it ends up with 50% duty cycle.
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 07ecf2a86742..6dff422b7f4e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -661,6 +661,29 @@ static int ice_cfg_cgu_pll_e825c(struct ice_hw *hw,
 	return 0;
 }
 
+#define ICE_ONE_PPS_OUT_AMP_MAX 3
+
+/**
+ * ice_cgu_cfg_pps_out - Configure 1PPS output from CGU
+ * @hw: pointer to the HW struct
+ * @enable: true to enable 1PPS output, false to disable it
+ *
+ * Return: 0 on success, other negative error code when CGU read/write failed
+ */
+int ice_cgu_cfg_pps_out(struct ice_hw *hw, bool enable)
+{
+	union nac_cgu_dword9 dw9;
+	int err;
+
+	err = ice_read_cgu_reg_e82x(hw, NAC_CGU_DWORD9, &dw9.val);
+	if (err)
+		return err;
+
+	dw9.one_pps_out_en = enable;
+	dw9.one_pps_out_amp = enable * ICE_ONE_PPS_OUT_AMP_MAX;
+	return ice_write_cgu_reg_e82x(hw, NAC_CGU_DWORD9, dw9.val);
+}
+
 /**
  * ice_cfg_cgu_pll_dis_sticky_bits_e82x - disable TS PLL sticky bits
  * @hw: pointer to the HW struct
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index ff98f76969e3..fc946fcd28b9 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -331,6 +331,7 @@ extern const struct ice_vernier_info_e82x e822_vernier[NUM_ICE_PTP_LNK_SPD];
 
 /* Device agnostic functions */
 u8 ice_get_ptp_src_clock_index(struct ice_hw *hw);
+int ice_cgu_cfg_pps_out(struct ice_hw *hw, bool enable);
 bool ice_ptp_lock(struct ice_hw *hw);
 void ice_ptp_unlock(struct ice_hw *hw);
 void ice_ptp_src_cmd(struct ice_hw *hw, enum ice_ptp_tmr_cmd cmd);
-- 
2.45.2


