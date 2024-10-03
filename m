Return-Path: <netdev+bounces-131626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0718698F130
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD69D1F21E09
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7F41865EB;
	Thu,  3 Oct 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZ3iKGtO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B8419CC3D
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 14:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965084; cv=none; b=eZxOtZj1kxSFXb9h4YAR6wb10XetxsOakU2O8LLOGQ9Q/kOJOnndjfBEVao0z9yLLkaMk70pKfSNCTKXjK1GXN6m6NWc0e769hvCPdicmcceN++intCXUk7Z7sgh5GujEfec8gbPcZwv14XP1D93l3zFRzD7aFIfOd/AEBA6lig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965084; c=relaxed/simple;
	bh=Z5thH/EpUIjGuMy68wcBUxaGKzOumavlo5M5anIJCRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lfExQsI/2rFQEKyZo/ebONEuDvGuSFl/ZVnP/9GhxKubIFDhDWShS3/GaAqtXy/biWzvsyAxKB1rJQk1WPxEGFxodomEG0/lY5zLKi/dZUikmZuKXKjRKG+5NzJ4WcW30jvjnbvkYjQMbKtvyYqHCq10K3CIu5MCrpSdrelJx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZ3iKGtO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727965083; x=1759501083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z5thH/EpUIjGuMy68wcBUxaGKzOumavlo5M5anIJCRg=;
  b=PZ3iKGtOL2SQpr3zzjYs82oXaGTQuQz3g1O5FQX2a1dUizmwvCDDAbIp
   wf6HdKjFEQFHsR+2viaiMbv+MG6LCRvYsMsNkEPOod3tZ8+Cks0TNyE79
   7K8jjo/QsCcVHvk2N2a4oMHSdYD+ghDzxaEccitNovILVyi4V0/2oGxR2
   I6j5mCIrP1d8CGP1i8Up1I4gXh1FRfAzcIr/RO3c7KdQ3K71dXZCAK9KJ
   y6fJDaaTKvnfC2X1sBOpzS5ByaoVIgtO8MZ4LxdYZS0aNCGvBSlPBBHGJ
   wCFnRHzUWm3DrSaCU9yAIwWSt5eJrPZ2Bs9nrc8uyyzy9M2xapr3HatRE
   A==;
X-CSE-ConnectionGUID: MGGwuXQITWGyJDIk1IrlBw==
X-CSE-MsgGUID: SmJF/9uDQqmYUrjp5eKXkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52567057"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="52567057"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 07:18:03 -0700
X-CSE-ConnectionGUID: Ly1usLgdSX6qJNdkiSSAuw==
X-CSE-MsgGUID: 6RXlGXBUToa+JO1Q7tmSOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="74793796"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.117.83])
  by orviesa007.jf.intel.com with ESMTP; 03 Oct 2024 07:18:02 -0700
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v9 0/7] ixgbe: Add support for Intel(R) E610 device
Date: Thu,  3 Oct 2024 16:16:43 +0200
Message-ID: <20241003141650.16524-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

This patch series adds low level support for the following features and
enables link management.

Piotr Kwapulinski (7):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Add ixgbe_x540 multiple header inclusion protection
  ixgbe: Clean up the E610 link management related code
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   14 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   25 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2579 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   76 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  437 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   72 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1067 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4318 insertions(+), 48 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
V1 -> V2:
  - fix for no previous prototypes for ixgbe_set_fw_drv_ver_x550,
    ixgbe_set_ethertype_anti_spoofing_x550 and
    ixgbe_set_source_address_pruning_x550
  - fix variable type mismatch: u16, u32, u64
  - fix inaccurate doc for ixgbe_aci_desc
  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610
  - add buffer caching and optimization in ixgbe_aci_send_cmd
V2 -> V3:
  - revert ixgbe_set_eee_capable inlining
  - update copyright date
V3 -> V4:
  - cleanup local variables in ixgbe_get_num_per_func
  - remove redundant casting in ixgbe_aci_disable_rxen
V4 -> V5:
  - remove unnecessary structure members initialization
  - remove unnecessary casting
  - fix comments
V5 -> V6:
  - create dedicated patch for ixgbe_x540 multiple header inclusion protection
  - extend debug messages
  - add descriptive constant for Receive Address Registers
  - remove unrelated changes
  - create dedicated patch for code cleanup
  - remove and cleanup of some conditions
  - spelling fixes
V6 -> V7:
  - rebase to adopt recent Makefile "ixgbe-y" changes
V7 -> V8:
  - implement more clear execution flow in ixgbe_aci_list_caps(),
    ixgbe_discover_func_caps(), ixgbe_get_link_status(),
    ixgbe_fc_autoneg_e610(), ixgbe_disable_rx_e610() and
    ixgbe_setup_phy_link_e610()
  - make use of FIELD_PREP macro in ixgbe_is_media_cage_present()
V8 -> V9:
  - tune-up auto-negotiation advertised link speeds at driver load
  - update the method of pending events detection
  - update the way of discovering device and function capabilities
  - update the parameter set-up for the firmware-controlled PHYs
  - fix port down after driver reload

2.43.0


