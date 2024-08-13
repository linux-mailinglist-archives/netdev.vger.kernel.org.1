Return-Path: <netdev+bounces-118035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D0F9505F7
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D02B20B2F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82A4206D;
	Tue, 13 Aug 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UuQsZRf7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849BD1993B7
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554491; cv=none; b=D3fTYbDo0oaMzNVkWxe6VumPAbqSMNQE9tpy72oOOJFRE3QbTcsW/ipbqh+Xmm3pB2cDuckCY6Y41WwrrIGtaYb8bin6wz1u5MumtPrYYbw4f5KMWQXaSXy2e9YzTDnOMJk3tHTfErtFvEPbYOvwJGxjfNOcnih1J76kTH2Lb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554491; c=relaxed/simple;
	bh=lNeqJxEpd49T++OecEYoBJ2nLcgVHCPOnYpAfhNlHZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3CkVAEgiv0hlx0ZGKwVdCGSpWI8PzLNqBrtWt63VyZkzkf1LqCmC+h0ra4jfXALIMqxFd5lO6sO6+T2Y2renUwkPWctW/qibw+/VM+hvAHD63BBR0omIwfkWhloKvQNAngsJs6y8Q4QzS1ZVKYnDNhMGasebgzi+mgDLzH0Ygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UuQsZRf7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723554490; x=1755090490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lNeqJxEpd49T++OecEYoBJ2nLcgVHCPOnYpAfhNlHZY=;
  b=UuQsZRf76VdVetaGoDJe6ldOWDOtifmS56nTqHu+1uvonsr0olxz8S5k
   N//zI29SHT0n0TQMKefwUfOb0U9L63q2Ra2bn1j0b9Gs4z8p5fGX7iQ38
   CwOcjYaCaPj7ZXEVdXdCxqva9MfoJePXhQ/Jb9auyV1GU6nE2s2f34rj1
   e7xq6XPVJhp8Xpk7O/KJZY6aIWWt6RyKMboqnl5O+iQGMfRwPGHH8EjmH
   uUw71sTpuDXMAUIhODimMBG8rfm0akbQYysS+5diy3Hcm36dkXbMIhMB0
   JUbUBqwDPFlBmU4qa3PFPE2tkwwUT+y6nt7L75q9uDuJ3sh8OIrc1t9xr
   Q==;
X-CSE-ConnectionGUID: WVNdX0h8Sc6rNNqhJ2Y5cQ==
X-CSE-MsgGUID: cQlgjUFQSm6ugJTeEBZZZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32290899"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="32290899"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 06:08:09 -0700
X-CSE-ConnectionGUID: ieVtGXeDSkKx7LnF+g4xJA==
X-CSE-MsgGUID: 2MrPp1fySh+9RuyaidzUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="59417116"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 13 Aug 2024 06:08:07 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C02CB32C86;
	Tue, 13 Aug 2024 14:08:05 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v9 00/14] Add support for Rx timestamping for both ice and iavf drivers
Date: Tue, 13 Aug 2024 08:54:59 -0400
Message-Id: <20240813125513.8212-1-mateusz.polchlopek@intel.com>
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
v9:
- another big refactor of code, again the list is too long to describe each change. Only
  patch1 and patch12 has not been changed AFAIR. Please take a look on v8 and changes
  requests from Alexander L. (in short - fixed structs paddings, aligns, optimized rx hot
  path, renamed few structs, added "const" keyword where applicable, added kdoc comments
  to newly introduced structs and defines, removed unnecessary casts, simplified few
  functions and few more).

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
 drivers/net/ethernet/intel/iavf/iavf_ptp.c    | 481 ++++++++++++++++++
 drivers/net/ethernet/intel/iavf/iavf_ptp.h    |  26 +
 drivers/net/ethernet/intel/iavf/iavf_trace.h  |   6 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 425 ++++++++++++----
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   |  22 +-
 drivers/net/ethernet/intel/iavf/iavf_type.h   | 272 +++++-----
 drivers/net/ethernet/intel/iavf/iavf_types.h  |  36 ++
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 223 ++++++++
 drivers/net/ethernet/intel/ice/ice_base.c     |   3 -
 drivers/net/ethernet/intel/ice/ice_lib.c      |   5 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |   4 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   8 +
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c |  96 +++-
 drivers/net/ethernet/intel/ice/ice_virtchnl.h |   6 +
 .../intel/ice/ice_virtchnl_allowlist.c        |   7 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  51 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  16 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  19 -
 include/linux/avf/virtchnl.h                  | 131 ++++-
 include/net/libeth/rx.h                       |  42 ++
 24 files changed, 1810 insertions(+), 336 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/iavf/iavf_types.h


base-commit: d1815992133ebcc6007009645571f322f4bc7c44
-- 
2.38.1


