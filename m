Return-Path: <netdev+bounces-130809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8B098B9DA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91A21C22FAA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449231A2653;
	Tue,  1 Oct 2024 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+UIcUuj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D11A0AF3
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779244; cv=none; b=ocIj/9489KJvfw3F9ozatjVIT1ABRCaZtn1cL1d7V0UXh7+e0fWo+8CEqxhvlNqXkK+IfU8G4VYTLLtjV/Rd+c2EG9/tNaRf/9xMG3tnThiGF+7WFXdrIBRXRFaaQ1P+WUzA3okr9v0ELQTCaD2Rr+1vW2PvsE8PVBTVOhUTd80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779244; c=relaxed/simple;
	bh=TJ8ojkbj4nMqG17eP3Yp1Q0kpn949AK5B73g0KtimIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjCorWyxHc2JIIiM8NF86JrINYohOp1xqFqwuPC7jZib8uqBrDSJ+F5Ie2is26l640h3T5RfhjRBZrM6jcwOZBic9ejzA6u2SWzGvyJ2AUDj2/jRZGglxXZ4X7mWwsip4c+2wX7L8fo+vkb2qFEdUuCrLgAH8qFNedlepG6ZQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+UIcUuj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727779242; x=1759315242;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TJ8ojkbj4nMqG17eP3Yp1Q0kpn949AK5B73g0KtimIE=;
  b=l+UIcUujoMiX/Q0Q+0eerVWliijG+6gcXUG/hPLl9hr4Xpb81lTqo8W0
   YDi7XQc+u/1fRkpdJ3TxmY9Ilp4MA0wgqz07pCniadHwI7owBf8Olficz
   KxZa0enQXn/oZMf6evA+k2mIYI6Zldfe1CYCQ+9bihCcLpejtkBTWPixR
   +jGLdC7/o8jQLRWLsD4Gti0T2t8zMrdy+i3wpbwndQmKFwWQoeIXEFaLE
   7Avc7HUiAzIKfqH+6ZS5b6yzp6iGzSbNyGuRBDNMUwdT9Hjd/IZWPBO7P
   Ds7I5GEWQghvsvnJpvIRwaakpFKewB+DmFuHPOxqofIQZGKxncoNXoikB
   A==;
X-CSE-ConnectionGUID: 3GnR6+1KTdyKjTrNGdB+1w==
X-CSE-MsgGUID: +mX7cEfjR82iON+ooPNW0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="44433911"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="44433911"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 03:40:40 -0700
X-CSE-ConnectionGUID: MLVR7bAUT2KILS2gYeKgDA==
X-CSE-MsgGUID: wd4rWgs3SIyxbrsfYDCWIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="104447768"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 01 Oct 2024 03:40:39 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9E31A27BC9;
	Tue,  1 Oct 2024 11:40:37 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next 2/2] ice: extend dump serdes equalizer values feature
