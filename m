Return-Path: <netdev+bounces-133357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0CD995BB7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4DEC1F220A4
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5418C335;
	Tue,  8 Oct 2024 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LCc3Zz30"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4913C9DE
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430488; cv=none; b=UqleEZT5hkFpghGlGxVc9xkrDPo92t8nLdjbOnpCXx9IB1UnoPMySafuou5cFNfM7W6twJjhT0eXlfJ6jZPvr2poMiYqVrQQueEnwxJOUAfROv5c5/P2SDWFCMGnHikszxS1f4BKIcEDD4HbDwp3t9gAmW2jNTT7hIWp6Dhc6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430488; c=relaxed/simple;
	bh=Dq86mjf9ut9DZCn7BwtpcLDXQCGPiYD2m2015sshmWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFH9hMysRIhZSatFxpwmQJ0Le6kwTkq1DC8fDe25HzExVPTwYQUADw/KUIcJTNggmscmXHq8Ga+Z0QGKB17f011AnnIrzAZh8R/AoJnZLJh7F3vWWLcYiQLHC0Elib+ZaPgOqtZcVOB9/HztQAriGQOLneQ2pWSGO4hw8bm7v50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LCc3Zz30; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430487; x=1759966487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Dq86mjf9ut9DZCn7BwtpcLDXQCGPiYD2m2015sshmWA=;
  b=LCc3Zz30sTQq9DB37q/0k+Axv3sfq26APb/KOBa+5uw99yRycONzkuiR
   qPKtbMMrFWe5vQIxkZz0mTamzpn+E+KkVNRrv7lQtIbFaFwr3V28atzzB
   ziPp9UKHD8p24k/dWO/9xN9co2U7pM7ApXzC6XCuYhUTZY4EQQWTt0l3f
   NXWIs7gOvcnCPi+IF7m4UBLAN628PmGSoOIhpS8OuzLyuIMzFnOWwOsTT
   AnycpbhUqhEJcI/mJWt886t+Je+8LBPz9VXhtj2FpjIe4PdewHrYz0oi1
   rhWxdnf7lsZk5yuDNnRouyorc9MvvyEEvhGkx0Jxn3ZrogVoEwEw+1KOk
   w==;
X-CSE-ConnectionGUID: SFCi6NZRR0+sT83xL3TzCQ==
X-CSE-MsgGUID: wHKSapxeTM+/nlSmfTeHAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779853"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779853"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:46 -0700
X-CSE-ConnectionGUID: JhXzHq7YTD2O/5U0C4PtAw==
X-CSE-MsgGUID: bX4Mg5oOSbe7hVXKHWFstw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794173"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/12][pull request] Intel Wired LAN Driver Updates 2024-10-08 (ice, iavf, igb, e1000e, e1000)
Date: Tue,  8 Oct 2024 16:34:26 -0700
Message-ID: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice, iavf, igb, e1000e, and e1000
drivers.

For ice:

Wojciech adds support for ethtool reset.

Paul adds support for hardware based VF mailbox limits for E830 devices.

Jake adjusts to a common iterator in ice_vc_cfg_qs_msg() and moves
storing of max_frame and rx_buf_len from VSI struct to the ring
structure.

Hongbo Li uses assign_bit() to replace an open-coded instance.

Markus Elfring adjusts a couple of PTP error paths to use a common,
shared exit point.

Yue Haibing removes unused declarations.

For iavf:

Yue Haibing removes unused declarations.

For igb:

Yue Haibing removes unused declarations.

For e1000e:

Takamitsu Iwai removes unneccessary writel() calls.

Joe Damato adds support for netdev-genl support to query IRQ, NAPI,
and queue information.

For e1000:

Joe Damato adds support for netdev-genl support to query IRQ, NAPI,
and queue information.

The following are changes since commit 42b2331081178785d50d116c85ca40d728b48291:
  tools: ynl-gen: refactor check validation for TypeBinary
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Hongbo Li (1):
  ice: Make use of assign_bit() API

Jacob Keller (2):
  ice: consistently use q_idx in ice_vc_cfg_qs_msg()
  ice: store max_frame and rx_buf_len only in ice_rx_ring

Joe Damato (2):
  e1000e: Link NAPI instances to queues and IRQs
  e1000: Link NAPI instances to queues and IRQs

Markus Elfring (1):
  ice: Use common error handling code in two functions

Paul Greenwalt (1):
  ice: add E830 HW VF mailbox message limit support

Takamitsu Iwai (1):
  e1000e: Remove duplicated writel() in e1000_configure_tx/rx()

Wojciech Drewek (1):
  ice: Implement ethtool reset support

Yue Haibing (3):
  ice: Cleanup unused declarations
  iavf: Remove unused declarations
  igb: Cleanup unused declarations

 .../device_drivers/ethernet/intel/ice.rst     | 31 ++++++++
 drivers/net/ethernet/intel/e1000/e1000_main.c |  5 ++
 drivers/net/ethernet/intel/e1000e/netdev.c    | 17 ++--
 drivers/net/ethernet/intel/iavf/iavf.h        | 10 ---
 .../net/ethernet/intel/iavf/iavf_prototype.h  |  3 -
 drivers/net/ethernet/intel/ice/ice.h          |  4 +-
 drivers/net/ethernet/intel/ice/ice_base.c     | 34 ++++----
 drivers/net/ethernet/intel/ice/ice_eswitch.h  |  5 --
 drivers/net/ethernet/intel/ice/ice_ethtool.c  | 77 +++++++++++++++++++
 .../net/ethernet/intel/ice/ice_flex_pipe.h    |  3 -
 .../net/ethernet/intel/ice/ice_hw_autogen.h   |  3 +
 drivers/net/ethernet/intel/ice/ice_lib.c      |  3 +
 drivers/net/ethernet/intel/ice/ice_lib.h      |  2 -
 drivers/net/ethernet/intel/ice/ice_main.c     | 27 +++++--
 drivers/net/ethernet/intel/ice/ice_ptp.c      | 32 ++++----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  3 -
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  3 +-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  3 +-
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  1 -
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 26 ++++++-
 drivers/net/ethernet/intel/ice/ice_vf_mbx.c   | 32 ++++++++
 drivers/net/ethernet/intel/ice/ice_vf_mbx.h   |  9 +++
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 34 ++++----
 drivers/net/ethernet/intel/igb/e1000_mac.h    |  1 -
 drivers/net/ethernet/intel/igb/e1000_nvm.h    |  1 -
 25 files changed, 269 insertions(+), 100 deletions(-)

-- 
2.42.0


