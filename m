Return-Path: <netdev+bounces-147427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A4E9D97A2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44CF71629E1
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6171D319B;
	Tue, 26 Nov 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gnu0No/j"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E571D47B5
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625607; cv=none; b=AR2AZeRrb12oHWEIpmfHDpv1SkSKKSXECZ30IR4xW1FmnpMRQf1l3lRKXTMHRNviDQjbFR42iGzo15PJsHn1PnDwdPi5XyWYm/9vfleknjhGuCmyzsVrWC4Jj0PslbECoq6cz9FnCDr3zDHds08TGwuTgOD0+xNy/HZ+tVkyw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625607; c=relaxed/simple;
	bh=k1Ue3R0HrgihX0mpbhnKSaEEsVNo4DDoozlvnlALX3o=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uUfLcsimdv1U/6I7TP2WGRUuxl1XwN3Opb58GadAR4JXVquxtbPXxlQbTsUsvlleXGaAMh8jXPFY8rhk01+WW5N5mbUp9Tv2pHP0WcuYod54UvVimo+gbYyAZQfLTRcao4DwlH9l+znmcSfN9JhCH9ejp/C2fbgDTnJfulv/Xgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gnu0No/j; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sMsj1itYD0QurpAqOjGf9BKpxvaNuiNfv6EPWoNRACk=; b=gnu0No/jFm+63Kw1vh4sqJEcVb
	CP3tCSBiaWpQZewHdIb/V2MhjxvIJk+9WhRGihmcgnycbELoQwxFTHINXw1BKNX8kEx67cOteEItU
	PYLMEctP9ij8LuJCT+z5Q66UlM3k8inm22HmraaNhAwgNlGHxpX9W494z0nOSCjwkaC3I95YLHwhx
	n45ij+Q/MCu5r6JiGkoddZpc8X/1Fsnjv4bJ2UXfrZ46p7WPks/5vvs7K7bhwYqeNxqBcf4kkZ+pO
	eWy3i1FG4Bdg1tVGY50N/OstxW2kGYWUdY8jMKP5BskkQ/8YhkaYXBaUmyRmKC8iIFu8pLsWme06m
	Nog3mhjg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51146 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tFv45-0006uw-1L;
	Tue, 26 Nov 2024 12:53:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tFv44-005yiR-E2; Tue, 26 Nov 2024 12:53:12 +0000
In-Reply-To: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	UNGLinuxDriver@microchip.com
Subject: [PATCH RFC net-next 12/23] net: mvneta: convert to phylink EEE
 implementation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tFv44-005yiR-E2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 26 Nov 2024 12:53:12 +0000

Convert mvneta to use phylink's EEE implementation, which means we just
need to implement the two methods for LPI control, and adding the
initial configuration.

Disabling LPI requires clearing a single bit. Enabling LPI needs a full
configuration of several values, as the timer values are dependent on
the MAC operating speed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 116 +++++++++++++++-----------
 1 file changed, 68 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index 1fb285fa0bdb..976ce8d6dabf 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -284,8 +284,12 @@
 					  MVNETA_TXQ_BUCKET_REFILL_PERIOD))
 
 #define MVNETA_LPI_CTRL_0                        0x2cc0
+#define      MVNETA_LPI_CTRL_0_TS                (0xff << 8)
 #define MVNETA_LPI_CTRL_1                        0x2cc4
-#define      MVNETA_LPI_REQUEST_ENABLE           BIT(0)
+#define      MVNETA_LPI_CTRL_1_REQUEST_ENABLE    BIT(0)
+#define      MVNETA_LPI_CTRL_1_REQUEST_FORCE     BIT(1)
+#define      MVNETA_LPI_CTRL_1_MANUAL_MODE       BIT(2)
+#define      MVNETA_LPI_CTRL_1_TW                (0xfff << 4)
 #define MVNETA_LPI_CTRL_2                        0x2cc8
 #define MVNETA_LPI_STATUS                        0x2ccc
 
