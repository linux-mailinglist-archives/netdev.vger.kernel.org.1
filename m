Return-Path: <netdev+bounces-276549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CU5O/tV1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:19:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E0E3BCBC8
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ED43300EA91
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175FC3CCFD3;
	Wed,  8 Apr 2026 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I4tshtdz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599A3CCFB7
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 13:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653951; cv=none; b=fyoeOUY2O7HFE9ykmZe4kXvsjqXlUTLFTdgEVh52WOUWL/eHu0GfZEwT0HgP6EOKOrAHI0cAqhkCTmBNbYSlt7f0SXf2V6EtNmzNFtE/WYw56+VhyMv5KumScPmpBg5Tr9sQUJEsVF4gPBd/6ZVPE1zg2KhsQJPRCjjLdLL5lQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653951; c=relaxed/simple;
	bh=K/cZlAHeWG54SXemvsMzndeB7VbEIshlUtv2sGqdCik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hTSGNVxwTLqVdp2bxYopcJyErTKI3tQhifILS2rXpN7m0Mn9aS6wyW/lMRiaoq/zuHJWm+0N5JZ+Fp3XxOeEbIlDxfiEHzzhkPte448FSPV09sqwQ7OrRpynauW33b2flgXOxlr4dFPYCy8OGgKvZUVIWPn61S8EcRM/Jgg2MVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I4tshtdz; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775653950; x=1807189950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K/cZlAHeWG54SXemvsMzndeB7VbEIshlUtv2sGqdCik=;
  b=I4tshtdzZHDdPHDknjG2H4e9o8GK+PI0toQC1LsmwBPEZe9sY1XgJPse
   3Ha9j6CbDkBpdkHdZB/FgoTJ/c4kbyK7jCgcJPTKTIfP+2XKloXUlcUrP
   7Xd56091HtSa9qvDA9LOxfoxHNPLl8quH+K6UDYwlfg/tWuG/qHRlwi9I
   nLbozy+JuJeNZK+Qbz/+rMlCXyvANOfsfZHLCq5Ty5Cz+eDRhDjdi9zbd
   9u0W0u4AwahtC55Op8KmcybMmOq8VBTN/OjZiy5l/yMarUeQ3pF1x1g/D
   K8sSmjIsQHg6vE8xOUUedQPif7j/vp4IlpEMrG5dUBwv6kc82HD7ZgOqX
   w==;
X-CSE-ConnectionGUID: QukKJMygTBGq0KpXm0YaIA==
X-CSE-MsgGUID: sY+97h9QSOW6cv0+teejHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="102087293"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="102087293"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 06:12:29 -0700
X-CSE-ConnectionGUID: h48jsidKQoqks8MOKZ6mcA==
X-CSE-MsgGUID: cREK8HQZRy+6gxdS8cwHug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; 
   d="scan'208";a="228715113"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 08 Apr 2026 06:12:28 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 7/8] ixgbe: use GFP_KERNEL in ixgbe_fcoe_ddp_setup()
Date: Wed,  8 Apr 2026 15:12:15 +0200
Message-ID: <20260408131216.2662245-8-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
References: <20260408131216.2662245-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276549-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 93E0E3BCBC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

ixgbe_fcoe_ddp_setup() is always called from process context (FCoE
offload setup paths) and never from an atomic context.  Using GFP_ATOMIC
is therefore unnecessarily restrictive and wastes memory allocator
headroom reserved for genuine atomic callers.

The previous attempt to change this to GFP_KERNEL placed the allocation
inside the get_cpu()/put_cpu() section, which disables preemption.
GFP_KERNEL can sleep under direct reclaim regardless of whether the
caller is in process context, which triggers a BUG() with preemption
disabled.

Restructure the function to split the get_cpu()/put_cpu() usage into
two narrow critical sections:

1. A short initial section that reads the per-CPU pool pointer and
   validates it, then immediately calls put_cpu() before any allocation.
   The pool pointer is saved in a local variable for use after the pin
   is dropped.

2. A second section after the allocation that re-pins the CPU solely to
   update per-CPU counters (noddp, noddp_ext_buff) inside the SG loop.

The DMA mapping and pool allocation sit between these two sections with
preemption enabled, making GFP_KERNEL safe.  The pool pointer saved
from section 1 remains valid because per-CPU DMA pools are only
destroyed during interface teardown under RTNL, not during normal
operation.

Suggested-by: Sebastian Basierski <sebastianx.basierski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
v1 -> v2:
 - Move dma_pool_alloc() outside the get_cpu()/put_cpu() section;
   split into two narrow preempt-off regions so GFP_KERNEL is safe.

 drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c | 51 +++++++++++---------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
index 011fda9..064ad17 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fcoe.c
@@ -139,6 +139,7 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	struct ixgbe_fcoe *fcoe;
 	struct ixgbe_fcoe_ddp *ddp;
 	struct ixgbe_fcoe_ddp_pool *ddp_pool;
