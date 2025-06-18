Return-Path: <netdev+bounces-199181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2ACBADF4EE
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C1C4A3530
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25112FCFDA;
	Wed, 18 Jun 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTaM881b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3244C307AE6
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268576; cv=none; b=E6/ZiQwLnWE0VdZ4E7wfooV+uUZelS+ITtpj05EoBENTVO7s3uwe/OzKib579+LvUnSRoBoOFzZRlhAoqs/49FkzMcMq8kSwNNxytagRiQg3tUH73LQPz70ADFKlmoW2N9UI+/rwz4zFl2MKf4z+St9CxNl8D2JS4DEiITPgW/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268576; c=relaxed/simple;
	bh=RGJ+/yRyq1iapUlw+WK6ohNx7EqPGbsi3/F6exVz24w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7C+BddfHEIo9RL+RLxtQ7iI28YRL0DVKWuFjWVD4jF5SNQeoO4h5UB6Gl8wOz7XkX2jiS/rH1eDm+bIZaa0riTMkK2cwqm3uxV3PO2FraetW40w6wBzYOde6oiQKNhXX6xG3R4Ms1Ddbqjcvf4fQIzE2bNUaYkzEhqVVK4pIH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTaM881b; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268575; x=1781804575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RGJ+/yRyq1iapUlw+WK6ohNx7EqPGbsi3/F6exVz24w=;
  b=DTaM881bgRiM0xB9qsVWULHwPDm8cN3fJ+YvXl6MatMdsCOxKCLPDcXf
   yH43Y2lwalyChBrF20XWz/+ykVEuvjGehFx40+dBNPQQ2jeZt3RvWm24F
   lPBFpRN2VMqtFkda+wUx2bwgc9RpzQlDgLF5xZmwnH+RwRfSaZW0NUzhf
   uWDic5DpUIhLydepkprsq0iEiMLNbyfge8GC4kYjGoKslWfHg4P+y+ub7
   aDpcVXqjCoNZjQN3jnTw4VW31Fw1HP08a1CEQrqVi1kLhZ3HJhR5gagvs
   SJOk44jXHWd89H1xLzb6anzVZeW21e6dZ4imC9dP7+t64fZ+Y+WmcPbZi
   w==;
X-CSE-ConnectionGUID: KCEWSEWDR3GA04wX2dfe6w==
X-CSE-MsgGUID: 6qqsroncTpCFfvX/YiOfMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183754"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183754"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:52 -0700
X-CSE-ConnectionGUID: fZMERbO3SzKU8p1Fp4Zqdw==
X-CSE-MsgGUID: LzsIcPUYSLKfyO6Un/iD1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149695998"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:51 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com,
	Milena Olech <milena.olech@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 12/15] ice: wait before enabling TSPLL
Date: Wed, 18 Jun 2025 10:42:24 -0700
Message-ID: <20250618174231.3100231-13-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
References: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karol Kolacinski <karol.kolacinski@intel.com>

To ensure proper operation, wait for 10 to 20 microseconds before
enabling TSPLL.

Adjust wait time after enabling TSPLL from 1-5 ms to 1-2 ms.

Those values are empirical and tested on multiple HW configurations.

Reviewed-by: Milena Olech <milena.olech@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tspll.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tspll.c b/drivers/net/ethernet/intel/ice/ice_tspll.c
index 66ad5ee63f30..a392b39920ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_tspll.c
+++ b/drivers/net/ethernet/intel/ice/ice_tspll.c
@@ -229,12 +229,15 @@ static int ice_tspll_cfg_e82x(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	r24 |= FIELD_PREP(ICE_CGU_R23_R24_TIME_REF_SEL, clk_src);
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, r24);
 
+	/* Wait to ensure everything is stable */
+	usleep_range(10, 20);
+
 	/* Finally, enable the PLL */
 	r24 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, r24);
 
-	/* Wait to verify if the PLL locks */
-	usleep_range(1000, 5000);
+	/* Wait at least 1 ms to verify if the PLL locks */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_BWM_LF, &val);
 	if (!(val & ICE_CGU_RO_BWM_LF_TRUE_LOCK)) {
@@ -357,12 +360,15 @@ static int ice_tspll_cfg_e825c(struct ice_hw *hw, enum ice_tspll_freq clk_freq,
 	/* Clear the R24 register. */
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R24, 0);
 
+	/* Wait to ensure everything is stable */
+	usleep_range(10, 20);
+
 	/* Finally, enable the PLL */
 	r23 |= ICE_CGU_R23_R24_TSPLL_ENABLE;
 	ICE_WRITE_CGU_REG_OR_DIE(hw, ICE_CGU_R23, r23);
 
-	/* Wait to verify if the PLL locks */
-	usleep_range(1000, 5000);
+	/* Wait at least 1 ms to verify if the PLL locks */
+	usleep_range(USEC_PER_MSEC, 2 * USEC_PER_MSEC);
 
 	ICE_READ_CGU_REG_OR_DIE(hw, ICE_CGU_RO_LOCK, &val);
 	if (!(val & ICE_CGU_RO_LOCK_TRUE_LOCK)) {
-- 
2.47.1


