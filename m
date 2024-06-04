Return-Path: <netdev+bounces-100576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A33208FB39F
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5382884E9
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB121465BE;
	Tue,  4 Jun 2024 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dou3ya0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C80F146019
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507495; cv=none; b=PpjWH0+LtjhZnnnz+JKO9eMCEPbFeaBOC3pnbJNjuyi2X6FT2Pq30aouF5bDZfZx6m6Nk395J4i3kJUt5XATcuyz1v9X6f5hhe+LYG2Eig5TFBsMjo29F9bfpPb2pVPiuJN04oIazdDIIEHUL3D1TwNIqGt1RM3l38OiPkoBLNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507495; c=relaxed/simple;
	bh=DS/KI3xMYtNzcbzUyEzBv/NVyRuMHUgq6ujsTOu9WEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oyep8GJEQ6ySg0YUg8L0C7ySLcDEJslaVdFxOXwpO5T1Tgku9VMObbQxzA4BgIqTI0sqaJCg3cRcZ4PE7cZ69y3c5SAO2IJwrWrZTEtPz5CVOVno6TmhI0+/EBFMg2d55xgrGANb6CgnigyqBQFN7vIoWhoBc6nfcxrf+Y3Yy9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dou3ya0Q; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717507494; x=1749043494;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DS/KI3xMYtNzcbzUyEzBv/NVyRuMHUgq6ujsTOu9WEk=;
  b=Dou3ya0Qwi6rcct3Ouyy2fU1AT8KdPVybUsvSRWkm7VSMk9Y23eqadFK
   HTVUvmD4PPQNRDCJCyw2PXVgxvxsu0QGNX+t3Sn5GmUA8li2dc5k7tK79
   OvbP873zRoq8vsp9ItEuo4peU2nc4GoDQMsuS5ZiZOZRIwpkTPZPZWso/
   vDmieJMNKncOQhK9SuFNRDr0dsTbmu2iTvjFGMNT0GPSOohCfrk/yMMMn
   Gm2Bs1zpRvM338OKvx/0AG79APh6Hn7TxPawf+a+QmpiuGxI4Z8IA+HZS
   IBC2fTw9+bb1qYXrRa9bpEF93W5HCcdaYi9WGpbTalJKPlE1ECBI1Zks0
   w==;
X-CSE-ConnectionGUID: AIL4BsDpRf+uOfCfMZ80bA==
X-CSE-MsgGUID: MMjsfdD5TX6+XmY2Jd0Vpg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14245367"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="14245367"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 06:24:53 -0700
X-CSE-ConnectionGUID: dR/fnQOMQvicCjJ8VgPrpg==
X-CSE-MsgGUID: Fjk7r3QZQ82pYL6JEfQ8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; 
   d="scan'208";a="37109726"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa007.fm.intel.com with ESMTP; 04 Jun 2024 06:24:51 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4B7CE125AF;
	Tue,  4 Jun 2024 14:24:44 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v7 00/12] Add support for Rx timestamping for both ice and iavf drivers.
Date: Tue,  4 Jun 2024 09:13:48 -0400
Message-Id: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initially, during VF creation it registers the PTP clock in
the system and negotiates with PF it's capabilities. In the
meantime the PF enables the Flexible Descriptor for VF.
Only this type of descriptor allows to receive Rx timestamps.

Enabling virtual clock would be possible, though it would probably
perform poorly due to the lack of direct time access.

Enable timestamping should be done using userspace tools, e.g.
hwstamp_ctl -i $VF -r 14

In order to report the timestamps to userspace, the VF extends
timestamp to 40b.

To support this feature the flexible descriptors and PTP part
in iavf driver have been introduced.

---
v7:
- changed .ndo_eth_ioctl to .ndo_hwtstamp_get and .ndo_hwtstamp_set
  (according to Kuba's suggestion) - patch 11

v6:
- reordered tags
- added RB tags where applicable
- removed redundant instructions in ifs - patch 4 and patch 5
- changed teardown to LIFO, adapter->ptp.initialized = false
  moved to the top of function - patch 6
- changed cpu-endianess for testing - patch 9
- aligned to libeth changes - patch 9
https://lore.kernel.org/netdev/20240528112301.5374-1-mateusz.polchlopek@intel.com/

v5:
- fixed all new issues generated by this series in kernel-doc
https://lore.kernel.org/netdev/20240418052500.50678-1-mateusz.polchlopek@intel.com/

v4:
- fixed duplicated argument in iavf_virtchnl.c reported by coccicheck
https://lore.kernel.org/netdev/20240410121706.6223-1-mateusz.polchlopek@intel.com/

v3:
- added RB in commit 6
- removed inline keyword in commit 9
- fixed sparse issues in commit 9 and commit 10
- used GENMASK_ULL when possible in commit 9
https://lore.kernel.org/netdev/20240403131927.87021-1-mateusz.polchlopek@intel.com/

v2:
- fixed warning related to wrong specifier to dev_err_once in
  commit 7
- fixed warnings related to unused variables in commit 9
https://lore.kernel.org/netdev/20240327132543.15923-1-mateusz.polchlopek@intel.com/

v1:
- initial series
https://lore.kernel.org/netdev/20240326115116.10040-1-mateusz.polchlopek@intel.com/
---

Jacob Keller (10):
  virtchnl: add support for enabling PTP on iAVF
  virtchnl: add enumeration for the rxdid format
  iavf: add support for negotiating flexible RXDID format
  iavf: negotiate PTP capabilities
  iavf: add initial framework for registering PTP clock
  iavf: add support for indirect access to PHC time
  iavf: periodically cache PHC time
  iavf: refactor iavf_clean_rx_irq to support legacy and flex
    descriptors
  iavf: handle set and get timestamps ops
  iavf: add support for Rx timestamps to hotpath

Mateusz Polchlopek (1):
  iavf: Implement checking DD desc field

Simei Su (1):
  ice: support Rx timestamp on flex descriptor

 drivers/net/ethernet/intel/iavf/Makefile      |   3 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  33 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 238 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 543 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  49 ++
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 425 +++++++++++---
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  26 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 148 +++--
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 238 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   2 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  86 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   2 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 include/linux/avf/virtchnl.h                  | 127 +++-
 17 files changed, 1776 insertions(+), 159 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h

-- 
2.38.1


