Return-Path: <netdev+bounces-144809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CABFB9C8772
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449661F218B4
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B151FB734;
	Thu, 14 Nov 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X2HaR6Hx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DB61FAF1C;
	Thu, 14 Nov 2024 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731579359; cv=none; b=kdL97omnUQmONpf2dQ4JhLNYaISk29f3Lbx10gmADco2Z6azMHAiLv/i0+Q6U7ALSCXI2Ab1Vq/oep+FHqyZ+Q8NKFoNCTefNGKHcEwPmtztbMEE5HD/xfWU7+DejH/aJMk5pW7C0pIJ7OFYjIUZJdWQ1drmUtSovA4oqog9WOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731579359; c=relaxed/simple;
	bh=vaxnoBJzKRVUIZrNTOT4m9eROwHwfeodA+AY/ly6VGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfpQ07g4Hq1mY4z94nEkSB+dHsBTqxQRdiVZj9aCqlxKxeiSycIsWV3o11rvmD2MuduCBE+zqdydljr13bB9Wi7+sNiNrPPuCJT7HVRTuW3Q2RJCGRpBsI1kVUBvkSARZeqCt512GIOmMHENxGcTtiBVUPIJww35rB6tfTVsb/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X2HaR6Hx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Tfs37pvOlG3pbk6MXe8wdDHOmktqFBXJiyyi+ALByIQ=; b=X2HaR6HxWpTIR5/FBIYDWbNiUh
	1WpnHZk7/VV95x6NsI7vXVZiqJGpclhIxL7jR1AL8Nbxj4nVppSaZdo2yZOAuUCsjfwssPr978DKX
	LSDQAGbDmZe0PB/m8oTOYJKpalLWxRSGLkOA6PHHRqelAxftz+tmZZZsW0DEf6yvw/dXJZXYqLPGX
	fMLiP1NmGTrDkZPHXfejnRfszArnssjfbPdsPtYPREZ+B5VOO6geGTCs0Q28e8nCVXxQS/5jiJJ49
	cWM0W2b8O3IPMfP9EOEkhN022Ne1cDdqhMpuGEXLs2iyuxl39BhOBre9aHpEQ3nJCfOeMVuVo8SDG
	DKWkCFHg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45596)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tBWt7-0007oD-14;
	Thu, 14 Nov 2024 10:15:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tBWt4-000127-31;
	Thu, 14 Nov 2024 10:15:42 +0000
Date: Thu, 14 Nov 2024 10:15:42 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to
 update eee_cfg values
Message-ID: <ZzXNzv5dt0UozSLR@shell.armlinux.org.uk>
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
 <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
 <71b6be0e-426f-4fb4-9d28-27c55d5afa51@lunn.ch>
 <eb937669-d4ce-4b72-bcae-0660e1345b76@linux.intel.com>
 <ZzW8t2bCTXJCP7-_@shell.armlinux.org.uk>
 <ZzW-5gj0cdbwdwZv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzW-5gj0cdbwdwZv@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Nov 14, 2024 at 09:12:06AM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 14, 2024 at 09:02:47AM +0000, Russell King (Oracle) wrote:
> > On Wed, Nov 13, 2024 at 06:10:55PM +0800, Choong Yong Liang wrote:
> > > On 12/11/2024 9:04 pm, Andrew Lunn wrote:
> > > > On Tue, Nov 12, 2024 at 12:03:15PM +0100, Heiner Kallweit wrote:
> > > > > In stmmac_ethtool_op_get_eee() you have the following:
> > > > > 
> > > > > edata->tx_lpi_timer = priv->tx_lpi_timer;
> > > > > edata->tx_lpi_enabled = priv->tx_lpi_enabled;
> > > > > return phylink_ethtool_get_eee(priv->phylink, edata);
> > > > > 
> > > > > You have to call phylink_ethtool_get_eee() first, otherwise the manually
> > > > > set values will be overridden. However setting tx_lpi_enabled shouldn't
> > > > > be needed if you respect phydev->enable_tx_lpi.
> > > > 
> > > > I agree with Heiner here, this sounds like a bug somewhere, not
> > > > something which needs new code in phylib. Lets understand why it gives
> > > > the wrong results.
> > > > 
> > > > 	Andrew
> > > Hi Russell, Andrew, and Heiner, thanks a lot for your valuable feedback.
> > > 
> > > The current implementation of the 'ethtool --show-eee' command heavily
> > > relies on the phy_ethtool_get_eee() in phy.c. The eeecfg values are set by
> > > the 'ethtool --set-eee' command and the phy_support_eee() during the initial
> > > state. The phy_ethtool_get_eee() calls eeecfg_to_eee(), which returns the
> > > eeecfg containing tx_lpi_timer, tx_lpi_enabled, and eee_enable for the
> > > 'ethtool --show-eee' command.
> > 
> > These three members you mention are user configuration members.
> > 
> > > The tx_lpi_timer and tx_lpi_enabled values stored in the MAC or PHY driver
> > > are not retrieved by the 'ethtool --show-eee' command.
> > 
> > tx_lpi_timer is the only thing that the MAC driver should be concerned
> > with - it needs to program the MAC according to the timer value
> > specified. Whether LPI is enabled or not is determined by
> > phydev->enable_tx_lpi. The MAC should be using nothing else.
> > 
> > > Currently, we are facing 3 issues:
> > > 1. When we boot up our system and do not issue the 'ethtool --set-eee'
> > > command, and then directly issue the 'ethtool --show-eee' command, it always
> > > shows that EEE is disabled due to the eeecfg values not being set. However,
> > > in the Maxliner GPY PHY, the driver EEE is enabled.
> > 
> > So the software state is out of sync with the hardware state. This is a
> > bug in the GPY PHY driver.
> > 
> > If we look at the generic code, we can see that genphy_config_aneg()
> > calls __genphy_config_aneg() which then goes on to call
> > genphy_c45_an_config_eee_aneg(). genphy_c45_an_config_eee_aneg()
> > writes the current EEE configuration to the PHY.
> > 
> > Now if we look at gpy_config_aneg(), it doesn't do this. Therefore,
> > the GPY PHY is retaining its hardware state which is different from
> > the software state. This is wrong.
> 
> Also note that phy_probe() reads the current configuration from the
> PHY. The supported mask is set via phydev->drv->get_features,
> which calls genphy_c45_pma_read_abilities() via the GPY driver and
> genphy_c45_read_eee_abilities().
> 
> phy_probe() then moved on to genphy_c45_read_eee_adv(), which reads
> the advertisement mask. If the advertising mask is non-zero, then
> EEE is set as enabled.
> 
> From your description, it sounds like this isn't working right, and
> needs to be debugged. For example, is the PHY changing its EEE
> advertisement between phy_probe() and when it is up and running?

