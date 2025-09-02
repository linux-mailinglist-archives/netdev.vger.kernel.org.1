Return-Path: <netdev+bounces-219358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34CDB410B1
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936E83B19B6
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721722777FC;
	Tue,  2 Sep 2025 23:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eFEEvMyc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829582773CB
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756855300; cv=none; b=XQgrxh7SUf0gyBgNJQyjIKctz6B1nOmBNt1ARxGLGeTAgS54QcFIiyMuSeyY3dubDhV8Bf6SkJIIUyq4KoitKIMVFO+4/QdjqGqGT/I8UVy/MaKnBaNK+kWJ+dRLG5WpaKYf/Jqv3xHyV+FrJKAJ86kUsjO3IloFwCq8CLxdE+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756855300; c=relaxed/simple;
	bh=AZUIZyFFoLadfnlI05MpLGGFpYbyJBalX+0CGgA9/nk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgPNqIcyuRFSyG79oiVTFTblFnrSaOTjZE0e5GQZok/IaCT4SOAX5j7CJOwwofKfh1TCDmEioN4EBIgNxHGzj3QV6Y8d43icHMoNrp3Kw8tfZaxpNjfN0AQut9MBxx8sMy5en5D/O2AL4mHLUtlsUeV+m+Xgcld5e0rM/xDvPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eFEEvMyc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756855298; x=1788391298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AZUIZyFFoLadfnlI05MpLGGFpYbyJBalX+0CGgA9/nk=;
  b=eFEEvMycc6mwGjmyEPYiE4/Nu/KkUoQVQFIr649J9TZUacHXS3AmcdHw
   dnEHfKOHQeTGmaulIdIUxzBNQlvRQHJ3QUO0P+diDGhB/QSMkLIpnGLGL
   Nux7EABRy7oQIaBw/12Lenx4TAneazjl4yn18RJ2iMaCyYztXM3VvNMBt
   osZB7IxnBuuEP1hMLoJsCIQ6LLsNNSZXZP+XMxEEuuG3+Y2ntvB62hegc
   34jf8ygThG5/U9mFVO+muAkBTZ7i5/fcIu6eVHXnLzDPh2UDIeRc5yyTY
   8d5UWlQbNABD0tS6m8bE4aGGI5xGNIFx9fPYDh/d0qBvCW07ANYzSKINf
   Q==;
X-CSE-ConnectionGUID: u0XTkEIWSQq4qh8eFhkYFg==
X-CSE-MsgGUID: RGr7fuUyQySx/PObLc7LQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69767178"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="69767178"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 16:21:37 -0700
X-CSE-ConnectionGUID: 3/JX2KdtRK6hAiw0Q946sg==
X-CSE-MsgGUID: sDaYUXf/Q8WH8DO855xDfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="171575886"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa008.jf.intel.com with ESMTP; 02 Sep 2025 16:21:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2025-09-02 (ice, idpf, i40e, ixgbe, e1000e)
Date: Tue,  2 Sep 2025 16:21:20 -0700
Message-ID: <20250902232131.2739555-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Jake adds checks for initialization of Tx timestamp tracking structure
to prevent NULL pointer dereferences.

For idpf:
Josh moves freeing of auxiliary device id to prevent use-after-free issue.

Emil sets, expected, MAC type value when sending virtchnl add/delete MAC
commands.

For i40e:
Jake removes read debugfs access as 'netdev_ops' has the possibility to
overflow.

Zhen Ni adds handling for when MAC list is empty.

For ixgbe:
Alok Tiwari corrects bitmap being used for link speeds.

For e1000e:
Vitaly adds check to ensure overflow does not occur in
e1000_set_eeprom().

The following are changes since commit a6099f263e1f408bcc7913c9df24b0677164fc5d:
  net: ethernet: ti: am65-cpsw-nuss: Fix null pointer dereference for ndev
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Alok Tiwari (1):
  ixgbe: fix incorrect map used in eee linkmode

Emil Tantilov (1):
  idpf: set mac type when adding and removing MAC filters

Jacob Keller (3):
  ice: fix NULL access of tx->in_use in ice_ptp_ts_irq
  ice: fix NULL access of tx->in_use in ice_ll_ts_intr
  i40e: remove read access to debugfs files

Joshua Hay (1):
  idpf: fix UAF in RDMA core aux dev deinitialization

Vitaly Lifshits (1):
  e1000e: fix heap overflow in e1000_set_eeprom

Zhen Ni (1):
  i40e: Fix potential invalid access when MAC list is empty

 drivers/net/ethernet/intel/e1000e/ethtool.c   |  10 +-
 drivers/net/ethernet/intel/i40e/i40e_client.c |   4 +-
 .../net/ethernet/intel/i40e/i40e_debugfs.c    | 123 +++---------------
 drivers/net/ethernet/intel/ice/ice_main.c     |  12 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_idc.c    |   4 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   9 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  12 ++
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |   4 +-
 9 files changed, 65 insertions(+), 126 deletions(-)

-- 
2.47.1


