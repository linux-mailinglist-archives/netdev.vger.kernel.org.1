Return-Path: <netdev+bounces-97259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8D8CA55B
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 02:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02A21F216C9
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 00:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0469E5C83;
	Tue, 21 May 2024 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+ADI2pX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F544C61
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250894; cv=none; b=mvfJt5yGzpZpSHwxzhUKXO644/lLV46Q8q/nuzEJm0qYuOTWnzkwPc2KqtI1BcY+U0PK0vh4AR0FqmaXabgy7jdi8pwYE1K0Uj4lPQNzxxUHFM1G6Y8eyNjsVIfGHFapa7gX4z3dtllf7uuHFftWOid1E6jMaFee5J3tkI9AKE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250894; c=relaxed/simple;
	bh=81CkU6yj5pUqnc0jWkH4er5ybsMLQCdikEjEk9iFVlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EDv3ZB/0eawXCBAHnM539/vjxYEXDkc/4wFructjZ0nVo4+8QaWMcfr9wIJdxIMDbVMneYPKsbj9gNebOWycCfeQbrgIGQLbAqP2N7TGJF+/3UnZdKHnwvckhLJ8rExIUQ+Z7NClpfidIofQKtuJGebq4KD8r75Ayli3u+a6IIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+ADI2pX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716250893; x=1747786893;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=81CkU6yj5pUqnc0jWkH4er5ybsMLQCdikEjEk9iFVlo=;
  b=E+ADI2pX0r+c0H8BYI4/yqUhPzek9YZ19XBXCwUYVP3k9wPT97sW5P0/
   WDOboQHB9JB4z8WxFZ7McACMGD8nKoGdWHC5Q8BDEdcuqjtbTtotPQfoE
   r9Bv3VVicApmD5S1Lfaj0Eu61XzI9lYF343IXRFBA4Gr4k/WjEE42hAeW
   R1QYkmLQH4GyONmRkEcra6cDxo/aWKLopWe/YNkoHybFgzt7HCyMPn1c1
   bY3L9jehcomHqhlttxWLJqBvLybHwk3mmwTx6QyNm4DbaOl9hZv6dDnfJ
   gETSAYNj5h9wTDs3LacmOg8iM4j18RZg4emGg05Skfszs9gV7MkahUH9c
   g==;
X-CSE-ConnectionGUID: JSsDtEWFR6WfaQtUw1DqZw==
X-CSE-MsgGUID: CT7xWoAbRk+pB/HqATpXfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="16252070"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="16252070"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 17:21:32 -0700
X-CSE-ConnectionGUID: Aji8kTT8R2iA/4RrsNcVag==
X-CSE-MsgGUID: ZS5OWn2sRQir+CStn3AcSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="33288240"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 17:21:31 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 20 May 2024 17:21:27 -0700
Subject: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
X-B4-Tracking: v=1; b=H4sIAAfpS2YC/x2NSw7CMAwFr1J5jSUTtfyugliY1FALSJATaKWqd
 69h9TSLNzNDEVMpcGpmMPlq0ZwctpsG4sDpLqi9MwQKLXWBMEnFHyB1vugfsYpFnxrzC8uoNQ4
 4Znuw5U/qsT3wjvd8vBITuPVtctPpXzyDy+CyLCuPv/r5hgAAAA==
To: netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Jeff Daly <jeffd@silicom-usa.com>, kernel.org-fo5k2w@ycharbi.fr
X-Mailer: b4 0.13.0

This reverts commit 565736048bd5f9888990569993c6b6bfdf6dcb6d.

According to the commit, it implements a manual AN-37 for some
"troublesome" Juniper MX5 switches. This appears to be a workaround for a
particular switch.

It has been reported that this causes a severe breakage for other switches,
including a Cisco 3560CX-12PD-S.

The code appears to be a workaround for a specific switch which fails to
link in SFI mode. It expects to see AN-37 auto negotiation in order to
link. The Cisco switch is not expecting AN-37 auto negotiation. When the
device starts the manual AN-37, the Cisco switch decides that the port is
confused and stops attempting to link with it. This persists until a power
cycle. A simple driver unload and reload does not resolve the issue, even
if loading with a version of the driver which lacks this workaround.

The authors of the workaround commit have not responded with
clarifications, and the result of the workaround is complete failure to
connect with other switches.

