Return-Path: <netdev+bounces-197972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2331FADAA43
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4E1892BD4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE5C211A35;
	Mon, 16 Jun 2025 08:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="YRVYaOMf"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7DF211711;
	Mon, 16 Jun 2025 08:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750061271; cv=none; b=ElAeH65fn7ScdonQ9c0ZXytImU3Pu2GR97X1PmUToadfqtLalouBiOeAm5kjJoVwhL0/CdiLdOnH/MZlKyOwq4+W1skTJ/rQbilKBIq/GaAkdHhb9Ppose4Ej1jb4j1yPzFNhrPYYa7dkIwwP9EM/YgVHZk4xlIHlpMAmb7cGbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750061271; c=relaxed/simple;
	bh=unkrt1I1aycK0USQscjU+zwYRYC1x0EAJV22XRofaLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ugwchjti/Lu0ImfJok9AK0jxYE0OgiXWRAldPShP1wrbIQa9j9V9oTDSdprdfBwipf1OcbmUaqbt15UFeN8r9TVBTClTo344OnCSD2ZChLSK6XthcW5Wr6uE8e/F18vr1D89feLKb0d7rtDA74HCc1y+XI72+SXd+GcjhEe8MZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=YRVYaOMf; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id F19A93FC53;
	Mon, 16 Jun 2025 08:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1750061267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8f/+FnkJmV80G4mQhBXvToxseQ3gyhJ12ujdf6hNPk=;
	b=YRVYaOMfzd+7prWkj42utAH6tzBV6u3ONURP+xaN3/DFVbAsj5qIV9Sl+/aAtzJk1+YF4E
	xpK902rB8xQYxVHDyB1XBmFs8LjkMCEB/pQq298HcNEU1ZERLkL4YWUXnYUIuXwApbios2
	d6HXxv8tNdhmIkUnEo5VCfYh7FNvngs=
Received: from frank-u24.. (fttx-pool-194.15.87.210.bambit.de [194.15.87.210])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id B7F19122704;
	Mon, 16 Jun 2025 08:07:46 +0000 (UTC)
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
Subject: [net-next v4 3/3] net: ethernet: mtk_eth_soc: change code to skip first IRQ completely
Date: Mon, 16 Jun 2025 10:07:36 +0200
Message-ID: <20250616080738.117993-4-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616080738.117993-1-linux@fw-web.de>
References: <20250616080738.117993-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

On SoCs without MTK_SHARED_INT capability (mt7621 + mt7628) the first
IRQ (eth->irq[0]) was read but never used. Do not read it and reduce
the IRQ-count to 2 because of skipped index 0.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
v4:
- drop >2 condition as max is already 2 and drop the else continue
- update comment to explain which IRQs are taken in legacy way
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 20 ++++++++++++++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++--
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3ecb399dcf81..f3fcbb00822c 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3341,16 +3341,28 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
 {
 	int i;
 
+	/* future SoCs beginning with MT7988 should use named IRQs in dts */
 	eth->irq[MTK_ETH_IRQ_TX] = platform_get_irq_byname(pdev, "tx");
 	eth->irq[MTK_ETH_IRQ_RX] = platform_get_irq_byname(pdev, "rx");
 	if (eth->irq[MTK_ETH_IRQ_TX] >= 0 && eth->irq[MTK_ETH_IRQ_RX] >= 0)
 		return 0;
 
+	/* legacy way:
+	 * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken from
+	 * devicetree and used for rx+tx.
+	 * On SoCs with non-shared IRQ the first was not used, second entry is
+	 * TX and third is RX.
+	 */
+
 	for (i = 0; i < MTK_ETH_IRQ_MAX; i++) {
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
-			eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
-		else
-			eth->irq[i] = platform_get_irq(pdev, i);
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
+			if (i == 0)
+				eth->irq[MTK_ETH_IRQ_SHARED] = platform_get_irq(pdev, i);
+			else
+				eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
+		} else {
+			eth->irq[i] = platform_get_irq(pdev, i + 1);
+		}
 
 		if (eth->irq[i] < 0) {
 			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 96b724dca0e2..9d91fe721ad0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -643,8 +643,8 @@
 #define MTK_MAC_FSM(x)		(0x1010C + ((x) * 0x100))
 
 #define MTK_ETH_IRQ_SHARED	0
-#define MTK_ETH_IRQ_TX		1
-#define MTK_ETH_IRQ_RX		2
+#define MTK_ETH_IRQ_TX		0
+#define MTK_ETH_IRQ_RX		1
 #define MTK_ETH_IRQ_MAX		(MTK_ETH_IRQ_RX + 1)
 
 struct mtk_rx_dma {
-- 
2.43.0


