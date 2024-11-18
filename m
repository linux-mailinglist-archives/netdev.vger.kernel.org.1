Return-Path: <netdev+bounces-145732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A52A9D093F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 07:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56C31F224D2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 06:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F1F18E03A;
	Mon, 18 Nov 2024 06:02:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17851885BF;
	Mon, 18 Nov 2024 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731909756; cv=none; b=ErM7Hv9/E8AN0rgsUdWXEw8LxVSKcJIY4JeHCJmtZaEvoI/m8/INxEKrmnSgqG2Z7eXoDyUIKVcfOMKpRB7ZU+SliM5e/aZvWDzh6bXounjwFiQQg76zVWY9y8ls/uPVA30LH372AFct5/NoOn9SsA5p+yapyHro7j3qBOBQYrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731909756; c=relaxed/simple;
	bh=BrnSBQjmH8umjO3cZA20Vy89Syvf3RzFwQj/MF+vmIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QmORFE/4LZnOtYPYvNDOor8xsz8sTLNIg/9n52ZD/MMdOfj/Q7jscrdTbNzKxYKwO++cc21koAyjyAO8SPibvAgg4p5AuPr+2wcXWGgKTNdMevJTzFrI3QQTSx75bfGm1f0dS+BVv88b2MRdXWUaTk248iMBd9bFjQjIk4wdeGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 18 Nov
 2024 14:02:08 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Mon, 18 Nov 2024 14:02:08 +0800
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <jacky_chou@aspeedtech.com>
Subject: [net-next v2 7/7] net: ftgmac100: remove extra newline symbols
Date: Mon, 18 Nov 2024 14:02:07 +0800
Message-ID: <20241118060207.141048-8-jacky_chou@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
References: <20241118060207.141048-1-jacky_chou@aspeedtech.com>
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
 drivers/net/ethernet/faraday/ftgmac100.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
index f3fbe241edb0..0ba41c59072a 100644
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
-- 
2.25.1


