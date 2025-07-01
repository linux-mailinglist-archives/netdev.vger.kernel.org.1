Return-Path: <netdev+bounces-202975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B99AF006E
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B571C3A2D28
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D900227CCE7;
	Tue,  1 Jul 2025 16:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BXyPG1HM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985327F18C
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 16:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388204; cv=none; b=FHEsLtGfk5PhcW7o5n1NBnGEzTfuk+8AEFUYSHz5iMb1PQSDAvYgyesvEgA5dBd/G3Eg0VWpuCma76IGTmfklxrpwGJzzkDi6hl1qMUT9QpY+dk7JBukUpw15zwALzOx/bKfhproWj6a/m2vbW6hVr3vf+6VWe3inQuWLDKsiJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388204; c=relaxed/simple;
	bh=7yYJUV6ppNgeRKLNbMeePZM9iPdG1PLQjiAiERP22z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCtDjCo/X6duK8JyAjzGPXGuNLKeCL75kpWBbGqiF85HfPvYn2vZym6na55Z6Kiz+7mtkC8QFOxcz1bPx8q6QoeYTtDMIUtSWLQaXxoWon9ywe4RakfFxbeh2Pp0ceO2afPFtxGltauuKLR1r4firKsPYHtd89ZZgiK9VHANTu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BXyPG1HM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751388203; x=1782924203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7yYJUV6ppNgeRKLNbMeePZM9iPdG1PLQjiAiERP22z8=;
  b=BXyPG1HMOHqdF8Py5H0nBjNtIRfs6nkF66XGODr4ssWx89XRulQubStc
   LHUk5/1wSfb9hq9gBeX9iE2CnRKBKlZj2P3l2TXllnB60YAkusIzJnvSu
   XrWRZj+dr9wj35fC4bui+JzwwU9cXhKRlpIQOFsEUMMjt05LVBbqZwzSM
   WKJT5k1Okpext9dXRKlUupBpZW3FChLxcoRqZhwNFXG1Yda05ybC4tqUe
   CynjzzQLSJIA4PMdNwxUndxegnkBlan4uuGIIkvdp8Y8Jbgi2QSxDRY4x
   5K1lKJRshVenIin4bIircGFvjmhib7R6IG7uttctarMda+x5vOqLohdOl
   w==;
X-CSE-ConnectionGUID: 8udPOGjtT4CD3m23vwtZKQ==
X-CSE-MsgGUID: R8NkP/i8QkmS4KCepUujEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="41296653"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="41296653"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 09:43:20 -0700
X-CSE-ConnectionGUID: u/2tqb/zQ5qtdQ2CHVg3YA==
X-CSE-MsgGUID: Z0R0bZEbTK+E4Wp6MWVJkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="153594087"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 01 Jul 2025 09:43:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/3] idpf: return 0 size for RSS key if not supported
Date: Tue,  1 Jul 2025 09:43:13 -0700
Message-ID: <20250701164317.2983952-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250701164317.2983952-1-anthony.l.nguyen@intel.com>
References: <20250701164317.2983952-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Returning -EOPNOTSUPP from function returning u32 is leading to
cast and invalid size value as a result.

-EOPNOTSUPP as a size probably will lead to allocation fail.

Command: ethtool -x eth0
It is visible on all devices that don't have RSS caps set.

[  136.615917] Call Trace:
[  136.615921]  <TASK>
[  136.615927]  ? __warn+0x89/0x130
[  136.615942]  ? __alloc_frozen_pages_noprof+0x322/0x330
[  136.615953]  ? report_bug+0x164/0x190
[  136.615968]  ? handle_bug+0x58/0x90
[  136.615979]  ? exc_invalid_op+0x17/0x70
[  136.615987]  ? asm_exc_invalid_op+0x1a/0x20
[  136.616001]  ? rss_prepare_get.constprop.0+0xb9/0x170
[  136.616016]  ? __alloc_frozen_pages_noprof+0x322/0x330
[  136.616028]  __alloc_pages_noprof+0xe/0x20
[  136.616038]  ___kmalloc_large_node+0x80/0x110
[  136.616072]  __kmalloc_large_node_noprof+0x1d/0xa0
[  136.616081]  __kmalloc_noprof+0x32c/0x4c0
[  136.616098]  ? rss_prepare_get.constprop.0+0xb9/0x170
[  136.616105]  rss_prepare_get.constprop.0+0xb9/0x170
[  136.616114]  ethnl_default_doit+0x107/0x3d0
[  136.616131]  genl_family_rcv_msg_doit+0x100/0x160
[  136.616147]  genl_rcv_msg+0x1b8/0x2c0
[  136.616156]  ? __pfx_ethnl_default_doit+0x10/0x10
[  136.616168]  ? __pfx_genl_rcv_msg+0x10/0x10
[  136.616176]  netlink_rcv_skb+0x58/0x110
[  136.616186]  genl_rcv+0x28/0x40
[  136.616195]  netlink_unicast+0x19b/0x290
[  136.616206]  netlink_sendmsg+0x222/0x490
[  136.616215]  __sys_sendto+0x1fd/0x210
[  136.616233]  __x64_sys_sendto+0x24/0x30
[  136.616242]  do_syscall_64+0x82/0x160
[  136.616252]  ? __sys_recvmsg+0x83/0xe0
[  136.616265]  ? syscall_exit_to_user_mode+0x10/0x210
[  136.616275]  ? do_syscall_64+0x8e/0x160
[  136.616282]  ? __count_memcg_events+0xa1/0x130
[  136.616295]  ? count_memcg_events.constprop.0+0x1a/0x30
[  136.616306]  ? handle_mm_fault+0xae/0x2d0
[  136.616319]  ? do_user_addr_fault+0x379/0x670
[  136.616328]  ? clear_bhb_loop+0x45/0xa0
[  136.616340]  ? clear_bhb_loop+0x45/0xa0
[  136.616349]  ? clear_bhb_loop+0x45/0xa0
[  136.616359]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  136.616369] RIP: 0033:0x7fd30ba7b047
[  136.616376] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d bd d5 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
[  136.616381] RSP: 002b:00007ffde1796d68 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  136.616388] RAX: ffffffffffffffda RBX: 000055d7bd89f2a0 RCX: 00007fd30ba7b047
[  136.616392] RDX: 0000000000000028 RSI: 000055d7bd89f3b0 RDI: 0000000000000003
[  136.616396] RBP: 00007ffde1796e10 R08: 00007fd30bb4e200 R09: 000000000000000c
[  136.616399] R10: 0000000000000000 R11: 0000000000000202 R12: 000055d7bd89f340
[  136.616403] R13: 000055d7bd89f3b0 R14: 000055d78943f200 R15: 0000000000000000

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 9bdb309b668e..eaf7a2606faa 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -47,7 +47,7 @@ static u32 idpf_get_rxfh_key_size(struct net_device *netdev)
 	struct idpf_vport_user_config_data *user_config;
 
 	if (!idpf_is_cap_ena_all(np->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
-		return -EOPNOTSUPP;
+		return 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
@@ -66,7 +66,7 @@ static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
 	struct idpf_vport_user_config_data *user_config;
 
 	if (!idpf_is_cap_ena_all(np->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
-		return -EOPNOTSUPP;
+		return 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
-- 
2.47.1


