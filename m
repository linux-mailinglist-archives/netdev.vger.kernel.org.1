Return-Path: <netdev+bounces-183013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C80A8AB00
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E391901AA5
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2830A253B6B;
	Tue, 15 Apr 2025 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHRMFd2x"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E125525E;
	Tue, 15 Apr 2025 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744755190; cv=none; b=Bw0rI+2JgAR6VdCy4Za9uA8qUyaz3KozUnt/ohKupsWoyVOxZOXQRMfuyMxlBnnmbBcjh2V58ShgsWc2E4+IfVkPEfhgstKrXeGUsaaaCDheA5Jv+M4Vi8SJX68nWdvgqdcYRPaQQvBfF5x/22k/EqF4+ITD4fUhRbDXeqJkvF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744755190; c=relaxed/simple;
	bh=hOCFD0cESI6tKSbbpI6PgaKgPUQWS0wlQy3xgMwK3fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZNHg/lfMaIk0hGi3gNy4fmIU8Llug9XLKxg0B9uCr1CFkcNCsbwvcIomntlywQzcFNx8NXll5SuFIki9qp8iBDyHcis3JVOwc1u6a3hS7N9cNRL4lYi7DaeOs2tWzHxkVjxr9TgOT+UM7CFaijb9ypmu/rLBPnn1JXzF96WUwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHRMFd2x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744755188; x=1776291188;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hOCFD0cESI6tKSbbpI6PgaKgPUQWS0wlQy3xgMwK3fo=;
  b=bHRMFd2xsXDFHUrp9hNEy/eX7nS1Q1Tre9NRdy/WQ1ASz1Ip9fGw7mmh
   NUg19/jxyiZkXCCui9bIxFMWRz+tdYQO+R7CiOZPB9PExQyCUjUAFqNSr
   JSsnVZYPalaB3dHG1MSKyRcldrhkgyafhaT8hlzAJ1yCctGpfzSWKBf8j
   xUh1WJanU3N8PzPCfqw5UK3Fi+XwpFQ4GaV/fFc85/OMBFKFGsQZ2Rp4f
   dVwQ5QNLys6zQpiHr9aEYo65nGWtm4foe7TgbGHyzhgq3UCPt1x99wsBO
   3N2ydg5Iu68TQxbhyXteCETEkb5BvPACNZ5Pht5y/vJrgqTdVcWSgRhNP
   g==;
X-CSE-ConnectionGUID: wZnyx3DTR4a7Nm0IqEb1wg==
X-CSE-MsgGUID: dmRSBFtqQ3CPAb2BFmsitQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46206587"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46206587"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 15:13:07 -0700
X-CSE-ConnectionGUID: VoT10cdPRQyfYAHBL+A7eA==
X-CSE-MsgGUID: HF2rpkvQSqWpA7DxRXtGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="131218519"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 15 Apr 2025 15:13:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com,
	jiri@resnulli.us,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v2 00/15][pull request] ixgbe: Add basic devlink support
Date: Tue, 15 Apr 2025 15:12:43 -0700
Message-ID: <20250415221301.1633933-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jedrzej Jagielski says:

Create devlink specific directory for more convenient future feature
development.

Flashing and reloading are supported only by E610 devices.

Introduce basic FW/NVM validation since devlink reload introduces
possibility of runtime NVM update. Check FW API version, FW recovery mode
and FW rollback mode. Introduce minimal recovery probe to let user to
reload the faulty FW when recovery mode is detected.
---
v2:
Patch 8
- Add devlink documentation for srev
Patch 10
- Report stored versions, using running version values, when no update is pending
- Move 'err' initialization from declaration, in ixgbe_set_ctx_dev_caps(),
  to group with its error check
- Introduce local vars in ixgbe_set_ctx_dev_caps() to avoid long lines.

v1: https://lore.kernel.org/netdev/20250407215122.609521-1-anthony.l.nguyen@intel.com/

IWL: https://lore.kernel.org/intel-wired-lan/20250313150346.356612-1-jedrzej.jagielski@intel.com/

The following are changes since commit e8a1bd8344054ce27bebf59f48e3f6bc10bc419b:
  net: ncsi: Fix GCPS 64-bit member variables
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

Andrii Staikov (1):
  ixgbe: add support for FW rollback mode

Jedrzej Jagielski (10):
  devlink: add value check to devlink_info_version_put()
  ixgbe: add initial devlink support
  ixgbe: add handler for devlink .info_get()
  ixgbe: add .info_get extension specific for E610 devices
  ixgbe: add E610 functions getting PBA and FW ver info
  ixgbe: extend .info_get() with stored versions
  ixgbe: add device flash update via devlink
  ixgbe: add support for devlink reload
  ixgbe: add FW API version check
  ixgbe: add E610 implementation of FW recovery mode

Przemek Kitszel (1):
  ixgbe: wrap netdev_priv() usage

Slawomir Mrozowicz (3):
  ixgbe: add E610 functions for acquiring flash data
  ixgbe: read the OROM version information
  ixgbe: read the netlist version information

 .../networking/devlink/devlink-info.rst       |    4 +
 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixgbe.rst    |  122 ++
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/ixgbe/Makefile     |    3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  557 ++++++
 .../ethernet/intel/ixgbe/devlink/devlink.h    |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   21 +
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |   56 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 1512 +++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   18 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   86 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |   12 +-
 .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |  707 ++++++++
 .../ethernet/intel/ixgbe/ixgbe_fw_update.h    |   12 +
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |   10 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  269 ++-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   16 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    5 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  161 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c  |    2 +-
 net/devlink/dev.c                             |    2 +-
 27 files changed, 3350 insertions(+), 243 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h

-- 
2.47.1