+	struct dma_pool *pool;
 	struct scatterlist *sg;
 	unsigned int i, j, dmacount;
 	unsigned int len;
@@ -179,29 +180,43 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 		return 0;
 	}
 
+	/* Pin to current CPU only to read the per-CPU pool pointer; drop
+	 * the pin before any allocations that may sleep under direct reclaim.
+	 */
 	ddp_pool = per_cpu_ptr(fcoe->ddp_pool, get_cpu());
 	if (!ddp_pool->pool) {
 		e_warn(drv, "xid=0x%x no ddp pool for fcoe\n", xid);
-		goto out_noddp;
+		put_cpu();
+		return 0;
 	}
+	pool = ddp_pool->pool;
+	put_cpu();
 
 	/* setup dma from scsi command sgl */
 	dmacount = dma_map_sg(&adapter->pdev->dev, sgl, sgc, DMA_FROM_DEVICE);
 	if (dmacount == 0) {
 		e_err(drv, "xid 0x%x DMA map error\n", xid);
-		goto out_noddp;
+		return 0;
 	}
 
-	/* alloc the udl from per cpu ddp pool */
-	ddp->udl = dma_pool_alloc(ddp_pool->pool, GFP_ATOMIC, &ddp->udp);
+	/* Allocate from per-CPU pool; GFP_KERNEL is safe: preemption is
+	 * re-enabled after the put_cpu() above.  Per-CPU DMA pools are only
+	 * destroyed under RTNL during interface teardown, so the saved pool
+	 * pointer remains valid.
+	 */
+	ddp->udl = dma_pool_alloc(pool, GFP_KERNEL, &ddp->udp);
 	if (!ddp->udl) {
 		e_err(drv, "failed allocated ddp context\n");
-		goto out_noddp_unmap;
+		dma_unmap_sg(&adapter->pdev->dev, sgl, sgc, DMA_FROM_DEVICE);
+		return 0;
 	}
-	ddp->pool = ddp_pool->pool;
+	ddp->pool = pool;
 	ddp->sgl = sgl;
 	ddp->sgc = sgc;
 
+	/* Re-pin CPU for per-CPU statistics updates inside the SG loop. */
+	ddp_pool = per_cpu_ptr(fcoe->ddp_pool, get_cpu());
+
 	j = 0;
 	for_each_sg(sgl, sg, dmacount, i) {
 		addr = sg_dma_address(sg);
@@ -210,7 +225,8 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 			/* max number of buffers allowed in one DDP context */
 			if (j >= IXGBE_BUFFCNT_MAX) {
 				ddp_pool->noddp++;
-				goto out_noddp_free;
+				put_cpu();
+				goto out_noddp_free_unmap;
 			}
 
 			/* get the offset of length of current buffer */
@@ -220,16 +236,20 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 			 * all but the 1st buffer (j == 0)
 			 * must be aligned on bufflen
 			 */
-			if ((j != 0) && (thisoff))
-				goto out_noddp_free;
+			if (j != 0 && thisoff) {
+				put_cpu();
+				goto out_noddp_free_unmap;
+			}
 			/*
 			 * all but the last buffer
 			 * ((i == (dmacount - 1)) && (thislen == len))
 			 * must end at bufflen
 			 */
-			if (((i != (dmacount - 1)) || (thislen != len))
-			    && ((thislen + thisoff) != bufflen))
-				goto out_noddp_free;
+			if ((i != (dmacount - 1) || thislen != len) &&
+			    (thislen + thisoff) != bufflen) {
+				put_cpu();
+				goto out_noddp_free_unmap;
+			}
 
 			ddp->udl[j] = (u64)(addr - thisoff);
 			/* only the first buffer may have none-zero offset */
@@ -250,14 +270,15 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 	if (lastsize == bufflen) {
 		if (j >= IXGBE_BUFFCNT_MAX) {
 			ddp_pool->noddp_ext_buff++;
-			goto out_noddp_free;
+			put_cpu();
+			goto out_noddp_free_unmap;
 		}
 
 		ddp->udl[j] = (u64)(fcoe->extra_ddp_buffer_dma);
 		j++;
 		lastsize = 1;
 	}
 	put_cpu();
 
 	fcbuff = (IXGBE_FCBUFF_4KB << IXGBE_FCBUFF_BUFFSIZE_SHIFT);
 	fcbuff |= ((j & 0xff) << IXGBE_FCBUFF_BUFFCNT_SHIFT);
@@ -316,14 +337,10 @@ static int ixgbe_fcoe_ddp_setup(struct net_device *netdev, u16 xid,
 
 	return 1;
 
-out_noddp_free:
+out_noddp_free_unmap:
 	dma_pool_free(ddp->pool, ddp->udl, ddp->udp);
 	ixgbe_fcoe_clear_ddp(ddp);
-
-out_noddp_unmap:
 	dma_unmap_sg(&adapter->pdev->dev, sgl, sgc, DMA_FROM_DEVICE);
-out_noddp:
-	put_cpu();
 	return 0;
 }
 
-- 
2.52.0

