Return-Path: <netdev+bounces-172600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD4DA55792
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EACA189A2B8
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B02755E9;
	Thu,  6 Mar 2025 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="m0nMUEMd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E4027426C
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293563; cv=none; b=ZjpE1sCa01bsRmbA/OdfpE1SzJmdji3CW0KJPRg8PSQE/nSz8kUXWYbg9hsQViqe2D95Tr4nVCO4VytA+wDrhMmcOuQcaOT13A/hNISvXRUL+2FmPSkBoFXrQGY1HLSxwQxbtbm+nnfaEsBZX5PvmdHiL3clxPJW8nsqg0H+u1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293563; c=relaxed/simple;
	bh=3oyhS/neJz80BZOQqYNoBOpdxi5uNvHfAJDCokDJxVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJyBnKBQpHog/ZtwBq63iJBUH9sxt9O7tT3rsgw8pFAisAhebJH9r1qG5j5KcGGpF4E88Tm9xf29ucr1NMqRTgazQaeI5jKVVP8RQIoOhO+RUdYHyeLzzhQicHQYXhZr7n1j42H5MRZZFRNVG8pCS9cpyE7UJHIA/Xzy1x1FzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=m0nMUEMd; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1741293561; bh=qK3GcAy1T7b7ZQP5vAw6ojWgGkMIfURsR+RxPTcGPYs=;
 b=m0nMUEMdasbqnujUuvlfygfdR5xDDGVGQ23tn3MP811H6BaX5/jlCsfIu7VZPaKP5QbTfPNfS
 24UvBirCp8B5lnkyflf029a6W48J4aR8vIR6IGunub+uW3u60/rHRaWHoBixndazxD3VFOthxWz
 xMWR2t+pygkpCTiU2dGxDuBccrEUPtBrBGEij73k8XmlKtZl9PC/tCcJLK/kvHx8Wvk6g7DQrvo
 XCIsultszmcU13eGwCiKV9QTzIVTx4IGmFORKPHbV4XpQT8pwSGyEaezff/NUyZV2WAYjigJEJQ
 PjBV4ZBqZkGtJc8YLuY25plVdE3YgK1GR+rtsYKohOdw==
X-Forward-Email-ID: 67ca07f4deafcb1458af928b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	David Wu <david.wu@rock-chips.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 3/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for RK3588
Date: Thu,  6 Mar 2025 20:38:54 +0000
Message-ID: <20250306203858.1677595-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306203858.1677595-1-jonas@kwiboo.se>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for Rockchip RK3588 GMAC was added without use of the
DELAY_ENABLE macro to assist with enable/disable use of MAC rx/tx delay.

Change to use a variant of the DELAY_ENABLE macro to help disable MAC
delay when RGMII_ID/RXID/TXID is used.

Fixes: 2f2b60a0ec28 ("net: ethernet: stmmac: dwmac-rk: Add gmac support for rk3588")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 37eb86e4e325..79db81d68afd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -91,6 +91,10 @@ struct rk_priv_data {
 	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE : soc##_GMAC_TXCLK_DLY_DISABLE) | \
 	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE : soc##_GMAC_RXCLK_DLY_DISABLE))
 
+#define DELAY_ENABLE_BY_ID(soc, tx, rx, id) \
+	(((tx) ? soc##_GMAC_TXCLK_DLY_ENABLE(id) : soc##_GMAC_TXCLK_DLY_DISABLE(id)) | \
+	 ((rx) ? soc##_GMAC_RXCLK_DLY_ENABLE(id) : soc##_GMAC_RXCLK_DLY_DISABLE(id)))
+
 #define PX30_GRF_GMAC_CON1		0x0904
 
 /* PX30_GRF_GMAC_CON1 */
@@ -1322,8 +1326,7 @@ static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
 		     RK3588_GMAC_CLK_RGMII_MODE(id));
 
 	regmap_write(bsp_priv->grf, RK3588_GRF_GMAC_CON7,
-		     RK3588_GMAC_RXCLK_DLY_ENABLE(id) |
-		     RK3588_GMAC_TXCLK_DLY_ENABLE(id));
+		     DELAY_ENABLE_BY_ID(RK3588, tx_delay, rx_delay, id));
 
 	regmap_write(bsp_priv->grf, offset_con,
 		     RK3588_GMAC_CLK_RX_DL_CFG(rx_delay) |
-- 
2.48.1


