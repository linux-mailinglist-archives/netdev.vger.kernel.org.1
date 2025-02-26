Return-Path: <netdev+bounces-169824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A18A45D54
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBF1B7A65DF
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A242153EA;
	Wed, 26 Feb 2025 11:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="D1SpJUTl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DB216382;
	Wed, 26 Feb 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740569905; cv=none; b=DMcF+D4GRb+fuJUkuQG8qYdwVlWHrNkskGNfQrMIHVZ7WK8cU/NiHGr1NAXBlf9OWv7FKbzOFBzZAjVZVFwq0Sqwgjs4N026uRJvwEutF/1z5lmaXztACg4CHdhw/xiXEu94JnbjEYLBBr9wlh6u46BJx5vw4vFKXlw2lg/OHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740569905; c=relaxed/simple;
	bh=OUg8cZA7IfFfcuR+4iMWbOGkxw9GJ0G5Kdx4qjUdK5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1m292Qwe8jqi6PJ8G9NBpNe1HunDzr+vbT4qF5od/hT4KW3wRxracHKcWWcO0t2SjnJzIKJe88dKBg62xfwyQOdGeWC8fnhk3tMN6VC0wi7PI845EVFk/OjS+neZ+VJ4BR4c0aBb8vEVZv7jUvN1P70YVf23kfiiD/0N5VnGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=D1SpJUTl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=y9BAqSnFFNaw8imer/kwMAPgxvAbHzc55cjQboyE68c=; b=D1SpJUTlsB6X390df0Z143pp1m
	N4oNs6gz9iuF/Ff/JFJvTgpa0RWUOjFTKJD1ClCHelSSvsi1BoG0rr/FuAfjG2Vhra1TdP88nmhj0
	JI3RC7uOPNGJHKp9mpZheKAe7V9xczdeNqdpcEu5Kfb/h15ixpMWWbyH6i46iPo+i85+hq5PbrUuj
	dfi4P49Smxd4FXvbsvPl9H1ygrhLEyL3hF/SnqiO1qJzyhtAoDU3HQnc5rJ/H1hEPYdNLkXW6VUnM
	NnEUh55FDtXESogMy7zcOXjUYXSNNdQV6rTv5h2M4DjsHshAtXzYsXDKvxlkZOoZd2ssH1c7Pn4mf
	eLE6cs1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36448)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnFjo-00046K-2J;
	Wed, 26 Feb 2025 11:38:04 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnFjj-00071h-28;
	Wed, 26 Feb 2025 11:37:59 +0000
Date: Wed, 26 Feb 2025 11:37:59 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Bryan Whitehead <bryan.whitehead@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH net-next 9/9] net: stmmac: convert to phylink managed EEE
 support
Message-ID: <Z779FzlWTwbbKW1s@shell.armlinux.org.uk>
References: <Z68nSJqVxcnCc1YB@shell.armlinux.org.uk>
 <86fae995-1700-420b-8d84-33ab1e1f6353@nvidia.com>
 <Z7X6Z8yLMsQ1wa2D@shell.armlinux.org.uk>
 <203871c2-c673-4a98-a0a3-299d1cf71cf0@nvidia.com>
 <Z7YtWmkVl0rWFvQO@shell.armlinux.org.uk>
 <fd4af708-0c92-4295-9801-bf53db3a16cc@nvidia.com>
 <Z7ZF0dA4-jwU7O2E@shell.armlinux.org.uk>
 <31731125-ab8f-48d9-bd6f-431d49431957@nvidia.com>
 <Z77myuNCoe_la7e4@shell.armlinux.org.uk>
 <dd1f65bf-8579-4d32-9c9c-9815d25cc116@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="6YZS2zdWWQ7tS9pq"
Content-Disposition: inline
In-Reply-To: <dd1f65bf-8579-4d32-9c9c-9815d25cc116@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>


