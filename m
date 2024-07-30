Return-Path: <netdev+bounces-114049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737F7940D71
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87351F246B4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65F2194C72;
	Tue, 30 Jul 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZoRdcL6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4192B9B0
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331669; cv=none; b=N2jYpf0Ikzdokk8XsFISGSMz+HMjR+F5SYw7hX4i745pOALOnhz6eDUJ4j4Fu0tHMQIIYd2g39H/mSAOdKsQCHbEyFiZ4Y2oLGMJIballUNEhgh5fguxDlLj/LJyL1YdFf2JcE9Ry1hEFSlmAqqPocuOekJirlYaKuKQz8whf2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331669; c=relaxed/simple;
	bh=/xc305hZ1fgi+sqa7EgPLJ8tLE23zwVmB4ti5MS5iVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofTaOLqSBefiLEHRSjepr+/JFuZi1oM6TJ2v4fVghruJY/vK1IDJyifEKpWK/Lq1p8Qpa5VovU6n0ypCQl52Uhvnu1ErbxrZa+fVB2bqdtyOEb6IbjS2pi9IhVJgONE1XFHQqx18Vt0ER1WdVDnJbIEfSdx8b2VOqI/Tt0IxZLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZoRdcL6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722331667; x=1753867667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/xc305hZ1fgi+sqa7EgPLJ8tLE23zwVmB4ti5MS5iVg=;
  b=nZoRdcL6tTS4i+MjsRNg2AJlR0byrc/V5krxW6BQxj+zUm/OHPY3xlvA
   WOxRkMDTUIWHosZ3ajYdA6uOKZZmonONfVPT9FYvtJTu8NRa63stVp/M/
   tlc5jQP/A5drFEcYsQqN/a0w0IWolDP0SYX4K/HxGmoCgsEAQBvgLEM4Q
   LZ7M7FmD2i/mPmqkkcMvNuf/DXW5PTq7tmrQa/6abSQKv8hpbpfG/8LW9
   AiVYDAGRnxEXKM5GZnWTXQK351SBmIh5sBfvDlGE2EIfqNRtdKk0bLfq1
   +kqUe3o81ofQSklrFjRDBgl+dBTiZok5cbiofGq1d+uX5JbJqBsckpg6j
   w==;
X-CSE-ConnectionGUID: XiusUP5FQ42rq431LWbOkQ==
X-CSE-MsgGUID: tngsgVucTHWm1fK1eew5hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="45551278"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="45551278"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:27:47 -0700
X-CSE-ConnectionGUID: FneXpZpBRw6FHV13c64GYg==
X-CSE-MsgGUID: biPhBIKDReyK74BND5GFMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="84923114"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa002.jf.intel.com with ESMTP; 30 Jul 2024 02:27:45 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 975602816E;
	Tue, 30 Jul 2024 10:27:43 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v8 00/14] Add support for Rx timestamping for both ice and iavf drivers.
Date: Tue, 30 Jul 2024 05:14:55 -0400
Message-Id: <20240730091509.18846-1-mateusz.polchlopek@intel.com>
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
v8:
- big refactor to make code more optimised (too many changes to list them here, please
  take a look on v7 patch9 and comments from Alexander L) - patch 11. Because of that I
  decided to remove all gathered RB tags for this patch.
- changed newly introduced spinlock aq_cmd_lock to mutex type to avoid deadlock - patch 7
- adjusted function iavf_is_descriptor_done() to extract fields from descriptor in a new
  way - patch 12
- changed (and removed unused) defines that describe specific fields and bits in
  descriptor

v7:
- changed .ndo_eth_ioctl to .ndo_hwtstamp_get and .ndo_hwtstamp_set
  (according to Kuba's suggestion) - patch 11
https://lore.kernel.org/netdev/20240604131400.13655-1-mateusz.polchlopek@intel.com/

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

Mateusz Polchlopek (3):
  libeth: move idpf_rx_csum_decoded and idpf_rx_extracted
  iavf: flatten union iavf_32byte_rx_desc
  iavf: Implement checking DD desc field

Simei Su (1):
  ice: support Rx timestamp on flex descriptor

 drivers/net/ethernet/intel/iavf/Makefile      |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  35 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 238 +++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 544 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  49 ++
 drivers/net/ethernet/intel/iavf/iavf_trace.h  |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 417 ++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  22 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 216 +++----
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 239 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   8 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  86 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   2 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   6 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  20 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |   8 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  19 -
 include/linux/avf/virtchnl.h                  | 124 +++-
 include/net/libeth/rx.h                       |  34 ++
 22 files changed, 1787 insertions(+), 296 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h


base-commit: 9e36cf8c8f4eee458dbc0fb9629a40159c704961
prerequisite-patch-id: cc2f45657b670428d502b1698de062ed8c3fcc81
-- 
2.38.1


