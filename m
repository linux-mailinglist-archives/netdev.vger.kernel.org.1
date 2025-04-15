Return-Path: <netdev+bounces-182581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E513CA89313
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 06:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD701895F1B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0483266568;
	Tue, 15 Apr 2025 04:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OMYTjDLL"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CAD4594A;
	Tue, 15 Apr 2025 04:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744692525; cv=none; b=E9UpZkwHOmxODUrV0j2fcJ2Y6N3o7r7RFajr4Vn5uuUgx5a/khzPs7hf9ldwQ+XXdyjMN+LdJKca2GW1/xnNP9yN9WoNPNw+0gwTx54aYlVjq16acAdOKFxbn6FGUByWSh96Ka5j+5eQK0xqWGHvSMM/r8DxCLP6w0Tqn2frGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744692525; c=relaxed/simple;
	bh=KxDYJ8JiwXrbu5/VrTiMOujSwfWDcrpNL34/Lrrtn9A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jF7VB+06lFDKQ2w2KomjKMp5sYrK7RuZKcNgevcdlWUTtY/QfWIkShvzgEPtpX9EY3MQgyQVvZtyZ82rPIC5FkKZow04QDHGoPFxfGatJf1/aMSZjXSnzxlQYeJScS0kY2KzQEbP63YDIVvUgjDrCMzsENRa+qAUWQHqJ+UFrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OMYTjDLL; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744692523; x=1776228523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KxDYJ8JiwXrbu5/VrTiMOujSwfWDcrpNL34/Lrrtn9A=;
  b=OMYTjDLLE2EzMnhQQgoto+c1+feukKLzlu7lbrNkHYV23ISDGEpiRQbr
   ApSRIO3VPTxKcutCg2etm+uvZyYT4iRNS2EO2+wiXbAxt9tohGPQ+4Xo9
   JB+Whcw7aERzTIL6X/d7ccu8XJfCQ61Tga7Vv36bAXswg5TwCjOc9lo/F
   cPG70nAQp88B6Kb0oejTfSb5bsJb4q+AGmyE+hxMcv/3bej7/uIWrMD+y
   7IPal2qylsDl4epXX60rmuLt6F57Hy0MZCcuiT6XhRyXPZLnJdqqW+9aH
   rnibAb+ffcr6DMvWAIJp2013RiitSRp4D0g1sc+kYhyCWByZXKMxzuMwT
   Q==;
X-CSE-ConnectionGUID: cK7Y7DXISQ+lEDvmSk7tAA==
X-CSE-MsgGUID: xAL9W8I6Rh+ilYS0qvATug==
X-IronPort-AV: E=Sophos;i="6.15,213,1739862000"; 
   d="scan'208";a="207985970"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Apr 2025 21:48:42 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 14 Apr 2025 21:48:20 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Mon, 14 Apr 2025 21:48:17 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v3] net: lan743x: Allocate rings outside ZONE_DMA
Date: Tue, 15 Apr 2025 10:15:09 +0530
Message-ID: <20250415044509.6695-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The driver allocates ring elements using GFP_DMA flags. There is
no dependency from LAN743x hardware on memory allocation should be
in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC. This
is consistent with other callers of lan743x_rx_init_ring_element().

Reported-by: Zhang, Liyin(CN) <Liyin.Zhang.CN@windriver.com>
Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
v0
-Initial Commit

v1
-Modified GFP flags from GFP_KERNEL to GFP_ATOMIC

v2
-resubmit to net-next

v3
-Shortened prefix and updated commit message
---
 drivers/net/ethernet/microchip/lan743x_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 23760b613d3e..8b6b9b6efe18 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2495,8 +2495,7 @@ static int lan743x_rx_process_buffer(struct lan743x_rx *rx)
 
 	/* save existing skb, allocate new skb and map to dma */
 	skb = buffer_info->skb;
-	if (lan743x_rx_init_ring_element(rx, rx->last_head,
-					 GFP_ATOMIC | GFP_DMA)) {
+	if (lan743x_rx_init_ring_element(rx, rx->last_head, GFP_ATOMIC)) {
 		/* failed to allocate next skb.
 		 * Memory is very low.
 		 * Drop this packet and reuse buffer.
-- 
2.25.1


