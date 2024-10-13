Return-Path: <netdev+bounces-135119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8021799C623
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39171C2250D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 09:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0BB156F39;
	Mon, 14 Oct 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DTluy7q4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29034142623
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899045; cv=none; b=Z2Fch7LeSli6Vvwpj4eRyiv1xyMRPFWR35eRK3EjdZRizQ003E05k6vXhd6bUnk29aS0xomjV+IO9HazF7SfIv8bZ/LXO9HWhhgIdD+ZvgcoG0BmXUR1fEK5FE3+PBWV6Ye+V8S3nugg+izllNRoAQ3o6D/lMr0McHs/EH8wDps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899045; c=relaxed/simple;
	bh=/Rwf2+973h7jAI+A4B1mvaxUtlBX4jABG4AkTX0WprQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RfQn2cq/HLsgXv093ytkmbZXSPCbz61J/AzGa9QkGKI5IVBlisyMFDluA9CTep9L35Mg+l58UcDwnx3UJK6nhAgp1PnGKH+th+PELmW/R8J9CEouFNQHIwuB/KRdxwunWJphVpZHLtQwW2fP/SAN8iK8MDIZ4xOBM0wPrUReedw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DTluy7q4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728899043; x=1760435043;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/Rwf2+973h7jAI+A4B1mvaxUtlBX4jABG4AkTX0WprQ=;
  b=DTluy7q4JHGBWnyHlQLRrtRBPt/KyNNwgUsy8AFhi7xLyYvQdId4We90
   nmMZcdjixSklKZU/HgVqr9TVYeJWHJBYEX6fG9CpyYUXlRgUxk9PySH1u
   X3GRzz8WRpdLoWH5vMXPUX6t0mTeQez1zDfMN7Duj2Pnh2rlJgwPt16ON
   62F3VvBfJ2oySaVtJ3Xzp3G3z6OzQaYMJG8ZAplYD1ZgBy8AD8UVNrjxK
   VaICKkjUCd9mVP7m6Et4k5e0mcqLfUdLrtaJg0IQ5JqD0vWs5h+Q+m/lD
   LQH6/SNkt06QC1s4UjLNXvaUntiEWQrti5W3lDYP5zwxg0lO7j/yBIkTV
   Q==;
X-CSE-ConnectionGUID: OUzbTXLNRb6ZBvNd5XCYeg==
X-CSE-MsgGUID: 6av8KdzCTaS2NtZUdwkhWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45712139"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45712139"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 02:44:02 -0700
X-CSE-ConnectionGUID: dN3unCp2Sdi0ytkh00mzdg==
X-CSE-MsgGUID: Yqdan1SET06D8kVSoEr48Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77531785"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 14 Oct 2024 02:44:00 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8CE9D27BA0;
	Mon, 14 Oct 2024 10:43:58 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v11 00/14] Add support for Rx timestamping for both ice and iavf drivers
Date: Sun, 13 Oct 2024 11:44:01 -0400
Message-Id: <20241013154415.20262-1-mateusz.polchlopek@intel.com>
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

Side notes:
Wojtek did great job handling this series during my vacations. Thanks!
---
v11:
- addressed all comments from v10 done by Alexander L. Short list: changed some
  logging functions (like pci_warn instead of dev_warn), fix RCT, fix indentation,
  remove unnecessary comments and casts, change error codes where applicable,
  remove ptp.initialized field in struct (now check for ptp.clock as Olek
  suggested), invert condition in few places to avoid +1 indent level, function
  iavf_ptp_do_aux_work made as static, add more descriptive kdoc for libeth
  struct fields, restore ptype as a field in libeth struct, remove unused
  defines, pass to specific functions quad word of descriptor instead of pass
  rx_desc, add asserts to structs where applicable, return from fields extracting
  functions when !fields.eop, refactor get VLAN tags, remove unnecessary empty
  initialization of structs and few more. Please see v10 to compare all changes.

v10:
- only cosmetic changes, make every patch compile, fixing checkpatch issues
https://lore.kernel.org/netdev/20240821121539.374343-1-wojciech.drewek@intel.com/

v9:
- another big refactor of code, again the list is too long to describe each change. Only
  patch1 and patch12 has not been changed AFAIR. Please take a look on v8 and changes
  requests from Alexander L. (in short - fixed structs paddings, aligns, optimized rx hot
  path, renamed few structs, added "const" keyword where applicable, added kdoc comments
  to newly introduced structs and defines, removed unnecessary casts, simplified few
  functions and few more).
https://lore.kernel.org/netdev/20240813125513.8212-1-mateusz.polchlopek@intel.com/

v8:
- big refactor to make code more optimised (too many changes to list them here, please
  take a look on v7 patch9 and comments from Alexander L) - patch 11. Because of that I
  decided to remove all gathered RB tags.
- changed newly introduced spinlock aq_cmd_lock to mutex type to avoid deadlock - patch 7
- adjusted function iavf_is_descriptor_done() to extract fields from descriptor in a new
  way - patch 12
- changed (and removed unused) defines that describe specific fields and bits in
  descriptor
https://lore.kernel.org/netdev/20240730091509.18846-1-mateusz.polchlopek@intel.com/

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
  iavf: define Rx descriptors as qwords
  iavf: Implement checking DD desc field

Simei Su (1):
  ice: support Rx timestamp on flex descriptor

 drivers/net/ethernet/intel/iavf/Makefile      |   2 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  35 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 228 ++++++++-
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 483 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  22 +
 drivers/net/ethernet/intel/iavf/iavf_trace.h  |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 433 ++++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  24 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 239 ++++-----
 drivers/net/ethernet/intel/iavf/iavf_types.h  |  34 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 201 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   8 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   3 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  77 ++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   6 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   7 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  51 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  16 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  19 -
 include/linux/avf/virtchnl.h                  | 135 ++++-
 include/net/libeth/rx.h                       |  47 ++
 24 files changed, 1757 insertions(+), 331 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_types.h


base-commit: a77c49f53be0af1efad5b4541a9a145505c81800
-- 
2.38.1


