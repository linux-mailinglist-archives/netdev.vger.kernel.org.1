Return-Path: <netdev+bounces-181772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC0AA86776
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95781B82299
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB0D28CF54;
	Fri, 11 Apr 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dlD8qqpS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11401D86E8
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 20:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404249; cv=none; b=eo7iFm7cwl/ThWGfokKG0XoGm/r/nfixyBcDHMfzMOkF3znvI87vvY+IBLfyiSmF+qm5Vn0wMKfuSmMD6QuCO+DuzVxlb817hoYfJReIXz7dUl00bj9hgM55hbsZWUwSE57IZMizWAq6WHHDvb+HH/46KJusScHIKyMYZvNOwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404249; c=relaxed/simple;
	bh=PM/4QEoV39cTKFgbzUr3ylxGXX/772zikagsbId6qCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fIaJ4wn6ln0+aTpI+EoOca7bgf6j4lpcyi1a+/KWot5fQBwAHWbemealaEQwT3ddBuo4nO5mrU/gdBu9h6fFTOqANhoWOM3sbDlrqs+v4dEjC7RGH4i6CYcsOLz2FfGIAl0ZsTRqyZgN35MCRVx4AREN2xLamWD/kwgL88SEkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dlD8qqpS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404248; x=1775940248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PM/4QEoV39cTKFgbzUr3ylxGXX/772zikagsbId6qCM=;
  b=dlD8qqpSiygDeFFRALVPWDnYVYZXU2C+aNXmB0w7fNfI41BX250uoFMF
   FyAk9x6rroeDLLCyhzzU2ahVUp9yIA7wOLt+0W3bEUVZ07J5xsZAQXbBN
   gWoNXBCs+a2I8wb0bKwXJ26yRdk55zHTW8xTmI9mM0t1Evaq3USR4qBxr
   B93NnAq+1oUTt3NPOOjLB3nqrmSzNE1n+dBCTWu9x7qTFn/9N9dlub+Qd
   BFVI/FKlHcInmZnye6f6AFoLXZLGbW8sckrHgcZeSAmYP6BiyQEJ9Izwq
   z7E6vRGsiNRtyT4OkAYfRcJCfjgrHrvA6HxleMCbihwGi+S3cYtcbKo35
   w==;
X-CSE-ConnectionGUID: cKVI4yuqSx6BP34ogvtWZg==
X-CSE-MsgGUID: cY+XprDTQ9+86XlA8LDpvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103840"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103840"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:06 -0700
X-CSE-ConnectionGUID: ext1V/i8Rcaka4XvS9wRJQ==
X-CSE-MsgGUID: ftCIMfKzRLKxHLP6OYhsIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241791"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2025-04-11 (ice, i40e, ixgbe, igc, e1000e)
Date: Fri, 11 Apr 2025 13:43:41 -0700
Message-ID: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Mateusz and Larysa add support for LLDP packets to be received on a VF
and transmitted by a VF in switchdev mode. Additional information:
https://lore.kernel.org/intel-wired-lan/20250214085215.2846063-1-larysa.zaremba@intel.com/

Karol adds timesync support for E825C devices using 2xNAC (Network
Acceleration Complex) configuration. 2xNAC mode is the mode in which
IO die is housing two complexes and each of them has its own PHY
connected to it.

Martyna adds messaging to clarify filter errors when recipe space is
exhausted.

Colin Ian King adds static modifier to a const array to avoid stack
usage.

For i40e:
Kyungwook Boo changes variable declaration types to prevent possible
underflow.

For ixgbe:
Rand Deeb adjusts retry values so that retries are attempted.

For igc:
Rui Salvaterra sets VLAN offloads to be enabled as default.

For e1000e:
Piotr Wejman converts driver to use newer hardware timestamping API.

The following are changes since commit 61499764e5cc5918c9f63026d3b7a34c8668d4b8:
  net: stmmac: stm32: simplify clock handling
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Colin Ian King (1):
  ice: make const read-only array dflt_rules static

Karol Kolacinski (3):
  ice: remove SW side band access workaround for E825
  ice: refactor ice_sbq_msg_dev enum
  ice: enable timesync operation on 2xNAC E825 devices

Kyungwook Boo (1):
  i40e: fix MMIO write access to an invalid page in i40e_clear_hw

Larysa Zaremba (4):
  ice: do not add LLDP-specific filter if not necessary
  ice: remove headers argument from ice_tc_count_lkups
  ice: support egress drop rules on PF
  ice: enable LLDP TX for VFs through tc

Martyna Szapar-Mudlaw (1):
  ice: improve error message for insufficient filter space

Mateusz Pacuszka (2):
  ice: fix check for existing switch rule
  ice: receive LLDP on trusted VFs

Piotr Wejman (1):
  net: e1000e: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()

Rand Deeb (1):
  ixgbe: Fix unreachable retry logic in combined and byte I2C write
    functions

Rui Salvaterra (1):
  igc: enable HW vlan tag insertion/stripping by default

 drivers/net/ethernet/intel/e1000e/e1000.h     |   2 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  75 +++--
 drivers/net/ethernet/intel/i40e/i40e_common.c |   7 +-
 drivers/net/ethernet/intel/ice/ice.h          |  61 +++-
 drivers/net/ethernet/intel/ice/ice_common.c   |  22 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   3 +-
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   2 +-
 drivers/net/ethernet/intel/ice/ice_eswitch.c  |   6 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |   2 +-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  71 ++++-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  63 ++++-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  49 +++-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   |  82 +++---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   5 -
 drivers/net/ethernet/intel/ice/ice_repr.c     |  10 +-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |  11 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |   4 +
 drivers/net/ethernet/intel/ice/ice_switch.c   |   4 +-
 drivers/net/ethernet/intel/ice/ice_tc_lib.c   | 266 ++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h   |  11 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  17 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  26 ++
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  53 +++-
 drivers/net/ethernet/intel/igc/igc_main.c     |   3 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |   4 +-
 29 files changed, 685 insertions(+), 192 deletions(-)

-- 
2.47.1


