Return-Path: <netdev+bounces-170323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C63A4828D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7901606F7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 15:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823D266190;
	Thu, 27 Feb 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fKjB7U/s"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C95A23816C
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740668734; cv=none; b=PpXAiElScSEEFc+1vWckp9VW0g3P2ZCTvWrvM1juXpb8QvTaRM3Jw3lp1fEYnPaoqHuKxcrl4M8Pj1FNuajzm+LZYD9/3rs5VHBkAO+M8p7RGMnCbpe3lpmQ3HtJyQ/0Xj1ZC7uKRBegTaQQBWG3h6lXZxtOvfuO0nE1s82Xgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740668734; c=relaxed/simple;
	bh=KcioZhvzHRDUd/v+inWiqDKXNTsnqnkwkwTXAUdBH3Q=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=ogtgBDnPCh5DkLxfm+ZphonKuXWyg9OUQlFW8h1g9bJN/mSI0E+OGJ5T1+yE84K3hF2B0Hnkif6oW0TPhOyEs/tFdpQPj5rfYvqyiUA0j0b6i57qZpQeNVR/yv8XGc9zml4YbfsWuxm+fWd+9Gd7MnysYKD+Xqzl16i5u+7dxm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fKjB7U/s; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PeDwYN+9O7ofBfdGjMQgostKcsW9CtPj8yKA2FA+gnQ=; b=fKjB7U/sPzjpaWnvnHuoQuyRgG
	wZBrdPenKuIJhclehBhbAjcb8axTDwJBoR3vcO1Vv6zab6McpqgkftdKTc3wkWJthAUhYvFXjnsqI
	1OgCtI2u+VPKBkOfdHZ5zS+s/FjdBrP7hil83VTxYmZ/TXp20xozg9RZzvj8sFCs/e5cfVTr1rbeN
	/zdwOCzDevN8DcM+kiAG1rk2wu/t09S9/D1hMraC8rD4Ygw7KpyXDqb6T/I/B0unT4UBxNCw4Kheq
	J5ANY94GeC7ePeXP8j9PAlJZHMhHtPSC3qUjRw5JSixDtpjt9jDgTdPkbjYDgCEIeT7HS72DqRZqe
	Ax4JYkTw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46938 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tnfRy-0007WX-0X;
	Thu, 27 Feb 2025 15:05:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tnfRe-0057S9-6W; Thu, 27 Feb 2025 15:05:02 +0000
In-Reply-To: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
References: <Z8B-DPGhuibIjiA7@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH RFC net-next 1/5] net: stmmac: call phylink_start() and
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
Message-Id: <E1tnfRe-0057S9-6W@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 27 Feb 2025 15:05:02 +0000

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

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 13796b1c8d7c..84d8b1c9f6d4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6887,6 +6887,8 @@ void stmmac_xdp_release(struct net_device *dev)
 	/* Ensure tx function is not running */
 	netif_tx_disable(dev);
 
+	phylink_stop(priv->phylink);
+
 	/* Disable NAPI process */
 	stmmac_disable_all_queues(priv);
 
@@ -6902,14 +6904,10 @@ void stmmac_xdp_release(struct net_device *dev)
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
@@ -6992,25 +6990,25 @@ int stmmac_xdp_open(struct net_device *dev)
 		tx_q->txtimer.function = stmmac_tx_timer;
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


