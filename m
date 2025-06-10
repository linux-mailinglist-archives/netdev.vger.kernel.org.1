Return-Path: <netdev+bounces-196238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A3AD4023
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 19:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0653417941B
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4919E242D83;
	Tue, 10 Jun 2025 17:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fGW3vK0C"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8840B243379
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575636; cv=none; b=ldWqATJmrnJj1Qud3TeYrmxDFjxWlK82p1T+GhabuvU/s8ygiFYuUQNSbyl3jHks4lzs16RkqCXgYaKzg5LtqOW1v8FjIADLaqbn8ppEy04wVxU+p0T0CwpzGrWddBcWo29oQRzp76j2X1MioOg3sWVWXk5BRXz40uzDQaNPfH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575636; c=relaxed/simple;
	bh=an0GXOU52s5Un9gGTPGem45ODwfELlgNS1lAJtmUvT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SX7VLKPJdxdNBdZsN/TS67W4tSHvmOdYS5kxnB52EPTTonAXGEM0nbmUsU/1ovQEl7ylEkJubXP9aVw63eGd19ctqOcGjERcYeBZ2mfJ/USnH3qL3Rb/J0sK14/+Wg67qg9UlHJjh6U4alWWlyFBCIf0D7EKwVqFROwVvIVLGNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fGW3vK0C; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749575634; x=1781111634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=an0GXOU52s5Un9gGTPGem45ODwfELlgNS1lAJtmUvT0=;
  b=fGW3vK0Cyznbl8TzYSRt7JtY+HcI0tPtGdbx57w1rz+QnCvPtxcgOBqA
   gqbEAy46lxm1IHN2MTe6iXcGXLNJV3TKwoHwdBl0arPXBlKG+GlPpEb0B
   G8GwI0YY52WNtFK16Ek1SluPKzmmsuhceouPJK8CMCs5bNMRxmcjK4Vq7
   7/ucN6IzjyLuOZ/lnn34/O36LTucZibAojur+0QAs+R9xdUaW8zDpryrw
   wvl3FYQzq3n4wey3tS01rmtkL9cnL+rUDqEsOlwM4yLSoba/50yz3jS8W
   tzy97vWDPjIrbTBcKJ1U9wxTkFEhJ5PVVwRYnBhUmdfNGtdXT6YXavvpV
   w==;
X-CSE-ConnectionGUID: HjMDfZ91TTe9buqxW+GkdQ==
X-CSE-MsgGUID: k8rfH3MBTl2POU7J9xcN6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="51554644"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="51554644"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 10:13:54 -0700
X-CSE-ConnectionGUID: hxtsJi8FQk6Qt0HAIwNtpg==
X-CSE-MsgGUID: UGvyf3zPS/66eqqy914cGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="147850434"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 10 Jun 2025 10:13:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2025-06-10 (i40e, iavf, ice, e1000)
Date: Tue, 10 Jun 2025 10:13:40 -0700
Message-ID: <20250610171348.1476574-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For i40e:
Robert Malz improves reset handling for situations where multiple reset
requests could cause some to be missed.

For iavf:
Ahmed adds detection, and handling, of reset that could occur early in
the initialization process to stop long wait/hangs.

For ice:
Anton, properly, sets missed use_nsecs value.

For e1000:
Joe Damato moves cancel_work_sync() call to avoid deadlock.

The following are changes since commit fdd9ebccfc32c060d027ab9a2c957097e6997de6:
  Merge tag 'for-net-2025-06-05' of git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Ahmed Zaki (1):
  iavf: fix reset_task for early reset event

Anton Nadezhdin (1):
  ice/ptp: fix crosstimestamp reporting

Joe Damato (1):
  e1000: Move cancel_work_sync to avoid deadlock

Robert Malz (2):
  i40e: return false from i40e_reset_vf if reset is in progress
  i40e: retry VFLR handling if there is ongoing VF reset

 drivers/net/ethernet/intel/e1000/e1000_main.c   |  8 ++++----
 .../net/ethernet/intel/i40e/i40e_virtchnl_pf.c  | 11 +++++++----
 drivers/net/ethernet/intel/iavf/iavf_main.c     | 11 +++++++++++
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 17 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp.c        |  1 +
 5 files changed, 40 insertions(+), 8 deletions(-)

-- 
2.47.1


