Return-Path: <netdev+bounces-263954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MO5CAzVvqGkkugAAu9opvQ
	(envelope-from <netdev+bounces-263954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:43:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846A5205563
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4FF1E3003730
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5E43890F3;
	Wed,  4 Mar 2026 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="kr93UXMK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC3337CD50;
	Wed,  4 Mar 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645878; cv=none; b=LK687KLfL56B+8JLQ4QzQjWs1JPjN+J5NM0wyEoHdvbTwuG+BDmGt3KfJ4I1AGXJG+EDpFXQ089g/nnzzRU5uIkipM0B1LwadZZCBjL1Q2D3WR0n7OOaBGPzGddfnIbiGqqf6te9LSqzmt1MrELCNIu7yQ0+DI96XaS3ea9PvWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645878; c=relaxed/simple;
	bh=u0FL7n3o5OqNavd4ndHJcVM7ITc0E6s2IOEChl2PixE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1WEUHu+jYiu2v85RV8fF34z+bQ0Sqz6dlk6B9n69/AZguyo5efzZNxZRM1MM4IRZPQju3VgtiORURIcPYf9gkxv1PHBVWHZhMDlteJicylNknelNol6csKqNXaZSAsOFJ8C1rls11Xsl1R7pfUpJDhxklYU89j/YtfRsimSDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=kr93UXMK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772645876; x=1804181876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u0FL7n3o5OqNavd4ndHJcVM7ITc0E6s2IOEChl2PixE=;
  b=kr93UXMKNs5Guutxi8SfVw98ctD6ju5OTSQWMc26ZkehjZF1HqEJVKP7
   RUenA2ie99vIf32di2JY/KKHChWUewSnGHKAg4ztGkPBN7rdsrXgpgZmx
   a3RpCw486MhKCOq+5brNAOMO7ibAYmMl34B/l4X5A5+oABs9zWkABNzV7
   6OgTxwO7z1DqIqrEhC4NHacicWYDzIoTYbcb1d5nHbfWUA19G6jxQYb/W
   YY0BUymsZnnri3PtVYR2rcGH2LAALmzJFlDMch1pDbUX4XRCOrlEoJvPy
   Ea1wAWKXPuoj7zF8gf5XzTugjMSB0ItcXE7qsCYRvhqRct7ZM8DEpP83I
   g==;
X-CSE-ConnectionGUID: SHXOS1CLR9CzaeSnJnbHlA==
X-CSE-MsgGUID: VXuQEQMITaO7HRdDdsHnjg==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="54654667"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 10:37:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 10:37:25 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 10:37:25 -0700
Date: Wed, 4 Mar 2026 09:37:23 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <netdev@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <aaht0/XpUCz+58bz@bby-cbu-swbuild03.eng.microchip.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260304-unvented-crinkle-37f0bfd03541@spud>
X-Rspamd-Queue-Id: 846A5205563
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263954-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bby-cbu-swbuild03.eng.microchip.com:mid]
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
> 
> > Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you can
> > recompile your kernel.
> 
> Setting this provided no further logs, seemingly.
> 
> Adding some basic prints shows that the driver changed the state of the
> PCSCNTRL register from 0x1040 to 0x40, so it disabled auto neg. The
> driver previously left it as it was, 0x1040 before and 0x1040 after.
> 

Thank you for this info.

Are you able to check register 23, bit 13 of your PHY by any chance? Maybe
with the mdio/mii commands in U-Boot if you have that.

> > > and because I am NFS root, it breaks boot :)
> > > 
> > > btw, I don't see an explanation in hte commit message for why the
> > > macb_is_gem(bp) got dropped? Is this now done unconditionally when it
> > > was conditional before?
> > > 
> > 
> > Well if you get to the ->macb_pcs_config() callback, you most certainly
> > have an SGMII PCS block. Does your IP have the PCS registers? (0x200 to
> > 0x23c) Also I thought that macb doesn't do SGMII (only GEM does) so it
> > can't reach ->macb_pcs_config(). 
> 
> When I said "macb on" I meant to say "macb driver on", but omitted the
> word. Unfortunately, the idiot who added the original mpfs compatible,
> because the platform was using the "cdns,macb" compatible rather than a
> soc-specific one, did not check if the platform was actually a macb
> before doing so, and trusted the original dts author. This is actually a
> gem.

Ok, well I think its correct to remove the macb_is_gem() check in
macb_pcs_config() because if we get to that function, SGMII was picked and
macb doesn't have SGMII. Furthermore, __set_bit(PHY_INTERFACE_MODE_SGMII
...) is guarded by a macb_is_gem() so even if someone puts 'phy-mode =
"sgmii"' in their macb device tree, we shouldn't get there.

Agreed that this should have been documented in the commit message.

Regards,
Charles



