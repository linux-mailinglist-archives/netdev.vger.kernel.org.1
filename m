Return-Path: <netdev+bounces-181885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D865FA86C06
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 11:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6A07461E2E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F433199FC9;
	Sat, 12 Apr 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vUfaTAFB"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905341F92E
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744450528; cv=none; b=b/8M9NqPgOpZ4AS8OSvDGCjmS8D/6vF9SuzwJNIITEZ2dNrvdPUphciLBBFFGPLvo/2XyVo+uh4K12/OPgwrzJYIvXhCXcPOmIYxcGDCj6QGcX1FUROutnaS54GBdrbhycUqfxKn4l7rtRHPs+srxl+UCCLxSjlnFhWtxfRyJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744450528; c=relaxed/simple;
	bh=tZv6NEzes6lMTSPMQYimH+tCrQU8SuRdCOASRm7Mglw=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=WpdavHPPdAkxjBdQzR/2sarFvgstKHAIPIZ6CeO10q/11yaTWIF6jCR8p8fy/rpq0Y2LSJRBGdLZ2e6l34Ds7oJN2Ri4PyU6PRuFgtwLYa0ztN0XOoNcu+uSP20gJvJC6OfU343QA7IVLLTRuYBpNTht1zd8dT6F5mP7xFtIBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vUfaTAFB; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DrisvxAFdiZGA941NY6Up+8vdtB3G97mNwjUf2byvUE=; b=vUfaTAFBMS/zgHgXBva9OKswfw
	su5QnXCfg2jssLGWwv58IIewbpKbb/KgqqUs4wg2jcT7PsqjbP1osL4cG/Ein5UJ9Wi2Sc0YxYEAT
	mNx1+22+53uE70u5kXNYbvPgLNTLc/lYrMT/8nk3zLA4JD9kL7yPxFeUPspyKUr31EtB5nXXshMEp
	Rle5XqwTRVFOwJKb5d7yd7vDjztVgpzEN8XATDTev4rpwueY1LZL6gurTXlvIvudQTNt6HsmW9UdM
	CllBWTJF7fe4vwlHEM3H+PnabQt7NXfluyO0LuNNsDRAhOJ0Ca7cPLgXLrkUZWidRf3AnODLeusFE
	NXOrp1Vw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46236 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1u3XGi-0004Qd-0Z;
	Sat, 12 Apr 2025 10:35:20 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1u3XG6-000EJg-V8; Sat, 12 Apr 2025 10:34:42 +0100
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
Subject: [PATCH net-next 1/3] net: stmmac: call phylink_start() and
 phylink_stop() in XDP functions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1u3XG6-000EJg-V8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sat, 12 Apr 2025 10:34:42 +0100

Phylink does not permit drivers to mess with the netif carrier, as
this will de-synchronise phylink with the MAC driver. Moreover,
setting and clearing the TE and RE bits via stmmac_mac_set() in this
path is also wrong as the link may not be up.

Replace the netif_carrier_on(), netif_carrier_off() and
stmmac_mac_set() calls with the appropriate phylink_start() and
phylink_stop() calls, thereby allowing phylink to manage the netif
carrier and TE/RE bits through the .mac_link_up() and .mac_link_down()
methods.

Note that RE should only be set after the DMA is ready to avoid the
receive FIFO between the MAC and DMA blocks overflowing, so
phylink_start() needs to be placed after DMA has been started.

Tested-by: Furong Xu <0x1207@gmail.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 59d07d0d3369..24eaabd1445e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6922,6 +6922,8 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Ensure tx function is not running */
 	netif_tx_disable(dev);
 
+	phylink_stop(priv->phylink);
+
 	/* Disable NAPI process */
 	stmmac_disable_all_queues(priv);
 
@@ -6937,14 +6939,10 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Release and free the Rx/Tx resources */
 	free_dma_desc_resources(priv, &priv->dma_conf);
 
-	/* Disable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, false);
-
 	/* set trans_start so we don't get spurious
 	 * watchdogs during reset
 	 */
 	netif_trans_update(dev);
-	netif_carrier_off(dev);
 }
 
 int stmmac_xdp_open(struct net_device *dev)
@@ -7026,25 +7024,25 @@ int stmmac_xdp_open(struct net_device *dev)
 		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	}
 
-	/* Enable the MAC Rx/Tx */
-	stmmac_mac_set(priv, priv->ioaddr, true);
-
 	/* Start Rx & Tx DMA Channels */
 	stmmac_start_all_dma(priv);
 
+	phylink_start(priv->phylink);
+
 	ret = stmmac_request_irq(dev);
 	if (ret)
 		goto irq_error;
 
 	/* Enable NAPI process*/
 	stmmac_enable_all_queues(priv);
-	netif_carrier_on(dev);
 	netif_tx_start_all_queues(dev);
 	stmmac_enable_all_dma_irq(priv);
 
 	return 0;
 
 irq_error:
+	phylink_stop(priv->phylink);
+
 	for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
 		hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
 
-- 
2.30.2


