Return-Path: <netdev+bounces-213863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C48B272C1
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D667AE216
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD1287518;
	Thu, 14 Aug 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8QhMgou"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57F8287274
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212946; cv=none; b=U+cRMTbxPuMv6FvBlZYKDI7xtRq3noqfQkhHc8F+V1dQYQypzEzMzhPx+awjkeV0UqyJqgGAinIxHP2ozZ0r5jYc6ccDU+bWlejDjRxyn4gcxuyrYckzAfinLI+mN2yQOUaeNaNhVfvI/Raes9kxSRMsRKRpMcUPZCzIZsLZv4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212946; c=relaxed/simple;
	bh=Z5VXzjISeoYBHcp9kdtmQw01ufQngPQ/bo1XVLAPd+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UuuYgLTgc/w2Oo0Yg/5NZ5Srt9bnyHE6o2PutEMU1rMyeYdqOBD56gjRGvTtKd6DCuDq+z+IsJev29uU9sXJD7cBYxTjOfVn8fxTFLonELxuSVg4IV3FUVKMmCUwiHL14roaktFOB32NaayBbMeJzcb/k+ZaikLlgd6/3Dv1cu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8QhMgou; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212945; x=1786748945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z5VXzjISeoYBHcp9kdtmQw01ufQngPQ/bo1XVLAPd+8=;
  b=X8QhMgouU4gIE/mAMzW/67ETK80CL46SfjjlQYx9+6qGX9sBz53AsNN/
   OYmjO6jTc9KCR6RGDiOMH20e3RP1Q/lhuEc4NnL+1ofT5tp4pcPaWu5kt
   W5ZTZcPEx+ckgvk501CtjkPgy/FPAI/1XCXcCMTULErUQAX4dLYhlhV2h
   8d2h6e6kf48R295THdpzdvPIkosx+ePeUWodLm9VcDDemsOmA8AHVD2al
   wMtLgh9pQbfhDmjLFq3586AwIxh1Zm9PLlxpa6EMj8+iB92Z/7M2/ZBw+
   +cs46tvEiPNYaOMogXKXON2aZQFUa4gVm8wG4sIAToWQYcVFTq8ZZtzRP
   g==;
X-CSE-ConnectionGUID: Tp/hGR6+Q5mQRDAUUNvlLg==
X-CSE-MsgGUID: Fo8bD/rQTtWfpucE10Nj6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45117955"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45117955"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:04 -0700
X-CSE-ConnectionGUID: dm+qijUYQnOk9dGmwg14RA==
X-CSE-MsgGUID: YPoAoOsiQyy1fX3WdF9KSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166848122"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 16:09:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	david.m.ertman@intel.com
Subject: [PATCH net-next 0/7][pull request] ice: implement SRIOV VF Active-Active LAG
Date: Thu, 14 Aug 2025 16:08:47 -0700
Message-ID: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dave Ertman says:

Implement support for SRIOV VFs over an Active-Active link aggregate.
The same restrictions apply as are in place for the support of
Active-Backup bonds.

- the two interfaces must be on the same NIC
- the FW LLDP engine needs to be disabled
- the DDP package that supports VF LAG must be loaded on device
- the two interfaces must have the same QoS config
- only the first interface added to the bond will have VF support
- the interface with VFs must be in switchdev mode

With the additional requirement of
- the version of the FW on the NIC needs to have VF Active/Active support

The balancing of traffic between the two interfaces is done on a queue
basis. Taking the queues allocated to all of the VFs as a whole, one
half of them will be distributed to each interface. When a link goes
down, then the queues allocated to the down interface will migrate to
the active port. When the down port comes back up, then the same
queues as were originally assigned there will be moved back.

Patch 1 cleans up void pointer casts
Patch 2 utilizes bool over u8 when appropriate
Patch 3 adds a driver prefix to a LAG define
Patch 4 pre-move a function to reduce delta in implementation patch
Patch 5 cleanup variable initialization in declaration block
Patch 6 cleanup capability parsing for LAG feature
Patch 7 is the implementation of the new functionality
---
IWL: https://lore.kernel.org/intel-wired-lan/20250616110323.788970-1-david.m.ertman@intel.com/

The following are changes since commit 875c541ea680d0df2de3e666d8125bee08c1bc1b:
  Merge branch 'net-ethtool-support-including-flow-label-in-the-flow-hash-for-rss'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Dave Ertman (7):
  ice: Remove casts on void pointers in LAG code
  ice: replace u8 elements with bool where appropriate
  ice: Add driver specific prefix to LAG defines
  ice: move LAG function in code to prepare for Active-Active
  ice: Cleanup variable initialization in LAG code
  ice: cleanup capabilities evaluation
  ice: Implement support for SRIOV VFs across Active/Active bonds

 drivers/net/ethernet/intel/ice/ice.h          |   1 +
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   4 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  19 +-
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      | 975 ++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_lag.h      |  21 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   6 +-
 include/linux/net/intel/libie/adminq.h        |   5 +-
 8 files changed, 807 insertions(+), 226 deletions(-)

-- 
2.47.1


