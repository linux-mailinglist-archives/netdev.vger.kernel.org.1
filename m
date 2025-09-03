Return-Path: <netdev+bounces-219568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1235B41F5E
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A502316A349
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D352F1FCF;
	Wed,  3 Sep 2025 12:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YSQkTxY+"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1742FF159
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903211; cv=none; b=Sgoc+YeYfkvWErduSRkW7Si5fheHLHP9wQrazhLWk+0dUXeNshpM4e05iDzAEBh/OmFr8pPGb/cJKNGXSXmAEnZFKhpqjkjsQd9V1PHKOEJVKOwxQgg+IeFo4TlHe0wYDz64XpmzA8vqh3jXTsDrtLbtvLB7/amakZV+QDCbqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903211; c=relaxed/simple;
	bh=4OXV6yLruJQuEymupKl6uJwd/4i1BjopGjW5Bmdpu0Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Ttwxra81yz/0gUjbBVCLww8vDwOiqXdIAPgYW1Gjn+sfGTcf+slbWZpXKLgjES5IgauO5q/2whKrH3kMEXNMnxns1guc89esSuXyFhYhXNMmrcqAgfX/3KsmvOvSHMrZxR9qCYnjUv/qwT3TfL22gNafGlIGpeEaKzNpUW7xmzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YSQkTxY+; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wix2Nxfe7GAzlZBUGkDn2w85ath+Xp649h9ggw1F87o=; b=YSQkTxY+T/Sf5fBoJDxDQ4OpEP
	3Qkhpm72IViiKr+HYQSRXRnNvBIb5ZrGrS6vK38o/uJi/bMMQZ/tq0hPgQDy4x+u+k2TwAMPWEgK1
	t1YQO+O59D4lb43YQwViggofeAEVK6Zf5uDnPtzw/5D4zW7SmLLRkECDpzQLUM61jvEko4+4P15JD
	FebdIeKZ0Lj4zH2k/eLatusvLZUST27pW9euJqakY9dE5Xh0WRSZ9vLc5a2x0F/MdHRsO087tvanU
	vzYSPS7bX1vn8G+w+V9KMe3B1RCfUrHR/ZZSpI6ieimvhsk3/L9Li3HRO96iou70wDVj19c0GzlZA
	rxJWK7cw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39576 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmmO-000000000Ww-3532;
	Wed, 03 Sep 2025 13:40:00 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmmO-00000001s0r-01IW;
	Wed, 03 Sep 2025 13:40:00 +0100
In-Reply-To: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 09/11] net: stmmac: mdio: return clk_csr value from
 stmmac_clk_csr_set()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1utmmO-00000001s0r-01IW@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:40:00 +0100

Return the clk_csr value from stmmac_clk_csr_set() rather than
using priv->clk_csr, as this struct member now serves very little
purpose. This allows us to remove priv->clk_csr.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 -
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 67 +++++++++----------
 2 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 4d5577935b13..ec6bccb13710 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -289,7 +289,6 @@ struct stmmac_priv {
 	u32 msg_enable;
 	int wolopts;
 	int wol_irq;
-	int clk_csr;
 	u32 gmii_address_bus_config;
 	struct timer_list eee_ctrl_timer;
 	int lpi_irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 2ba0938ac641..7326cf5401cc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -483,9 +483,10 @@ void stmmac_pcs_clean(struct net_device *ndev)
  *	documentation). Viceversa the driver will try to set the MDC
  *	clock dynamically according to the actual clock input.
  */
