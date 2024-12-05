Return-Path: <netdev+bounces-149243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27469E4E23
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 08:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5360718818C2
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 07:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A36D1A0700;
	Thu,  5 Dec 2024 07:22:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECE51B4F0F;
	Thu,  5 Dec 2024 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383334; cv=none; b=CRkRjb/OyazDupuhBybx/yPXciV2qGBCnLtVg3CkS4E/8z+pnmsactVn7sJ7JNli95Nf7KpMpv13B8yt4HWJgAXJkWSIM7xTcblNSlPhHo8yYbzizwjRC8zkQQc6k24mqRfRJXvaeis80qvkstNlyEcnDnI+a0L6CC9dQhwgaoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383334; c=relaxed/simple;
	bh=CYrgK0GZef4qd4DylejgFhuD+iymzjGbUbnw1d4ueFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZa2IFkdbdb7WSM54N3W7NP1OP2eoHPHAlIdBb1w1BCQgelc4kPHPMxwOP7BgnzOExxVLBHic5GcD/60ULKGHXopUpWesJcTpC4jSrgHA8yrpd810M12pE83M/+QudPJDk7oK1eMkkQIAxSmjGmIuXhANtcbzTYa5XRZOv/AgJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 5 Dec
 2024 15:20:49 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 5 Dec 2024 15:20:49 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [PATCH net-next v4 7/7] net: ftgmac100: remove extra newline symbols
Date: Thu, 5 Dec 2024 15:20:48 +0800
Message-ID: <20241205072048.1397570-8-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
References: <20241205072048.1397570-1-jacky_chou@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Remove some unnecessary newline symbols in code.

Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
---
 drivers/net/ethernet/faraday/ftgmac100.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index 11a81f75ed4e..5a0a94c3b1eb 100644
--- a/drivers/net/ethernet/faraday/ftgmac100.c
+++ b/drivers/net/ethernet/faraday/ftgmac100.c
@@ -575,7 +575,6 @@ static bool ftgmac100_rx_packet(struct ftgmac100 *priv, int *processed)
 	dma_unmap_single(priv->dev, map, RX_BUF_SIZE, DMA_FROM_DEVICE);
 #endif
 
-
 	/* Resplenish rx ring */
 	ftgmac100_alloc_rx_buf(priv, pointer, rxdes, GFP_ATOMIC);
 	priv->rx_pointer = ftgmac100_next_rx_pointer(priv, pointer);
@@ -1273,7 +1272,6 @@ static int ftgmac100_poll(struct napi_struct *napi, int budget)
 		more = ftgmac100_rx_packet(priv, &work_done);
 	} while (more && work_done < budget);
 
-
 	/* The interrupt is telling us to kick the MAC back to life
 	 * after an RX overflow
 	 */
@@ -1363,7 +1361,6 @@ static void ftgmac100_reset(struct ftgmac100 *priv)
 	if (priv->mii_bus)
 		mutex_lock(&priv->mii_bus->mdio_lock);
 
-
 	/* Check if the interface is still up */
 	if (!netif_running(netdev))
 		goto bail;
@@ -1462,7 +1459,6 @@ static void ftgmac100_adjust_link(struct net_device *netdev)
 
 	if (netdev->phydev)
 		mutex_lock(&netdev->phydev->lock);
-
 }
 
 static int ftgmac100_mii_probe(struct net_device *netdev)
@@ -1990,7 +1986,6 @@ static int ftgmac100_probe(struct platform_device *pdev)
 			dev_err(priv->dev, "MII probe failed!\n");
 			goto err_ncsi_dev;
 		}
-
 	}
 
 	if (priv->is_aspeed) {
-- 
2.25.1


