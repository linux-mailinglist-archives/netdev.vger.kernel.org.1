Return-Path: <netdev+bounces-226944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38791BA6412
	for <lists+netdev@lfdr.de>; Sun, 28 Sep 2025 00:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D125217F512
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 22:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B7E23BD05;
	Sat, 27 Sep 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="x0ovdlib"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85385221FC8;
	Sat, 27 Sep 2025 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759011625; cv=none; b=OLsr95VasOAJ4dBjDSrSCX4jQ7GVGkLm3wG6zntUHYp2YLHNmrbTS4jDLg1K1QhoHeOzq/ofMO/EIZIueyY9yQYZ9ixzZHH2CUiPDZ3Q7eWg7bwWVOuZRZ0UUH9d8AsTy5vkhlmj1Uf5zuVNKZ9l01tH3Hidw6b7+K5uK5l5gIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759011625; c=relaxed/simple;
	bh=rDNww6zekboHYzKVp12Po2Aq94Q59QtQ17pLFONbLwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l56jaEl9XCFdqbon0EiFIzOYGdG5MfbxIRZwOSC0OyzADkPizT/riAzi0kCvkhKFlkwFZbYmXU8GGZTPEDv+2mQeOsIMsSIguTK2B1A44Xi8nipCCs93RQa4hKKyIbwvrjy7hOxu6vxMulODcFw83sbqKabvTQrg96yuM3sjFXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=x0ovdlib; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=odkFKXOldqDIOZCvIlWG0IgIw5UqgIFwVetK5lpN4Dw=; b=x0ovdlibqOHKSHeKlD7uS0K56J
	xByjvjIpch7SYKEdvHdp+mnQgJW6SPCHiYNlo3j9dOzwYDuiH+SrZj4GgL1VywFZXPPNiAIo3mSyz
	GxJ90CKYRL8G4GkJvRW/d2WN9oZT6hhcZ+S/4Gfaj36lECgpg8Qfcz9osJL0XM2aewwl88CxUFU9o
	0BoEAjxeLhPtJO8CIWDJWhqAWGHzzeyAWGRrVT0KTq/lePi68Y3kAHf38Dxa2IyH9aucqIjLs10bf
	AiQFU7HKDa7TI7k6kLerA7cctz4rnXEB3xlOfukdecEFvvFWnTxfjeIknBcXe5yjhmLuR+i4KUwsX
	kDsvxX0g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50452)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1v2dGj-000000004pK-1PIK;
	Sat, 27 Sep 2025 23:19:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1v2dGc-000000001yQ-3Z5o;
	Sat, 27 Sep 2025 23:19:46 +0100
Date: Sat, 27 Sep 2025 23:19:46 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Gatien Chevallier <gatien.chevallier@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Tristram Ha <Tristram.Ha@microchip.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/4] net: stmmac: stm32: add WoL from PHY
 support
Message-ID: <aNhjAhBQzNzNTzZr@shell.armlinux.org.uk>
References: <20250917-wol-smsc-phy-v2-0-105f5eb89b7f@foss.st.com>
 <20250917-wol-smsc-phy-v2-2-105f5eb89b7f@foss.st.com>
 <aMriVDAgZkL8DAdH@shell.armlinux.org.uk>
 <aNbUdweqsCKAKJKl@shell.armlinux.org.uk>
 <a318f055-059b-44a4-af28-2ffd80a779e6@broadcom.com>
 <34478e1c-b3ba-4da3-839a-4cec9ac5f51e@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34478e1c-b3ba-4da3-839a-4cec9ac5f51e@broadcom.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Sep 27, 2025 at 02:04:15PM -0700, Florian Fainelli wrote:
