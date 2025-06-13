Return-Path: <netdev+bounces-197615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E27EAD956C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31F011769DF
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF36242D9C;
	Fri, 13 Jun 2025 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="PXFRvsBB"
X-Original-To: netdev@vger.kernel.org
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7228231832;
	Fri, 13 Jun 2025 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842314; cv=none; b=YBiOISFz8mEyyI24Dy3x+n+fube7VQvYV0LUv/2q5CefS8jPb8OsQjUJsZghcgOyE96J040cMUsWcoQ5nexWtJeArasx+dINv3BljTh+U3uVI/1XYU6sudqP5+q6AwdyUR7aV7Iwsu/HicWxQzdnyn93zZWoTp/8MrRxRGXhsD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842314; c=relaxed/simple;
	bh=UUDTe7DybzfY/V5zJtnJ1qRayPddR3aBTTh7gRACPeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3znVciE/CX2qHU0+jfcWoSyF0H6oTlTnUhGaXwB3BiYHXFE0medsyck4MelXue2AUE/tJNPUEiF+xGqvuxeogPF8E94e66g3HWIsL4l1gAat7QJjI2RBO45dVmH8LUbWVaRQYviXfsm7NJ0UUvtUx/eWRvnCAjks7grIFZL63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=PXFRvsBB; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout2.routing.net (Postfix) with ESMTP id 6275D6027A;
	Fri, 13 Jun 2025 19:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1749842302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Q/gXoaffigG8SJ50bYXBMyjpep5Cs+E0rWgAJGLqcfQ=;
	b=PXFRvsBB6wXCXmZ7lG9srlG05l6kvlz/2sleXEDzy0Psswk0FYLA9P0GMnYWXGV611KqkX
	SLrdN38JmcFdL+DbgMHsr88KQ+SW6lyzDdfGRMou+846UlV5hDBKrxyDBiS5vZfTNdtX2Q
	pgqbTfE0gvXZxKeCw869IUwKFn1Lq6g=
Received: from frank-u24.. (fttx-pool-217.61.151.84.bambit.de [217.61.151.84])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 260491226E5;
	Fri, 13 Jun 2025 19:18:22 +0000 (UTC)
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
	daniel@makrotopia.org
Subject: [net-next v1] net: ethernet: mtk_eth_soc: support named IRQs
Date: Fri, 13 Jun 2025 21:18:11 +0200
Message-ID: <20250613191813.61010-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Add named interrupts and keep index based fallback for exiting devicetrees.

Currently only rx and tx IRQs are defined to be used with mt7988, but
later extended with RSS/LRO support.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 24 +++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b76d35069887..fcec5f95685e 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -5106,17 +5106,23 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
 
-	for (i = 0; i < 3; i++) {
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[0];
-		else
-			eth->irq[i] = platform_get_irq(pdev, i);
-		if (eth->irq[i] < 0) {
-			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
-			err = -ENXIO;
-			goto err_wed_exit;
+	eth->irq[1] = platform_get_irq_byname(pdev, "tx");
+	eth->irq[2] = platform_get_irq_byname(pdev, "rx");
+	if (eth->irq[1] < 0 || eth->irq[2] < 0) {
+		for (i = 0; i < 3; i++) {
+			if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
+				eth->irq[i] = eth->irq[0];
+			else
+				eth->irq[i] = platform_get_irq(pdev, i);
+
+			if (eth->irq[i] < 0) {
+				dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
+				err = -ENXIO;
+				goto err_wed_exit;
+			}
 		}
 	}
+
 	for (i = 0; i < ARRAY_SIZE(eth->clks); i++) {
 		eth->clks[i] = devm_clk_get(eth->dev,
 					    mtk_clks_source_name[i]);
-- 
2.43.0


