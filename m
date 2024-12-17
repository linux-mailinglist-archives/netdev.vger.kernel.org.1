Return-Path: <netdev+bounces-152737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA69F59E4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 23:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4130A1893C1B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 22:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986ED1E008E;
	Tue, 17 Dec 2024 22:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBXSMxco"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A37914B08E
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734476244; cv=none; b=s9xq/hsny/RslQJFRFBBczfRpQkoIkAOpe5WQrcDVtVfhNRLWgmDkj2qykStUODlFPPRRlxeqENawSLv5fDKoWS27m83UT1JPJySUJAz76Hn3w0JumtygFzv5k4Ue9JKZB9QBuVGvr64FRK8vDE53I6wm9jp/eEUs0/njrxNbG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734476244; c=relaxed/simple;
	bh=cUkrZCteRJtKMunPUE6QIP5CXcGVksBzwabo2cc1e5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2pKKd8PW8t7D3unC0qq+Luf0xPVERPL/apHuT3GifWP/LDzNwd48lkAwkH7qbL0tTYBboNM8EttNE7oYWXURJB9sJVqgJz5CCJ1fumuUTtlOUi81TWVtIQMDPVddjD7q53mEJKqpT9fSDtMOkxG1c0lPQ0YJGbQriZCVZYQ69Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBXSMxco; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734476243; x=1766012243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cUkrZCteRJtKMunPUE6QIP5CXcGVksBzwabo2cc1e5k=;
  b=aBXSMxcoVpRadIqI608wq2jNcWwz7l5GUaKA3t3fuZ2eoZlh70riaHT/
   d8C3eG5YchoJgcf5CPvs3N5QOgGq/71BvqtHIX0X6id1uqFnfUCrbZO+4
   gt1o9+aeYoYu1e2z92LIa/Op6tzrCzOIn1+ZN9YhD5mnH2JwFVDSryzJt
   zaOG48P8twlKYtNcSI6DY9sKIp1SgIBnCru/5Pgv3yRXpS65e14P/3J/f
   pJkDS9oO9IqhO3REAI/UvGBmwSR30Y+P7k2wBWnIH06bA+TyxHlbR1MRi
   ALga2sRQ5DoF/mm0yME0LowWunNuaDChiAKX/hu0THKsTfb2syw57ucNX
   g==;
X-CSE-ConnectionGUID: C1IGU1/tQh25fkvlgNycXg==
X-CSE-MsgGUID: x09XrtonRN6y1Ev6O5E4qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="35071991"
X-IronPort-AV: E=Sophos;i="6.12,243,1728975600"; 
   d="scan'208";a="35071991"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 14:57:23 -0800
X-CSE-ConnectionGUID: XXdpiHrFSvS/oNR1fRgwLA==
X-CSE-MsgGUID: yxTzH7seRXyAyNx01I97wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120916644"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 17 Dec 2024 14:57:22 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	joshua.a.hay@intel.com,
	przemyslaw.kitszel@intel.com,
	michal.kubiak@intel.com,
	madhu.chittim@intel.com
Subject: [PATCH net 0/2][pull request] idpf: trigger SW interrupt when exiting wb_on_itr mode
Date: Tue, 17 Dec 2024 14:57:11 -0800
Message-ID: <20241217225715.4005644-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Joshua Hay says:

This patch series introduces SW triggered interrupt support for idpf,
then uses said interrupt to fix a race condition between completion
writebacks and re-enabling interrupts.
---
IWL: https://lore.kernel.org/intel-wired-lan/20241125235855.64850-1-joshua.a.hay@intel.com/

The following are changes since commit 7ed2d91588779f0a2b27fd502ce2aaf1fab9b3ca:
  qed: fix possible uninit pointer read in qed_mcp_nvm_info_populate()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Joshua Hay (2):
  idpf: add support for SW triggered interrupts
  idpf: trigger SW interrupt when exiting wb_on_itr mode

 drivers/net/ethernet/intel/idpf/idpf_dev.c    |  3 ++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 29 ++++++++++++-------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ++++-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |  3 ++
 4 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.47.1


