Return-Path: <netdev+bounces-237292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECC7C48817
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99AB44EDAA3
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25536327787;
	Mon, 10 Nov 2025 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jfol6QOm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62512326D55
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798525; cv=none; b=gOnzc5iocGWy3Y0eifH8tz6R0Nlfeh3tr336pxPQ1r9YaN5sn7a2xPpH+QTkzMG3ZVHB94F8g4giIlOVzSz/rt2AROXGJl2tC0zG2u7X9rJhQ0Im92a3a105AHLh83SlGt4JOcH1+FUrD/2FiknmhoEudyQvRm81w0hNAQrUVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798525; c=relaxed/simple;
	bh=ZcG6etlUmAxtrygkrGXXAEDFPwEwT7oT7TuLRNXMsJo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mhE/lTDLKMt7JQ98qepwzQePALIOcuW0MeBBfhIJ4BjCITMzK+EoERLXroxQVCWov8pQvsV4avLXoi2LFi54mYL3fqKWT5SAvyiYXBR7NMql3yrK3Grj43ZMwN3usGa4E+bUvi4iTWBRb75gd0ACNDnZIidTtN1wLMTaAKmhbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jfol6QOm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762798523; x=1794334523;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZcG6etlUmAxtrygkrGXXAEDFPwEwT7oT7TuLRNXMsJo=;
  b=Jfol6QOmar2hDySDsO6fM1RZevEUTNg70BkJOf8WOU8XL3hap2kI5oFL
   yit9891XswH39Ulp3pg0K+WqFZgk5VolJ8QZQPB+Tkuim21viFWwdLhXZ
   /6e4Xh2v9jvhTntnc3RFeIylQPsAyQvxzXhKp0W6uU/9Evb3WTPX8ThgJ
   ov0Ii6NMh2scdLelG+P/0q95LjhTlOsYhEiPVkIN+s4AHRP3UzvMjol7F
   jO2ztoGhKO7WT3GShHCuIbhC1fvMRystvgAlxDvLEHnO9uRBowXcvT9Jx
   cdUSQ59RqCeVJQ3Y4XH/y+p8SpiDqXGx+haFdfpj/q6WhExTiXlmyyMCF
   Q==;
X-CSE-ConnectionGUID: bc2SiiXKSE+/PP+0/ADL+g==
X-CSE-MsgGUID: AU7gyfKPQAqd6oMZYwfJJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="87485211"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="87485211"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:15:21 -0800
X-CSE-ConnectionGUID: kDROKgB/Qk6HQ03TxUqxJA==
X-CSE-MsgGUID: AdDmsryzRkGE5lGvLEgczA==
X-ExtLoop1: 1
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2025 10:15:21 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net 3/4] idpf: fix memory leak in idpf_vport_rel()
Date: Mon, 10 Nov 2025 10:08:22 -0800
Message-Id: <20251110180823.18008-4-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251110180823.18008-1-emil.s.tantilov@intel.com>
References: <20251110180823.18008-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

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
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 8c7c3e6bccc7..8c3041f00cda 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1105,6 +1105,8 @@ static void idpf_vport_rel(struct idpf_vport *vport)
 		kfree(adapter->vport_config[idx]->req_qs_chunks);
 		adapter->vport_config[idx]->req_qs_chunks = NULL;
 	}
+	kfree(vport->rx_ptype_lkup);
+	vport->rx_ptype_lkup = NULL;
 	kfree(vport);
 	adapter->num_alloc_vports--;
 }
-- 
2.37.3


