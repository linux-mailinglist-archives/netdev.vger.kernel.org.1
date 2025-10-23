Return-Path: <netdev+bounces-232024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A62C00310
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5003A94E2
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 09:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489B63019DA;
	Thu, 23 Oct 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0XY4qFwe"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04A3009DD;
	Thu, 23 Oct 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211009; cv=none; b=Rp8eQHiBikybmy/zIJz0xie8NypoKtDZstV4MAmn2jj9Hd6GVOmSXbar9rZPF7f7FojDzVNiEr30eDFYIfZlDXMrvA8gJlbxQvBZHfEw9K/OytzE+qzWlhRDVg5nq7K4/5GNS+9LypKkdt/B9BND3KAY6gNNlTEeCaL29k/VNR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211009; c=relaxed/simple;
	bh=jgx8oZjzTOubNI75/f6kGfcKZDSIxIqDzchd9sghRHc=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gy84leO6Ce09Sxp7/gAlOwESggffAuzJ8pppk8hvaJK0yvD9PLPGGavF1ppUHC/z85AVKQy0QKS5dJEPOtgthckNL6MhWX80pX8CSF5yl5YGCM3gyI2Svne9N2wJ9PZFUvelsd/KaaiCVNZZdV2sh7tn/qTmHywls7aDG4kmlb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0XY4qFwe; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hq8eSGJQR2tbu8Qfub5EGZF1AmodfN7Xb2wZ4KalfuA=; b=0XY4qFweMZLPy6RK1rcsklD0gZ
	3coqbtgYdvuLJcAG/CbZuN2n68wX9qHkN+HSHzIWilmGId9/xFNEb2AFtz/IyXUZiCfRsoXgjDBRp
	HsEuaCiZ+dqqmdjhM5FFEn5fg6/e/ur2s1k0frHqNpOpk8HYztQdc9Qtxq0tmUZXFvooAGvJchvlE
	gaPLsW+dl32zDfqWMem6CCV5IIyctUpowu9TkVJUVNJTwy11UE+tH3gM2ZyPJ0UqnAT2/vU+3rHgo
	AOsqrAJlniHr8CyJxyc3LYmyrizS4ibWiERq+r79D7t6JGq5HywZBpIgZ6Ukb7bk6ygpef2XyJQFJ
	7MALslzg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38296 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vBrR3-0000000061D-1zB1;
	Thu, 23 Oct 2025 10:16:41 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vBrR2-0000000BLzU-1xYL;
	Thu, 23 Oct 2025 10:16:40 +0100
In-Reply-To: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
References: <aPnyW54J80h9DmhB@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	devicetree@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>
Subject: [PATCH net-next v2 3/6] net: phylink: add phylink managed MAC
 Wake-on-Lan support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vBrR2-0000000BLzU-1xYL@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 23 Oct 2025 10:16:40 +0100

Add core phylink managed Wake-on-Lan support, which is enabled when the
MAC driver fills in the new .mac_wol_set() method that this commit
creates.

When this feature is disabled, phylink acts as it has in the past,
merely passing the ethtool WoL calls to phylib whenever a PHY exists.
No other new functionality provided by this commit is enabled.

When this feature is enabled, a more inteligent approach is used.
Phylink will first pass WoL options to the PHY, read them back, and
attempt to set any options that were not set at the PHY at the MAC.

Since we have PHY drivers that report they support WoL, and accept WoL
configuration even though they aren't wired up to be capable of waking
the system, we need a way to differentiate between PHYs that think
they support WoL and those which actually do. As PHY drivers do not
make use of the driver model's wake-up infrastructure, but could, we
use this to determine whether PHY drivers can participate. This gives
a path forward where, as MAC drivers are converted to this, it
encourages PHY drivers to also be converted.

Phylink will also ignore the mac_wol argument to phylink_suspend() as
it now knows the WoL state at the MAC.

