Return-Path: <netdev+bounces-142107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C949BD871
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 23:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160212842C6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0655216429;
	Tue,  5 Nov 2024 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kMjAXePL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924711DD0D2
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845440; cv=none; b=i3DXNmIr4IoVtWPDP81KkPFFKDwBfwJdm93GAM8XhDC1KZc9sLDKgoq0lA3q3WJQAU6MH1uI1sQi32sQf4FjE8EcwI6UIEvpvYivYj/C9HPBk25M4C2O9EHMJfXGxiHe+A32aVSXkO+g7CMnH/liITCnpzWN2Z+xAEeEF7ZDlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845440; c=relaxed/simple;
	bh=a8wydvfd3IcPhabsIUcJy8VdzASonw3weScWlCOkVWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhLXDJZmD1YOsB2YDmvnuFryaohDj4lPkkcWC4ToCHfu4luZLNgraWHCdWMbs4JnLHXVG3ecvfXvb6ejIguHR9eHsMLs1U4u+IHAgyNhLtaRCf05fbv8itgwlGfZzf4Gm4IMSwv+4oBaPKwL0GVWQtmO75oHYBu+g+F6tCuWy2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kMjAXePL; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730845439; x=1762381439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=a8wydvfd3IcPhabsIUcJy8VdzASonw3weScWlCOkVWE=;
  b=kMjAXePLmz/AwOc23JYZxFF0hZcC/JO4Jqbo2m/OKvu7wy/34LbNET7I
   3fi3HLpnVpVIzSAwpbnloionVaZ77OQbiMvj5KnEiXUTwdtLPZUhZKtzr
   g6RW1fZVWTN0idI2PkCVZtboqdkRgGPD69UqXaYU7WuRPzVKPleQGy065
   uD0f5qclKc9eO9pXlDfwiThKPR+PO55PcAEcLUImKe6mY1i9UgehnDemO
   mQkl5aEDjpFI/40VXXTWAsm07VtN57Wcv95B2yopGWXUbg0GntckEpjix
   EAq3Sa52ZkOpwU0y16opMFfHDyCI9eVbTlvwip3gm4m4rQhmtX0o3mA4C
   A==;
X-CSE-ConnectionGUID: MnELafHtQpaoyan5BBmDdA==
X-CSE-MsgGUID: hxtQ945jQ72uVLzS+M5ZSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34314243"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34314243"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 14:23:58 -0800
X-CSE-ConnectionGUID: Gd4NBX3WTbixqVzF1UpxvQ==
X-CSE-MsgGUID: ONoflcyHQyujr8tgoM5ESA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="84322424"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa009.fm.intel.com with ESMTP; 05 Nov 2024 14:23:56 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2024-11-05 (ice, ixgbe, igc. igb, igbvf, e1000)
Date: Tue,  5 Nov 2024 14:23:34 -0800
Message-ID: <20241105222351.3320587-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Paul adds generic checksum support for E830 devices.

Mateusz refactors and adds additional SerDes configuration values to be
output.

Przemek refactors processing of DDP and adds support for a flag field in
the DDP's signature segment header.

Joe Damato adds support for persistent NAPI config.

Brett adjusts setting of Tx promiscuous based on unicast/multicast
setting.

Jake moves setting of pf->supported_rxdids to occur directly after DDP
load and changes a small struct to use stack memory.

Frederic Weisbecker adds WQ_UNBOUND flag to the workqueue.

For ixgbe:

Diomidis Spinellis removes a circular dependency.

For igc:

Vitaly removes an unneeded autoneg parameter.

For igb:

Johnny Park fixes a couple of typos.

For igbvf:

Wander Lairson Costa removes and unused spinlock.

For e1000:

Joe Damato adds RTNL lock to some calls where it is expected to be held.
---
The following are changes since commit ccb35037c48a16dfa377e3af3be2c164e73d54f0:
  Merge branch 'net-lan969x-add-vcap-functionality'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Brett Creeley (1):
  ice: only allow Tx promiscuous for multicast

Diomidis Spinellis (1):
  ixgbe: Break include dependency cycle

Frederic Weisbecker (1):
  ice: Unbind the workqueue

Jacob Keller (2):
  ice: initialize pf->supported_rxdids immediately after loading DDP
  ice: use stack variable for virtchnl_supported_rxdids

Joe Damato (2):
  ice: Add support for persistent NAPI config
  e1000: Hold RTNL when e1000_down can be called

Johnny Park (1):
  igb: Fix 2 typos in comments in igb_main.c

Mateusz Polchlopek (2):
  ice: rework of dump serdes equalizer values feature
  ice: extend dump serdes equalizer values feature

Paul Greenwalt (1):
  ice: Add E830 checksum offload support

Przemek Kitszel (2):
  ice: refactor "last" segment of DDP pkg
  ice: support optional flags in signature segment header

Vitaly Lifshits (1):
  igc: remove autoneg parameter from igc_mac_info

Wander Lairson Costa (1):
  igbvf: remove unused spinlock

 drivers/net/ethernet/intel/e1000/e1000_main.c |  10 +-
 drivers/net/ethernet/intel/ice/ice.h          |   7 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  17 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      | 302 +++++++++--------
 drivers/net/ethernet/intel/ice/ice_ddp.h      |   5 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 110 +++---
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |  39 ++-
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |   9 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  18 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  76 ++++-
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  26 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   3 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  26 ++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  59 ++--
 drivers/net/ethernet/intel/igb/igb_main.c     |   4 +-
 drivers/net/ethernet/intel/igbvf/igbvf.h      |   3 -
 drivers/net/ethernet/intel/igbvf/netdev.c     |   3 -
 drivers/net/ethernet/intel/igc/igc_diag.c     |   3 +-
 drivers/net/ethernet/intel/igc/igc_ethtool.c  |  13 +-
 drivers/net/ethernet/intel/igc/igc_hw.h       |   1 -
 drivers/net/ethernet/intel/igc/igc_mac.c      | 316 +++++++++---------
 drivers/net/ethernet/intel/igc/igc_main.c     |   1 -
 drivers/net/ethernet/intel/igc/igc_phy.c      |  24 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |  16 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  15 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   1 +
 31 files changed, 629 insertions(+), 485 deletions(-)

-- 
2.42.0


