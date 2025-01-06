Return-Path: <netdev+bounces-155436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D80A02548
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74BB61633F3
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0B1DC9BB;
	Mon,  6 Jan 2025 12:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hDA8FV4W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E321D6182
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736166317; cv=none; b=MZZLi4u8N8DPPiMm84QkicbcOEeBL1xA0PRBIimXd6yipFZeXDJxKVuEyusTCZhh7tKT1QDLR5zp+ckN+BbtMGUdeelY6aDltstFdcfmStUNgNoTiWgkQe6ASEOHuMSPE9fK0WKd5N7dGxSpQAjvTNb+QxNZYrIoQke4+oO/jKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736166317; c=relaxed/simple;
	bh=pmf4JM4aMtuoowcATewve10dlfwLQF58M94CnHdkYC4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=t7PKe8UCxT4IpWIKN7MXeTTuRshWjOvHAhq0th/fRwF9+5KKqhOEKZh9GPmF2QN71+gEvI9YCO72wB1LiML6bIeEBa85wwwvvzspLWeju5pr3IhsXma5SjLHB/UlqrADpfiOJBfD6ZAZr2xpQ8bspOfjk/exdjUNdtZm2jGaJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hDA8FV4W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=v9uE5xTG9qTQ0AUPbco1oDtQCPyFLisTdvXtKl/xZsU=; b=hDA8FV4WWi/YZh4SpbMJtoCTx5
	cTOx/jNNwaxmWMj//2xA0aLilY5IhIYvl9Rz7lb246whJ/4ULsh/0in1HiS0qa0rkl9HGixTNyS2A
	elnQMdP8gXVwI6TPOTM3mL48iaAkW1X+F0Pp4lJ43E1ChH+i16vqdRO2wzfJNz6wkzv90QN8fxPvP
	TBjY8XgKII2w5ufccQYJiHLYU3pTK3CTA0m38QXOiFEprJvaYiq2ZldfpN8HeLiXV85QT9kN2OLkx
	1R/4K6zjxrlGmmJjy+Y9vBwd8PjusLitoNG2aTsuEq5/Mpnnfl9r5/UmqyvYNY+ynBO+9oE1ZjWth
	JF/gJV4g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35836 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tUmAN-0005r5-00;
	Mon, 06 Jan 2025 12:25:07 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tUmAK-007VX1-2Q; Mon, 06 Jan 2025 12:25:04 +0000
In-Reply-To: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
References: <Z3vLbRQ9Ctl-Rpdg@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 04/17] net: stmmac: make EEE depend on
 phy->enable_tx_lpi
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tUmAK-007VX1-2Q@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 06 Jan 2025 12:25:04 +0000

Make stmmac EEE depend on phylib's evaluation of user settings and PHY
negotiation, as indicated by phy->enable_tx_lpi. This will ensure when
phylib has evaluated that the user has disabled LPI, phy_init_eee()
will not be called, and priv->eee_active will be false, causing LPI/EEE
to be disabled.

This is an interim measure - phy_init_eee() will be removed in a later
patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b0ef439b715b..dbee2de08583 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1085,7 +1085,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
 
 	stmmac_mac_set(priv, priv->ioaddr, true);
 	if (phy && priv->dma_cap.eee) {
-		priv->eee_active =
+		priv->eee_active = phy->enable_tx_lpi &&
 			phy_init_eee(phy, !(priv->plat->flags &
 				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
 		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
-- 
2.30.2


