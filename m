Return-Path: <netdev+bounces-219563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FB8B41F64
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63523A4348
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 12:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEDE2FFDCB;
	Wed,  3 Sep 2025 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mmZD0HqN"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512A22E7631
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903185; cv=none; b=Ja/AZ7gPGowx4WVm1/6yvjyce8C/GPixjqqfwpNY7lWYAAQ7XzM6dIx0sOdFvS/cVpj2mwZYCIYUhuIs9p+njTJaEEXz3p5R0adIgDOJXpc2lOHJMNVLb+PhxTnAVpCDVyacJPVmjTDWi8Q4Cnn35FZ3i7t1NpuCP4ReQR+QoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903185; c=relaxed/simple;
	bh=epja36SbtLMWzcwprWQoMnL4/o/BVvqWzHosYEpaTaM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=RjwjoO56xzxogv1tBf7XXxJ0dNyDA+GRsYsijzjAf4BJSYWCBD4FFgjtONhkanXv0Yf7+fMJrz+lxzwDrgl53Gzd9LaNSdUWP1FAYypHNDmxxhTZrWSuKBSE9qDfkKZUhlw5YANcmdr40/IvD7p2F3e3TIlhqNSox9p+S55EbKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mmZD0HqN; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MqYxTQI+DGW4jWLwQ5AzqVwMKT+E7RNgsllxaToWBcE=; b=mmZD0HqNBi8Lu0/BA2PHa8SAN/
	8BPd8PL4BY2NDsJM0sHlAextIbdWKXCQK90h3VX5zoluYkENQny7QCpO5j/Vr5IG3A3bBPaI2cWRd
	lAO+dijV1+lCJ5UeaaqoOmdemB885MoqsQ15OVgWv/2iDx47gRLCH28goKKt6SdRafKPj3sb21YQB
	FvkMt909EqlY6mNBagOiFgJoIDzekey5UyPV842bNJMNYTwAXFOUG7Ivu38dh7PvDRTYuWp6nXwnR
	np53AFGwQluv9EaYoir8MEKp6cS5znnhdhhRxAV625X0OaXHwW5VK+NocxmpikbI5bizBa4VtQL3N
	sihS6LfA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37360 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1utmlz-000000000Vd-0RSV;
	Wed, 03 Sep 2025 13:39:35 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1utmly-00000001s0I-1U6i;
	Wed, 03 Sep 2025 13:39:34 +0100
In-Reply-To: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
References: <aLg24RZ6hodr711j@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 04/11] net: stmmac: mdio: move
 stmmac_mdio_format_addr() into read/write
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1utmly-00000001s0I-1U6i@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 03 Sep 2025 13:39:34 +0100

Move stmmac_mdio_format_addr() into stmmac_mdio_read() and
stmmac_mdio_write().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 46 ++++++++++---------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index 2267a93ce44d..dafe97a49d1f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -238,16 +238,20 @@ static u32 stmmac_mdio_format_addr(struct stmmac_priv *priv,
 	       MII_BUSY;
 }
 
-static int stmmac_mdio_read(struct stmmac_priv *priv, int data, u32 value)
+static int stmmac_mdio_read(struct stmmac_priv *priv, unsigned int pa,
+			    unsigned int gr, u32 cmd, int data)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
+	u32 value;
 	int ret;
 
 	ret = stmmac_mdio_wait(priv->ioaddr + mii_address, MII_BUSY);
 	if (ret)
 		return ret;
 
+	value = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
+
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
 
@@ -273,17 +277,18 @@ static int stmmac_mdio_read_c22(struct mii_bus *bus, int phyaddr, int phyreg)
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int data = 0;
-	u32 value;
+	u32 cmd;
 
 	data = pm_runtime_resume_and_get(priv->device);
 	if (data < 0)
 		return data;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, phyreg);
 	if (priv->plat->has_gmac4)
-		value |= MII_GMAC4_READ;
+		cmd = MII_GMAC4_READ;
+	else
+		cmd = 0;
 
-	data = stmmac_mdio_read(priv, data, value);
+	data = stmmac_mdio_read(priv, phyaddr, phyreg, cmd, data);
 
 	pm_runtime_put(priv->device);
 
@@ -306,29 +311,29 @@ static int stmmac_mdio_read_c45(struct mii_bus *bus, int phyaddr, int devad,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int data = 0;
-	u32 value;
+	u32 cmd;
 
 	data = pm_runtime_resume_and_get(priv->device);
 	if (data < 0)
 		return data;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, devad);
-	value |= MII_GMAC4_READ;
-	value |= MII_GMAC4_C45E;
+	cmd = MII_GMAC4_READ | MII_GMAC4_C45E;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
 
-	data = stmmac_mdio_read(priv, data, value);
+	data = stmmac_mdio_read(priv, phyaddr, devad, cmd, data);
 
 	pm_runtime_put(priv->device);
 
 	return data;
 }
 
-static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
+static int stmmac_mdio_write(struct stmmac_priv *priv, unsigned int pa,
+			     unsigned int gr, u32 cmd, int data)
 {
 	unsigned int mii_address = priv->hw->mii.addr;
 	unsigned int mii_data = priv->hw->mii.data;
+	u32 value;
 	int ret;
 
 	/* Wait until any existing MII operation is complete */
@@ -336,6 +341,8 @@ static int stmmac_mdio_write(struct stmmac_priv *priv, int data, u32 value)
 	if (ret)
 		return ret;
 
+	value = stmmac_mdio_format_addr(priv, pa, gr) | cmd;
+
 	/* Set the MII address register to write */
 	writel(data, priv->ioaddr + mii_data);
 	writel(value, priv->ioaddr + mii_address);
@@ -357,19 +364,18 @@ static int stmmac_mdio_write_c22(struct mii_bus *bus, int phyaddr, int phyreg,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
-	u32 value;
+	u32 cmd;
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, phyreg);
 	if (priv->plat->has_gmac4)
-		value |= MII_GMAC4_WRITE;
+		cmd = MII_GMAC4_WRITE;
 	else
-		value |= MII_WRITE;
+		cmd = MII_WRITE;
 
-	ret = stmmac_mdio_write(priv, data, value);
+	ret = stmmac_mdio_write(priv, phyaddr, phyreg, cmd, data);
 
 	pm_runtime_put(priv->device);
 
@@ -390,19 +396,17 @@ static int stmmac_mdio_write_c45(struct mii_bus *bus, int phyaddr,
 {
 	struct stmmac_priv *priv = netdev_priv(bus->priv);
 	int ret, data = phydata;
-	u32 value;
+	u32 cmd;
 
 	ret = pm_runtime_resume_and_get(priv->device);
 	if (ret < 0)
 		return ret;
 
-	value = stmmac_mdio_format_addr(priv, phyaddr, devad);
-	value |= MII_GMAC4_WRITE;
-	value |= MII_GMAC4_C45E;
+	cmd = MII_GMAC4_WRITE | MII_GMAC4_C45E;
 
 	data |= phyreg << MII_GMAC4_REG_ADDR_SHIFT;
 
-	ret = stmmac_mdio_write(priv, data, value);
+	ret = stmmac_mdio_write(priv, phyaddr, devad, cmd, data);
 
 	pm_runtime_put(priv->device);
 
-- 
2.47.2


