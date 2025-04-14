Return-Path: <netdev+bounces-182107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FCEA87DF2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 12:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C320418941AB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D9B277014;
	Mon, 14 Apr 2025 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="auBKICzj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1C127604D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 10:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627675; cv=none; b=IurFAfJnO4IVNxC/2MKdpqgBYRuxfCLoBbp/AL7EBGe1OjKmef9QtdsVx87ASdIqmh3pRg7e/xLkAreYVLoKAldXrSVFtv9n4bMhVeJ+GVuX000ZHifvY3rbllNuLDuMBjHBxYX/8/8F+YaJcoYHRIY95xucI1h4tKtO5yMedNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627675; c=relaxed/simple;
	bh=+TjVZGjYo8n4HJPQyDmDpLiNv5Oaf5sgd6xwB5kIKRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PdITL7YRAXAS5HS8EAD7BBoXGA9SuaC1swYiSTKoLa+D3GGQ2dW5eroOHgdjNlOw5p/y6RGDPymgkQ/Uxx7ROlJ9rIwLi3D5rvkrLDvi/6pFGO1berh80DV772faNgZZndoCezJa9XezSzd/fKBh/nyGA8ittpJ3VSFcZfHIqbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=auBKICzj; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744627674; x=1776163674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+TjVZGjYo8n4HJPQyDmDpLiNv5Oaf5sgd6xwB5kIKRg=;
  b=auBKICzj3m1zxUrCYAWIJvze9D+YDpYPovdxJ1MVTSX+dWwMeMW21/eE
   gXC1pDvZscO2Q3qDAftC67WHXsCFBIoP5tQK5YRWqAk8b+BqOPDga63Q8
   3JQIv4quU2YcbVtHapBA0ALYnDhYGmIcGnq3liH84W9Xj7KUslAzj7EVx
   eeirnsN3Tyfu/HvKIx7Qq9jnnYT+xtSxYo7tyGD8PJwvcJH/CjBGfEY7k
   MqGZANdbo3vM2io19AdozrPY6NGJmgk5UqXcTPTUomOMV5BG3MFdBrxvA
   SVIz3E/o5/qi5dMfO6MK0R3VTNzOXCDZW+VuP6JgbPzL26V13fjMMfiTm
   g==;
X-CSE-ConnectionGUID: GNx8PT22RxiQdr8sYz1G1w==
X-CSE-MsgGUID: ITSzC6zlQA2DtG8a4v/Stg==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="71477969"
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="71477969"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 03:47:52 -0700
X-CSE-ConnectionGUID: 3HTss1W8SJGfLy1EeUtTmA==
X-CSE-MsgGUID: 9H98Hl+MTFeQ2GlFI66glg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,212,1739865600"; 
   d="scan'208";a="160739554"
Received: from gklab-003-014.igk.intel.com ([10.211.116.96])
  by orviesa002.jf.intel.com with ESMTP; 14 Apr 2025 03:47:50 -0700
From: Milena Olech <milena.olech@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Milena Olech <milena.olech@intel.com>
Subject: [PATCH v11 iwl-next 00/11] idpf: add initial PTP support
Date: Mon, 14 Apr 2025 12:45:05 +0200
Message-ID: <20250414104658.14706-1-milena.olech@intel.com>
X-Mailer: git-send-email 2.43.5
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

v10 -> v11: change timestamp extension algorithm, use one lock for
latches lists, allocate each index latch separately during caps
negotiation, fix virtchnl comment
v9 -> v10: create a separate patch for cross timestamping, change the
order, improve get device clock time latch mechanism
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

Milena Olech (11):
  idpf: change the method for mailbox workqueue allocation
  idpf: add initial PTP support
  virtchnl: add PTP virtchnl definitions
  idpf: move virtchnl structures to the header file
  idpf: negotiate PTP capabilities and get PTP clock
  idpf: add mailbox access to read PTP clock time
  idpf: add cross timestamping
  idpf: add PTP clock configuration
  idpf: add Tx timestamp capabilities negotiation
  idpf: add Tx timestamp flows
  idpf: add support for Rx timestamping

 drivers/net/ethernet/intel/idpf/Kconfig       |    1 +
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   35 +
 .../ethernet/intel/idpf/idpf_controlq_api.h   |    3 +
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   14 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   75 +-
 .../ethernet/intel/idpf/idpf_lan_pf_regs.h    |    4 +
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |   13 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   47 +
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    9 +-
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    | 1015 +++++++++++++++++
 drivers/net/ethernet/intel/idpf/idpf_ptp.h    |  379 ++++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  171 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   18 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  160 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   84 ++
 .../ethernet/intel/idpf/idpf_virtchnl_ptp.c   |  673 +++++++++++
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  314 ++++-
 18 files changed, 2915 insertions(+), 103 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.c
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_ptp.h
 create mode 100644 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c


base-commit: 427c6457b91dda46d4252166999386e4fa722abd
-- 
2.43.5


