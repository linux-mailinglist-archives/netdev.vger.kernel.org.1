Return-Path: <netdev+bounces-84301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5D896724
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246511F2992D
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4371B5C8E2;
	Wed,  3 Apr 2024 07:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0qPaghF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9D219E5
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130620; cv=none; b=iWFApf0HdO9VJfWvMClTI7biRYhdPDEe4WGjs5wm7qEYa30b2V5huqQwZhZMd423vFS7riUOj9qfZqkIsGYCSTbMdLlkXGSVpxmo69UFK66cSonnny8pVphECnKc+NkL10YAotCnpJrOE+zXoWqLUHZNZdxY4flrZRdNFLEjrGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130620; c=relaxed/simple;
	bh=v3U9R3hX9VfIJR8X6zGBJRhrr7nCNNgpwlNhzMSfXXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRGL/wcQbnMW8mD7+XUWfkr+rzEM6Iudqrgn7hx245rEHlY0mmPjDStoacebeTouY0zU0gSO41I4CFguKFEyW7KJ4At2Rv2Rsp3KfobpI3nPV7ChpUxD+eOTv9b5jHiwKIimPOScHTxsCjIG5aXGYZaEHzx/6/NwWjIDYtg6Eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0qPaghF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712130618; x=1743666618;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v3U9R3hX9VfIJR8X6zGBJRhrr7nCNNgpwlNhzMSfXXI=;
  b=O0qPaghF/1M+fV27+74KWu9+ADVrSfibOSBCJJvyWmmXkArKquOmyLCS
   BdOUozHrgmn/eLfWDzzizzuf3jl+R4JU5Lfj39LmHYwnBaWlQKUnkGeBt
   fPOm/mJx1KiSPjUmjk8t0ZKs4ZzICe+9vRnALhV6tRTUljy98slf0cojV
   vsaZnU/uL0f3dPVECeHoeCx0GLYk+V4n4Qlh9JOQc6cyWoqk6hn/vXYn9
   aFz3id0RXdH0H0wJCDjrj0DdsInjPBByb8+FYbEnUm7vNUYgXiQcD00SQ
   a7RV53b3ETvMpnGSGL9oNsARUkU2uIZhvmVomAiqPV/EQqxC3lQd9lh6W
   Q==;
X-CSE-ConnectionGUID: lQHNWo6URTmbwvJaPGyCPQ==
X-CSE-MsgGUID: 8Rf2u82PSZmy0XkOYey0tg==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="10311867"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="10311867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 00:50:17 -0700
X-CSE-ConnectionGUID: BuNJNmGRT7iZ31jWMEqPxA==
X-CSE-MsgGUID: Fbk12bArSKSrUkvUNXMU6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="55790884"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2024 00:50:14 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id B5C3A369F7;
	Wed,  3 Apr 2024 08:50:08 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	kuba@kernel.org,
	jiri@resnulli.us,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	victor.raj@intel.com,
	michal.wilczynski@intel.com,
	lukasz.czapnik@intel.com,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH net-next v9 0/6] ice: Support 5 layer Tx scheduler topology
Date: Wed,  3 Apr 2024 03:41:06 -0400
Message-Id: <20240403074112.7758-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For performance reasons there is a need to have support for selectable
Tx scheduler topology. Currently firmware supports only the default
9-layer and 5-layer topology. This patch series enables switch from
default to 5-layer topology, if user decides to opt-in.

---
v9:
- rebased the code after devlink changes from Michal S

v8:
- fixed all drivers to use new *set pointer - commit 1
- added setting flag in ice_copy_and_init_pkg based on family - commit 2
- changed the way of registering devlink param - commit 5
- changed the name of devlink param to be more descriptive - commit 5
- added RB in commit 1 and commit 6
https://lore.kernel.org/netdev/20240326143042.9240-1-mateusz.polchlopek@intel.com/

