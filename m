Return-Path: <netdev+bounces-158126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF5A10862
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C384118898ED
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83274C08;
	Tue, 14 Jan 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="eZCM7rsD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E470817
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863371; cv=none; b=tGrqKBEi14xBGW08fpm5oQYMkmysibqEbKsqNxVTt19VcD8bijJlgg77QNqUS5542y6OX9vDHEOEiN6LLg0Qs+OdxgfrfllLWP+YlmANdxuI+P/LghKD2NMqKdhLH0ZroCNMymzSNSv4t2KXJzK41p+m1XkJ/8lGwdTTArvCXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863371; c=relaxed/simple;
	bh=f48l18xLpnAL3vxONj4cdCIygSUbVmqkvZYmYzgpYgY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gCQi/GSX5xSD6H0hVsG04FF0pzsGWzruP7/FxWWwlySV3tJQ6UWfjIyHddeMsu53VFnnSFJHUr9ItBg/rk4y3dOyf8x/ts8vN2ZzeAQS+SAl5PaOyWhj2W779JsEc1EZRAzuLJkLHzokRBq2qZiD97IQ/62gTtj/7D60yt3e1pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=eZCM7rsD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DPm/ca2LeFOJo+vX8bH9MO309BJWI3+tFieUmz4BjG8=; b=eZCM7rsD268EZ5xKhHySV/TnGX
	YDtJPuFh78OFOS2hKH6LbNQ/099oMXf6THFAzjKAUUT/M/Gp5b1K0azzD5/lZkNy/nARlaXqZE5ia
	5ezpzmc4Yj/8KerFSuf23TGcHYORp2+Z8P/Kvih8o4CSPbxoDEs093x/+HkyHNwTh2qxvbxFvV4RP
	mq6+FHquh4I5xW9mfZRnTtcwiLhDPFiqwieNIq19REFWha9+pbt6Epuavscun4djS9N38o6ocfUWA
	UT3AGB0Rija/5NiMpp2V+CRT0k/18Cvj7t4Gsk8Bh8mfDPuXOZtZsic0l8aOvr+1eHKL9EErVX4a0
	76T0IrtQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52334 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1tXhV8-00089Y-1v;
	Tue, 14 Jan 2025 14:02:38 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1tXhUp-000n0Y-BA; Tue, 14 Jan 2025 14:02:19 +0000
In-Reply-To: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
References: <Z4ZtoeeHIXPucjUv@shell.armlinux.org.uk>
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
	Simon Horman <horms@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 04/10] net: phylink: add EEE management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1tXhUp-000n0Y-BA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 14 Jan 2025 14:02:19 +0000

Add EEE management to phylink, making use of the phylib implementation.
This will only be used where a MAC driver populates the methods and
capabilities bitfield, otherwise we keep our old behaviour.

Phylink will keep track of the EEE configuration, including the clock
stop abilities at each end of the MAC to PHY link, programming the PHY
appropriately and preserving the LPI configuration should the PHY go
away.

Phylink will call into the MAC driver when LPI needs to be enabled or
disabled, with the requirement that the MAC have LPI disabled prior
to the netdev being brought up (in other words, it will only call
mac_disable_tx_lpi() if it has already called mac_enable_tx_lpi().)

Support for phylink managed EEE is enabled by populating both tx_lpi
MAC operations method pointers, and filling in both LPI interfaces
and capabilities. If the methods are provided but the LPI interfaces
or capabilities remain empty, this indicates to phylink that EEE is
implemented by the driver but the hardware it is driving does not
support EEE, and thus the ethtool set_eee() and get_eee() methods will
return EOPNOTSUPP.

No validation of the LPI timer value is performed by this patch.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 133 ++++++++++++++++++++++++++++++++++++--
 include/linux/phylink.h   |  45 +++++++++++++
 2 files changed, 174 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index e3fc1d1be1ed..2712d8949f94 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -81,12 +81,20 @@ struct phylink {
 	unsigned int pcs_state;
 
 	bool link_failed;
+	bool mac_supports_eee_ops;
+	bool mac_supports_eee;
+	bool phy_enable_tx_lpi;
+	bool mac_enable_tx_lpi;
+	bool mac_tx_clk_stop;
+	u32 mac_tx_lpi_timer;
 
 	struct sfp_bus *sfp_bus;
 	bool sfp_may_have_phy;
 	DECLARE_PHY_INTERFACE_MASK(sfp_interfaces);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(sfp_support);
 	u8 sfp_port;
+
+	struct eee_config eee_cfg;
 };
 
 #define phylink_printk(level, pl, fmt, ...) \
