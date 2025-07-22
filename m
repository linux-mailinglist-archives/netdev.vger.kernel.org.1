Return-Path: <netdev+bounces-208883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B3B0D7C0
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 13:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C9C5601BC
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 11:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31C1230D0E;
	Tue, 22 Jul 2025 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOvFSTHc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E83A1E2858
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182419; cv=none; b=QbJFynDa2K3WvVjrx4uy5sHtAnWxbWQiXSQsIEvOuFC5VR/I15MSlPLUWhrH2D04hvdgvyDFRTEZwmrgdzZeH9bprNN0JSWdUR/4MqjaFWKmuTMTeG6+BgqMZjdaSgM413yG2kkcddxMFFS3xxyBzHC+8qXo8efhuf7aUI0yzrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182419; c=relaxed/simple;
	bh=PJqY2BhJricnl5M7ZiNQoswZwu2458ENy3RSk/KsWy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3jiMpgBWQmUMRVPREMis8H0UKoRUE989ZHH8fHTbydFLTs+hBKeEFNIqjfobhR4E5ktW8QYH3kSbr/Wzss0wjQ1CVSMnFySkkiaKvZwCa6Z1w77AurQH4ZD+Xua31jKN304Uca9MYHZkgXuMmAwjljJbOgmGlbm1CqtwGCP8QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOvFSTHc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753182418; x=1784718418;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PJqY2BhJricnl5M7ZiNQoswZwu2458ENy3RSk/KsWy4=;
  b=DOvFSTHcRvD7w9MToIV5dvzOKBNUq0K2xJZMMB8RR79oVw29b2OBCTsG
   Cb5olKAInKLA2hup9gyiaM2A0axyLEB4FeUxEFU8o7bPgUAR/qRGww0Bm
   WdT1x/q+1UY+FoxcIDQRGR15bWd9uWHpOKJiO7k924P9Dn3pIxc/0waO2
   1OBXR9iDLoYZJWfcPVxMQPK50K9pFG7MCUM2eKOrHC1rfMbL1qJf7OSt5
   NNcdMl/TfyEZSPIes6zpFOmm12h2O8YigDskdFAWvZWAOt4tU+y1AC19Y
   8SdLx/xecQtoT6NAxTblkDup2qADAJ/2yts1DoOZizC3eBYqPaxXToV0K
   Q==;
X-CSE-ConnectionGUID: b4gQN+VYSK66nsDVs+QyYA==
X-CSE-MsgGUID: PwmlGhYaTvSbxFhQKExSaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="59083575"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="59083575"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 04:06:57 -0700
X-CSE-ConnectionGUID: w9xP/zPlSOmXjvxaQiou3A==
X-CSE-MsgGUID: 7euq7hCJSZ+CU30vRIQ/0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163153910"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa003.fm.intel.com with ESMTP; 22 Jul 2025 04:06:55 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	dawid.osuchowski@linux.intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 00/15] Fwlog support in ixgbe
Date: Tue, 22 Jul 2025 12:45:45 +0200
Message-ID: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Firmware logging is a feature that allow user to dump firmware log using
debugfs interface. It is supported on device that can handle specific
firmware ops. It is true for ice and ixgbe driver.

Prepare code from ice driver to be moved to the library code and reuse
it in ixgbe driver.

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
 drivers/net/ethernet/intel/libie/Kconfig      |    7 +
 drivers/net/ethernet/intel/libie/Makefile     |    4 +
 drivers/net/ethernet/intel/libie/fwlog.c      | 1113 +++++++++++++++++
 include/linux/net/intel/libie/adminq.h        |   90 ++
 include/linux/net/intel/libie/fwlog.h         |   85 ++
 19 files changed, 1401 insertions(+), 1312 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
 create mode 100644 drivers/net/ethernet/intel/libie/fwlog.c
 create mode 100644 include/linux/net/intel/libie/fwlog.h

-- 
2.49.0