This appears to be a case where the driver can either "correctly" link with
the Juniper MX5 switch, at the cost of bricking the link with the Cisco
switch, or it can behave properly for the Cisco switch, but fail to link
with the Junipir MX5 switch. I do not know enough about the standards
involved to clearly determine whether either switch is at fault or behaving
incorrectly. Nor do I know whether there exists some alternative fix which
corrects behavior with both switches.

Revert the workaround for the Juniper switch.

Fixes: 565736048bd5 ("ixgbe: Manual AN-37 for troublesome link partners for X550 SFI")
Link: https://lore.kernel.org/netdev/cbe874db-9ac9-42b8-afa0-88ea910e1e99@intel.com/T/
Link: https://forum.proxmox.com/threads/intel-x553-sfp-ixgbe-no-go-on-pve8.135129/#post-612291
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jeff Daly <jeffd@silicom-usa.com>
Cc: kernel.org-fo5k2w@ycharbi.fr
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  3 --
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 56 ++-------------------------
 2 files changed, 3 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
index 897fe357b65b..346e3d9114a8 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
@@ -3675,9 +3675,7 @@ struct ixgbe_info {
 #define IXGBE_KRM_LINK_S1(P)		((P) ? 0x8200 : 0x4200)
 #define IXGBE_KRM_LINK_CTRL_1(P)	((P) ? 0x820C : 0x420C)
 #define IXGBE_KRM_AN_CNTL_1(P)		((P) ? 0x822C : 0x422C)
-#define IXGBE_KRM_AN_CNTL_4(P)		((P) ? 0x8238 : 0x4238)
 #define IXGBE_KRM_AN_CNTL_8(P)		((P) ? 0x8248 : 0x4248)
-#define IXGBE_KRM_PCS_KX_AN(P)		((P) ? 0x9918 : 0x5918)
 #define IXGBE_KRM_SGMII_CTRL(P)		((P) ? 0x82A0 : 0x42A0)
 #define IXGBE_KRM_LP_BASE_PAGE_HIGH(P)	((P) ? 0x836C : 0x436C)
 #define IXGBE_KRM_DSP_TXFFE_STATE_4(P)	((P) ? 0x8634 : 0x4634)
@@ -3687,7 +3685,6 @@ struct ixgbe_info {
 #define IXGBE_KRM_PMD_FLX_MASK_ST20(P)	((P) ? 0x9054 : 0x5054)
 #define IXGBE_KRM_TX_COEFF_CTRL_1(P)	((P) ? 0x9520 : 0x5520)
 #define IXGBE_KRM_RX_ANA_CTL(P)		((P) ? 0x9A00 : 0x5A00)
-#define IXGBE_KRM_FLX_TMRS_CTRL_ST31(P)	((P) ? 0x9180 : 0x5180)
 
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_DA		~(0x3 << 20)
 #define IXGBE_KRM_PMD_FLX_MASK_ST20_SFI_10G_SR		BIT(20)
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index 2decb0710b6e..a5f644934445 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -1722,59 +1722,9 @@ static int ixgbe_setup_sfi_x550a(struct ixgbe_hw *hw, ixgbe_link_speed *speed)
 		return -EINVAL;
 	}
 
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* change mode enforcement rules to hybrid */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x0400;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_FLX_TMRS_CTRL_ST31(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* manually control the config */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x20002240;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* move the AN base page values */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x1;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_PCS_KX_AN(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* set the AN37 over CB mode */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= 0x20000000;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_AN_CNTL_4(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
-
-	/* restart AN manually */
-	(void)mac->ops.read_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, &reg_val);
-	reg_val |= IXGBE_KRM_LINK_CTRL_1_TETH_AN_RESTART;
-
-	(void)mac->ops.write_iosf_sb_reg(hw,
-			IXGBE_KRM_LINK_CTRL_1(hw->bus.lan_id),
-			IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
+	status = mac->ops.write_iosf_sb_reg(hw,
+				IXGBE_KRM_PMD_FLX_MASK_ST20(hw->bus.lan_id),
+				IXGBE_SB_IOSF_TARGET_KR_PHY, reg_val);
 
 	/* Toggle port SW reset by AN reset. */
 	status = ixgbe_restart_an_internal_phy_x550em(hw);

---
base-commit: e4a87abf588536d1cdfb128595e6e680af5cf3ed
change-id: 20240520-net-2024-05-20-revert-silicom-switch-workaround-48a6a7a9b0a0

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


