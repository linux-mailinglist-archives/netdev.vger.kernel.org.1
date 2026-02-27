Return-Path: <netdev+bounces-261796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMgcA5FqoWkOswQAu9opvQ
	(envelope-from <netdev+bounces-261796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:57:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0481B5A67
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 464D330E4D54
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81AF35A3AE;
	Fri, 27 Feb 2026 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="R8Po7Hch"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38401F03D7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186035; cv=none; b=Y27tHB7g3/BEYiyKpc+qonD5mJv7ItBJyxON2qfHJSeiwv2YwxXQlFqTYnmZWSG88YEBM6fgj02Mt3qBX2em6jBazxGEsmfJa/JLL3hc2tba4t0qXhiO0b46bw6Qm+bxA6nUSa1KP48T63hp5FUb+U3EM5tWIJ/jQuGAQ14TFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186035; c=relaxed/simple;
	bh=EvoCDTo5PoEy8M/dzTpk1t3G1jQCZmHQbLu9B2AMd+8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=TitsypprMoMb1L651LizGtXgTSgGO9TsziLqr3tv72VxomPD0rjmd61zN5pSnxGuGULOjVDnZ2h2m0vTgtJBsZlrwS19NIO4iqIHbVyAgzS0dFbd53zc191Fw04ZtBucy2D3P4TNSb5WCeu4gyfJSXP6ryd4XNalo5gt4g92/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=R8Po7Hch; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZorrloPfemvcsYMgP1UDQkKbx9xEkj+9egNHECL/Qqg=; b=R8Po7Hch/KhNtzaCZT60T0Y3ir
	EPgq+7WWGaRNmkBre2NyYLee0Sm+f+SYRcBIJ08F/2taBoHPvNL82+lm9gy+kpsw7SnDYUEkOpPHx
	sbwDOt7NtAWEihZzVaYxaC+ObcZX16mlOVjdE/PyP0gTRtrplV3PnwofOwM5pqrprpU85g9QVI1Tn
	MRki8njPwfE3vzfSurL2eBBSCAXzMYVlEEFZuEGHYU3ShGiARGLncYlq50EjzJQskJ8wRBKx+YvlR
	FWtQ5W0aqaJe4obO5Z/8DRRofJaSFTb0zlCvdlq3ECseGtg+gji0R2YRTiCkQ7lEtfKFds25Am08r
	RKDfr6tQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43986 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvuXS-000000000d9-0S0K;
	Fri, 27 Feb 2026 09:53:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvuXO-0000000Avn3-1hhD;
	Fri, 27 Feb 2026 09:53:34 +0000
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
Subject: [PATCH net-next 06/14] net: stmmac: remove dwmac4
 DMA_CHAN_INTR_DEFAULT_[TR]X*
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvuXO-0000000Avn3-1hhD@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 09:53:34 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261796-lists,netdev=lfdr.de,kernel];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rmk-PC.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 6C0481B5A67
X-Rspamd-Action: no action

Remove the DMA_CHAN_INTR_DEFAULT_[TR]X* definitions, which are aliases
of their respective DMA_CHAN_INTR_ENA_[TR]IE definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h |  4 ----
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 16 ++++++++--------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 9d9077a4ac9f..7fbd02a8119f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -111,8 +111,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 /* DMA default interrupt mask for 4.00 */
 #define DMA_CHAN_INTR_DEFAULT_MASK	(DMA_CHAN_INTR_NORMAL | \
 					 DMA_CHAN_INTR_ABNORMAL)
-#define DMA_CHAN_INTR_DEFAULT_RX	(DMA_CHAN_INTR_ENA_RIE)
-#define DMA_CHAN_INTR_DEFAULT_TX	(DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_NORMAL_4_10	(DMA_CHAN_INTR_ENA_NIE_4_10 | \
 					 DMA_CHAN_INTR_ENA_RIE | \
@@ -123,8 +121,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
 /* DMA default interrupt mask for 4.10a */
 #define DMA_CHAN_INTR_DEFAULT_MASK_4_10	(DMA_CHAN_INTR_NORMAL_4_10 | \
 					 DMA_CHAN_INTR_ABNORMAL_4_10)
-#define DMA_CHAN_INTR_DEFAULT_RX_4_10	(DMA_CHAN_INTR_ENA_RIE)
-#define DMA_CHAN_INTR_DEFAULT_TX_4_10	(DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_RX_WATCHDOG(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x38)
 #define DMA_CHAN_SLOT_CTRL_STATUS(addrs, x)	(dma_chanx_base_addr(addrs, x) + 0x3c)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index c098047a3bff..9217308bfd38 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -116,9 +116,9 @@ void dwmac4_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 
 	if (rx)
-		value |= DMA_CHAN_INTR_DEFAULT_RX;
+		value |= DMA_CHAN_INTR_ENA_RIE;
 	if (tx)
-		value |= DMA_CHAN_INTR_DEFAULT_TX;
+		value |= DMA_CHAN_INTR_ENA_TIE;
 
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
@@ -130,9 +130,9 @@ void dwmac410_enable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 
 	if (rx)
-		value |= DMA_CHAN_INTR_DEFAULT_RX_4_10;
+		value |= DMA_CHAN_INTR_ENA_RIE;
 	if (tx)
-		value |= DMA_CHAN_INTR_DEFAULT_TX_4_10;
+		value |= DMA_CHAN_INTR_ENA_TIE;
 
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
@@ -144,9 +144,9 @@ void dwmac4_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 
 	if (rx)
-		value &= ~DMA_CHAN_INTR_DEFAULT_RX;
+		value &= ~DMA_CHAN_INTR_ENA_RIE;
 	if (tx)
-		value &= ~DMA_CHAN_INTR_DEFAULT_TX;
+		value &= ~DMA_CHAN_INTR_ENA_TIE;
 
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
@@ -158,9 +158,9 @@ void dwmac410_disable_dma_irq(struct stmmac_priv *priv, void __iomem *ioaddr,
 	u32 value = readl(ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 
 	if (rx)
-		value &= ~DMA_CHAN_INTR_DEFAULT_RX_4_10;
+		value &= ~DMA_CHAN_INTR_ENA_RIE;
 	if (tx)
-		value &= ~DMA_CHAN_INTR_DEFAULT_TX_4_10;
+		value &= ~DMA_CHAN_INTR_ENA_TIE;
 
 	writel(value, ioaddr + DMA_CHAN_INTR_ENA(dwmac4_addrs, chan));
 }
-- 
2.47.3


