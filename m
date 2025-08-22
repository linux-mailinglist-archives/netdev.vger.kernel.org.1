Return-Path: <netdev+bounces-215891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 175A2B30D09
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 05:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA4D21CE41E6
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 03:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013372737E5;
	Fri, 22 Aug 2025 03:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmRNDO2s"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27C393DC5
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 03:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755834822; cv=none; b=gXHYczfVJnka0qDbVtNsoVNKkPGLfXcSiTjgc9bzsL0b6CgxsXwqSBp/8k6xL4g1B7fuPA4qgnDEVvxVIDJ9HgiSuHGHQ+ermb/So6gNmYWXfSbNZ39Tp6mLPtNtvszdkW2/azsM3QEyKygRO/Nvar0vbwnPC7PmoFlmBPLRC4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755834822; c=relaxed/simple;
	bh=ADoLOsWifGjrYBSUnJen568SncRhss7JIBHOtlvnQSE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=FwFBCabUgbxE4CIp0XX3XUcYlZa5S0hokyIB5XMmERwJW2a30UVmk92wzI+2WeG6knxtXNgKetWYGmUrk0Ib0sRvlIWvTwjdtdx9kR3Y9DUrAg5FqYGjokFmmG3ZW6Au5s6OgTH7797P06Z8uSf8kpA8F2IO/gYsM9MHcxRPNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmRNDO2s; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755834821; x=1787370821;
  h=from:to:cc:subject:date:message-id;
  bh=ADoLOsWifGjrYBSUnJen568SncRhss7JIBHOtlvnQSE=;
  b=SmRNDO2s+c3w7zFB3IongDXUUJ7/du6KFaDx/+eDopcSo4zhma/3sii1
   rOMt3S6LDJAE/44Gk9KxdXcx36QN50sNK5nuFLFTMjytnrPccQgaTn0KT
   m5PKTkqVpezrTzuTb9cjuyLtiwT130CUXWH7MizKDUg0Vb5qyKF2VYiib
   XoCFfXp7uQBeW0MJyqfVgThaPKiNK6aTFQ6SvTi0DYS+ZcAlplzJ/Ysy4
   MAd7h0D5sbf6hB6Z9daDE3ir7mycVLh3d5cHTCmNgRk+YsvGJW6RiHn63
   mVVuWmjsKaiAYKZmBsIwKJzSqHsrsu+o9sc1BiuX1ghLUodrXnqc1A3w5
   g==;
X-CSE-ConnectionGUID: CBEY8+bLSO+AWxPy+hRo8Q==
X-CSE-MsgGUID: bY1cMKDdShWwGxdjsCUj5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="69508570"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="69508570"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 20:53:40 -0700
X-CSE-ConnectionGUID: YVQ6LBE1R3abFw1s3Y4o0A==
X-CSE-MsgGUID: kEA06p//Q8KGqG7jrFV9pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="192253205"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2025 20:53:39 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com
Subject: [PATCH iwl-net 0/2] idpf: Fix vport state handling
Date: Thu, 21 Aug 2025 20:52:46 -0700
Message-Id: <20250822035248.22969-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

While testing the support for setting the MAC type [0], rmmod while 
multiple vports are up would occasionally report an error, caused by a 
VC message being sent with opcode 536, attempting to delete a MAC filter 
that was already deleted by the call to idpf_vport_stop():
idpf 0000:83:00.0: Received invalid MAC filter payload (op 536) (len 0)

This can happen as idpf_addr_unsync() is called via ndo_set_rx_mode() 
while idpf_vport_stop() is called  by rmmod:
rmmod-231066  [004] ..... 100851.014226: idpf_add_del_mac_filters <-idpf_vport_stop
systemd-resolve-1364    [029] b..1. 100851.159457: idpf_add_del_mac_filters <-idpf_addr_unsync

Though the issue was discovered while testing the MAC type change, it is 
not specific to that flow, hence why it is posted in a separate series.
While it can be applied on its own, for the purpose of testing it is 
recommended to be applied on top of [0].

The changes are split in 2 parts:
- The first commit is just a conversion to bitmap for the vport state.
- Second commit plugs the race by making sure the IDPF_VPORT_UP bit is
  cleared by idpf_vport_stop() on entry.

[0] https://lore.kernel.org/intel-wired-lan/20250814234300.2926-1-emil.s.tantilov@intel.com/

Emil Tantilov (2):
  idpf: convert vport state to bitmap
  idpf: fix possible race in idpf_vport_stop()

 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++------
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 10 ++++----
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 23 +++++++++----------
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  2 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  4 ++--
 6 files changed, 25 insertions(+), 28 deletions(-)

-- 
2.37.3


