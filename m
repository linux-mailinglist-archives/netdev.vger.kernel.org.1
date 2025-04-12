Return-Path: <netdev+bounces-181886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5310CA86C08
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC2E7B5D6F
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C386E19DF7A;
	Sat, 12 Apr 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EfvprTU/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01B71F92E
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744450533; cv=none; b=Jyb7Tem+0SFmoD8dkdwU9O15YwcEW0SwLC4T8EyFY1pRK4tfdf1322g1jB4+27gC5fppen1fW84RiOV2GFQ6Qx4yCGfoXwWDYIsvJoogZ0hKYvE5QdflwHrUekJfz+UqUflKHfHtCnmQG8DOSzWfHDCFY3qn0BGXaICPCroL/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744450533; c=relaxed/simple;
	bh=t57kFMZOyc2E1DcWWsgxbRLaNhFNzzlWClnSLl3gxKU=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=JMFcv6Zykpon5TO75oKBq8VaPHgzFyq/AD80wXXv6zljZUtiRrfZgMh679oC33tcK01dEn2fF4FtElxvBFchrHBcDDLYHj2HIeO+aTQHavE7SUk6TDDWo2GGsla9HfGHrF7i1+apxpb+nTTCYMw8sFOTTaQESROavPIJargVN8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=EfvprTU/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HgIKLwjmM3zOzMNcI6zf8TGzoq3WJV5zZ0yVxBt2glo=; b=EfvprTU/8x/51YDmQAMnZidivo
	WOj2km33+1oGuZga0iiSe8ziXDiLaqam9Is9OB4c1Ty/GOouFBjtFAltzNHSkoSaXQr/psGAgeJav
	G72MMjyzFVvNeXcD2ptyAgiQXXxt1vQCyxzy3JXS2xHrRX2kBCcdSefSGU1yQTPrnzPpt344PmoKI
	tuhE5NYrx5vRmvg9nabLWImOp3k8WDuWUHTPP709VUf7P6+clUWbaJXMQtVMFHKxHxBzjX6nb5K22
	AQyYJy6aFPP/Gn7FlUkJmJAnmbwriCfr9NrrT4b3BZCwFx2ymWv40IVuGVSxvu5BLQbzfsURDrOzr
	mG34zFwA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46246 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3XGn-0004Qq-0z;
	Sat, 12 Apr 2025 10:35:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3XGC-000EJm-2N; Sat, 12 Apr 2025 10:34:48 +0100
In-Reply-To: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
References: <Z/ozvMMoWGH9o6on@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 2/3] net: stmmac: remove _RE and _TE in
 (start|stop)_(tx|rx)() methods
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3XGC-000EJm-2N@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 10:34:48 +0100

Remove fiddling with _TE and _RE in the GMAC control register in the
start_tx/stop_tx/start_rx/stop_rx() methods as this should be handled
by stmmac_mac_link_up() and stmmac_mac_link_down() and not during
initialisation.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c   |  8 --------
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 12 ------------
 2 files changed, 20 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 57c03d491774..61584b569be7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -50,10 +50,6 @@ void dwmac4_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 
 	value |= DMA_CONTROL_ST;
 	writel(value, ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value |= GMAC_CONFIG_TE;
-	writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void dwmac4_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -77,10 +73,6 @@ void dwmac4_dma_start_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value |= DMA_CONTROL_SR;
 
 	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(dwmac4_addrs, chan));
-
-	value = readl(ioaddr + GMAC_CONFIG);
-	value |= GMAC_CONFIG_RE;
-	writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void dwmac4_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 7840bc403788..cba12edc1477 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -288,10 +288,6 @@ static void dwxgmac2_dma_start_tx(struct stmmac_priv *priv,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value |= XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value |= XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
@@ -302,10 +298,6 @@ static void dwxgmac2_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
 	value &= ~XGMAC_TXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_TX_CONFIG);
-	value &= ~XGMAC_CONFIG_TE;
-	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
 static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
@@ -316,10 +308,6 @@ static void dwxgmac2_dma_start_rx(struct stmmac_priv *priv,
 	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
 	value |= XGMAC_RXST;
 	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
-
-	value = readl(ioaddr + XGMAC_RX_CONFIG);
-	value |= XGMAC_CONFIG_RE;
-	writel(value, ioaddr + XGMAC_RX_CONFIG);
 }
 
 static void dwxgmac2_dma_stop_rx(struct stmmac_priv *priv, void __iomem *ioaddr,
-- 
2.30.2


