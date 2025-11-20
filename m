Return-Path: <netdev+bounces-240477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E7120C75658
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F283435B04E
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2027736922D;
	Thu, 20 Nov 2025 16:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IEAD3apL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB30334387;
	Thu, 20 Nov 2025 16:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656101; cv=none; b=qC4h9ZvTRnz0EpmoyRROI6yyaJHuXlx/PH9uh3xMzWAgZtFa/KLhWjSPG0gXputAYXcMU/TUKW8/d1/Sz3B3Op40FxoxIS2p+XVIyLigYQpQ4yM/0vQwuETudydFgPxsyPw41yaev37frHxfmtuy4g9jy77VaYDr6korpYITF2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656101; c=relaxed/simple;
	bh=Fq3t0sobCfSkZ8rkAOl15NszCcSbPhZftbWaCIEfhF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j8YbpgYVS+MxLJW05L1LRtV8lodZXWRyP1I4/9YXom7KlxtWJss/O604VCBiObVtD91EcnYx0i1m1J646/XpfwkLWqMQZwqiVTWldm8WZTPE5oL3ec1p+Lmx1nauZoe8tqzI/lqt9c2D/jCGgYh9ZyI4MJ5m7PdrAXYyR++mHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IEAD3apL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763656099; x=1795192099;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fq3t0sobCfSkZ8rkAOl15NszCcSbPhZftbWaCIEfhF0=;
  b=IEAD3apLcpYruK6tFxERBJ5yUMUUQSR5DbQwtk/oJvW25Kv5+PXaOzFr
   hPuyyylC2DFTrTQekrIDKNi4eWT+dfkrypEGiB9ew6KTIIEfNtMTo6oVK
   9XoU1aDySFmlYVed6rJ9pa7iVgPBBQXnCNsvfD9kOQ8tqkdefP1U1gc8j
   b6/iPyiDHp/h8xQeacbkI/g8m7mhwnsEIYE4uCme46tHux8pCxMssed3D
   VaI0PpspNQ0qvLDdMtLqhgFud4LPgImtuE94cMCSoe2r+bdGP786faG44
   arEwcSlA3RmZCgFM6KOdavFbh8YV4jVBMfgXyTWxBQkamZ4rO1QaX6swx
   w==;
X-CSE-ConnectionGUID: 4+tlg5upRliw5PdsZ3hYyA==
X-CSE-MsgGUID: 3n0yCi5uR8CdgnkMMB0KQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="69599284"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="69599284"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 08:28:18 -0800
X-CSE-ConnectionGUID: Fq2BGUNARu2f/f/s3Bq9EA==
X-CSE-MsgGUID: gSbIR6DNQG+Z1/wDh9w5+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="191531281"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa008.jf.intel.com with ESMTP; 20 Nov 2025 08:28:17 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com
Subject: [PATCH iwl-next 1/8] ice: in dvm, use outer VLAN in MAC,VLAN lookup
Date: Thu, 20 Nov 2025 17:28:06 +0100
Message-ID: <20251120162813.37942-2-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120162813.37942-1-jakub.slepecki@intel.com>
References: <20251120162813.37942-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

In double VLAN mode (DVM), outer VLAN is located a word earlier in
the field vector compared to the single VLAN mode.  We already modify
ICE_SW_LKUP_VLAN to use it but ICE_SW_LKUP_MAC_VLAN was left untouched,
causing the lookup to match any packet with one or no layer of Dot1q.
This change enables to fix cross-vlan loopback traffic using MAC,VLAN
lookups.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_vlan_mode.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
index fb526cb84776..68a7b05de44e 100644
--- a/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
+++ b/drivers/net/ethernet/intel/ice/ice_vlan_mode.c
@@ -198,6 +198,7 @@ static bool ice_is_dvm_supported(struct ice_hw *hw)
 #define ICE_SW_LKUP_VLAN_LOC_LKUP_IDX			1
 #define ICE_SW_LKUP_VLAN_PKT_FLAGS_LKUP_IDX		2
 #define ICE_SW_LKUP_PROMISC_VLAN_LOC_LKUP_IDX		2
+#define ICE_SW_LKUP_MAC_VLAN_LOC_LKUP_IDX		4
 #define ICE_PKT_FLAGS_0_TO_15_FV_IDX			1
 static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
 	{
@@ -234,6 +235,17 @@ static struct ice_update_recipe_lkup_idx_params ice_dvm_dflt_recipes[] = {
 		.mask_valid = false,  /* use pre-existing mask */
 		.lkup_idx = ICE_SW_LKUP_PROMISC_VLAN_LOC_LKUP_IDX,
 	},
+	{
+		/* Similarly to ICE_SW_LKUP_VLAN, change to outer/single VLAN in
+		 * DVM
+		 */
+		.rid = ICE_SW_LKUP_MAC_VLAN,
+		.fv_idx = ICE_EXTERNAL_VLAN_ID_FV_IDX,
+		.ignore_valid = true,
+		.mask = 0,
+		.mask_valid = false,
+		.lkup_idx = ICE_SW_LKUP_MAC_VLAN_LOC_LKUP_IDX,
+	},
 };
 
 /**
-- 
2.43.0


