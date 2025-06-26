Return-Path: <netdev+bounces-201573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00567AE9F47
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9820F3B6FD2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CCF2E763F;
	Thu, 26 Jun 2025 13:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D602E7632
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750945467; cv=none; b=UpXmmNAiQgnTiWhTUEDxkhN7OYu6pvZf5Kt/57O9uIJ/R8/rdTK8QB0/6P1vVul9z1LAfoPxJ2tub03jYG6oFgH2Nokzz9zXbL8pihoU8M3XDro9MG0SnzAEAC49atAmdD0RHGXHYxV2fL8NQGfpzrh6LrVCrORSiFZM1dS3IP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750945467; c=relaxed/simple;
	bh=lOIhZPwjq2iRUH2/8/px4H6GSxHqp5XVL22e3XXy7z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gkSMwFUGJO8e0DzvFVieocxLDeqIt7MtjWLb8LdHaIWgSL3dqLS2aW7lW/oKFkNfpSpbuoNaqDz6x0Mri6Fp+cgYdvWRxIBTqz4h8+Fe0488+Kp6jifM5B1AxHcsYBd/vz5sLyuIT9N24MJRcCwu5wqK9U7y8BiFJrlF4p3tsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1uUmte-0004GB-8X; Thu, 26 Jun 2025 15:44:10 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 26 Jun 2025 15:44:02 +0200
Subject: [PATCH v2] net: fec: allow disable coalescing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-fec_deactivate_coalescing-v2-1-0b217f2e80da@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAKFOXWgC/42NQQrCMBBFr1JmbaSJTRRX3kNKGZJpOyBJSWKol
 N7d2BO4fA/++xskikwJ7s0GkQonDr6COjVgZ/QTCXaVQbVKt0ZpMZIdHKHNXDDTYAO+KFn2k7B
 mvDnZoXTGQN0vkUZej/azrzxzyiF+jqsif/afapFCCn1FSZ3ETrvLYyE/vXMMntezI+j3ff8CC
 mFWLMcAAAA=
X-Change-ID: 20250625-fec_deactivate_coalescing-c6f8d14a1d66
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: imx@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=lOIhZPwjq2iRUH2/8/px4H6GSxHqp5XVL22e3XXy7z8=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYsiI9Vvx4OHE6n/nVJLubsl8WbztT/rihy+8LZfZnFnsV
 d+394WAU0cpC4MYB4OsmCJLrJqcgpCx/3WzSrtYmDmsTCBDGLg4BWAic40Y/vvq6XwWsDDStV++
 aeWlK3EHNFpK2zeHhrqnbrV90dbjUc7w34GDW3TyRK0ic8GQ5Q+nHfUIsr28IufcJd6DzmVSn/Q
 t+AA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

In the current implementation, IP coalescing is always enabled and
cannot be disabled.

As setting maximum frames to 0 or 1, or setting delay to zero implies
immediate delivery of single packets/IRQs, disable coalescing in
hardware in these cases.

This also guarantees that coalescing is never enabled with ICFT or ICTT
set to zero, a configuration that could lead to unpredictable behaviour
according to i.MX8MP reference manual.

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
Changes in v2:
- Adjust type of rx_itr, tx_itr (Thanks, Wei)
- Set multiple FEC_ITR_ flags in one line for more compact code (Thanks, Wei)
- Commit Message: mention ICFT/CTT fields constraints (Thanks, Andrew)
- Link to v1: https://lore.kernel.org/r/20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3@pengutronix.de
---
 drivers/net/ethernet/freescale/fec_main.c | 34 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 63dac42720453a8b8a847bdd1eec76ac072030bf..d4eed252ad4098a7962f615bce98338bc3d12f5c 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3121,27 +3121,25 @@ static int fec_enet_us_to_itr_clock(struct net_device *ndev, int us)
 static void fec_enet_itr_coal_set(struct net_device *ndev)
 {
 	struct fec_enet_private *fep = netdev_priv(ndev);
-	int rx_itr, tx_itr;
+	u32 rx_itr = 0, tx_itr = 0;
+	int rx_ictt, tx_ictt;
 
-	/* Must be greater than zero to avoid unpredictable behavior */
-	if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
-	    !fep->tx_time_itr || !fep->tx_pkts_itr)
-		return;
-
-	/* Select enet system clock as Interrupt Coalescing
-	 * timer Clock Source
-	 */
-	rx_itr = FEC_ITR_CLK_SEL;
-	tx_itr = FEC_ITR_CLK_SEL;
+	rx_ictt = fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr);
+	tx_ictt = fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr);
 
-	/* set ICFT and ICTT */
-	rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
-	rx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr));
-	tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
-	tx_itr |= FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr));
+	if (rx_ictt > 0 && fep->rx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		rx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		rx_itr |= FEC_ITR_ICFT(fep->rx_pkts_itr);
+		rx_itr |= FEC_ITR_ICTT(rx_ictt);
+	}
 
-	rx_itr |= FEC_ITR_EN;
-	tx_itr |= FEC_ITR_EN;
+	if (tx_ictt > 0 && fep->tx_pkts_itr > 1) {
+		/* Enable with enet system clock as Interrupt Coalescing timer Clock Source */
+		tx_itr = FEC_ITR_EN | FEC_ITR_CLK_SEL;
+		tx_itr |= FEC_ITR_ICFT(fep->tx_pkts_itr);
+		tx_itr |= FEC_ITR_ICTT(tx_ictt);
+	}
 
 	writel(tx_itr, fep->hwp + FEC_TXIC0);
 	writel(rx_itr, fep->hwp + FEC_RXIC0);

---
base-commit: 8dacfd92dbefee829ca555a860e86108fdd1d55b
change-id: 20250625-fec_deactivate_coalescing-c6f8d14a1d66

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


