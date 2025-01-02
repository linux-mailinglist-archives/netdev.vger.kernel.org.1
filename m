Return-Path: <netdev+bounces-154844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D867A000FE
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25C9160992
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C013019048F;
	Thu,  2 Jan 2025 22:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qyy2Ezke"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11DD13CF82
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735855374; cv=none; b=HMuyHQOtGlGc6WVlby5e/THSJXCPzMGJRjakORRnLCdeb8qHDEieXmB3DcppP84DGxG58B1iL1wK39okkS+4MOCaFEmI1EZbDjAqKwy/pLBgfzIzesiKdlNm/kQQiqbn3xsS6m6BLKB47FGZk33o3T1tXx2+jt2AK+whQIM01ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735855374; c=relaxed/simple;
	bh=SmDWOWTF4hdBe8hr4Ra9W/oom3mIAnmvG02pf9hOiJg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEfFKO9XVx00JbcnGvq0E5o5OEKc8BAdb0QNv5ByIJrDO5jECF1PbwfqWihcRAr8N6GFHLIdAy3AuIhGngMXsj22OQWFEq8ogQ+ixyINyyw7aAt3WbcZEwwCg8CZDmsXT5wQgXvlkyMF59PJq38aneybAF3MJIH6OSXYwN2M4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qyy2Ezke; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=flhDoTWszixGfZPN6AOG1Kbft1s/lql3hbGGxPrleY8=; b=Qyy2EzkeztfaArvMkfHife79Ug
	9mQxwcT2GZuEs9PnDjVTD4WeTUQJCrRpPLvtvgYR19N+827e2vvXLvaLiV4etpXf/AYhSeE6bb/oz
	YSQP7e3uiC9+62RHteTzoLkBq3S6NeeTMku8Fgxbg0C+6XwfGUMQWC6PMmiw1P74J4G+Y9/PhTLrT
	oA73aILo0VoMwypPccrltiS0J4qmszRBCr2wYbir7YCiU6FU8gqkmlRB2lgGzMEt3Rj7htCV/Iz43
	hei0v+MieMRXrRU/BJ7k7yqTpbCyHqos1rQ6+yAK3luur6S1DaFLurb0G/SdPh0CsB+r0Knuglo8X
	nAJ3p0bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49174)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tTTH5-0002Qh-0q;
	Thu, 02 Jan 2025 22:02:39 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tTTH1-0000e4-0k;
	Thu, 02 Jan 2025 22:02:35 +0000
Date: Thu, 2 Jan 2025 22:02:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/7] net: stmmac: move tx_lpi_timer tracking to
 phylib
Message-ID: <Z3cM-5tShVza0M58@shell.armlinux.org.uk>
References: <Z1r3MWZOt36SgGxf@shell.armlinux.org.uk>
 <E1tLkSX-006qfS-Rx@rmk-PC.armlinux.org.uk>
 <Z1wTqh-BnvPYLqU8@shell.armlinux.org.uk>
 <Z1yTviYUZ8sbNOsK@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1yTviYUZ8sbNOsK@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 13, 2024 at 08:06:22PM +0000, Russell King (Oracle) wrote:
