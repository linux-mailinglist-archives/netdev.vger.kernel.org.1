Return-Path: <netdev+bounces-263937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6ER7ArRkqGl3uQAAu9opvQ
	(envelope-from <netdev+bounces-263937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:58:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B88C204BB2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E72FC3055D7E
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAFA374E59;
	Wed,  4 Mar 2026 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rn45a6g2"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A153368B4;
	Wed,  4 Mar 2026 16:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643345; cv=none; b=pOYPvXVEsIWRPJ9aU4VEWHc5WMU8IFuePvoa41QCYY8x85kJVtmAFHUtkubygP9hh3HGm9UCpNc1/xpBVdpyfM97d/oa5BEDwW2NSAwwEQ1bNSvwzCJ0A3K7iB1PclC6TgMnmuDVavFaa/ojWHUX8gquG+YVWuu6OBOWvA8adJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643345; c=relaxed/simple;
	bh=N2eRMLJG/1aJGLtXlcZXeM9woo2DUmQb+2c8tcrSe0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7dx5SEt3SdozgkUrVbGxOhd8tQcSUXgzq3L8vBFjWjl/v09HgMupfPbjKlBCOvGOi0pf94kZU4iOc970Yn9mv8YSlX+yi5KKZchqaELStSOtIhAizwtcCseRBFMMenpEAbHqNbFq79u/2EzXACODws8OIG50Cglbw86xIWLtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rn45a6g2; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q1OR1ny9KFs0cLcczZ9iJL56E6KTQVwen5EbKPngUTI=; b=rn45a6g23EaW5caqIzZj5OZ2Ly
	og7O38RJVXm4MlO2JKu5lghEzaQlpwSDnu07R5FwePeEnC5F/VTb8/PBDcNr71lMqVWNYqCP43qAB
	ZR+vhBECsTPUXr3Qd8uN1vz1I82qDYoAz3qtHJQo0U8xyTtJkGCKwiFcy5ERtkJWr0TB3n6Fw/lMp
	ue/RC/k0eC08s7w74Hr2f4kZjMLIE8df5FSJc/ZQ9Hjcv44SLU8rhvWOxYHi75+RTWuz2q4ReNoQC
	/FBQBM1+jrm01y2cgA7SMnuOOUCfb3nQYmBKvGTXLuX+wdBDh6VosUxfa/xvvAJR+cxEixEhfmhOM
	/iI55llQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38232)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vxpVc-000000006mT-18Hz;
	Wed, 04 Mar 2026 16:55:40 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vxpVa-0000000083l-0gZC;
	Wed, 04 Mar 2026 16:55:38 +0000
Date: Wed, 4 Mar 2026 16:55:37 +0000
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
Message-ID: <aahkCah1pvuNIy03@shell.armlinux.org.uk>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304-unvented-crinkle-37f0bfd03541@spud>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Queue-Id: 5B88C204BB2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263937-lists,netdev=lfdr.de];
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
	NEURAL_SPAM(0.00)[0.255];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,armlinux.org.uk:url]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> On Wed, Mar 04, 2026 at 06:59:35AM -0800, Charles Perry wrote:
> > On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> > > On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > > > Make it possible to connect a PHY which does not use inband
> > > > autoneg to a gem MAC using phylink's information.
> > > > 
> > > > The previous implementation relied on whether or not the link
> > > > was a fixed-link to disable SGMII autoneg. This commit extend
> > > > this to all link which are not configured for inband
> > > > autonegotiation.
> > > > 
> > > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > 
> > > This breaks the macb on mpfs-icicle-kit, I get stuck with:
> > > 
> > > [    7.189102] mpfs-sys-controller syscontroller: Registered MPFS system controller
> > > [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> > > [    7.273881] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> > > [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> > > [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> > > [    7.358082] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> > > [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> > > [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > > [   11.398403] Sending DHCP requests .
> > > [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> > > [   13.938425] ..... timed out!
> > > [   93.598491] macb 20110000.ethernet eth0: Link is Down
> > > [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock unregistered.
> > > [   93.659433] macb 20112000.ethernet eth1: Link is Down
> > > [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock unregistered.
> > > [   93.703977] IP-Config: Retrying forever (NFS root)...
> > > [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> > > [   93.770655] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> > > [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > > [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> > > [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> > > [   93.856769] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> > > [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> > > [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> > > 
> > 
> > Hello Conor,
> > 
> > I checked the driver for the VSC8662 and it doesn't have the
> > ->inband_caps() and ->config_inband() callbacks so Linux leaves whatever
> > the bootloader puts or uses the defaults. Looking at the datasheet, this
> > should be register 23 (Extended PHY Control Set 1) bit 13 (MAC interface
> > auto-negotiation)
> > 
> > My guess is that this bit is set and since this patch disable inband
> > autonegotiation (because phylink decides it), there is a mismatch.
> > 
> > Can you add 'managed = "in-band-status"' in your device tree under the macb
> > node? That's not necessarily the fix, I just want to confirm my theory.
> 
> No, it just produces a different error:
> [    5.769864] mpfs-sys-controller syscontroller: Registered MPFS system controller
> [    5.829146] macb 20110000.ethernet eth0: Could not attach PHY (-19)
> [    5.854232] IP-Config: Failed to open eth0
> [    5.897152] macb 20112000.ethernet eth1: Could not attach PHY (-19)
> [    5.921061] IP-Config: Failed to open eth1
> [    5.925592] IP-Config: No network devices available
> [    5.938800] clk: Disabling unused clocks
> [    5.944156] PM: genpd: Disabling unused power domains
> [    5.961029] check access for rdinit=/usr/sbin/init failed: -2, ignoring

-19 is -ENODEV (I wish everyone would use %pe so we get english
error messages rather than having to look up errno codes in the
header files.)

macb uses either phylink_of_phy_connect() or phylink_connect_phy().
I don't think phylink_connect_phy() would return -ENODEV, but
phylink_of_phy_connect() would - but I can't see that adding
'managed = "in-band-status";' to DT would cause that. The only
case I can see is that fwnode_phy_find_device() fails to find the
phydev, but there is a PHY node specified in DT, but that would
fail without in-band-status.

> > Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you can
> > recompile your kernel.
> 
> Setting this provided no further logs, seemingly.

It certainly would if you place it before the first #include - I
routinely build kernels with it set as such. The messages are produced
at debug level, so should appear via "dmesg". If you want to see them
on the console, you need to add "debug" to the kernel command line.

However, the in-band-status thing needs to be root-caused first.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

