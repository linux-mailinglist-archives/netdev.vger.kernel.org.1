Return-Path: <netdev+bounces-155606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C95A03286
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 23:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A414164931
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C6B1DFE18;
	Mon,  6 Jan 2025 22:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XK7Bi2Dk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AC1D90A9
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 22:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736201978; cv=none; b=CMMDF8ieV2afs3uIV/GU+DMy+KRgtt2IGgCpOcAFDXCQzQGVCSqSHpmokwfhjdT5gHx2X4z8WpIKJeHg8D/leQ33yVQcPjxihV7Mw4vG+O4CNoo1s4ahUiZ99jPh8aGqjSempBdE4p/oSIxgvn/ze2CuqviXUEV/yqcnJLJqo+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736201978; c=relaxed/simple;
	bh=DOL28C/UgoUOTLAgz8oCQEjVS07ss9Mm7PCKFkGSpJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M8bHPCyQuFtGpmtW80EzXldS1Le5ze/psX9uz3/37BDPxX+jA5BPisfJPy62+ER0lX0xS+yWGhgTLhxRrXMRjvalEqMCnTzANWnntmHAc4HzApdtpK+xXowtHOYwfduR0VMfjaJxV0jjAsPr30L8KqLWZqGK12h5LILgCl2Q20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XK7Bi2Dk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736201976; x=1767737976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DOL28C/UgoUOTLAgz8oCQEjVS07ss9Mm7PCKFkGSpJM=;
  b=XK7Bi2DkEuXht6x0jtavC3GqYj17aqePgISeYt4OJNdGPwAQww7oOTDg
   mtMPXoMufIhXZaXA4trUhK0TaXC5MslPCTeP51qq2iKZCWkM/l9Q3XDeU
   eGvNtJCtCz45OHtBPCrdhks7Pz7CBOW8MNj35D4UrqkNWGlx42JsUnb7v
   +f1VTobUQuJmCvz1SGjUoQP/fUl6VG8qe9a+qLnEacfipTX0ynvliFqZo
   6GXrgtthdsUsq0dWoiyb7Vn9dvpaPLyzjzcsm8JBsaW6yLJIGzuSz5lhA
   kgZqkCiHbdiao+Tuee9VoB2Mop2zk9fNf4x8Bmm1kYJqCGy+VQJwvifw4
   w==;
X-CSE-ConnectionGUID: XbL7XgrTRRGhmXXMorPcWQ==
X-CSE-MsgGUID: hMeVobosTG6LDtfBt/QE1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11307"; a="46858637"
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="46858637"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 14:19:35 -0800
X-CSE-ConnectionGUID: 1OgLZqtBT2CXDSTMcURRag==
X-CSE-MsgGUID: LUiT2PxIRoqrIdD7I0JxCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,293,1728975600"; 
   d="scan'208";a="102368448"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 06 Jan 2025 14:19:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2025-01-06 (igb, igc, ixgbe, ixgbevf, i40e, fm10k)
Date: Mon,  6 Jan 2025 14:19:08 -0800
Message-ID: <20250106221929.956999-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For igb:

Sriram Yagnaraman and Kurt Kanzenbach add support for AF_XDP
zero-copy.

Original cover letter:
The first couple of patches adds helper functions to prepare for AF_XDP
zero-copy support which comes in the last couple of patches, one each
for Rx and TX paths.

As mentioned in v1 patchset [0], I don't have access to an actual IGB
device to provide correct performance numbers. I have used Intel 82576EB
emulator in QEMU [1] to test the changes to IGB driver.

The tests use one isolated vCPU for RX/TX and one isolated vCPU for the
xdp-sock application [2]. Hope these measurements provide at the least
some indication on the increase in performance when using ZC, especially
in the TX path. It would be awesome if someone with a real IGB NIC can
test the patch.

AF_XDP performance using 64 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		220		235		350
txpush		1.000		1.000		410
l2fwd 		1.000		1.000		200

AF_XDP performance using 1500 byte packets in Kpps.
Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
rxdrop		200		210		310
txpush		1.000		1.000		410
l2fwd 		0.900		1.000		160

[0]: https://lore.kernel.org/intel-wired-lan/20230704095915.9750-1-sriram.yagnaraman@est.tech/
[1]: https://www.qemu.org/docs/master/system/devices/igb.html
[2]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example

Subsequent changes and information can be found here:
https://lore.kernel.org/intel-wired-lan/20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de/

Yue Haibing converts use of ERR_PTR return to traditional error code
which resolves a smatch warning.

For igc:

Song Yoong Siang allows for the XDP program to be hot-swapped.

Yue Haibing converts use of ERR_PTR return to traditional error code
which resolves a smatch warning.

Joe Damato adds sets IRQ and queues to NAPI instances to allow for
reporting via netdev-genl API.

For ixgbe:

Yue Haibing converts use of ERR_PTR return to traditional error code
which resolves a smatch warning.

For ixgbevf:

Yue Haibing converts use of ERR_PTR return to traditional error code
which resolves a smatch warning.

For i40e:

Alex implements "mdd-auto-reset-vf" private flag to automatically reset
VFs when encountering an MDD event.

For fm10k:

Dr. David Alan Gilbert removes an unused function.

The following are changes since commit 3e5908172c05ab1511f2a6719b806d6eda6e1715:
  Merge tag 'ieee802154-for-net-next-2025-01-03' of git://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE

Aleksandr Loktionov (1):
  i40e: add ability to reset VF for Tx and Rx MDD events

Dr. David Alan Gilbert (1):
  intel/fm10k: Remove unused fm10k_iov_msg_mac_vlan_pf

Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

Kurt Kanzenbach (1):
  igb: Add XDP finalize and stats update functions

Song Yoong Siang (1):
  igc: Allow hot-swapping XDP program

Sriram Yagnaraman (5):
  igb: Remove static qualifiers
  igb: Introduce igb_xdp_is_enabled()
  igb: Introduce XSK data structures and helpers
  igb: Add AF_XDP zero-copy Rx support
  igb: Add AF_XDP zero-copy Tx support

Yue Haibing (4):
  igc: Fix passing 0 to ERR_PTR in igc_xdp_run_prog()
  igb: Fix passing 0 to ERR_PTR in igb_run_xdp()
  ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()
  ixgbevf: Fix passing 0 to ERR_PTR in ixgbevf_run_xdp()

 .../device_drivers/ethernet/intel/i40e.rst    |  12 +
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c   | 120 ----
 drivers/net/ethernet/intel/fm10k/fm10k_pf.h   |   2 -
 drivers/net/ethernet/intel/i40e/i40e.h        |   4 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |   2 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 107 +++-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |   2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  11 +-
 drivers/net/ethernet/intel/igb/Makefile       |   2 +-
 drivers/net/ethernet/intel/igb/igb.h          |  58 +-
 drivers/net/ethernet/intel/igb/igb_main.c     | 270 ++++++---
 drivers/net/ethernet/intel/igb/igb_xsk.c      | 562 ++++++++++++++++++
 drivers/net/ethernet/intel/igc/igc.h          |   2 +
 drivers/net/ethernet/intel/igc/igc_main.c     |  79 ++-
 drivers/net/ethernet/intel/igc/igc_xdp.c      |   8 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  23 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |  23 +-
 18 files changed, 1002 insertions(+), 287 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/igb/igb_xsk.c

-- 
2.47.1


