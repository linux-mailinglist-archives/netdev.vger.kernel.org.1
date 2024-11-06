Return-Path: <netdev+bounces-142498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2162A9BF5D0
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25231F228F8
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2AF20823B;
	Wed,  6 Nov 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iau+yy8U"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DC207A1A
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730919532; cv=none; b=n0YVkymPZMf0lGXhCVYBUVO2+eBqoMo95GFcJSQxCC1xkzwn0krG2ZV23mV8biQ+7DGxmXHFfbCVAeZSR6Wx9NG8FHz3Ed6ShSJOWedXN3DlpXU0wsbnwOjzEFYDmcOBkIQqzuaWjtmFPWQoEARp6M64RaW/GbMUFt2F7qQZkqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730919532; c=relaxed/simple;
	bh=SDI/0rzwiJm+GJEizqtwZHkTsAwZppo4C3xkG2bUSXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lwaFAqjwC+TbrCjjgSmtQMdyBbibsO3smDQYFM4qrylXY9axrnMM3gla92Vh0hyuDPlq9cupm4nn7bsjwhmwfMeu8CoDiUU4xJfOyeCMcbXyq1mx1Si3xoSr/eV+56OPe4ES8fq2puALMK3i2rIojmgTym6awf1tEYenW7Ing2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iau+yy8U; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730919531; x=1762455531;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SDI/0rzwiJm+GJEizqtwZHkTsAwZppo4C3xkG2bUSXM=;
  b=iau+yy8UbafMNtOG/q2zowJeV55gKRNM5O0svFBJrgHk/DjRBJkwGHtZ
   UQWfalT7ydduDNfqxlrTdxdczVVKIk83C8Xk3+u6J+xwwThRIjMhMsXw1
   oTk6bxXYWFfG74F1IWQB0bu3OwKrjoDXXs1Zj0Y03Dnjs5lShsDGiN6hq
   H5F8iYRO9LQ2Q+wimt5LOSrqbwTts3t6szKg2Zsl4Owb09FiMIyQlxiT8
   h67khtFyBeGf1KZ3kamh2y2rDsvICxl2IN+G2rPRUCzSTbiTV+haVHC6h
   h4usHNqWxXk3OXyIFV3SaNLcL089yOGyXA4tKNd8dt9Um1D1STRxDT1eM
   w==;
X-CSE-ConnectionGUID: 6TXAnKamTq6/Zt98Gby2lQ==
X-CSE-MsgGUID: ygwjpc4TRTy3oH6gQ0as6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="30959457"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="30959457"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 10:58:50 -0800
X-CSE-ConnectionGUID: Ph0lnBW0T2eTSVFoAPMMTQ==
X-CSE-MsgGUID: HVxW13hSRaykkM1ysO4ItA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89813788"
Received: from timelab-spr11.ch.intel.com ([143.182.136.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Nov 2024 10:56:39 -0800
From: Christopher S M Hall <christopher.s.hall@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: david.zage@intel.com,
	vinicius.gomes@intel.com,
	netdev@vger.kernel.org,
	rodrigo.cadore@l-acoustics.com,
	vinschen@redhat.com
Subject: [PATCH iwl-net v3 0/6] igc: Fix PTM timeout
Date: Wed,  6 Nov 2024 18:47:16 +0000
Message-Id: <20241106184722.17230-1-christopher.s.hall@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There have been sporadic reports of PTM timeouts using i225/i226 devices

These timeouts have been root caused to:

1) Manipulating the PTM status register while PTM is enabled and triggered
2) The hardware retrying too quickly when an inappropriate response is
   received from the upstream device

The issue can be reproduced with the following:

$ sudo phc2sys -R 1000 -O 0 -i tsn0 -m

Note: 1000 Hz (-R 1000) is unrealistically large, but provides a way to
quickly reproduce the issue.

PHC2SYS exits with:

"ioctl PTP_OFFSET_PRECISE: Connection timed out" when the PTM transaction
  fails

Additional problem description tested by:
Corinna Vinschen <vinschen@redhat.com>

  This patch also fixes a hang in igc_probe() when loading the igc
  driver in the kdump kernel on systems supporting PTM.

  The igc driver running in the base kernel enables PTM trigger in
  igc_probe().  Therefore the driver is always in PTM trigger mode,
  except in brief periods when manually triggering a PTM cycle.

  When a crash occurs, the NIC is reset while PTM trigger is enabled.
  Due to a hardware problem, the NIC is subsequently in a bad busmaster
  state and doesn't handle register reads/writes.  When running
  igc_probe() in the kdump kernel, the first register access to a NIC
  register hangs driver probing and ultimately breaks kdump.

  With this patch, igc has PTM trigger disabled most of the time,
  and the trigger is only enabled for very brief (10 - 100 us) periods
  when manually triggering a PTM cycle.  Chances that a crash occurs
  during a PTM trigger are not zero, but extremly reduced.


Changelog:

v1 -> v2: -Removed patch modifying PTM retry loop count
      	  -Moved PTM mutex initialization from igc_reset() to igc_ptp_init()
	   called once in igc_probe()
v2 -> v3: -Added mutex_destroy() to clean up PTM lock
	  -Added missing checks for PTP enabled flag called from igc_main.c
	  -Cleanup PTP module if probe fails
	  -Wrap all access to PTM registers with PTM lock/unlock

Christopher S M Hall (6):
  igc: Ensure the PTM cycle is reliably triggered
  igc: Lengthen the hardware retry time to prevent timeouts
  igc: Move ktime snapshot into PTM retry loop
  igc: Handle the IGC_PTP_ENABLED flag correctly
  igc: Cleanup PTP module if probe fails
  igc: Add lock preventing multiple simultaneous PTM transactions

 drivers/net/ethernet/intel/igc/igc.h         |   1 +
 drivers/net/ethernet/intel/igc/igc_defines.h |   3 +-
 drivers/net/ethernet/intel/igc/igc_main.c    |   1 +
 drivers/net/ethernet/intel/igc/igc_ptp.c     | 113 ++++++++++++-------
 4 files changed, 78 insertions(+), 40 deletions(-)

-- 
2.34.1


