Return-Path: <netdev+bounces-263851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGvSEqxLqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:11:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E0499202507
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 232F63092203
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534573A0B2B;
	Wed,  4 Mar 2026 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ABGn02UV"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D419B3C6A36;
	Wed,  4 Mar 2026 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636404; cv=none; b=OIur3zdOXTXRuQ3/HCdD0hWUEzohrQk6VGZecpsogMfxaaMHjR9S0jsoPjc+rTMzMPB90WBuQOcjuOnqO/n/mIoKHmcxVm5ufOQugEk0PbspNtTeSTdeUWh2fy34DzjgirI/8z0ofdHqwgiWWdwmgRk64RxnbeTZDyKQct7bw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636404; c=relaxed/simple;
	bh=16E405jWrEfN4a6uwMbsHHztxI1WGoONQmT+FIcdDU4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rGLxigv0UZGPbEVi6BiGhLVmWM6YVB4tOqS/r6rbeHEjSb3Xz5tNRyYH2IOTEf1mxGHY6IVWUfqRO5InQ+LPt9WXuqdCgpZymP5z4Fzb/I+E/+ezg72DyEak3RLkrhwp+BpY1IMwXOjxyK6fxdN0ozz4HLX5RjYzlrMAEiGkjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ABGn02UV; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772636402; x=1804172402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=16E405jWrEfN4a6uwMbsHHztxI1WGoONQmT+FIcdDU4=;
  b=ABGn02UVmu4/TIkCGSFTX8q9xhkMagqhuf7lohud6bEOsTd0Prcxtz53
   mmcto4XK3ai1EkOleC9PLrlFKaFbT2DN7m6fcHL9flo6/WSouDcnI/6Oh
   BM21ps7e2EUY5NKHl6SUi78WtXxQd3jvCLeU48y7aTc86DbLmhRppuVcH
   ZZvfB88UY+HXkGmRIJXuT/7o3JKWeWruuGyK7H5DFONAZQpzYA3KOB9Or
   UoRpCOr79UEWiJb3ekBY0yl0dJSq7v7FRP7OEzbGbq79e6y5XX/KxlajX
   rvBBiGjmnRDfveT21x2WNg8JQEKrqr5rQVzP/rOwitzdstZ2MmYBgPpzc
   A==;
X-CSE-ConnectionGUID: UCaRE/fBR4K2V+i0Z7y/9Q==
X-CSE-MsgGUID: rrIA1Uv2SySFdtdtXiX7gg==
X-IronPort-AV: E=Sophos;i="6.21,324,1763449200"; 
   d="scan'208";a="221483058"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 08:00:02 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.87.152) by
 chn-vm-ex1.mchp-main.com (10.10.87.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Wed, 4 Mar 2026 07:59:37 -0700
Received: from bby-cbu-swbuild03.eng.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58 via Frontend Transport; Wed, 4 Mar 2026 07:59:37 -0700
Date: Wed, 4 Mar 2026 06:59:35 -0800
From: Charles Perry <charles.perry@microchip.com>
To: Conor Dooley <conor@kernel.org>
CC: <netdev@vger.kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, <linux-kernel@vger.kernel.org>,
	<charles.perry@microchip.com>
Subject: Re: [PATCH net-next v2 1/3] net: macb: fix SGMII with inband aneg
 disabled
Message-ID: <aahI1y0NO9ax/V8J@bby-cbu-swbuild03.eng.microchip.com>
References: <20260224202854.112813-1-charles.perry@microchip.com>
 <20260224202854.112813-2-charles.perry@microchip.com>
 <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260304-nebulizer-rounding-40fbc81a2ba1@spud>
X-Rspamd-Queue-Id: E0499202507
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263851-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microchip.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[charles.perry@microchip.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,microchip.com:dkim,microchip.com:email]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 11:15:43AM +0000, Conor Dooley wrote:
> On Tue, Feb 24, 2026 at 12:28:52PM -0800, Charles Perry wrote:
> > Make it possible to connect a PHY which does not use inband
> > autoneg to a gem MAC using phylink's information.
> > 
> > The previous implementation relied on whether or not the link
> > was a fixed-link to disable SGMII autoneg. This commit extend
> > this to all link which are not configured for inband
> > autonegotiation.
> > 
> > Signed-off-by: Charles Perry <charles.perry@microchip.com>
> 
> This breaks the macb on mpfs-icicle-kit, I get stuck with:
> 
> [    7.189102] mpfs-sys-controller syscontroller: Registered MPFS system controller
> [    7.260946] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> [    7.273881] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> [    7.296580] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> [    7.345782] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> [    7.358082] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> [    7.380479] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> [   11.376763] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [   11.398403] Sending DHCP requests .
> [   11.472699] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> [   13.938425] ..... timed out!
> [   93.598491] macb 20110000.ethernet eth0: Link is Down
> [   93.641823] macb 20110000.ethernet: gem-ptp-timer ptp clock unregistered.
> [   93.659433] macb 20112000.ethernet eth1: Link is Down
> [   93.691724] macb 20112000.ethernet: gem-ptp-timer ptp clock unregistered.
> [   93.703977] IP-Config: Retrying forever (NFS root)...
> [   93.758382] macb 20110000.ethernet eth0: PHY [20112000.ethernet-ffffffff:08] driver [Vitesse VSC8662] (irq=POLL)
> [   93.770655] macb 20110000.ethernet eth0: configuring for phy/sgmii link mode
> [   93.786497] macb 20110000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
> [   93.795840] macb 20110000.ethernet: gem-ptp-timer ptp clock registered.
> [   93.844481] macb 20112000.ethernet eth1: PHY [20112000.ethernet-ffffffff:09] driver [Vitesse VSC8662] (irq=POLL)
> [   93.856769] macb 20112000.ethernet eth1: configuring for phy/sgmii link mode
> [   93.870926] macb 20112000.ethernet eth1: Link is Up - 1Gbps/Full - flow control off
> [   93.880302] macb 20112000.ethernet: gem-ptp-timer ptp clock registered.
> 

Hello Conor,

I checked the driver for the VSC8662 and it doesn't have the
->inband_caps() and ->config_inband() callbacks so Linux leaves whatever
the bootloader puts or uses the defaults. Looking at the datasheet, this
should be register 23 (Extended PHY Control Set 1) bit 13 (MAC interface
auto-negotiation)

My guess is that this bit is set and since this patch disable inband
autonegotiation (because phylink decides it), there is a mismatch.

Can you add 'managed = "in-band-status"' in your device tree under the macb
node? That's not necessarily the fix, I just want to confirm my theory.
Also '#define DEBUG' in 'drivers/net/phy/phylink.c' can help if you can
recompile your kernel.

> and because I am NFS root, it breaks boot :)
> 
> btw, I don't see an explanation in hte commit message for why the
> macb_is_gem(bp) got dropped? Is this now done unconditionally when it
> was conditional before?
> 

