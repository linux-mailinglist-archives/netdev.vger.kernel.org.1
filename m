Return-Path: <netdev+bounces-30873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FBD78978D
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D529C28189F
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 14:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0436DDDD;
	Sat, 26 Aug 2023 14:52:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C0737A
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 14:52:15 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260ED92
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 07:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2/XFiRWbsHAztbiWsUZlx5MlU2MgZke2abs/3p9CZK0=; b=QjG4Go9OCC7TxDShCUFGAF/zK2
	GIzsaw2gEFaflqFM+3jnuXZ1K5IZ/jQ/C7vYg86wDWiWcpSouG2j2oDMn4dpjDRSQHKSgoDmrH6TL
	8ehl9Xa+ZZJQt0HBC0ivqh2htMi/kqYCJrRF06ZTVxVM0qMIRoCMxvzsAfJ7myttlO0aUsA0Quuwa
	aQsg57cyGb2dZs4yVGmOHCkxNWTiqJNyabMxiAOhkBitDx3CZnhGkakXr+TQ9WbTxvLt+dRtZuXV6
	eEO3n1a/2/cv+DlegEunqKdGGZ1WaL89ZxFN/lk4z8Rr3h1kLtXErLTUJZNK+Z3o4lddCELcYPzlE
	WpbtmYFg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58886)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qZudp-0006HZ-0F;
	Sat, 26 Aug 2023 15:51:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qZudl-0001Zm-B8; Sat, 26 Aug 2023 15:51:53 +0100
Date: Sat, 26 Aug 2023 15:51:53 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 08/10] net: stmmac: move xgmac specific phylink
 caps to dwxgmac2 core
Message-ID: <ZOoRiVZiAyf7pArp@shell.armlinux.org.uk>
References: <ZOddFH22PWmOmbT5@shell.armlinux.org.uk>
 <E1qZAXd-005pUP-JL@rmk-PC.armlinux.org.uk>
 <rpwsyyjdzeixx3f7o3pxeslyff7yc3fuutm436ygjggoyiwjcb@7s3skg627mid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rpwsyyjdzeixx3f7o3pxeslyff7yc3fuutm436ygjggoyiwjcb@7s3skg627mid>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 26, 2023 at 04:32:15PM +0300, Serge Semin wrote:
> On Thu, Aug 24, 2023 at 02:38:29PM +0100, Russell King (Oracle) wrote:
> > Move the xgmac specific phylink capabilities to the dwxgmac2 support
> > core.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 10 ++++++++++
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 10 ----------
> >  2 files changed, 10 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > index 34e1b0c3f346..f352be269deb 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> > @@ -47,6 +47,14 @@ static void dwxgmac2_core_init(struct mac_device_info *hw,
> >  	writel(XGMAC_INT_DEFAULT_EN, ioaddr + XGMAC_INT_EN);
> >  }
> >  
> > +static void xgmac_phylink_get_caps(struct stmmac_priv *priv)
> > +{
> > +	priv->phylink_config.mac_capabilities |= MAC_2500FD | MAC_5000FD |
> > +						 MAC_10000FD | MAC_25000FD |
> > +						 MAC_40000FD | MAC_50000FD |
> > +						 MAC_100000FD;
> > +}
> > +
> >  static void dwxgmac2_set_mac(void __iomem *ioaddr, bool enable)
> >  {
> >  	u32 tx = readl(ioaddr + XGMAC_TX_CONFIG);
> > @@ -1490,6 +1498,7 @@ static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
> >  
> >  const struct stmmac_ops dwxgmac210_ops = {
> >  	.core_init = dwxgmac2_core_init,
> 
> > +	.phylink_get_caps = xgmac_phylink_get_caps,
> 
> This doesn't look correct. DW XGMAC doesn't support 25/40/50/100Gbps
> speeds.

So the reason this got added is to keep the code compatible with how
things work today.

When priv->plat->has_xgmac is true, the old code in stmmac_phy_setup()
would enable speeds from 2.5G up to 100G, limiting them if
priv->plat->max_speed is set non-zero.

The table in hwif.c matches when:
	entry->gmac == priv->plat->has_gmac,
	entry->gmac4 == priv->plat->has_gmac4 and
	entry->xgmac == priv->plat->has_xgmac

The entries in the table which patch on has_xgmac = true contain the
following:

                .mac = &dwxgmac210_ops,
                .mac = &dwxlgmac2_ops,

Therefore, to keep things compatible, I've effectively moved this
initialisation into the new .phylink_get_caps method that is part of
those two ops, and since they have has_xgmac true, this means that
all these speeds need to be set.

We do this without regard to max_speed, which we apply separately,
after the .phylink_get_caps method has returned.

So, the code is functionally identical to what happens in the driver,
even if it is the case that xgmac210 doesn't actually support the
speeds. If those extra speeds that the hardware doesn't support were
present before, they're present after. If those extra speeds are
limited by the max_speed, then they will be similarly limited.

While it may look odd, since the specifications for Synopsys are all
behind closed doors, all I can do is transform the code - I can't
know that such-and-such a core doesn't actually support stuff. So
my only option is to keep the code bug-compatible.

I think all I've done here is make it glaringly obvious what the old
code is doing and you've spotted "but that isn't right!" - which is
actually a good thing!

Feel free to submit patches to correct the functionality as bugs in
the driver become more obvious!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

