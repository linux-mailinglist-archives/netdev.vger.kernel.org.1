Return-Path: <netdev+bounces-222313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04702B53D73
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 23:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D645A3019
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 21:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16CF02DAFC4;
	Thu, 11 Sep 2025 21:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IAlm1XxO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747DA2D23B8
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 21:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757624740; cv=none; b=m44X6OTKfquBcaQfaTPavnpsQAjRfxHpFln7QIQD2p5wCxiXPq0ZsCu+qsn/ZoZeVhTTojJbjj258y536OgiWdCq5CL/gQpSioi1pllhrE5YIzP2bhQ7+VoJHmIlqhsJznqBpZ4Ov0O/ZvDy3V+Dj4BBw2vcJzoNDpDrU7Tbk1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757624740; c=relaxed/simple;
	bh=vo5qFUglzmuWMMVnYWy79b5GhFFSgr0ZIaI8Yc9xjio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jAAWkFoganvXGKLZxGJpdrdQFk903l+/TQoI69jSuiufjEoycvvr7TSGlshr7DANqbwvwy/mkugJDUD4YRxjv8LO8hXtp3v6po+YYYKN3L1uj4YVmrm54621Z2lXkWnBnzFJb3RbRdBKyfjzxfQfWOg6ghq8f/OV9mKjT+XYLzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IAlm1XxO; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757624740; x=1789160740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vo5qFUglzmuWMMVnYWy79b5GhFFSgr0ZIaI8Yc9xjio=;
  b=IAlm1XxOWIUQGxy5YprDmXxx4SrysjZiXsXk6fmQle9Nrw78eIg663Cl
   xQnfvWUYHk7pOYBBtNw4utsKUgFsJlCV3I/B6Lq4KHiZEZ+f93R1xiSO+
   f+8JRrvgwAEEHn7tZUH63qnKveQKl2mnu+VzdmSrvuiY0jYlwSAqDpPBS
   quF1QC6EbW+yyokXamCCVXTUovhbQua3bwYqCmTMRe+kBk59iz8Wr28Er
   YYqJqQjOjkqw2vK7dbaGv8VJTit6ddlhR1nnj8yv9F2K5Tfv7Ro+DFnYv
   Fe8CQ61X0hbXY4DWoTlaYx6IuOjsjZHWNbTl1bO9cniAHkPp0LKTXDZEg
   g==;
X-CSE-ConnectionGUID: 8SYwa15IQOucvDlxejShXw==
X-CSE-MsgGUID: WBGhuWB1TqKLXeUpPjpVjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="82558834"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="82558834"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 14:05:36 -0700
X-CSE-ConnectionGUID: b7Ph6G+GTgSPXnY0xnFlhQ==
X-CSE-MsgGUID: 9Oat9nu9Rw2MF0AURg9xbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,258,1751266800"; 
   d="scan'208";a="174583323"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 11 Sep 2025 14:05:34 -0700
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
	dawid.osuchowski@linux.intel.com,
	horms@kernel.org
Subject: [PATCH net-next 00/15][pull request] Fwlog support in ixgbe
Date: Thu, 11 Sep 2025 14:04:59 -0700
Message-ID: <20250911210525.345110-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Michal Swiatkowski says:

Firmware logging is a feature that allow user to dump firmware log using
debugfs interface. It is supported on device that can handle specific
firmware ops. It is true for ice and ixgbe driver.

Prepare code from ice driver to be moved to the library code and reuse
it in ixgbe driver.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250812042337.1356907-1-michal.swiatkowski@linux.intel.com/

The following are changes since commit 5adf6f2b9972dbb69f4dd11bae52ba251c64ecb7:
  Merge branch 'ipv4-icmp-fix-source-ip-derivation-in-presence-of-vrfs'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

Michal Swiatkowski (15):
  ice: make fwlog functions static
  ice: move get_fwlog_data() to fwlog file
  ice: drop ice_pf_fwlog_update_module()
  ice: introduce ice_fwlog structure
  ice: add pdev into fwlog structure and use it for logging
  ice: allow calling custom send function in fwlog
  ice: move out debugfs init from fwlog
  ice: check for PF number outside the fwlog code
  ice: drop driver specific structure from fwlog code
  libie, ice: move fwlog admin queue to libie
  ice: move debugfs code to fwlog
  ice: prepare for moving file to libie
  ice: reregister fwlog after driver reinit
  ice, libie: move fwlog code to libie
  ixgbe: fwlog support for e610

 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/ice/Makefile       |    1 -
 drivers/net/ethernet/intel/ice/ice.h          |    6 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   78 --
 drivers/net/ethernet/intel/ice/ice_common.c   |   46 +-
 drivers/net/ethernet/intel/ice/ice_debugfs.c  |  633 +---------
 drivers/net/ethernet/intel/ice/ice_fwlog.c    |  474 -------
 drivers/net/ethernet/intel/ice/ice_fwlog.h    |   79 --
 drivers/net/ethernet/intel/ice/ice_main.c     |   43 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   32 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |    2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 +
 drivers/net/ethernet/intel/libie/Kconfig      |    9 +
 drivers/net/ethernet/intel/libie/Makefile     |    4 +
 drivers/net/ethernet/intel/libie/fwlog.c      | 1115 +++++++++++++++++
 include/linux/net/intel/libie/adminq.h        |   90 ++
 include/linux/net/intel/libie/fwlog.h         |   85 ++
 19 files changed, 1403 insertions(+), 1314 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
 create mode 100644 drivers/net/ethernet/intel/libie/fwlog.c
 create mode 100644 include/linux/net/intel/libie/fwlog.h

-- 
2.47.1


