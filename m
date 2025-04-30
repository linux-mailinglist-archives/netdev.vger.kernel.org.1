Return-Path: <netdev+bounces-187169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66746AA582A
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 00:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230F53B8552
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F3226CF8;
	Wed, 30 Apr 2025 22:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYOCqhMU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAFC34545
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053503; cv=none; b=XIHAle6RK52LKyHCUmjbQkID22czCTPl3tbWSTwUlCpYbt9dqHpXcW22KWKWbB7GzGocA/b53FGm9cZaIGSdFHFFbrJv6M/h3Qatejjormyj4dP4kfaReREt4JqsPNvek6ohO+7077IT4yC9U6VZ2IPNiUyrwdi5exwsB+U/7wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053503; c=relaxed/simple;
	bh=KK3dNEhgw/GTE+XcYq3o2kJsiK5m4hTbVIgJsntdH1E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=n8ijB+cbMaNjLmJ2Kz5xGAds+2dc6UyVG8yVgbDYsnly8Q/TQztSkxaAbvn2dMtX3tFGXx20AOB4kJE3MatKN/bZk/l6DhlkmOnMnVo+JYxHbkNIN+TEbQW/PGWMKuYGJiaoWD88hh3dKKyuaQ135vpNwQ+prAYgrU7Vsu7fzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYOCqhMU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746053501; x=1777589501;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=KK3dNEhgw/GTE+XcYq3o2kJsiK5m4hTbVIgJsntdH1E=;
  b=MYOCqhMUT7ASytJm42fMI2bsrmwJhTF32fh/FoZUcVQlFmAkBuP7jtNl
   XMjgRbUZ1AGhjjgJGwCnr6lP1d5F1T0LMFZ3HHyO+SvpyCOO4lR5yfgma
   +PT+CVGnlw7w11vOVXUBR/qeEPSPv03QtWA1EPHZvThHaB/VZydAEiI9H
   vRFCikffyLYBzPjl4kvPrCqPfvuaHO02WjMlxfL8S5t7+qbG9NDCtZZ1e
   Tius7I2XMt718BeiFh83xp+eO+5M8eZcFzFxe9fu1ok7OzjhOr3nNydqn
   INVvHaJDfCnEjgukOwW8aMlDYBRpK485sBVGrXy5q89SY2G5rqZRhXgxL
   A==;
X-CSE-ConnectionGUID: 52cshEvSSW6gR0WQElvDPg==
X-CSE-MsgGUID: +643FzUjRlitga9E/UWsGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="73120884"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="73120884"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
X-CSE-ConnectionGUID: Jumn1DZUQPipNouzckLrQQ==
X-CSE-MsgGUID: aOggiD2ATSGiAlPZ9hp06A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="134145065"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 15:51:40 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v3 00/15] ice: Separate TSPLL from PTP and clean up
Date: Wed, 30 Apr 2025 15:51:31 -0700
Message-Id: <20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOpEmgC/x2NywqEMAwAf0VyNlDr+vwV8dDVqMFaSyMiiP++X
 W8zl5kbhAKTQJvcEOhk4d1FydMEhsW4mZDH6KCVLtQnq3Bd8RBvLfLmw37SRu4QNJZn90fUw1d
 VtRmnpswgVnygia/30PXP8wM1doexcQAAAA==
X-Change-ID: 20250417-kk-tspll-improvements-alignment-2cb078adf961
To: Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>, 
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Milena Olech <milena.olech@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>
X-Mailer: b4 0.14.2

Separate TSPLL related functions and definitions from all PTP-related
files and clean up the code by implementing multiple helpers.

Adjust TSPLL wait times and fall back to TCXO on lock failure to ensure
proper init flow of TSPLL.

Change default clock source for E825-C from TCXO to TIME_REF if its
available.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v3:
- Add SPDX headers to new files
- Fix .dest_dev assignments in patch #1
- Drop accidental re-sizing of e82x misc15 field in v2 #2
- Split v2 patch #6, with behavioral changes in new patch #3 and #8
- Split v2 patch #3, with removal of E825-C array to its own patch #4
- Fix kernel doc warnings
- Add a patch to also update the default E825-C clock source to TIME_REF
- Link to v2: https://lore.kernel.org/intel-wired-lan/20250409122830.1977644-12-karol.kolacinski@intel.com/

---
Jacob Keller (4):
      ice: fix E825-C TSPLL register definitions
      ice: clear time_sync_en field for E825-C during reprogramming
      ice: read TSPLL registers again before reporting status
      ice: change default clock source for E825-C

Karol Kolacinski (11):
      ice: move TSPLL functions to a separate file
      ice: rename TSPLL and CGU functions and definitions
      ice: remove ice_tspll_params_e825 definitions
      ice: use designated initializers for TSPLL consts
      ice: add TSPLL log config helper
      ice: add ICE_READ/WRITE_CGU_REG_OR_DIE helpers
      ice: use bitfields instead of unions for CGU regs
      ice: add multiple TSPLL helpers
      ice: wait before enabling TSPLL
      ice: fall back to TCXO on TSPLL lock fail
      ice: move TSPLL init calls to ice_ptp.c

 drivers/net/ethernet/intel/ice/ice.h            |   1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h   | 181 --------
 drivers/net/ethernet/intel/ice/ice_common.h     |  58 +++
 drivers/net/ethernet/intel/ice/ice_ptp_consts.h | 177 +-------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h     |  54 +--
 drivers/net/ethernet/intel/ice/ice_tspll.h      |  31 ++
 drivers/net/ethernet/intel/ice/ice_type.h       |  20 +-
 drivers/net/ethernet/intel/ice/ice_common.c     |  71 ++-
 drivers/net/ethernet/intel/ice/ice_ptp.c        |  14 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c     | 564 +-----------------------
 drivers/net/ethernet/intel/ice/ice_tspll.c      | 518 ++++++++++++++++++++++
 drivers/net/ethernet/intel/ice/Makefile         |   2 +-
 12 files changed, 712 insertions(+), 979 deletions(-)
---
base-commit: deeed351e982ac4d521598375b34b071304533b0
change-id: 20250417-kk-tspll-improvements-alignment-2cb078adf961

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


