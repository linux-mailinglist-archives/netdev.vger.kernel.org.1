Return-Path: <netdev+bounces-168437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA28A3F0E4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB9E19C80C6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91828209F47;
	Fri, 21 Feb 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dl0phkgo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC6F204087
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740131012; cv=none; b=XXy81jIIBwRSw5egjM+iC9ixu2UMhU3uXq+i2J+j1YRe64ioEV/uez3Qxz5uTlt5eZpve4Y/sFtV9HwZYtdlz6uT109xjnoyaR8ko5KaRiZyHdINKPDwXnJQooswb0jED3nY2cRs0hT5+X3X1Qf67IMYw+A5NkUnKiy08mq5sSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740131012; c=relaxed/simple;
	bh=522MooTYpYrtzHnLXBjlkvV0sFdSBCEqCsgZPGxH6BI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PohcxtZkCYr4VaynAzlUp5+R8effILpQBUTjuhS1vaw/7FfMFr3TtSeuJR352Du5C8znW7RA14GvK0bFic/q7aZgeGVQWs2Dxk/GZPeAwOLhN7E/94w5BZzXOrqAP5OHA3+jKCL4LEdoEfFJJS3FB9WB+1qZuWVBIWjVsjs+rLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dl0phkgo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740131010; x=1771667010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=522MooTYpYrtzHnLXBjlkvV0sFdSBCEqCsgZPGxH6BI=;
  b=Dl0phkgotja1bN7cME+xsycIMuf8Rm39Fl5qKrzqoOlsHYyi0ZtTKAYp
   PjZljXjywibHOcgCKhz6E0nnwUVbspZmkfGBlcs4m/e01WXgQNmdQJqN3
   kHnAww1k9zoJs3ATbongjVCLtD1TgzLaTlrSyWKmHmslACU0ixl2ivXRL
   LOTJdob20wfHw75nGfTbsBC/65TGncy8aPXRP4wi46i58jiWTY1pBa8KR
   Wgt+AG1hl/i+a6HcUmrlqcxnJ8e938UKkegGo7Bi+t16rlzfmfKgvSN1u
   gulYuooMsE7hFmCSEjStHVOiVW2Dme9jIx5wBgPxYrNbb3OBhaEpnuYUl
   g==;
X-CSE-ConnectionGUID: asgZdGDFRnOi3ZkSsvSA/A==
X-CSE-MsgGUID: UH5ieAqNR5aO+QO4IeCj1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51588302"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; 
   d="scan'208";a="51588302"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2025 01:43:30 -0800
X-CSE-ConnectionGUID: UZ8654HgQxyk8hBCbgBuUg==
X-CSE-MsgGUID: gWQjtqNiRPG6ZbGjteWRzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146214739"
Received: from gklab-003-001.igk.intel.com ([10.211.3.1])
  by fmviesa001.fm.intel.com with ESMTP; 21 Feb 2025 01:43:28 -0800
From: Grzegorz Nitka <grzegorz.nitka@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH iwl-net v1] ice: fix lane number calculation
Date: Fri, 21 Feb 2025 10:39:49 +0100
Message-Id: <20250221093949.2436728-1-grzegorz.nitka@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E82X adapters do not have sequential IDs, lane number is PF ID.

Add check for ICE_MAC_GENERIC and skip checking port options.

Also, adjust logical port number for specific E825 device with external
PHY support (PCI device id 0x579F). For this particular device,
with 2x25G (PHY0) and 2x10G (PHY1) port configuration, modification of
pf_id -> lane_number mapping is required. PF IDs on the 2nd PHY start
from 4 in such scenario. Otherwise, the lane number cannot be
determined correctly, leading to PTP init errors during PF initialization.

Fixes: 258f5f9058159 ("ice: Add correct PHY lane assignment")
Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Milena Olech <milena.olech@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7a2a2e8da8fa..83b72414760a 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4171,6 +4171,15 @@ int ice_get_phy_lane_number(struct ice_hw *hw)
 	unsigned int lane;
 	int err;
 
+	/* E82X does not have sequential IDs, lane number is PF ID.
+	 * For E825 device, the exception is the variant with external
+	 * PHY (0x579F), in which there is also 1:1 pf_id -> lane_number
+	 * mapping.
+	 */
+	if (hw->mac_type == ICE_MAC_GENERIC ||
+	    hw->device_id == ICE_DEV_ID_E825C_SGMII)
+		return hw->pf_id;
+
 	options = kcalloc(ICE_AQC_PORT_OPT_MAX, sizeof(*options), GFP_KERNEL);
 	if (!options)
 		return -ENOMEM;

base-commit: c4813820042d447c687cf4f1d5e240740638e586
-- 
2.39.3


