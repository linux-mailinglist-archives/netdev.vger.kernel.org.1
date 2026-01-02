Return-Path: <netdev+bounces-246581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F17CEE93F
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 13:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 532C7301B4BC
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 12:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8E0242D62;
	Fri,  2 Jan 2026 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X0p/GDUq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B5822F772;
	Fri,  2 Jan 2026 12:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358037; cv=none; b=ggZ83NAif0B5y01Y6qCQaoWBmf9py2rCE7IWDIZFrH4wQlHRdqtCLGuHgVWIiHKE6hXhZZFoTMK+5dQunDNFvl+yXAJypyet+KVbKJlukVyqlZemgg8Fb64wm8sgQHyEQgrli3SOhyQYFMo7hdq6Wk4U7acatYzj+7AFywJx7qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358037; c=relaxed/simple;
	bh=uno3wOH3G4noie3vSL7ulQoofYXxYKHROaoxwpaI7Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJBOhgyaC8yyaFFVJO0ZvTBcYo/9pRoFuFI1RIFu0z8DEXePFaJO/YRIORY9sQ2MfeTZCnuy6v8uJwUzKbmFBUxYv0FFtppVmI+7YJkt/bzRkKS96a72yqY/ABvFFVMg78Saz/AJk4X3aEiCZ57YPTaXZnOIgH+Gdpja3TxrFh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X0p/GDUq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9zc9NYapZ80LDdmQx21geXmhwH0joxz27NiN/xVLzP8=; b=X0p/GDUqTJg+wYs3ka9JV38DXF
	m7/EXH4L3ARIKTvfUzzgWFbBF3O7NSebmT0W2pyy65g3YP7WybjNCb7PSW97+Zk9iFt6RsQKXVM2P
	HD/7WKpQUOBmIvploC6z1GCH25Jn42NTqXRq8W63Sl3gwOK3MxBsUGUWdzczHfvtS8Z+KIP+1vbq6
	afu0/sMU2Jg0Lmwig/AN77txqx0Jptt/FF7/Zn3Pa9iFZfNbUeDozP2IddGsFMxf7O+5vKL9Avx4P
	djn/iT4QXMrSS5K6V5hVxzdyZWtbYh8Pc0SB/H34ahTzsKK7OtwawrcaLFeEl4RipP47wV8xR7/uW
	hJKgBbHA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43418)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vbeYe-000000005z4-2sT5;
	Fri, 02 Jan 2026 12:47:08 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vbeYc-0000000053N-14g9;
	Fri, 02 Jan 2026 12:47:06 +0000
Date: Fri, 2 Jan 2026 12:47:06 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Josua Mayer <josua@solid-run.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next v2 1/2] net: phy: marvell: 88e1111: define
 gigabit features
Message-ID: <aVe-SlqC0DfGS6O5@shell.armlinux.org.uk>
References: <20260101-cisco-1g-sfp-phy-features-v2-0-47781d9e7747@solid-run.com>
 <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101-cisco-1g-sfp-phy-features-v2-1-47781d9e7747@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 01, 2026 at 06:05:38PM +0200, Josua Mayer wrote:
> When connecting RJ45 SFP modules to Linux an ethernet phy is expected -
> and probed on the i2c bus when possible. Once the PHY probed, phylib
> populates the supported link modes for the netdev based on bmsr
> register bits set at the time (see phy_device.c: phy_probe).
> 
> Marvell phy driver probe function only allocates memory, leaving actual
> configuration for config_init callback.
> This means the supported link modes of the netdev depend entirely on the
> power-on status of the phy bmsr register.
> 
> Certain Cisco SFP modules such as GLC-T and GLC-TE have invalid
> configuration at power-on: MII_M1111_HWCFG_MODE_COPPER_1000X_AN
> This means fiber with automatic negotiation to copper. As the module
> exhibits a physical RJ45 connector this configuration is wrong.

No, it isn't wrong.

There are modules that can be bought with different configurations.
Sourcephotonics did it with their modules. Some of their modules are
configured to power up as 1000BASE-X to 1000BASE-T. Other modules power
up as SGMII to BASE-T.

The reason is device compatibility - with switches that can only talk
1000BASE-X, you want a module that powers up in 1000BASE-X to
1000BASE-T mode, and the switch can only support gigabit modes. The PHY
onboard advertises on its media side only that support.

If the switch can talk SGMII, then obviously want a module that powers
up in SGMII mode.

In the kernel, when we detect a PHY on the SFP, we *always* use SGMII
mode, and one of the things that the Marvell driver does is program the
PHY to operate in SGMII mode. This means that, even if the module was
a variant that powers up in 1000BASE-X mode, it gets switched to SGMII
mode during PHY bringup.

> As a consequence after power-on the bmsr does not set bits for 10/100
> modes.
> 
> During config_init marvell phy driver identifies the correct intended
> MII_M1111_HWCFG_MODE_SGMII_NO_CLK which means sgmii with automatic
> negotiation to copper, and configures the phy accordingly.
> 
> At this point the bmsr register correctly indicates support for 10/100
> link modes - however the netedev supported modes bitmask is never
> updated.
> 
> Hence the netdev fails to negotiate or link-up at 10/100
> speeds, limiting to 1000 links only.
> 
> Explicitly define features for 88e1111 phy to ensure that all supported
> modes are available at runtime even when phy power-on configuration was
> invalid.

This is wrong. If the PHY remains in 1000BASE-X mode on the host side
for whatever reason, when it is very reasonable not to say that 10/100
is unsupported.

If the operational mode of the PHY is reconfigured at runtime, then I
think it would be reasonable to re-read the supported linkmodes.
However, I think this will cause issues for phylink, as currently it
wants to know the link modes that are supported so it can choose an
appropriate interface mode.

We currently have phydev->possible_interfaces which indicates the
interface modes that the PHY will switch between depending on the mode
it has been configured for (so after the operating mode of the PHY has
been established.)

I do have patches that add phydev->supported_interfaces which are
populated at probe time to inform phylink which host interface modes
that the PHY can be reconfigured between - and this overrides the
linkmode-derivation of that information - it basically becomes:

        phy_interface_and(interfaces, phy->supported_interfaces,
                          pl->config->supported_interfaces);
        interface = phylink_choose_sfp_interface(pl, interfaces);
        if (interface == PHY_INTERFACE_MODE_NA) {
                phylink_err(pl, "selection of interface for PHY failed\n");
                return -EINVAL;
        }

        phylink_dbg(pl, "copper SFP: chosen %s interface\n",
                    phy_modes(interface));

        ret = phylink_attach_phy(pl, phy, interface);

and phylink_attach_phy() will result in the PHY driver's config_init
being called, configuring the appropriate operating mode for the
PHY, which can then be used to update phydev->supported as appropriate.

phylink will then look at phydev->supported once the above has
completed when it will do so in phylink_bringup_phy().

Deriving the host side PHY interface mode from the link modes has
always been rather sketchy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