@@ -1574,6 +1582,52 @@ static const char *phylink_pause_to_str(int pause)
 	}
 }
 
+static void phylink_deactivate_lpi(struct phylink *pl)
+{
+	if (pl->mac_enable_tx_lpi) {
+		pl->mac_enable_tx_lpi = false;
+
+		phylink_dbg(pl, "disabling LPI\n");
+
+		pl->mac_ops->mac_disable_tx_lpi(pl->config);
+	}
+}
+
+static void phylink_activate_lpi(struct phylink *pl)
+{
+	int err;
+
+	if (!test_bit(pl->cur_interface, pl->config->lpi_interfaces)) {
+		phylink_dbg(pl, "MAC does not support LPI with %s\n",
+			    phy_modes(pl->cur_interface));
+		return;
+	}
+
+	phylink_dbg(pl, "LPI timer %uus, tx clock stop %u\n",
+		    pl->mac_tx_lpi_timer, pl->mac_tx_clk_stop);
+
+	err = pl->mac_ops->mac_enable_tx_lpi(pl->config, pl->mac_tx_lpi_timer,
+					     pl->mac_tx_clk_stop);
+	if (!err)
+		pl->mac_enable_tx_lpi = true;
+	else
+		phylink_err(pl, "%ps() failed: %pe\n",
+			    pl->mac_ops->mac_enable_tx_lpi, ERR_PTR(err));
+}
+
+static void phylink_phy_restrict_eee(struct phylink *pl, struct phy_device *phy)
+{
+	__ETHTOOL_DECLARE_LINK_MODE_MASK(eee_supported);
+
+	/* Convert the MAC's LPI capabilities to linkmodes */
+	linkmode_zero(eee_supported);
+	phylink_caps_to_linkmodes(eee_supported, pl->config->lpi_capabilities);
+
+	/* Mask out EEE modes that are not supported */
+	linkmode_and(phy->supported_eee, phy->supported_eee, eee_supported);
+	linkmode_and(phy->advertising_eee, phy->advertising_eee, eee_supported);
+}
+
 static void phylink_link_up(struct phylink *pl,
 			    struct phylink_link_state link_state)
 {
@@ -1620,6 +1674,9 @@ static void phylink_link_up(struct phylink *pl,
 				 pl->cur_interface, speed, duplex,
 				 !!(link_state.pause & MLO_PAUSE_TX), rx_pause);
 
+	if (pl->mac_supports_eee && pl->phy_enable_tx_lpi)
+		phylink_activate_lpi(pl);
+
 	if (ndev)
 		netif_carrier_on(ndev);
 
@@ -1636,6 +1693,9 @@ static void phylink_link_down(struct phylink *pl)
 
 	if (ndev)
 		netif_carrier_off(ndev);
+
+	phylink_deactivate_lpi(pl);
+
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
 	phylink_info(pl, "Link is Down\n");
@@ -1899,6 +1959,17 @@ struct phylink *phylink_create(struct phylink_config *config,
 		return ERR_PTR(-EINVAL);
 	}
 
+	pl->mac_supports_eee_ops = mac_ops->mac_disable_tx_lpi &&
+				   mac_ops->mac_enable_tx_lpi;
+	pl->mac_supports_eee = pl->mac_supports_eee_ops &&
+			       pl->config->lpi_capabilities &&
+			       !phy_interface_empty(pl->config->lpi_interfaces);
+
+	/* Set the default EEE configuration */
+	pl->eee_cfg.eee_enabled = pl->config->eee_enabled_default;
+	pl->eee_cfg.tx_lpi_enabled = pl->eee_cfg.eee_enabled;
+	pl->eee_cfg.tx_lpi_timer = pl->config->lpi_timer_default;
+
 	pl->phy_state.interface = iface;
 	pl->link_interface = iface;
 	if (iface == PHY_INTERFACE_MODE_MOCA)
@@ -2003,16 +2074,22 @@ static void phylink_phy_change(struct phy_device *phydev, bool up)
 	pl->phy_state.link = up;
 	if (!up)
 		pl->link_failed = true;
+
+	/* Get the LPI state from phylib */
+	pl->phy_enable_tx_lpi = phydev->enable_tx_lpi;
+	pl->mac_tx_lpi_timer = phydev->eee_cfg.tx_lpi_timer;
 	mutex_unlock(&pl->state_mutex);
 
 	phylink_run_resolve(pl);
 
-	phylink_dbg(pl, "phy link %s %s/%s/%s/%s/%s\n", up ? "up" : "down",
+	phylink_dbg(pl, "phy link %s %s/%s/%s/%s/%s/%slpi\n",
+		    up ? "up" : "down",
 		    phy_modes(phydev->interface),
 		    phy_speed_to_str(phydev->speed),
 		    phy_duplex_to_str(phydev->duplex),
 		    phy_rate_matching_to_str(phydev->rate_matching),
-		    phylink_pause_to_str(pl->phy_state.pause));
+		    phylink_pause_to_str(pl->phy_state.pause),
+		    phydev->enable_tx_lpi ? "" : "no");
 }
 
 static int phylink_validate_phy(struct phylink *pl, struct phy_device *phy,
@@ -2142,6 +2219,30 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 
 	/* Restrict the phy advertisement according to the MAC support. */
 	linkmode_copy(phy->advertising, config.advertising);
+
+	/* If the MAC supports phylink managed EEE, restrict the EEE
+	 * advertisement according to the MAC's LPI capabilities.
+	 */
+	if (pl->mac_supports_eee) {
+		/* If EEE is enabled, then we need to call phy_support_eee()
+		 * to ensure that the advertising mask is appropriately set.
+		 * This also enables EEE at the PHY.
+		 */
+		if (pl->eee_cfg.eee_enabled)
+			phy_support_eee(phy);
+
+		phy->eee_cfg.tx_lpi_enabled = pl->eee_cfg.tx_lpi_enabled;
+		phy->eee_cfg.tx_lpi_timer = pl->eee_cfg.tx_lpi_timer;
+
+		/* Restrict the PHYs EEE support/advertisement to the modes
+		 * that the MAC supports.
+		 */
+		phylink_phy_restrict_eee(pl, phy);
+	} else if (pl->mac_supports_eee_ops) {
+		/* MAC supports phylink EEE, but wants EEE always disabled. */
+		phy_disable_eee(phy);
+	}
+
 	mutex_unlock(&pl->state_mutex);
 	mutex_unlock(&phy->lock);
 
@@ -2157,7 +2258,13 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	if (pl->config->mac_managed_pm)
 		phy->mac_managed_pm = true;
 
-	return 0;
+	/* Allow the MAC to stop its clock if the PHY has the capability */
+	pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;
+
+	/* Explicitly configure whether the PHY is allowed to stop it's
+	 * receive clock.
+	 */
+	return phy_eee_rx_clock_stop(phy, pl->config->eee_rx_clk_stop_enable);
 }
 
 static int phylink_attach_phy(struct phylink *pl, struct phy_device *phy,
@@ -2314,6 +2421,8 @@ void phylink_disconnect_phy(struct phylink *pl)
 		mutex_lock(&phy->lock);
 		mutex_lock(&pl->state_mutex);
 		pl->phydev = NULL;
+		pl->phy_enable_tx_lpi = false;
+		pl->mac_tx_clk_stop = false;
 		mutex_unlock(&pl->state_mutex);
 		mutex_unlock(&phy->lock);
 		flush_work(&pl->resolve);
@@ -3068,6 +3177,9 @@ int phylink_ethtool_get_eee(struct phylink *pl, struct ethtool_keee *eee)
 
 	ASSERT_RTNL();
 
+	if (pl->mac_supports_eee_ops && !pl->mac_supports_eee)
+		return ret;
+
 	if (pl->phydev)
 		ret = phy_ethtool_get_eee(pl->phydev, eee);
 
@@ -3082,12 +3194,25 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_get_eee);
  */
 int phylink_ethtool_set_eee(struct phylink *pl, struct ethtool_keee *eee)
 {
+	bool mac_eee = pl->mac_supports_eee;
 	int ret = -EOPNOTSUPP;
 
 	ASSERT_RTNL();
 
-	if (pl->phydev)
+	phylink_dbg(pl, "mac %s phylink EEE%s, adv %*pbl, LPI%s timer %uus\n",
+		    mac_eee ? "supports" : "does not support",
+		    eee->eee_enabled ? ", enabled" : "",
+		    __ETHTOOL_LINK_MODE_MASK_NBITS, eee->advertised,
+		    eee->tx_lpi_enabled ? " enabled" : "", eee->tx_lpi_timer);
+
+	if (pl->mac_supports_eee_ops && !mac_eee)
+		return ret;
+
+	if (pl->phydev) {
 		ret = phy_ethtool_set_eee(pl->phydev, eee);
+		if (ret == 0)
+			eee_to_eeecfg(&pl->eee_cfg, eee);
+	}
 
 	return ret;
 }
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 4b7a20620b49..8e06d2812516 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -5,6 +5,8 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 
+#include <net/eee.h>
+
 struct device_node;
 struct ethtool_cmd;
 struct fwnode_handle;