MAC drivers are expected to record/configure the Wake-on-Lan state in
their .mac_set_wol() method, and deal appropriately with it in their
suspend/resume methods. The driver model provides assistance to set the
IRQ wake support which may assist driver authors in achieving the
necessary configuration.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
v2: initialise wolinfo in phylink_ethtool_set_wol().
---
 drivers/net/phy/phylink.c | 80 +++++++++++++++++++++++++++++++++++++--
 include/linux/phylink.h   | 26 +++++++++++++
 2 files changed, 102 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 9d7799ea1c17..bec44ebdf80b 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -93,6 +93,9 @@ struct phylink {
 	u8 sfp_port;
 
 	struct eee_config eee_cfg;
+
+	u32 wolopts_mac;
+	u8 wol_sopass[SOPASS_MAX];
 };
 
 #define phylink_printk(level, pl, fmt, ...) \
@@ -2562,6 +2565,17 @@ void phylink_rx_clk_stop_unblock(struct phylink *pl)
 }
 EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
 
+static bool phylink_mac_supports_wol(struct phylink *pl)
+{
+	return !!pl->mac_ops->mac_wol_set;
+}
+
+static bool phylink_phy_supports_wol(struct phylink *pl,
+				     struct phy_device *phydev)
+{
+	return phydev && (pl->config->wol_phy_legacy || phy_can_wakeup(phydev));
+}
+
 /**
  * phylink_suspend() - handle a network device suspend event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
@@ -2575,11 +2589,17 @@ EXPORT_SYMBOL_GPL(phylink_rx_clk_stop_unblock);
  *   can also bring down the link between the MAC and PHY.
  * - If Wake-on-Lan is active, but being handled by the MAC, the MAC
  *   still needs to receive packets, so we can not bring the link down.
+ *
+ * Note: when phylink managed Wake-on-Lan is in use, @mac_wol is ignored.
+ * (struct phylink_mac_ops.mac_set_wol populated.)
  */
 void phylink_suspend(struct phylink *pl, bool mac_wol)
 {
 	ASSERT_RTNL();
 
+	if (phylink_mac_supports_wol(pl))
+		mac_wol = !!pl->wolopts_mac;
+
 	if (mac_wol && (!pl->netdev || pl->netdev->ethtool->wol_enabled)) {
 		/* Wake-on-Lan enabled, MAC handling */
 		mutex_lock(&pl->state_mutex);
@@ -2689,8 +2709,24 @@ void phylink_ethtool_get_wol(struct phylink *pl, struct ethtool_wolinfo *wol)
 	wol->supported = 0;
 	wol->wolopts = 0;
 
-	if (pl->phydev)
-		phy_ethtool_get_wol(pl->phydev, wol);
+	if (phylink_mac_supports_wol(pl)) {
+		if (phylink_phy_supports_wol(pl, pl->phydev))
+			phy_ethtool_get_wol(pl->phydev, wol);
+
+		/* Where the MAC augments the WoL support, merge its support and
+		 * current configuration.
+		 */
+		if (~wol->wolopts & pl->wolopts_mac & WAKE_MAGICSECURE)
+			memcpy(wol->sopass, pl->wol_sopass,
+			       sizeof(wol->sopass));
+
+		wol->supported |= pl->config->wol_mac_support;
+		wol->wolopts |= pl->wolopts_mac;
+	} else {
+		/* Legacy */
+		if (pl->phydev)
+			phy_ethtool_get_wol(pl->phydev, wol);
+	}
 }
 EXPORT_SYMBOL_GPL(phylink_ethtool_get_wol);
 
@@ -2707,12 +2743,48 @@ EXPORT_SYMBOL_GPL(phylink_ethtool_get_wol);
  */
 int phylink_ethtool_set_wol(struct phylink *pl, struct ethtool_wolinfo *wol)
 {
+	struct ethtool_wolinfo w = { .cmd = ETHTOOL_GWOL };
 	int ret = -EOPNOTSUPP;
+	bool changed;
+	u32 wolopts;
 
 	ASSERT_RTNL();
 
-	if (pl->phydev)
-		ret = phy_ethtool_set_wol(pl->phydev, wol);
+	if (phylink_mac_supports_wol(pl)) {
+		wolopts = wol->wolopts;
+
+		if (phylink_phy_supports_wol(pl, pl->phydev)) {
+			ret = phy_ethtool_set_wol(pl->phydev, wol);
+			if (ret != 0 && ret != -EOPNOTSUPP)
+				return ret;
+
+			phy_ethtool_get_wol(pl->phydev, &w);
+
+			/* Any Wake-on-Lan modes which the PHY is handling
+			 * should not be passed on to the MAC.
+			 */
+			wolopts &= ~w.wolopts;
+		}
+
+		wolopts &= pl->config->wol_mac_support;
+		changed = pl->wolopts_mac != wolopts;
+		if (wolopts & WAKE_MAGICSECURE)
+			changed |= !!memcmp(wol->sopass, pl->wol_sopass,
+					    sizeof(wol->sopass));
+		memcpy(pl->wol_sopass, wol->sopass, sizeof(pl->wol_sopass));
+
+		if (changed) {
+			ret = pl->mac_ops->mac_wol_set(pl->config, wolopts,
+						       wol->sopass);
+			if (!ret)
+				pl->wolopts_mac = wolopts;
+		} else {
+			ret = 0;
+		}
+	} else {
+		if (pl->phydev)
+			ret = phy_ethtool_set_wol(pl->phydev, wol);
+	}
 
 	return ret;
 }
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 9af0411761d7..59cb58b29d1d 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -156,6 +156,8 @@ enum phylink_op_type {
  * @lpi_capabilities: MAC speeds which can support LPI signalling
  * @lpi_timer_default: Default EEE LPI timer setting.
  * @eee_enabled_default: If set, EEE will be enabled by phylink at creation time
+ * @wol_phy_legacy: Use Wake-on-Lan with PHY even if phy_can_wakeup() is false
+ * @wol_mac_support: Bitmask of MAC supported %WAKE_* options
  */
 struct phylink_config {
 	struct device *dev;
@@ -173,6 +175,10 @@ struct phylink_config {
 	unsigned long lpi_capabilities;
 	u32 lpi_timer_default;
 	bool eee_enabled_default;
+
+	/* Wake-on-Lan support */
+	bool wol_phy_legacy;
+	u32 wol_mac_support;
 };
 
 void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
@@ -188,6 +194,7 @@ void phylink_limit_mac_speed(struct phylink_config *config, u32 max_speed);
  * @mac_link_up: allow the link to come up.
  * @mac_disable_tx_lpi: disable LPI.
  * @mac_enable_tx_lpi: enable and configure LPI.
+ * @mac_wol_set: configure Wake-on-Lan settings at the MAC.
  *
  * The individual methods are described more fully below.
  */
@@ -211,6 +218,9 @@ struct phylink_mac_ops {
 	void (*mac_disable_tx_lpi)(struct phylink_config *config);
 	int (*mac_enable_tx_lpi)(struct phylink_config *config, u32 timer,
 				 bool tx_clk_stop);
+
+	int (*mac_wol_set)(struct phylink_config *config, u32 wolopts,
+			   const u8 *sopass);
 };
 
 #if 0 /* For kernel-doc purposes only. */
@@ -440,6 +450,22 @@ void mac_disable_tx_lpi(struct phylink_config *config);
  */
 int mac_enable_tx_lpi(struct phylink_config *config, u32 timer,
 		      bool tx_clk_stop);
+
+/**
+ * mac_wol_set() - configure the Wake-on-Lan parameters
+ * @config: a pointer to a &struct phylink_config.
+ * @wolopts: Bitmask of %WAKE_* flags for enabled Wake-On-Lan modes.
+ * @sopass: SecureOn(tm) password; meaningful only for %WAKE_MAGICSECURE
+ *
+ * Enable the specified Wake-on-Lan options at the MAC. Options that the
+ * PHY can handle will have been removed from @wolopts.
+ *
+ * The presence of this method enables phylink-managed WoL support.
+ *
+ * Returns: 0 on success.
+ */
+int (*mac_wol_set)(struct phylink_config *config, u32 wolopts,
+		   const u8 *sopass);
 #endif
 
 struct phylink_pcs_ops;
-- 
2.47.3


