Return-Path: <netdev+bounces-263943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A2HOJtsqGn9uQAAu9opvQ
	(envelope-from <netdev+bounces-263943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:32:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 557B42052F9
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 18:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32527308C58A
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 17:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBDB3B7B9D;
	Wed,  4 Mar 2026 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="i2xy1qCK"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9F73B7B84;
	Wed,  4 Mar 2026 17:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645200; cv=none; b=LwW0zAKKvrNjnZkgkeUIcejgVC1Kq+JS6olPfJu7nxse9v0N33ovnYCH1P2Tz0z8iSPKsob+r3GqHTYaB4WQLI2SG2yVy/CnJjyBtT9ksDkIxj5/SeL6GYw3t1tXEI0qVS6hSow614YGA99dXJJcc+rjGm4hy7UOFHljg5+1sIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645200; c=relaxed/simple;
	bh=LARPChrQh1p43gCZUpy+K77KnUK5C9TLQ5kz2+MNn7M=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaYEseqUqbcZhe9q+GYaaMnhGjzeACEMyjDYGjNuIlbgGT7rHJNAYxZTb94vYsxO8/Lvta0DzNqTQ/3G9PABcuoswuYaKTQGvQp7aIarrW3g5UBupMIN9pJgqOftWtUI8AA0QgtUDLX69bbbZK1cOr//HSBmAqAiRGwVK8rCLtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=i2xy1qCK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772645195; x=1804181195;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LARPChrQh1p43gCZUpy+K77KnUK5C9TLQ5kz2+MNn7M=;
  b=i2xy1qCKLYN8hLpNzBexQn3JJldlMxgane6D/QO8eolCaUdNgI9D2s6V
   7A5oywYCeUm1YMq4ZCR8xMe9BIVW8Vg9FUx1//VQuybvlciy/WSDdZyTE
   D/4CFd+MIzjPYy8rezchhRq375PWr1sPXNJdFw+IhZE9kppK6oFfqSZVG
   y48KGxqBo4HYJnqh0L5n8ubinPDFCUvu5W0SFDtELQnrfHuS4q1DlW7/s
   V2yz8MVqASNOrK+1X1RkxbsyhQQnTjvSBp7xt4Cqlxrn2ImLQ+363IoRW
   MITRAn6q1pQewwFoOtoHy5e6lNgwGm862+8YVI0lVdu3ZHXka20B3UTlW
   Q==;
X-CSE-ConnectionGUID: R+zGeeCTStCZFwacSaEwmw==
X-CSE-MsgGUID: YHg8yHRwRg2O9e0Eet1mdQ==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="54654015"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2026 10:26:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 4 Mar 2026 10:25:59 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 10:25:58 -0700
Date: Wed, 4 Mar 2026 09:25:57 -0800
From: Charles Perry <charles.perry@microchip.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Conor Dooley
	<conor@kernel.org>
CC: Conor Dooley <conor@kernel.org>, <netdev@vger.kernel.org>, Sean Anderson
	<sean.anderson@linux.dev>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <aahrJZyn4wxRapVk@bby-cbu-swbuild03.eng.microchip.com>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
 <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
 <20260304-unvented-crinkle-37f0bfd03541@spud>
 <aahkCah1pvuNIy03@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aahkCah1pvuNIy03@shell.armlinux.org.uk>
X-Rspamd-Queue-Id: 557B42052F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263943-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email,bby-cbu-swbuild03.eng.microchip.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 04:55:37PM +0000, Russell King (Oracle) wrote:
> On Wed, Mar 04, 2026 at 04:23:30PM +0000, Conor Dooley wrote:
> > On Wed, Mar 04, 2026 at 06:59:35AM -0800, Charles Perry wrote:
> > > On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> > > > On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > > > > Make it possible to connect a PHY which does not use inband
> > > > > autoneg to a gem MAC using phylink's information.
> > > > > 
> > > > > The previous implementation relied on whether or not the link
> > > > > was a fixed-link to disable SGMII autoneg. This commit extend
> > > > > this to all link which are not configured for inband
> > > > > autonegotiation.
> > > > > 
> > > > > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> > > > 
> > > > This breaks the macb on mpfs-icicle-kit, I get stuck with:
> > > > 
> > > > [    7.189102] mpfs-sys-controller syscontroller: Registered MPFS system controller
> > > > [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> > > > [    7.273881] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> > > > [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> > > > [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> > > > [    7.358082] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> > > > [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> > > > [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > > > [   11.398403] Sending DHCP requests .
> > > > [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> > > > [   13.938425] ..... timed out!
> > > > [   93.598491] macb 20110000.ethernet eth0: Link is Down
> > > > [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock unregistered.
> > > > [   93.659433] macb 20112000.ethernet eth1: Link is Down
> > > > [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock unregistered.
> > > > [   93.703977] IP-Config: Retrying forever (NFS root)...
> > > > [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> > > > [   93.770655] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> > > > [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> > > > [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> > > > [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> > > > [   93.856769] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> > > > [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> > > > [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> > > > 
> > > 
> > > Hello Conor,
> > > 
> > > I checked the driver for the VSC8662 and it doesn't have the
> > > ->inband_caps() and ->config_inband() callbacks so Linux leaves whatever
> > > the bootloader puts or uses the defaults. Looking at the datasheet, this
> > > should be register 23 (Extended PHY Control Set 1) bit 13 (MAC interface
> > > auto-negotiation)
> > > 
> > > My guess is that this bit is set and since this patch disable inband
> > > autonegotiation (because phylink decides it), there is a mismatch.
> > > 
> > > Can you add 'managed = "in-band-status"' in your device tree under the macb
> > > node? That's not necessarily the fix, I just want to confirm my theory.
> > 
> > No, it just produces a different error:
> > [    5.769864] mpfs-sys-controller syscontroller: Registered MPFS system controller
> > [    5.829146] macb 20110000.ethernet eth0: Could not attach PHY (-19)
> > [    5.854232] IP-Config: Failed to open eth0
> > [    5.897152] macb 20112000.ethernet eth1: Could not attach PHY (-19)
> > [    5.921061] IP-Config: Failed to open eth1
> > [    5.925592] IP-Config: No network devices available
> > [    5.938800] clk: Disabling unused clocks
> > [    5.944156] PM: genpd: Disabling unused power domains
> > [    5.961029] check access for rdinit=/usr/sbin/init failed: -2, ignoring
> 
> -19 is -ENODEV (I wish everyone would use %pe so we get english
> error messages rather than having to look up errno codes in the
> header files.)
> 
> macb uses either phylink_of_phy_connect() or phylink_connect_phy().
> I don't think phylink_connect_phy() would return -ENODEV, but
> phylink_of_phy_connect() would - but I can't see that adding
> 'managed = "in-band-status";' to DT would cause that. The only
> case I can see is that fwnode_phy_find_device() fails to find the
> phydev, but there is a PHY node specified in DT, but that would
> fail without in-band-status.
> 

Conor,

Can you send us a snippet of you device tree showing the gem node and the
phy?

The idea behind adding 'managed = "in-band-status"' in the device tree is
to hint phylink to use MLO_AN_INBAND. I'm afraid we'll get the same result
if we come up with a different workaround.

Thanks,
Charles

> > > Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you can
> > > recompile your kernel.
> > 
> > Setting this provided no further logs, seemingly.
> 
> It certainly would if you place it before the first #include - I
> routinely build kernels with it set as such. The messages are produced
> at debug level, so should appear via "dmesg". If you want to see them
> on the console, you need to add "debug" to the kernel command line.
> 
> However, the in-band-status thing needs to be root-caused first.
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

