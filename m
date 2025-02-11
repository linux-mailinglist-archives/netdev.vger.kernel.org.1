Return-Path: <netdev+bounces-165283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51256A31738
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA30916234B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96644264F9E;
	Tue, 11 Feb 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZkvLgcw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBCA2641CA
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739308040; cv=none; b=D5LFVDaB19W4L7F8emCEf/l1x39e1v4B4XGDh/aMwVWPHzM33eWjBKiJo1JITDu09ZhfQdwRbRjzP/B7UviQ203E8enuFO/i4rjxMKvO9u3H1iwsFWRCdakyahiQy539pinHc6hihNS3c05E+B+KHwJOfWA675ywRanYgTI1Ujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739308040; c=relaxed/simple;
	bh=TFm6w0dYBEDVb2VwN+9OC/vGM8GxlTiGPZz0LGBO/m8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Asf4NEsIkUNVaJ0Zsn5dN5yLULcs+qa/kYLGnXq1uWp6+P+mGaLvJ0T8okgouC45T1HSx5alGNum9Hj0+hOzlSZPRi0AjRrkr3Cjo+W3GUHKfU/9gSh8o6eknpfvd3ogj8XdsXDS+hkGzYZPdO7TW2vWBo4hJjiQCMwx2FaZiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZkvLgcw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739308039; x=1770844039;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TFm6w0dYBEDVb2VwN+9OC/vGM8GxlTiGPZz0LGBO/m8=;
  b=PZkvLgcwPb6r+eSDDwbgfAvP52IU2DDTmVJt7acjZDhIg23IfRd1xP6p
   AS0tpelS+QEzqM6PzebLAXvkuaVju1a69VR1DBgb9zwy842lgMMTNBtCy
   +ZnLZ3H0Nb1kjT9fm+9GMA7BNW7Y6AgoHL6W1z6VfzxVpjmFRRorKB21H
   Fd9w7806DF0tz3a3MaD59O16FIa896vG6AYHERp0fJ28Z6jA2TU6AePI2
   ROsoWEQ+B7wPr6d5UuJC0LYyfYOALyAWlqcslwuXG9GTLan6hg7DQbNXj
   ijU5k8ZLoRxVTzv+2VHPJC2BwzLL/PIsC67CzOhbvyzDtLP8yrYjegu1R
   w==;
X-CSE-ConnectionGUID: ymhri8mSTze8Yqb9NN0PJw==
X-CSE-MsgGUID: zjmNee6NRfuS+H1cH03JUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="51339586"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="51339586"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:18 -0800
X-CSE-ConnectionGUID: ZR390SP9T52V7LbOgqkplA==
X-CSE-MsgGUID: mvMugSqhQj202VYZ+klHow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116713214"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO azaki-desk1.intel.com) ([10.125.108.7])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 13:07:11 -0800
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
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH net-next v8 0/6] net: napi: add CPU affinity to napi->config
Date: Tue, 11 Feb 2025 14:06:51 -0700
Message-ID: <20250211210657.428439-1-ahmed.zaki@intel.com>
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
the ARFS rmaps.

Ice does not always delete the NAPIS before releasing the IRQs. The first
patch makes sure the driver removes the IRQ number along with the queue
when the NAPIs are disabled. Without this, the next patches in this series
would free the IRQ before releasing the IRQ notifier (which generates
warnings).

The second patch moves the ARFS rmap management to CORE. Patch 3 adds the
IRQ affinity mask to napi_config and re-applies the mask after reset.
Patches 4-6 use the new API for bnxt, ice and idpf drivers.

Tested on bnxt, ice and idpf.

V8:
    - Add a new patch in "ice" that releases the IRQs and their notifiers
      when clearing the NAPI queues (pls read 3rd paragraph above).
    - Add a new NAPI flag "NAPI_STATE_HAS_NOTIFIER" that simplifies the
      code for IRQ notifier detection (Patch 2).
    - Move the IRQ notifier auto-removal to napi_delete() instead of
      napi_disable(). This is the reason for the new ice patch. (Jakub)
    - Add a WARN_ON_ONCE(!napi->config) in netif_napi_set_irq_locked().
      This would detect drivers that asked for irq_affinity_auto but did
      not use napi_add_config(). (Patch 3) (Joe)
    - Rename netif_enable_irq_affinity() to netif_set_affinity_auto()
      (Patch 3) (Jakub).
V7:
    - https://lore.kernel.org/netdev/20250204220622.156061-1-ahmed.zaki@intel.com/
    - P1: add documentation for netif_enable_cpu_rmap()
    - P1: move a couple of "if (rx_cpu_rmap_auto)" from patch 1 to patch 2
      where they are really needed.
    - P1: remove a defensive "if (!rmap)"
    - p1: In netif_disable_cpu_rmap(), remove the for loop that frees
          notifiers since this is already done in napi_disable_locked().
          Also rename it to netif_del_cpu_rmap().
    - P1 and P2: simplify the if conditions in netif_napi_set_irq_locked()
    - Other nits

V6:
    - https://lore.kernel.org/netdev/20250118003335.155379-1-ahmed.zaki@intel.com/
    - Modifications to have less #ifdef CONFIG_RF_ACCL guards
    - Remove rmap entry in napi_disable
    - Rebase on rc7 and use netif_napi_set_irq_locked()
    - Assume IRQ can be -1 and free resources if an old valid IRQ was
      associated with the napi. For this, I had to merge the first 2
      patches to use the new rmap API.

V5:
    - https://lore.kernel.org/netdev/20250113171042.158123-1-ahmed.zaki@intel.com/
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
  ice: clear NAPI's IRQ numbers in ice_vsi_clear_napi_queues()
  net: move ARFS rmap management to core
  net: napi: add CPU affinity to napi_config
  bnxt: use napi's irq affinity
  ice: use napi's irq affinity
  idpf: use napi's irq affinity

 Documentation/networking/scaling.rst         |   6 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c |  43 +----
 drivers/net/ethernet/broadcom/bnxt/bnxt.c    |  54 +-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h    |   2 -
 drivers/net/ethernet/intel/ice/ice.h         |   3 -
 drivers/net/ethernet/intel/ice/ice_arfs.c    |  33 +---
 drivers/net/ethernet/intel/ice/ice_arfs.h    |   2 -
 drivers/net/ethernet/intel/ice/ice_base.c    |   7 +-
 drivers/net/ethernet/intel/ice/ice_lib.c     |  16 +-
 drivers/net/ethernet/intel/ice/ice_main.c    |  47 +----
 drivers/net/ethernet/intel/idpf/idpf_lib.c   |   1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c  |  22 +--
 drivers/net/ethernet/intel/idpf/idpf_txrx.h  |   6 +-
 include/linux/cpu_rmap.h                     |   1 +
 include/linux/netdevice.h                    |  28 ++-
 lib/cpu_rmap.c                               |   2 +-
 net/core/dev.c                               | 172 ++++++++++++++++++-
 17 files changed, 233 insertions(+), 212 deletions(-)

-- 
2.43.0


