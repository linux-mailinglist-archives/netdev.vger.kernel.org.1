Return-Path: <netdev+bounces-261076-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JDMMaBmn2lRagQAu9opvQ
	(envelope-from <netdev+bounces-261076-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:16:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF819DBC9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 22:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2A2D3043AEF
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 21:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EE724E4C6;
	Wed, 25 Feb 2026 21:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mg4zm1Qg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A664F23E35F
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 21:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772054154; cv=none; b=dPwgDFWhdwhLQKVi5ZBJP3e/rFJgOb2lp0+aqg8tz5xcNXRpwEy5rggjhbY8R6dBC5hVzaow/s6kgInNBybUYj6zhiHT7cskoUCglD5fPYFQN8DDozyIknPiJN+y8Wvkn6lABMIyq+GLY+jXEJX7RXDr1u8QFaw/hThFwPxmIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772054154; c=relaxed/simple;
	bh=ywTLj6d3tUU3utmjwhHS4lz2bj5RQM9ID63YDWolGmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kc2PWwXf2KKOIZq5wGNGHtyI10qmrXslKCYsOAy2uRWXyRmK/CgavkFWthJKhUZmEHNO+dZ95kbOx3a1D1lF4rg/3iAOfNeYfu9q4pVJsQA93LdZYtucLDraMPXj50E4873f9pY13/97bu69R46Mg7rw35Fx9klnPp2HF1w/Nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mg4zm1Qg; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772054154; x=1803590154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ywTLj6d3tUU3utmjwhHS4lz2bj5RQM9ID63YDWolGmI=;
  b=mg4zm1QgGj8yQXNLGc929PEHrn26IGxRrsD7GL9S2nxRQRgnWPWegkIX
   1qlYv/imsqEDwJeprNgSe4VJRq7uCfvXgemzLbaFVQpTXhd//6JPY5XUh
   pb9NwuBM3l5tvvpH6Pb0FEjaaozZUjL9wuEVMMU3DFy9beRNn/Ao/wO/V
   npqIm4rh7TBION6nhLXcHFteKMzoSnq7ezibIXrnD5W36axtDjV535/0B
   4BXGXQQw88n/Zn+61F1QkZAP9bx6+YT2PaOe97h+ai+8dkxmePYICt1H4
   yTG+5SxSL7ZtCl7Qx4HaMYEHcWRUyk94+VyOLBEenXHphQGhjOPCPgGrx
   w==;
X-CSE-ConnectionGUID: sxmcgx/DRcu0w3ZiKjkg3Q==
X-CSE-MsgGUID: Cvww5SkER3GvGu0oWmILOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73013752"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73013752"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 13:15:53 -0800
X-CSE-ConnectionGUID: Bd7vG9trQbie0eKktwVJ7Q==
X-CSE-MsgGUID: 8LsmURh2RHGlz1CSLI6yrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="239349674"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2026 13:15:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net v2 00/12][pull request] Intel Wired LAN Driver Updates 2026-02-19 (idpf, ice, i40e, ixgbevf, e1000e)
Date: Wed, 25 Feb 2026 13:15:31 -0800
Message-ID: <20260225211546.1949260-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261076-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.987];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 60FF819DBC9
X-Rspamd-Action: no action

For idpf:
Li Li moves the check for software marker to occur after incrementing
next to clean to avoid re-encountering the same packet. He also adds a
couple of checks to prevent NULL pointer dereferences and NULLs rss_key,
after free, in error path so that later checks are properly evaluated.

Brian Vazquez adjusts IRQ naming to have correlation with netdev naming.

Sreedevi removes validation of action type as part of ntuple rule
deletion.

For ice:
Aaron Ma breaks RDMA initialization into two steps and adjusts calls so
that VSIs are entirely configured before plugging.

Michal Schmidt fixes initialization of loopback VSI to have proper
resources allocated to allow for loopback testing to occur.

For i40e:
Thomas Gleixner fixes a leak of preempt count by replacing get_cpu()
with smp_processor_id().

For ixgbevf:
Jedrzej adds a check for mailbox version before attempting to call an
associated link state call that is supported in that mailbox version.

For e1000e:
Vitaly clears power gating feature for Panther Lake systems to avoid
packet issues.
---
v2:
- Drop last patch; e1000e XTAL clock adjustment

v1: https://lore.kernel.org/netdev/20260220004027.729384-1-anthony.l.nguyen@intel.com/

The following are changes since commit 2f61f38a217462411fed950e843b82bc119884cf:
  net: stmmac: fix timestamping configuration after suspend/resume
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 200GbE

Aaron Ma (1):
  ice: recap the VSI and QoS info after rebuild

Brian Vazquez (1):
  idpf: change IRQ naming to match netdev and ethtool queue numbering

Jedrzej Jagielski (1):
  ixgbevf: fix link setup issue

Li Li (4):
  idpf: increment completion queue next_to_clean in sw marker wait
    routine
  idpf: skip deallocating bufq_sets from rx_qgrp if it is NULL
  idpf: skip deallocating txq group's txqs if it is NULL
  idpf: nullify pointers after they are freed

Michal Schmidt (1):
  ice: fix crash in ethtool offline loopback test

Sreedevi Joshi (1):
  idpf: Fix flow rule delete failure due to invalid validation

Thomas Gleixner (1):
  i40e: Fix preempt count leak in napi poll tracepoint

Vitaly Lifshits (2):
  e1000e: introduce new board type for Panther Lake PCH
  e1000e: clear DPG_EN after reset to avoid autonomous power-gating

 drivers/net/ethernet/intel/e1000e/defines.h   |  1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |  4 +-
 drivers/net/ethernet/intel/e1000e/hw.h        |  2 -
 drivers/net/ethernet/intel/e1000e/ich8lan.c   | 31 ++++++++++++-
 drivers/net/ethernet/intel/e1000e/netdev.c    | 15 +++----
 drivers/net/ethernet/intel/i40e/i40e_trace.h  |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  1 +
 drivers/net/ethernet/intel/ice/ice_base.c     |  5 ++-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  4 ++
 drivers/net/ethernet/intel/ice/ice_idc.c      | 44 ++++++++++++++-----
 drivers/net/ethernet/intel/ice/ice_lib.c      | 15 ++++---
 drivers/net/ethernet/intel/ice/ice_main.c     |  7 ++-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  3 --
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 14 ++++--
 drivers/net/ethernet/intel/ixgbevf/vf.c       |  3 +-
 16 files changed, 114 insertions(+), 38 deletions(-)

-- 
2.47.1


