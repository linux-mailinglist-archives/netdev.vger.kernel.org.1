Return-Path: <netdev+bounces-235044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E982C2B8B7
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C29254FB559
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FA530146E;
	Mon,  3 Nov 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="yITtMUXj"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8FE304962
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170625; cv=none; b=I3az9TtCr4mnvX1+Jsn6hyt3BWrcAhvL1igF+EePABgTefksZKX7vRB9gu/BmpmdmdOpvkMrIGk/L2GsqRl13NwB2+J0XQCr4FqHl+X4hcpvoy7gRDNyO6liDwwNPulhkrOJtGgEW0QyeBIgbgZ0emlEN5/oBdm2CHVLcswFvf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170625; c=relaxed/simple;
	bh=B3Fn9YgDFp8eWKn1XLwZErvLFjkJ+iCr8m1nxMrilYM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=CY3cyc0X1z3OopoeZfG7ukdisF+D3YzAXcELS3Sy8/gCl706jJOKhIYXd16/VM6/RtUowMxgBpQFuk9jNWl5oiLt6hQ2xCMzUN3fsGV/kioPyYXlbxh+2n+6XNX6LlFHPGJahKKVbqEqf7biXMjOygEKwny7wBgxqkFrs9k0/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=yITtMUXj; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CbjiE3yRrQYHEu8s8D+tBXPqnkwgsI3CtvhQkXXPRzA=; b=yITtMUXjG26H2n/Mr982LDhvyf
	WKaKSxb9G17jARSSsPhcBzmQfZHX72t5vsWFakEXzrUeSdAdYAl12hXv9WpkkQVgwEeYHAJmaphva
	IohLp+0Lb9nBcihPhl0cRm6yHmboGYW314eodCQtAPlu+59wUeQSnNKixWqkGs3/cmOLHKzzp6/B9
	S/IHGOep+9Px+rEq4G2F5sfbxfkvd5nVRQ9c+Gf1AqwwsCKHSpBbawKPlwogScTwgynQj2wkwF/5V
	T/vzBd1ORmuDHvH3BGOwrxnqoyLfsukbs9+aRpA0EmMtDnaJHhdaVxHEFgfScovqbR7+QQs3+SR4/
	ZcuirTVg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56282 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vFt4e-000000000g4-0oMe;
	Mon, 03 Nov 2025 11:50:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vFt4c-0000000Choe-3SII;
	Mon, 03 Nov 2025 11:50:10 +0000
In-Reply-To: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
References: <aQiWzyrXU_2hGJ4j@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	s32@nxp.com,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH net-next 04/11] net: stmmac: add stmmac_get_phy_intf_sel()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vFt4c-0000000Choe-3SII@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 03 Nov 2025 11:50:10 +0000

Provide a function to translate the PHY interface mode to the
phy_intf_sel pin configuration for dwmac1000 and dwmac4 cores that
support multiple interfaces. We currently handle MII, GMII, RGMII,
SGMII, RMII and REVMII, but not TBI, RTBI nor SMII as drivers do not
appear to use these three and the driver doesn't currently support
these.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  1 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 3ea680cc63d8..0ea74c88a779 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -396,6 +396,7 @@ void stmmac_ptp_register(struct stmmac_priv *priv);
 void stmmac_ptp_unregister(struct stmmac_priv *priv);
 int stmmac_xdp_open(struct net_device *dev);
 void stmmac_xdp_release(struct net_device *dev);
+int stmmac_get_phy_intf_sel(phy_interface_t interface);
 int stmmac_resume(struct device *dev);
 int stmmac_suspend(struct device *dev);
 void stmmac_dvr_remove(struct device *dev);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 1e69c1a7dc6c..95d2cd020a0c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3082,6 +3082,26 @@ static void stmmac_check_ether_addr(struct stmmac_priv *priv)
 	}
 }
 
+int stmmac_get_phy_intf_sel(phy_interface_t interface)
+{
+	int phy_intf_sel = -EINVAL;
+
+	if (interface == PHY_INTERFACE_MODE_MII ||
+	    interface == PHY_INTERFACE_MODE_GMII)
+		phy_intf_sel = PHY_INTF_SEL_GMII_MII;
+	else if (phy_interface_mode_is_rgmii(interface))
+		phy_intf_sel = PHY_INTF_SEL_RGMII;
+	else if (interface == PHY_INTERFACE_MODE_SGMII)
+		phy_intf_sel = PHY_INTF_SEL_SGMII;
+	else if (interface == PHY_INTERFACE_MODE_RMII)
+		phy_intf_sel = PHY_INTF_SEL_RMII;
+	else if (interface == PHY_INTERFACE_MODE_REVMII)
+		phy_intf_sel = PHY_INTF_SEL_REVMII;
+
+	return phy_intf_sel;
+}
+EXPORT_SYMBOL_GPL(stmmac_get_phy_intf_sel);
+
 /**
  * stmmac_init_dma_engine - DMA init.
  * @priv: driver private structure
-- 
2.47.3


