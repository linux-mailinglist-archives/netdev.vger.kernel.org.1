Return-Path: <netdev+bounces-162156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE6A25E88
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 16:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B4B3B0391
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55775207A22;
	Mon,  3 Feb 2025 15:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csl7Qdto"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28B134A8
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 15:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595835; cv=none; b=sz95s41ADIOL4/Mqiy/7tHUnNlWUEODb267eR4YXxzfoxeX8iyXE8q+p1sD1t/D41t6XKjSZ6Bpd3Xm6+VqWNumO0bA/unNHsSXUJ8ymIxuvQR5geDhKAaHZCeLL1GJ11n5SxxLs7ofUY2I/Yn9Dur3DVfCXP7hITgq10EXItVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595835; c=relaxed/simple;
	bh=hrU4YUoQ6tChpjI4I/QYVbfh+gFvdGcc89so4FDsqrs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWjAJBekzwZl7aUHxkH7CyI76S4xJof/Hjzbqb67KdPGR5qHv6m8dqBBzxiJa+YG8ss4bT6odZOhag/vilKdgGbtGQoRR0RbAbhCgtjNZ400XvjVUv1wW9a08frOHjZxjt7njRSFc+WDGQha4MSsrfzCJDU8p6lODs6FvRN092U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csl7Qdto; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738595834; x=1770131834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hrU4YUoQ6tChpjI4I/QYVbfh+gFvdGcc89so4FDsqrs=;
  b=csl7QdtoMJz6LIYJUNsQFs0GkNc5JIrxks35rUojLl1HRIRVdjngYV7y
   /NLWJDyd2SMv9dMylVMRylISM/Trg7tBy14852yy3VR1mMJ0dJfaUV/sT
   j7iGo9plCyO3PFIIgMw83rfmdm+Rjh5QZ+d31LbYP+CkiSS5D3J6E5GuG
   GtU4VrZoUEHBgeuJfgkDmz4EFIUvNBIk06TTPXFMT/vNxh6ND3SaSJB1u
   2vogall4qJTC30MHFO4Jn9HNVws2BmjjRangabdd0PTJduL6mrJ6WlVZo
   zplwwTvHcsUvX4M95u/l+26kCeCe6dJf0UWDBHT35UKEelGRQX9RgrLb2
   A==;
X-CSE-ConnectionGUID: vt9vw+ObQF2DcETu64OQTg==
X-CSE-MsgGUID: uNRjniLaSzqltMeXgw8Sbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56519785"
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="56519785"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 07:17:14 -0800
X-CSE-ConnectionGUID: NI01GYFKS/K6RJndj5OXwA==
X-CSE-MsgGUID: Dit3lA5yRAGJ84UG2BKAfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,256,1732608000"; 
   d="scan'208";a="110886201"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by fmviesa009.fm.intel.com with ESMTP; 03 Feb 2025 07:17:11 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v1 00/13] ixgbe: Add basic devlink support
Date: Mon,  3 Feb 2025 16:03:15 +0100
Message-Id: <20250203150328.4095-1-jedrzej.jagielski@intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create devlink specific directory for more convenient future feature
development.

Flashing and reloading are supported only by E610 devices.

Introduce basic FW/NVM validation since devlink reload introduces
possibility of runtime NVM update. Check FW API version, FW recovery mode
and FW rollback mode. Introduce minimal recovery probe to let user to
reload the faulty FW when recovery mode is detected.

This series is based on the series introducing initial E610 device
support:
https://lore.kernel.org/intel-wired-lan/20241205084450.4651-1-piotr.kwapulinski@intel.com/

Andrii Staikov (1):
  ixgbe: add support for FW rollback mode

Jedrzej Jagielski (9):
  ixgbe: add initial devlink support
  ixgbe: add handler for devlink .info_get()
  ixgbe: add .info_get extension specific for E610 devices
  ixgbe: add E610 functions getting PBA and FW ver info
  ixgbe: extend .info_get with stored versions
  ixgbe: add device flash update via devlink
  ixgbe: add support for devlink reload
  ixgbe: add FW API version check
  ixgbe: add E610 implementation of FW recovery mode

Slawomir Mrozowicz (3):
  ixgbe: add E610 functions for acquiring flash data
  ixgbe: read the OROM version information
  ixgbe: read the netlist version information

 Documentation/networking/devlink/index.rst    |    1 +
 Documentation/networking/devlink/ixgbe.rst    |  105 ++
 drivers/net/ethernet/intel/Kconfig            |    2 +
 drivers/net/ethernet/intel/ixgbe/Makefile     |    3 +-
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  625 +++++++
 .../ethernet/intel/ixgbe/devlink/devlink.h    |   10 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   14 +
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    1 +
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 1510 +++++++++++++++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   16 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   12 +
 .../ethernet/intel/ixgbe/ixgbe_fw_update.c    |  709 ++++++++
 .../ethernet/intel/ixgbe/ixgbe_fw_update.h    |   12 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  180 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    5 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  161 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    1 +
 20 files changed, 3253 insertions(+), 117 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h


base-commit: 09a7ccb316bce8347fefad05809426526b6699f3
-- 
2.31.1


