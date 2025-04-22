Return-Path: <netdev+bounces-184891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11784A979B1
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 23:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1893A9FB0
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 21:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6B270554;
	Tue, 22 Apr 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T6UFj/r0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10A262FFC
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 21:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745358514; cv=none; b=jEu0X2/NnmhMjIEUyHOqGU6vVcAnPUlYPuOA79r5PKkQLkHHvJWFMJJ3X1n7qqVFsJu4Rjk5NiJ3sJO8aLVvQfJKiA2gKPfhsCV3uQNsJtSMzi077SJpD0tWD1iNGJgXbTMjIpodXKZCskPwznynQvdxo3E60BUONKBMphSiI8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745358514; c=relaxed/simple;
	bh=ZEsnU07JrPjfYqx9V6J9FLdY/kqz52yq29rV4o+ocdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQ0nOYM9reIfBWvQYH9a3WnzbEAmICOy9QspSehvoJBdsnPFopAtA4W8vFJuOCdVpPdGJs/6p1n5XYBnYpXrUFbcUGDd3NmeCmFvm3RXPFniq9gOyGJ9kzIaGvOPjrCLCi4wFlo8MIjjfQjagwRfr7IeOK79iXXhTlKQbr9PanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T6UFj/r0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745358512; x=1776894512;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZEsnU07JrPjfYqx9V6J9FLdY/kqz52yq29rV4o+ocdw=;
  b=T6UFj/r0J6C5d4vStNA/ZRVFRDTwAHB8D0nIJIhyV4gh9SKL9zw6jmIj
   KpqX4j8oZcwLp088+vPrq+TfjdCEPmBpAC3XHCZ0iYBUX3rS83jrmY+kE
   Ftklpe9U5fS3pdPvhY/opsqQ8xI9bmZEjzkEdZq2DqQ+aokFDlBdKRQnA
   SYwsQLNPOZWJRrITKhYONO1f8tMcKPZT15WMURjhwGkNuhgtGpXwpAg5K
   iux8MPcYaIUWdsclJMvrfK8buKsexTk7sHmQW5lss7CXXI4nAecxLSCpJ
   x6+OW3hILWMVO8RZ1rLrb41EZoqdkO4glfV/lH6XVaZxPOaXPNcOiYBGX
   g==;
X-CSE-ConnectionGUID: zP859uj9TWqo4LBu23tu4A==
X-CSE-MsgGUID: xQLRQ9vMTw65JwoSYMTy+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46949127"
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="46949127"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 14:48:32 -0700
X-CSE-ConnectionGUID: SpWl5Hg0QT6C8nPLS43uCg==
X-CSE-MsgGUID: Xf0oCnViSXajoFEC7kZY+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,232,1739865600"; 
   d="scan'208";a="163186546"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 22 Apr 2025 14:48:31 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates 2025-04-22 (ice, idpf)
Date: Tue, 22 Apr 2025 14:48:04 -0700
Message-ID: <20250422214822.882674-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ice:
Paul removes setting of ICE_AQ_FLAG_RD in ice_get_set_tx_topo() on
E830 devices.

Xuanqiang Luo adds error check for NULL VF VSI.

For idpf:
Madhu fixes misreporting of, currently, unsupported encapsulated
packets.

The following are changes since commit c03a49f3093a4903c8a93c8b5c9a297b5343b169:
  net: lwtunnel: disable BHs when required
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Madhu Chittim (1):
  idpf: fix offloads support for encapsulated packets

Paul Greenwalt (1):
  ice: fix Get Tx Topology AQ command error on E830

Xuanqiang Luo (1):
  ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()

 drivers/net/ethernet/intel/ice/ice_ddp.c      | 10 ++--
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    |  5 ++
 drivers/net/ethernet/intel/idpf/idpf.h        | 14 +++--
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 57 +++++++------------
 4 files changed, 39 insertions(+), 47 deletions(-)

-- 
2.47.1


