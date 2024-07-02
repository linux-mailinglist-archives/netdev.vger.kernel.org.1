Return-Path: <netdev+bounces-108561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921989244CC
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42E31C220FD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB41BE23D;
	Tue,  2 Jul 2024 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hlg7TB+R"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4951BE23F
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940505; cv=none; b=N1OELvYkQW05hHGhsNAQB3DGJ804V3OOcVQZH2u1WaWTrYgnMaTRdWljgsUt5WSKfhQsfAbBsWb/DLVv9W7LYYyaNgkBSXspXUdbrp28s8VNzKGVG+fcodwVUy0tyAs2ZLFRSHbdztyI7XNfw/lYXymGuAK0TRMt8InrpY4oTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940505; c=relaxed/simple;
	bh=CeDD/JxDUkpo2b0Ild3Y4E7FhF2isxz0ugRSvmWb0cY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G2kHTY2UkU9//TjwwNrf0jJXPG8MNBksxEDnRvypxE3bf+/ChZgHQR+yHn7hNzsR7m90KPLnWBroeqM2NEP2G32hLLW0cX/FpYHVPFVWP1IEY28rqoxhURIyO7U6I+xsNrnYmyTwkATUXSkGQ8vWx3YG0gD1E96TpcSLFwTiB6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hlg7TB+R; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719940503; x=1751476503;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CeDD/JxDUkpo2b0Ild3Y4E7FhF2isxz0ugRSvmWb0cY=;
  b=Hlg7TB+RYGA8L4feZeOaXT2K5Ffk/ZnOEQbz6q3mYq4UZKN/2s1GY3Mi
   JlNplFHDDO1/n8ObvfBT/v9imv89YnQpY3GkxWdU3KC5rQn93pvDYTwSN
   v+aSB68iqrVDexTLga8QNOaWKPwZMaGX1a4MLKMILEXJzB7Yi3iLaMhuo
   wE3Pxw0ubsDPdhjzSd3XODjQobQPCe/zqaMcHxlADqZ7S0Liy8qjQVd2U
   5edqo5HDTWoPx1TjEYyADHKIgSOo1/cIo1/LYO+Key7FSncxgaRGMRhtU
   G8kQ39WTp0mrTsrAaINsjd6wQs1UnMjYdVwhZw28hiX4l/ooIcADREW7R
   Q==;
X-CSE-ConnectionGUID: V19EK1s5RDiGdvb7lCnqOA==
X-CSE-MsgGUID: AcU6XDDuRNuvz1PLhmeoLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="20032321"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="20032321"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 10:15:02 -0700
X-CSE-ConnectionGUID: ccnUqDgLRXSbjFirFJSTEw==
X-CSE-MsgGUID: UBNoSJ1OT4ysbkoaXeSEEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="76708746"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 02 Jul 2024 10:15:02 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net v2 0/4][pull request] Intel Wired LAN Driver Updates 2024-06-25 (ice)
Date: Tue,  2 Jul 2024 10:14:53 -0700
Message-ID: <20240702171459.2606611-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Milena adds disabling of extts events when PTP is disabled.

Jake prevents possible NULL pointer by checking that timestamps are
ready before processing extts events and adds checks for unsupported
PTP pin configuration.

Petr Oros replaces _test_bit() with the correct test_bit() macro.
---
v2:
- Adjusted formatting in "ice: Fix improper extts handling" and
  reworded commit message

v1: https://lore.kernel.org/netdev/20240625170248.199162-1-anthony.l.nguyen@intel.com/

The following are changes since commit 8905a2c7d39b921b8a62bcf80da0f8c45ec0e764:
  Merge branch 'net-txgbe-fix-msi-and-intx-interrupts'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jacob Keller (2):
  ice: Don't process extts if PTP is disabled
  ice: Reject pin requests with unsupported flags

Milena Olech (1):
  ice: Fix improper extts handling

Petr Oros (1):
  ice: use proper macro for testing bit

 drivers/net/ethernet/intel/ice/ice_hwmon.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c   | 131 ++++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_ptp.h   |   9 ++
 3 files changed, 111 insertions(+), 31 deletions(-)

-- 
2.41.0


