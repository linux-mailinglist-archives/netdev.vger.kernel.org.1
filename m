Return-Path: <netdev+bounces-209128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12598B0E6C3
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BA2547F97
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAE02877DB;
	Tue, 22 Jul 2025 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0CThilS/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888424C92;
	Tue, 22 Jul 2025 22:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753225073; cv=none; b=kWBwpiMsvzTbdUWldtCnGecYw2OiEgYzn6gbiIUzxafZrZ3nMBzDqqf1JSsYsCLXUNsePny7kCWYR3fsuLhitbwFvld2Phf7pHgcwKD2kPr9bX0X2JLAKQqVoH6FCFRgK/OGmKU1Uj0nEhm8qsKMR3GdcV72xmK7OuvZuorMvMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753225073; c=relaxed/simple;
	bh=RwAWrB9T/X8gz/T7F17l0O3p5co+yiEzjRRueneN+mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNqFyoSY9Z2J+/oCfpbJApsLmJgpbRghXZzNq0HX9a41eYLH3f4tR0hyKY0WuMHe17FhmLNUoitey/c4n/XckkvwRJqOIPBccvJCWwbU3I/j/999l5sNEt9/XZf5EdUFMvrng3HFQct0FCreVtrp91l5/ajcKECXG5v09atKZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=0CThilS/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tRHxx3s63gK7fxd6KXoQFpMiOEIrFkGNGYZBp4mLO+c=; b=0CThilS/+BqK/91rcK4h50c2bc
	iKiHdcV/oxxVFXCQOlZfdykWHlojpCHpcX+ZRHEkP3JQCa6MzQpJFlWODnIodUgqERBaGcJdxNxQM
	Bca1tSskla9Nw82ZeI4rtooCIwZyjfGBFxjFX71GlaGSQg7vLk4Oydui8KxjkwH9DWJAu9bddX2L7
	wroMLAN0L8J5DJw+e1nPhljl/rznxVwG5m5SNITXGbkuCP2it7peKghtuvYyXuGXmPZ6+7P44r3P9
	nT36pM4YqwjYYNbsXaNjEyjYnKkTKA8XrJXdA7ix8BU/EWrBd578FUxx0ZYUm8wjvQHfrUe0Hcr5c
	e63ES15g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55460)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1ueLvP-0000kZ-2V;
	Tue, 22 Jul 2025 23:57:31 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1ueLvJ-0007WU-0l;
	Tue, 22 Jul 2025 23:57:25 +0100
Date: Tue, 22 Jul 2025 23:57:25 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
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
Message-ID: <aIAXVSIJqOa5PEOQ@shell.armlinux.org.uk>
References: <f5c4bb6d-4ff1-4dc1-9d27-3bb1e26437e3@foss.st.com>
 <e3c99bdb-649a-4652-9f34-19b902ba34c1@lunn.ch>
 <38278e2a-5a1b-4908-907e-7d45a08ea3b7@foss.st.com>
 <5b8608cb-1369-4638-9cda-1cf90412fc0f@lunn.ch>
 <383299bb-883c-43bf-a52a-64d7fda71064@foss.st.com>
 <2563a389-4e7c-4536-b956-476f98e24b37@lunn.ch>
 <aH_yiKJURZ80gFEv@shell.armlinux.org.uk>
 <ae31d10f-45cf-47c8-a717-bb27ba9b7fbe@lunn.ch>
 <aIAFKcJApcl5r7tL@shell.armlinux.org.uk>
 <aIAKAlkdB5S8UiYx@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIAKAlkdB5S8UiYx@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 22, 2025 at 11:00:34PM +0100, Russell King (Oracle) wrote:
