Return-Path: <netdev+bounces-219918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5864BB43B2C
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 14:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7440217AFEB
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CB12C21D8;
	Thu,  4 Sep 2025 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mlgIdPmR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E552D46CB
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756987876; cv=none; b=PlXq2IjEwGaWJXDyQe42reL/lsxMpsMkpvARLakTqC8X5phZOxQajAlbakafJZRmM7YKXiZ1ZLRMGE5p/Qvmdpb3uVzLuLASbuXedFbLovpyQy+2OaQjbyBG5BiqvIAarR06F0rOoW0ipke0hSE2fubkzE/wSd4Cm+CBtONWK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756987876; c=relaxed/simple;
	bh=EwO2xXEJwHY5yTHGpdxqsmJCgVPJ7b8GRYo/X2EMQzY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=rhmYyCXE7hzKubJdYKR9eJjRsmdSDrMtznJnkge6wXiNGqL+A9fYKitHzgQfypxvQK41YX5nacbpQOLjnrYx8TJNMlNVi4dFH4IVT47NqwurA3nBhMPrpe4IyGd4+tVThaT75jtY2BrHYCtrqxA6UTHuuL2+2OSjy/Eh2lfNvNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mlgIdPmR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=09jzU5RnoK37mEWoerkBBMdU2xO5D5cZIVVTnpRSdkI=; b=mlgIdPmRkCa/S9QYhoiyeNMC37
	ojIScjRfDgLlMMyfK8dr8TjvM5ogIHRMljyNu8Uir8Cd+Tdxrk4iRSjf9Bxe/33pR3mqj3PaLk5bp
	kGyHkrQd138DV+KQHHbrAE3yWiXVXqbOGpaPKsPhg96FDQHm9GqF7+mjyF+1GlMAMB87gU0zIf1vn
	cFH5Huc71dPSgV4qE3Y84ty1zal+kTKQDTEBi8iB3Juh9XaoaqWFRQ7psc++1aUOfiC5KU7WXykhh
	neEW/j6J7Gew22TWXxmFTk9D9XYc1/LMiYpaL4eDNaKNyx60Le+Aw4KQQMOBwbrgQegd+aKIOkcJS
	mtdJ7L+Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:55610 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uu8ny-000000001xK-04Po;
	Thu, 04 Sep 2025 13:11:06 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uu8nx-00000001voa-0tJ0;
	Thu, 04 Sep 2025 13:11:05 +0100
In-Reply-To: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
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
Subject: [PATCH net-next v2 02/11] net: stmmac: mdio: provide
 stmmac_mdio_wait()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uu8nx-00000001voa-0tJ0@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 04 Sep 2025 13:11:05 +0100

All the readl_poll_timeout()s follow the same pattern - test a register
for a bit being clear every 100us, and timeout after 10ms returning
-EBUSY. Wrap this up into a function to avoid duplicating this.

This slightly changes the return value for stmmac_mdio_write() if the
second readl_poll_timeout() fails - rather than returning -ETIMEDOUT
we return -EBUSY matching the stmmac_mdio_read() behaviour.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 70 +++++++++----------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index c305c202055a..6acce54b5d55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -45,6 +45,16 @@
 #define MII_XGMAC_PA_SHIFT		16
 #define MII_XGMAC_DA_SHIFT		21
 
+static int stmmac_mdio_wait(void __iomem *reg, u32 mask)
+{
+	u32 v;
+
+	if (readl_poll_timeout(reg, v, !(v & mask), 100, 10000))
+		return -EBUSY;
+
+	return 0;
+}
+
 static void stmmac_xgmac2_c45_format(struct stmmac_priv *priv, int phyaddr,
 				     int devad, int phyreg, u32 *hw_addr)
 {
@@ -83,7 +93,6 @@ static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 tmp;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -91,33 +100,27 @@ static int stmmac_xgmac2_mdio_read(struct stmmac_priv *priv, u32 addr,
 		return ret;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
 	value |= MII_XGMAC_READ;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	/* Set the MII address register to read */
 	writel(addr, priv->ioaddr + mii_address);
 	writel(value, priv->ioaddr + mii_data);
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	/* Read the data from the MII data register */
 	ret = (int)readl(priv->ioaddr + mii_data) & GENMASK(15, 0);
@@ -160,7 +163,6 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 tmp;
 	int ret;
 
 	ret = pm_runtime_resume_and_get(priv->device);
@@ -168,11 +170,9 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 		return ret;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	value |= (priv->clk_csr << priv->hw->mii.clk_csr_shift)
 		& priv->hw->mii.clk_csr_mask;
@@ -180,19 +180,16 @@ static int stmmac_xgmac2_mdio_write(struct stmmac_priv *priv, u32 addr,
 	value |= MII_XGMAC_WRITE;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-			       !(tmp & MII_XGMAC_BUSY), 100, 10000)) {
-		ret = -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
+	if (ret)
 		goto err_disable_clks;
-	}
 
 	/* Set the MII address register to write */
 	writel(addr, priv->ioaddr + mii_address);
 	writel(value, priv->ioaddr + mii_data);
 
 	/* Wait until any existing MII operation is complete */
-	ret = readl_poll_timeout(priv->ioaddr + mii_data, tmp,
-				 !(tmp & MII_XGMAC_BUSY), 100, 10000);
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_data, MII_XGMAC_BUSY);
 
 err_disable_clks:
 	pm_runtime_put(priv->device);
@@ -253,18 +250,18 @@ static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 v;
+	int ret;
 
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000))
-		return -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	if (ret)
+		return ret;
 
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000))
-		return -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	if (ret)
+		return ret;
 
 	/* Read the data from the MII data register */
 	return readl(priv->ioaddr + mii_data) & MII_DATA_MASK;
@@ -340,20 +337,19 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
-	u32 v;
+	int ret;
 
 	/* Wait until any existing MII operation is complete */
-	if (readl_poll_timeout(priv->ioaddr + mii_address, v, !(v & MII_BUSY),
-			       100, 10000))
-		return -EBUSY;
+	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
+	if (ret)
+		return ret;
 
 	/* Set the MII address register to write */
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
 	/* Wait until any existing MII operation is complete */
-	return readl_poll_timeout(priv->ioaddr + mii_address, v,
-				  !(v & MII_BUSY), 100, 10000);
+	return stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
 }
 
 /**
-- 
2.47.2


