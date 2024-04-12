Return-Path: <netdev+bounces-87377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 087088A2EF6
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B791C28319E
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 13:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89725915A;
	Fri, 12 Apr 2024 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqdh8ztz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954943EA83
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927474; cv=none; b=ekQEUSp+CdEaju3iDi0qxRyRVb5BfnyYs66Ko7vYmZY3cxb6ez2dvtE1wDca2DXHn3f7o98wIjlG7CIwUJbzTXLef3/mtVwbrkb/vHIxIyYt/EW6I2U3UE4P33GDUordxDyHyoRle12A1BVyVSkfTAFYK/U0XYVktjb8lK7hv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927474; c=relaxed/simple;
	bh=5uEalmKLGaEC3QKjKv+lpkHjtZVbWIXGtcDrsB4bDkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLnsj8LD78Y5S81uVP7vQtkSYXUPo6NruGeyXImcbA3Sr+Wpsreexgk+Dt7g6YGs+2MS1u8HWFCeIYBdHYxrCsqPvx+uZjJjNIxQcKP4NZv+oyvgFuMrNR0p3vUEePE43KneOLPdQnbYVveur42Ol5npo5RpTacif7oNho/DsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqdh8ztz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712927472; x=1744463472;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5uEalmKLGaEC3QKjKv+lpkHjtZVbWIXGtcDrsB4bDkw=;
  b=fqdh8ztzdsvQ5VM1cjARap/pgN4O5jlk7Q4G3U//JOqLTwZMIs3mNof+
   bE8EOxsC2I2hktm6si9Is7njA8i5XhfsSLliYVs0fpKqpfVcxH+pUwAy2
   FmCQtnm9rTP6n/UazTw1pbOdGqqGhq9GbL3Yi/lCsHYRPOISs7jBEpzP/
   FtTsiTaiwGuvP2IPTFWhIJnlUco4HmQmEVkaedxN4daPr4RUx7Y7ucYsR
   r2x9lTrsosjOpsNz0PjwbiVZzhEvCjV8XXsG51/NgYQqCbviaDVTSF5BM
   q5fxRqa6kLnuBeifYdBSLrc20Gx0x6M71W606bSbZa2PgeQqMBEHIHTm1
   A==;
X-CSE-ConnectionGUID: t4hXl82vSVKuC81rs16AAw==
X-CSE-MsgGUID: AbHG4RRGQ4GsDGHHl1bO5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="12230954"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="12230954"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:11:11 -0700
X-CSE-ConnectionGUID: oB/MuTJbRQKx66ZebZTTzA==
X-CSE-MsgGUID: M8z4ZsS0TdulTJR0eQX1CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="52384837"
Received: from kkolacin-desk1.igk.intel.com ([10.102.102.152])
  by fmviesa001.fm.intel.com with ESMTP; 12 Apr 2024 06:11:08 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v8 iwl-next 00/12] Introduce ETH56G PHY model for E825C products
Date: Fri, 12 Apr 2024 15:06:43 +0200
Message-ID: <20240412131104.322851-14-karol.kolacinski@intel.com>
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
          - ice: Move CGU block
          - ice: Introduce ETH56G PHY model for E825C products

V5 -> V6: Changes in:
          - ice: Move CGU block

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
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3592 +++++++++++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  288 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
 13 files changed, 3871 insertions(+), 912 deletions(-)


base-commit: df238859a090c8e9eae88eb58b4cb267304f7988
-- 
2.43.0