@@ -143,11 +145,17 @@ enum phylink_op_type {
  *                    possible and avoid stopping it during suspend events.
  * @default_an_inband: if true, defaults to MLO_AN_INBAND rather than
  *		       MLO_AN_PHY. A fixed-link specification will override.
+ * @eee_rx_clk_stop_enable: if true, PHY can stop the receive clock during LPI
  * @get_fixed_state: callback to execute to determine the fixed link state,
  *		     if MAC link is at %MLO_AN_FIXED mode.
  * @supported_interfaces: bitmap describing which PHY_INTERFACE_MODE_xxx
  *                        are supported by the MAC/PCS.
+ * @lpi_interfaces: bitmap describing which PHY interface modes can support
+ *		    LPI signalling.
  * @mac_capabilities: MAC pause/speed/duplex capabilities.
+ * @lpi_capabilities: MAC speeds which can support LPI signalling
+ * @lpi_timer_default: Default EEE LPI timer setting.
+ * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
  */
 struct phylink_config {
 	struct device *dev;
@@ -156,10 +164,15 @@ struct phylink_config {
 	bool mac_managed_pm;
 	bool mac_requires_rxc;
 	bool default_an_inband;
+	bool eee_rx_clk_stop_enable;
 	void (*get_fixed_state)(struct phylink_config *config,
 				struct phylink_link_state *state);
 	DECLARE_PHY_INTERFACE_MASK(supported_interfaces);
+	DECLARE_PHY_INTERFACE_MASK(lpi_interfaces);
 	unsigned long mac_capabilities;
+	unsigned long lpi_capabilities;
+	u32 lpi_timer_default;
+	bool eee_enabled_default;
 };
 
 void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
@@ -173,6 +186,8 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
  * @mac_finish: finish a major reconfiguration of the interface.
  * @mac_link_down: take the link down.
  * @mac_link_up: allow the link to come up.
+ * @mac_disable_tx_lpi: disable LPI.
+ * @mac_enable_tx_lpi: enable and configure LPI.
  *
  * The individual methods are described more fully below.
  */
@@ -193,6 +208,9 @@ struct phylink_mac_ops {
 			    struct phy_device *phy, unsigned int mode,
 			    phy_interface_t interface, int speed, int duplex,
 			    bool tx_pause, bool rx_pause);
+	void (*mac_disable_tx_lpi)(struct phylink_config *config);
+	int (*mac_enable_tx_lpi)(struct phylink_config *config, u32 timer,
+				 bool tx_clk_stop);
 };
 
 #if 0 /* For kernel-doc purposes only. */
@@ -387,6 +405,33 @@ void mac_link_down(struct phylink_config *config, unsigned int mode,
 void mac_link_up(struct phylink_config *config, struct phy_device *phy,
 		 unsigned int mode, phy_interface_t interface,
 		 int speed, int duplex, bool tx_pause, bool rx_pause);
+
+/**
+ * mac_disable_tx_lpi() - disable LPI generation at the MAC
+ * @config: a pointer to a &struct phylink_config.
+ *
+ * Disable generation of LPI at the MAC, effectively preventing the MAC
+ * from indicating that it is idle.
+ */
+void mac_disable_tx_lpi(struct phylink_config *config);
+
+/**
+ * mac_enable_tx_lpi() - configure and enable LPI generation at the MAC
+ * @config: a pointer to a &struct phylink_config.
+ * @timer: LPI timeout in microseconds.
+ * @tx_clk_stop: allow xMII transmit clock to be stopped during LPI
+ *
+ * Configure the LPI timeout accordingly. This will only be called when
+ * the link is already up, to cater for situations where the hardware
+ * needs to be programmed according to the link speed.
+ *
+ * Enable LPI generation at the MAC, and configure whether the xMII transmit
+ * clock may be stopped.
+ *
+ * Returns: 0 on success. Please consult with rmk before returning an error.
+ */
+int mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
+		      bool tx_clk_stop);
 #endif
 
 struct phylink_pcs_ops;
-- 
2.30.2


