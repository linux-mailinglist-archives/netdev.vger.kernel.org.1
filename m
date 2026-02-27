Return-Path: <netdev+bounces-261797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K80BbZpoWkUsgQAu9opvQ
	(envelope-from <netdev+bounces-261797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:53:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B8B1B59A5
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14C8A3030A3C
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C036CDE9;
	Fri, 27 Feb 2026 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XqXR5twb"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3F7364934
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186035; cv=none; b=buNZrnHLXjbuCCNkWrwWWao6KLC4na95Aqo/x2jnjpCJVNv5/8+mnzczM74JeV0U3mNaO72y8qb9WINnIBHJNNnxga/ll71luTx0aKoiYGGf9Ft7TA1PgxCT5z1n8gXGyrqY9PFuRVhWBV6Pg0U/b+yl3W16fnoVoZxng1TO3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186035; c=relaxed/simple;
	bh=pzptHLWBLc5DID1qaNqwupeHFmKd7Ku2vd7StdBuWm8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XUkCE7LDE4GLrDdbqTZVqk5rTBv5h0FaPhUpyJ7FV+TW8pPJ06MZSCQofLuPuaLenR/KWGWRr1w1nOUx6ZEfZvQxXulr2Z+RZpOWDEKB/3ftnqUbA+o6RhqrpKTyoik7B2avPCFZDg4M7heqAPCRl76o6OyA72OfRlxuN1VjQjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XqXR5twb; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bf1QswQcmBvRnk87FFzbebb6xULLTXkeOFLe8YFoLoI=; b=XqXR5twb4rZe3u9oLt6RA55jd9
	jXevEjJ0eoiN9U4uU1Y3YEP4k7rMz11sWq/UU3JIOUWaMl0uNHu2LUsv2otP8HbZsoCqF5YrzrKDh
	HVlfh+005MnqpRN2buhaq9DYbwBStJ2Qyw4G77cO3ecI7syU9nJBoBeDxNQJ2hQHq6UVbn7Pr0zHI
	QS12+yT2gU+2rj+FbnxvEfUkANxx9s95Uwn8FfqUT881JQVqrQz6LNIY3vc2GH/QBZaZKNjfMA7Pl
	ii7pFzOEqxJZ6u95pTSNlDyzS8L/ExLOzhdNCr1tFOOBshdevl51XSC21ENj8OCpLwCK7+tFO1dQO
	KH46cFKw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42698 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXV-000000000dR-1zvu;
	Fri, 27 Feb 2026 09:53:41 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXT-0000000Avn9-29US;
	Fri, 27 Feb 2026 09:53:39 +0000
In-Reply-To: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
References: <aaFpZvuIzOLaNM0m@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 07/14] net: stmmac: remove
 dwmac410_(enable|disable)_dma_irq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXT-0000000Avn9-29US@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:39 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261797-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.981];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: B1B8B1B59A5
X-Rspamd-Action: no action

As a result of the previous cleanup, it is now obvious that there are
no differences between the dwmac4 and dwmac410 versions of the DMA
interrupt enable/disable functions.

Moreover, dwmac410_disable_dma_irq() is completely unused; instead,
dwmac4_disable_dma_irq() is used to disable the interrupts for v4.10a
cores while dwmac410_enable_dma_irq() was being used to enable these
same same interrupts.

Remove the unnecessary v4.10a functions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_dma.h  |  4 ---
 .../net/ethernet/stmicro/stmmac/dwmac4_lib.c  | 28 -------------------
 3 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 60b880cdd9da..28728271fbc9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@ -582,7 +582,7 @@ const struct stmmac_dma_ops dwmac410_dma_ops = {
 	.dump_regs = dwmac4_dump_dma_regs,
 	.dma_rx_mode = dwmac4_dma_rx_chan_op_mode,
 	.dma_tx_mode = dwmac4_dma_tx_chan_op_mode,
-	.enable_dma_irq = dwmac410_enable_dma_irq,
+	.enable_dma_irq = dwmac4_enable_dma_irq,
 	.disable_dma_irq = dwmac4_disable_dma_irq,
 	.start_tx = dwmac4_dma_start_tx,
 	.stop_tx = dwmac4_dma_stop_tx,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 7fbd02a8119f..af6580332d49 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -170,12 +170,8 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 int dwmac4_dma_reset(void __iomem *ioaddr);
 void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			   u32 chan, bool rx, bool tx);
-void dwmac410_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
-			     u32 chan, bool rx, bool tx);
 void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    u32 chan, bool rx, bool tx);
-void dwmac410_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
-			      u32 chan, bool rx, bool tx);
 void dwmac4_dma_start_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
 			 u32 chan);
 void dwmac4_dma_stop_tx(struct stmmac_priv *priv, void __iomem *ioaddr,
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index 9217308bfd38..8c87a20880c4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -123,20 +123,6 @@ void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
 
-void dwmac410_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
-			     u32 chan, bool rx, bool tx)
-{
-	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
-	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
-
-	if (rx)
-		value |= DMA_CHAN_INTR_ENA_RIE;
-	if (tx)
-		value |= DMA_CHAN_INTR_ENA_TIE;
-
-	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
-}
-
 void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 			    u32 chan, bool rx, bool tx)
 {
@@ -151,20 +137,6 @@ void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
 
-void dwmac410_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
-			      u32 chan, bool rx, bool tx)
-{
-	const struct dwmac4_addrs *dwmac4_addrs = priv->plat->dwmac4_addrs;
-	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
-
-	if (rx)
-		value &= ~DMA_CHAN_INTR_ENA_RIE;
-	if (tx)
-		value &= ~DMA_CHAN_INTR_ENA_TIE;
-
-	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
-}
-
 int dwmac4_dma_interrupt(struct stmmac_priv *priv, void __iomem *ioaddr,
 			 struct stmmac_extra_stats *x, u32 chan, u32 dir)
 {
-- 
2.47.3