--6YZS2zdWWQ7tS9pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2025 at 10:11:58AM +0000, Jon Hunter wrote:
> On 26/02/2025 10:02, Russell King (Oracle) wrote:
> > The patch above was something of a hack, bypassing the layering, so I
> > would like to consider how this should be done properly.
> > 
> > I'm still wondering whether the early call to phylink_resume() is
> > symptomatic of this same issue, or whether there is a PHY that needs
> > phy_start() to be called to output its clock even with link down that
> > we don't know about.
> > 
> > The phylink_resume() call is relevant to this because I'd like to put:
> > 
> > 	phy_eee_rx_clock_stop(priv->dev->phydev,
> > 			      priv->phylink_config.eee_rx_clk_stop_enable);
> > 
> > in there to ensure that the PHY is correctly configured for clock-stop,
> > but given stmmac's placement that wouldn't work.
> > 
> > I'm then thinking of phylink_pre_resume() to disable the EEE clock-stop
> > at the PHY.
> > 
> > I think the only thing we could do is try solving this problem as per
> > above and see what the fall-out from it is. I don't get the impression
> > that stmmac users are particularly active at testing patches though, so
> > it may take months to get breakage reports.
> 
> 
> We can ask Furong to test as he seems to active and making changes, but
> otherwise I am not sure how well it is being tested across various devices.
> On the other hand, it feels like there are still lingering issues like this
> with the driver and so I would hope this is moving in the right direction.
> 
> Let me know if you have a patch you want me to test and I will run in on our
> Tegra186, Tegra194 and Tegra234 devices that all use this.

The attached patches shows what I'm thinking of - it's just been roughed
out, and only been build tested.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

