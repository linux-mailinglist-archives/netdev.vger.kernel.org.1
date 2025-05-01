Return-Path: <netdev+bounces-187318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9871AA666E
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 00:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652981BC44B9
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 22:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAE02222B6;
	Thu,  1 May 2025 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d92pQjhq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6750E19F12D
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 22:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746140073; cv=none; b=JSkZnUDoxuZLCs67Od6JCWEAjpOCGB/8LWebWbxTZ5fj6RDUTOP3Ndus8SznQ38yUORObGBCpwMhdotfExTrlyIh31W67cXGLVby/h5ZfBt6ZjWuPxBNeEVNStOtqOEb/8/NSs1XOYIfllsOCJeYoxCbd5CLuIbDpn3Q+Qu7l/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746140073; c=relaxed/simple;
	bh=npbzd8YVDzReRS2nEhdUgTqdeSXEFuHyZrYqC+awAy8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GBWiGPBrLgOO1W5Obx0/jyUqhHFxVc+jOtblKDyTc8OepCRG+pQdC8iLUtH+9mxAVGJUBOgKF+hDQ+jDo9fSxEZKkwgFCCM9NE74MpckYAYOql3/SfSF41L0m1rUi9u9kk+cxMZupwXADlu56bf8ecTQWs3H/8H9dOvTsHMEfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d92pQjhq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746140072; x=1777676072;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=npbzd8YVDzReRS2nEhdUgTqdeSXEFuHyZrYqC+awAy8=;
  b=d92pQjhqgnj99sw64MK9508/K5OBWZVdg++gb5Li7TfHO1zjpbYOGMiy
   L6Lad+L9KYEG/nOgzeD0VKUgzjjmF7ojiyE1AuKUMu5AfnXjtB6Jl7mzC
   rVjbTQYwCLJ90G8JNFV/cWTluCXaqY5tjd+gmcK/oooCzOqtdOVzJz+CY
   u3aUCP54MaQUw8iOQcH5UJYKly5XRf4QYscluXnDlR5m8B0TGUJzoGOT9
   g1kb/YWaeCFJFj8RTfYMRdFT/n33QqaWzhwhu95FJ1OH3hLN19FdR5ogy
   13vH/QQchSDA1I0PTIUSo80ftW1ivbOmNUqsQYJjiZ0P3xUrt0AsiF1SI
   Q==;
X-CSE-ConnectionGUID: YQaUijapS0Spgpt+qtyPxA==
X-CSE-MsgGUID: fhO06OSyS6ywRYvX0j9hlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11420"; a="58811698"
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="58811698"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:31 -0700
X-CSE-ConnectionGUID: /NoSdGhbTsapKidFYHIG8g==
X-CSE-MsgGUID: OXh18hciQ4qvDmN26cLnBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,254,1739865600"; 
   d="scan'208";a="138514267"
Received: from jekeller-desk.jf.intel.com ([10.166.241.15])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 15:54:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH v4 00/15] ice: Separate TSPLL from PTP and clean up
Date: Thu, 01 May 2025 15:54:11 -0700
Message-Id: <20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJT7E2gC/4WNwQ6DIBAFf8Vw7jaIVG1P/Y/GA+qqGxEMENLG+
 O9F03tvb95hZmMeHaFnj2xjDiN5siaBvGSsm5QZEahPzAQXNy7zCuYZgl+1BlpWZyMuaIIHpWk
 0xwTRtbyqVT/cy5wly+pwoPdZeDWJJ/LBus8ZjMXx/twF/+uOBXBQbS0rgXUpuHySCaivnV1Ys
 +/7FztdYIjOAAAA
X-Change-ID: 20250417-kk-tspll-improvements-alignment-2cb078adf961
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, 
 Anthony Nguyen <anthony.l.nguyen@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Karol Kolacinski <karol.kolacinski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Milena Olech <milena.olech@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: b4 0.14.2

Separate TSPLL related functions and definitions from all PTP-related
files and clean up the code by implementing multiple helpers.

Adjust TSPLL wait times and fall back to TCXO on lock failure to ensure
proper init flow of TSPLL.

Change default clock source for E825-C from TCXO to TIME_REF if its
available.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v4:
- Rebase onto Intel Wired LAN dev-queue
- Restore use of string choice helpers
- Restore use of ice_debug()
- Improve title of commit to change the default clock source
- Link to v3: https://lore.kernel.org/r/20250430-kk-tspll-improvements-alignment-v3-0-ab8472e86204@intel.com

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
      ice: default to TIME_REF instead of TXCO on E825-C

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
base-commit: e3945f0d3dac6bf6231a5501766c3614cd6f7f45
change-id: 20250417-kk-tspll-improvements-alignment-2cb078adf961

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


