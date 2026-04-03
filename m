Return-Path: <netdev+bounces-275110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QADADkfez2mn1QYAu9opvQ
	(envelope-from <netdev+bounces-275110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:35:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A61E3395CFC
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 17:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 116D5300678C
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 15:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128D734F48C;
	Fri,  3 Apr 2026 15:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRmjZZzt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0D33AF648
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775230533; cv=none; b=UlWG+o09xe4J1YsJT7OehExcDXL9uejS2NoOgIadcaTSepMhdlLgzOLESHjX5GCfq76D65/PS/ldxtVEInyTxSrPGJtlWtS8trnm1sfhhKPx1+6ZfzEwmA//zb0wK3JgGu9y5oy9Vyj1WsnqgBmQM7OcvWmpIbTvV64PpHyIB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775230533; c=relaxed/simple;
	bh=m6upnxiH1P+6zCK7Xqx4QkGQ+RwHOvo5Qald/CwjdMk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fs+WHl+utOPBxpUgLrufrqC1iIgnUV9b2y1gqIKuz4ctVMmiK14wiR1+y5z028V4UBqO2iScKValNjqZ5QcKrI5KvF0my0CToew/R1A8RpKA4E2+gN0P1nwx13n3tNpBY+39GVyqoHImG1/1riD4mbBApnOJk65nfcqYjvbRMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRmjZZzt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775230531; x=1806766531;
  h=from:to:cc:subject:date:message-id;
  bh=m6upnxiH1P+6zCK7Xqx4QkGQ+RwHOvo5Qald/CwjdMk=;
  b=gRmjZZztl/NMfkJoQ5HzVBEOXRhTtoNG64NDfC7HRhgIBfVSwu23ndQk
   KRibPd5oInXQgia7iOuMkFBr8Jj4ELjtrKV2HjM2WtervF1T1yY/25K8O
   OECRA7CTjKJgX1kCmO/A9TDMTOKh13M+HCJ4FVgQEFf66UqcVIoLnXZyy
   6vF42ppzKlkPnXK/5eX0HVgahhRgKchttPaQRgV3dJyJGS5xGSdarFqpf
   8EVYwRdt6pUjfCc87JZeKQqgV0H6wQn7IezDjjsKAAjg9mB0X/SzIC6ay
   D2RZMxwR3XW24FLMddJ3cGt0zb39p0n7EpOZ1hhMN8m8kmPa///DxQz9I
   A==;
X-CSE-ConnectionGUID: oAj0yrjHTtG51dqDnknoSw==
X-CSE-MsgGUID: 2iNRxHRXRhiSWkhgPm7aAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="87365585"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="87365585"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 08:35:30 -0700
X-CSE-ConnectionGUID: ibUhVm37TqKdk7EgYGyaZQ==
X-CSE-MsgGUID: ye/U7QWRRIK2zA/nBZh43Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="228908233"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa004.fm.intel.com with ESMTP; 03 Apr 2026 08:35:29 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	jacob.e.keller@intel.com,
	konstantin.ilichev@intel.com
Subject: [PATCH iwl-net] idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()
Date: Fri,  3 Apr 2026 08:35:38 -0700
Message-Id: <20260403153538.11516-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275110-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil.s.tantilov@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: A61E3395CFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In idpf_ptp_init(), read_dev_clk_lock is initialized after
ptp_schedule_worker() had already been called (and after
idpf_ptp_settime64() could reach the lock). The PTP aux worker
fires immediately upon scheduling and can call into
idpf_ptp_read_src_clk_reg_direct(), which takes
spin_lock(&ptp->read_dev_clk_lock) on an uninitialized lock, triggering
the lockdep "non-static key" warning:

[12973.796587] idpf 0000:83:00.0: Device HW Reset initiated
[12974.094507] INFO: trying to register non-static key.
...
[12974.097208] Call Trace:
[12974.097213]  <TASK>
[12974.097218]  dump_stack_lvl+0x93/0xe0
[12974.097234]  register_lock_class+0x4c4/0x4e0
[12974.097249]  ? __lock_acquire+0x427/0x2290
[12974.097259]  __lock_acquire+0x98/0x2290
[12974.097272]  lock_acquire+0xc6/0x310
[12974.097281]  ? idpf_ptp_read_src_clk_reg+0xb7/0x150 [idpf]
[12974.097311]  ? lockdep_hardirqs_on_prepare+0xde/0x190
[12974.097318]  ? finish_task_switch.isra.0+0xd2/0x350
[12974.097330]  ? __pfx_ptp_aux_kworker+0x10/0x10 [ptp]
[12974.097343]  _raw_spin_lock+0x30/0x40
[12974.097353]  ? idpf_ptp_read_src_clk_reg+0xb7/0x150 [idpf]
[12974.097373]  idpf_ptp_read_src_clk_reg+0xb7/0x150 [idpf]
[12974.097391]  ? kthread_worker_fn+0x88/0x3d0
[12974.097404]  ? kthread_worker_fn+0x4e/0x3d0
[12974.097411]  idpf_ptp_update_cached_phctime+0x26/0x120 [idpf]
[12974.097428]  ? _raw_spin_unlock_irq+0x28/0x50
[12974.097436]  idpf_ptp_do_aux_work+0x15/0x20 [idpf]
[12974.097454]  ptp_aux_kworker+0x20/0x40 [ptp]
[12974.097464]  kthread_worker_fn+0xd5/0x3d0
[12974.097474]  ? __pfx_kthread_worker_fn+0x10/0x10
[12974.097482]  kthread+0xf4/0x130
[12974.097489]  ? __pfx_kthread+0x10/0x10
[12974.097498]  ret_from_fork+0x32c/0x410
[12974.097512]  ? __pfx_kthread+0x10/0x10
[12974.097519]  ret_from_fork_asm+0x1a/0x30
[12974.097540]  </TASK>

Move the call to spin_lock_init() up a bit to make sure read_dev_clk_lock
is not touched before it's been initialized.

Fixes: 5cb8805d2366 ("idpf: negotiate PTP capabilities and get PTP clock")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index eec91c4f0a75..4a51d2727547 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -952,6 +952,8 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 		goto free_ptp;
 	}
 
+	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
+
 	err = idpf_ptp_create_clock(adapter);
 	if (err)
 		goto free_ptp;
@@ -977,8 +979,6 @@ int idpf_ptp_init(struct idpf_adapter *adapter)
 			goto remove_clock;
 	}
 
-	spin_lock_init(&adapter->ptp->read_dev_clk_lock);
-
 	pci_dbg(adapter->pdev, "PTP init successful\n");
 
 	return 0;
-- 
2.37.3


