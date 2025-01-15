Return-Path: <netdev+bounces-158642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD397A12CDE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22092188973D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D411D8E07;
	Wed, 15 Jan 2025 20:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ORWnCauJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A457F1D935A
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736973803; cv=none; b=Abk1mvzzf9SBCgpAeiAjNG2scFTQ3GIsFC1mFRs7MLy8MMcH0S7HypNOw3yBVIzkq2mOtYGMiTaDo//IUHCru+zBp58YCxOaHJ3Zfw3bSfaa71OQSF/nXNOzeWDQZdhZ7V64+HpV/QFEV0jaem4ZPq7RU8N0YUxQcT2aDW+SXUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736973803; c=relaxed/simple;
	bh=mASC5LL/bRdA+PTyy4203RT3Zxmj6X+qDnpdgTeEgpM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=XGQyrhIpzVCtKWfyGGU1O8cuOExuCM5zzZLIPwzLHTztjUHgeS0x4/yOGUc4B6Wi4C5Gs++mPl2Frt3QpVW9Vx/bm/sgZFPirb2LYHDYPkz44lv54saJWLap1puh0GXKmRtQnp6TErDpVpxjdg/0dlVgl7GJ8FqXSBDS6UPXodo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ORWnCauJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Rz+XpBnmMvG/ye+c56phijalxyBjKCZ02lLP/GXNpEg=; b=ORWnCauJU0dRlsVRKGGPIrvXN/
	QOEDnVyw3+XmsviKuxqxji9tCr/LYmg/JVOpsmUxs4Vsq2L1ZtgCqi0PKZ9oMOmAwz/kbvsRQ7QyJ
	N7HBdc3J6TADqNrrZwLV97CQKiaVZ5O4JUanvU+fk8M3IkA5d7rLBoWwl19uVZJwgYWSxsFEchf3K
	TM9Z3SkANipAIO/3cwogZSdHJ4/OQj1VAAGyjy6rpFGnHRrdSsmSYh8a5128cXIQieFQqh4MMZkKb
	uogHkw4HZKuoEYTYMgLuNJtvgcBySj0J8ip4Gi+/20gG/PAWW78dTIIpxvPpNPQxAFkfo8vScgBM4
	KDT8wh8w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46358 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tYAEK-0001jc-1J;
	Wed, 15 Jan 2025 20:43:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tYAE0-0014Pz-R9; Wed, 15 Jan 2025 20:42:52 +0000
In-Reply-To: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 6/9] net: mvpp2: add EEE implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tYAE0-0014Pz-R9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 15 Jan 2025 20:42:52 +0000

Add EEE support for mvpp2, using phylink's EEE implementation, which
means we just need to implement the two methods for LPI control, and
with the initial configuration. Only SGMII mode is supported, so only
100M and 1G speeds.

Disabling LPI requires clearing a single bit. Enabling LPI needs a full
configuration of several values, as the timer values are dependent on
the MAC operating speed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
--
v3: split LPI timer limit and validation into separate patches
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  5 ++
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 86 +++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
index 9e02e4367bec..44fe9b68d1c2 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -481,6 +481,11 @@
 #define MVPP22_GMAC_INT_SUM_MASK		0xa4
 #define     MVPP22_GMAC_INT_SUM_MASK_LINK_STAT	BIT(1)
 #define	    MVPP22_GMAC_INT_SUM_MASK_PTP	BIT(2)
