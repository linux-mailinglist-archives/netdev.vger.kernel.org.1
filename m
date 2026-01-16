Return-Path: <netdev+bounces-250518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA14AD30D05
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D749F302C9E7
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0E936C5BA;
	Fri, 16 Jan 2026 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fmqLL66s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE329C327
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768564997; cv=none; b=gIyPcMh5kxxDkcrQsx2eNyxG/eo/8dCqR5sPtMdlkr6JUyo8Kq5Iy73PK/cwKOBsmRMey5nYoGFxKAWBIrAAujDaiLYcgCP2vXoKOVweBGLVTaG3hYHhGXqns6v3jseAEPqgYfjqPjPq2hzTS0eaANWa+7Z8eZTHCPtJ3CZ1nMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768564997; c=relaxed/simple;
	bh=5LSHpYluNT3I38fsGIFTYyyt50V6fFj6n0MDSZ220pY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnSbBZIWQ3LCq/39AZ+voud20flg1jkZrK1cFMvL/cMM2kC9QiYwzDO1c46nZqyJIOmlK2YLlDiF5Er0qTC7W7rqVnvZeyc1JMNYd3adwoYBTkhJaZSt5BNUGz/dPWKA7Kb865aO0WYM8An+bBoSP0jNVM1zlZp9yXzEchkAQkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fmqLL66s; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768564996; x=1800100996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5LSHpYluNT3I38fsGIFTYyyt50V6fFj6n0MDSZ220pY=;
  b=fmqLL66s7grakItYQ/3Azfu/J221egMf3NSdL43HOQzBoQZHO7l+V4M2
   l44FfkDMJEhybh/vjezF+J+bQGWZ9bWy8SavOP66gM3uB/3sJbxSjz7rr
   s/K2yWzhRW7Zx/MFbdid4twDgVjGUUBcHTaZdG/XhXnR9aPXiIimNWtLt
   IazxVsG8OYSA7Wx+MK/BQRUpRxeJzFn9LBdLQTT3TvA0kCTriEgqwy4xq
   U1ln3pxzBtTgNY1iqxFnwhLHGOVr1QNVSdAPe8UQEcCLCndcxM/m52t0k
   E++UvomHAyXfoFo1Xjb1QF+VR+uG6l/laZ+KwnCAcNdak48dmlXazEoTw
   A==;
X-CSE-ConnectionGUID: RP/lO+MIRiuodsuOCkhs7A==
X-CSE-MsgGUID: uEf9qCDdRDmJP+jWjZExgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="68888346"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="68888346"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:03:15 -0800
X-CSE-ConnectionGUID: bXkxxtW9RdmRSUOnJaJnfw==
X-CSE-MsgGUID: 8OB1lOosT1yxsOeOHZpkfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209721855"
Received: from amlin-018-252.igk.intel.com ([10.102.18.252])
  by orviesa004.jf.intel.com with ESMTP; 16 Jan 2026 04:03:12 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	horms@kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next 1/2] ixgbe: e610: add missing endianness conversion
Date: Fri, 16 Jan 2026 13:23:53 +0100
Message-ID: <20260116122353.78235-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a possible ACI issue on big-endian platforms.

Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
index c2f8189..f494e90 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
@@ -113,7 +113,8 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 
 	/* Descriptor is written to specific registers */
 	for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++)
-		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i), raw_desc[i]);
+		IXGBE_WRITE_REG(hw, IXGBE_PF_HIDA(i),
+				le32_to_cpu(raw_desc[i]));
 
 	/* SW has to set PF_HICR.C bit and clear PF_HICR.SV and
 	 * PF_HICR_EV
@@ -145,7 +146,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_SV)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA(i));
-			raw_desc[i] = raw_desc[i];
+			raw_desc[i] = cpu_to_le32(raw_desc[i]);
 		}
 	}
 
@@ -153,7 +154,7 @@ static int ixgbe_aci_send_cmd_execute(struct ixgbe_hw *hw,
 	if ((hicr & IXGBE_PF_HICR_EV) && !(hicr & IXGBE_PF_HICR_C)) {
 		for (i = 0; i < IXGBE_ACI_DESC_SIZE_IN_DWORDS; i++) {
 			raw_desc[i] = IXGBE_READ_REG(hw, IXGBE_PF_HIDA_2(i));
-			raw_desc[i] = raw_desc[i];
+			raw_desc[i] = cpu_to_le32(raw_desc[i]);
 		}
 	}
 
-- 
2.47.1


