Return-Path: <netdev+bounces-152960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B639F6721
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221A8189497F
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 13:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3461ACED2;
	Wed, 18 Dec 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx5bD0xF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E981ACEB0
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734527575; cv=none; b=s9FFF076W7b4PkoUhgnba6Gwv+MgJ5PWQeoSw+QlZQvHAI3Adv8Fww61xiFbYCJvQv4iU+3kAqlbN6nHihTXpvr+NvOFoTqZOhnq9/PbX0LEJNSTYWGqoN6wd2x+S8KeDtoMTMyB9UwChR9Shq/K7Twy+nINNN4dVVk2e6jukF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734527575; c=relaxed/simple;
	bh=Lv2CDgoXs13IOcxlzHVU5MTFI+KJ6mbBs57kYxXXYVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0QfdD+BLbgKDfOySDtXfjC3/H0TQQsjYGXsVHbswvhJmR/qlTsO0CgZlA6d/yBkKqpVgaIyl5CbAiOif1t6NF099mvmxNlDhfmaS8Y/J895vyfwQxj4pchkwHcawNrfOoGUcbf+S7mP3mnXmbU+fFOD8OTBfjKmC78CzvxT4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx5bD0xF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734527574; x=1766063574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lv2CDgoXs13IOcxlzHVU5MTFI+KJ6mbBs57kYxXXYVc=;
  b=Jx5bD0xFKPEoiQF+lpBQ4Mf5g8dhzVSz6ylKk0t+v/c6EONbkf7qawHh
   AeQZzSBHL6Huq/RLPPaa7DAsryfNitQglJsQBvpMhOotzXgCkubZKMW5e
   feqbcQU6kzS+DPEfmYLosPNud3NeI6QzEIE+Wizf/rJdDXtEr2dth+hWR
   6YCMxKw8UIpNacIFQ1hUkK1VNpGzLMvPCK4u8FURIo4etlqJhSUqEq21o
   a4iD+kw27NcME/o/LZ0UdpAiRybogYuFAcTKx4KasZlAls2FqoSwfdB+z
   O8JZPM/aP8zcYkaGSx3F/0pBYMUCtv4+vjGaeHSfSLQHdUsD6ZLRIdmPD
   A==;
X-CSE-ConnectionGUID: 9IHBP5uUSXmIOI+PHeNiCA==
X-CSE-MsgGUID: rCin4V3uSd6V3YerfjQvwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22589566"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="22589566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 05:12:53 -0800
X-CSE-ConnectionGUID: PkDnewjFRvy4yFb6QUOuDw==
X-CSE-MsgGUID: FDuqev5VRu67/fSfqDohMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102471016"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.118.127])
  by fmviesa005.fm.intel.com with ESMTP; 18 Dec 2024 05:12:52 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v3 0/2] ixgbevf: Add support for Intel(R) E610 device
Date: Wed, 18 Dec 2024 14:12:36 +0100
Message-ID: <20241218131238.5968-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Intel(R) E610 Series of network devices. The E610 is
based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.

Piotr Kwapulinski (2):
  PCI: Add PCI_VDEVICE_SUB helper macro
  ixgbevf: Add support for Intel(R) E610 device

 drivers/net/ethernet/intel/ixgbevf/defines.h      |  5 ++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |  6 +++++-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 12 ++++++++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c           | 12 +++++++++++-
 drivers/net/ethernet/intel/ixgbevf/vf.h           |  4 +++-
 include/linux/pci.h                               | 14 ++++++++++++++
 6 files changed, 47 insertions(+), 6 deletions(-)

-- 
v1 -> v2
  allow specifying the subvendor ("Subsystem Vendor ID" in the spec) in
  the PCI_VDEVICE_SUB macro
v2 -> v3
  update IXGBE_SUBDEV_ID_E610_VF_HV to 0x00FF

2.43.0


