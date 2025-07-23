Return-Path: <netdev+bounces-209285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEBEB0EE62
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69CC1967A8D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928B5283C9F;
	Wed, 23 Jul 2025 09:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WZh6BmN8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1963280A5E;
	Wed, 23 Jul 2025 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262749; cv=none; b=cO/LAWNHgERDe/EnISCeI4Mv6SH9sQ7RWJvccXQV3pB8UlwkE4rPdqOZCfMO1oNAn9oZ8RVlFIxbPqms1mQfNvwM8rhTVhliGrHceBQ54aDky8yF+4JBO6j34kI3L5yQE/KH2VfOF8X5bf6+MtkY2M4lV8c2SA+uDvVC1YJF+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262749; c=relaxed/simple;
	bh=bdpBf1Ooad8GWX62n2or+lrZpr6yzJguzf8dfMsDB4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPmf/40owTDHQsZTPRKXd0QvmoKfLIaL0HeizhMmeRiRvNckzvIrkixw2eINh1jCw14DPYvfw5nXAs8uzycWB7YBky6x97ctL+e8CbGPd0k8ngs9ybxdAXheApKuk/znQDeLimb6OYBjxlh3AGToIC514YPLarp8w6QdJMoO29o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WZh6BmN8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RQQNlB7I/R+hz0Pu8a7A7amzzOyNcSagtZOh2OuR264=; b=WZh6BmN8hQuSFxA834dDH6kvHr
	6SE3fOtagej8RVCHO+0bc9gYSxOLat7qdCtP1argbaypPp9KTTL48yPBCyeXWL7bufvDhgiiZzZW0
	QxUS9kXhOIh12/uAVF1hrtwrNqCGTvM3N4HLwhZYE+7kfRm6aksFTDzKT+NYOh9IVPzDaJrFoiuXi
	dyVtSMnykJmX4bX5BOATpSENv1AJYnlW6Vp5Fvjd+a8x5KZb1xrLcCEUw15jdcNLdfzuS+Ck+B41n
	wSNRlEqXRc4WNGFTlQv1iPhgoO8fgYiNTxZIuLOW+4kxj6a8nh0nN9/ES8MU3zEewbPqD6+19jcii
	o92g88QQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37166)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ueVjC-0001QJ-0A;
	Wed, 23 Jul 2025 10:25:34 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ueVj9-00082Q-34;
	Wed, 23 Jul 2025 10:25:31 +0100
Date: Wed, 23 Jul 2025 10:25:31 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski <krzk@kernel.org>,
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Tristram Ha <Tristram.Ha@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: document st,phy-wol
 property
Message-ID: <aICqi9eRi-vB1i1m@shell.armlinux.org.uk>
References: <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
 <5a2e0cd8-6d20-4f5a-a3a0-9010305509e3@foss.st.com>
 <9c9499e3-10c9-4245-938a-65831fe10c05@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9c9499e3-10c9-4245-938a-65831fe10c05@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 23, 2025 at 10:53:55AM +0200, Gatien CHEVALLIER wrote:
> On 7/23/25 10:50, Gatien CHEVALLIER wrote:
> > On 7/22/25 22:20, Russell King (Oracle) wrote:
> > > On Tue, Jul 22, 2025 at 03:40:16PM +0200, Andrew Lunn wrote:
> > > > I know Russell has also replied about issues with stmmac. Please
> > > > consider that when reading what i say... It might be not applicable.
> > > > 
> > > > > Seems like a fair and logical approach. It seems reasonable that the
> > > > > MAC driver relies on the get_wol() API to know what's supported.
> > > > > 
> > > > > The tricky thing for the PHY used in this patchset is to get this
> > > > > information:
> > > > > 
> > > > > Extract from the documentation of the LAN8742A PHY:
> > > > > "The WoL detection can be configured to assert the nINT interrupt pin
> > > > > or nPME pin"
> > > > 
> > > > https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt
> > > > 
> > > > It is a bit messy, but in the device tree, you could have:
> > > > 
> > > >      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>
> > > >                   <&pmic 42 IRQ_TYPE_LEVEL_LOW>;
> > > >      interrupt-names = "nINT", "wake";
> > > >      wakeup-source
> > > > 
> > > > You could also have:
> > > > 
> > > >      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>;
> > > >      interrupt-names = "wake";
> > > >      wakeup-source
> > > > 
> > > > In the first example, since there are two interrupts listed, it must
> > > > be using the nPME. For the second, since there is only one, it must be
> > > > using nINT.
> > > > 
> > > > Where this does not work so well is when you have a board which does
> > > > not have nINT wired, but does have nPME. The phylib core will see
> > > > there is an interrupt and request it, and disable polling. And then
> > > > nothing will work. We might be able to delay solving that until such a
> > > > board actually exists?
> > > 
> > > (Officially, I'm still on vacation...)
> > > 
> > > At this point, I'd like to kick off a discussion about PHY-based
> > > wakeup that is relevant to this thread.
> > > 
> > > The kernel has device-based wakeup support. We have:
> > > 
> > > - device_set_wakeup_capable(dev, flag) - indicates that the is
> > >    capable of waking the system depending on the flag.
> > > 
> > > - device_set_wakeup_enable(dev, flag) - indicates whether "dev"
> > >    has had wake-up enabled or disabled depending on the flag.
> > > 
> > > - dev*_pm_set_wake_irq(dev, irq) - indicates to the wake core that
> > >    the indicated IRQ is capable of waking the system, and the core
> > >    will handle enabling/disabling irq wake capabilities on the IRQ
> > >    as appropriate (dependent on device_set_wakeup_enable()). Other
> > >    functions are available for wakeup IRQs that are dedicated to
> > >    only waking up the system (e.g. the WOL_INT pin on AR8031).
> > > 
> > > Issue 1. In stmmac_init_phy(), we have this code:
> > > 
> > >          if (!priv->plat->pmt) {
> > >                  struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> > > 
> > >                  phylink_ethtool_get_wol(priv->phylink, &wol);
> > >                  device_set_wakeup_capable(priv->device,
> > > !!wol.supported);
> > >                  device_set_wakeup_enable(priv->device, !!wol.wolopts);
> > >          }
> > > 
> > > This reads the WoL state from the PHY (a different struct device)
> > > and sets the wakeup capability and enable state for the _stmmac_
> > > device accordingly, but in the case of PHY based WoL, it's the PHY
> > > doing the wakeup, not the MAC. So this seems wrong on the face of
> > > it.
> > 
> > 2 cents: Maybe even remove in stmmac_set_wol() if !priv->plat->pmt.
> > 
> 
> Sorry, that's not very clear. I was thinking of removing:
> device_set_wakeup_enable(priv->device, !!wol->wolopts); in
> stmmac_set_wol()

Yes, I think that's something which should be looked into, along with
the code at the bottom of stmmac_init_phy() calling
device_set_wakeup_capable() and device_set_wakeup_enable() depending on
the PHY state. However, that's something which needs testing by folk
who have stmmac setups that use PHY-side WoL.

It appears that my Jetson Xavier NX currently doesn't, although
MAC-side WoL also doesn't appear to work, so I've asked nVidia folk
for assistance. It could be it's supposed to use PHY-side, or maybe
there's something missing to support MAC-side (e.g. clk_rx_i is
being turned off in suspend despite WoL being enabled.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

