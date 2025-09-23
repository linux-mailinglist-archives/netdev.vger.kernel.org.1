Return-Path: <netdev+bounces-225583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC60B95A5D
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2084E2D06
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D9145B3F;
	Tue, 23 Sep 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wvvoM4eu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B778321F31
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626799; cv=none; b=KEzyDS5zOt2lUfuBaKkFmThjQoc7+48styl3ze+TZvKYiUxnryYGymgPy3RNP9yO1ulvekRP91Hv/SwAEoRE4xOQmv4tl88vJVcdBy79+T45VaS8onfYAkOrDLYDImD5GkEzb7ZyzDboIbwzyA82OjSX6NR6OVAMr8ABfzMpk6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626799; c=relaxed/simple;
	bh=U0vHf2j5EEQQF47ggQL/jOeVOq1G4esMf7qdocNs178=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=bRWFJ/G+gCe9x2JYM52a04/AFbFh9KXiJembavXVX0qO4DyofiUlMcbO1B+guuCzENepljeXyD3tebHD4zEqbVtckQuph/RNAsPGYvbFBvw4wehBHstaJWCcIIWm6+1l8Dwy7I9xdPfNcWqyxlRQpNVHISl1utEGLQEvP83iBLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wvvoM4eu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=q24K7de5jaqh0rHllgz2My1TxD+1mvaZiPDKkSvAA3Q=; b=wvvoM4eue0TfQLiDWTqBwk1u4u
	AsxrfAUxyL7D6hjK6sPr6Geqd2HnXq+KNGvlv1HLDZxk3OgvpFN7fZ/LWRINV+3T4+xru0eBdC2lT
	ugsvxuDIsfBYn+hLyY1Lpi31onpgDakqrHKKZsRUv4TOz+thtDHi5psMT1uFTew16u1XdXQHzV8TB
	qOtKTopPDI39RhjAk8o7NwFpjWdnQCkcF8/8trnhh/looSHN5cyhm+zQsl8Wyqh1lTPovM1v+Rayi
	sRLv+EL9+lW1UVqIlZIbX5QjeaAQRyKKsZ6LCgSu/Jgov2mt/Ugaqx28qDO8VLjRwL6p0AykjbtBP
	plq2/Oig==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:39568 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1v11AB-0000000079Z-0c1x;
	Tue, 23 Sep 2025 12:26:27 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1v11A8-0000000774M-3pmH;
	Tue, 23 Sep 2025 12:26:24 +0100
In-Reply-To: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
References: <aNKDqqI7aLsuDD52@shell.armlinux.org.uk>
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
Subject: [PATCH net-next 6/6] net: stmmac: simplify stmmac_init_phy()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1v11A8-0000000774M-3pmH@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 23 Sep 2025 12:26:24 +0100

If we fail to attach a PHY, there is no point trying to configure WoL
settings. Exit the function after printing the "cannot attach to PHY"
error, and remove the now unnecessary code indentation for configuring
the LPI timer in phylink. Since we know that "ret" must be zero at this
point, change the final return to use a constant rather than "ret".

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4844d563e291..be064f240895 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -1115,6 +1115,7 @@ static int stmmac_init_phy(struct net_device *dev)
 	int mode = priv->plat->phy_interface;
 	struct fwnode_handle *phy_fwnode;
 	struct fwnode_handle *fwnode;
+	struct ethtool_keee eee;
 	int ret;
 
 	if (!phylink_expects_phy(priv->phylink))
@@ -1160,19 +1161,17 @@ static int stmmac_init_phy(struct net_device *dev)
 	if (ret) {
 		netdev_err(priv->dev, "cannot attach to PHY (error: %pe)\n",
 			   ERR_PTR(ret));
-	} else {
-		struct ethtool_keee eee;
+		return ret;
+	}
 
-		/* Configure phylib's copy of the LPI timer. Normally,
-		 * phylink_config.lpi_timer_default would do this, but there is
-		 * a chance that userspace could change the eee_timer setting
-		 * via sysfs before the first open. Thus, preserve existing
-		 * behaviour.
-		 */
-		if (!phylink_ethtool_get_eee(priv->phylink, &eee)) {
-			eee.tx_lpi_timer = priv->tx_lpi_timer;
-			phylink_ethtool_set_eee(priv->phylink, &eee);
-		}
+	/* Configure phylib's copy of the LPI timer. Normally,
+	 * phylink_config.lpi_timer_default would do this, but there is a
+	 * chance that userspace could change the eee_timer setting via sysfs
+	 * before the first open. Thus, preserve existing behaviour.
+	 */
+	if (!phylink_ethtool_get_eee(priv->phylink, &eee)) {
+		eee.tx_lpi_timer = priv->tx_lpi_timer;
+		phylink_ethtool_set_eee(priv->phylink, &eee);
 	}
 
 	if (!priv->plat->pmt) {
@@ -1183,7 +1182,7 @@ static int stmmac_init_phy(struct net_device *dev)
 		device_set_wakeup_enable(priv->device, !!wol.wolopts);
 	}
 
-	return ret;
+	return 0;
 }
 
 static int stmmac_phy_setup(struct stmmac_priv *priv)
-- 
2.47.3


