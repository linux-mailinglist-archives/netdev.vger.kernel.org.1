Return-Path: <netdev+bounces-173526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D76A5947B
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17C9E165CD4
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE8227E8A;
	Mon, 10 Mar 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fSqW4TRP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4EB227EB6
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609719; cv=none; b=uBhDZf18/qI9L41XAwzXtpDAP6tIb9dMjJd1uM1qS1Oy4bmPlDWFU4kz7os4o58Ibl9ie+D9hTDI6kxcf1s1f1rmyMCIbODyomugnc/92SLE/tSdzqqtVU5udZGGM/OtCWHwithJwjCdLGCqmMTFOz2Aw3GzXCJVz3TLhXioMdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609719; c=relaxed/simple;
	bh=/CH9UU6hzZ0ulPSOFaDZUiPy2Hm90+BbN8HITQ7ASd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHQFWN9AEck8pnjHCYLIKuVM396vLrz5uoaYi4VLW7mK1GTksBPzZp/0Xvq9D0KfyP4Rl33k8YuHilJ6DN0W+voyS94wxnSAlApXLt40a3R10pCXNqJ3hmwJbJGK5xCMIoFxCbxOlXLn0O7/tvOnBgFoXuFFLGou/qiuW18tJto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fSqW4TRP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741609717; x=1773145717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CH9UU6hzZ0ulPSOFaDZUiPy2Hm90+BbN8HITQ7ASd4=;
  b=fSqW4TRPqbZHF6yp6/FUT4qvAUhbET/f5D27ZjEuMTX4gwcV0cDDGmG7
   V/DWTw7t4QUHWnY2my2vG//xW3pSgAuVTDo9h4MgPF/ZoDk4Z1OwLPwGP
   /b+Jgq2KjwLmeAQUX5mFURC8vlXaE7Kp3MUcNbMm/PD2cktr73nL516Jp
   J/kHxrwz5xKZuR8aJAg5QKFWFQtVbzqvWBijAMAbLtdKS4LL2+13kGgKK
   QvmZMuN15UAkOvXZ/tcoFqY//fSeeB29obExSN0XfHIhFZTLBsPZWauwT
   HwD4poUextZbSwPG/I3eS+tpKsEMTyBuO03HeZgt1AUgDAT9fN0XeUKpT
   A==;
X-CSE-ConnectionGUID: opnKoxhzTrKQQKqk8NS4RQ==
X-CSE-MsgGUID: fCw8nLfwTJKz/eosgij7tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53981140"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="53981140"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 05:28:36 -0700
X-CSE-ConnectionGUID: XqccRF4TRt6Qu4qupIgxIA==
X-CSE-MsgGUID: FuAgZO44Qi6N165e3Gk5fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="119698254"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by orviesa009.jf.intel.com with ESMTP; 10 Mar 2025 05:28:35 -0700
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>
Subject: [PATCH iwl-next v2 2/3] ice: refactor ice_sbq_msg_dev enum
Date: Mon, 10 Mar 2025 13:24:38 +0100
Message-Id: <20250310122439.3327908-3-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250310122439.3327908-1-grzegorz.nitka@intel.com>
References: <20250310122439.3327908-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

Rename ice_sbq_msg_dev to ice_sbq_dev_id to reflect the meaning of this
type more precisely. This enum type describes RDA (Remote Device Access)
client ids, accessible over SB (Side Band) interface.
Rename enum elements to make a driver namespace more cleaner and
consistent with other definitions within SB
Remove unused 'rmn_x' entries, specific to unsupported E824 device.
Adjust clients '2' and '13' names (phy_0 and phy_0_peer respectively) to
be compliant with EAS doc. According to the specification, regardless of
the complex entity (single or dual), when accessing its own ports,
they're accessed always as 'phy_0' client. And referred as 'phy_0_peer'
when handling ports conneced to the other complex.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Co-developed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c  |  2 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c  | 20 ++++++++++----------
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h | 11 ++++-------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index edb1d0f7e187..8f0c72df2a44 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3434,7 +3434,7 @@ int ice_aq_get_fec_stats(struct ice_hw *hw, u16 pcs_quad, u16 pcs_port,
 	msg.msg_addr_low = lower_16_bits(reg_offset);
 	msg.msg_addr_high = receiver_id;
 	msg.opcode = ice_sbq_msg_rd;
-	msg.dest_dev = rmn_0;
+	msg.dest_dev = ice_sbq_dev_phy_0;
 
 	err = ice_sbq_rw_reg(hw, &msg, flag);
 	if (err)
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index a5df081ffc19..eb1893dd8979 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -240,7 +240,7 @@ static int ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
 		.opcode = ice_sbq_msg_rd,
-		.dest_dev = cgu,
+		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr
 	};
 	int err;
