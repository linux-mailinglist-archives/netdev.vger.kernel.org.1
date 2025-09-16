Return-Path: <netdev+bounces-223724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C94AB5A3E7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 23:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 123C47A33A7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 21:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0CE287515;
	Tue, 16 Sep 2025 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RuLou+N4"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98163238178
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758058093; cv=none; b=L5YYb0lMcHn8Q+B19VSXSnwkXDqJVarOOM4X+53hK76LdlCTXTdwACob4bhnnRNB6eo7bAnvqFUKACaLjsBNgG+bcJcMy5mtTZIBYVpKiH3bCQ2cOZuSPBQvf8cE9T/ZmCYbtl/wZ4LkXo9duztJINai4Vfb2BwhLnnTspqqZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758058093; c=relaxed/simple;
	bh=IAqvf7ofR55M7pfMQLE3mbtDg3qG8eJCvrOxWoeh/c4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9x/D2s6FhCkENqAL4VhzEATbQhdGw4/ogJtlXOwYcZbFMKgD2k8/v24pMTNkCOQXWZaCKX9ImLS8rWv9PVvmHsFpYNC0//7Db2M1gWWQCUJerMFwTOwCsEV+jIManvqX3g0IxRFniCW6d7QKlH52mLUp51Eensx5Qc3jevqbqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RuLou+N4; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758058092; x=1789594092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IAqvf7ofR55M7pfMQLE3mbtDg3qG8eJCvrOxWoeh/c4=;
  b=RuLou+N4YY+gWHulti71vSYbpEymOQe9zYk2Tgy41JFMNxoE/aPDosV1
   kpRPrSdDUWZVr7Lx1jaUXzb+mQq6MYaDWrNHZS8jUw10vcuzzulpbqI13
   PKwuYzn3+h0tjYduoz4ECx26X90gKngFMk4zgKOaABT8fHYoyBaqenmJ2
   +XNq1obiTfPSIEEHmXrYEFp4W3zwN078UbDyUa4bdU/kiuCGqSTfLjus1
   r0Hu3gACh2YLBuPHWdhyOjAX2OA2hrbXTwbyCaW2jOsX6ap33XPV7wqvP
   uEC2lxmWOrlfspI+3vB14MNBHS4XT4L/c4Vog6nc8i6RDbYITupF2SV8/
   w==;
X-CSE-ConnectionGUID: ZeUZtc2vSAGn1jasVJBNDw==
X-CSE-MsgGUID: Uer8PMU+QGqcUF7k4kbsdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60410743"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="60410743"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:28:11 -0700
X-CSE-ConnectionGUID: udis9gvWQnmqkD6hotytoQ==
X-CSE-MsgGUID: eceC67vmSX6N5QM2jTXBxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,270,1751266800"; 
   d="scan'208";a="180316925"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 16 Sep 2025 14:28:10 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2025-09-16 (ice, i40e, ixgbe, igc)
Date: Tue, 16 Sep 2025 14:27:55 -0700
Message-ID: <20250916212801.2818440-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Jake resolves leaking pages with multi-buffer frames when a 0-sized
descriptor is encountered.

For i40e:
Maciej removes a redundant, and incorrect, memory barrier.

For ixgbe:
Jedrzej adjusts lifespan of ACI lock to ensure uses are while it is
valid.

For igc:
Kohei Enju does not fail probe on LED setup failure which resolves a
kernel panic in the cleanup path, if we were to fail.

The following are changes since commit 93ab4881a4e2b9657bdce4b8940073bfb4ed5eab:
  net: natsemi: fix `rx_dropped` double accounting on `netif_rx()` failure
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jacob Keller (1):
  ice: fix Rx page leak on multi-buffer frames

Jedrzej Jagielski (2):
  ixgbe: initialize aci.lock before it's used
  ixgbe: destroy aci.lock later within ixgbe_remove path

Kohei Enju (1):
  igc: don't fail igc_probe() on LED setup error

Maciej Fijalkowski (1):
  i40e: remove redundant memory barrier when cleaning Tx descs

 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  3 -
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 80 ++++++++-----------
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 -
 drivers/net/ethernet/intel/igc/igc.h          |  1 +
 drivers/net/ethernet/intel/igc/igc_main.c     | 12 ++-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 22 ++---
 6 files changed, 56 insertions(+), 63 deletions(-)

-- 
2.47.1