> On Fri, Dec 13, 2024 at 10:59:54AM +0000, Russell King (Oracle) wrote:
> > On Thu, Dec 12, 2024 at 02:46:33PM +0000, Russell King (Oracle) wrote:
> > > @@ -1092,6 +1092,7 @@ static void stmmac_mac_link_up(struct phylink_config *config,
> > >  			phy_init_eee(phy, !(priv->plat->flags &
> > >  				STMMAC_FLAG_RX_CLK_RUNS_IN_LPI)) >= 0;
> > >  		priv->eee_enabled = stmmac_eee_init(priv);
> > > +		priv->tx_lpi_timer = phy->eee_cfg.tx_lpi_timer;
> > >  		priv->tx_lpi_enabled = priv->eee_enabled;
> > >  		stmmac_set_eee_pls(priv, priv->hw, true);
> > >  	}
> > 
> > While looking deeper at stmmac, there's a bug in the above hunk -
> > stmmac_eee_init() makes use of priv->tx_lpi_timer, so this member
> > needs to be set before calling this function. I'll post a v2 shortly.
> 
> I'm going to hold off v2, there's a lot more that can be cleaned up
> here - the EEE code is rather horrid in stmmac, and there's definitely
> one race, and one logical error in it (e.g. why mark software EEE mode
> *enabled* when EEE mode is being disabled - which can lead to the EEE
> timer being added back onto the timer list.)
> 
> There's also weirdness with dwmac4's EEE register fiddling.
> 
> The stmmac driver uses hardware timed LPI entry if the timer is small
> enough to be programmed into hardware, otherwise it uses software mode.
> 
> When software mode wants to enter LPI mode, it sets both:
> 
> 	GMAC4_LPI_CTRL_STATUS_LPIEN (LPI enable)
> 	GMAC4_LPI_CTRL_STATUS_LPITXA (LPI TX Automate)
> 
> When software mode wants to exit LPI mode, it clears both of these
> two bits.
> 
> In hardware mode, when enabling LPI generation, we set the hardware LPI
> entry timer (separate register) to a non-zero value, and then set:
> 
> 	GMAC4_LPI_CTRL_STATUS_LPIEN (LPI enable)
> 	GMAC4_LPI_CTRL_STATUS_LPITXA (LPI TX Automate)
> 	GMAC4_LPI_CTRL_STATUS_LPIATE (LPI Timer enable)
> 
> That seems logical. However, in hardware mode, when we want to then
> disable hardware LPI generation, we set the hardware LPI entry timer to
> zero, the following bits:
> 
> 	GMAC4_LPI_CTRL_STATUS_LPIEN (LPI enable)
> 	GMAC4_LPI_CTRL_STATUS_LPITXA (LPI TX Automate)
> 
> and clear:
> 
> 	GMAC4_LPI_CTRL_STATUS_LPIATE (LPI Timer enable)
> 
> So, hardware mode, disabled, ends up setting the same bits as
> software mode wanting to generate LPI state on the transmit side.
> This makes no sense to me, and looks like another bug in this driver.

I've found a document that describes the GMAC:

https://www.st.com/resource/en/reference_manual/rm0441-stm32mp151-advanced-armbased-32bit-mpus-stmicroelectronics.pdf

Page 3302 gives the definitions for the ETH_MACLCSR, which is this
register.

LPITE (bit 20) - allows the ETH_MACLETR register to define how long to
wait before the TX path enters LPI. Requires LPITXA and LPIEN to both
be set. LPIEN is *not* automatically cleared when the TX path exits
LPI.

LPITXA (bit 19) - if this and LPIEN are set, then LPI is entered once
all outstanding packets have been transmitted, and exits when there's
a packet to be transmitted or the Tx FIFO is flushed. When it exits,
it clears the LPIEN bit (making this a one-shot LPI enter-exit.)

PLS (bit 17) needs to be programmed to reflect the PHY link status,
and is used to hold off LPI state for the LS timer.

LPIEN (bit 16) instructs the MAC to enter (when set) or exit (when
cleared) LPI state. It doesn't say what the behaviour of this bit is
if LPITXA is clear.

So:

LPIEN	LPITXA	LPITE	Effect
0	x	x	No LPI, or LPI exited if active
1	0	0	Undocumented
1	1	0	Tx LPI entered if PLS has been set for the LS
			timer, and once all packets have been sent.
			LPIEN clears when Tx LPI exits.
1	1	1	Tx LPI entered if PLS has been set for the LS
			timer, and transmitter has been idle for
			ETH_MACLETR. Exits do not clear LPIEN, allowing
			for subsequent idle periods to enter LPI.

Therefore, given this description, I believe the code to be wrong.
In the case where we've set LPIEN=1 LPITXA=1 LPITE=1, and we want
to exit/disable LPI, we should not be clearing LPIATE and leaving
LPIEN and LPITXA as they were. According to my reading, this would
cause LPI to remain active until there is a packet to be sent or the
TX FIFO is flushed. At that point, Tx LPI will be exited, causing
LPIEN to be cleared - but the code is wanting to disable Tx LPI
(e.g. because the user configured through ethtool for LPI to be
disabled.)

The question is... does this get fixed? Is there anyone who can test
this (beyond the "patch doesn't seem to cause regressions" but can
actually confirm entry/exit from LPI state?)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

