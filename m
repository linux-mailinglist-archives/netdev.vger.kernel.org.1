Return-Path: <netdev+bounces-255229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM2MHpb+fGnLPgIAu9opvQ
	(envelope-from <netdev+bounces-255229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:55:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB699BE030
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 19:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE2B9303FF38
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 18:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863CE385EEE;
	Fri, 30 Jan 2026 18:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2t76HAH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC8387357
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799251; cv=none; b=nm3wQK3+L2ygCGRCTUDJWRLReAMJ4QSOGF3IC4f7u9PT04lDd9ScSc+lETn2Flv6NmQ5ISY31sXcjF1/divciICxioYRtOaKlnza5kUn62obMY0V8FrltsS3yDDe42dd/xdqOOeBT+g0Sa1B9s4m0D3l3cej5ZbqS/fkdv1CZt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799251; c=relaxed/simple;
	bh=4hA8+5V9zUTOTtdxsL59RoF45dOCKSXugTqSOlt39M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iv6sqb8IgAW6eNx+EQcAky9B9APYpODfQauB9zObxp9y3o8wHu7s1YHqpuI4Kl9IW3Ce8Jh7rZ3hZbC4p3yAtqAEeh+HfLAwNM4Cs/2PzOkXOGuzit/BZt/8xlwVztXfAGqJrfP3d7y9F6XOjYnrLMWS2/PE48p+MjuHzZ7zDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2t76HAH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769799250; x=1801335250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4hA8+5V9zUTOTtdxsL59RoF45dOCKSXugTqSOlt39M0=;
  b=c2t76HAHS9JqOk5Fv4VRGgQ9cEMvEcjQkOrs9dzUO70UACUqwVFf1gZJ
   v+ABVAxbWxccUyT5yv/+y4TBsFVkhvbIHFfbOzFKA59jrhRdpjs/Eg2oh
   sunWzZ+XhljlORqLmbqaKys2SRJ0dpHTQzc53cEoVCCyAp/lK39sPUluY
   xlrCAzng7AjIghXJZ2PpElpXUOSZDod+HkfXpNzCDxye4cMtw4lPP37nL
   HRChyNKGANZdMTD/rFXhDpNmd4aKJYAGOKe4xGCvrz7v8q6goXKSLjAVE
   XfLbdp/Y3BN0qQe72YQJJXRMvVjdPH85qttz7X/ApIER5kQG0hqyFZKZF
   w==;
X-CSE-ConnectionGUID: 8IISe7JvR0mAftpf4ZVXYg==
X-CSE-MsgGUID: gV6HlKNITIiYtPMYWAoIMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71091301"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="71091301"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 10:54:08 -0800
X-CSE-ConnectionGUID: R2i1lEDYSGqxQ4juY5n0Gw==
X-CSE-MsgGUID: QS9EbsQQRsK78ccrB6KxHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="231841016"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jan 2026 10:54:07 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mohammad Heib <mheib@redhat.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 5/5] i40e: drop udp_tunnel_get_rx_info() call from i40e_open()
Date: Fri, 30 Jan 2026 10:53:58 -0800
Message-ID: <20260130185401.1091523-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
References: <20260130185401.1091523-1-anthony.l.nguyen@intel.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255229-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpg.de:email,intel.com:email,intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB699BE030
X-Rspamd-Action: no action

From: Mohammad Heib <mheib@redhat.com>

The i40e driver calls udp_tunnel_get_rx_info() during i40e_open().
This is redundant because UDP tunnel RX offload state is preserved
across device down/up cycles. The udp_tunnel core handles
synchronization automatically when required.

Furthermore, recent changes in the udp_tunnel infrastructure require
querying RX info while holding the udp_tunnel lock. Calling it
directly from the ndo_open path violates this requirement,
triggering the following lockdep warning:

  Call Trace:
   <TASK>
   ? __udp_tunnel_nic_assert_locked+0x39/0x40 [udp_tunnel]
   i40e_open+0x135/0x14f [i40e]
   __dev_open+0x121/0x2e0
   __dev_change_flags+0x227/0x270
   dev_change_flags+0x3d/0xb0
   devinet_ioctl+0x56f/0x860
   sock_do_ioctl+0x7b/0x130
   __x64_sys_ioctl+0x91/0xd0
   do_syscall_64+0x90/0x170
   ...
   </TASK>

Remove the redundant and unsafe call to udp_tunnel_get_rx_info() from
i40e_open() resolve the locking violation.

Fixes: 1ead7501094c ("udp_tunnel: remove rtnl_lock dependency")
Signed-off-by: Mohammad Heib <mheib@redhat.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 0b1cc0481027..d3bc3207054f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -9030,7 +9030,6 @@ int i40e_open(struct net_device *netdev)
 						       TCP_FLAG_FIN |
 						       TCP_FLAG_CWR) >> 16);
 	wr32(&pf->hw, I40E_GLLAN_TSOMSK_L, be32_to_cpu(TCP_FLAG_CWR) >> 16);
-	udp_tunnel_get_rx_info(netdev);
 
 	return 0;
 }
-- 
2.47.1


