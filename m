Return-Path: <netdev+bounces-209283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE85B0EE43
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B5313ABEC9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ACA283C9F;
	Wed, 23 Jul 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dSO24jNl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B559A1E2834;
	Wed, 23 Jul 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262483; cv=none; b=XzOFg5l29e46Yk0GdEbyxFsQIa5aFep0my0/iVKndK1bFOGW//DJDiNU3erRW/p4Q7IZtHa+Y0ZucJgxF0aVXSZZYWWelTbmnrM78jvOWNewBUAC+GnEDgDUNkTbDVR3oflDjXll8vXeTpjjSF4vxqDyK8nBq0p5uRUOyDFThKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262483; c=relaxed/simple;
	bh=0uVFd6hQe+qkcXcnSvsb5DjTCK/2OUBtPQDZjpDrNJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGe59lhwYZ5BQo2mOZZC7iuCktLUcTb3Ijc5cWuvToVLDZQsRWK74kKCZhMmRSMMC/y9fwPvk1uH0ZMHR/BLU1d/6ERDshQV7VPA+xXXx5agMEjQ8k3G4uVw1wnbBlpoaB1ASlY9xp7s2A5PpQxff8sXCdUykDHo0+qPJ7lw7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dSO24jNl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jtyXDAbchD+ujNyFyIw8Kuiv1V26MM0ceC3YK26OqoU=; b=dSO24jNlgvoSlEHlcgr1p7E1SK
	hp8iXPeZ3QxgCVbnbEydNBjv4SqSleULWSLgbxmhJcsGmzBMLCbQGwOdaRKuXRRPltE1Olq+avDXr
	Uy11BYnClHrXefVKZ3L/cm5ftZifI5HJfI2zgDHfzgtGbke/hXqmI3R+VRhuuLvNddmv95DM/psJ7
	ctdDEMqZEyD77UWF089swc+Y0lMtI5CzmIhvikUIIEE5W0nZ7sAyi8JdB55xWe9Khm6ccv+jFi2ip
	6uLD9IBrEcPCFCOx86atSJue+A6XIE+X5at70NmtFx/JYZ1tqrvX3dxaDsrCJL0UpvKg4XPM78gxX
	RdPQs0SQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41512)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ueVeq-0001PX-0W;
	Wed, 23 Jul 2025 10:21:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ueVem-00082G-07;
	Wed, 23 Jul 2025 10:21:00 +0100
Date: Wed, 23 Jul 2025 10:20:59 +0100
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
Message-ID: <aICpe63iqldl9NFd@shell.armlinux.org.uk>
References: <20250721-wol-smsc-phy-v1-1-89d262812dba@foss.st.com>
 <faea23d5-9d5d-4fbb-9c6a-a7bc38c04866@kernel.org>
 <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
 <5a2e0cd8-6d20-4f5a-a3a0-9010305509e3@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a2e0cd8-6d20-4f5a-a3a0-9010305509e3@foss.st.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jul 23, 2025 at 10:50:12AM +0200, Gatien CHEVALLIER wrote:
