Return-Path: <netdev+bounces-154688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B73D9FF748
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 10:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FEBA188067D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 09:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0091993A3;
	Thu,  2 Jan 2025 09:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="L4pPXnCQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A5199938;
	Thu,  2 Jan 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735808938; cv=none; b=mHe2hJsLtd1qrUgaopoou5Xn93yENj5gJDSrIIhtaNp5VWsI1oKCpkRLa0qJdFDqYRWKbSuKmKDBOfy9gWI2VfeS14LY0ikFlXNTDeXX3BmlvL37zJpu82nlGY1MXHVpWL7esCXWD/QV0ZEYzwB9JoqeYfErZRWfAwMq9i4ZaK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735808938; c=relaxed/simple;
	bh=md0UAgdCit3t5nBhaHpl9cl7CWVXVeVXnf7Ky1+Ih08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXi6DYaam39kRrD6WbR2/IP4AXGqBnvjOGHy+vdgsBrPq0g7OSeZBCHHkkLiiV6a0hKziGN6si6BQZed9PCqV9hEzf6URcqCZnt5h/gF46F9j/oO6GORpXo/td2Yzn2ypxZEXimie4ch3Q2jB1Y0UcK6Ixz2746N7PUUH0vgI8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=L4pPXnCQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N2/lJMrShdKFF/LCN9VGIHz6yfGl2Ad/fJkiczIYxJk=; b=L4pPXnCQ9/MJcPrdVq87EETWV0
	YDKENkOXhbSxIPBk+Fja0LuH8yLVErcGMrtKbOeNwLJrx0Q1b1cVhgbCsdctxHwteht7k98Ox7cLK
	MoRfX66zRHw7bblH1gYjqVZYzwdvk0Gj4o/vArejDnQkzany+qP73vcTOikSRfaME3xbZR7kxP0pw
	soBjvplC+RcHJpTBAxSoixRJaUArYlSYFBFjx1INgvnf6nBptKYRysgz0dkMaqUF5tukvPeVtAAmL
	Enhth10wOgC4RkuAx5idJIPV/id+reUcAeYsNI709XYEVelZVerZKiQABcdZZ3Uw/GIpbH+lcf0Y8
	yT9odH4Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43370)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTHC9-0001nF-0g;
	Thu, 02 Jan 2025 09:08:45 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTHC5-00008P-0K;
	Thu, 02 Jan 2025 09:08:41 +0000
Date: Thu, 2 Jan 2025 09:08:40 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexis =?iso-8859-1?Q?Lothor=E9?= <alexis.lothore@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: stmmac: use PCS supported_interfaces
Message-ID: <Z3ZXmAIAHmYVbdbl@shell.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
 <E1tMBRQ-006vat-7F@rmk-PC.armlinux.org.uk>
 <20241217141912.34cdd5ae@fedora.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217141912.34cdd5ae@fedora.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 17, 2024 at 02:19:12PM +0100, Maxime Chevallier wrote:
> Hi Russell,
> 
> On Fri, 13 Dec 2024 19:35:12 +0000
> "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:
> 
> > Use the PCS' supported_interfaces member to build the MAC level
> > supported_interfaces bitmap.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index d45fd7a3acd5..0e45c4a48bb5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -1206,6 +1206,7 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
> >  	struct stmmac_mdio_bus_data *mdio_bus_data;
> >  	int mode = priv->plat->phy_interface;
> >  	struct fwnode_handle *fwnode;
> > +	struct phylink_pcs *pcs;
> >  	struct phylink *phylink;
> >  
> >  	priv->phylink_config.dev = &priv->dev->dev;
> > @@ -1227,8 +1228,14 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
> >  
> >  	/* If we have an xpcs, it defines which PHY interfaces are supported. */
> >  	if (priv->hw->xpcs)
> > -		xpcs_get_interfaces(priv->hw->xpcs,
> > -				    priv->phylink_config.supported_interfaces);
> > +		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);
> > +	else
> > +		pcs = priv->hw->phylink_pcs;
> > +
> > +	if (pcs)
> > +		phy_interface_or(priv->phylink_config.supported_interfaces,
> > +				 priv->phylink_config.supported_interfaces,
> > +				 pcs->supported_interfaces);
> >  
> >  	fwnode = priv->plat->port_node;
> >  	if (!fwnode)
> 
> I think that we could even make xpcs_get_interfaces a static
> non-exported function now :) But this can be done in a subsequent patch.

Yes, that can definitely be done. I already have a patch for this.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

