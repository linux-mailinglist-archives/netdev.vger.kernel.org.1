Return-Path: <netdev+bounces-151747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B6F9F0C48
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B83D169851
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30E41DFD96;
	Fri, 13 Dec 2024 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ih816SSC"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092041DCB09;
	Fri, 13 Dec 2024 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734093152; cv=none; b=fLktiNXjyz/W7n5gtpmXZjOTjmRnQzJT4nlyECbBdKlNtL2txGcERBQV8zWVBNKBG84ahLcI/wYntHNrtIP2YVeRBBgAOlyIk6giL34QE44FN4taCg+TMKBrmk9baZf83TTLGWqEi/Ese2rgV0XM0L7H59fwXda26QnAl732yKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734093152; c=relaxed/simple;
	bh=Cmo6WDz3rC/L7dCSEvrpYVHvneSHBq6A6CB+GmSheiY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ia47LVIWPT73bGhHbS5b8XWOvYgCg6di2370mroDcNC9yMCQPJm8f/MbcmTubzL8jOYDxvBM5BB/akj412V7aQ/DfjdoDzN9cMe+DHMBEGN3wtTT4R7gS5JI2BjZY5PIsbwOCXvCyz8rsqaBNAvCCJAIGQIica71Iqxzn+y0HZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ih816SSC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734093150; x=1765629150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cmo6WDz3rC/L7dCSEvrpYVHvneSHBq6A6CB+GmSheiY=;
  b=Ih816SSCykOLzoYb0FwNVluj0bOgXdgqhcjB895UwPGV2dkapOaNnyLt
   IQ1epgmYvhrNm65EnOGRid3Em21ifG2FP1vOAj2s+NSpc28Pq/bkOLGpd
   mSF4xICEZNXXR81tjcgatY/JOYLboa8/fDa6jVzf5VVyYwCDl/xrDlCIQ
   K+BcFq2tj6cTWvQKwXuQ18humO+1ozUULYqzZJAN9UFINBk93dawiMCK4
   0STdLMoFqzi7M4HUGqN++GiiYnCkLWLT2sqqu2qbJOYMAwBMIuKq/kt65
   XJXTCm5tTlyB19Tv79gCwZUslN05dFWLQ1eirRWg/62pPDj4lHJ0/P4jg
   g==;
X-CSE-ConnectionGUID: T4iONzRASJC/nLtS7vBTbg==
X-CSE-MsgGUID: vmjulHARRTa/MJnIVnitFQ==
X-IronPort-AV: E=Sophos;i="6.12,231,1728975600"; 
   d="scan'208";a="35183035"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Dec 2024 05:32:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 13 Dec 2024 05:32:13 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 13 Dec 2024 05:32:10 -0700
From: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <parthiban.veerasooran@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
	<jacob.e.keller@intel.com>
Subject: [PATCH net v4 1/2] net: ethernet: oa_tc6: fix infinite loop error when tx credits becomes 0
Date: Fri, 13 Dec 2024 18:01:58 +0530
Message-ID: <20241213123159.439739-2-parthiban.veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
References: <20241213123159.439739-1-parthiban.veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

SPI thread wakes up to perform SPI transfer whenever there is an TX skb
from n/w stack or interrupt from MAC-PHY. Ethernet frame from TX skb is
transferred based on the availability tx credits in the MAC-PHY which is
reported from the previous SPI transfer. Sometimes there is a possibility
that TX skb is available to transmit but there is no tx credits from
MAC-PHY. In this case, there will not be any SPI transfer but the thread
will be running in an endless loop until tx credits available again.

So checking the availability of tx credits along with TX skb will prevent
the above infinite loop. When the tx credits available again that will be
notified through interrupt which will trigger the SPI transfer to get the
available tx credits.

Fixes: 53fbde8ab21e ("net: ethernet: oa_tc6: implement transmit path to transfer tx ethernet frames")
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index f9c0dcd965c2..4c8b0ca922b7 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -1111,8 +1111,9 @@ static int oa_tc6_spi_thread_handler(void *data)
 		/* This kthread will be waken up if there is a tx skb or mac-phy
 		 * interrupt to perform spi transfer with tx chunks.
 		 */
-		wait_event_interruptible(tc6->spi_wq, tc6->waiting_tx_skb ||
-					 tc6->int_flag ||
+		wait_event_interruptible(tc6->spi_wq, tc6->int_flag ||
+					 (tc6->waiting_tx_skb &&
+					 tc6->tx_credits) ||
 					 kthread_should_stop());
 
 		if (kthread_should_stop())
-- 
2.34.1