v7:
- fixed comments from v6 in commit 1 (devlink changes) and commit 5 (ice_devlink changes)
- included Documentation change that should be in v6 (reboot -> PCI slot powercycle)
- added Reviewed-by tag to commit 1 (devlink changes) and commit 6 (Documentation)
https://lore.kernel.org/netdev/20240308113919.11787-1-mateusz.polchlopek@intel.com/

v6:
- extended devlink_param *set pointer to accept one more parameter - extack
- adjusted all drivers that use *set pointer to pass one more parameter
- updated Documentation - changed "reboot" to "PCI slot powercycle", kept Kuba's ACK
- removed "Error: " prefix from NL_SET_ERR_MSG_MOD function in ice_devlink.c
- removed/adjusted messages sent to end user in ice_devlink.c
https://lore.kernel.org/netdev/20240305143942.23757-1-mateusz.polchlopek@intel.com/

v5:
- updated Documentation commit as suggested in v4
https://lore.kernel.org/netdev/20240228142054.474626-1-mateusz.polchlopek@intel.com/

v4:
- restored the initial way of passing firmware data to ice_cfg_tx_topo
  function in ice_init_tx_topology function in ice_main.c file. In v2
  and v3 version it was passed as const u8 parameter which caused kernel
  crash. Because of this change I decided to drop all Reviewed-by tags.
https://lore.kernel.org/netdev/20240219100555.7220-1-mateusz.polchlopek@intel.com/

v3:
- fixed documentation warnings
https://lore.kernel.org/netdev/20231009090711.136777-1-mateusz.polchlopek@intel.com/

v2:
- updated documentation
- reorder of variables list (default-init first)
- comments changed to be more descriptive
- added elseif's instead of few if's
- returned error when ice_request_fw fails
- ice_cfg_tx_topo() changed to take const u8 as parameter (get rid of copy
  buffer)
- renamed all "balance" occurences to the new one
- prevent fail of ice_aq_read_nvm() function
- unified variables names (int err instead of int status in few
  functions)
- some smaller fixes, typo fixes
https://lore.kernel.org/netdev/20231006110212.96305-1-mateusz.polchlopek@intel.com/

v1:
https://lore.kernel.org/netdev/20230523174008.3585300-1-anthony.l.nguyen@intel.com/
---

Lukasz Czapnik (1):
  ice: Add tx_scheduling_layers devlink param

Mateusz Polchlopek (1):
  devlink: extend devlink_param *set pointer

Michal Wilczynski (2):
  ice: Enable switching default Tx scheduler topology
  ice: Document tx_scheduling_layers parameter

Raj Victor (2):
  ice: Support 5 layer topology
  ice: Adjust the VSI/Aggregator layers

 Documentation/networking/devlink/ice.rst      |  47 ++++
 .../marvell/octeontx2/otx2_cpt_devlink.c      |   9 +-
 drivers/net/ethernet/amd/pds_core/core.h      |   3 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  | 184 +++++++++++++++-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  32 +++
 drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 205 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   2 +
 .../net/ethernet/intel/ice/ice_fw_update.c    |   7 +-
 .../net/ethernet/intel/ice/ice_fw_update.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 102 +++++++--
 drivers/net/ethernet/intel/ice/ice_nvm.c      |   7 +-
 drivers/net/ethernet/intel/ice/ice_nvm.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_sched.c    |  37 ++--
 drivers/net/ethernet/intel/ice/ice_sched.h    |   3 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 .../marvell/octeontx2/af/rvu_devlink.c        |  12 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |   3 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   3 +-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |   3 +-
 .../ethernet/netronome/nfp/devlink_param.c    |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   3 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   6 +-
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   3 +-
 include/net/devlink.h                         |   3 +-
 include/net/dsa.h                             |   3 +-
 net/devlink/param.c                           |   7 +-
 net/dsa/devlink.c                             |   3 +-
 35 files changed, 645 insertions(+), 84 deletions(-)

-- 
2.38.1