@@ -272,7 +272,7 @@ static int ice_write_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 val)
 {
 	struct ice_sbq_msg_input cgu_msg = {
 		.opcode = ice_sbq_msg_wr,
-		.dest_dev = cgu,
+		.dest_dev = ice_sbq_dev_cgu,
 		.msg_addr_low = addr,
 		.data = val
 	};
@@ -919,16 +919,16 @@ static void ice_ptp_cfg_sync_delay(const struct ice_hw *hw, u32 delay)
  *
  * Return: destination sideband queue PHY device.
  */
-static enum ice_sbq_msg_dev ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
-						      u8 port)
+static enum ice_sbq_dev_id ice_ptp_get_dest_dev_e825(struct ice_hw *hw,
+						     u8 port)
 {
 	/* On a single complex E825, PHY 0 is always destination device phy_0
 	 * and PHY 1 is phy_0_peer.
 	 */
 	if (port >= hw->ptp.ports_per_phy)
-		return eth56g_phy_1;
+		return ice_sbq_dev_phy_0_peer;
 	else
-		return eth56g_phy_0;
+		return ice_sbq_dev_phy_0;
 }
 
 /**
@@ -2758,7 +2758,7 @@ static void ice_fill_phy_msg_e82x(struct ice_hw *hw,
 		msg->msg_addr_high = P_Q1_H(P_4_BASE + offset, phy_port);
 	}
 
-	msg->dest_dev = rmn_0;
+	msg->dest_dev = ice_sbq_dev_phy_0;
 }
 
 /**
@@ -3081,7 +3081,7 @@ static int ice_fill_quad_msg_e82x(struct ice_hw *hw,
 	if (quad >= ICE_GET_QUAD_NUM(hw->ptp.num_lports))
 		return -EINVAL;
 
-	msg->dest_dev = rmn_0;
+	msg->dest_dev = ice_sbq_dev_phy_0;
 
 	if (!(quad % ICE_GET_QUAD_NUM(hw->ptp.ports_per_phy)))
 		addr = Q_0_BASE + offset;
@@ -4800,7 +4800,7 @@ static int ice_read_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 *val)
 	msg.msg_addr_low = lower_16_bits(addr);
 	msg.msg_addr_high = upper_16_bits(addr);
 	msg.opcode = ice_sbq_msg_rd;
-	msg.dest_dev = rmn_0;
+	msg.dest_dev = ice_sbq_dev_phy_0;
 
 	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
 	if (err) {
@@ -4830,7 +4830,7 @@ static int ice_write_phy_reg_e810(struct ice_hw *hw, u32 addr, u32 val)
 	msg.msg_addr_low = lower_16_bits(addr);
 	msg.msg_addr_high = upper_16_bits(addr);
 	msg.opcode = ice_sbq_msg_wr;
-	msg.dest_dev = rmn_0;
+	msg.dest_dev = ice_sbq_dev_phy_0;
 	msg.data = val;
 
 	err = ice_sbq_rw_reg(hw, &msg, ICE_AQ_FLAG_RD);
diff --git a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
index 3b0054faf70c..183dd5457d6a 100644
--- a/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_sbq_cmd.h
@@ -46,13 +46,10 @@ struct ice_sbq_evt_desc {
 	u8 data[24];
 };
 
-enum ice_sbq_msg_dev {
-	eth56g_phy_0	= 0x02,
-	rmn_0		= 0x02,
-	rmn_1		= 0x03,
-	rmn_2		= 0x04,
-	cgu		= 0x06,
-	eth56g_phy_1	= 0x0D,
+enum ice_sbq_dev_id {
+	ice_sbq_dev_phy_0	= 0x02,
+	ice_sbq_dev_cgu		= 0x06,
+	ice_sbq_dev_phy_0_peer	= 0x0D,
 };
 
 enum ice_sbq_msg_opcode {
-- 
2.39.3


