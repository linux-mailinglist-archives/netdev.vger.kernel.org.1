Return-Path: <netdev+bounces-245239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1FCCC9718
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 20:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E445530985EB
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 19:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE482F6560;
	Wed, 17 Dec 2025 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BI3jqVIw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE7214A8B
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001008; cv=none; b=mnWu7xi7rMVi6bjyZXelZEMXGkBKFVvkMB0aTvPuyFkNUHD42VP4XRZpKM2JEDrUPOPgwaDe0HNe4GbIFYhRe0rG8vutwXmdDKJOQVr4u8Fg+tz54yLrXAPfjeLESRIhsPw1IpZ1EwB/Ahrql3TVQAr7L7ibQf9/6a/JbJXmBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001008; c=relaxed/simple;
	bh=Gl2coxkLVN0Eesn37qvVYmZ6bebuXEMa3q6zw0NUA4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUmSDdEUnEvLM6pj8m6LUJLMzh07XkZipTJH+RwmlD7ClSwa90gCZr29S47rqUYCnNQBPaQUufWFz78caKvqLG0opIOzMfsFU1MbpSfXbVcq3FI87oF1L7YFn+Q+yXyJLev2/JVlTsHJjQMJyBg1/9PVgIrmURDVF2bLrBdeVs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BI3jqVIw; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766001007; x=1797537007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gl2coxkLVN0Eesn37qvVYmZ6bebuXEMa3q6zw0NUA4c=;
  b=BI3jqVIwNZv9ASzi1Jb1HZJZ1xhgiABAInl7y/kW11US6KtJiK//XI3m
   tnN0ZGp2on/93J574v9I8/KdGlinb7hbq91uZuXbWE5PY2a8kMsFVXDab
   pH877MrsV40lNffeN0BFCOyZCXuG5LinVnDYqHnAVyagjA8EsTs21otb3
   vu2Ev5Tl/yunEwx2332Zzpf2W0y0m+9kDsBz8E5K28tXeZmlVvXINE3z0
   vL6kFRyq2UA0EdG3G8APiRaukveGOPct0FbESfVs/ccc/wSFlktJAOP9D
   uLrWzGkHNxP7D+ikxYXr+ghlwE5Ct/yyQMcPXrDI3u6lsAiDl2JjHeiwt
   g==;
X-CSE-ConnectionGUID: axy/QyC0TImcZK7truWVqg==
X-CSE-MsgGUID: 05iGdhDzSk+wissHK1AmPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="67841433"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="67841433"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 11:50:02 -0800
X-CSE-ConnectionGUID: aR1Tq3D+RfGu0x34P2Zb2A==
X-CSE-MsgGUID: GnQ8MeGzR0C+3GIvPY+UXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202898043"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 17 Dec 2025 11:50:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Kohei Enju <enjuk@amazon.com>,
	anthony.l.nguyen@intel.com,
	kohei.enju@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 3/6] iavf: fix off-by-one issues in iavf_config_rss_reg()
Date: Wed, 17 Dec 2025 11:49:42 -0800
Message-ID: <20251217194947.2992495-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
References: <20251217194947.2992495-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kohei Enju <enjuk@amazon.com>

There are off-by-one bugs when configuring RSS hash key and lookup
table, causing out-of-bounds reads to memory [1] and out-of-bounds
writes to device registers.

Before commit 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS"),
the loop upper bounds were:
    i <= I40E_VFQF_{HKEY,HLUT}_MAX_INDEX
which is safe since the value is the last valid index.

That commit changed the bounds to:
    i <= adapter->rss_{key,lut}_size / 4
where `rss_{key,lut}_size / 4` is the number of dwords, so the last
valid index is `(rss_{key,lut}_size / 4) - 1`. Therefore, using `<=`
accesses one element past the end.

Fix the issues by using `<` instead of `<=`, ensuring we do not exceed
the bounds.

[1] KASAN splat about rss_key_size off-by-one
  BUG: KASAN: slab-out-of-bounds in iavf_config_rss+0x619/0x800
  Read of size 4 at addr ffff888102c50134 by task kworker/u8:6/63

  CPU: 0 UID: 0 PID: 63 Comm: kworker/u8:6 Not tainted 6.18.0-rc2-enjuk-tnguy-00378-g3005f5b77652-dirty #156 PREEMPT(voluntary)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: iavf iavf_watchdog_task
  Call Trace:
   <TASK>
   dump_stack_lvl+0x6f/0xb0
   print_report+0x170/0x4f3
   kasan_report+0xe1/0x1a0
   iavf_config_rss+0x619/0x800
   iavf_watchdog_task+0x2be7/0x3230
   process_one_work+0x7fd/0x1420
   worker_thread+0x4d1/0xd40
   kthread+0x344/0x660
   ret_from_fork+0x249/0x320
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 63:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   __kmalloc_noprof+0x246/0x6f0
   iavf_watchdog_task+0x28fc/0x3230
   process_one_work+0x7fd/0x1420
   worker_thread+0x4d1/0xd40
   kthread+0x344/0x660
   ret_from_fork+0x249/0x320
   ret_from_fork_asm+0x1a/0x30

  The buggy address belongs to the object at ffff888102c50100
   which belongs to the cache kmalloc-64 of size 64
  The buggy address is located 0 bytes to the right of
   allocated 52-byte region [ffff888102c50100, ffff888102c50134)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102c50
  flags: 0x200000000000000(node=0|zone=2)
  page_type: f5(slab)
  raw: 0200000000000000 ffff8881000418c0 dead000000000122 0000000000000000
  raw: 0000000000000000 0000000080200020 00000000f5000000 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff888102c50000: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
   ffff888102c50080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
  >ffff888102c50100: 00 00 00 00 00 00 04 fc fc fc fc fc fc fc fc fc
                                       ^
   ffff888102c50180: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
   ffff888102c50200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc

Fixes: 43a3d9ba34c9 ("i40evf: Allow PF driver to configure RSS")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index c2fbe443ef85..4b0fc8f354bc 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1726,11 +1726,11 @@ static int iavf_config_rss_reg(struct iavf_adapter *adapter)
 	u16 i;
 
 	dw = (u32 *)adapter->rss_key;
-	for (i = 0; i <= adapter->rss_key_size / 4; i++)
+	for (i = 0; i < adapter->rss_key_size / 4; i++)
 		wr32(hw, IAVF_VFQF_HKEY(i), dw[i]);
 
 	dw = (u32 *)adapter->rss_lut;
-	for (i = 0; i <= adapter->rss_lut_size / 4; i++)
+	for (i = 0; i < adapter->rss_lut_size / 4; i++)
 		wr32(hw, IAVF_VFQF_HLUT(i), dw[i]);
 
 	iavf_flush(hw);
-- 
2.47.1


