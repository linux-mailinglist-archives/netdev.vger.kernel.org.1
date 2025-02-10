Return-Path: <netdev+bounces-164747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D118A2EF4E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 15:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A776A3A5BA4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4698D233142;
	Mon, 10 Feb 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9k+K7lJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C582327B9
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739196620; cv=none; b=h/d7u9i0tBNVU+uPEkIgEe0+WD4sb3ZmNiO6OM8Kvu4wwolnfz7ZYxGDTqrR5CGkQ621Z6yCpyztNGVaWy+aB5pnFahlVlygbqMBECLE5ZqoaHSq3fbYUUIq6KYnSiibnOn1ER8wgGyQh3DCQEiw8IhU3idFihxAv0AbyH3ESGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739196620; c=relaxed/simple;
	bh=BiLaCyokrJFFKJLK//RofcN+NCXzo7rXDGJPQCrHrVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfzlT5zJcpl8XjV7Saf2N6uWnK77kuulF72u5MubTIcmwhjJe/RH4PIVRhc8hq2MZmyxvd/HXXECoj9Bu8SyVPxsst/kXRr+s83VeKoLoVcWDoeYo/x6nhNYq+679noyIOeCYM380pPfb8MOLvxa7yKniM2XwwLDOwSD4jq9yUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9k+K7lJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739196619; x=1770732619;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BiLaCyokrJFFKJLK//RofcN+NCXzo7rXDGJPQCrHrVg=;
  b=f9k+K7lJkgiByLqTj0XZzQz8mhRnFMhIRxqUDvcbxqfKWzSqvgjU/QYL
   okSzxS3PCN1/A55rjWBANPnQ8TyCscYpb0h+I0u2S/o87yYVT/owb++3T
   UJCcm2sC4h74KoW3D6OgBXeywuCZRM+yBRg0VOe/IoHbPOCtgBTUL3cbQ
   IagyEXk3sKgQ0QBeuEgN8kvaol33jexBIUbheoTftTQSwyESyaNbXRNbc
   i6iMHDTQaYOSHiWCzPxOiG2Lr/2dONBQiADBHd1KNTuOTMBn/Egsk2E5M
   GlqVMbazB9Wui49fE70l2sHUdLBY4nZgCIxrmR0dVFhp+OvkvdzyBbX7G
   w==;
X-CSE-ConnectionGUID: Iko1GbPbQuWR4hUt8UfGaQ==
X-CSE-MsgGUID: UsJ6OMrvSKS/Fioih0tfrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="57190336"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="57190336"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 06:10:18 -0800
X-CSE-ConnectionGUID: 3GNdtsHEQ6CySoGlqa07Hg==
X-CSE-MsgGUID: KCmS9NgsT0K6p3uD9o79hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="111964177"
Received: from os-delivery.igk.intel.com ([10.102.18.218])
  by orviesa009.jf.intel.com with ESMTP; 10 Feb 2025 06:10:16 -0800
From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH iwl-next v2 00/13] ixgbe: Add basic devlink support
Date: Mon, 10 Feb 2025 14:56:26 +0100
Message-Id: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
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
 .../ethernet/intel/ixgbe/devlink/devlink.c    |  629 +++++++
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
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  178 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    5 +
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  161 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |    1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |    1 +
 20 files changed, 3256 insertions(+), 116 deletions(-)
 create mode 100644 Documentation/networking/devlink/ixgbe.rst
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/devlink/devlink.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.h


base-commit: 09a7ccb316bce8347fefad05809426526b6699f3
-- 
2.31.1


