Return-Path: <netdev+bounces-247505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C1DCFB6D0
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 242FE305E3C2
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330972623;
	Wed,  7 Jan 2026 00:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2JEWwOr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE81156CA
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767744418; cv=none; b=Ag7744WTz6RJNpyR5l1OLm0hMvaLEpoZD4AEclOf/6zQN/TjrIDKkK7QN8N/vKq8Yp15biZZMj5Fm6yn54Zvps2OMEr1ucNxlLx9z4QKxWemLMw7+2gn8HOmP65W9RVj7DUPEkmkByhF+ijA566VEGhLuS3ZHm9fQrBRF2YeHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767744418; c=relaxed/simple;
	bh=S75QM6is21ytQBizK1/zY77OLc695DGnwry4N258bvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtQ672vtZEu/XCpNPVBbV9CwV+GM53zIU8gI/ql0q3TryVv8PVotE7vaReOaVXiYn+Htcqpf+xp7Cs5Z0dNdJ8JUrlQCjGCMLBQfJwtuNpwXP4z47EkKfhi/v0Qqzkht1rdntqopEiul9Uu+PkNKnlDxYpm0xXw+MAnDkRSQD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2JEWwOr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767744418; x=1799280418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S75QM6is21ytQBizK1/zY77OLc695DGnwry4N258bvQ=;
  b=X2JEWwOrNTp11etWJu4mbdD4gpfjWlCXej+2s9JBgDqVa3gXl+sKDt2f
   rMHqa5fojKTRNh6aNOFynNONLMceEeb2Fy9NerBdra3ZvJPdYvp2UheuC
   NRwxewaCXL0AI/vaYiNPsoweriVZwq+xDS0o+oiCDNlisM6WWIQ535pzR
   mI6vMIOyBFptAxD0Ml4gNXyX6PRmzRrcr00jVUmxz3LNNvBskDCKySLQ7
   whrdkADfuzyV9NK4r8Ke4X8QDZuh52s27sPkCNGOaGYix3g7vNlzZH9Rl
   /vpbz6+frcssWqsJKZ5Ncr7r6fHUZ0S5+yePhdivFpPuwkM3c5qb3P4/8
   Q==;
X-CSE-ConnectionGUID: K+LV866tTLWvGxcNilqdIg==
X-CSE-MsgGUID: dLW3ZkBTR82U10RytMQmaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69161634"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="69161634"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 16:06:54 -0800
X-CSE-ConnectionGUID: dpMmNZPISw603SMrkQCtnA==
X-CSE-MsgGUID: IwoS502QRSCCG7/1BDSutg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207841187"
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
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	larysa.zaremba@intel.com,
	aleksander.lobakin@intel.com,
	iamvivekkumar@google.com,
	decot@google.com,
	willemb@google.com,
	tatyana.e.nikolova@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 04/13] idpf: fix memory leak in idpf_vc_core_deinit()
Date: Tue,  6 Jan 2026 16:06:36 -0800
Message-ID: <20260107000648.1861994-5-anthony.l.nguyen@intel.com>
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

Make sure to free hw->lan_regs. Reported by kmemleak during reset:

unreferenced object 0xff1b913d02a936c0 (size 96):
  comm "kworker/u258:14", pid 2174, jiffies 4294958305
  hex dump (first 32 bytes):
    00 00 00 c0 a8 ba 2d ff 00 00 00 00 00 00 00 00  ......-.........
    00 00 40 08 00 00 00 00 00 00 25 b3 a8 ba 2d ff  ..@.......%...-.
  backtrace (crc 36063c4f):
    __kmalloc_noprof+0x48f/0x890
    idpf_vc_core_init+0x6ce/0x9b0 [idpf]
    idpf_vc_event_task+0x1fb/0x350 [idpf]
    process_one_work+0x226/0x6d0
    worker_thread+0x19e/0x340
    kthread+0x10f/0x250
    ret_from_fork+0x251/0x2b0
    ret_from_fork_asm+0x1a/0x30

Fixes: 6aa53e861c1a ("idpf: implement get LAN MMIO memory regions")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Joshua Hay <joshua.a.hay@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 5bbe7d9294c1..01bbd12a642a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3570,6 +3570,7 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
  */
 void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 {
+	struct idpf_hw *hw = &adapter->hw;
 	bool remove_in_prog;
 
 	if (!test_bit(IDPF_VC_CORE_INIT, adapter->flags))
@@ -3593,6 +3594,9 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	idpf_vport_params_buf_rel(adapter);
 
+	kfree(hw->lan_regs);
+	hw->lan_regs = NULL;
+
 	kfree(adapter->vports);
 	adapter->vports = NULL;
 
-- 
2.47.1


