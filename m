Return-Path: <netdev+bounces-237583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB17EC4D694
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 12:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2097B3A5D1F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2D02F7479;
	Tue, 11 Nov 2025 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DMBpCpcs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8928339708
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 11:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762860410; cv=none; b=MuHlVVRT2UmV6imjJPJR4md4xtK5PEnAqFN7aotlPp5s5WezpXlclogQSccpvyg9S0vX4ucrDPJd9uLOh+PV+h7aLX3W+lWK11ijkN09sEa3mszu7en/pauRaHHFO7fGatCwHaZjTYUNFkunJroUhf1i4tce8QZxvMnSFxYVfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762860410; c=relaxed/simple;
	bh=DAFaKVgmG1X4jF9A80tS9X+m8RYeEWiPeJ/7W1FgvLU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=G12PA8JAcecFRF5aOsrzBiFB+L30lC5ArI+/1DN0+L3BeE+5iBN3SaFWrMvO0iSEB4/UkM81Ewu02+5574uKiuN4FRTCFlAEJv/kiIfU6pxhCFaHon7FSvCF3ymT7xV5emO+7D3BNqL+nTfi/CcUF/uq5G5dIKTnq296ZLsFvV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DMBpCpcs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zsfJ+olgcWefQZWLK01j9ksweF/zZC4+ckiHnhVmTSM=; b=DMBpCpcsyjMgu7m2jqNJh2ZPQK
	gUH0Sfb6tAQkHJgRkfWujCROHyohPtSF1//JP8a802YcQbhzkNrVCbroV6r14o3X729AA97PWUaYO
	ksGz4iP/KcDNDNjJRGlv8vUi1DIcCpaT6lFXcsHUTiu1DSkmmQAU6+1nM+D+fBTiy7QjyELxg4mt7
	K73uFdX7hpbE3C5vXCHHTaXoqKp6CeLKrsBs7/WHcHPmx0EaApTamLsUUQgfCR4Zq0LvgUGWGKUdw
	iapqy5b5N/xBG3Ve1wcSMjUrexFPko1g5swgVqFGHntuLbqhoV9ddHMy4aNrvECqBU4A1E0ShGBOb
	XXma21AA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:60616 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vImWG-000000002U1-0lkg;
	Tue, 11 Nov 2025 11:26:40 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vImWF-0000000DrIr-1fmn;
	Tue, 11 Nov 2025 11:26:39 +0000
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
Subject: [PATCH net-next] net: stmmac: clean up stmmac_reset()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vImWF-0000000DrIr-1fmn@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 11 Nov 2025 11:26:39 +0000

stmmac_reset() takes the stmmac_priv and an ioaddr. It has one call
site, which passes the priv pointer, and dereferences priv for the
ioaddr.

stmmac_reset() then checks whether priv is NULL. If it was, the caller
would have oopsed. Remove the checks for NULL, and move the dereference
for ioaddr into stmmac_reset().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/hwif.c        | 8 +++-----
 drivers/net/ethernet/stmicro/stmmac/hwif.h        | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 8212441f9826..ee612cadbd77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -103,12 +103,10 @@ static int stmmac_dwxlgmac_quirks(struct stmmac_priv *priv)
 	return 0;
 }
 
-int stmmac_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
+int stmmac_reset(struct stmmac_priv *priv)
 {
-	struct plat_stmmacenet_data *plat = priv ? priv->plat : NULL;
-
-	if (!priv)
-		return -EINVAL;
+	struct plat_stmmacenet_data *plat = priv->plat;
+	void __iomem *ioaddr = priv->ioaddr;
 
 	if (plat && plat->fix_soc_reset)
 		return plat->fix_soc_reset(priv, ioaddr);
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index cb8fc09caf86..d359722100fa 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -698,7 +698,7 @@ extern const struct stmmac_tc_ops dwmac510_tc_ops;
 #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
 #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
 
-int stmmac_reset(struct stmmac_priv *priv, void __iomem *ioaddr);
+int stmmac_reset(struct stmmac_priv *priv);
 int stmmac_hwif_init(struct stmmac_priv *priv);
 
 #endif /* __STMMAC_HWIF_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index eb4350193996..d202f604161e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3162,7 +3162,7 @@ static int stmmac_init_dma_engine(struct stmmac_priv *priv)
 	if (ret)
 		return ret;
 
-	ret = stmmac_reset(priv, priv->ioaddr);
+	ret = stmmac_reset(priv);
 	if (ret) {
 		netdev_err(priv->dev, "Failed to reset the dma\n");
 		return ret;
-- 
2.47.3


