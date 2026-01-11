Return-Path: <netdev+bounces-248812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9985FD0EF6C
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 14:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E64C030034A7
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 13:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5A33E348;
	Sun, 11 Jan 2026 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QVIR/Dfl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637124397A
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137335; cv=none; b=H346bZaDzWSfkF1j2ZlSpcmfBy0TdyWKBXBr9NuuH4S5EfCcW2c4qZOYci8qlMSM6xihOPCF8ERa04h1cppllYiRLs1J9fCp95l9rQHjWs5Sm9LZwcFIckXvXea2rONCv/w9p0R6UU0Y3YDskPFkZgyuTVmhB5aTJTNFpaumsmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137335; c=relaxed/simple;
	bh=Q8qcv+5QH7L4mrvbmICzTW3K78hb4pqwlbARUP9EoAQ=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=Yxj01r3+FMCLIsmsxJF+8CMBKY58gAUmyV7Jyg61llcGRdcxHsr6uYIQXxVelw1iSUZEe2v6OYkgArP7wHs1v21QyLnpbt+DLDv4z5dymCklYGpy8fDVCCEK7LcrbHDtgzm8VcU1fKzGVhmYzdENDVZz6P/e3ZZkOlfQ854hYVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QVIR/Dfl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WSNhvw1vyae2rSZSCNCBJzYosUcuU20D4rv5WQm3Glg=; b=QVIR/DflJl5rQj+fATGbDJ5XFo
	FWCphEu0AxcT1+/LcKwPb6/lGer4WJ5q80fSaeSl7g4Ier5ZCQbVo/+NPLtaqfy6kwHL9ViyC90N/
	Jn/bLFOjH9kDaTE9FiwIrHSqmgI3JCfpsr2OxlXacxYPRdg6RVkiMasxMulQJJsFRzip3vAHLxq5k
	uqInOEgnUqPF1VN1U1riI6O7EvPv/ZsoFbATzlZKVD8svAj3leoOe/Uzg+BNVhTvon65NSKRsq3kG
	7bSeoQI903mcLQsZYZDggnYYRRNguvrJenWZQ4Zg9s8YL52/hLlkoXfYb75KphkfWtiPPHGxUa892
	I1mdjK+w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:42264 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vevHx-000000005Uh-2Rqn;
	Sun, 11 Jan 2026 13:15:25 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vevHw-00000002Yoz-35A7;
	Sun, 11 Jan 2026 13:15:24 +0000
In-Reply-To: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
References: <aWOiOfDQkMXDwtPp@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 4/5] net: stmmac: change arguments to PCS handler and
 use dev_info()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vevHw-00000002Yoz-35A7@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Sun, 11 Jan 2026 13:15:24 +0000

Change the arguments to the PCS handler so that it can access the
struct device pointer and integrated PCS pointers.

This allows us to use the PCS register offset stored in struct
stmmac_pcs rather than passing it into the function, and also allows
the messages to be printed using dev_info() rather than pr_info(),
thereby allowing the stmmac instance to be identified.

Finally, as dev_info() identifies the driver/device, prefixing with
"stmmac_pcs: " is now redundant, so replace this with just "PCS ".

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac1000_core.c  |  3 +-
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c |  3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.c  | 28 ++++++-------------
 .../net/ethernet/stmicro/stmmac/stmmac_pcs.h  |  3 +-
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
index b01815a28280..3756d3c4ee15 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_core.c
@@ -305,8 +305,7 @@ static int dwmac1000_irq_status(struct stmmac_priv *priv,
 	}
 
 	if (intr_status & (PCS_ANE_IRQ | PCS_LINK_IRQ))
-		stmmac_integrated_pcs_irq(ioaddr, GMAC_PCS_BASE, intr_status,
-					  x);
+		stmmac_integrated_pcs_irq(priv, intr_status, x);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index e7ca181e8e76..a9ec9a34ebca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -659,8 +659,7 @@ static int dwmac4_irq_status(struct stmmac_priv *priv,
 	}
 
 	if (intr_status & (PCS_ANE_IRQ | PCS_LINK_IRQ))
-		stmmac_integrated_pcs_irq(ioaddr, GMAC_PCS_BASE, intr_status,
-					  x);
+		stmmac_integrated_pcs_irq(priv, intr_status, x);
 
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
index 90cdff30520b..28748e7ef7dd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c
@@ -45,33 +45,23 @@ static const struct phylink_pcs_ops dwmac_integrated_pcs_ops = {
 	.pcs_config = dwmac_integrated_pcs_config,
 };
 
-/**
- * stmmac_integrated_pcs_irq - TBI, RTBI, or SGMII PHY ISR
- * @ioaddr: IO registers pointer
- * @reg: Base address of the AN Control Register.
- * @intr_status: GMAC core interrupt status
- * @x: pointer to log these events as stats
- * Description: it is the ISR for PCS events: Auto-Negotiation Completed and
- * Link status.
- */
-void stmmac_integrated_pcs_irq(void __iomem *ioaddr, u32 reg,
-			       unsigned int intr_status,
+void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 			       struct stmmac_extra_stats *x)
 {
-	u32 val = readl(ioaddr + GMAC_AN_STATUS(reg));
+	struct stmmac_pcs *spcs = priv->integrated_pcs;
+	u32 val = readl(spcs->base + GMAC_AN_STATUS(0));
 
-	if (intr_status & PCS_ANE_IRQ) {
+	if (status & PCS_ANE_IRQ) {
 		x->irq_pcs_ane_n++;
 		if (val & GMAC_AN_STATUS_ANC)
-			pr_info("stmmac_pcs: ANE process completed\n");
+			dev_info(priv->device,
+				 "PCS ANE process completed\n");
 	}
 
-	if (intr_status & PCS_LINK_IRQ) {
+	if (status & PCS_LINK_IRQ) {
 		x->irq_pcs_link_n++;
-		if (val & GMAC_AN_STATUS_LS)
-			pr_info("stmmac_pcs: Link Up\n");
-		else
-			pr_info("stmmac_pcs: Link Down\n");
+		dev_info(priv->device, "PCS Link %s\n",
+			 val & GMAC_AN_STATUS_LS ? "Up" : "Down");
 	}
 }
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
index bfc3d665265c..c4e6b242d390 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.h
@@ -62,8 +62,7 @@ phylink_pcs_to_stmmac_pcs(struct phylink_pcs *pcs)
 	return container_of(pcs, struct stmmac_pcs, pcs);
 }
 
-void stmmac_integrated_pcs_irq(void __iomem *ioaddr, u32 reg,
-			       unsigned int intr_status,
+void stmmac_integrated_pcs_irq(struct stmmac_priv *priv, u32 status,
 			       struct stmmac_extra_stats *x);
 int stmmac_integrated_pcs_init(struct stmmac_priv *priv, unsigned int offset,
 			       u32 int_mask);
-- 
2.47.3


