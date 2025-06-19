Return-Path: <netdev+bounces-199474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5F0AE06E3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B6C3B1789
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4D42505A9;
	Thu, 19 Jun 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="xHaiROar"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB524DCF6;
	Thu, 19 Jun 2025 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339305; cv=none; b=Ps2tkiFvkkXD5HEfLeMJHQsA03z7yxeLVSVi+1fzEbxJfqv4rffyjNpFo0xrUrAoy6SgWYHqKulwZhnqe5/gxWWEYARRBNBussXt8q++OIpkGVzep5+ggD7UR4x6NoO0Ur+uKEiFMXfLd+lzYH+R0gpmrQsz97Lm+x1OfHP2SPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339305; c=relaxed/simple;
	bh=oKulFATTRQQZBNnM1v+cHfttUexHr0J5m9zujzySsQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LijoQGN3Qu5JIYVTikBVgJZp++npCuHYfH7Jv3CQIzK9lW3XBEy1+HMqDyLjAE+bdkzTa4xUzxvR1vC7rQAeOnqnp4T/3487OBkEAWMDWtA9ZCJBRhlyparig8JvMJi1On56I305a5pLpX2Css5DAoGnFXJLbdEQ3fCOY1kJvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=xHaiROar; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 3150D603E2;
	Thu, 19 Jun 2025 13:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750339295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/TJe0GtibYNSR3TlB4zrDfpZgRHLE4jCl9Gxezu9Oew=;
	b=xHaiROarPd6WYyhOgV1oAn9fe8HfGC0vZhhuiQ/bfA7DQDhjGGFRwlqnVTke8GSfNuMX9B
	ZaQvX+xp5uV5Ppcm8mfNOetNsDVtMnxNioem29dwd44C/MAWGmE1WqHEV6klYiU9rbGmok
	ipPGXglbjHy43h98B3ne2it90Q/IOjI=
Received: from frank-u24.. (fttx-pool-80.245.76.73.bambit.de [80.245.76.73])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id E95351226B5;
	Thu, 19 Jun 2025 13:21:34 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Simon Horman <horms@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	arinc.unal@arinc9.com
Subject: [net-next v6 3/4] net: ethernet: mtk_eth_soc: skip first IRQ if not used
Date: Thu, 19 Jun 2025 15:21:23 +0200
Message-ID: <20250619132125.78368-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619132125.78368-1-linux@fw-web.de>
References: <20250619132125.78368-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

On SoCs with dedicated RX and TX interrupts (all except MT7621 and
MT7628) platform_get_irq() is called for the first IRQ (eth->irq[0])
but it is never used.
Skip the first IRQ and reduce the IRQ-count to 2.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v6:
- changed commit description a bit
- use MTK_FE_IRQ_SHARED instead of 0
v5:
- change commit title and description
v4:
- drop >2 condition as max is already 2 and drop the else continue
- update comment to explain which IRQs are taken in legacy way
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 12 ++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index efffdd7e131e..67ba8927be46 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3353,10 +3353,14 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 	 * the second is for TX, and the third is for RX.
 	 */
 	for (i = 0; i < MTK_FE_IRQ_NUM; i++) {
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[MTK_FE_IRQ_SHARED];
-		else
-			eth->irq[i] = platform_get_irq(pdev, i);
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
+			if (i == MTK_FE_IRQ_SHARED)
+				eth->irq[MTK_FE_IRQ_SHARED] = platform_get_irq(pdev, i);
+			else
+				eth->irq[i] = eth->irq[MTK_FE_IRQ_SHARED];
+		} else {
+			eth->irq[i] = platform_get_irq(pdev, i + 1);
+		}
 
 		if (eth->irq[i] < 0) {
 			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 8cdf1317dff5..9261c0e13b59 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -643,8 +643,8 @@
 #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
 
 #define MTK_FE_IRQ_SHARED	0
-#define MTK_FE_IRQ_TX		1
-#define MTK_FE_IRQ_RX		2
+#define MTK_FE_IRQ_TX		0
+#define MTK_FE_IRQ_RX		1
 #define MTK_FE_IRQ_NUM		(MTK_FE_IRQ_RX + 1)
 
 struct mtk_rx_dma {
-- 
2.43.0


