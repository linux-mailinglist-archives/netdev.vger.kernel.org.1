Return-Path: <netdev+bounces-209835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81537B110DE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0D237AE2EE
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECE92ECD0A;
	Thu, 24 Jul 2025 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ffT+Bbr7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0D244EA1
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381719; cv=none; b=BsTRaT2xfiuiAgyKJYvklRoaDR7cHq3JgLB0KWhZotM98hX6IdwCAPp7TCVStSoUAl7z9FY9r/SyUua2yoYG9Uv2Mk1/wGSXo1O7Loajf5PPPogQoaGd0yatzn5EoRyGGpaLCNl4l8m4TL4Dr0lAvN0APYm552yr9AqkAe4XC4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381719; c=relaxed/simple;
	bh=HU2p8x5jOzp4RatuFp+pnYhlYGpS+NZa63h7+j3Jw5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ueob5ODO/MQX67lF07hgV0HXD39ORx6bZI1pq5z+tB/oTwxFIfQFuTCn57J7LKli92OtzqbjWc0Ok8wL0Aq5FrONZ9JUR1ptxEOjrE2CE6aaxWdjsKmU9tnaKbo3jQtWV2S774Dvk+6+/6QXwi53VALLJ9zdzx8b2PBvKDGJ+Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ffT+Bbr7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753381718; x=1784917718;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HU2p8x5jOzp4RatuFp+pnYhlYGpS+NZa63h7+j3Jw5k=;
  b=ffT+Bbr7qWKeZcSCpyG7iHM5edOKw5wsSFJo/j0YjL6v51Q9GYi5IzAz
   AtkGjSHHde4Bo2SJSxd4z83jgRhW2NfKQmm8OaEDRBlurWG9h/SOBX42G
   WHIh6Mbf70PEaM70GFfzSiGIkimKGQBXBAEglL6WopHeqL94VwSZrKRre
   DVR1AtI6nWkb5mogogBZ6YwxgXSevbnmgfoFGBp2kCbvf7H4VtOSzIzfk
   MjZUyPlWXmM6E4bE4E0ofoS+A7cl8TzmswDAQuCbhmL6jugjOrh/BZe91
   9D4XeGIYzZxicSEgSKGW2WogxeRwKUKuUVJ8VJxcY02NxqiSfRGToWiAR
   A==;
X-CSE-ConnectionGUID: FR16cL9sQHCHZjZTwynWPg==
X-CSE-MsgGUID: 6idoZ1g/TwuTS0boWWAWkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55861354"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55861354"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:28:36 -0700
X-CSE-ConnectionGUID: ae++s/3UQN6zkeGubu2yUg==
X-CSE-MsgGUID: zf0gVRL9SxGMkNq6J7V2zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="161096486"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jul 2025 11:28:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com,
	larysa.zaremba@intel.com
Subject: [PATCH net-next 0/8][pull request] libie: commonize adminq structure
Date: Thu, 24 Jul 2025 11:28:16 -0700
Message-ID: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski says:

It is a prework to allow reusing some specific Intel code (eq. fwlog).

Move common *_aq_desc structure to libie header and changing
it in ice, ixgbe, i40e and iavf.

Only generic adminq commands can be easily moved to common header, as
rest is slightly different. Format remains the same. It will be better
to correctly move it when it will be needed to commonize other part of
the code.

Move *_aq_str() to new libie module (libie_adminq) and use it across
drivers. The functions are exactly the same in each driver. Some more
adminq helpers/functions can be moved to libie_adminq when needed.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250425060809.3966772-1-michal.swiatkowski@linux.intel.com/

The following are changes since commit 94619ea2d933a2efeea5af63ec909bf2f1519a0e:
  Merge tag 'ipsec-next-2025-07-23' of git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Michal Swiatkowski (8):
  ice, libie: move generic adminq descriptors to lib
  ixgbe: use libie adminq descriptors
  i40e: use libie adminq descriptors
  iavf: use libie adminq descriptors
  libie: add adminq helper for converting err to str
  ice: use libie_aq_str
  iavf: use libie_aq_str
  i40e: use libie_aq_str

 drivers/net/ethernet/intel/Kconfig            |   3 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  68 +-
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  12 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 155 +---
 drivers/net/ethernet/intel/i40e/i40e_client.c |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c | 730 ++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   8 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  46 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  36 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 240 +++---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  18 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  15 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   6 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  27 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.c |  62 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h |  12 +-
 .../net/ethernet/intel/iavf/iavf_adminq_cmd.h |  83 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c | 110 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   5 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   |   2 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  10 +-
 .../net/ethernet/intel/ice/devlink/health.c   |   6 +-
 drivers/net/ethernet/intel/ice/ice.h          |   1 -
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 270 +------
 drivers/net/ethernet/intel/ice/ice_common.c   | 384 ++++-----
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_controlq.c |  53 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h |   8 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c      |  36 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |  47 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     |  26 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  12 +-
 .../net/ethernet/intel/ice/ice_fw_update.c    |  38 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c    |  16 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  67 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c      |  38 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  16 +-
 drivers/net/ethernet/intel/ice/ice_sched.c    |  18 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  55 +-
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c   |   6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   6 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |   6 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  24 +-
 .../net/ethernet/intel/ixgbe/devlink/region.c |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 272 +++----
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +-
 .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |   4 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 226 +-----
 drivers/net/ethernet/intel/libie/Kconfig      |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   4 +
 drivers/net/ethernet/intel/libie/adminq.c     |  52 ++
 include/linux/net/intel/libie/adminq.h        | 308 ++++++++
 59 files changed, 1575 insertions(+), 2142 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libie/adminq.c
 create mode 100644 include/linux/net/intel/libie/adminq.h

-- 
2.47.1