> On Tue, Jul 22, 2025 at 10:39:53PM +0100, Russell King (Oracle) wrote:
> > rtl8211f_get_wol() does not take account of whether the PMEB pin is
> > wired or not. Thus, stmmac can't just forward the get_wol() and
> > set_wol() ops to the PHY driver and let it decide, as suggested
> > earlier. As stmmac gets used with multiple PHYs, (and hey, we can't
> > tell what they are, because DT doesn't list what the PHY actually is!)
> > we can't know how many other PHY drivers also have this problem.
> 
> I've just read a bit more of the RTL8211F datasheet, and looked at the
> code, and I'm now wondering whether WoL has even been tested with
> RTL8211F. What I'm about to state doesn't negate anything I've said
> in my previous reply.
> 
> 
> So, the RTL8211F doesn't have a separate PMEB pin. It has a pin that
> is shared between "interrupt" and "PMEB".
> 
> Register 22, page 0xd40, bit 5 determines whether this pin is used for
> PMEB (in which case it is pulsed on wake-up) or whether it is used as
> an interrupt. It's one or the other function, but can't be both.
> 
> rtl8211f_set_wol() manipulates this bit depending on whether
> WAKE_MAGIC is enabled or not.
> 
> The effect of this is...
> 
> If we're using PHY interrupts from the RTL8211F, and then userspace
> configures magic packet WoL on the PHY, then we reconfigure the
> interrupt pin to become a wakeup pin, disabling the interrupt
> function - we no longer receive interrupts from the RTL8211F !!!!!!!
> 
> Yes, the driver does support interrupts for this device!
> 
> This is surely wrong because it will break phylib's ability to track
> the link state as there will be no further interrupts _and_ phylib
> won't be expecting to poll the PHY.
> 
> The really funny thing is that the PHY does have the ability to
> raise an interrupt if a wakeup occurs through the interrupt pin
> (when configured as such) via register 18, page 0xa42, bit 7...
> but the driver doesn't touch that.
> 
> 
> Jetson Xavier NX uses interrupts from this PHY. Forwarding an
> ethtool .set_wol() op to the PHY driver which enables magic packet
> will, as things stand, switch the interrupt pin to wake-up only
> mode, preventing delivery of further link state change events to
> phylib, breaking phylib.
> 
> Maybe there's a need for this behaviour with which-ever network
> driver first used RTL8211F in the kernel. Maybe the set of network
> drivers that use interrupts from the RTL8211F don't use WoL and
> vice versa. If there's any network drivers that do forward WoL
> calls to the RTL8211F driver _and_ use interrupts from the PHY...
> that's just going to break if magic packet WoL is ever enabled at
> the PHY.

The only solutions I can think that may work with RTL8211F are:

Solution 1. move the control of RTL8211F_INTBCR_INTB_PMEB to a new
  rtl8211f_suspend() / rtl8211f_resume(), and switch the pin between
  interrupt mode and PMEB mode accordingly if WoL is enabled. This
  should be relatively low-risk, and not require DT changes.

Solution 2. don't switch to PMEB mode if phylib is using interrupts.
  Instead, enable WoL interrupt when in INTB mode. Also needs
  rtl8211f_handle_interrupt() modified to "handle" the interrupt
  to prevent an interrupt storm. May cause other problems - PMEB
  is pulsed, WoL over INTB is level-based, so higher risk.

Solution 3. introduce a DT flag for rtl8211f PHYs to tell the PHY
  driver "this platform should enable WoL interrupts in INTB mode
  and not switch to PMEB mode". Safest, as no change in behaviour
  without the flag being present... but arguable whether it truly
  describes hardware. However, what we currently have in DT
  *doesn't* actually describe hardware because of the mistakes made.
  (Maybe we can use the wakeup-source property to indicate this
  mode, which may be more acceptable to Krzysztof than a whole new
  flag.)

Maybe something else would be acceptable to DT folk - I think I've
provided enough of a description of the problem we currently have
to allow DT folk to digest the issue here.

Just random thoughts below... here's the description of the PHY on
the Jetson Xavier NX which I'll use as a basis for some scenarios.
(from arch/arm64/boot/dts/nvidia/tegra194-p3668.dtsi).

	phy: ethernet-phy@0 {
		compatible = "ethernet-phy-ieee802.3-c22";
		reg = <0x0>;
		interrupt-parent = <&gpio>;
		interrupts = <TEGRA194_MAIN_GPIO(G, 4) IRQ_TYPE_LEVEL_LOW>;
		#phy-cells = <0>;
	};

If WoL is supported through interrupts, then maybe we describe it
as:

	phy: ethernet-phy@0 {
		compatible = "ethernet-phy-ieee802.3-c22";
		reg = <0x0>;
		interrupt-parent = <&gpio>;
		interrupts = <TEGRA194_MAIN_GPIO(G, 4) IRQ_TYPE_LEVEL_LOW>;
		#phy-cells = <0>;
		wakeup-source;
	};

WoL is supported through PMEB, no interrupt support, then it gets
described as:

	phy: ethernet-phy@0 {
		compatible = "ethernet-phy-ieee802.3-c22";
		reg = <0x0>;
		#phy-cells = <0>;
		wakeup-source;
	};

The problem becomes how to describe the _existing_ behaviour going
forward, which we get with the current (first) description above. We
would need to preserve this for the existing description for backward
compatibility to avoid breaking existing setups. Do we try to come up
with something different that allows wakeup-source to be added?
Should we say that shared-interrupt and PMEB mode isn't something we
support except for legacy stuff, and thus not care about the missing
wakeup-source property? Something else, if so what (please suggest) ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

