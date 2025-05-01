Return-Path: <netdev+bounces-187234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3DAA5DF7
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 13:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0121BC4D44
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 11:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0F022425C;
	Thu,  1 May 2025 11:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dKkic6gk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF30933086
	for <netdev@vger.kernel.org>; Thu,  1 May 2025 11:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746099972; cv=none; b=L5OKWKoFjPQBTQ0FihWD6plwLcs5nm2V/n9Gpm/MCXjDXdZAYLtZJJ+qaygZDRoRzPIki2unrOJwMXXGjrUTfQB0NwF8DinzmhvmMH6igK/VgoPJdiAJMF28pwgi+/f1ci5iv59BOWmp/acAoT1jDsnvvWE8HTb0dJtXIWU74yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746099972; c=relaxed/simple;
	bh=vo0YhO11Po9cZZcFbaq+MNLX/ordFENKyx+STjYjs5U=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=NS82v/6jJGN6TwoTL4h7SvN4GC9xZETtzIen4u9jTrH4nOTkM2lasExtSub3gyxJ6Nk8yKihQkhCv/0hzOqCJoPx4Hl8IABctLhhMD5yaalqi4jURRMIp3xr8bMK2joxjgRbiT90hXif57LOLj6c5FsBm5W7OqU/uBQmgUDefNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dKkic6gk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zyliqNaGDFNwYmId46fHcTCD6i4R1js20R/a2SWRoHw=; b=dKkic6gkYdMSWsgm4Qr7l4xOhb
	Y55Qep0F0HFwJb6gDahvf9Y/59IuG2dJh2btGA4xiU0pVFjdBAlwbGkA0r+P5S0nABuPFwixwOnRz
	SNUa4i2xnw0xHGBZ9rF1FOuMdXyzHbB39UrCPiNRXgTg0U79wALzj+K5xnnN3RApc0ktScOEapw0c
	5ukMBpL4qmWihVOiRGDYSdDWLf3CL97Rf1t4PJRBp//Mihg3/G2hwqPDXqKGeAzVViEyDca3lIsBj
	gE6XXSwffabMXyvHTxI03pEoXEYZCEsBCqRKaFVTroxIi3cZcryBlZsLbqdqVMeGWYlTB/MrNKXd7
	G3M45zUg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52286 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uASMb-00005f-0S;
	Thu, 01 May 2025 12:46:01 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uASLx-0021Qs-Uz; Thu, 01 May 2025 12:45:21 +0100
In-Reply-To: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
References: <aBNe0Vt81vmqVCma@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 5/6] net: stmmac: intel: convert speed_mode_2500() to
 get_interfaces()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uASLx-0021Qs-Uz@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 01 May 2025 12:45:21 +0100

TGL platforms support either SGMII or 2500BASE-X, which is determined
by reading a SERDES register.

Thus, plat->phy_interface (and phylink's supported_interfaces) depend
on this. Use the new .get_interfaces() method to set both
plat->phy_interface and the supported_interfaces bitmap.

This removes the only user of the .speed_mode_2500() method.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/dwmac-intel.c | 30 ++++++++++---------
 .../net/ethernet/stmicro/stmmac/dwmac-intel.h |  1 -
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 4b263a3c65a4..9a47015254bb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -284,25 +284,28 @@ static void intel_serdes_powerdown(struct net_device *ndev, void *intel_data)
 	}
 }
 
-static void intel_speed_mode_2500(struct net_device *ndev, void *intel_data)
+static void tgl_get_interfaces(struct stmmac_priv *priv, void *bsp_priv,
+			       unsigned long *interfaces)
 {
-	struct intel_priv_data *intel_priv = intel_data;
-	struct stmmac_priv *priv = netdev_priv(ndev);
-	int serdes_phy_addr = 0;
-	u32 data = 0;
-
-	serdes_phy_addr = intel_priv->mdio_adhoc_addr;
+	struct intel_priv_data *intel_priv = bsp_priv;
+	phy_interface_t interface;
+	int data;
 
 	/* Determine the link speed mode: 2.5Gbps/1Gbps */
-	data = mdiobus_read(priv->mii, serdes_phy_addr,
-			    SERDES_GCR);
+	data = mdiobus_read(priv->mii, intel_priv->mdio_adhoc_addr, SERDES_GCR);
+	if (data < 0)
+		return;
 
-	if (((data & SERDES_LINK_MODE_MASK) >> SERDES_LINK_MODE_SHIFT) ==
-	    SERDES_LINK_MODE_2G5) {
+	if (FIELD_GET(SERDES_LINK_MODE_MASK, data) == SERDES_LINK_MODE_2G5) {
 		dev_info(priv->device, "Link Speed Mode: 2.5Gbps\n");
-		priv->plat->phy_interface = PHY_INTERFACE_MODE_2500BASEX;
 		priv->plat->mdio_bus_data->default_an_inband = false;
+		interface = PHY_INTERFACE_MODE_2500BASEX;
+	} else {
+		interface = PHY_INTERFACE_MODE_SGMII;
 	}
+
+	__set_bit(interface, interfaces);
+	priv->plat->phy_interface = interface;
 }
 
 /* Program PTP Clock Frequency for different variant of
@@ -929,8 +932,7 @@ static int tgl_common_data(struct pci_dev *pdev,
 	plat->rx_queues_to_use = 6;
 	plat->tx_queues_to_use = 4;
 	plat->clk_ptp_rate = 204800000;
-	plat->phy_interface = PHY_INTERFACE_MODE_SGMII;
-	plat->speed_mode_2500 = intel_speed_mode_2500;
+	plat->get_interfaces = tgl_get_interfaces;
 
 	plat->safety_feat_cfg->tsoee = 1;
 	plat->safety_feat_cfg->mrxpee = 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
index a12f8e65f89f..7511c224b312 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.h
@@ -21,7 +21,6 @@
 #define SERDES_RATE_MASK	GENMASK(9, 8)
 #define SERDES_PCLK_MASK	GENMASK(14, 12)	/* PCLK rate to PHY */
 #define SERDES_LINK_MODE_MASK	GENMASK(2, 1)
-#define SERDES_LINK_MODE_SHIFT	1
 #define SERDES_PWR_ST_SHIFT	4
 #define SERDES_PWR_ST_P0	0x0
 #define SERDES_PWR_ST_P3	0x3
-- 
2.30.2