> 
> 
> On 9/26/2025 12:05 PM, Florian Fainelli wrote:
> > 
> > 
> > On 9/26/2025 10:59 AM, Russell King (Oracle) wrote:
> > > On Wed, Sep 17, 2025 at 05:31:16PM +0100, Russell King (Oracle) wrote:
> > > > On Wed, Sep 17, 2025 at 05:36:37PM +0200, Gatien Chevallier wrote:
> > > > > If the "st,phy-wol" property is present in the device tree node,
> > > > > set the STMMAC_FLAG_USE_PHY_WOL flag to use the WoL capability of
> > > > > the PHY.
> > > > > 
> > > > > Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
> > > > > ---
> > > > >   drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c | 5 +++++
> > > > >   1 file changed, 5 insertions(+)
> > > > > 
> > > > > diff --git
> > > > > a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/
> > > > > drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> > > > > index 77a04c4579c9dbae886a0b387f69610a932b7b9e..6f197789cc2e8018d6959158b795e4bca46869c5
> > > > > 100644
> > > > > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> > > > > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
> > > > > @@ -106,6 +106,7 @@ struct stm32_dwmac {
> > > > >       u32 speed;
> > > > >       const struct stm32_ops *ops;
> > > > >       struct device *dev;
> > > > > +    bool phy_wol;
> > > > >   };
> > > > >   struct stm32_ops {
> > > > > @@ -433,6 +434,8 @@ static int stm32_dwmac_parse_data(struct
> > > > > stm32_dwmac *dwmac,
> > > > >           }
> > > > >       }
> > > > > +    dwmac->phy_wol = of_property_read_bool(np, "st,phy-wol");
> > > > > +
> > > > >       return err;
> > > > >   }
> > > > > @@ -557,6 +560,8 @@ static int stm32_dwmac_probe(struct
> > > > > platform_device *pdev)
> > > > >       plat_dat->bsp_priv = dwmac;
> > > > >       plat_dat->suspend = stm32_dwmac_suspend;
> > > > >       plat_dat->resume = stm32_dwmac_resume;
> > > > > +    if (dwmac->phy_wol)
> > > > > +        plat_dat->flags |= STMMAC_FLAG_USE_PHY_WOL;
> > > > 
> > > > I would much rather we found a different approach, rather than adding
> > > > custom per-driver DT properties to figure this out.
> > > > 
> > > > Andrew has previously suggested that MAC drivers should ask the PHY
> > > > whether WoL is supported, but this pre-supposes that PHY drivers are
> > > > coded correctly to only report WoL capabilities if they are really
> > > > capable of waking the system. As shown in your smsc PHY driver patch,
> > > > this may not be the case.
> > > > 
> > > > Given that we have historically had PHY drivers reporting WoL
> > > > capabilities without being able to wake the system, we can't
> > > > implement Andrew's suggestion easily.
> > > > 
> > > > The only approach I can think that would allow us to transition is
> > > > to add:
> > > > 
> > > > static inline bool phy_can_wakeup(struct phy_device *phy_dev)
> > > > {
> > > >     return device_can_wakeup(&phy_dev->mdio.dev);
> > > > }
> > > > 
> > > > to include/linux/phy.h, and a corresponding wrapper for phylink.
> > > > This can then be used to determine whether to attempt to use PHY-based
> > > > Wol in stmmac_get_wol() and rtl8211f_set_wol(), falling back to
> > > > PMT-based WoL if supported at the MAC.
> > > > 
> > > > So, maybe something like:
> > > > 
> > > > static u32 stmmac_wol_support(struct stmmac_priv *priv)
> > > > {
> > > >     u32 support = 0;
> > > > 
> > > >     if (priv->plat->pmt && device_can_wakeup(priv->device)) {
> > > >         support = WAKE_UCAST;
> > > >         if (priv->hw_cap_support && priv->dma_cap.pmt_magic_frame)
> > > >             support |= WAKE_MAGIC;
> > > >     }
> > > > 
> > > >     return support;
> > > > }
> > > > 
> > > > static void stmmac_get_wol(struct net_device *dev, struct
> > > > ethtool_wolinfo *wol)
> > > > {
> > > >     struct stmmac_priv *priv = netdev_priv(dev);
> > > >     int err;
> > > > 
> > > >     /* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
> > > >     if (phylink_can_wakeup(priv->phylink) ||
> > > >         priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
> > > >         err = phylink_ethtool_get_wol(priv->phylink, wol);
> > > >         if (err != 0 && err != -EOPNOTSUPP)
> > > >             return;
> > > >     }
> > > > 
> > > >     wol->supported |= stmmac_wol_support(priv);
> > > > 
> > > >     /* A read of priv->wolopts is single-copy atomic. Locking
> > > >      * doesn't add any benefit.
> > > >      */
> > > >     wol->wolopts |= priv->wolopts;
> > > > }
> > > > 
> > > > static int stmmac_set_wol(struct net_device *dev, struct
> > > > ethtool_wolinfo *wol)
> > > > {
> > > >     struct stmmac_priv *priv = netdev_priv(dev);
> > > >     u32 support, wolopts;
> > > >     int err;
> > > > 
> > > >     wolopts = wol->wolopts;
> > > > 
> > > >     /* Check STMMAC_FLAG_USE_PHY_WOL for legacy */
> > > >     if (phylink_can_wakeup(priv->phylink) ||
> > > >         priv->plat->flags & STMMAC_FLAG_USE_PHY_WOL) {
> > > >         struct ethtool_wolinfo w;
> > > > 
> > > >         err = phylink_ethtool_set_wol(priv->phylink, wol);
> > > >         if (err != -EOPNOTSUPP)
> > > >             return err;
> > > > 
> > > >         /* Remove the WoL modes that the PHY is handling */
> > > >         if (!phylink_ethtool_get_wol(priv->phylink, &w))
> > > >             wolopts &= ~w.wolopts;
> > > >     }
> > > > 
> > > >     support = stmmac_wol_support(priv);
> > > > 
> > > >     mutex_lock(&priv->lock);
> > > >     priv->wolopts = wolopts & support;
> > > >     device_set_wakeup_enable(priv->device, !!priv->wolopts);
> > > >     mutex_unlock(&priv->lock);
> > > > 
> > > >     return 0;
> > > > }
> > > > 
> > > > ... and now I'm wondering whether this complexity is something that
> > > > phylink should handle internally, presenting a mac_set_wol() method
> > > > to configure the MAC-side WoL settings. What makes it difficult to
> > > > just move into phylink is the STMMAC_FLAG_USE_PHY_WOL flag, but
> > > > that could be a "force_phy_wol" flag in struct phylink_config as
> > > > a transitionary measure... so long as PHY drivers get fixed.
> > > 
> > > I came up with this as an experiment - I haven't tested it beyond
> > > running it through the compiler (didn't let it get to the link stage
> > > yet.) Haven't even done anything with it for stmmac yet.
> > > 
> > 
> > I like the direction this is going, we could probably take one step
> > further and extract the logic present in bcmgenet_wol.c and make those
> > helper functions for other drivers to get the overlay of PHY+MAC WoL
> > options/password consistent across all drivers. What do you think?
> 
> +		if (wolopts & WAKE_MAGIC)
> +			changed |= !!memcmp(wol->sopass, pl->wol_sopass,
> +					    sizeof(wol->sopass));
> 
> 
> Should not the hunk above be wolopts & WAKE_MAGICSECURE?

Yes, and there's a few other bits missing as well. The series has
progressed, and stmmac is converted and tested on my Jetson platform.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

