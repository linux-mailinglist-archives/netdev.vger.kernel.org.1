Return-Path: <netdev+bounces-258241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOnFEXNPjGmukgAAu9opvQ
	(envelope-from <netdev+bounces-258241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:44:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B582C122DC4
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 10:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5A743013736
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671F435BDB2;
	Wed, 11 Feb 2026 09:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TYudtbpD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C235B631
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770803021; cv=none; b=VfYrEnnv8otC0SNQpMwLIO1rNJ1sj+7ddh/vkIzVzg0AH952pTcSoVZ8PFyEv6VKXkt7w7T3f4LzheB5JjHhiFE+b346SK/a0JdPAwH7mL1GmkbHQWia+Ajts55C2ONtvoplijaCJd7dcSXrUkXDQ1fbZO73ofRxmnSYzYjY2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770803021; c=relaxed/simple;
	bh=3R2gvJlYg2fkGJs2L5r+sIWjeFpGyp7Xsc71mVtw76k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peWld4Wa6oJwuIq7nwhfHnJ7xYpYyNH+PRXL8VhD7glWt2u86X0zy3kqoqKq/g8hRURv2d0QWmbS/VkZxQLq1K8YOzmCCq03BeTmjaV51lqwl1+E1BVtARf87j4Y0jezMEcp8cx2NjoYbwhDAxtblZMFcpdYTmQYQ4iWVCj4Dxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TYudtbpD; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770803017; x=1802339017;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3R2gvJlYg2fkGJs2L5r+sIWjeFpGyp7Xsc71mVtw76k=;
  b=TYudtbpDvYG57mjnnPgpMNN/pEd8/QoN2m8HoHFXxbnMx0aKFp7bEQHA
   BVT7KvMoTYEHvrpameOpZbz+BKL2NndqP8Lp6w1Vykl4gX9j5S5ntPjVn
   cPadn35jgamfGMyHhgd5t9nTrDifm/f1cIwxYzlcqWiogEW3L/RHbBv/P
   bWP4D7EHDq+DchKRTmOCQGXwkmgIvIV37d+zMuASSS/qrdTHV+DbulnyX
   tEo+8qzwVDauSVUNThmHNe5XJ9tB3qdeztE8UAuVEc3WOQrdBpZdE/Z5u
   nTs1W2g52aSmmGZPQ61MK8QJ3vdPUaqsU7tyrxDp9AreclZnikeB8GdjD
   A==;
X-CSE-ConnectionGUID: G3J43xdiQn6AOq/7fcXXCw==
X-CSE-MsgGUID: NtdM7XvzQG2IncmkT4IsVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="71848060"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="71848060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2026 01:43:36 -0800
X-CSE-ConnectionGUID: 1Feq19IFQUuQkHJ/wzguJA==
X-CSE-MsgGUID: 8D3a+89OQ1SWV7f1wzmaQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="211599160"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by fmviesa010.fm.intel.com with ESMTP; 11 Feb 2026 01:43:34 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net v1] libie: don't unroll if fwlog isn't supported
Date: Wed, 11 Feb 2026 10:11:40 +0100
Message-ID: <20260211091140.236389-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258241-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B582C122DC4
X-Rspamd-Action: no action

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
---
 drivers/net/ethernet/intel/libie/fwlog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/libie/fwlog.c b/drivers/net/ethernet/intel/libie/fwlog.c
index f39cc11cb7c5..5d890d9d3c4d 100644
--- a/drivers/net/ethernet/intel/libie/fwlog.c
+++ b/drivers/net/ethernet/intel/libie/fwlog.c
@@ -1051,6 +1051,10 @@ void libie_fwlog_deinit(struct libie_fwlog *fwlog)
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
2.49.0


