Return-Path: <netdev+bounces-61038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8B38224AE
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 23:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0487B216C3
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 22:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06AA3171BB;
	Tue,  2 Jan 2024 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9kHWY50"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0925A171BF
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704234278; x=1735770278;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jqBMoWCPGXlySX7dDUPNhC2e+bX+y6kBQwjld4zNoc4=;
  b=F9kHWY50l8HWEEGZw2aUlueHaBc5S2uTswl2jiXPPJ4VIifVam7J5/gh
   uejPv0iLXGpWalWD0z7n/zQAV/qnwdYl3ps5INWXGWKCoLpJWWZyoOWL0
   HJZ60dB3VgyJUiVZpR0L7NTMmQVw9yLEg06CJzoxaIbuE0Olj8eHHdZru
   Jy8Jh4a/sPs33I0dBRLatBvwYG4ATmBHAvNi/yakAIyTfGzyv38LNmm4K
   gGMvZDcJKkxU8gIEJjj8fF2K96hRDNGaLbxjTryyPein6LWkhy10Sktec
   FJ+W1F+Of+Hts7S0+qxR7o3t1KZjKUgTfytPFMDqhFPisSjFtuWQ0Jkop
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="3700398"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="3700398"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 14:24:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="772965449"
X-IronPort-AV: E=Sophos;i="6.04,326,1695711600"; 
   d="scan'208";a="772965449"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2024 14:24:37 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates 2024-01-02 (ixgbe, i40e)
Date: Tue,  2 Jan 2024 14:24:18 -0800
Message-ID: <20240102222429.699129-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ixgbe and i40e drivers.

Ovidiu Panait adds reporting of VF link state to ixgbe.

Jedrzej removes uses of IXGBE_ERR* codes to instead use standard error
codes.

Andrii modifies behavior of VF disable to properly shut down queues on
i40e.

Simon Horman removes, undesired, use of comma operator for i40e.

The following are changes since commit 954fb2d2d49f46e1d9861c45731e26bdeb081695:
  Merge branch 'remove-retired-tc-uapi'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 10GbE

Andrii Staikov (1):
  i40e: Fix VF disable behavior to block all traffic

Jedrzej Jagielski (2):
  ixgbe: Refactor overtemp event handling
  ixgbe: Refactor returning internal error codes

Ovidiu Panait (1):
  ixgbe: report link state for VF devices

Simon Horman (1):
  i40e: Avoid unnecessary use of comma operator

 .../net/ethernet/intel/i40e/i40e_ethtool.c    |   2 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  32 ++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |   1 +
 .../net/ethernet/intel/ixgbe/ixgbe_82598.c    |  36 ++---
 .../net/ethernet/intel/ixgbe/ixgbe_82599.c    |  61 ++++----
 .../net/ethernet/intel/ixgbe/ixgbe_common.c   | 145 ++++++++---------
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  42 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c  |  34 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h  |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 105 +++++++------
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h  |   2 +-
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    |   3 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  43 +----
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c |  44 +++---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 148 +++++++++---------
 16 files changed, 342 insertions(+), 359 deletions(-)

-- 
2.41.0


