Return-Path: <netdev+bounces-253468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKtsKxlfd2n8eQEAu9opvQ
	(envelope-from <netdev+bounces-253468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:33:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E9C884CC
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA436300644C
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91FA337111;
	Mon, 26 Jan 2026 12:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hWxLtS7B"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252562BEC5E
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769430805; cv=none; b=HeX1h3Zt9XTR5D+Y0So2ubYI59AQOa4VavJV41dxAPzo4ZMgqruFRl5nlIPd6o5k4lDN/5J+l8lNyAarMYS7BuFdO+B/eP0KsH+sTC3LlWoabaxe/shGHhmi2CZ5NKvLvFkGs6IUla70IDEUPKoXVZx0UbpUJ5+OR77uGGSBtC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769430805; c=relaxed/simple;
	bh=OaxYGudCI5gkMkHS471pmUeXDsGjJOqSNIu5Rs/mAzA=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=uf1D20y6ktnfMKA48lA8cCjNgjSiWwGDsZ8u9kgYI28cUrip3Rpu8ogUs0IHymTHOgWhXuZzgrGq5EZfKTZCYMoni9ofWNGNCV10wBtv7ArA9ZjpObRTXwfVNbfInoyYAd5E9Mom0YHI1kqk2zq5vfVOZWhaDA47rPrO6GASUqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hWxLtS7B; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Wg/dOnG781SWjs7CoGEbkT1P6etmPjivu2HuJgD0COY=; b=hWxLtS7BpmMeAI9fBkfEvqzDge
	DXnVM4bgozkpzZaoqlIZweq2goDdXp9qbnd8XA5qnSFEmxOAI25winOvkWxW+z3qNwmVxIK7cPMpC
	2AUw8cF5Rqtgbw1QlCr6XA1nxQA2SjBOzdvVo+chp/GU79rCeFuXDcncy1FTwmD95EM5NPXNfafaZ
	SiShaRwGILyh2SKZBEGPUisDLB3MAXNchj/12Rh4e24PS3O7X/9SipnuATgsWmsVXD6IymczsfOwZ
	2jyAod1I/FEWcdM2E9zoRpl0PK6Hhn6XO+/auKezJ5rwlMR7Gfgdy3rmgvDRDHoL1zkU3PpuCTMA6
	eMFx1IsA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50600 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vkLmM-000000004oZ-40gK;
	Mon, 26 Jan 2026 12:33:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vkLmM-00000005vE1-0nop;
	Mon, 26 Jan 2026 12:33:14 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next] net: stmmac: don't pass ioaddr to fix_soc_reset()
 method
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vkLmM-00000005vE1-0nop@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 26 Jan 2026 12:33:14 +0000
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253468-lists,netdev=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[rmk@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rmk-PC.armlinux.org.uk:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 73E9C884CC
X-Rspamd-Action: no action

As the stmmac_priv struct is passed to the fix_soc_reset() method which
has the ioaddr, there is no need to pass ioaddr separately. Pass just
the stmmac_priv struct. Fix up the glues that use it.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c      | 8 +++++---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 6 ++++--
 drivers/net/ethernet/stmicro/stmmac/hwif.c           | 2 +-
 include/linux/stmmac.h                               | 2 +-
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index c722ff2dc1fc..97de4726208e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -46,7 +46,7 @@ struct imx_dwmac_ops {
 	u32 flags;
 	bool mac_rgmii_txclk_auto_adj;
 
-	int (*fix_soc_reset)(struct stmmac_priv *priv, void __iomem *ioaddr);
+	int (*fix_soc_reset)(struct stmmac_priv *priv);
 	int (*set_intf_mode)(struct imx_priv_data *dwmac, u8 phy_intf_sel);
 	void (*fix_mac_speed)(void *priv, int speed, unsigned int mode);
 };
@@ -220,12 +220,14 @@ static void imx93_dwmac_fix_speed(void *priv, int speed, unsigned int mode)
 	writel(old_ctrl, dwmac->base_addr + MAC_CTRL_REG);
 }
 
-static int imx_dwmac_mx93_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
+static int imx_dwmac_mx93_reset(struct stmmac_priv *priv)
 {
 	struct plat_stmmacenet_data *plat_dat = priv->plat;
-	u32 value = readl(ioaddr + DMA_BUS_MODE);
+	void __iomem *ioaddr = priv->ioaddr;
+	u32 value;
 
 	/* DMA SW reset */
+	value = readl(ioaddr + DMA_BUS_MODE);
 	value |= DMA_BUS_MODE_SFT_RESET;
 	writel(value, ioaddr + DMA_BUS_MODE);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 4f2b5bd6cb31..ed0b534d8d7b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -485,10 +485,12 @@ static int loongson_dwmac_acpi_config(struct pci_dev *pdev,
 }
 
 /* Loongson's DWMAC device may take nearly two seconds to complete DMA reset */
-static int loongson_dwmac_fix_reset(struct stmmac_priv *priv, void __iomem *ioaddr)
+static int loongson_dwmac_fix_reset(struct stmmac_priv *priv)
 {
-	u32 value = readl(ioaddr + DMA_BUS_MODE);
+	void __iomem *ioaddr = priv->ioaddr;
+	u32 value;
 
+	value = readl(ioaddr + DMA_BUS_MODE);
 	if (value & DMA_BUS_MODE_SFT_RESET) {
 		netdev_err(priv->dev, "the PHY clock is missing\n");
 		return -EINVAL;
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/ethernet/stmicro/stmmac/hwif.c
index 014f7cd79a3c..7e69ff4b9a98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
@@ -109,7 +109,7 @@ int stmmac_reset(struct stmmac_priv *priv)
 	void __iomem *ioaddr = priv->ioaddr;
 
 	if (plat && plat->fix_soc_reset)
-		return plat->fix_soc_reset(priv, ioaddr);
+		return plat->fix_soc_reset(priv);
 
 	return stmmac_do_callback(priv, dma, reset, ioaddr);
 }
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index e308c98c7bd3..5199451dd0bc 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -257,7 +257,7 @@ struct plat_stmmacenet_data {
 	int (*set_clk_tx_rate)(void *priv, struct clk *clk_tx_i,
 			       phy_interface_t interface, int speed);
 	void (*fix_mac_speed)(void *priv, int speed, unsigned int mode);
-	int (*fix_soc_reset)(struct stmmac_priv *priv, void __iomem *ioaddr);
+	int (*fix_soc_reset)(struct stmmac_priv *priv);
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	int (*mac_finish)(struct net_device *ndev,
-- 
2.47.3