-static void stmmac_clk_csr_set(struct stmmac_priv *priv)
+static u32 stmmac_clk_csr_set(struct stmmac_priv *priv)
 {
 	unsigned long clk_rate;
+	u32 value = ~0;
 
 	clk_rate = clk_get_rate(priv->plat->stmmac_clk);
 
@@ -496,50 +497,50 @@ static void stmmac_clk_csr_set(struct stmmac_priv *priv)
 	 * the frequency of clk_csr_i. So we do not change the default
 	 * divider.
 	 */
-	if (!(priv->clk_csr & MAC_CSR_H_FRQ_MASK)) {
-		if (clk_rate < CSR_F_35M)
-			priv->clk_csr = STMMAC_CSR_20_35M;
-		else if ((clk_rate >= CSR_F_35M) && (clk_rate < CSR_F_60M))
-			priv->clk_csr = STMMAC_CSR_35_60M;
-		else if ((clk_rate >= CSR_F_60M) && (clk_rate < CSR_F_100M))
-			priv->clk_csr = STMMAC_CSR_60_100M;
-		else if ((clk_rate >= CSR_F_100M) && (clk_rate < CSR_F_150M))
-			priv->clk_csr = STMMAC_CSR_100_150M;
-		else if ((clk_rate >= CSR_F_150M) && (clk_rate < CSR_F_250M))
-			priv->clk_csr = STMMAC_CSR_150_250M;
-		else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
-			priv->clk_csr = STMMAC_CSR_250_300M;
-		else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
-			priv->clk_csr = STMMAC_CSR_300_500M;
-		else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
-			priv->clk_csr = STMMAC_CSR_500_800M;
-	}
+	if (clk_rate < CSR_F_35M)
+		value = STMMAC_CSR_20_35M;
+	else if ((clk_rate >= CSR_F_35M) && (clk_rate < CSR_F_60M))
+		value = STMMAC_CSR_35_60M;
+	else if ((clk_rate >= CSR_F_60M) && (clk_rate < CSR_F_100M))
+		value = STMMAC_CSR_60_100M;
+	else if ((clk_rate >= CSR_F_100M) && (clk_rate < CSR_F_150M))
+		value = STMMAC_CSR_100_150M;
+	else if ((clk_rate >= CSR_F_150M) && (clk_rate < CSR_F_250M))
+		value = STMMAC_CSR_150_250M;
+	else if ((clk_rate >= CSR_F_250M) && (clk_rate <= CSR_F_300M))
+		value = STMMAC_CSR_250_300M;
+	else if ((clk_rate >= CSR_F_300M) && (clk_rate < CSR_F_500M))
+		value = STMMAC_CSR_300_500M;
+	else if ((clk_rate >= CSR_F_500M) && (clk_rate < CSR_F_800M))
+		value = STMMAC_CSR_500_800M;
 
 	if (priv->plat->flags & STMMAC_FLAG_HAS_SUN8I) {
 		if (clk_rate > 160000000)
-			priv->clk_csr = 0x03;
+			value = 0x03;
 		else if (clk_rate > 80000000)
-			priv->clk_csr = 0x02;
+			value = 0x02;
 		else if (clk_rate > 40000000)
-			priv->clk_csr = 0x01;
+			value = 0x01;
 		else
-			priv->clk_csr = 0;
+			value = 0;
 	}
 
 	if (priv->plat->has_xgmac) {
 		if (clk_rate > 400000000)
-			priv->clk_csr = 0x5;
+			value = 0x5;
 		else if (clk_rate > 350000000)
-			priv->clk_csr = 0x4;
+			value = 0x4;
 		else if (clk_rate > 300000000)
-			priv->clk_csr = 0x3;
+			value = 0x3;
 		else if (clk_rate > 250000000)
-			priv->clk_csr = 0x2;
+			value = 0x2;
 		else if (clk_rate > 150000000)
-			priv->clk_csr = 0x1;
+			value = 0x1;
 		else
-			priv->clk_csr = 0x0;
+			value = 0x0;
 	}
+
+	return value;
 }
 
 static void stmmac_mdio_bus_config(struct stmmac_priv *priv)
@@ -550,12 +551,10 @@ static void stmmac_mdio_bus_config(struct stmmac_priv *priv)
 	 * that the CSR Clock Range value should not be computed from the CSR
 	 * clock.
 	 */
-	if (priv->plat->clk_csr >= 0) {
+	if (priv->plat->clk_csr >= 0)
 		value = priv->plat->clk_csr;
-	} else {
-		stmmac_clk_csr_set(priv);
-		value = priv->clk_csr;
-	}
+	else
+		value = stmmac_clk_csr_set(priv);
 
 	value <<= priv->hw->mii.clk_csr_shift;
 
-- 
2.47.2


