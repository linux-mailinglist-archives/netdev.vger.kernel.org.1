Return-Path: <netdev+bounces-264007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yG8DJFd+qGmYvAAAu9opvQ
	(envelope-from <netdev+bounces-264007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:47:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0912069E0
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70308306F991
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 18:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4013D75C0;
	Wed,  4 Mar 2026 18:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="hmODaLLp"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23403D6CCA;
	Wed,  4 Mar 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649588; cv=none; b=LGg3fRZePU0aONtQVhsO8qMV4BlUty/b3/EFnmy3qvUvpDXkW0IM8cj7REuN8m83+EqENcUvHQ/TMCgeZArMuFQpXwfVGBuDZDlpWPSpVC8AHWbNECB/6ruiUkHTaZ4J1Q44AAYeEUCk0BvuZaLKWZMo9Dm/2ZIjFwVgA5WmcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649588; c=relaxed/simple;
	bh=R7r/9iy9PxjsZGaaU7iSkUMDsbJHuTExsjp1rpTaprA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9SJCPLRiPfs5ZMlOFo7CAk7nwn+vC+8QzpLrjvANZJp18KcK5GwJK493uIPXKkv06PVLZmVb5SpUe5dBFhlyg2Uxv8XbHT3y7idhE7DpvGNaoKM8Maxt3toZWD8enjqn6XWGnmgFczZvdX+PvsMK3sWt5O9vWNr3fQL2gpsxc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=hmODaLLp; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AMYUahY70D+FCuhMzhH/aLIjs6OCUm1fA18v0olgLd0=; b=hmODaLLp/3k/9x4biYhWt3CYJs
	vLBQHTK6JgKC8MRZ/Zq2sZR+WLZWwFNeXYryo8eSYy0u26Il+gIG0Cqc/Z+tItY3YHGqBkurgOby9
	xO7UUz9EHPBUWVYeBeYvvDffH+1eCoWE46u8rACD/yRmXxq5W4mUJh3o6oacZprj+t8LbLD3ljXPP
	ARKWa70v5whdOKZ5l5UPqYZreqW9YPZ/PSRd8MKsFRbGAin03G27BXtfVhhiCQSFOYOZ4tnmdMQrc
	Xr3sWxU0zpu/eZRC9POVjxsUxI9A7XFRVbC+VoOjCb7HMGMZ4PQPnP7KInc059yGgiGAEj8aCcXi7
	AVn1iZnQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39472)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxr8H-000000006wA-3TWE;
	Wed, 04 Mar 2026 18:39:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxr8E-00000000888-1i5a;
	Wed, 04 Mar 2026 18:39:38 +0000
Date: Wed, 4 Mar 2026 18:39:38 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Conor Dooley <conor@kernel.org>
Cc: Charles Perry <charles.perry@microchip.com>, netdev@vger.kernel.org,
	Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <aah8akCJPTNkBrxs@shell.armlinux.org.uk>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aahkCah1pvuNIy03@shell.armlinux.org.uk>
 <20260304-mandarin-alumni-4b38a7743ee1@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-mandarin-alumni-4b38a7743ee1@spud>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 8C0912069E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264007-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_SPAM(0.00)[0.331];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shell.armlinux.org.uk:mid,0.0.0.8:email,armlinux.org.uk:url,0.0.0.9:email,microchip.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 06:06:20PM +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 04:55:37PM +0000, Russell King (Oracle) wrote:
