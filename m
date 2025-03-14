Return-Path: <netdev+bounces-174805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED36A60963
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 08:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3964319C1C3B
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 07:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5037156C79;
	Fri, 14 Mar 2025 07:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Nd+oXAg+"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3230117D2;
	Fri, 14 Mar 2025 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741935955; cv=none; b=LQvEO9MNKM+s2yFOvXAKZpPoX3aMhHlQvSNl5oX06iGCy3DzpiFYMmg8hzzZXxDAekKtxSwvWIhjs8mBOp/FZ6ETePIm6NrkmnCQ8P94TQwDe9YVDrMm6d6V/6us0TlP4rPeC7hQMR2jOM19B+ZvtW4jeRhtPU/g9QjjgNL83BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741935955; c=relaxed/simple;
	bh=b3WNv+AURHTHeYSP+2evjJ0mBuWMbnv0L0mj5nqpztU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g9sVAzLdKU2IFvMg3BQ043JTLLkAZZWJbaaBNWTraOiFIkMQR5maTfaElRta50c6lfap0r05N+vvPKckthKfh9jEOpnFpDFNJ1LzC7TtWMgZ/7T8fOvKKeh0jq9IShmTVkr7atE0jmL89CAE/DotsMjFoJk5dXYd24fqRwTYsJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Nd+oXAg+; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741935954; x=1773471954;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b3WNv+AURHTHeYSP+2evjJ0mBuWMbnv0L0mj5nqpztU=;
  b=Nd+oXAg+DSRyogCwZboapwzOlMe/3m0GcbJeaF9RxTGHjgm6MsLSqTtF
   tciLQMk1TWQxfYu9iR5LlPK9XXlk7693Y6HN1jjubdbt6oOaS18XoTqQw
   paHirNGpnpcWtsGh3YlqSOX4+QJdAx2m5DBGUR18rPoHhTREvVuV8DbFB
   0hi7QOie8xnbZPPkkI8kH+LL2TMfTuvoG4gQ5tNYuQjjS80ODZ+U28TXt
   Ilr4sQh/2nVoJG4q6iBfXRfjG/6X8sCsDSPddNZUXxvCIBvmBQFZqTRCs
   tTMGLgWbHq0c1QrCJed2glA0sxUioXMb6knXxxi1Bbwjp6WpCD585LyJj
   A==;
X-CSE-ConnectionGUID: /zsTpkCNSV+jU5iEveDSrw==
X-CSE-MsgGUID: oHDl3ebHRZ6krXSvcnFZOw==
X-IronPort-AV: E=Sophos;i="6.14,246,1736838000"; 
   d="scan'208";a="39478137"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Mar 2025 00:05:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 14 Mar 2025 00:05:31 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 14 Mar 2025 00:05:28 -0700
From: Thangaraj Samynathan <thangaraj.s@microchip.com>
To: <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: ethernet: microchip: lan743x: Fix memory allocation failure
Date: Fri, 14 Mar 2025 12:32:27 +0530
Message-ID: <20250314070227.24423-1-thangaraj.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The driver allocates ring elements using GFP_ATOMIC and GFP_DMA
flags. The allocation is not done in atomic context and there is
no dependency from LAN743x hardware on memory allocation should be
in DMA_ZONE. Hence modifying the flags to use only GFP_KERNEL.

Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
---
 drivers/net/ethernet/microchip/lan743x_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
index 23760b613d3e..c10b0131d5fb 100644
--- a/drivers/net/ethernet/microchip/lan743x_main.c
+++ b/drivers/net/ethernet/microchip/lan743x_main.c
@@ -2495,8 +2495,7 @@ static int lan743x_rx_process_buffer(struct lan743x_rx *rx)
 
 	/* save existing skb, allocate new skb and map to dma */
 	skb = buffer_info->skb;
-	if (lan743x_rx_init_ring_element(rx, rx->last_head,
-					 GFP_ATOMIC | GFP_DMA)) {
+	if (lan743x_rx_init_ring_element(rx, rx->last_head, GFP_KERNEL)) {
 		/* failed to allocate next skb.
 		 * Memory is very low.
 		 * Drop this packet and reuse buffer.
-- 
2.25.1