Date: Tue,  1 Oct 2024 06:26:05 -0400
Message-Id: <20241001102605.4526-3-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
References: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the work done in commit 70838938e89c ("ice: Implement driver
functionality to dump serdes equalizer values") by adding the new set of
Rx registers that can be read using command:
  $ ethtool -d interface_name

Rx equalization parameters are E810 PHY registers used by end user to
gather information about configuration and status to debug link and
connection issues in the field.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 17 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c    | 17 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.h    | 17 +++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 1f01f3501d6b..1489a8ceec51 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1492,6 +1492,23 @@ struct ice_aqc_dnl_equa_param {
 #define ICE_AQC_RX_EQU_BFLF (0x13 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_BFHF (0x14 << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_RX_EQU_DRATE (0x15 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINHF (0x20 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINLF (0x21 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_GAINDC (0x22 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_CTLE_BW (0x23 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_GAIN (0x30 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_GAIN2 (0x31 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_2 (0x32 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_3 (0x33 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_4 (0x34 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_5 (0x35 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_6 (0x36 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_7 (0x37 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_8 (0x38 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_9 (0x39 << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_10 (0x3A << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_11 (0x3B << ICE_AQC_RX_EQU_SHIFT)
+#define ICE_AQC_RX_EQU_DFE_12 (0x3C << ICE_AQC_RX_EQU_SHIFT)
 #define ICE_AQC_TX_EQU_PRE1 0x0
 #define ICE_AQC_TX_EQU_PRE3 0x3
 #define ICE_AQC_TX_EQU_ATTEN 0x4
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 19e7a9d93928..3072634bf049 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -711,6 +711,23 @@ static int ice_get_tx_rx_equa(struct ice_hw *hw, u8 serdes_num,
 		{ ICE_AQC_RX_EQU_BFLF, rx, &ptr->rx_equ_bflf },
 		{ ICE_AQC_RX_EQU_BFHF, rx, &ptr->rx_equ_bfhf },
 		{ ICE_AQC_RX_EQU_DRATE, rx, &ptr->rx_equ_drate },
+		{ ICE_AQC_RX_EQU_CTLE_GAINHF, rx, &ptr->rx_equ_ctle_gainhf },
+		{ ICE_AQC_RX_EQU_CTLE_GAINLF, rx, &ptr->rx_equ_ctle_gainlf },
+		{ ICE_AQC_RX_EQU_CTLE_GAINDC, rx, &ptr->rx_equ_ctle_gaindc },
+		{ ICE_AQC_RX_EQU_CTLE_BW, rx, &ptr->rx_equ_ctle_bw },
+		{ ICE_AQC_RX_EQU_DFE_GAIN, rx, &ptr->rx_equ_dfe_gain },
+		{ ICE_AQC_RX_EQU_DFE_GAIN2, rx, &ptr->rx_equ_dfe_gain_2 },
+		{ ICE_AQC_RX_EQU_DFE_2, rx, &ptr->rx_equ_dfe_2 },
+		{ ICE_AQC_RX_EQU_DFE_3, rx, &ptr->rx_equ_dfe_3 },
+		{ ICE_AQC_RX_EQU_DFE_4, rx, &ptr->rx_equ_dfe_4 },
+		{ ICE_AQC_RX_EQU_DFE_5, rx, &ptr->rx_equ_dfe_5 },
+		{ ICE_AQC_RX_EQU_DFE_6, rx, &ptr->rx_equ_dfe_6 },
+		{ ICE_AQC_RX_EQU_DFE_7, rx, &ptr->rx_equ_dfe_7 },
+		{ ICE_AQC_RX_EQU_DFE_8, rx, &ptr->rx_equ_dfe_8 },
+		{ ICE_AQC_RX_EQU_DFE_9, rx, &ptr->rx_equ_dfe_9 },
+		{ ICE_AQC_RX_EQU_DFE_10, rx, &ptr->rx_equ_dfe_10 },
+		{ ICE_AQC_RX_EQU_DFE_11, rx, &ptr->rx_equ_dfe_11 },
+		{ ICE_AQC_RX_EQU_DFE_12, rx, &ptr->rx_equ_dfe_12 },
 	};
 	int err;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.h b/drivers/net/ethernet/intel/ice/ice_ethtool.h
index 98eb9c51d687..8f2ad1c172c0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.h
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.h
@@ -16,6 +16,23 @@ struct ice_serdes_equalization_to_ethtool {
 	int rx_equ_bflf;
 	int rx_equ_bfhf;
 	int rx_equ_drate;
+	int rx_equ_ctle_gainhf;
+	int rx_equ_ctle_gainlf;
+	int rx_equ_ctle_gaindc;
+	int rx_equ_ctle_bw;
+	int rx_equ_dfe_gain;
+	int rx_equ_dfe_gain_2;
+	int rx_equ_dfe_2;
+	int rx_equ_dfe_3;
+	int rx_equ_dfe_4;
+	int rx_equ_dfe_5;
+	int rx_equ_dfe_6;
+	int rx_equ_dfe_7;
+	int rx_equ_dfe_8;
+	int rx_equ_dfe_9;
+	int rx_equ_dfe_10;
+	int rx_equ_dfe_11;
+	int rx_equ_dfe_12;
 	int tx_equ_pre1;
 	int tx_equ_pre3;
 	int tx_equ_atten;
-- 
2.38.1


