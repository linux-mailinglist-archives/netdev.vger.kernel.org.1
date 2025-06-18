Return-Path: <netdev+bounces-199170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11039ADF4DD
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 19:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAA63A985E
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 17:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7EF2FCE20;
	Wed, 18 Jun 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADY6pX9f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B552FCE11
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750268565; cv=none; b=B4PqDj49NMEue/cS4kdsGj5jrxTAgx/y8UOr0/YIKFopEQYDt+ejEbVZN9BvZ5VH35Oj7id5y2l4+sXo6h3GzysYo1BId6dNN1N90sojiliFsDkeyPLz34rUefOw1iecurOgCJzGSJ9Tsbvh6Y3M2nJ2Q6QZ9wgO5koyrdNSbU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750268565; c=relaxed/simple;
	bh=ezfkWYilFJoWjnrdYnziJbrI9I7n/cw46+cyVaxD7S4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBJAcdEbuGFXd7sbNIa74eBuz7Evwe+EYJf/GkhAtsXqIL6gFSAutoQKAT8mM4fD/AnXx82lR0FERSOtZsQl2yotUiMKkWAKedDKjL85QDYbx/A5F7o/Gplr2YtPGlWrj1RlJVU1aadEWaJTsWvz2iqIsdxfQol2qI1eChu1pdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADY6pX9f; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750268564; x=1781804564;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ezfkWYilFJoWjnrdYnziJbrI9I7n/cw46+cyVaxD7S4=;
  b=ADY6pX9fx8o6VIxUBkpWSslDBHTzTsL23K8hJ7X8vHK1QhBNt3JFthTC
   alOOdd9MlLISASM4Aa6CGUe5HYtRG6b0iMipRH0tsgvZmBzQoui+Rt0P3
   7uFMIUc5h79KRZflseV/gIBfXwu7MyHSkzhIK9kmQ/zJ9R6Dqm0BqiaQU
   hSdeyxdZpr8WHgZVwLiR4oFQLHZiHdADi1Ro1tAlucJMmKRVbcPjJSJdj
   TBycFspjh/fbiXEwf+q2p/Pt8cdLjYNa4rsnae+//PH+OguBQKwoMCk7Z
   hu6tsrULKt7ktK/O945pX6IzPjS89/IydyLusZqSueTHPdoM9MgCeybWE
   Q==;
X-CSE-ConnectionGUID: loxUpT4tSRyRGCV10kRe6A==
X-CSE-MsgGUID: LFSG1xGiTpe8AdiHSQRtPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="56183658"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="56183658"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 10:42:43 -0700
X-CSE-ConnectionGUID: 7HSDCHPCTHGz4IrrVZ6MvQ==
X-CSE-MsgGUID: fCdFJyRVREeDkLfML7fmWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149695803"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 18 Jun 2025 10:42:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	karol.kolacinski@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	richardcochran@gmail.com
Subject: [PATCH net-next 00/15][pull request] ice: Separate TSPLL from PTP and clean up
Date: Wed, 18 Jun 2025 10:42:12 -0700
Message-ID: <20250618174231.3100231-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jake Keller says:

Separate TSPLL related functions and definitions from all PTP-related
files and clean up the code by implementing multiple helpers.

Adjust TSPLL wait times and fall back to TCXO on lock failure to ensure
proper init flow of TSPLL.

Change default clock source for E825-C from TCXO to TIME_REF if its
available.
---
IWL: https://lore.kernel.org/intel-wired-lan/20250501-kk-tspll-improvements-alignment-v4-0-24c83d0ce7a8@intel.com/

The following are changes since commit fc4842cd0f117042a648cf565da4db0c04a604be:
  Merge branch 'netconsole-msgid' into main
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jacob Keller (4):
  ice: fix E825-C TSPLL register definitions
  ice: clear time_sync_en field for E825-C during reprogramming
  ice: read TSPLL registers again before reporting status
  ice: default to TIME_REF instead of TXCO on E825-C

Karol Kolacinski (11):
  ice: move TSPLL functions to a separate file
  ice: rename TSPLL and CGU functions and definitions
  ice: remove ice_tspll_params_e825 definitions
  ice: use designated initializers for TSPLL consts
  ice: add TSPLL log config helper
  ice: add ICE_READ/WRITE_CGU_REG_OR_DIE helpers
  ice: use bitfields instead of unions for CGU regs
  ice: add multiple TSPLL helpers
  ice: wait before enabling TSPLL
  ice: fall back to TCXO on TSPLL lock fail
  ice: move TSPLL init calls to ice_ptp.c

 drivers/net/ethernet/intel/ice/Makefile       |   2 +-
 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 drivers/net/ethernet/intel/ice/ice_cgu_regs.h | 181 ------
 drivers/net/ethernet/intel/ice/ice_common.c   |  71 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |  58 ++
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  14 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 177 +-----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 564 +-----------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  54 +-
 drivers/net/ethernet/intel/ice/ice_tspll.c    | 518 ++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_tspll.h    |  31 +
 drivers/net/ethernet/intel/ice/ice_type.h     |  20 +-
 12 files changed, 712 insertions(+), 979 deletions(-)
 delete mode 100644 drivers/net/ethernet/intel/ice/ice_cgu_regs.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.c
 create mode 100644 drivers/net/ethernet/intel/ice/ice_tspll.h

-- 
2.47.1