@@ -541,10 +545,6 @@ struct mvneta_port {
 	struct mvneta_bm_pool *pool_short;
 	int bm_win_id;
 
-	bool eee_enabled;
-	bool eee_active;
-	bool tx_lpi_enabled;
-
 	u64 ethtool_stats[ARRAY_SIZE(mvneta_statistics)];
 
 	u32 indir[MVNETA_RSS_LU_TABLE_SIZE];
@@ -1354,6 +1354,13 @@ static void mvneta_port_enable(struct mvneta_port *pp)
 	val = mvreg_read(pp, MVNETA_GMAC_CTRL_0);
 	val |= MVNETA_GMAC0_PORT_ENABLE;
 	mvreg_write(pp, MVNETA_GMAC_CTRL_0, val);
+
+	/* Ensure LPI is disabled */
+	val = mvreg_read(pp, MVNETA_LPI_CTRL_1);
+	val &= ~(MVNETA_LPI_CTRL_1_REQUEST_ENABLE |
+		 MVNETA_LPI_CTRL_1_REQUEST_FORCE |
+		 MVNETA_LPI_CTRL_1_MANUAL_MODE);
+	mvreg_write(pp, MVNETA_LPI_CTRL_1, val);
 }
 
 /* Disable the port and wait for about 200 usec before retuning */
@@ -4206,18 +4213,6 @@ static int mvneta_mac_finish(struct phylink_config *config, unsigned int mode,
 	return 0;
 }
 
