Return-Path: <netdev+bounces-290043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBJdNW0ADmp+5QUAu9opvQ
	(envelope-from <netdev+bounces-290043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B769659702E
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDFCC30346CE
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F278368968;
	Wed, 20 May 2026 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZwroW7J"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C789F17A2FC
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302109; cv=none; b=Yz9ARwPvjBTEoM1MOEbxOdRkaLcPMGTlAeoa906yn+gio8fuS/y6E17Edf79yHmanTQPIWHYxwgBLVDIJWaIBZkvZOcJfsqno163Qi9yXnHD9p1N+DYAuRt7CUoWSQ404H6L/ZEOWjS0lUnLXJ2l50Qxdr7d/dONIN1xjK0jZcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302109; c=relaxed/simple;
	bh=icWIZjLOTuvGJ+N/SeRHL1GuE+VE6j/H7U2P/08fJ6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YcDH23yUHi0xI4LS0tz7TC1rOxrUMb9H4blF4pI7RXJwMoK8nUfPzIJktY8MXcaXbxMwioLAFm8WGd12FtROMDbm5RuIrbCCobDwc2tLTJuTYav8RULL9/agLTQSB2M3QJNjWT4qtwldBJdWdemRWzOZjOpa8zq7o2DJSimJvPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZwroW7J; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779302108; x=1810838108;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=icWIZjLOTuvGJ+N/SeRHL1GuE+VE6j/H7U2P/08fJ6s=;
  b=aZwroW7JpuzGd4qGi/SEfkwjWEiclCVOH+T/eDeB8k/tYb9NAPacDGkq
   HnjuTAwAQUEEDajgfhD8ou7frGVla296qUgJdLLSDTcOFHou+Apf4IOCz
   mcvm+ZahPuQtAiNUmhIpDlFx3BKHYYznuEZ/SDgteMEI9fdL7hLgEtqoM
   7XVkymGiJ2jezTb7n2VzI10xYbiw+R1m4rxfHc/PFHQGYUIErQ1IQMv/G
   8t20yKenxbzOp26rMVph4KDeceKr4nwtnCVbFp1u7Fwk/x63SO2+hYKm0
   rESLgCukFY7KHIGtubpwwaa4z8l2MgBeMuEylDvtsvekxb6Ix+Y3bJq6X
   w==;
X-CSE-ConnectionGUID: oO+p0jRYQs2pyNleLxYSnA==
X-CSE-MsgGUID: 3T2fE7m2R8OGJqmqBlIExA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80391741"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80391741"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:35:07 -0700
X-CSE-ConnectionGUID: +tPCDv5lRVGJwSGrqU4Llg==
X-CSE-MsgGUID: rlciePmaRcWAwKlym8xIJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="239423883"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 20 May 2026 11:35:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates 2026-05-20 (ice, iavf, i40e, ixgbe)
Date: Wed, 20 May 2026 11:34:48 -0700
Message-ID: <20260520183501.3360810-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-290043-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B769659702E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kohei Enju disallows XDP attach when VSI is rebuilding to prevent
possible NULL dereference on ice.

Michal Schmidt adds call to ice_vsi_realloc_stat_arrays() when
reconfiguring VF VSIs on ice to resolve overwriting bounds when queues
are increased.

Jose Ignacio Tornos Martinez fixes issues with VF bonding that came
about with commit ad7c7b2172c3 ("net: hold netdev instance lock during
sysfs operations").

Further details:
https://lore.kernel.org/all/20260429102426.210750-1-jtornosm@redhat.com/

Przemyslaw Korba sets the proper PTP extts flags for i40e.

Corinna Vinschen moves from VF spinlock to RCU to prevent races in
structure accesses in ixgbe.

The following are changes since commit edc502717be153674b0b3eefb8b40734c747c138:
  Merge branch 'mptcp-misc-fixes-for-v7-1-rc4'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 100GbE

Corinna Vinschen (1):
  ixgbe: only access vfinfo and mv_list under RCU lock

Jose Ignacio Tornos Martinez (4):
  iavf: return EBUSY if reset in progress or not ready during MAC change
  i40e: skip unnecessary VF reset when setting trust
  iavf: send MAC change request synchronously
  ice: skip unnecessary VF reset when setting trust

Kohei Enju (1):
  ice: fix UAF/NULL deref when VSI rebuild and XDP attach race

Michal Schmidt (1):
  ice: fix stats array overflow when VF requests more queues

Przemyslaw Korba (1):
  i40e: set supported_extts_flags for rising edge

 drivers/net/ethernet/intel/i40e/i40e_ptp.c    |   2 +
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    |  38 +-
 drivers/net/ethernet/intel/iavf/iavf.h        |  10 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  74 ++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 100 +++-
 drivers/net/ethernet/intel/ice/ice_lib.c      |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  13 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  33 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |   7 +
 drivers/net/ethernet/intel/ixgbe/ixgbe.h      |   7 +-
 .../net/ethernet/intel/ixgbe/ixgbe_dcb_nl.c   |  36 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  |  44 +-
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    |  17 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 227 +++++---
 .../net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 547 ++++++++++++------
 16 files changed, 825 insertions(+), 333 deletions(-)

-- 
2.47.1


