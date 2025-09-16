Return-Path: <netdev+bounces-223528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CDBB5966F
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442504E623E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B91B313E01;
	Tue, 16 Sep 2025 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fphd4eqs"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA825313290;
	Tue, 16 Sep 2025 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026610; cv=none; b=QjFCK04+3ER4N6mu9AbPUFX0yNnH7Z78OQIfMRu7sNYA/okEfBIuL+0+quEZo6RdGLEBATMVB4+SyLvAWRbK3UY8WMBCmOL+keOk+olaFR0W13NGg8e0wO43wDza35M0NAIGJLHUXFJtks2w3uHV3GT90oLy+HruC7mXYa8uGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026610; c=relaxed/simple;
	bh=Wa+D4zEpH275liIM4B6G5Lb4l1qqCmqJOKkaA+4OV4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PIhpcERBSSoTF5k/Hat5ekhTN05MLzfs+ceImW/Smr6Lj43kTU7YX/PpQc6+e1TB43QST2OHlk7nNkvS9m+Px4i85moyoY2at/PZApWezjoA+FNYxkGrRSTvoTKaZVXLBF/DHYG3tIXo/+NThlqYNNezgTrspNtw3d7R2QOxCvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fphd4eqs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758026609; x=1789562609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wa+D4zEpH275liIM4B6G5Lb4l1qqCmqJOKkaA+4OV4M=;
  b=Fphd4eqshKO50e4ky5EZ4hegpYE8ejDCLLf3H/c56/+CE8OPzoy6Un+b
   V2L7IU+gC58NprEDfN5CskzjGBIhJursnS9IG8RqexZHZYiuLVBGbtFC4
   9ti9cY6OwCKGoLsmok9wT39+QxKj4D1Q+OcYleiKxgboX+6v7hAwt2oqm
   90W9YrcM6La3axaEfozJJkPHCb8I6/+SPAA/p0Rt8W0dVaDHvvdOPtbw5
   SQn71XldzfD1J8Fzu8/SHOXj664rtgi48XgDxtNi1YSXQotqmwrVRDHxC
   ji9HC5fuiEJhO9n+dJczPh+neoNEl6/wSHh+VYXG0/FhzCffWny9rbX7G
   g==;
X-CSE-ConnectionGUID: dmMGfeelRvG/cmOvrXBB5Q==
X-CSE-MsgGUID: CYxV1/T5TP6tO9pwspDF6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="85742019"
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="85742019"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 05:43:29 -0700
X-CSE-ConnectionGUID: iH7Kw7R5TCOWhS44awOe2g==
X-CSE-MsgGUID: eVLORkypQne/Xe23u3KA8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,269,1751266800"; 
   d="scan'208";a="174043191"
Received: from gklab-kleszczy-dev.igk.intel.com ([10.102.25.215])
  by orviesa006.jf.intel.com with ESMTP; 16 Sep 2025 05:43:26 -0700
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
Subject: [PATCH net-next v3 3/3] net: stmmac: correct Tx descriptors debugfs prints
Date: Tue, 16 Sep 2025 14:48:08 +0200
Message-Id: <20250916124808.218514-4-konrad.leszczynski@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916124808.218514-1-konrad.leszczynski@intel.com>
References: <20250916124808.218514-1-konrad.leszczynski@intel.com>
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

Reviewed-by: Konrad Leszczynski <konrad.leszczynski@intel.com>
Reviewed-by: Sebastian Basierski <sebastian.basierski@intel.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Piotr Warpechowski <piotr.warpechowski@intel.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4df967500cd3..38f130cb0c9f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6355,14 +6355,25 @@ static void sysfs_display_ring(void *head, int size, int extend_desc,
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
 
@@ -6402,7 +6413,11 @@ static int stmmac_rings_status_show(struct seq_file *seq, void *v)
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


