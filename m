Return-Path: <netdev+bounces-173606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E3FA59FF5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4A81717F3
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3097233707;
	Mon, 10 Mar 2025 17:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLjtEDsR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC91C3F34
	for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628708; cv=none; b=rxwYyheODT/idgmb7oVFh3NzH/5jjj3av73974ZouTAP6/eHs2+SkpWGJ/CKyFZw1S0XBd4efX6c3UiM/pQdvW15pow2Xw/jw7SmiFhoI9W2ZHmu3+L+C9eEb8dRDHm6MxMRxWJSXobdhcRMmieFawvjC+8X8HrSC6/7C3Tdgfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628708; c=relaxed/simple;
	bh=2za/68UvUhFl8boaQMl1lzPdw3iWqcz4QRwb0TRq1rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=noVOkdQYWBqPlb/ywCSiv7rMYno6fq92fBkuaMzreRDZI2vNXUQ5mBnwKQ0RFOI+KNULpgssQ4gSjHwoaN/J637u88fEf7nHbPrQ9cEwKhMI6rLkTgtGQUuQBcvHySd+EXUegYcS4i98TvhPqJgYKw7Gc5NBh8teX0oWz4F6kTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SLjtEDsR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741628707; x=1773164707;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2za/68UvUhFl8boaQMl1lzPdw3iWqcz4QRwb0TRq1rQ=;
  b=SLjtEDsRLRGYRNXlujEWWU5CLD6Yvr5+yGmzmB6jhf0qcCbzwog2Enhv
   lhZu88uUnPmoxFoAV+a5xppNu9mQeY8CuS50r53WlpC4uPIxw3lzTjhOo
   xdUQwea6T0lSK+tsZKUvp3vG8xXiPtt9cVdMsfiY10EUbo7FSEtZBPC2Z
   DCDuUlgxLgrcS2dhlZi7Zt1MjCKxmUuIUxxmFFy21qX8SEFWWi0w3x2Sk
   XoQDZ4u92bJwZQi1nZZi8uwUcltbkhnx/I3RB8yDl9nmrEuK3X1sJc0nb
   bRwcYlEA7bK91K7ISwAYNZglC6Zv0TrhP6S+SnV7Gg5PwpVXlHfMEUz7p
   w==;
X-CSE-ConnectionGUID: hu3sgwtwTzO08T4VfDOQkw==
X-CSE-MsgGUID: Y99GiEG2TmaVuIfkSfVU0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="46548975"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="46548975"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:45:06 -0700
X-CSE-ConnectionGUID: gIEevCNNQD+fH/Pu6VzKHg==
X-CSE-MsgGUID: qYnv2QqhRoqyVxxwlm0sLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120950778"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Mar 2025 10:45:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/6][pull request] Intel Wired LAN Driver Updates 2025-03-10 (ice, ixgbe)
Date: Mon, 10 Mar 2025 10:44:53 -0700
Message-ID: <20250310174502.3708121-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:

Paul adds generic checksum support for E830 devices.

Karol refactors PTP code related to E825C; simplifying PHY register info
struct, utilizing GENMASK, removing unused defines, etc.

For ixgbe:

Piotr adds PTP support for E610 devices.

Jedrzej adds reporting when overheating is detected on E610 devices.

The following are changes since commit 8ef890df4031121a94407c84659125cbccd3fdbe:
  net: move misc netdev_lock flavors to a separate header
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Jedrzej Jagielski (1):
  ixgbe: add support for thermal sensor event reception

Karol Kolacinski (3):
  ice: rename ice_ptp_init_phc_eth56g function
  ice: Refactor E825C PHY registers info struct
  ice: E825C PHY register cleanup

Paul Greenwalt (1):
  ice: Add E830 checksum offload support

Piotr Kwapulinski (1):
  ixgbe: add PTP support for E610 device

 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    |  9 ++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |  8 +-
 drivers/net/ethernet/intel/ice/ice_main.c     | 18 +++++
 .../net/ethernet/intel/ice/ice_ptp_consts.h   | 75 ++++---------------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 19 +++--
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   | 35 ++++-----
 drivers/net/ethernet/intel/ice/ice_txrx.c     | 27 ++++++-
 drivers/net/ethernet/intel/ice/ice_txrx.h     |  2 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 26 +++++++
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c  | 13 +++-
 .../ethernet/intel/ixgbe/ixgbe_type_e610.h    |  3 +
 14 files changed, 146 insertions(+), 95 deletions(-)

-- 
2.47.1


