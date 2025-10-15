Return-Path: <netdev+bounces-229670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14CBDF958
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1D7B1A2119C
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8D8330D29;
	Wed, 15 Oct 2025 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zPIbxYT2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7725CC79
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544655; cv=none; b=K/1MKGZGXMBnkEiHZ7C1lD2767Y8nvjML3m+IvcYyBcZeCiwdIttVxDeDU8yXyAU+5dcAHYBcMwHJPm11MngvGSqXGPJdnF8fLJvQDMmWsPyP377qptaWlScm50bVc2NZv7VlEOu6/OWlAVenNoEh3TOsO4viC58SRu6XfocFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544655; c=relaxed/simple;
	bh=vJ9W7pSZ9Ey0EoSvcXCY2sl7JfouXXUt8ZBUq3RvEQc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=kjPk7idCH6AvsV6BvgXVNv08XZd8N8iCovljl7d+YRP9FkDxwcVwgZoEDZ+VMEMGxmsCgArNRWJvPfAX7CKPbAXFRBBYp8fwgrUQAS6v0+oPdJ1mTurofUGlltfgo7jbogQFjITzxiKbXv0LqrsoPE411ptUBxlamzOSHlr0Icw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zPIbxYT2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rD9sxXXcMPCdPzJUHRNkbrU7OVhc+3FqTiQbvaq4qKA=; b=zPIbxYT2T4pXpUpYZgf1evBIL8
	jisw/dzamHSTXVee/35trO3vQnd3oafAsZiH55/E+MYSdOA4nrwS4e/EguiWjg+ujbT3FRgIM015L
	/Ngz4fuS/DOBdbbkr5hDM6cQN7bCrP5hOBLDo36YmJpeAfqGbZVH004xz9Rw7PbeJ80O1bqYOwQCf
	bKmqkoV38Vx0QwNGVnusn3scCNtUGvDpk8+fKM7rR/7ly73pZM2fITEA7QwNnV84lHKjJT2JHBf65
	jdDp6KfWRN6zMXngWSbF7uLPtEmuuveTEzYr3Ny0NhMzOGWl0Vr2Q9pRy19j1ldNDxeY8f9MnqM2o
	C70FcEDQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38608 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v945K-0000000059q-0yvh;
	Wed, 15 Oct 2025 17:10:42 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v945J-0000000AmeJ-1GOb;
	Wed, 15 Oct 2025 17:10:41 +0100
In-Reply-To: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
References: <aO_HIwT_YvxkDS8D@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 1/5] net: stmmac: dwc-qos-eth: move MDIO bus locking
 into stmmac_mdio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v945J-0000000AmeJ-1GOb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Oct 2025 17:10:41 +0100

Rather than dwc-qos-eth manipulating the MDIO bus lock directly, add
helpers to the stmmac MDIO layer and use them in dwc-qos-eth. This
improves my commit 87f43e6f06a2 ("net: stmmac: dwc-qos: calibrate tegra
with mdio bus idle").

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |  4 ++--
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 ++
 drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 14 ++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index e8539cad4602..f1c2e35badf7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -162,7 +162,7 @@ static void tegra_eqos_fix_speed(void *bsp_priv, int speed, unsigned int mode)
 		priv = netdev_priv(dev_get_drvdata(eqos->dev));
 
 		/* Calibration should be done with the MDIO bus idle */
-		mutex_lock(&priv->mii->mdio_lock);
+		stmmac_mdio_lock(priv);
 
 		/* calibrate */
 		value = readl(eqos->regs + SDMEMCOMPPADCTRL);
@@ -198,7 +198,7 @@ static void tegra_eqos_fix_speed(void *bsp_priv, int speed, unsigned int mode)
 		value &= ~SDMEMCOMPPADCTRL_PAD_E_INPUT_OR_E_PWRD;
 		writel(value, eqos->regs + SDMEMCOMPPADCTRL);
 
-		mutex_unlock(&priv->mii->mdio_lock);
+		stmmac_mdio_unlock(priv);
 	} else {
 		value = readl(eqos->regs + AUTO_CAL_CONFIG);
 		value &= ~AUTO_CAL_CONFIG_ENABLE;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 7ca5477be390..ec8bddc1c37f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -388,6 +388,8 @@ static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
 int stmmac_mdio_unregister(struct net_device *ndev);
 int stmmac_mdio_register(struct net_device *ndev);
 int stmmac_mdio_reset(struct mii_bus *mii);
+void stmmac_mdio_lock(struct stmmac_priv *priv);
+void stmmac_mdio_unlock(struct stmmac_priv *priv);
 int stmmac_pcs_setup(struct net_device *ndev);
 void stmmac_pcs_clean(struct net_device *ndev);
 void stmmac_set_ethtool_ops(struct net_device *netdev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
index f408737f6fc7..d62b2870899d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
@@ -734,3 +734,17 @@ int stmmac_mdio_unregister(struct net_device *ndev)
 
 	return 0;
 }
+
+void stmmac_mdio_lock(struct stmmac_priv *priv)
+{
+	if (priv->mii)
+		mutex_lock(&priv->mii->mdio_lock);
+}
+EXPORT_SYMBOL_GPL(stmmac_mdio_lock);
+
+void stmmac_mdio_unlock(struct stmmac_priv *priv)
+{
+	if (priv->mii)
+		mutex_unlock(&priv->mii->mdio_lock);
+}
+EXPORT_SYMBOL_GPL(stmmac_mdio_unlock);
-- 
2.47.3


