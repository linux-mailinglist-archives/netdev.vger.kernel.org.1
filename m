Return-Path: <netdev+bounces-263458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHK6C8dqp2mYhQAAu9opvQ
	(envelope-from <netdev+bounces-263458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:12:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0656D1F8474
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5E241303CB30
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE273976A4;
	Tue,  3 Mar 2026 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEdFIvNc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD2386575
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579522; cv=none; b=hjPjFEdeM1ORBYrSjcwCL38LzGw+AyG20K1ryZIhvh1h3vS5bkuBZ98toYxWPQNdBp2BR4ihX/bbSFs76naBhdwXnq2oAiLUswmm1PRI/37+VDmP7e7AGQY84gUPQY3zk2tpZ19cIA+FukCexAhsGWfyBueT0Buf7r+oyz4WaTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579522; c=relaxed/simple;
	bh=HwG7wQDiUdhPcNN4taA5Px3Q3Ke9KAzMdvuAs3cNFKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJIVc0qZ25Zjq4PXyx1XUiKxqJT2HLbjJYd1edaHTCdCSs0/aH4Mx/oWKwLaSEimy7l2YSdU1Kie652oAVQ2Zq+97MiLeWPzdKgyFZN0LuOHXVCZesRRO+C4c3nMWVtl6IyISTeiCvkvZpEGCa5Vm9+zO+sxiwjexAkjwy5yEZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEdFIvNc; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579519; x=1804115519;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HwG7wQDiUdhPcNN4taA5Px3Q3Ke9KAzMdvuAs3cNFKE=;
  b=kEdFIvNc1l5QNGy3dmDAHcn70m90A7khGV9ZeVcpRtTj501YES7AO7ek
   2VfY6yp73RkrBu/plfZgEC/Hnna/SjJqDU/rDenAlqeHXgTH+2h6xx7Kr
   z0O9j0zq8HiAkJbiTCITJ53LQcNHGCog/qqbybGSa751EhFjCICQSOYS0
   rqUcIurHVjxV7g5+MBOJrISVJ9avcVspktrMGwskOE8dRSRZIjb19WLCC
   6qwIGl0kudcCq1xR9k1aFYbSsRbVTmGW3GT92yGnNJ4deQsY4CBNLTxaE
   FkiIv2RIhL/s9gwT1rvT4sY+UZMHAOVrzt7hsNiW+rQJERvJMH6YRzdeI
   w==;
X-CSE-ConnectionGUID: QJQpsry4RFiYi8Q4NKp4PQ==
X-CSE-MsgGUID: W8sHqbhzQvm0Gu2H/Yyz8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238787"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:11:58 -0800
X-CSE-ConnectionGUID: iY/4tSaMRk6gSsQ7p+VKzA==
X-CSE-MsgGUID: RyGJhE+hTcS+qP8mBbIGTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633793"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 15:11:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2026-03-03 (ice, libie, iavf, igb, igc)
Date: Tue,  3 Mar 2026 15:11:46 -0800
Message-ID: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0656D1F8474
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263458-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Larysa removes VF restriction for LLDP filters on ice to allow for LLDP
traffic to reach the correct destination.

Jakub adds retry mechanism for AdminQ Read/Write SFF EEPROM call to
follow hardware specification on ice.

Zilin Guan adds cleanup path to free XDP rings on failure in
ice_set_ringparam().

Michal bypasses firmware logging unroll in libie when it isn't supported.

Kohei Enju fixes iavf to take into account hardware MTU support when
setting max MTU values.

Vivek Behera fixes issues on igb and igc using incorrect IRQs when Tx/Rx
queues do not share the same IRQ.

The following are changes since commit 1a86a1f7d88996085934139fa4c063b6299a2dd3:
  net: Fix rcu_tasks stall in threaded busypoll
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Jakub Staniszewski (2):
  ice: reintroduce retry mechanism for indirect AQ
  ice: fix retry for AQ command 0x06EE

Kohei Enju (1):
  iavf: fix netdev->max_mtu to respect actual hardware limit

Larysa Zaremba (1):
  ice: fix adding AQ LLDP filter for VF

Michal Swiatkowski (1):
  libie: don't unroll if fwlog isn't supported

Vivek Behera (2):
  igb: Fix trigger of incorrect irq in igb_xsk_wakeup
  igc: Fix trigger of incorrect irq in igc_xsk_wakeup function

Zilin Guan (1):
  ice: Fix memory leak in ice_set_ringparam()

 drivers/net/ethernet/intel/iavf/iavf_main.c  | 17 +++++++-
 drivers/net/ethernet/intel/ice/ice_common.c  | 15 +++++--
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 46 ++++++++++----------
 drivers/net/ethernet/intel/igb/igb_xsk.c     | 38 ++++++++++++----
 drivers/net/ethernet/intel/igc/igc_main.c    | 34 ++++++++++-----
 drivers/net/ethernet/intel/igc/igc_ptp.c     |  3 +-
 drivers/net/ethernet/intel/libie/fwlog.c     |  4 ++
 7 files changed, 110 insertions(+), 47 deletions(-)

-- 
2.47.1