Well if you get to the ->macb_pcs_config() callback, you most certainly
have an SGMII PCS block. Does your IP have the PCS registers? (0x200 to
0x23c) Also I thought that macb doesn't do SGMII (only GEM does) so it
can't reach ->macb_pcs_config(). 

Thanks alot for the testing!

Regards,
Charles

> Cheers,
> Conor.
> 
> > ---
> > 
> > Notes:
> >     Changes in v2:
> >       * Move my notes to the cover letter
> >       * Remove the spinlock in macb_pcs_config
> >       * Keep the comment about the PCSSEL register
> > 
> >  drivers/net/ethernet/cadence/macb_main.c | 36 +++++++++++++-----------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> > index f72270a39d25..f4250e76cef0 100644
> > --- a/drivers/net/ethernet/cadence/macb_main.c
> > +++ b/drivers/net/ethernet/cadence/macb_main.c
> > @@ -574,6 +574,26 @@ static int macb_pcs_config(struct phylink_pcs *pcs,
> >  			   const unsigned long *advertising,
> >  			   bool permit_pause_to_mac)
> >  {
> > +	struct macb *bp = container_of(pcs, struct macb, phylink_sgmii_pcs);
> > +	u32 old, new;
> > +
> > +	old = gem_readl(bp, PCSANADV);
> > +	new = phylink_mii_c22_pcs_encode_advertisement(interface, advertising);
> > +	if (new != -EINVAL && old != new)
> > +		gem_writel(bp, PCSANADV, new);
> > +
> > +	/* Disable AN if it's not to be used, enable otherwise.
> > +	 * Must be written after PCSSEL is set in NCFGR which is done in
> > +	 * macb_mac_config(), otherwise writes will not take effect.
> > +	 */
> > +	old = gem_readl(bp, PCSCNTRL);
> > +	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
> > +		new = old | BMCR_ANENABLE;
> > +	else
> > +		new = old & ~BMCR_ANENABLE;
> > +	if (old != new)
> > +		gem_writel(bp, PCSCNTRL, new);
> > +
> >  	return 0;
> >  }
> >  
> > @@ -628,22 +648,6 @@ static void macb_mac_config(struct phylink_config *config, unsigned int mode,
> >  	if (old_ncr ^ ncr)
> >  		macb_or_gem_writel(bp, NCR, ncr);
> >  
> > -	/* Disable AN for SGMII fixed link configuration, enable otherwise.
> > -	 * Must be written after PCSSEL is set in NCFGR,
> > -	 * otherwise writes will not take effect.
> > -	 */
> > -	if (macb_is_gem(bp) && state->interface == PHY_INTERFACE_MODE_SGMII) {
> > -		u32 pcsctrl, old_pcsctrl;
> > -
> > -		old_pcsctrl = gem_readl(bp, PCSCNTRL);
> > -		if (mode == MLO_AN_FIXED)
> > -			pcsctrl = old_pcsctrl & ~GEM_BIT(PCSAUTONEG);
> > -		else
> > -			pcsctrl = old_pcsctrl | GEM_BIT(PCSAUTONEG);
> > -		if (old_pcsctrl != pcsctrl)
> > -			gem_writel(bp, PCSCNTRL, pcsctrl);
> > -	}
> > -
> >  	spin_unlock_irqrestore(&bp->lock, flags);
> >  }
> >  
> > -- 
> > 2.47.3
> > 



