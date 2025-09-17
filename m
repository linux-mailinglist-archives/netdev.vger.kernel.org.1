Return-Path: <netdev+bounces-224126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F62B81068
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 18:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086C13B20E4
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 16:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05822F3C35;
	Wed, 17 Sep 2025 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lqNmbubT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B86288A2;
	Wed, 17 Sep 2025 16:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126696; cv=none; b=IwhsmY29IwVbqHznnfies+249KXt6HUZxBCDwdRCNmz1h5OiGuIn3woygP65edyq33c6b3xJ5myNR6Tsvp683/1LAj+4cCxO6WJ82TUkeqlQR9D0kpT+xaCvPm6m8gJ0idEG8AfJRaDzNA1PtsGkTgRutic0jJsoQFlVfdIS/pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126696; c=relaxed/simple;
	bh=UVuCdBv0y0ssaMtXvdPJf82lnAZePvxoqcizxkhuiYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1r7snYmhVZhZgfk81vPWMfzQHH/4eRpF4YA7PcXbhl1yWULi/NBlfbe5licoLsItmgQN2mD06ZBVZMh3SzMah83t69Xvq0ONJK2dz54XpX+4HXRbpMy5Z1mYrElDuzXRjKy+znpwNFVSoWxuTJl7O/tEILvVGN60LlONkvILCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=lqNmbubT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t7ZqalwnvjICi7kuOiOIafiliCtJGxrARFdp8W4lXxY=; b=lqNmbubTKYTpthGWHPykLNREkq
	a6h0sXLqwZcvzf1kHFi8/4wqRzTLPZ5t4JG0CX4Ax83EBEIolNl3BmwHrN5NmNiZX671xdmPJSgH2
	nFtq7ceA+M5n1PeBvkOVPFNvRXxDrq8tYVBobWZmNDyHpKQmZ158OQtCadM+oLJDaOmnk77cmCPYl
	IFMBaQIdpJj0yuWqNpTnxRkrKexCbJs00Ef7dR2v3QxXq/JjrV8aDwIZKLzlbVv7iTPkFIPpFwXkb
	d6e9GNwiy2bH5R5G8dIxQjEYUZwXZcz8KvO6Swi1xoMfVcDOTSVBZeIUeAISi+cACfrpX4OE/tHJs
	d90qzIPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49908)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uyv3v-000000005BG-32EF;
	Wed, 17 Sep 2025 17:31:19 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uyv3s-000000000LJ-1mOb;
	Wed, 17 Sep 2025 17:31:16 +0100
Date: Wed, 17 Sep 2025 17:31:16 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien Chevallier <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
Message-ID: <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 17, 2025 at 05:36:37PM +0200, Gatien Chevallier wrote:
> If the "st,phy-wol" property is present in the device tree node,
> set the STMMAC_FLAG_USE_PHY_WOL flag to use the WoL capability of
> the PHY.
> 
> Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> index 77a04c4579c9dbae886a0b387f69610a932b7b9e..6f197789cc2e8018d6959158b795e4bca46869c5 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> @@ -106,6 +106,7 @@ struct stm32_dwmac {
>  	u32 speed;
>  	const struct stm32_ops *ops;
>  	struct device *dev;
> +	bool phy_wol;
>  };
>  
>  struct stm32_ops {
> @@ -433,6 +434,8 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>  		}
>  	}
>  
> +	dwmac->phy_wol = of_property_read_bool(np, "st,phy-wol");
> +
>  	return err;
>  }
>  
> @@ -557,6 +560,8 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
>  	plat_dat->bsp_priv = dwmac;
>  	plat_dat->suspend = stm32_dwmac_suspend;
>  	plat_dat->resume = stm32_dwmac_resume;
> +	if (dwmac->phy_wol)
> +		plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;

I would much rather we found a different approach, rather than adding
custom per-driver DT properties to figure this out.

Andrew has previously suggested that MAC drivers should ask the PHY
whether WoL is supported, but this pre-supposes that PHY drivers are
coded correctly to only report WoL capabilities if they are really
capable of waking the system. As shown in your smsc PHY driver patch,
this may not be the case.

Given that we have historically had PHY drivers reporting WoL
capabilities without being able to wake the system, we can't
implement Andrew's suggestion easily.

The only approach I can think that would allow us to transition is
to add:

static inline bool phy_can_wakeup(struct phy_device *phy_dev)
{
	return device_can_wakeup(&phy_dev->mdio.dev);
}

to include/linux/phy.h, and a corresponding wrapper for phylink.
This can then be used to determine whether to attempt to use PHY-based
Wol in stmmac_get_wol() and rtl8211f_set_wol(), falling back to
PMT-based WoL if supported at the MAC.

So, maybe something like:

static u32 stmmac_wol_support(struct stmmac_priv *priv)
{
	u32 support = 0;

	if (priv->plat->pmt && device_can_wakeup(priv->device)) {
		support = WAKE_UCAST;
		if (priv->hw_cap_support && priv->dma_cap.pmt_magic_frame)
			support |= WAKE_MAGIC;
	}

	return support;
}

static void stmmac_get_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
{
	struct stmmac_priv *priv = netdev_priv(dev);
	int err;

	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
	if (phylink_can_wakeup(priv->phylink) ||
	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
		err = phylink_ethtool_get_wol(priv->phylink, wol);
		if (err != 0 && err != -EOPNOTSUPP)
			return;
	}

	wol->supported |= stmmac_wol_support(priv);

	/* A read of priv->wolopts is single-copy atomic. Locking
	 * doesn't add any benefit.
	 */
	wol->wolopts |= priv->wolopts;
}

static int stmmac_set_wol(struct net_device *dev, struct ethtool_wolinfo *wol)
{
	struct stmmac_priv *priv = netdev_priv(dev);
	u32 support, wolopts;
	int err;

	wolopts = wol->wolopts;

	/* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
	if (phylink_can_wakeup(priv->phylink) ||
	    priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
		struct ethtool_wolinfo w;

		err = phylink_ethtool_set_wol(priv->phylink, wol);
		if (err != -EOPNOTSUPP)
			return err;

		/* Remove the WoL modes that the PHY is handling */
		if (!phylink_ethtool_get_wol(priv->phylink, &w))
			wolopts &= ~w.wolopts;
	}

	support = stmmac_wol_support(priv);

	mutex_lock(&priv->lock);
	priv->wolopts = wolopts & support;
	device_set_wakeup_enable(priv->device, !!priv->wolopts);
	mutex_unlock(&priv->lock);

	return 0;
}

... and now I'm wondering whether this complexity is something that
phylink should handle internally, presenting a mac_set_wol() method
to configure the MAC-side WoL settings. What makes it difficult to
just move into phylink is the STMMAC_FLAG_USE_PHY_WOL flag, but
that could be a "force_phy_wol" flag in struct phylink_config as
a transitionary measure... so long as PHY drivers get fixed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