--6YZS2zdWWQ7tS9pq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-phylink-add-config-of-PHY-receive-clock-stop-in-.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 1/5] net: phylink: add config of PHY receive
 clock-stop in phylink_resume()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index a3b186ab3854..0aae0bb2a254 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2264,7 +2264,7 @@ static int phylink_bringup_phy(struct phylink *pl, struct phy_device *phy,
 	pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;
 
 	if (pl->mac_supports_eee_ops) {
-		/* Explicitly configure whether the PHY is allowed to stop it's
+		/* Explicitly configure whether the PHY is allowed to stop its
 		 * receive clock.
 		 */
 		ret = phy_eee_rx_clock_stop(phy,
@@ -2645,8 +2645,22 @@ EXPORT_SYMBOL_GPL(phylink_suspend);
  */
 void phylink_resume(struct phylink *pl)
 {
+	int ret;
+
 	ASSERT_RTNL();
 
+	if (pl->mac_supports_eee_ops && pl->phydev) {
+		/* Explicitly configure whether the PHY is allowed to stop its
+		 * receive clock on resume to ensure that it is correctly
+		 * configured.
+		 */
+		ret = phy_eee_rx_clock_stop(pl->phydev,
+					    pl->config->eee_rx_clk_stop_enable);
+		if (ret == -EOPNOTSUPP)
+			phylink_warn(pl, "failed to set rx clock stop: %pe\n",
+				     ERR_PTR(ret));
+	}
+
 	if (test_bit(PHYLINK_DISABLE_MAC_WOL, &pl->phylink_disable_state)) {
 		/* Wake-on-Lan enabled, MAC handling */
 
-- 
2.30.2


--6YZS2zdWWQ7tS9pq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-net-phylink-add-phylink_prepare_resume.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 2/5] net: phylink: add phylink_prepare_resume()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Add a resume preparation function, which will ensure that the receive
clock from the PHY is appropriately configured while resuming.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 24 ++++++++++++++++++++++++
 include/linux/phylink.h   |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0aae0bb2a254..976e569feb70 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2636,6 +2636,30 @@ void phylink_suspend(struct phylink *pl, bool mac_wol)
 }
 EXPORT_SYMBOL_GPL(phylink_suspend);
 
+/**
+ * phylink_prepare_resume() - prepare to resume a network device
+ * @pl: a pointer to a &struct phylink returned from phylink_create()
+ *
+ * Optional, thus must be called prior to phylink_resume().
+ *
+ * Prepare to resume a network device, preparing the PHY as necessary.
+ */
+void phylink_prepare_resume(struct phylink *pl)
+{
+	ASSERT_RTNL();
+
+	/* If the MAC requires the receive clock, but receive clock
+	 * stop was enabled at the PHY, we need to ensure that the
+	 * receive clock is running. Disable receive clock stop.
+	 * phylink_resume() will re-enable it if necessary.
+	 */
+	if (pl->mac_supports_eee_ops && pl->phydev &&
+	    pl->config->mac_requires_rxc &&
+	    pl->config->eee_rx_clk_stop_enable)
+		phy_eee_rx_clock_stop(pl->phydev, false);
+}
+EXPORT_SYMBOL_GPL(phylink_prepare_resume);
+
 /**
  * phylink_resume() - handle a network device resume event
  * @pl: a pointer to a &struct phylink returned from phylink_create()
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 08df65f6867a..071ed4683c8c 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -699,6 +699,7 @@ void phylink_start(struct phylink *);
 void phylink_stop(struct phylink *);
 
 void phylink_suspend(struct phylink *pl, bool mac_wol);
+void phylink_prepare_resume(struct phylink *pl);
 void phylink_resume(struct phylink *pl);
 
 void phylink_ethtool_get_wol(struct phylink *, struct ethtool_wolinfo *);
-- 
2.30.2


--6YZS2zdWWQ7tS9pq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0003-net-stmmac-move-phylink_resume-after-resume-setup-is.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 3/5] net: stmmac: move phylink_resume() after resume
 setup is complete
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Move phylink_resume() to be after the setup in stmmac_resume() has
completed, as phylink_resume() may result in an immediate call to the
.mac_link_up method, which will enable the transmitter and receiver,
and enable the transmit queues.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d552e64eaa90..b9f651d77c4f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7926,16 +7926,6 @@ int stmmac_resume(struct device *dev)
 			return ret;
 	}
 
-	rtnl_lock();
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_resume(priv->phylink);
-	} else {
-		phylink_resume(priv->phylink);
-		if (device_may_wakeup(priv->device))
-			phylink_speed_up(priv->phylink);
-	}
-	rtnl_unlock();
-
 	rtnl_lock();
 	mutex_lock(&priv->lock);
 
@@ -7954,6 +7944,15 @@ int stmmac_resume(struct device *dev)
 	stmmac_enable_all_dma_irq(priv);
 
 	mutex_unlock(&priv->lock);
+
+	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
+		phylink_resume(priv->phylink);
+	} else {
+		phylink_resume(priv->phylink);
+		if (device_may_wakeup(priv->device))
+			phylink_speed_up(priv->phylink);
+	}
+
 	rtnl_unlock();
 
 	netif_device_attach(ndev);
-- 
2.30.2


--6YZS2zdWWQ7tS9pq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0004-net-stmmac-simplify-calls-to-phylink_suspend-and-phy.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 4/5] net: stmmac: simplify calls to phylink_suspend()
 and phylink_resume()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

Currently, the calls to phylink's suspend and resume functions are
inside overly complex tests, and boil down to:

	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
		call phylink
	} else {
		call phylink and
		if (device_may_wakeup(priv->device))
			do something else
	}

This results in phylink always being called, possibly with differing
arguments for phylink_suspend().

Simplify this code, noting that each site is slightly different due to
the order in which phylink is called and the "something else".

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b9f651d77c4f..262718e5c4f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7831,13 +7831,11 @@ int stmmac_suspend(struct device *dev)
 	mutex_unlock(&priv->lock);
 
 	rtnl_lock();
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_suspend(priv->phylink, true);
-	} else {
-		if (device_may_wakeup(priv->device))
-			phylink_speed_down(priv->phylink, false);
-		phylink_suspend(priv->phylink, false);
-	}
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_down(priv->phylink, false);
+
+	phylink_suspend(priv->phylink,
+			device_may_wakeup(priv->device) && priv->plat->pmt);
 	rtnl_unlock();
 
 	if (stmmac_fpe_supported(priv))
@@ -7945,13 +7943,9 @@ int stmmac_resume(struct device *dev)
 
 	mutex_unlock(&priv->lock);
 
-	if (device_may_wakeup(priv->device) && priv->plat->pmt) {
-		phylink_resume(priv->phylink);
-	} else {
-		phylink_resume(priv->phylink);
-		if (device_may_wakeup(priv->device))
-			phylink_speed_up(priv->phylink);
-	}
+	phylink_resume(priv->phylink);
+	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
+		phylink_speed_up(priv->phylink);
 
 	rtnl_unlock();
 
-- 
2.30.2


--6YZS2zdWWQ7tS9pq
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0005-net-stmmac-call-phylink_prepare_resume.patch"

From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Bcc: linux@mail.armlinux.org.uk
Subject: [PATCH net-next 5/5] net: stmmac: call phylink_prepare_resume()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

The stmmac core needs the receive clock to be running in order to
complete its software triggered reset. However, the media link may
be in EEE low-power mode, and as the driver allows the PHY receive
clock to be disabled, the receive clock may not be present while
resuming. This has been observed with Tegra 186.

Fix this by using the newly provided phylink_prepare_resume() to
temporarily disable receive clock stop while resuming. phylink_resume()
will restore the receive clock stop setting according to the
configuration passed from the netdev driver.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 262718e5c4f3..31ec1818211d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7925,6 +7925,8 @@ int stmmac_resume(struct device *dev)
 	}
 
 	rtnl_lock();
+	phylink_prepare_resume(priv->phylink);
+
 	mutex_lock(&priv->lock);
 
 	stmmac_reset_queues_param(priv);
-- 
2.30.2


--6YZS2zdWWQ7tS9pq--

