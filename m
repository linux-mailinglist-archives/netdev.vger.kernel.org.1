Return-Path: <netdev+bounces-170168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B5A478DE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E094188FBC7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B86D226188;
	Thu, 27 Feb 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wneBXL4m"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5132248BD
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647839; cv=none; b=sUqBSQsvZBpjjSG6YKXqVE2JfAt0lFD6GNxcjtcD8qH0oc8aEnrji5dY8BkucMu5YjY1mHuHhBhe3yYuAL1XExCUscD1vnprAvfDcr2ExxG27j/xBxczpftPaLjvLNof84+eGYELlqUxjby7sg8IJZmI7DVfGIf/JOb3VsH8sNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647839; c=relaxed/simple;
	bh=+0rNi2m+LJAVAmlyQxaWUpioNFnnyA9AFdFwoiJV+/Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uUtvIyr1kTvkSr/5gl9+25N2YkDIZfmm9qgk0t4plklxUe/NLQXbZ8+YiP0Qxwtu1G8NZ5nzw4AZh9HQx7xq18pqjNGZXr0yRA5ZsO6cGTPNG7lkJs0kCT3bjOvjOWpP1aZ31wgNq9g/KTLthmAhEehH1HA7V6kuLILlxeazPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wneBXL4m; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rbFSLdJ2BXUSUV0YgnQ7knSt3ShZinjE3OWChyPJm3A=; b=wneBXL4myqrbXgSp27MjRW6cUo
	YBO153FUjsqljzategPT1Xj8e0bx4ZGDJMA4791tOV+MlDRDOCTGaHnlKqycZ3PEdMHrGZvtfInhD
	+JbJSANOznoyzkSn0OVsonXNYxy7PtmqJObEmw88aUXW6IP+asiN5oIrhtUFWJOXzCzr0PlPMn5fv
	FyP7ki+0Idexo0FqhyYTu/2vl9enz7hA4ZDYsdPfDEieBA/mLz+ITFoWFtWGu2uL+RQIl+Tv5ahsU
	SsvMf0gpEbM+ysS2Wwzr9+QF+nalVbt9FlsVvaqLMenKC0vUiPbcmt/hmHojyeeUOVBmCsp6DAcQf
	f4SWjabw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:45376 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tna0z-0006cq-1H;
	Thu, 27 Feb 2025 09:17:09 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tna0f-0052sw-8r; Thu, 27 Feb 2025 09:16:49 +0000
In-Reply-To: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
References: <Z8AtX-wyPal1auVO@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 06/11] net: stmmac: intel: use generic
 stmmac_set_clk_tx_rate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tna0f-0052sw-8r@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 09:16:49 +0000

Use the generic stmmac_set_clk_tx_rate() to configure the MAC transmit
clock.

Note that given the current unpatched driver structure,
plat_dat->fix_mac_speed will always be populated with
kmb_eth_fix_mac_speed(), even when no clock is present. We preserve
this behaviour in this patch by always initialising plat_dat->clk_tx_i
and plat_dat->set_clk_tx_rate.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../stmicro/stmmac/dwmac-intel-plat.c         | 24 +++----------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
index 0591756a2100..599def7b3a64 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel-plat.c
@@ -22,31 +22,12 @@ struct intel_dwmac {
 };
 
 struct intel_dwmac_data {
-	void (*fix_mac_speed)(void *priv, int speed, unsigned int mode);
 	unsigned long ptp_ref_clk_rate;
 	unsigned long tx_clk_rate;
 	bool tx_clk_en;
 };
 
-static void kmb_eth_fix_mac_speed(void *priv, int speed, unsigned int mode)
-{
-	struct intel_dwmac *dwmac = priv;
-	long rate;
-	int ret;
-
-	rate = rgmii_clock(speed);
-	if (rate < 0) {
-		dev_err(dwmac->dev, "Invalid speed\n");
-		return;
-	}
-
-	ret = clk_set_rate(dwmac->tx_clk, rate);
-	if (ret)
-		dev_err(dwmac->dev, "Failed to configure tx clock rate\n");
-}
-
 static const struct intel_dwmac_data kmb_data = {
-	.fix_mac_speed = kmb_eth_fix_mac_speed,
 	.ptp_ref_clk_rate = 200000000,
 	.tx_clk_rate = 125000000,
 	.tx_clk_en = true,
@@ -89,8 +70,6 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 	 * platform_match().
 	 */
 	dwmac->data = device_get_match_data(&pdev->dev);
-	if (dwmac->data->fix_mac_speed)
-		plat_dat->fix_mac_speed = dwmac->data->fix_mac_speed;
 
 	/* Enable TX clock */
 	if (dwmac->data->tx_clk_en) {
@@ -132,6 +111,9 @@ static int intel_eth_plat_probe(struct platform_device *pdev)
 		}
 	}
 
+	plat_dat->clk_tx_i = dwmac->tx_clk;
+	plat_dat->set_clk_tx_rate = stmmac_set_clk_tx_rate;
+
 	plat_dat->bsp_priv = dwmac;
 	plat_dat->eee_usecs_rate = plat_dat->clk_ptp_rate;
 
-- 
2.30.2


