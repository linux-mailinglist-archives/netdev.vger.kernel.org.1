Return-Path: <netdev+bounces-123861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B69D0966B1A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A4031F236AE
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13681BF7FD;
	Fri, 30 Aug 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nL9J9gj1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817C1C0DEA
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051904; cv=none; b=T3bxVlHbm5/ZBcSS6ExqjLMDSqwXpPB0VMRjjNjkCN8WIDlVJzuNbKMZ86jc+Bi/IJ5+LXt84EbM9wIr9xzO4QRwsw79FyeXH4+4n6DMi+ahOGC/uwJSdmfBAvOk1iHxuS70btjH5PgxoRlJE/ZK8pC/HsM6vffo7k0mi2aWrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051904; c=relaxed/simple;
	bh=36e4r0gDgegR0T+wBYDgb0wrRcQ3YAuIH38QDEnvLqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEJ4uHG/v/0A2cLTo0STjAdqDT1SKnABa6W5tmYwXJ9xfCo4XaqmjV3k7+tYbHChAyV4pFf2FcTK4VSamAEQWHesVe55rys4inKeOs78q8cogWjZpbmZwnLwTf2L4nUjibgUI/w5Lw5j15w4IlNxzC0fb/UZpC73tdgTrbze7R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nL9J9gj1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725051903; x=1756587903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=36e4r0gDgegR0T+wBYDgb0wrRcQ3YAuIH38QDEnvLqA=;
  b=nL9J9gj1+sDpO7PuOPX8N55O1ArN+Q4Ulh3ssh+iytcGQa4cMUHE7PLz
   YOj9S0GnlvHxdbEJ0R10qQkw8/mc85VFdIe2djio6JIYQLEV8VPR0EICP
   gbMcE4VFgj7/GyovpyIygauS2JGp9BPYZL8zfxaFKVqTm/i9Q6e5nlBiz
   D5phdATjzgxVT0rmh1rXJtZo7sbNQhOpmXQaF7H2aDRn552opmP/E2enz
   f1FN9cCy+TFEMHLVGZSd+lC+LJdkxf07p0PfFrIemvWLpZghnd9ZSuYAd
   JKrQP+CbrEexNNrYoKDyO9Ao58x00FGxLYVCICEJ4DuI3sZT9b6KiuxQ8
   Q==;
X-CSE-ConnectionGUID: yDeiIwacT1G7XmnNoQwvXA==
X-CSE-MsgGUID: J5WY7cxXR0SbScgq54y5pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11180"; a="13304276"
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="13304276"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 14:05:00 -0700
X-CSE-ConnectionGUID: gzvp4YlDSJOH5hLjCF9SPw==
X-CSE-MsgGUID: 2QxjlzVrTWKw5y9x3l1YhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="63625253"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 30 Aug 2024 14:05:00 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Sasha Neftin <sasha.neftin@intel.com>,
	anthony.l.nguyen@intel.com,
	vitaly.lifshits@intel.com,
	dima.ruinskiy@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net-next 4/6] igc: Move the MULTI GBT AN Control Register to _regs file
Date: Fri, 30 Aug 2024 14:04:46 -0700
Message-ID: <20240830210451.2375215-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sasha Neftin <sasha.neftin@intel.com>

MULTI GBT AN Control Register is IEEE Standard Register 7.32 (not a mask).
The right place should be in igc_reg.h file. In accordance with the
registers naming convention added IGC_' prefix.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_defines.h | 1 -
 drivers/net/ethernet/intel/igc/igc_phy.c     | 4 ++--
 drivers/net/ethernet/intel/igc/igc_regs.h    | 3 +++
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
index 6d6717ba4ffd..8e449904aa7d 100644
--- a/drivers/net/ethernet/intel/igc/igc_defines.h
+++ b/drivers/net/ethernet/intel/igc/igc_defines.h
@@ -178,7 +178,6 @@
 
 /* PHY GPY 211 registers */
 #define STANDARD_AN_REG_MASK	0x0007 /* MMD */
-#define ANEG_MULTIGBT_AN_CTRL	0x0020 /* MULTI GBT AN Control Register */
 #define MMD_DEVADDR_SHIFT	16     /* Shift MMD to higher bits */
 #define CR_2500T_FD_CAPS	0x0080 /* Advertise 2500T FD capability */
 
diff --git a/drivers/net/ethernet/intel/igc/igc_phy.c b/drivers/net/ethernet/intel/igc/igc_phy.c
index 861f37076861..2801e5f24df9 100644
--- a/drivers/net/ethernet/intel/igc/igc_phy.c
+++ b/drivers/net/ethernet/intel/igc/igc_phy.c
@@ -240,7 +240,7 @@ static s32 igc_phy_setup_autoneg(struct igc_hw *hw)
 		/* Read the MULTI GBT AN Control Register - reg 7.32 */
 		ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
 					    MMD_DEVADDR_SHIFT) |
-					    ANEG_MULTIGBT_AN_CTRL,
+					    IGC_ANEG_MULTIGBT_AN_CTRL,
 					    &aneg_multigbt_an_ctrl);
 
 		if (ret_val)
@@ -380,7 +380,7 @@ static s32 igc_phy_setup_autoneg(struct igc_hw *hw)
 		ret_val = phy->ops.write_reg(hw,
 					     (STANDARD_AN_REG_MASK <<
 					     MMD_DEVADDR_SHIFT) |
-					     ANEG_MULTIGBT_AN_CTRL,
+					     IGC_ANEG_MULTIGBT_AN_CTRL,
 					     aneg_multigbt_an_ctrl);
 
 	return ret_val;
diff --git a/drivers/net/ethernet/intel/igc/igc_regs.h b/drivers/net/ethernet/intel/igc/igc_regs.h
index bb6f37f5d3a5..12ddc5793651 100644
--- a/drivers/net/ethernet/intel/igc/igc_regs.h
+++ b/drivers/net/ethernet/intel/igc/igc_regs.h
@@ -310,6 +310,9 @@
 #define IGC_IPCNFG	0x0E38 /* Internal PHY Configuration */
 #define IGC_EEE_SU	0x0E34 /* EEE Setup */
 
+/* MULTI GBT AN Control Register - reg. 7.32 */
+#define IGC_ANEG_MULTIGBT_AN_CTRL	0x0020
+
 /* EEE ANeg Advertisement Register - reg 7.60 and reg 7.62 */
 #define IGC_ANEG_EEE_AB1	0x003c
 #define IGC_ANEG_EEE_AB2	0x003e
-- 
2.42.0


