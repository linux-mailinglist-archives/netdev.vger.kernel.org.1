Return-Path: <netdev+bounces-174084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFEDA5D60C
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 07:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52695189CB48
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E301E4929;
	Wed, 12 Mar 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jWfAKPik"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E651E3DED
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760671; cv=none; b=CFVtsDleUMIBXpKCTUJoGDg3JXrInLZ5lj2WEj3YiSqC+axSJMqzGzOC3++pQc51BxmdCDvpVirsahyXzdPMeLiGhUc4OAU9bdztwe6FAIJkileAzCTGVdmitW+pyf+relb1DdmIyN+KIJ4E2yOYFa6stPB4H6sBnriHeBDHqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760671; c=relaxed/simple;
	bh=YJkTHWF93HF5H/UtYfuCsyxZwj3cgBwPqIwMndptGa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTF7etXKpWyBvka3ivY3kqCyMQzKPjpvuw8FE5DYwfVFqc9EYKB6l5HU1IWl2EBI8SBs7sSDUz8tWZmqSVhTb9GVyQwMkeQImPHXjP9Oi0+HX99OEOrJqC5kqItQ3/xp5cqDmY2nDbRq3tDJ9UqQ1Z05xzjfGB+0DE6m1yDD0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jWfAKPik; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741760670; x=1773296670;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YJkTHWF93HF5H/UtYfuCsyxZwj3cgBwPqIwMndptGa4=;
  b=jWfAKPikYMvet29zasJIlNL5jSzrW/j7PbTBEAWK6T7SD05LqXJnJO+F
   iN6bbONTYPevZO8ItQjPhCxCmOkjFlRDRmJtY1m5wRggVyeuMY5ypGxTS
   2II1m430EP2DjsBnR1xWGUDRlVn2tc7NhZgADAt1uRA1EKdo4W/pISFIX
   fj6CcdWmIAAxoVmFUzUuU9QbmleA3Z7CIO6XlbPxLnbmHTVfk77i845ee
   QfRTRqcbvU0qias+PkFSlfdjBeCD8/YKE9vSBlG9ZjT02U1EZs9qplI5n
   078l9kMgHBTQXrg2unu2W5FcCB3L3zKevjfk1X2WDyIlXhX1/0UGs8dYN
   g==;
X-CSE-ConnectionGUID: /Cpx8j42R1a9GXA4M6qJnQ==
X-CSE-MsgGUID: LwdB9re4TPOuOIlTa+Rztg==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="43005538"
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="43005538"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 23:24:30 -0700
X-CSE-ConnectionGUID: royPC8NbTtqI2mbHIzrDbg==
X-CSE-MsgGUID: 7kJMwHZ9SCSTpg7oRO6fTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,240,1736841600"; 
   d="scan'208";a="120569466"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa007.fm.intel.com with ESMTP; 11 Mar 2025 23:24:27 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com,
	larysa.zaremba@intel.com
Subject: [iwl-next v1 0/8] libie: commonize adminq structure
Date: Wed, 12 Mar 2025 07:24:18 +0100
Message-ID: <20250312062426.2544608-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

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
 drivers/net/ethernet/intel/libie/Kconfig      |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   4 +
 drivers/net/ethernet/intel/i40e/i40e_adminq.h |  12 +-
 .../net/ethernet/intel/i40e/i40e_adminq_cmd.h | 155 +---
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  15 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.h |  12 +-
 .../net/ethernet/intel/iavf/iavf_adminq_cmd.h |  83 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   1 -
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   | 267 +------
 drivers/net/ethernet/intel/ice/ice_common.h   |   6 +-
 drivers/net/ethernet/intel/ice/ice_controlq.h |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |  12 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 226 +-----
 include/linux/net/intel/libie/adminq.h        | 309 ++++++++
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  68 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c |   7 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c | 730 ++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |   8 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |  46 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  36 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 240 +++---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  18 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  27 +-
 drivers/net/ethernet/intel/iavf/iavf_adminq.c |  62 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c | 110 +--
 drivers/net/ethernet/intel/iavf/iavf_main.c   |   5 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |   2 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  10 +-
 .../net/ethernet/intel/ice/devlink/health.c   |   6 +-
 drivers/net/ethernet/intel/ice/ice_common.c   | 376 ++++-----
 drivers/net/ethernet/intel/ice/ice_controlq.c |  53 +-
 drivers/net/ethernet/intel/ice/ice_dcb.c      |  36 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |  47 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     |  20 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  12 +-
 .../net/ethernet/intel/ice/ice_fw_update.c    |  38 +-
 drivers/net/ethernet/intel/ice/ice_fwlog.c    |  16 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  63 +-
 drivers/net/ethernet/intel/ice/ice_nvm.c      |  38 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  20 +-
 drivers/net/ethernet/intel/ice/ice_sched.c    |  18 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  55 +-
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c   |   6 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |   6 +-
 .../net/ethernet/intel/ice/ice_vlan_mode.c    |   6 +-
 .../net/ethernet/intel/ice/ice_vsi_vlan_lib.c |  24 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 272 +++----
 .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |   4 +-
 drivers/net/ethernet/intel/libie/adminq.c     |  50 ++
 58 files changed, 1567 insertions(+), 2128 deletions(-)
 create mode 100644 include/linux/net/intel/libie/adminq.h
 create mode 100644 drivers/net/ethernet/intel/libie/adminq.c

-- 
2.42.0