> On 7/22/25 22:20, Russell King (Oracle) wrote:
> > On Tue, Jul 22, 2025 at 03:40:16PM +0200, Andrew Lunn wrote:
> > > I know Russell has also replied about issues with stmmac. Please
> > > consider that when reading what i say... It might be not applicable.
> > > 
> > > > Seems like a fair and logical approach. It seems reasonable that the
> > > > MAC driver relies on the get_wol() API to know what's supported.
> > > > 
> > > > The tricky thing for the PHY used in this patchset is to get this
> > > > information:
> > > > 
> > > > Extract from the documentation of the LAN8742A PHY:
> > > > "The WoL detection can be configured to assert the nINT interrupt pin
> > > > or nPME pin"
> > > 
> > > https://www.kernel.org/doc/Documentation/devicetree/bindings/power/wakeup-source.txt
> > > 
> > > It is a bit messy, but in the device tree, you could have:
> > > 
> > >      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>
> > >                   <&pmic 42 IRQ_TYPE_LEVEL_LOW>;
> > >      interrupt-names = "nINT", "wake";
> > >      wakeup-source
> > > 
> > > You could also have:
> > > 
> > >      interrupts = <&sirq 0 IRQ_TYPE_LEVEL_LOW>;
> > >      interrupt-names = "wake";
> > >      wakeup-source
> > > 
> > > In the first example, since there are two interrupts listed, it must
> > > be using the nPME. For the second, since there is only one, it must be
> > > using nINT.
> > > 
> > > Where this does not work so well is when you have a board which does
> > > not have nINT wired, but does have nPME. The phylib core will see
> > > there is an interrupt and request it, and disable polling. And then
> > > nothing will work. We might be able to delay solving that until such a
> > > board actually exists?
> > 
> > (Officially, I'm still on vacation...)
> > 
> > At this point, I'd like to kick off a discussion about PHY-based
> > wakeup that is relevant to this thread.
> > 
> > The kernel has device-based wakeup support. We have:
> > 
> > - device_set_wakeup_capable(dev, flag) - indicates that the is
> >    capable of waking the system depending on the flag.
> > 
> > - device_set_wakeup_enable(dev, flag) - indicates whether "dev"
> >    has had wake-up enabled or disabled depending on the flag.
> > 
> > - dev*_pm_set_wake_irq(dev, irq) - indicates to the wake core that
> >    the indicated IRQ is capable of waking the system, and the core
> >    will handle enabling/disabling irq wake capabilities on the IRQ
> >    as appropriate (dependent on device_set_wakeup_enable()). Other
> >    functions are available for wakeup IRQs that are dedicated to
> >    only waking up the system (e.g. the WOL_INT pin on AR8031).
> > 
> > Issue 1. In stmmac_init_phy(), we have this code:
> > 
> >          if (!priv->plat->pmt) {
> >                  struct ethtool_wolinfo wol = { .cmd = ETHTOOL_GWOL };
> > 
> >                  phylink_ethtool_get_wol(priv->phylink, &wol);
> >                  device_set_wakeup_capable(priv->device, !!wol.supported);
> >                  device_set_wakeup_enable(priv->device, !!wol.wolopts);
> >          }
> > 
> > This reads the WoL state from the PHY (a different struct device)
> > and sets the wakeup capability and enable state for the _stmmac_
> > device accordingly, but in the case of PHY based WoL, it's the PHY
> > doing the wakeup, not the MAC. So this seems wrong on the face of
> > it.
> 
> 2 cents: Maybe even remove in stmmac_set_wol() if !priv->plat->pmt.

On the face of it, that seems like a sane solution, but sadly we
can't do that. If we did, then at least Jetson Xavier NX would break if
WoL were enabled, because DT describes the PHY interrupt, and currently
the PHY driver switches the interrupt pin from interrupt mode (where it
signals link changes) to PMEB mode (where it only pulses when a wake-up
packet is received) when WoL is enabled at the PHY. This will mean
phylib won't receive link state interrupts anymore, so unplugging/
replugging the cable won't be detected by phylib.

Even my further suggestions do not get us to a state where we can pass
the set_wol() to the PHY, and then work out what the MAC needs to do,
because e.g. in the case of RTL8211F, even if we use the "wakeup-source"
to fix the above, we still have the problem of "is wake-up supported
by the PHY wiring or is it not". We just have not described that in the
DT trees for platforms, so this is basically unknown.

Adding any logic to the kernel to make that decision will cause
regressions - either by making WoL unavailable on platforms where it
previously worked (e.g. because PHY WoL was being used) or the opposite
(where MAC WoL was used but now PHY WoL gets used but isn't wired.)

This is why I say we've boxed ourselves into a corner on this - this is
not phylib maintainers fault, because we can't know everything about
every device out there, and we don't have time to read every damn data
sheet which may or may not be publically available. We have to go by
what submitters provide us, which leads to problems like this.

So, we need flexibility from everyone to try and find a way forward.
We can't have people sticking to ideals - such as DT maintainers being
rigid about "DT describes hardware only". As I've already stated, our
DT currently does *not* describe hardware with respect to PHY wake-up,
and because this has been overlooked, we're now in a mess where there
is *no* easy solutions, and no solution that could be said to purely
describe hardware.

If we didn't have any PHY drivers, and were starting afresh, then we
would have the latitude to come up with something clean. That boat has
long since sailed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

