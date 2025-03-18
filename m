Return-Path: <netdev+bounces-175814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63376A678C8
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 17:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C9F188A804
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FB3210F58;
	Tue, 18 Mar 2025 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yt9VG6yf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915C20ADF4
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314419; cv=none; b=MY+Z78WtJK4NnDxNSaPzt7I4ER/kLewgPnMRvBo5fJ2CoJyHF0/OrQFRJAfMXRxt75Eh6k4w6W67BIaEflXErjqSyBRv1MnTnkEMQb07qiPY5a9XdTXo3M5VLeBgzFeiaHQERclUFhiZR8SNk56ITzW8FDlAC+ChA7VV/FkZg4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314419; c=relaxed/simple;
	bh=KHZmWIDBjEhcVDZ+cpgRQhrqLsnPQKA55BEIHKUA1rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ptaNMkxB7IM1LdAgbiLimukkRUH40H3yFaZtUCJt/P25CPcNDIiJ73/WV6lXJb7u4YdT634JOyoAB07hEbehJCA3p5MOPmUZ2eaMdvJ6dPMVyHDKsNT5Tm8lxzB+EiPQoT5+YlfIIS9Y5/5Hc0Aw1GJeSQ4SNkbgrV0BgAHq5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yt9VG6yf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742314413; x=1773850413;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KHZmWIDBjEhcVDZ+cpgRQhrqLsnPQKA55BEIHKUA1rc=;
  b=Yt9VG6yfBhIloDOe4aE+dKjWU/ypOZ8SKBVVGqTytnUwCKh/q0ukYOFo
   vBGKKa9ZbEGGwZHIKeVUySg7wevVIN3n6yVNWdZvkmfVl0KW3a50Mwi9C
   dgbcRsr88UYit9r7hr2IH2j4XcGhwT4WhwwVBCoketxCOj4aJctxpNWUp
   t7NZdZWc5Fjg6RVjpUCKzHZrgPFJLqs9iLiquvz2P+56ZQ+OiGVk+2gx1
   yRmK+D3C8mlmacN5I8QaFDB5eBQEOegxk1yGdUk3GqXwhr4oEVL+ZhTnM
   32r/8RP/ZqKERiNW+zbzAFztykQ386jfIWwmry5lGM3WyTxD9YkxTPvJO
   A==;
X-CSE-ConnectionGUID: APVNPKNAQgmK2NvBekREtw==
X-CSE-MsgGUID: bi+vL7/FS2KFLwhUtML7gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="54458787"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="54458787"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 09:13:32 -0700
X-CSE-ConnectionGUID: 8bJRR5y4Q9eUOfTyEIfqPg==
X-CSE-MsgGUID: /GbrMGfiQYGjr6gcQe3OaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="122041923"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Mar 2025 09:13:33 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	milena.olech@intel.com,
	przemyslaw.kitszel@intel.com,
	karol.kolacinski@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 00/10][pull request] idpf: add initial PTP support
Date: Tue, 18 Mar 2025 09:13:15 -0700
Message-ID: <20250318161327.2532891-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milena Olech says:

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
---
IWL: https://lore.kernel.org/intel-wired-lan/20250313180417.2348593-1-milena.olech@intel.com/

The following are changes since commit 23c9ff659140f97d44bf6fb59f89526a168f2b86:
  Merge branch 'net-stmmac-remove-unnecessary-of_get_phy_mode-calls'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

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

 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   35 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |    3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   75 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |    4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   57 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 1000 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  370 ++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  171 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  161 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  677 +++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  314 +++++-
 18 files changed, 2906 insertions(+), 103 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c

-- 
2.47.1