> > On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > > On Wed, Mar 04, 2026 at 06:59:35AM -0800, Charles Perry wrote:
> > > > On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> > > > > On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > > > > > Make it possible to connect a PHY which does not use inband
> > > > > > autoneg to a gem MAC using phylink's information.
> > > > > > 
> > > > > > The previous implementation relied on whether or not the link
> > > > > > was a fixed-link to disable SGMII autoneg. This commit extend
> > > > > > this to all link which are not configured for inband
> > > > > > autonegotiation.
> > > > > > 
> > > > > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > > > 
> > > > > This breaks the macb on mpfs-icicle-kit, I get stuck with:
> > > > > 
> > > > > [    7.189102] mpfs-sys-controller syscontroller: Registered MPFS system controller
> > > > > [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> > > > > [    7.273881] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> > > > > [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> > > > > [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> > > > > [    7.358082] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> > > > > [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> > > > > [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > > > > [   11.398403] Sending DHCP requests .
> > > > > [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> > > > > [   13.938425] ..... timed out!
> > > > > [   93.598491] macb 20110000.ethernet eth0: Link is Down
> > > > > [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock unregistered.
> > > > > [   93.659433] macb 20112000.ethernet eth1: Link is Down
> > > > > [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock unregistered.
> > > > > [   93.703977] IP-Config: Retrying forever (NFS root)...
> > > > > [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> > > > > [   93.770655] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> > > > > [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > > > > [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> > > > > [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> > > > > [   93.856769] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> > > > > [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> > > > > [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> > > > > 
> > > > 
> > > > Hello Conor,
> > > > 
> > > > I checked the driver for the VSC8662 and it doesn't have the
> > > > ->inband_caps() and ->config_inband() callbacks so Linux leaves whatever
> > > > the bootloader puts or uses the defaults. Looking at the datasheet, this
> > > > should be register 23 (Extended PHY Control Set 1) bit 13 (MAC interface
> > > > auto-negotiation)
> > > > 
> > > > My guess is that this bit is set and since this patch disable inband
> > > > autonegotiation (because phylink decides it), there is a mismatch.
> > > > 
> > > > Can you add 'managed = "in-band-status"' in your device tree under the macb
> > > > node? That's not necessarily the fix, I just want to confirm my theory.
> > > 
> > > No, it just produces a different error:
> > > [    5.769864] mpfs-sys-controller syscontroller: Registered MPFS system controller
> > > [    5.829146] macb 20110000.ethernet eth0: Could not attach PHY (-19)
> > > [    5.854232] IP-Config: Failed to open eth0
> > > [    5.897152] macb 20112000.ethernet eth1: Could not attach PHY (-19)
> > > [    5.921061] IP-Config: Failed to open eth1
> > > [    5.925592] IP-Config: No network devices available
> > > [    5.938800] clk: Disabling unused clocks
> > > [    5.944156] PM: genpd: Disabling unused power domains
> > > [    5.961029] check access for rdinit=/usr/sbin/init failed: -2, ignoring
> > 
> > -19 is -ENODEV (I wish everyone would use %pe so we get english
> > error messages rather than having to look up errno codes in the
> > header files.)
> > 
> > macb uses either phylink_of_phy_connect() or phylink_connect_phy().
> > I don't think phylink_connect_phy() would return -ENODEV, but
> > phylink_of_phy_connect() would - but I can't see that adding
> > 'managed = "in-band-status";' to DT would cause that. The only
> > case I can see is that fwnode_phy_find_device() fails to find the
> > phydev, but there is a PHY node specified in DT, but that would
> > fail without in-band-status.
> 
> It's as you say, and fwnode_phy_find_device() is the source.
> fwnode_mdio_find_device() is what fails, returning NULL.

Ah, I've just found the reason:

        /* With fixed-link, we don't need to register the MDIO bus,
         * except if we have a child named "mdio" in the device tree.
         * In that case, some devices may be attached to the MACB's MDIO bus.
         */
        mdio_np = of_get_child_by_name(np, "mdio");
        if (!mdio_np && of_phy_is_fixed_link(np))
                return macb_mii_probe(bp->dev);

of_phy_is_fixed_link() will return true as soon as you add that managed
property, and as the mac1 node just lists the PHYs without using a
mdio child:

&mac1 {
        phy-mode = "sgmii";
        phy-handle = <&phy1>;
        status = "okay";

        phy1: ethernet-phy@9 {
                reg = <9>;
        };

        phy0: ethernet-phy@8 {
                reg = <8>;
        };
};

it means mdio_np is NULL above. Hence, no MDIO bus will be created.

> > > > Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you can
> > > > recompile your kernel.
> > > 
> > > Setting this provided no further logs, seemingly.
> > 
> > It certainly would if you place it before the first #include - I
> > routinely build kernels with it set as such. The messages are produced
> > at debug level, so should appear via "dmesg". If you want to see them
> > on the console, you need to add "debug" to the kernel command line.
> 
> Clearly I'm too stupid for this, because I did it again and still got no
> more logs. I even disabled DYNAMIC_DEBUG since that has an interaction
> in the file.

I'm sorry, I don't know what's going on there. As I say, it works for
me. E.g. from two days ago:

[  101.279224] mvneta f1034000.ethernet eno2: configuring for inband/2500base-x link mode
[  101.287194] mvneta f1034000.ethernet eno2: major config, requested inband/2500base-x
[  101.294986] mvneta f1034000.ethernet eno2: interface 2500base-x inband modes: pcs=02 phy=00
[  101.303423] mvneta f1034000.ethernet eno2: major config, active inband/inband,an-enabled/2500base-x
[  101.312541] mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/2500base-x/none adv=00000000,00000000,00008000,0000a240 pause=04
[  101.325123] mvneta f1034000.ethernet eno2: pcs link down
...
[  101.447124] mvneta f1034000.ethernet eno2: phylink_sfp_connect_phy()
[  101.453541] mvneta f1034000.ethernet eno2: copper SFP: interfaces=[mac=4,9-12,19,22-23, sfp=4,23,27]
[  101.462789] mvneta f1034000.ethernet eno2: copper SFP: chosen 2500base-x interface
[  101.470563] mvneta f1034000.ethernet eno2: PHY i2c:sfp:16 uses interfaces 4,23,27, validating 4,23
[  101.479636] mvneta f1034000.ethernet eno2:  interface 4 (sgmii) rate match none supports 2-3,5-6,13
[  101.488730] mvneta f1034000.ethernet eno2:  interface 23 (2500base-x) rate match none supports 6,13,47
[  101.498079] mvneta f1034000.ethernet eno2: PHY [i2c:sfp:16] driver [Broadcom BCM84881] (irq=POLL)
[  101.507043] mvneta f1034000.ethernet eno2: phy: 2500base-x setting supported 00000000,00000000,00008000,0000206c advertising 00000000,00000000,00008000,0000206c
[  101.522979] mvneta f1034000.ethernet eno2: major config, requested inband/2500base-x
[  101.530778] mvneta f1034000.ethernet eno2: interface 2500base-x inband modes: pcs=02 phy=01
[  101.539213] mvneta f1034000.ethernet eno2: 2500base-x: incompatible in-band capabilities, trying in-band
[  101.548732] mvneta f1034000.ethernet eno2: major config, active inband/inband,an-enabled/2500base-x
[  101.557842] mvneta f1034000.ethernet eno2: phylink_mac_config: mode=inband/2500base-x/none adv=00000000,00000000,00008000,0000206c pause=04
[  101.570425] mvneta f1034000.ethernet eno2: phylink_sfp_module_start()
[  101.576903] mvneta f1034000.ethernet eno2: phylink_sfp_link_up()
[  101.692254] mvneta f1034000.ethernet eno2: phy link down 2500base-x/Unknown/Unknown/none/off/nolpi

with the following at the top of phylink.c:

// SPDX-License-Identifier: GPL-2.0
/*
 * phylink models the MAC to optional PHY connection, supporting
 * technologies such as SFP cages where the PHY is hot-pluggable.
 *
 * Copyright (C) 2015 Russell King
 */
#define DEBUG
#include <linux/acpi.h>
...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

