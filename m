Return-Path: <netdev+bounces-266325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCrROJ+FsGk5kQIAu9opvQ
	(envelope-from <netdev+bounces-266325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:57:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9F42580BD
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 21:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F12A30B1977
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 20:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F6376BF2;
	Tue, 10 Mar 2026 20:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQ0VSt9N"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33BA352C4F
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773176221; cv=none; b=tnH1/t5w4ku0eHkiyVtMLPDyEP4+FEQlPg+cUja3fN7L42NA+DSIGPpph7XCOKZv3ifXA7CBCN4pdj6bpXifbzqnOnznfUl6lUoFsfpJMYQpgrK2GBqX8EPl0iIAQC7YWYy7uKBj1TG8lYfACvlFVcBLrNZYmED5gDrcS3gQEcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773176221; c=relaxed/simple;
	bh=EFsLn81hEAGbiNtRRuxLHFVmVCOalMy0iAx6Co25y70=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkO8UTWM5BbX/gWk39OmI4qCsuWWB8ycveb8QtgPzMiQ5zByLUsZPvCo/9oasrHwcB288Y/bTW5cUFKoX1MOGH2XZTfrXktRvMVGojL/WndqbMpnxcQaBHirageQ/loX9bTlIY0EjTL5kByD97i+gh7W5aoN3We9vY7qfaT9HmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQ0VSt9N; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773176219; x=1804712219;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EFsLn81hEAGbiNtRRuxLHFVmVCOalMy0iAx6Co25y70=;
  b=XQ0VSt9N+2xP8LnHc5s+Q+5+Ka0vw5duezjD0F7Yh2uGFYIzoW42QY4d
   tMbHQ4QoNVHPobG2Eee3X1RsmWoJSavLiD/ZFRYRVONmgBVnLVQKvL5CZ
   jHrdY/uFbSJNzezvvAJP+wJ5K1PWYUiLL3vXWDgOLJzW0BO9vDQfUrtnB
   Nuh1UhvOz8M68vBdJxhNwaqvyUjkViNI9NaoQUaTrEKqtbEvHy7IY8D9F
   XO/lNH0JSnhGhaS8G68PdLmdkArNxfoJzJ1dEsIK/cuHCnVRWtmc7W+IX
   RRLdsS0Hi9X2SluXW6HrjCo/VrzCZXQcRUOgqQFgrJ1s4W9zTubQ8eIuT
   w==;
X-CSE-ConnectionGUID: hYi0e9EVSZG2asd9N4dRJg==
X-CSE-MsgGUID: cvQ1wDvVSHeq0ZEaja2HMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="85326039"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="85326039"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 13:56:59 -0700
X-CSE-ConnectionGUID: HeJOPTU0Q3aaaHw3mzqQMg==
X-CSE-MsgGUID: FYKTLh48RPqZmIC8wSNilg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="258162864"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 10 Mar 2026 13:56:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2026-03-10 (ice, iavf, i40e, e1000e, e1000)
Date: Tue, 10 Mar 2026 13:56:48 -0700
Message-ID: <20260310205654.4109072-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6D9F42580BD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266325-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:mid]
X-Rspamd-Action: no action

Nikolay Aleksandrov changes return code of RDMA related ice devlink get
parameters when irdma is not enabled to -EOPNOTSUPP as current return
of -ENODEV causes issues with devlink output.

Petr Oros resolves a couple of issues in iavf; freeing PTP resources
before reset and disable. Fixing contention issues with the netdev lock
between reset and some ethtool operations.

Alok Tiwari corrects an incorrect comparison of cloud filter values and
adjust some passed arguments to sizeof() for consistency on i40e.

Matt Vollrath removes an incorrect decrement for DMA error on e1000 and
e1000e drivers.

The following are changes since commit 73aefba4e2eb713cf7bc4ad83cfc9b5d4f966f6d:
  Merge tag 'linux-can-fixes-for-7.0-20260310' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Alok Tiwari (1):
  i40e: fix src IP mask checks and memcpy argument names in cloud filter

Matt Vollrath (1):
  e1000/e1000e: Fix leak in DMA error cleanup

Nikolay Aleksandrov (1):
  drivers: net: ice: fix devlink parameters get without irdma

Petr Oros (2):
  iavf: fix PTP use-after-free during reset
  iavf: fix incorrect reset handling in callbacks

 drivers/net/ethernet/intel/e1000/e1000_main.c |  2 -
 drivers/net/ethernet/intel/e1000e/netdev.c    |  2 -
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 14 ++--
 drivers/net/ethernet/intel/iavf/iavf.h        |  3 +-
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 19 ++---
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 81 +++++++------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  1 -
 .../net/ethernet/intel/ice/devlink/devlink.c  |  4 +-
 8 files changed, 44 insertions(+), 82 deletions(-)

-- 
2.47.1