For the benefit of this thread - phylib definitely has a problem. It's
got one too many things called eee_enabled, leading to confusion about
which should be used. I've now built this patch, and am testing it
with a Marvell PHY.

Without a call to phy_support_eee():

EEE settings for eth2:
        EEE status: disabled
        Tx LPI: disabled
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  Not reported
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full

With a call to phy_support_eee():

EEE settings for eth2:
        EEE status: enabled - active
        Tx LPI: 0 (us)
        Supported EEE link modes:  100baseT/Full
                                   1000baseT/Full
        Advertised EEE link modes:  100baseT/Full
                                    1000baseT/Full
        Link partner advertised EEE link modes:  100baseT/Full
                                                 1000baseT/Full

So the EEE status is now behaving correctly, and the Marvell PHY is
being programmed with the advertisement correctly.

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index c1b3576c307f..2d64d3f293e5 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -943,7 +943,7 @@ EXPORT_SYMBOL_GPL(genphy_c45_read_eee_abilities);
  */
 int genphy_c45_an_config_eee_aneg(struct phy_device *phydev)
 {
-	if (!phydev->eee_enabled) {
+	if (!phydev->eee_cfg.eee_enabled) {
 		__ETHTOOL_DECLARE_LINK_MODE_MASK(adv) = {};
 
 		return genphy_c45_write_eee_adv(phydev, adv);
@@ -1576,8 +1576,6 @@ int genphy_c45_ethtool_set_eee(struct phy_device *phydev,
 		}
 	}
 
-	phydev->eee_enabled = data->eee_enabled;
-
 	ret = genphy_c45_an_config_eee_aneg(phydev);
 	if (ret > 0) {
 		ret = phy_restart_aneg(phydev);
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index bc24c9f2786b..b26bb33cd1d4 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3589,12 +3589,12 @@ static int phy_probe(struct device *dev)
 	/* There is no "enabled" flag. If PHY is advertising, assume it is
 	 * kind of enabled.
 	 */
-	phydev->eee_enabled = !linkmode_empty(phydev->advertising_eee);
+	phydev->eee_cfg.eee_enabled = !linkmode_empty(phydev->advertising_eee);
 
 	/* Some PHYs may advertise, by default, not support EEE modes. So,
 	 * we need to clean them.
 	 */
-	if (phydev->eee_enabled)
+	if (phydev->eee_cfg.eee_enabled)
 		linkmode_and(phydev->advertising_eee, phydev->supported_eee,
 			     phydev->advertising_eee);
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 1e4127c495c0..33905e9672a7 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -601,7 +601,6 @@ struct macsec_ops;
  * @adv_old: Saved advertised while power saving for WoL
  * @supported_eee: supported PHY EEE linkmodes
  * @advertising_eee: Currently advertised EEE linkmodes
- * @eee_enabled: Flag indicating whether the EEE feature is enabled
  * @enable_tx_lpi: When True, MAC should transmit LPI to PHY
  * @eee_cfg: User configuration of EEE
  * @lp_advertising: Current link partner advertised linkmodes
@@ -721,7 +720,6 @@ struct phy_device {
 	/* used for eee validation and configuration*/
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported_eee);
 	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertising_eee);
-	bool eee_enabled;
 
 	/* Host supported PHY interface types. Should be ignored if empty. */
 	DECLARE_PHY_INTERFACE_MASK(host_interfaces);

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

