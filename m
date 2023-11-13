Return-Path: <netdev+bounces-47502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC407EA6B6
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 00:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CEDDB20A82
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE823C6BB;
	Mon, 13 Nov 2023 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKUXX4sv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F50E2E41A
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 23:10:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3111899
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 15:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699917053; x=1731453053;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZbWWEd2vLVjyAzDPGj6sqcTGxMa/7xXLaJg3Tc6yfgo=;
  b=GKUXX4svA7kQNudCkg0kOEAZLhSDebm8WUBswMUaVg0P88FXprxkQvDZ
   jo24q9ASOz+a0Da2MXe9aOTP2FOIytAB1hJidD3fYm62C7sKG6LWDPNVV
   Af8+wB0SWDd7TNBPpiQeeAhEVAfVZWXnAYczJiebke3NLdZ9IG1JKY+pD
   9BK6Nrdv2kaVMrwFhVuN9oBA0vumnH67/Vs3aHblM7UfCr/dkc6I2uiNu
   Lt3L1sUltq8ivKzOzR2e5tEWbc4D5QMQXIZxORLBFsZNlB6ydOphKiBaa
   rHTWlwi8UpsPapHfQYPapj35dL3fFhtXuYBzVNi98E9vcd99mSC1qJaix
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375562588"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375562588"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 15:10:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="888051390"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="888051390"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2023 15:10:52 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 00/15][pull request] Intel Wired LAN Driver Updates 2023-11-13 (i40e)
Date: Mon, 13 Nov 2023 15:10:19 -0800
Message-ID: <20231113231047.548659-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to i40e driver only.

Justin Bronder increases number of allowable descriptors for XL710
devices.

Su Hui adds error check, and unroll, for RSS configuration.

Andrii changes module read error message to debug and makes it more
verbose.

Ivan Vecera performs numerous clean-ups and refactors to driver such as
removing unused defines and fields, converting use of flags to bitmaps,
adding helpers, re-organizing code, etc.

The following are changes since commit 89cdf9d556016a54ff6ddd62324aa5ec790c05cc:
  Merge tag 'net-6.7-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 40GbE

Andrii Staikov (1):
  i40e: Change user notification of non-SFP module in
    i40e_get_module_info()

Ivan Vecera (12):
  i40e: Remove unused flags
  i40e: Remove _t suffix from enum type names
  i40e: Use DECLARE_BITMAP for flags and hw_features fields in i40e_pf
  i40e: Use DECLARE_BITMAP for flags field in i40e_hw
  i40e: Consolidate hardware capabilities
  i40e: Initialize hardware capabilities at single place
  i40e: Move i40e_is_aq_api_ver_ge helper
  i40e: Add other helpers to check version of running firmware and AQ
    API
  i40e: Use helpers to check running FW and AQ API versions
  i40e: Remove VF MAC types
  i40e: Move inline helpers to i40e_prototype.h
  i40e: Delete unused i40e_mac_info fields

Justin Bronder (1):
  i40e: increase max descriptors for XL710

Su Hui (1):
  i40e: add an error code check in i40e_vsi_setup

 drivers/net/ethernet/intel/i40e/i40e.h        | 148 ++---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c | 163 +++--
 drivers/net/ethernet/intel/i40e/i40e_common.c |  68 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb.c    |   9 +-
 drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c |  29 +-
 drivers/net/ethernet/intel/i40e/i40e_debug.h  |   1 +
 .../net/ethernet/intel/i40e/i40e_debugfs.c    |   7 +-
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 246 +++----
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 620 +++++++++---------
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    |  10 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  70 ++
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |  32 +-
 .../net/ethernet/intel/i40e/i40e_register.h   |   1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  20 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   8 +-
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  51 +-
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  20 +-
 17 files changed, 764 insertions(+), 739 deletions(-)

-- 
2.41.0


