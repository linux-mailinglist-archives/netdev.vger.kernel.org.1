Return-Path: <netdev+bounces-181058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C09A837BA
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659D51B62CE8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674B1F0E56;
	Thu, 10 Apr 2025 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zDdspdWO"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074571BB6BA;
	Thu, 10 Apr 2025 04:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744258457; cv=none; b=ZoG8ms0YloXGU3/pNgRlx1NJz5aZ973WQyuNeyQ7klQKcGFSGmOlt38CB3SL+CIBLVPKBLLAVRF0iCRBZOQb1bKMmOS3w4ELT669fa6kfZ/Kys/cRmz2lEJl31CrFqYwjSw+e0fLgsSs0quAP+k0og7NhvMfSUsDtsRnZJKPHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744258457; c=relaxed/simple;
	bh=0eD9VL33YeCoJeo1RYLS81d+ryBC2kaugHJfF+ygWN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSx+poYzfazwcqsv8yACLexZBqxrzBnU6IbZpUCCAj1bE6fBBJGWxscwkdwlQzvWVFVER5kV4f2fwvjabkNYobtOA3aaoU6jE2iGp/6ot/P3D9ZvVvVJ2RlmMQkGwXW3F4qivUoTmX/lFNL/ZrQz7dRSYDS9bb8Zlr/kUHnMEuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zDdspdWO; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1744258456; x=1775794456;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0eD9VL33YeCoJeo1RYLS81d+ryBC2kaugHJfF+ygWN8=;
  b=zDdspdWOKIwDimAqKgnXa/u2KsdCvT5BPRoTNydAuWiJYEx8vzuGBggq
   UB5XhofGrsMhRGtLz6FCF9JAnYOBC8eohTuE1em0BRfZ8cIyIl4QK3FH/
   Pus6UGODxbEbrlRhF0TorUUbkIzndd1+XuJLdoKI3EQKpYP1VX9isr6ie
   4PgiRgj4qnkdC80OLiQRKR2dMWX4ibh9sqsGDHef1MWw52UYENhqvHJKo
   pdjf2JQMiFqu8/AJbBcfFzGRzQrzvd2jDNe+YY8JH7lUtkfDu8e3o+0fU
   y3z94XIcMRD70SMk09X/st6pO+34Oo/IHlbTkmiO7FolAEdUG4kCBYVg2
   Q==;
X-CSE-ConnectionGUID: rOlfZuRETmefZMrPijj2jQ==
X-CSE-MsgGUID: YL4bVxb2TBKs0/Ock90PPA==
X-IronPort-AV: E=Sophos;i="6.15,202,1739862000"; 
   d="scan'208";a="40766564"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Apr 2025 21:14:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 9 Apr 2025 21:13:43 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 9 Apr 2025 21:13:40 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v2] net: ethernet: microchip: lan743x: Fix memory allocation failure
Date: Thu, 10 Apr 2025 09:40:34 +0530
Message-ID: <20250410041034.17423-1-thangaraj.s@microchip.com>
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
in DMA_ZONE. Hence modifying the flags to use only GFP_ATOMIC

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
v0
-Initial Commit

v1
-Modified GFP flags from GFP_KERNEL to GFP_ATOMIC
-added fixes tag

v2
-Resubmit net-next instead of net

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