+#define MVPP2_GMAC_LPI_CTRL0			0xc0
+#define     MVPP2_GMAC_LPI_CTRL0_TS_MASK	GENMASK(15, 8)
+#define MVPP2_GMAC_LPI_CTRL1			0xc4
+#define     MVPP2_GMAC_LPI_CTRL1_REQ_EN		BIT(0)
+#define     MVPP2_GMAC_LPI_CTRL1_TW_MASK	GENMASK(15, 4)
 
 /* Per-port XGMAC registers. PPv2.2 and PPv2.3, only for GOP port 0,
  * relative to port->base.
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index f85229a30844..a8c33417bb3e 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5757,6 +5757,28 @@ static int mvpp2_ethtool_set_rxfh(struct net_device *dev,
 	return mvpp2_modify_rxfh_context(dev, NULL, rxfh, extack);
 }
 
+static int mvpp2_ethtool_get_eee(struct net_device *dev,
+				 struct ethtool_keee *eee)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	if (!port->phylink)
+		return -EOPNOTSUPP;
+
+	return phylink_ethtool_get_eee(port->phylink, eee);
+}
+
+static int mvpp2_ethtool_set_eee(struct net_device *dev,
+				 struct ethtool_keee *eee)
+{
+	struct mvpp2_port *port = netdev_priv(dev);
+
+	if (!port->phylink)
+		return -EOPNOTSUPP;
+
+	return phylink_ethtool_set_eee(port->phylink, eee);
+}
+
 /* Device ops */
 
 static const struct net_device_ops mvpp2_netdev_ops = {
@@ -5802,6 +5824,8 @@ static const struct ethtool_ops mvpp2_eth_tool_ops = {
 	.create_rxfh_context	= mvpp2_create_rxfh_context,
 	.modify_rxfh_context	= mvpp2_modify_rxfh_context,
 	.remove_rxfh_context	= mvpp2_remove_rxfh_context,
+	.get_eee		= mvpp2_ethtool_get_eee,
+	.set_eee		= mvpp2_ethtool_set_eee,
 };
 
 /* Used for PPv2.1, or PPv2.2 with the old Device Tree binding that
@@ -6672,6 +6696,55 @@ static void mvpp2_mac_link_down(struct phylink_config *config,
 	mvpp2_port_disable(port);
 }
 
+static void mvpp2_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct mvpp2_port *port = mvpp2_phylink_to_port(config);
+
+	mvpp2_modify(port->base + MVPP2_GMAC_LPI_CTRL1,
+		     MVPP2_GMAC_LPI_CTRL1_REQ_EN, 0);
+}
+
+static int mvpp2_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				   bool tx_clk_stop)
+{
+	struct mvpp2_port *port = mvpp2_phylink_to_port(config);
+	u32 ts, tw, lpi1, status;
+
+	status = readl(port->base + MVPP2_GMAC_STATUS0);
+	if (status & MVPP2_GMAC_STATUS0_GMII_SPEED) {
+		/* At 1G speeds, the timer resolution are 1us, and
+		 * 802.3 says tw is 16.5us. Round up to 17us.
+		 */
+		tw = 17;
+		ts = timer;
+	} else {
+		/* At 100M speeds, the timer resolutions are 10us, and
+		 * 802.3 says tw is 30us.
+		 */
+		tw = 3;
+		ts = DIV_ROUND_UP(timer, 10);
+	}
+
+	if (ts > 255)
+		ts = 255;
+
+	/* Configure ts */
+	mvpp2_modify(port->base + MVPP2_GMAC_LPI_CTRL0,
+		     MVPP2_GMAC_LPI_CTRL0_TS_MASK,
+		     FIELD_PREP(MVPP2_GMAC_LPI_CTRL0_TS_MASK, ts));
+
+	lpi1 = readl(port->base + MVPP2_GMAC_LPI_CTRL1);
+
+	/* Configure tw */
+	lpi1 = u32_replace_bits(lpi1, tw, MVPP2_GMAC_LPI_CTRL1_TW_MASK);
+
+	/* Enable LPI generation */
+	writel(lpi1 | MVPP2_GMAC_LPI_CTRL1_REQ_EN,
+	       port->base + MVPP2_GMAC_LPI_CTRL1);
+
+	return 0;
+}
+
 static const struct phylink_mac_ops mvpp2_phylink_ops = {
 	.mac_select_pcs = mvpp2_select_pcs,
 	.mac_prepare = mvpp2_mac_prepare,
@@ -6679,6 +6752,8 @@ static const struct phylink_mac_ops mvpp2_phylink_ops = {
 	.mac_finish = mvpp2_mac_finish,
 	.mac_link_up = mvpp2_mac_link_up,
 	.mac_link_down = mvpp2_mac_link_down,
+	.mac_enable_tx_lpi = mvpp2_mac_enable_tx_lpi,
+	.mac_disable_tx_lpi = mvpp2_mac_disable_tx_lpi,
 };
 
 /* Work-around for ACPI */
@@ -6957,6 +7032,15 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 		port->phylink_config.mac_capabilities =
 			MAC_2500FD | MAC_1000FD | MAC_100 | MAC_10;
 
+		__set_bit(PHY_INTERFACE_MODE_SGMII,
+			  port->phylink_config.lpi_interfaces);
+
+		port->phylink_config.lpi_capabilities = MAC_1000FD | MAC_100FD;
+
+		/* Setup EEE.  Choose 250us idle. */
+		port->phylink_config.lpi_timer_default = 250;
+		port->phylink_config.eee_enabled_default = true;
+
 		if (port->priv->global_tx_fc)
 			port->phylink_config.mac_capabilities |=
 				MAC_SYM_PAUSE | MAC_ASYM_PAUSE;
@@ -7031,6 +7115,8 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 			goto err_free_port_pcpu;
 		}
 		port->phylink = phylink;
+
+		mvpp2_mac_disable_tx_lpi(&port->phylink_config);
 	} else {
 		dev_warn(&pdev->dev, "Use link irqs for port#%d. FW update required\n", port->id);
 		port->phylink = NULL;
-- 
2.30.2


