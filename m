Return-Path: <netdev+bounces-174690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A545A5FEC7
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 19:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98EE3BB2AB
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 18:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6831DC046;
	Thu, 13 Mar 2025 18:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cpx2PvSN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55215B0EF
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741889192; cv=none; b=YsA015ZEhKCkBb4bg0jO+vVZhBgwE6KO1hq9wrkbQc6wXBXWflwPAjToV55Xgpwel8MfedKGfk+tMh45ttGN9nMfePiIp2ejNhKX1CO25gyZY8rD6espPGlZbvVM1wZBgGKiZujvaADj9XHX34QePDk4soOfYvStftH2YfQXgcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741889192; c=relaxed/simple;
	bh=KAAc4RZckGEqafCdpg/tQUmKLLXJzCX6UTENXhcc5A4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qvBkC/PbCOWdnADPn6dTP+twiFCRYPUG6xQbzvcIH2zf+AZDx5o9Xxmh1jY7rRcDCUWgXNJ0RLeGG8GGtv/ccLpx38hNAa+ZrZeZ08faNFlv37w5k2T9/3pE9I8hNQkP0muse87GdpjIhlxIQNfkYkUcmsNWLHdMaIEyMYnA1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cpx2PvSN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741889190; x=1773425190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KAAc4RZckGEqafCdpg/tQUmKLLXJzCX6UTENXhcc5A4=;
  b=Cpx2PvSNAszyKTcyhzkdxsrNvTfXYhO2xeuRDXQvl/6G8ce5dr3fmXLc
   IrRfMZyRMCH9K43Ev0Wc8m6UHkecRWeK1HecneZtUQAG/uXxd2T/dfDVu
   nKFxZ27Bli4DmuEQkbtActAA8yeEOZeMqZKTSJ5fpzU7bFNqbYMuhSX1s
   YGjK7Gi/AJi8bOSUDOs1Bk8DgDv9icTA28PXR0b3AgVXFmsnGXRh9xCjm
   /X9lgAQgIRiIDVYlHDu8f49X77BXgcSEcp5zCkoMhDjVv6cq6tndmmCkk
   qUQpNENfx7q8mTX9Ts6sXU+h+TEDS7iCRt3ZlMmB1sxbYXuAXEbxlN37Y
   g==;
X-CSE-ConnectionGUID: BS+fwFIFROKsQlVzNdy2dg==
X-CSE-MsgGUID: Sv6YUVB0SB+Dyq6c0v4Gxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="45795429"
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="45795429"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 11:06:29 -0700
X-CSE-ConnectionGUID: m2842EkOT1GFQfW/B+co8w==
X-CSE-MsgGUID: BHe8f1rdQ4K4O16lH25Abg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,245,1736841600"; 
   d="scan'208";a="120989325"
Received: from unknown (HELO localhost.igk.intel.com) ([10.102.22.54])
  by orviesa010.jf.intel.com with ESMTP; 13 Mar 2025 11:06:28 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v9 iwl-next 00/10] idpf: add initial PTP support
Date: Thu, 13 Mar 2025 19:04:09 +0100
Message-Id: <20250313180417.2348593-1-milena.olech@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces support for Precision Time Protocol (PTP) to
Intel(R) Infrastructure Data Path Function (IDPF) driver. PTP feature is
supported when the PTP capability is negotiated with the Control
Plane (CP). IDPF creates a PTP clock and sets a set of supported
functions.

During the PTP initialization, IDPF requests a set of PTP capabilities
and receives a writeback from the CP with the set of supported options.
These options are:
- get time of the PTP clock
- get cross timestamp
- set the time of the PTP clock
- adjust the PTP clock
- Tx timestamping

Each feature is considered to have direct access, where the operations
on PCIe BAR registers are allowed, or the mailbox access, where the
virtchnl messages are used to perform any PTP action. Mailbox access
means that PTP requests are sent to the CP through dedicated secondary
mailbox and the CP reads/writes/modifies desired resource - PTP Clock
or Tx timestamp registers.

Tx timestamp capabilities are negotiated only for vports that have
UPLINK_VPORT flag set by the CP. Capabilities provide information about
the number of available Tx timestamp latches, their indexes and size of
the Tx timestamp value. IDPF requests Tx timestamp by setting the
TSYN bit and the requested timestamp index in the context descriptor for
the PTP packets. When the completion tag for that packet is received,
IDPF schedules a worker to read the Tx timestamp value.

v8 -> v9: fix Rx filters upscaling, check if the link is up in
idpf_hwtstamp_get/set, fix typo
v7 -> v8: split Tx and Rx timestamping enablement, refactor
idpf_for_each_vport
v6 -> v7: remove section about Tx timestamp limitation from cover letter
since it has been fixed, change preparing flow descriptor method
v5 -> v6: change locking mechanism in get_ts_info, clean timestamp
fields when preparing flow descriptor, add Rx filter
v4 -> v5: fix spin unlock when Tx timestamp index is requested
v3 -> v4: change timestamp filters dependent on Tx timestamp cap,
rewrite function that extends Tx timestamp value, minor fixes
v2 -> v3: fix minor issues, revert idpf_for_each_vport changes,
extend idpf_ptp_set_rx_tstamp, split tstamp statistics
v1 -> v2: add stats for timestamping, use ndo_hwtamp_get/set,
fix minor spelling issues

Milena Olech (10):
  idpf: add initial PTP support
  virtchnl: add PTP virtchnl definitions
  idpf: move virtchnl structures to the header file
  idpf: negotiate PTP capabilities and get PTP clock
  idpf: add mailbox access to read PTP clock time
  idpf: add PTP clock configuration
  idpf: add Tx timestamp capabilities negotiation
  idpf: add Tx timestamp flows
  idpf: add support for Rx timestamping
  idpf: change the method for mailbox workqueue allocation

 drivers/net/ethernet/intel/idpf/Kconfig       |   1 +
 drivers/net/ethernet/intel/idpf/Makefile      |   3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |  35 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |   3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  75 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |   4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  57 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |   9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 996 ++++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    | 370 +++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 171 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |  84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   | 677 ++++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   | 314 +++++-
 18 files changed, 2901 insertions(+), 103 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c

-- 
2.31.1


