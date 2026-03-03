Return-Path: <netdev+bounces-263462-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YI8QLfZqp2mWhQAAu9opvQ
	(envelope-from <netdev+bounces-263462-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:12:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FC1F84AE
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 00:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B255830795F1
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 23:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D1D39B941;
	Tue,  3 Mar 2026 23:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9vta/QV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8B3932E0
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 23:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772579528; cv=none; b=AqIthCGeLL2bKPdxahRTEsCK2OhhqXfL2iOG703e0s5hwpn6CMCTaBiegYuSWkyA/Oz91zrUyywDJ0r4w0cFw1KV3eWMq2eURI/rKJEOrQ6FN1VeHdZKpw/090QZvX7jxw6ej+cyeKoUT3+rMhNfCYThBEzWnFEoGJ0S9oDf/Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772579528; c=relaxed/simple;
	bh=wmEgyA8nyNjdT1m/jN30lORYC9hUBMULrYP1nJIQ6Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6t0yef3XvNBnFvaxhEtMlnDKp/li+3mqZ0KkuEXFW9vK2j6k6jgMiIW1vYBuY7oi/fUAFO4ivJtyZxwEjO7paA1CiJX5v+oDnkyaPJUec+Jbd7hICaW6Ee2H4n5g0AL2YjadwObdInYMyI2HkmPT33ZnCacLklvx6utEDTTUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9vta/QV; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772579525; x=1804115525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wmEgyA8nyNjdT1m/jN30lORYC9hUBMULrYP1nJIQ6Xo=;
  b=C9vta/QVw1KGzh8OA4r0XVE8bWUizCHfHjjV6NNa10e7jGp939GfURGu
   zdJFTaSsn9ngSt9gwX7a6+ePQD4pAyk61mKtvyqvzS5o35yLMt46zraFw
   mvVufy0IMb3PS41/cFB/GQr7Tf+IuJVafN4xawad0IPHBlDn//h+Oy/7N
   RTuHd7j6ZrMTFsS4U9Wjr45LHoUcYBmWv/c4oxEo+f3+uM6cNFgLGNNol
   k0BlEyNKtFevvSLvyp99FLpOts+XcMFnpgulcoek3u3s/PNGgiSgGoiqi
   9lrQU7a2MkE2z1Zm9a+kUdKHtKLNSGQ2X90JAxkF/LLX3RbQLfjcn92XF
   A==;
X-CSE-ConnectionGUID: c/DRKASqT+CjYgV5VLlbig==
X-CSE-MsgGUID: 3Ag/VltSRK+YQ+SwA7nCDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11718"; a="77238820"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="77238820"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:11:59 -0800
X-CSE-ConnectionGUID: eNw2mdr5QNOBjGwmyTb6cw==
X-CSE-MsgGUID: dHMvGnSoQuy6UGJ6soGvcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="248633810"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa002.jf.intel.com with ESMTP; 03 Mar 2026 15:11:59 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 5/8] libie: don't unroll if fwlog isn't supported
Date: Tue,  3 Mar 2026 15:11:51 -0800
Message-ID: <20260303231155.2895065-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
References: <20260303231155.2895065-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 384FC1F84AE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-263462-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

The libie_fwlog_deinit() function can be called during driver unload
even when firmware logging was never properly initialized. This led to call
trace:

[  148.576156] Oops: Oops: 0000 [#1] SMP NOPTI
[  148.576167] CPU: 80 UID: 0 PID: 12843 Comm: rmmod Kdump: loaded Not tainted 6.17.0-rc7next-queue-3oct-01915-g06d79d51cf51 #1 PREEMPT(full)
[  148.576177] Hardware name: HPE ProLiant DL385 Gen10 Plus/ProLiant DL385 Gen10 Plus, BIOS A42 07/18/2020
[  148.576182] RIP: 0010:__dev_printk+0x16/0x70
[  148.576196] Code: 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 41 55 41 54 49 89 d4 55 48 89 fd 53 48 85 f6 74 3c <4c> 8b 6e 50 48 89 f3 4d 85 ed 75 03 4c 8b 2e 48 89 df e8 f3 27 98
[  148.576204] RSP: 0018:ffffd2fd7ea17a48 EFLAGS: 00010202
[  148.576211] RAX: ffffd2fd7ea17aa0 RBX: ffff8eb288ae2000 RCX: 0000000000000000
[  148.576217] RDX: ffffd2fd7ea17a70 RSI: 00000000000000c8 RDI: ffffffffb68d3d88
[  148.576222] RBP: ffffffffb68d3d88 R08: 0000000000000000 R09: 0000000000000000
[  148.576227] R10: 00000000000000c8 R11: ffff8eb2b1a49400 R12: ffffd2fd7ea17a70
[  148.576231] R13: ffff8eb3141fb000 R14: ffffffffc1215b48 R15: ffffffffc1215bd8
[  148.576236] FS:  00007f5666ba6740(0000) GS:ffff8eb2472b9000(0000) knlGS:0000000000000000
[  148.576242] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  148.576247] CR2: 0000000000000118 CR3: 000000011ad17000 CR4: 0000000000350ef0
[  148.576252] Call Trace:
[  148.576258]  <TASK>
[  148.576269]  _dev_warn+0x7c/0x96
[  148.576290]  libie_fwlog_deinit+0x112/0x117 [libie_fwlog]
[  148.576303]  ixgbe_remove+0x63/0x290 [ixgbe]
[  148.576342]  pci_device_remove+0x42/0xb0
[  148.576354]  device_release_driver_internal+0x19c/0x200
[  148.576365]  driver_detach+0x48/0x90
[  148.576372]  bus_remove_driver+0x6d/0xf0
[  148.576383]  pci_unregister_driver+0x2e/0xb0
[  148.576393]  ixgbe_exit_module+0x1c/0xd50 [ixgbe]
[  148.576430]  __do_sys_delete_module.isra.0+0x1bc/0x2e0
[  148.576446]  do_syscall_64+0x7f/0x980

It can be reproduced by trying to unload ixgbe driver in recovery mode.

Fix that by checking if fwlog is supported before doing unroll.

Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/libie/fwlog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/fwlog.c b/drivers/net/ethernet/intel/libie/fwlog.c
index 79020d990859..4d0c8370386b 100644
--- a/drivers/net/ethernet/intel/libie/fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -1049,6 +1049,10 @@ void libie_fwlog_deinit(struct libie_fwlog *fwlog)
 {
 	int status;
 
+	/* if FW logging isn't supported it means no configuration was done */
+	if (!libie_fwlog_supported(fwlog))
+		return;
+
 	/* make sure FW logging is disabled to not put the FW in a weird state
 	 * for the next driver load
 	 */
-- 
2.47.1


