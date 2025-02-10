Return-Path: <netdev+bounces-164888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD6A2F88A
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689B916442F
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD102566CB;
	Mon, 10 Feb 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kc9rfDW5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570B324BCFD
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739215443; cv=none; b=Moy9SPuilqf+mhwoWFqcOi1o5ojs8oYGwEJsb4s48KrFgAwOcdIE8KtghQdB9geks2x25sYrz4mD/RD4mGe3Nwo8jhLDuoMb5wKkI/hTa2m/CTVj4uPBs5ZDnqNhMblsz/PcsGTPpFqJx5QxdAvWrHPqyU1t/wA49nUDFieDR7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739215443; c=relaxed/simple;
	bh=ONXEmnzALn9fRS3Po3MMrwB7jktik1dKj/r7HKsKLhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZtg0MpA3MyX13x27dprX05VjzzTFjuqTfeXV2RLVqDzzJF1etJZoG8tJCB359Bx6ipN8S+2lmd1PTav+XHI3vW99wFVQ7FNBLdElcnxIeYKIETGKMkSQeQaAU/10kD3EV87bIl62SVGI7iAnneJxqejUOEyg6h/wcjKttMHTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kc9rfDW5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739215441; x=1770751441;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ONXEmnzALn9fRS3Po3MMrwB7jktik1dKj/r7HKsKLhA=;
  b=kc9rfDW5xtjzJ6Ffy5swVBgGpfNXVQHznmQ7Zk3lZrupa7PKouEk6D2j
   /lyi1Y+jieX8VMEsbxgprZIuW0/EdwBGbvGnYjQw33vfuGdm1SlSZMPpW
   F9CwSpUrRcjugN+rh08eyO9rIUxULTqC7EQvIApZqth0MlQAlmZBs8S86
   4Xifdeea2Eo3xc19jGMPSyNSbpRfGJ+s3jJHYCMadENdHHcJXyNGVbJpR
   KCh/5R8ZAILlk4pxPszeelKDEZGMGlq929XsPRGyIfvv21Vzipdglpjn1
   nm1AZ8yOVPageXTqsocZGb/eEvfnk2by9wmqi2l17TVg6LCxa+dNXIQ3P
   g==;
X-CSE-ConnectionGUID: brpIzljMQoyzk0+9hSWyjg==
X-CSE-MsgGUID: xCrmMhbRTty+cU75K/YREA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39929200"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39929200"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 11:24:00 -0800
X-CSE-ConnectionGUID: 0OrIktwkRPqFzyBHKBMClw==
X-CSE-MsgGUID: tz4X8oGtQW6mYckhiV1+Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112733855"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 10 Feb 2025 11:24:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/10][pull request] Intel Wired LAN Driver Updates 2025-02-10 (ice, igc, e1000e)
Date: Mon, 10 Feb 2025 11:23:38 -0800
Message-ID: <20250210192352.3799673-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Karol, Jake, and Michal add PTP support for E830 devices. Karol
refactors and cleans up PTP code. Jake allows for a common
cross-timestamp implementation to be shared for all devices and
Michal adds E830 support.

Mateusz cleans up initial Flow Director rule creation to loop rather
than duplicate repeated similar calls.

For igc:

Siang adjust calls to remove need for close and open calls on loading
XDP program.

For e1000e:

Gerhard Engleder batches register writes for writing multicast table
on real-time kernels.

The following are changes since commit 39f54262ba499d862420a97719d2f0eea0cbd394:
  Merge branch 'eth-fbnic-support-rss-contexts-and-ntuple-filters'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Gerhard Engleder (1):
  e1000e: Fix real-time violations on link up

Jacob Keller (1):
  ice: Add unified ice_capture_crosststamp

Karol Kolacinski (5):
  ice: Don't check device type when checking GNSS presence
  ice: Remove unnecessary ice_is_e8xx() functions
  ice: Use FIELD_PREP for timestamp values
  ice: Process TSYN IRQ in a separate function
  ice: Refactor ice_ptp_init_tx_*

Mateusz Polchlopek (1):
  ice: refactor ice_fdir_create_dflt_rules() function

Michal Michalik (1):
  ice: Implement PTP support for E830 devices

Song Yoong Siang (1):
  igc: Avoid unnecessary link down event in XDP_SETUP_PROG process

 drivers/net/ethernet/intel/Kconfig            |   2 +-
 drivers/net/ethernet/intel/e1000e/mac.c       |  15 +-
 drivers/net/ethernet/intel/ice/ice.h          |   5 -
 drivers/net/ethernet/intel/ice/ice_common.c   | 208 ++++----
 drivers/net/ethernet/intel/ice/ice_common.h   |   7 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   4 +-
 .../net/ethernet/intel/ice/ice_ethtool_fdir.c |  21 +-
 drivers/net/ethernet/intel/ice/ice_gnss.c     |  29 +-
 drivers/net/ethernet/intel/ice/ice_gnss.h     |   4 +-
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  12 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  27 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 505 ++++++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   9 +-
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 413 ++++++++------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  28 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   9 -
 drivers/net/ethernet/intel/igc/igc_xdp.c      |  19 +-
 18 files changed, 765 insertions(+), 554 deletions(-)

-- 
2.47.1