-static void mvneta_set_eee(struct mvneta_port *pp, bool enable)
-{
-	u32 lpi_ctl1;
-
-	lpi_ctl1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
-	if (enable)
-		lpi_ctl1 |= MVNETA_LPI_REQUEST_ENABLE;
-	else
-		lpi_ctl1 &= ~MVNETA_LPI_REQUEST_ENABLE;
-	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi_ctl1);
-}
-
 static void mvneta_mac_link_down(struct phylink_config *config,
 				 unsigned int mode, phy_interface_t interface)
 {
@@ -4233,9 +4228,6 @@ static void mvneta_mac_link_down(struct phylink_config *config,
 		val |= MVNETA_GMAC_FORCE_LINK_DOWN;
 		mvreg_write(pp, MVNETA_GMAC_AUTONEG_CONFIG, val);
 	}
-
-	pp->eee_active = false;
-	mvneta_set_eee(pp, false);
 }
 
 static void mvneta_mac_link_up(struct phylink_config *config,
@@ -4284,11 +4276,53 @@ static void mvneta_mac_link_up(struct phylink_config *config,
 	}
 
 	mvneta_port_up(pp);
+}
+
+static void mvneta_mac_disable_tx_lpi(struct phylink_config *config)
+{
+	struct mvneta_port *pp = netdev_priv(to_net_dev(config->dev));
+	u32 lpi1;
+
+	lpi1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
+	lpi1 &= ~MVNETA_LPI_CTRL_1_REQUEST_ENABLE;
+	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi1);
+}
+
+static void mvneta_mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+				     bool tx_clk_stop)
+{
+	struct mvneta_port *pp = netdev_priv(to_net_dev(config->dev));
+	u32 ts, tw, lpi0, lpi1, status;
 
-	if (phy && pp->eee_enabled) {
-		pp->eee_active = phy_init_eee(phy, false) >= 0;
-		mvneta_set_eee(pp, pp->eee_active && pp->tx_lpi_enabled);
+	status = mvreg_read(pp, MVNETA_GMAC_STATUS);
+	if (status & MVNETA_GMAC_SPEED_1000) {
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
 	}
+
+	if (ts > 255)
+		ts = 255;
+
+
+	/* Configure ts */
+	lpi0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
+	lpi0 = u32_replace_bits(lpi0, MVNETA_LPI_CTRL_0_TS, ts);
+	mvreg_write(pp, MVNETA_LPI_CTRL_0, lpi0);
+
+	/* Configure tw and enable LPI generation */
+	lpi1 = mvreg_read(pp, MVNETA_LPI_CTRL_1);
+	lpi1 = u32_replace_bits(lpi1, MVNETA_LPI_CTRL_1_TW, tw);
+	lpi1 |= MVNETA_LPI_CTRL_1_REQUEST_ENABLE;
+	mvreg_write(pp, MVNETA_LPI_CTRL_1, lpi1);
 }
 
 static const struct phylink_mac_ops mvneta_phylink_ops = {
@@ -4298,6 +4332,8 @@ static const struct phylink_mac_ops mvneta_phylink_ops = {
 	.mac_finish = mvneta_mac_finish,
 	.mac_link_down = mvneta_mac_link_down,
 	.mac_link_up = mvneta_mac_link_up,
+	.mac_disable_tx_lpi = mvneta_mac_disable_tx_lpi,
+	.mac_enable_tx_lpi = mvneta_mac_enable_tx_lpi,
 };
 
 static int mvneta_mdio_probe(struct mvneta_port *pp)
@@ -5099,14 +5135,6 @@ static int mvneta_ethtool_get_eee(struct net_device *dev,
 				  struct ethtool_keee *eee)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
-	u32 lpi_ctl0;
-
-	lpi_ctl0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
-
-	eee->eee_enabled = pp->eee_enabled;
-	eee->eee_active = pp->eee_active;
-	eee->tx_lpi_enabled = pp->tx_lpi_enabled;
-	eee->tx_lpi_timer = (lpi_ctl0) >> 8; // * scale;
 
 	return phylink_ethtool_get_eee(pp->phylink, eee);
 }
@@ -5115,23 +5143,6 @@ static int mvneta_ethtool_set_eee(struct net_device *dev,
 				  struct ethtool_keee *eee)
 {
 	struct mvneta_port *pp = netdev_priv(dev);
-	u32 lpi_ctl0;
-
-	/* The Armada 37x documents do not give limits for this other than
-	 * it being an 8-bit register.
-	 */
-	if (eee->tx_lpi_enabled && eee->tx_lpi_timer > 255)
-		return -EINVAL;
-
-	lpi_ctl0 = mvreg_read(pp, MVNETA_LPI_CTRL_0);
-	lpi_ctl0 &= ~(0xff << 8);
-	lpi_ctl0 |= eee->tx_lpi_timer << 8;
-	mvreg_write(pp, MVNETA_LPI_CTRL_0, lpi_ctl0);
-
-	pp->eee_enabled = eee->eee_enabled;
-	pp->tx_lpi_enabled = eee->tx_lpi_enabled;
-
-	mvneta_set_eee(pp, eee->tx_lpi_enabled && eee->eee_enabled);
 
 	return phylink_ethtool_set_eee(pp->phylink, eee);
 }
@@ -5446,6 +5457,9 @@ static int mvneta_port_power_up(struct mvneta_port *pp, int phy_mode)
 	    !phy_interface_mode_is_rgmii(phy_mode))
 		return -EINVAL;
 
+	/* Ensure LPI is disabled */
+	mvneta_mac_disable_tx_lpi(&pp->phylink_config);
+
 	return 0;
 }
 
@@ -5537,6 +5551,12 @@ static int mvneta_probe(struct platform_device *pdev)
 	pp->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_10 |
 		MAC_100 | MAC_1000FD | MAC_2500FD;
 
+	/* Setup EEE.  Choose 250us idle. */
+	pp->phylink_config.lpi_capabilities = MAC_100FD | MAC_1000FD;
+	pp->phylink_config.lpi_timer_limit_us = 255;
+	pp->phylink_config.lpi_timer_default = 250;
+	pp->phylink_config.eee_enabled_default = true;
+
 	phy_interface_set_rgmii(pp->phylink_config.supported_interfaces);
 	__set_bit(PHY_INTERFACE_MODE_QSGMII,
 		  pp->phylink_config.supported_interfaces);
-- 
2.30.2


