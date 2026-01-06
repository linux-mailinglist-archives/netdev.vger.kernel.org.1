Return-Path: <netdev+bounces-247459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6241CFAEE8
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8158E302922C
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12FC33A6F4;
	Tue,  6 Jan 2026 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SCIaDDuO"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3065D1D47B4
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731491; cv=none; b=Qv939CSWXj5HUaw573NjYru04zLpG8LFp3VMqLg13QOpjnfaaZOvjjyX9BkAQikboyHBfCHH4RN8QJqwqp5u4cideY77nYLVQhcuuT6Xe74sdFD9+kH8mUfX9iKuvZ4edN3LFqZRHt2n3MVhmChsTdr898psF/mZ7c7czvUeM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731491; c=relaxed/simple;
	bh=1e9hCafsqlfIn/9PTUB5R0dsvrWMEtdcI2CaozOOVOQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=IO9Wr8SVq7YsogXf1wWb7v05wQ2VzsZM72kqH/PlqGAk+n2O/sySI3S5EuRw6RbXNkSp4idB6aItm/qMiun0p18DwH8s9Z0lY0t0er25TwL7L6uKIChAKVheq2RE31c41EWY+BIu102794rVutErCeh2Kza1Rqr9L5RLlv2YjGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SCIaDDuO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Luh25YQfp2M+J9LmqGBEzB403xFiDCfMCyzxptMa4QY=; b=SCIaDDuOwJIryBMgZtdCz9jetm
	djnmffVj60OkJkmqKQGusroN6fRsvNYGyrnVYvMoIIH9mSwzy6O2YbgvV9lBXVCceC6p1R4P9Fgqv
	HG062RbSx/wSDmcvrPq+PzFHby/ktla7BmJ5NbJe1MoQRQJp+t3T+FocL1dvLA06iBt+k5ERvghMf
	iwgLjZpeWNTcOcgf9cDqqBPK2bDm6sbJaJ4PgJLrW6d42OU+dZQK1VeGH3ZXmS4Gju4zx4ZG2wFDC
	dWVLgF4ofs9hG8dAjrudtE+0s8xdxU7CHRy8UTiHktdVWIfuXrUy7zkTc2aaj1l1FIWciCu5WDFf5
	IG8vcvCw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46278 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vdDi6-0000000010m-3IIV;
	Tue, 06 Jan 2026 20:31:22 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vdDi5-00000002E1P-24pm;
	Tue, 06 Jan 2026 20:31:21 +0000
In-Reply-To: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
References: <aV1w9yxPwL990yZJ@shell.armlinux.org.uk>
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
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 2/9] net: stmmac: dwmac4: fix RX FIFO fill statistics
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vdDi5-00000002E1P-24pm@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 06 Jan 2026 20:31:21 +0000

In dwmac4_debug(), the wrong shift is used with the RXFSTS mask:

 #define MTL_DEBUG_RXFSTS_MASK          GENMASK(5, 4)
 #define MTL_DEBUG_RXFSTS_SHIFT         4
 #define MTL_DEBUG_RRCSTS_SHIFT         1

                       u32 rxfsts = (value & MTL_DEBUG_RXFSTS_MASK)
                                    >> MTL_DEBUG_RRCSTS_SHIFT;

where rxfsts is tested against small integers 1 .. 3. This results in
the tests always failing, causing the "mtl_rx_fifo__fill_level_empty"
statistic counter to always be incremented no matter what the fill
level actually is.

Fix this by using FIELD_GET() and remove the unnecessary
MTL_DEBUG_RXFSTS_SHIFT definition as FIELD_GET() will shift according
to the least siginificant set bit in the supplied field mask.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4.h      | 1 -
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
index fa27639895ce..3da6891b9df7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4.h
@@ -460,7 +460,6 @@ static inline u32 mtl_low_credx_base_addr(const struct dwmac4_addrs *addrs,
 
 /* MAC debug: GMII or MII Transmit Protocol Engine Status */
 #define MTL_DEBUG_RXFSTS_MASK		GENMASK(5, 4)
-#define MTL_DEBUG_RXFSTS_SHIFT		4
 #define MTL_DEBUG_RXFSTS_EMPTY		0
 #define MTL_DEBUG_RXFSTS_BT		1
 #define MTL_DEBUG_RXFSTS_AT		2
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index a4282fd7c3c7..bd5f48d0b9fc 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -700,8 +700,7 @@ static void dwmac4_debug(struct stmmac_priv *priv, void __iomem *ioaddr,
 		value = readl(ioaddr + MTL_CHAN_RX_DEBUG(dwmac4_addrs, queue));
 
 		if (value & MTL_DEBUG_RXFSTS_MASK) {
-			u32 rxfsts = (value & MTL_DEBUG_RXFSTS_MASK)
-				     >> MTL_DEBUG_RRCSTS_SHIFT;
+			u32 rxfsts = FIELD_GET(MTL_DEBUG_RXFSTS_MASK, value);
 
 			if (rxfsts == MTL_DEBUG_RXFSTS_FULL)
 				x->mtl_rx_fifo_fill_level_full++;
-- 
2.47.3


