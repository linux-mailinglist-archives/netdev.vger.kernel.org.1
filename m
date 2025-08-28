Return-Path: <netdev+bounces-217689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEB1B398EE
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9803A5571
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 09:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FC5303CBD;
	Thu, 28 Aug 2025 09:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG6TxDTl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075A83009FA;
	Thu, 28 Aug 2025 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375079; cv=none; b=PV8zlhKk+EwJs7q9khKx/YJs+FUKCj0rVa3Q3xt8NsYkjYe+/eJS9He/RkSv2nv6ESO2T9Rgq3Q77DuyZybdmJDac1vNWTPdjGCmLYChIHpAV3XZWPtnQhrZSwT8rpTmwpBfBW3M9I2VCco/ASH5Z1NVYaiHmeyz4dNz3hYHWaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375079; c=relaxed/simple;
	bh=CjZSl/MD9z8aqTndBAzCVVBnt/OFES9kThtlsbgXlko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WeFqxpYVOlY/1t7EWtd3BRSjFCBGmTzyiYjSsACrPyjpulMiyuZrDxjcYVeZ9QudU3Phzefbi6hMraGPHc705FUubyT4PJP5Gr1mr7R0B0sciUo9uNSqxp/h+mlT+hmNQhiqXXHaBj94WAwFJFgledEY7/bEeEo6b2XiTrfhsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG6TxDTl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756375078; x=1787911078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CjZSl/MD9z8aqTndBAzCVVBnt/OFES9kThtlsbgXlko=;
  b=MG6TxDTlxaiF58Ut3xlGo/DENaWV9IEa03lc4e/kQ0vMpN9eSbzgyB9R
   emxjK0cBwaXi93krCrwyJPh8gt84/nFYfBkLw5Fh/eeLy4vElsHqmJ7ke
   raPDUsxynUHXnGdoaamy3T+SWj1UITD3AtSiXxhP1Rp6xmySc60d9KfjA
   7/tNpJXVWvZVm3YAhRrFPzanw4ChDudyKXMlrqGikhgNctvg6yl7a2QfT
   QXGOLQC7iOXmfBL1YYENB6VE1vfwW3db7ElEkMq6fzTMncbls5XWEIqIT
   JG0PJLwT4gJA651G5yCBoE+6PpInRqJUTk0+H4CJQS5A8Yv+nbSt6buaj
   Q==;
X-CSE-ConnectionGUID: ls10JpxpSfqndw5hTLIOlw==
X-CSE-MsgGUID: 9LdNEzRWRRGyh1z+Ebb7zA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69735035"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="69735035"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 02:57:58 -0700
X-CSE-ConnectionGUID: vO4WZI5bQMWRfFIe5VHVGg==
X-CSE-MsgGUID: 0L4OwTkUSDSJ1u7xf/DO2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170467412"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by fmviesa009.fm.intel.com with ESMTP; 28 Aug 2025 02:57:55 -0700
From: Konrad Leszczynski <konrad.leszczynski@intel.com>
To: davem@davemloft.net,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cezary.rojewski@intel.com,
	sebastian.basierski@intel.com,
	Piotr Warpechowski <piotr.warpechowski@intel.com>,
	Konrad Leszczynski <konrad.leszczynski@intel.com>
Subject: [PATCH net 2/3] net: stmmac: correct Tx descriptors debugfs prints
Date: Thu, 28 Aug 2025 12:02:36 +0200
Message-Id: <20250828100237.4076570-3-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
References: <20250828100237.4076570-1-konrad.leszczynski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Piotr Warpechowski <piotr.warpechowski@intel.com>

It was observed that extended descriptors are not printed out fully and
enhanced descriptors are completely omitted in stmmac_rings_status_show().

Correct printing according to documentation and other existing prints in
the driver.

Fixes: 79a4f4dfa69a8379 ("net: stmmac: reduce dma ring display code duplication")
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
Signed-off-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 7b16d1207b80..70c3dd88a749 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6351,14 +6351,25 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
 	desc_size = extend_desc ? sizeof(*ep) : sizeof(*p);
 	for (i = 0; i < size; i++) {
 		dma_addr = dma_phy_addr + i * desc_size;
-		seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
-				i, &dma_addr,
-				le32_to_cpu(p->des0), le32_to_cpu(p->des1),
-				le32_to_cpu(p->des2), le32_to_cpu(p->des3));
-		if (extend_desc)
-			p = &(++ep)->basic;
-		else
+		if (extend_desc) {
+			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+				   i, &dma_addr,
+				   le32_to_cpu(ep->basic.des0),
+				   le32_to_cpu(ep->basic.des1),
+				   le32_to_cpu(ep->basic.des2),
+				   le32_to_cpu(ep->basic.des3),
+				   le32_to_cpu(ep->des4),
+				   le32_to_cpu(ep->des5),
+				   le32_to_cpu(ep->des6),
+				   le32_to_cpu(ep->des7));
+			ep++;
+		} else {
+			seq_printf(seq, "%d [%pad]: 0x%x 0x%x 0x%x 0x%x\n",
+				   i, &dma_addr,
+				   le32_to_cpu(p->des0), le32_to_cpu(p->des1),
+				   le32_to_cpu(p->des2), le32_to_cpu(p->des3));
 			p++;
+		}
 	}
 }
 
@@ -6398,7 +6409,11 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "Extended descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_etx,
 					   priv->dma_conf.dma_tx_size, 1, seq, tx_q->dma_tx_phy);
-		} else if (!(tx_q->tbs & STMMAC_TBS_AVAIL)) {
+		} else if (tx_q->tbs & STMMAC_TBS_AVAIL) {
+			seq_printf(seq, "Enhanced descriptor ring:\n");
+			sysfs_display_ring((void *)tx_q->dma_entx,
+					   priv->dma_conf.dma_tx_size, 1, seq, tx_q->dma_tx_phy);
+		} else {
 			seq_printf(seq, "Descriptor ring:\n");
 			sysfs_display_ring((void *)tx_q->dma_tx,
 					   priv->dma_conf.dma_tx_size, 0, seq, tx_q->dma_tx_phy);
-- 
2.34.1


