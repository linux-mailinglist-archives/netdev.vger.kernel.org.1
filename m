Return-Path: <netdev+bounces-195868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE4FAD28B5
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE573A616A
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 21:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47EA221289;
	Mon,  9 Jun 2025 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2fGu/Tv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F381245BE3
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749504423; cv=none; b=lZm8iVzPLMGPrB1cfmEfEGnHBgU0ULNYsb+XL6kCVQapQOsA9HExJLrI6eOqcJBvc6IFYW2hn1omBASXGDrRO09G2NvmE5YIykRzNSltX0O9C0Zy97JUS1F3bVWgk9aN7OBJtvK0XzmHuFQVt8uIe35KEKMljNRyIDL0GKIo/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749504423; c=relaxed/simple;
	bh=iPk990DE1rgPDsXDBx24XfIFSlNmSvrq59A7zjkM3v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=htdwncm4/oo9byQ4hyxySkUEZWpNlkhmLQYVQsCY5rhStcIBbPWF44N0XgsdkKtdI9YzV0pjeobmxambhR1q/eGYGt5b5qODwWLoZGoEhhUQa0JefVtLDyjZrZXzDEKvrm1x0VosrsUpSbsuYPE78cOPJqluDZQPbM0LWpjihdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2fGu/Tv; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749504422; x=1781040422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iPk990DE1rgPDsXDBx24XfIFSlNmSvrq59A7zjkM3v0=;
  b=D2fGu/TvcBg6VQ8AMU+tqUBrwfsiDzduR/9O1oHW16BHXa45U7yliwqc
   Qsq0Af5OQPISoBNxeFsEW3lmEuH8psX3rWGq67hvpxSvm+ihXnVsoeXmo
   junmn0edS1KRw8DeSGkSB4Egu5mC919Zhbqj0l8cWhmwNOKvDVrj5+HJU
   X8Z8LJ8XJ7gnRPNdh9v26RWmyOhcC5isjP4HADtL89uVU1eYTuuQ4g7H9
   jMWanXMYeS5M1/a4OZ+KuBGIRfqr1oAYUNLOnAwFdMtXe3EGeH7qO7LH1
   wR0PuMTy7zmLVUlRL0vEdYuBkWWh1edTdoYESVz0JMrwUAa5miqM7mCxd
   Q==;
X-CSE-ConnectionGUID: WDsAuYRxS8WaxrNt6tBVWA==
X-CSE-MsgGUID: e/xRqP3bTMaTmgsr7B/K+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="61864158"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="61864158"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 14:27:01 -0700
X-CSE-ConnectionGUID: l+gYWRofQuWeVXynXS081g==
X-CSE-MsgGUID: /vbPIWSmTeiWGzFIAJmbrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="150468996"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 09 Jun 2025 14:27:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/11][pull request] Intel Wired LAN Driver Updates 2025-06-09 (ice, i40e, ixgbe, iavf)
Date: Mon,  9 Jun 2025 14:26:39 -0700
Message-ID: <20250609212652.1138933-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jake moves from individual virtchnl RSS configuration values, for ice,
i40e, and iavf, to a common libie location and values.

Martyna and Dawid add counters for link_down_events to ice, i40e, and
ixgbe drivers. The counter increments only on actual physical link-down
events visible to the PHY. It does not increment when the user performs
a software-only interface down/up (e.g. ip link set dev down).

The counter does increment in cases where the interface is reinitialized
in a way that causes a real link drop - such as eg. when attaching
an XDP program, reconfiguring channels, or toggling certain priv-flags.

For ice:
Arkadiusz and Karol separate PTP and DPLL functionality to their
respective APIs.

Michal adds a separate handler for Flow Director command processing.

For iavf:
Ahmed converts driver to utilize core's IRQ affinity API.

For ixgbe:
Alok Tiwari fixes issues with some comments; typos, copy/paste errors,
etc.

The following are changes since commit 2c7e4a2663a1ab5a740c59c31991579b6b865a26:
  Merge tag 'net-6.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Ahmed Zaki (1):
  iavf: convert to NAPI IRQ affinity API

Alok Tiwari (1):
  ixgbe: Fix typos and clarify comments in X550 driver code

Arkadiusz Kubalewski (1):
  ice: redesign dpll sma/u.fl pins control

Dawid Osuchowski (1):
  i40e: add link_down_events statistic

Jacob Keller (2):
  net: intel: rename 'hena' to 'hashcfg' for clarity
  net: intel: move RSS packet classifier types to libie

Karol Kolacinski (2):
  ice: change SMA pins to SDP in PTP API
  ice: add ice driver PTP pin documentation

Martyna Szapar-Mudlaw (2):
  ice: add link_down_events statistic
  ixgbe: add link_down_events statistic

Michal Kubiak (1):
  ice: add a separate Rx handler for flow director commands

 .../device_drivers/ethernet/intel/ice.rst     |  13 +
 drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  91 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  28 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  25 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  47 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  32 -
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  46 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  12 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  75 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   |   3 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  42 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   |  32 -
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  33 +-
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_base.c     |   5 +-
 drivers/net/ethernet/intel/ice/ice_dpll.c     | 927 +++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_dpll.h     |  23 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +
 drivers/net/ethernet/intel/ice/ice_flow.c     |  45 +-
 drivers/net/ethernet/intel/ice/ice_flow.h     |  68 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   3 +
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 254 +----
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx.c     |  87 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |   3 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  44 +-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   4 +-
 .../intel/ice/ice_virtchnl_allowlist.c        |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |  28 +-
 include/linux/avf/virtchnl.h                  |  23 +-
 include/linux/net/intel/libie/pctype.h        |  41 +
 37 files changed, 1423 insertions(+), 647 deletions(-)
 create mode 100644 include/linux/net/intel/libie/pctype.h

-- 
2.47.1


