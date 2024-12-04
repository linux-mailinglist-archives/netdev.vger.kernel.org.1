Return-Path: <netdev+bounces-149015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1171A9E3CC0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DCE283EDD
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CBC20A5C3;
	Wed,  4 Dec 2024 14:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jqX1ZCkJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2E208997
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733322688; cv=none; b=CRjyV+Ar/eoHuRkqm5yZwxqJKoaviYq3yO4bZ/c/te7Wq2cMVWJEUyv9KvqXD2MhJsfJ2usNdvDVcVnBPpl6+xzLANwjYdnva3dD9bDGQfJ7xu6ztO+fMauImbUueXYRlaa9LWmzERJzmlTaBPPVn3kjQsiK19UIdqzmy5LBmmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733322688; c=relaxed/simple;
	bh=ylekp1q9dXOocIdM2S7qJGupqIGIZ+5pqILllRble4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oprXCOMpYQFeQDzcSHwncjDzKyGoNvKkZonrQTWk5EC/gCTXiD0Zu3vruVqEB6Fq2LCwklHPXHjQeQCUzqkfG/13EVWAtbCDqI1v926k0DFvNCRE80OsrAaU6mlbmpK1ho3C3EETME0GoXCCPBtKT4ah72sALNzs0ToSwVONj/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jqX1ZCkJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733322687; x=1764858687;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ylekp1q9dXOocIdM2S7qJGupqIGIZ+5pqILllRble4c=;
  b=jqX1ZCkJVn9zE9pS+IQjQAW4n1bUwhFg3YuOj2KG+D3cOTRWZGi59HNo
   KuZap+UG6Ku4hcGt4PxAjrEiLmDo8pzE1AVC2KnoJr0+MtjpngXIfqMxQ
   PeHlfua8cEcCQfIi2kL5IIkQbRD7uIr+6exEEtkBqvjun0hq76nywZB8r
   kfDbY9FZk+rpckpOyr+PeGsegogQzL6emteGyrFzLKnZDb9ixHt6gNCKM
   dwAtq0UbF4d+eSe+9RKFgvfK9aNOT9cJXmNeHpYdrVdlbF4NAYJEVwdmA
   zDVjvpyhC4xldtk/ew5QnmuB6dfm19zrkw2DsY8rs6cXtGssjg6dQkdca
   Q==;
X-CSE-ConnectionGUID: 5dzi52haRze0d1AvCD7J7g==
X-CSE-MsgGUID: 3ayrH1BBSsKRGk41YjPS1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44621545"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44621545"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 06:31:27 -0800
X-CSE-ConnectionGUID: /6gRdQ5oSHiC8z9W7Bhi3w==
X-CSE-MsgGUID: AYLHQ7xUQ5297gIrBAuoRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="93456119"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
  by fmviesa006.fm.intel.com with ESMTP; 04 Dec 2024 06:31:25 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v11 0/8] ixgbe: Add support for Intel(R) E610 device
Date: Wed,  4 Dec 2024 15:31:04 +0100
Message-ID: <20241204143112.29411-1-piotr.kwapulinski@intel.com>
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

Piotr Kwapulinski (8):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Add support for EEPROM dump in E610 device
  ixgbe: Add ixgbe_x540 multiple header inclusion protection
  ixgbe: Clean up the E610 link management related code
  ixgbe: Enable link management in E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   25 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2653 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   81 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  436 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   72 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1075 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 18 files changed, 4404 insertions(+), 47 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
Add dedicated patch for EEPROM dump.

v1 -> v2:
  - fix for no previous prototypes for ixgbe_set_fw_drv_ver_x550,
    ixgbe_set_ethertype_anti_spoofing_x550 and
    ixgbe_set_source_address_pruning_x550
  - fix variable type mismatch: u16, u32, u64
  - fix inaccurate doc for ixgbe_aci_desc
  - remove extra buffer allocation in ixgbe_aci_send_cmd_execute
  - replace custom loops with generic fls64 in ixgbe_get_media_type_e610
  - add buffer caching and optimization in ixgbe_aci_send_cmd
v2 -> v3:
  - revert ixgbe_set_eee_capable inlining
  - update copyright date
v3 -> v4:
  - cleanup local variables in ixgbe_get_num_per_func
  - remove redundant casting in ixgbe_aci_disable_rxen
v4 -> v5:
  - remove unnecessary structure members initialization
  - remove unnecessary casting
  - fix comments
v5 -> v6:
  - create dedicated patch for ixgbe_x540 multiple header inclusion protection
  - extend debug messages
  - add descriptive constant for Receive Address Registers
  - remove unrelated changes
  - create dedicated patch for code cleanup
  - remove and cleanup of some conditions
  - spelling fixes
v6 -> v7:
  - rebase to adopt recent Makefile "ixgbe-y" changes
v7 -> v8:
  - implement more clear execution flow in ixgbe_aci_list_caps(),
    ixgbe_discover_func_caps(), ixgbe_get_link_status(),
    ixgbe_fc_autoneg_e610(), ixgbe_disable_rx_e610() and
    ixgbe_setup_phy_link_e610()
  - make use of FIELD_PREP macro in ixgbe_is_media_cage_present()
v8 -> v9:
  - tune-up auto-negotiation advertised link speeds at driver load
  - update the method of pending events detection
  - update the way of discovering device and function capabilities
  - update the parameter set-up for the firmware-controlled PHYs
  - fix port down after driver reload
v9 -> v10:
  - clean-up redundant automatic variables
  - optimize return statements
v10 -> v11:
  - add support for EEPROM dump
  - use little endian type in admin commands
  - fix link status message based on FW link events

2.43.0


