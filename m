Return-Path: <netdev+bounces-169805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DD0A45C6F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80B93A3410
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F17442AA5;
	Wed, 26 Feb 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YpuC46+x"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0554B322A;
	Wed, 26 Feb 2025 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567619; cv=none; b=l7Pv7TJcvBI24F6Jrk/4JnfkaRTf+rBqIq8z50be3wUVX8jxyPHPRvf38hCTnhL2luKRe0pp88Z80Nt74klkHzagyJGRsNkrs6DQZcvtSaOLBYC9unyq4h1/Cp1uM2RHpZspH4H29Xi1tSDmPYML3zKIPBwyVdF62aYpSerT0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567619; c=relaxed/simple;
	bh=ApG6Ew9SI1aZoG+UxvBTZ+sutgnzMe2rdoFQZX2cS6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4ermQlUMQgT4EKYykJMps8NnDj06qZUjPNMs1zeo5/kWQwAQGYz7cb/UknGhxt5ePSaTlM3wCi35PH2Yv2dIwqgBFhcbx709res+px4Sq5uwiAVlC7hO2igUW9hU/kZcMjhVls+08M5/5wvCymdunMArcnDfsE6H5X59r5xMRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YpuC46+x; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u959TBYWOv9S7YvoxEBIspvDOHEq4YyJ10CaapL1Rnw=; b=YpuC46+xpDCnI9LSS2IXu08VWA
	RAQ4FGKjOmXC7t3M5vbVF2q93gZ/nbORvFCxSvEZAW1CdpdJsBLQSOA50BBqM0qKA6NBQ1EQn2sQ7
	jTAYkPaiNYVJvfNElRkwbjFDmwkq0XQG66S7ZKmB1Ze/GkTIa5moVBOKdTsULxLvxcsOj3lWeM9qe
	pk5jghlkg/CZxlwKFYkAqfWWCoBmUwScTMyFqomSM5F6kfqHfV1c4O6PA3qlqDik3d7jlsrQNXPa1
	8bV/HpTG2ICCPy2zXQutFS2/sUBKCvMlNpmdMnrUCXB5oIo8CKPMUu5j1AXX1R9KKE5AWTgAtk3US
	1H5xstuQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52384)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnF8z-00041N-02;
	Wed, 26 Feb 2025 11:00:01 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnF8v-000704-13;
	Wed, 26 Feb 2025 10:59:57 +0000
Date: Wed, 26 Feb 2025 10:59:57 +0000
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
Message-ID: <Z770LRrhPOjOsdrd@shell.armlinux.org.uk>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd1f65bf-8579-4d32-9c9c-9815d25cc116@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 10:11:58AM +0000, Jon Hunter wrote:
> 
> On 26/02/2025 10:02, Russell King (Oracle) wrote:
> > On Tue, Feb 25, 2025 at 02:21:01PM +0000, Jon Hunter wrote:
> > > Hi Russell,
> > > 
> > > On 19/02/2025 20:57, Russell King (Oracle) wrote:
> > > > So, let's try something (I haven't tested this, and its likely you
> > > > will need to work it in to your other change.)
> > > > 
> > > > Essentially, this disables the receive clock stop around the reset,
> > > > something the stmmac driver has never done in the past.
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index 1cbea627b216..8e975863a2e3 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -7926,6 +7926,8 @@ int stmmac_resume(struct device *dev)
> > > >    	rtnl_lock();
> > > >    	mutex_lock(&priv->lock);
> > > > +	phy_eee_rx_clock_stop(priv->dev->phydev, false);
> > > > +
> > > >    	stmmac_reset_queues_param(priv);
> > > >    	stmmac_free_tx_skbufs(priv);
> > > > @@ -7937,6 +7939,9 @@ int stmmac_resume(struct device *dev)
> > > >    	stmmac_restore_hw_vlan_rx_fltr(priv, ndev, priv->hw);
> > > > +	phy_eee_rx_clock_stop(priv->dev->phydev,
> > > > +			      priv->phylink_config.eee_rx_clk_stop_enable);
> > > > +
> > > >    	stmmac_enable_all_queues(priv);
> > > >    	stmmac_enable_all_dma_irq(priv);
> > > 
> > > 
> > > Sorry for the delay, I have been testing various issues recently and needed
> > > a bit more time to test this.
> > > 
> > > It turns out that what I had proposed last week does not work. I believe
> > > that with all the various debug/instrumentation I had added, I was again
> > > getting lucky. So when I tested again this week on top of vanilla v6.14-rc2,
> > > it did not work :-(
> > > 
> > > However, what you are suggesting above, all by itself, is working. I have
> > > tested this on top of vanilla v6.14-rc2 and v6.14-rc4 and it is working
> > > reliably. I have also tested on some other boards that use the same stmmac
> > > driver (but use the Aquantia PHY) and I have not seen any issues. So this
> > > does fix the issue I am seeing.
> > > 
> > > I know we are getting quite late in the rc for v6.14, but not sure if we
> > > could add this as a fix?
> > 
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

Do we think this needs to be a patch for the net tree or the net-next
tree? I think we've established that it's been a long-standing bug,
so maybe if we target net-next to give it more time to be tested?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

