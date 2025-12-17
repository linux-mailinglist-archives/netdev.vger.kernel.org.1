Return-Path: <netdev+bounces-245234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9FECC9706
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C8E0303BFEA
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BDF2F12B7;
	Wed, 17 Dec 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M1EfTy72"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177A2C11D5
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001003; cv=none; b=N1dgU92Xi5aaLgVnUG2U1gGOGvbkbBD/RdqxQ/Ksq9lLFI2iUt5AjwZtmlxdv2oKkPWTi1OmXbo2ObNGcoBc2iNk/jamPMLwE/n2m9D0mEG6skb7es9ZakPWvtUhUV0UoEuNVfU8etRU753CiZQZH1ZB2YK5L0CrSzCOFOrcF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001003; c=relaxed/simple;
	bh=b/diij7fFHRduhhCcO6xE9ZXMTBOUK6UJMsGt+Adb8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/+y6nlnHWO9vTlbu1v+miss+4eZKBUVc4Y3+4DhlJElLcj/kNEN381ME3modyJhvHsD1KiXaNVrh0prdq+Q6VYeSJrs8NN9WQBy0A+4Zso1HkL7dkprpZ1fqImHpki7JGkSL5fvO7Eym8YS2a+3z0soQKZQ6tCuiWju5N0dGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M1EfTy72; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766001002; x=1797537002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b/diij7fFHRduhhCcO6xE9ZXMTBOUK6UJMsGt+Adb8Y=;
  b=M1EfTy72uQWIKC4XZ0Tj2XqAfo3ry2qiBztavgPaGpJROjwv5R+v1hzd
   AAhWAOtpUtbXnZyi0BFCt4BE+pmz5JkxpJKunWYByHUYH6pOXJkTQRyH9
   jAWLxvgCHeQ213FqADeixmZqsXsqo2lCfRLM7e4Z8j3zdQ7lRAl2UrACZ
   iP0nDOgEDI0+WGtxmvcMZMwDyCdvZda4CAf7EX3tckgPZqjoJdaBflYAf
   MTDVUhrJW3MBkyfcZrQH+Q2pKtycYYZWLUC+kCjh2KRO4P4Z6ssHHzfCI
   5+eX5YBF4lqyNJpBE/4eoLLhJ86S6I04Gvbr/TH7EBpMYygKpUf2GaZSS
   A==;
X-CSE-ConnectionGUID: zBefZckzT76BqjkdnB9neA==
X-CSE-MsgGUID: ERuieYXCS868Q5lfqZ9wNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67841415"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67841415"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 11:50:01 -0800
X-CSE-ConnectionGUID: IsA+zVBISXG+sSkmy7MfEg==
X-CSE-MsgGUID: qej571LWTyasUZk6VRNDAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202898033"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 17 Dec 2025 11:50:01 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/6][pull request] Intel Wired LAN Driver Updates 2025-12-17 (i40e, iavf, idpf, e1000)
Date: Wed, 17 Dec 2025 11:49:39 -0800
Message-ID: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For i40e:
Przemyslaw immediately schedules service task following changes to
filters to ensure timely setup for PTP.

Gregory Herrero adjusts VF descriptor size checks to be device specific.

For iavf:
Kohei Enju corrects a couple of condition checks which caused off-by-one
issues.

For idpf:
Larysa fixes LAN memory region call to follow expected requirements.

Brian Vazquez reduces mailbox wait time during init to avoid lengthy
delays.

For e1000:
Guangshuo Li adds validation of data length to prevent out-of-bounds
access.

The following are changes since commit 885bebac9909994050bbbeed0829c727e42bd1b7:
  nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Brian Vazquez (1):
  idpf: reduce mbx_task schedule delay to 300us

Gregory Herrero (1):
  i40e: validate ring_len parameter against hardware-specific values

Guangshuo Li (1):
  e1000: fix OOB in e1000_tbi_should_accept()

Kohei Enju (1):
  iavf: fix off-by-one issues in iavf_config_rss_reg()

Larysa Zaremba (1):
  idpf: fix LAN memory regions command on some NVMs

Przemyslaw Korba (1):
  i40e: fix scheduling in set_rx_mode

 drivers/net/ethernet/intel/e1000/e1000_main.c      | 10 +++++++++-
 drivers/net/ethernet/intel/i40e/i40e.h             | 11 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 12 ------------
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 ++--
 drivers/net/ethernet/intel/iavf/iavf_main.c        |  4 ++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c         |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c    |  5 +++++
 8 files changed, 31 insertions(+), 18 deletions(-)

-- 
2.47.1


