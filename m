Return-Path: <netdev+bounces-247504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA16CFB6CD
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EEAA30365B7
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103CD224F3;
	Wed,  7 Jan 2026 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKg1IG4Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708EFDDAB
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744417; cv=none; b=GgmUPAGpEixDDDLNbtVxmRdGxLQXrsBDwEGeYLDDIMHDlDXLw7IhPQ2Db/RH1hSzhhWpcRSX1NC0zY3SoPZ7evhnstN9tfkyKs1mRs+Wq/OJJKzOoLm+d4LmqUzx7dMbSpthtLlleAYRZpBmlwgY89ZPLclmwLDbGLRTvHlEtX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744417; c=relaxed/simple;
	bh=4NZP29bqbnddAcfRO3PhABzhnEG0IKNwUrBlL1mwzVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W/PgLYCDOJG4yM5op8vO/9x3Wnmp3L9yVKzcQe0MnZuh4iyyx5C4xXrWkaa4PO7VbTxNlb1zDpDNTSel17DaFJH42bLmB1zc6kzmUTnzpEEOtdd2wBywyVb0g4wwoZG2Za10W4eLX27i4Qf2S/+ZFn+6k6axIblDnIqpr4yAZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKg1IG4Y; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744417; x=1799280417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4NZP29bqbnddAcfRO3PhABzhnEG0IKNwUrBlL1mwzVM=;
  b=FKg1IG4Yvzb6eX+AaTCYJlkYHvP2DQLhJlGXEEHYTGmoI1V715xDgn1Z
   WLgWiJ23qfAV5eypdSq2aLb78FD9Yp9YgnQ7k/1Z9uvXGItb5qRRt6zw7
   ZyOt5cW5iXv5Y9fJGA7qcEXS11qXd9UGGvt4hF6/zCmf1oNXF6VBo7abx
   tYqdxzXOgbJkzht1xdtBoOB0BRFhwNFfHCRaVRxpsY7d4trgAQxoM0zPD
   BYdA6C5TKKeykeHB5vZfZ22ZmvfeEtCd1/VqriGVW0+BchfF344k1sLZp
   oUjojTWzMoVTbDx+cyrfGn2EGztTNHWut2CzExK5j7a2foHKE0H4dV+j9
   A==;
X-CSE-ConnectionGUID: 2Ba04VI6TI6KXL4XC38akg==
X-CSE-MsgGUID: Z5NE6v+vSm2lrqCrGJNlCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161629"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161629"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:54 -0800
X-CSE-ConnectionGUID: RbjiRxQkQmi6o/Y4Hf35IA==
X-CSE-MsgGUID: 9/5cRHOeQLKhuuG3D1V4IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841184"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 06 Jan 2026 16:06:54 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	iamvivekkumar@google.com,
	decot@google.com,
	willemb@google.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 03/13] idpf: fix memory leak in idpf_vport_rel()
Date: Tue,  6 Jan 2026 16:06:35 -0800
Message-ID: <20260107000648.1861994-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
References: <20260107000648.1861994-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Free vport->rx_ptype_lkup in idpf_vport_rel() to avoid leaking memory
during a reset. Reported by kmemleak:

unreferenced object 0xff450acac838a000 (size 4096):
  comm "kworker/u258:5", pid 7732, jiffies 4296830044
  hex dump (first 32 bytes):
    00 00 00 00 00 10 00 00 00 10 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 10 00 00 00 00 00 00  ................
  backtrace (crc 3da81902):
    __kmalloc_cache_noprof+0x469/0x7a0
    idpf_send_get_rx_ptype_msg+0x90/0x570 [idpf]
    idpf_init_task+0x1ec/0x8d0 [idpf]
    process_one_work+0x226/0x6d0
    worker_thread+0x19e/0x340
    kthread+0x10f/0x250
    ret_from_fork+0x251/0x2b0
    ret_from_fork_asm+0x1a/0x30

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a964e0f5891e..04af10cfaa8c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1082,6 +1082,8 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 		kfree(adapter->vport_config[idx]->req_qs_chunks);
 		adapter->vport_config[idx]->req_qs_chunks = NULL;
 	}
+	kfree(vport->rx_ptype_lkup);
+	vport->rx_ptype_lkup = NULL;
 	kfree(vport);
 	adapter->num_alloc_vports--;
 }
-- 
2.47.1


