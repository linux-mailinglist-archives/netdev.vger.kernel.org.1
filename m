Return-Path: <netdev+bounces-157818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED8A0BE78
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 18:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6ECB18867C6
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 17:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AB720F078;
	Mon, 13 Jan 2025 17:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WDzqAvY2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7497F1C5D77
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788262; cv=none; b=oBn8+ucCU5T/yN1S+vNR7VguRtHNPQbBSATU1k32Yhq/G4p4/rdJIuLScuBoNlLQTWqjpB7Xwb2osc54OgFRjfh6b9+Bum+rjDKMww0itwRHLCPC6JfZZj4yZVypDXmRd/Wz6jNpJ+wxqCV9/CN7RnJ33mQjtBLb5R/zDOaWMr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788262; c=relaxed/simple;
	bh=15JdyYSaKi30v601K2OvHWk5bNjotLlY0cBEC/OW20I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=optPPqpqjfcP3qS4pYVM3Zridm47ypzaw8blAmnXajO4nizxVl4vhF20RJsegFRdZ49BoaUPfdQN6xJpvtTxhOYyEUgObs4w6kWTy0ZvS+aqYPYaQGgHLzTlx+83MuBr4JS+mvEsYvCnSh+uEZbQOBVVgpHAjh8TrUVE/S6ec3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WDzqAvY2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736788261; x=1768324261;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=15JdyYSaKi30v601K2OvHWk5bNjotLlY0cBEC/OW20I=;
  b=WDzqAvY2npTk6U56P7DyGsHKa/IDLQlARw+VZs/vzlcdXcRhOoSbqumK
   QtOTTArW5InpqLsHGEEFDlCG2LpdPjiPGzk2N72TCH5jOWnnZtjw9zYpU
   sOAkrYJinWkANl++kqiToMlx2Hn/Q/QsqSBB9r0udKEMfVb/cEZw27V0a
   bPimDo8CSBfQxuBuUM7IdCrPgSUuXqT34aDxvK+R/Kii5GCRWixMgLuCH
   Xv58O6EJvDAKb82wRq9nMqWUYKdimjX2+dS/2+gpf9UzbVfKO91hA4LZv
   5BuHU/EzkEyPbrZsfhuN9yJLmRnvE452cJchnrPcmajcoYISQfqanWcXr
   w==;
X-CSE-ConnectionGUID: L6gcr48cST+4Om2K2XSyDg==
X-CSE-MsgGUID: WOA5foKmTjWhtQtnOOS3BQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="36748789"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="36748789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:10:58 -0800
X-CSE-ConnectionGUID: 0s/t8HvGTFCJsFPzeaMzBw==
X-CSE-MsgGUID: d2XKZX1qSwa49Bm73J7XWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104499532"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.26])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:10:50 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	michael.chan@broadcom.com,
	tariqt@nvidia.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jdamato@fastly.com,
	shayd@nvidia.com,
	akpm@linux-foundation.org,
	shayagr@amazon.com,
	kalesh-anakkur.purayil@broadcom.com,
	pavan.chebbi@broadcom.com,
	yury.norov@gmail.com,
	darinzon@amazon.com,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v5 0/6] net: napi: add CPU affinity to napi->config
Date: Mon, 13 Jan 2025 10:10:36 -0700
Message-ID: <20250113171042.158123-1-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers usually need to re-apply the user-set IRQ affinity to their IRQs
after reset. However, since there can be only one IRQ affinity notifier
for each IRQ, registering IRQ notifiers conflicts with the ARFS rmap
management in the core (which also registers separate IRQ affinity
notifiers).   

Move the IRQ affinity management to the napi struct. This way we can have
a unified IRQ notifier to re-apply the user-set affinity and also manage
the ARFS rmaps. Patches 1 and 2 move the ARFS rmap management to CORE.
Patch 3 adds the IRQ affinity mask to napi_config and re-applies the mask
after reset. Patches 4-6 use the new API for bnxt, ice and idpf drivers.

Tested on bnxt, ice and idpf.

V5:
    - Add kernel doc for new netdev flags (Simon).
    - Remove defensive (if !napi) check in napi_irq_cpu_rmap_add()
      (patch 2) since caller is already dereferencing the pointer (Simon).
    - Fix build error when CONFIG_ARFS_ACCEL is not defined (patch 3).

v4:
    - https://lore.kernel.org/netdev/20250109233107.17519-1-ahmed.zaki@intel.com/
    - Better introduction in the cover letter.
    - Fix Kernel build errors in ena_init_rx_cpu_rmap() (Patch 1)
    - Fix kernel test robot warnings reported by Dan Carpenter:
      https://lore.kernel.org/all/202501050625.nY1c97EX-lkp@intel.com/
    - Remove unrelated empty line in patch 4 (Kalesh Anakkur Purayil)
    - Fix a memleak (rmap was not freed) by calling cpu_rmap_put() in
      netif_napi_affinity_release() (patch 2).

v3:
    - https://lore.kernel.org/netdev/20250104004314.208259-1-ahmed.zaki@intel.com/
    - Assign one cpu per mask starting from local NUMA node (Shay Drori).
    - Keep the new ARFS and Affinity flags per nedev (Jakub).

v2:
    - https://lore.kernel.org/netdev/202412190454.nwvp3hU2-lkp@intel.com/T/
    - Also move the ARFS IRQ affinity management from drivers to core. Via
      netif_napi_set_irq(), drivers can ask the core to add the IRQ to the
      ARFS rmap (already allocated by the driver).

RFC -> v1:
    - https://lore.kernel.org/netdev/20241210002626.366878-1-ahmed.zaki@intel.com/
    - move static inline affinity functions to net/dev/core.c
    - add the new napi->irq_flags (patch 1)
    - add code changes to bnxt, mlx4 and ice.

Ahmed Zaki (6):
  net: move ARFS rmap management to core
  net: napi: add internal ARFS rmap management
  net: napi: add CPU affinity to napi_config
  bnxt: use napi's irq affinity
  ice: use napi's irq affinity
  idpf: use napi's irq affinity

 drivers/net/ethernet/amazon/ena/ena_netdev.c |  38 +----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  52 +------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h    |   2 -
 drivers/net/ethernet/intel/ice/ice.h         |   3 -
 drivers/net/ethernet/intel/ice/ice_arfs.c    |  17 +--
 drivers/net/ethernet/intel/ice/ice_base.c    |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |   6 -
 drivers/net/ethernet/intel/ice/ice_main.c    |  47 +-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  22 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   6 +-
 include/linux/cpu_rmap.h                     |   1 +
 include/linux/netdevice.h                    |  31 +++-
 lib/cpu_rmap.c                               |   2 +-
 net/core/dev.c                               | 151 ++++++++++++++++++-
 15 files changed, 205 insertions(+), 181 deletions(-)

-- 
2.43.0


