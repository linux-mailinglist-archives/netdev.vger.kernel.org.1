Return-Path: <netdev+bounces-153792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBBE9F9B04
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14343188B74C
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39CC21A42D;
	Fri, 20 Dec 2024 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrWK/h0L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BE422256F
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 20:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725762; cv=none; b=Sm2BZijvp84hBhFzrg1jT1S/5lxf9uHg8KooPFYeoPmGoTgc/otMUYtuYHJpAwTF4G4y2NDhUd8pZPVWfDtUSSR50XU1WsKYnqpDNp5igj7+735U81WDxha+Je5z8Ve+v1bfz2bAy1QHj4Dk6s6w9xOTXPZwIgr7K21sJGl/cvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725762; c=relaxed/simple;
	bh=Nwo5SYhY6ABeo8fu2KCKIhYU//fRGFO4yS43M1QtI/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oC4QIL9x94lzCxVRlM0LHTXsuP7koHZ9mPukjB4qU6gGgpvtI0M5QsSMRSfjqXsNh9+alLHRhw64QCzDcikepcC8jDeB3bWLvMaSRR0yJD2xqicZfyFLV/DsHpWeHokh+RdJEKtsqHU4YRJS0rP/4vxtbwVBpophU7geGdJCZ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrWK/h0L; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734725761; x=1766261761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Nwo5SYhY6ABeo8fu2KCKIhYU//fRGFO4yS43M1QtI/Y=;
  b=UrWK/h0LIOTa45RMPWVuzD5Y8vw1vbYHREIsCo7tLyJE7VVUxbiLaFag
   htJtiWML99RrJwDrcUpCx3ayD2J+p9YfpvV4rZkHkZ5+Z4uHlwSrVPE/d
   zhE12YE+MKAZzlKe0/ErqdEIOp9pvEqqlQnUg/3bRntwWb6irnFa4QOP3
   aC73DgcyyUjmtVAwJadRYljxmxKi3Kse6ZIw/t6BhnR9Bf5D8dX0TM+nr
   7ih1nozIbHD50wYu6HFOKs7RFATOyUmiOOJWlWBkoXblTI+24Fc+hJ21T
   zQUhENqQLDcEnGay9CsunKkhkrSS2cbOrUL2EaxXZg3aFc1AvY7OHJDms
   w==;
X-CSE-ConnectionGUID: QEacF70DQ7CUEmN2SYAQ5w==
X-CSE-MsgGUID: VRLC5ijASLOVSRkeVLxMbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11292"; a="46292371"
X-IronPort-AV: E=Sophos;i="6.12,251,1728975600"; 
   d="scan'208";a="46292371"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2024 12:16:00 -0800
X-CSE-ConnectionGUID: supQFL0zT26ZPP4YB3ybMA==
X-CSE-MsgGUID: /CdOrjImRg2BQWVx/FcmgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="102717082"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa003.fm.intel.com with ESMTP; 20 Dec 2024 12:16:00 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	piotr.kwapulinski@intel.com,
	przemyslaw.kitszel@intel.com,
	horms@kernel.org
Subject: [PATCH net-next 00/10][pull request] ixgbe, ixgbevf: Add support for Intel(R) E610 device
Date: Fri, 20 Dec 2024 12:15:05 -0800
Message-ID: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Piotr Kwapulinski says:

Add initial support for Intel(R) E610 Series of network devices. The E610
is based on X550 but adds firmware managed link, enhanced security
capabilities and support for updated server manageability.
---
IWL:
ixgbe: https://lore.kernel.org/intel-wired-lan/20241205084450.4651-1-piotr.kwapulinski@intel.com/
ixgbevf: https://lore.kernel.org/intel-wired-lan/20241218131238.5968-1-piotr.kwapulinski@intel.com/

The following are changes since commit b73e56f16250c6124f8975636f1844472f6fd450:
  Merge branch 'xdp-a-fistful-of-generic-changes-pt-iii'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

Piotr Kwapulinski (10):
  ixgbe: Add support for E610 FW Admin Command Interface
  ixgbe: Add support for E610 device capabilities detection
  ixgbe: Add link management support for E610 device
  ixgbe: Add support for NVM handling in E610 device
  ixgbe: Add support for EEPROM dump in E610 device
  ixgbe: Add ixgbe_x540 multiple header inclusion protection
  ixgbe: Clean up the E610 link management related code
  ixgbe: Enable link management in E610 device
  PCI: Add PCI_VDEVICE_SUB helper macro
  ixgbevf: Add support for Intel(R) E610 device

 drivers/net/ethernet/intel/ixgbe/Makefile     |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   13 +-
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |    3 +-
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   |   25 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2658 +++++++++++++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h |   81 +
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |    6 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  436 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |    4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  |    5 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |   72 +-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    | 1074 +++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |   12 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h |    7 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   29 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h |   20 +
 drivers/net/ethernet/intel/ixgbevf/defines.h  |    5 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf.h  |    6 +-
 .../net/ethernet/intel/ixgbevf/ixgbevf_main.c |   12 +-
 drivers/net/ethernet/intel/ixgbevf/vf.c       |   12 +-
 drivers/net/ethernet/intel/ixgbevf/vf.h       |    4 +-
 include/linux/pci.h                           |   14 +
 24 files changed, 4455 insertions(+), 53 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
 create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.h

-- 
2.47.1


