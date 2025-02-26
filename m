Return-Path: <netdev+bounces-169771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23310A45A6F
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1273F16CBAB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7793620CCEA;
	Wed, 26 Feb 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UqutqlGJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B54C226D0D
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562813; cv=none; b=IjT4a4SCrvh842mKj3wRQWRx6ESFjLC0+Ab+wURXt3vVn3AYaX8wxhPkDRDWpeQuvONJJEyRp9WzvAcFlCBWxRmjFB+mrrMlzxWWiyMWQqYNCY8e0YjMWN1KVHNu8ogN7hpmxWY2VRTQEpwK6gU+EJi3SDv8IDYSeiEr2hzZ0VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562813; c=relaxed/simple;
	bh=oXYrs8fLkSqwtRneRydxS1WiAhpp9hDEK2JtL3e2Wtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlgaKnh1H5f3XmfLvT5gESEtlpxEswIzsQFHTzDGKqJY728GB95jBOjDrCIVJNwf0k137ZzgLLFcfCBErBzu1p2rnYt1P9a7HrEJirFFFimH34MFf+pSspi1vM6plNPa448ZbY4fY8ddnj7Od6G9vJ8s2hdMKQCmgmlSuoVy0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UqutqlGJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=83zqbI+x0U8gPtjXear3SquLiO46uugWTwSYAMtbREo=; b=UqutqlGJIvxUsGizH3OmMYEY79
	1gUkhNTP6dnsG+xmSD9xemC1LTrj5vJtrHPQFCOEf8uykUCEgktMB9PRlBrgw8V9Plwa/r1N1Yhkn
	tjB0bufEAycPO1r/FWfGxiEYGaWv8s0UhFkIlcCnfKsx7N08rKykXCsy0XjPqmxabduh/ypagv8JV
	OJIuldAhllwqQGTb9TEsS/afmerYWy8+wPNqeO41sSu35L7UDEkVI8aawV/LmZftEmEtNxAm78bn5
	olE6xbjjH8MHE2Vd1QBQp0bBVc/zGk2/FIviY8wWn6fzq90d4x5BM/Aq02WkJWFN87+xpfIhfuf21
	dL2zjjyw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45812)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tnDtL-0003mS-2I;
	Wed, 26 Feb 2025 09:39:49 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tnDt8-0006xF-1k;
	Wed, 26 Feb 2025 09:39:34 +0000
Date: Wed, 26 Feb 2025 09:39:34 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Furong Xu <0x1207@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Inochi Amaoto <inochiama@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jan Petrous <jan.petrous@oss.nxp.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Minda Chen <minda.chen@starfivetech.com>, netdev@vger.kernel.org,
	NXP S32 Linux Team <s32@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Thierry Reding <treding@nvidia.com>, hailong.fan@siengine.com,
	2694439648@qq.com
Subject: Re: net: stmmac: weirdness in stmmac_hw_setup()
Message-ID: <Z77hVrC5Lcbxrlx8@shell.armlinux.org.uk>
References: <Z7dVp7_InAHe0q_y@shell.armlinux.org.uk>
 <20250226104326.0000766e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226104326.0000766e@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Feb 26, 2025 at 10:43:26AM +0800, Furong Xu wrote:
> On Thu, 20 Feb 2025 16:17:43 +0000, "Russell King (Oracle)" wrote:
> 
> > While looking through the stmmac driver, I've come across some
> > weirdness in stmmac_hw_setup() which looks completely barmy to me.
> > 
> > It seems that it follows the initialisation suggested by Synopsys
> > (as best I can determine from the iMX8MP documentation), even going
> > as far as to *enable* transmit and receive *before* the network
> > device has been administratively brought up. stmmac_hw_setup() does
> > this:
> > 
> >         /* Enable the MAC Rx/Tx */
> >         stmmac_mac_set(priv, priv->ioaddr, true);
> > 
> > which sets the TE and RE bits in the MAC configuration register.
> > 
> > This means that if the network link is active, packets will start
> > to be received and will be placed into the receive descriptors.
> > 
> > We won't transmit anything because we won't be placing packets in
> > the transmit descriptors to be transmitted.
> > 
> > However, this in stmmac_hw_setup() is just wrong. Can it be deleted
> > as per the below?
> > Tested-by: Thierry Reding <treding@nvidia.com>
> > 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index c2913f003fe6..d6e492f523f5 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -3493,9 +3493,6 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
> >  		priv->hw->rx_csum = 0;
> >  	}
> >  
> > -	/* Enable the MAC Rx/Tx */
> > -	stmmac_mac_set(priv, priv->ioaddr, true);
> > -
> >  	/* Set the HW DMA mode and the COE */
> >  	stmmac_dma_operation_mode(priv);
> >  
> 
> A better fix here:
> https://lore.kernel.org/all/tencent_CCC29C4F562F2DEFE48289DB52F4D91BDE05@qq.com/

I don't think that addresses the issue I highlighted above, since it's
still calling stmmac_mac_set(, true) in stmmac_hw_setup(), which I
believe to be wrong (as per my explanation above.)

However, the removal of setting GMAC_CONFIG_TE in the start_tx method
looks correct to me, because:

- the start_tx method is called via stmmac_start_tx(), which is only
  called from stmmac_start_tx_dma().

- stmmac_start_tx_dma() is called from:
  * stmmac_start_all_dma()
  * stmmac_tx_err()
  * stmmac_enable_tx_queue()

* stmmac_start_all_dma() is called from the end of stmmac_hw_setup(),
  but we've already called stmmac_mac_set(, true) both before and
  after the patch in the above URL, so is redundant.

  Incidentally, this brings the same set of questions I've stated in
  my initial email, and to me this is wrong.

* stmmac_tx_err() can only happen when we are already active (so
  transmission was already enabled).

* stmmac_enable_tx_queue() is called from stmmac_xdp_enable_pool(),
  which will only call this if netif_running() returns true,
  implying that the netdev is already adminstratively brought up
  and thus stmmac_hw_setup() will have been called.

  Again, this brings the same set of questions I've stated in my
  initial email, and to me this is wrong.


While looking at Simon's comment, he talks about stmmac_xdp_open(), so
I just looked at that, and found:

        netif_carrier_on(dev);

Then there's:

        netif_carrier_off(dev);

in stmmac_xdp_release().

These were introduced in commit ac746c8520d9 ("net: stmmac: enhance XDP
ZC driver level switching performance"), well after stmmac had been
converted to phylink. Phylink documents this:

16. Verify that the driver does not call::

        netif_carrier_on()
        netif_carrier_off()

    as these will interfere with phylink's tracking of the link state,
    and cause phylink to omit calls via the :c:func:`mac_link_up` and
    :c:func:`mac_link_down` methods.

So, the presence of these calls will mess up phylink, resulting in
mac_link_up() and/or mac_link_down() *NOT* being called at appropriate
times.

However, stmmac_xdp_(open|release)() doesn't seem to do anything to
bring the PHY or PCS up/down. This makes me wonder whether XDP support
in the stmmac driver is basically broken, or maybe the netdev needs to
already be administratively up (ip li set dev ... up). I don't know
XDP as I've never used it. If that is the case, then those
netif_carrier_*() calls need removing. Or - I say again - stmmac needs
to *stop* using phylink. It's one or the other. A network driver
either needs to use phylink properly or not use phylink *at* *all*.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

