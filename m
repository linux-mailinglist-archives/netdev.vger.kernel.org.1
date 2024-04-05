Return-Path: <netdev+bounces-85148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D0899A42
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E941C20C07
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 10:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5A161339;
	Fri,  5 Apr 2024 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQ2V9IFK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E316132E
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311620; cv=none; b=UZ6v1eNdaqietnKgNqh6ePZRdB8FNh6MQwvG2I0qaVxeLFIrqIU2s3JTgVeBWDi13CR4KTMFaYJX/B5fviGR6VgeVijWZPcdBNbSyxYtLLfctq/1UJ2JMJ7MaRtdUxnFV+APfWr/Ey/Hu5UIg0ZpexKOYt+SMQY09jBkbqFpX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311620; c=relaxed/simple;
	bh=SoyjNGlki52gHtWEtTa0V4mjRrOqn9ZjWpMmSIycJ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlN75w2Wj75D8ip52n8jP8CjgDpA+sxjNFYSc+Kg+Syqpo9d1eq9ALVj1c1vr9YugiiyZBF4+7u8u3hvt62MIDGJ/XOOO/8TmO7HIfjlnD3XcXRm12lq64ggn5jdY74amFc2E2CKHmQRjH7u3/6owctWN9qgdYgjBng4dpqmCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQ2V9IFK; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712311617; x=1743847617;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SoyjNGlki52gHtWEtTa0V4mjRrOqn9ZjWpMmSIycJ1c=;
  b=EQ2V9IFKvvokbMn1uSSqJzzwdHAosVl/Cfao5Z09u7kDb9a8jgAesYz2
   5NytMtlKmMkXcYsHPOT7x1a5ZU04UQgxh/Q4zo1V2SrJIlNf8fbHn8SlG
   8pqjn/kr0RbGrBlQeYADe9f/wBqSb30FAmZ376pqUxbk1TSFU4M0f6T23
   hjPsi3oEFy/INn8tAGhh3GgL7DdZxW+V6ILp/SCFfqh/MRETyV9jdZ7d5
   KINwN7sWWXR7AFg92D3DVfJ3nxprls8VjzWBuoyR4zupu026ZPGg0WCep
   CoVfOn4y/cRBi7efwtUtoDllSfPW16SY8quxiZUkRfna3jwtXWkmo/npb
   g==;
X-CSE-ConnectionGUID: MHsE9h4jSk+Sbpjpoc6ySw==
X-CSE-MsgGUID: wrbGE1m7R9uS+v1rqkqcxw==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7493919"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7493919"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 03:06:57 -0700
X-CSE-ConnectionGUID: hArtSAm8Su2qSmrc5hebDQ==
X-CSE-MsgGUID: U+yr5OLdQkyd/p384kIrzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19536083"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by orviesa007.jf.intel.com with ESMTP; 05 Apr 2024 03:06:56 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v6 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Fri,  5 Apr 2024 11:57:12 +0200
Message-ID: <20240405100648.144756-14-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825C products have a different PHY model than E822, E823 and E810 products.
This PHY is ETH56G and its support is necessary to have functional PTP stack
for E825C products.

Grzegorz Nitka (2):
  ice: Add NAC Topology device capability parser
  ice: Adjust PTP init for 2x50G E825C devices

Jacob Keller (2):
  ice: Introduce helper to get tmr_cmd_reg values
  ice: Introduce ice_get_base_incval() helper

Karol Kolacinski (4):
  ice: Introduce ice_ptp_hw struct
  ice: Add PHY OFFSET_READY register clearing
  ice: Change CGU regs struct to anonymous
  ice: Support 2XNAC configuration using auxbus

Michal Michalik (1):
  ice: Add support for E825-C TS PLL handling

Sergey Temerkhanov (3):
  ice: Implement Tx interrupt enablement functions
  ice: Move CGU block
  ice: Introduce ETH56G PHY model for E825C products

V5 -> V6: Changes in:
          - ice: Implement Tx interrupt enablement functions
          - ice: Move CGU block

V4 -> V5: Changes in:
          - ice: Introduce ice_ptp_hw struct
          - ice: Introduce helper to get tmr_cmd_reg values
          - ice: Introduce ice_get_base_incval() helper
          - ice: Introduce ETH56G PHY model for E825C products
          - ice: Add support for E825-C TS PLL handling
          - ice: Adjust PTP init for 2x50G E825C devices

V1 -> V4: Changes in:
          - ice: Introduce ETH56G PHY model for E825C products

 drivers/net/ethernet/intel/ice/ice.h          |   23 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h |   77 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   58 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  265 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3595 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  290 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3874 insertions(+), 914 deletions(-)


base-commit: 0a3074e5b4b523fb60f4ae9fb32bb180ea1fb6ef
-- 
2.43.0


