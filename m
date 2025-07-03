Return-Path: <netdev+bounces-203890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6C9AF7F42
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790D31CA1D83
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2B28C03C;
	Thu,  3 Jul 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z9tyPUXA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD89015747D
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751564569; cv=none; b=O0LrC1mveNmvHwmsWy9AAXeRxM8wHuuSV5fZLJ1Jcc0bceyv680lNR+lsg0dLhL7MMKCxjuLBdLyHsnAG89Aeov7/QNHI4IQxymnzeuNiXIBKcihMykywy4PDPLlio2THfS8LUtt5EIroYyR8O0jqgdXw+ZsF8LZTeV5ZlHTi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751564569; c=relaxed/simple;
	bh=HyciM9zi8tI3rCy6rZOudw3SXCQJutFFC83C1Z5f2F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bjs8UYc545pG4uGEDCJDcmt1Up/d1K9Qu3YhKdhYILcGGoupPQPKk9UKWeIlT0vPnx7WVlUyMU9ICAKKNui05QpR+QCDer0rbv2gewZjybOaXLlZrbd2rHZwzCLDGQbMNdz8VaT/9VEPmxGqionp5rOGhVrtaFTB/Sy/zuA0fA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z9tyPUXA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751564568; x=1783100568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HyciM9zi8tI3rCy6rZOudw3SXCQJutFFC83C1Z5f2F8=;
  b=Z9tyPUXAdCIGjd2WNFfzfdqQn3hL4dzr9Mew8s5CSK+Wt5Cl3mJ+pr3x
   T3gH5p5tzQ1R0Degz6U8AxYqSv5d21P/eVq1EL3JmfvRroDFAa7oV7ApT
   K940DdJuGfB8xxG66WVj2QCAb0Fh4O8iOb1LsvkI2clJ+m/O8MA/gkOwS
   fExD/ZtehiOu83VyzgM1ziG02IWAML2vdks53xITB7bUYgxKIF12CXUGT
   i6BUxpgs+1iPQp20nXOKkL3/AbDbXftdHuX6e8H90URUr/FGczYneA2ec
   bAL/qXmKze8bHHcPq435p3UBjfP7CpXL9l15W0MgcP46z/NknC+W6nJt9
   w==;
X-CSE-ConnectionGUID: KfIHgvoRQTSUU1Yhx9OaPw==
X-CSE-MsgGUID: JpMfQu+nTcaXD1yNo5MapA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53767877"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="53767877"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 10:42:48 -0700
X-CSE-ConnectionGUID: dBE5NNrLQKScFqt1DjXqqQ==
X-CSE-MsgGUID: n65VcAM5Tlu45qLG6BpNaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="154997866"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 03 Jul 2025 10:42:46 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/12][pull request] Intel Wired LAN Driver Updates 2025-07-03
Date: Thu,  3 Jul 2025 10:42:27 -0700
Message-ID: <20250703174242.3829277-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Vladimir Oltean converts Intel drivers (ice, igc, igb, ixgbe, i40e) to
utilize new timestamping API (ndo_hwtstamp_get() and ndo_hwtstamp_set()).

For ixgbe:
Paul, Don, Slawomir, and Radoslaw add Malicious Driver Detection (MDD)
support for X550 and E610 devices to detect, report, and handle
potentially malicious VFs.

Simon Horman corrects spelling mistakes.

For igbvf:
Kohei Enju removes a couple of unreported counters and adds reporting
of Tx timeouts.

The following are changes since commit 5f712c3877f99d5b5e4d011955c6467ae0e535a6:
  ipv6: Cleanup fib6_drop_pcpu_from()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

Don Skidmore (1):
  ixgbe: check for MDD events

Kohei Enju (2):
  igbvf: remove unused interrupt counter fields from struct
    igbvf_adapter
  igbvf: add tx_timeout_count to ethtool statistics

Paul Greenwalt (1):
  ixgbe: add MDD support

Radoslaw Tyl (1):
  ixgbe: turn off MDD while modifying SRRCTL

Simon Horman (1):
  ixgbe: spelling corrections

Slawomir Mrozowicz (1):
  ixgbe: add Tx hang detection unhandled MDD

Vladimir Oltean (5):
  ice: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  igc: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  igb: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  ixgbe: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  i40e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()

 drivers/net/ethernet/intel/i40e/i40e.h        |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  24 +-
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  43 ++--
 drivers/net/ethernet/intel/ice/ice_main.c     |  24 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  45 ++--
 drivers/net/ethernet/intel/ice/ice_ptp.h      |  17 +-
 drivers/net/ethernet/intel/igb/igb.h          |   9 +-
 drivers/net/ethernet/intel/igb/igb_main.c     |   6 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c      |  37 ++-
 drivers/net/ethernet/intel/igbvf/ethtool.c    |   1 +
 drivers/net/ethernet/intel/igbvf/igbvf.h      |   2 -
 drivers/net/ethernet/intel/igbvf/netdev.c     |   4 -
 drivers/net/ethernet/intel/igc/igc.h          |   9 +-
 drivers/net/ethernet/intel/igc/igc_main.c     |  21 +-
 drivers/net/ethernet/intel/igc/igc_ptp.c      |  36 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |  14 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |   4 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c |   4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |   5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 237 +++++++++++++++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  |  42 ++--
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |  53 +++-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.h    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  46 +++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 122 ++++++++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   5 +
 31 files changed, 596 insertions(+), 236 deletions(-)

-- 
2.47.1


