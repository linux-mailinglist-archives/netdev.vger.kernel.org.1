Return-Path: <netdev+bounces-272803-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULCUFUckyGkXhQUAu9opvQ
	(envelope-from <netdev+bounces-272803-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:56:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD134FB45
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 19:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BCBC3024A58
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 18:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABF633A70F;
	Sat, 28 Mar 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wcxrXdOx"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A03081D6
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 18:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774724164; cv=none; b=d8gFvMjyFTsxchg7lZHz7Yxflxx62vhryRXFxWdbHk66XWoOIWL+AyMi0Wb89N66yxe6m9n3V/w9/ZhC+pBD1YPtnTXPIZNP9NPSSrUMsU93RLUMs92cBDobGUWjuLkmE19GXCnKuvhXOwi1ZjReoei17a7T9YCqiEEarnCzRr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774724164; c=relaxed/simple;
	bh=MFMcARP+62ax75T9Lx65udf8GIwMXzSxFrP9s3n8eJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrgL8GFR7NitUGYXUhMn22f83FeB7LkYJNg9bKXOwMULZlHMUyLohX9wMicpbtSAOFI2CrQ6SMT2k7s2nvKCzDXCkIB/lrUpQ/q2GWhtn63fvNcqqlUhGm7kT2ahZEUw8eDmrJHE95JhVgNcu6zUztyUAzM87GkFNpOBL7J9vRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wcxrXdOx; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QmNbU8w/wXLROhB5GpLCWw/c0/7pPxZBQCA+U72RmSs=; b=wcxrXdOx2x0CM5UOU1Z5djDfMk
	rTynwB4SMJh1bQYz6s1K8OGwkSf9Z2R5QW6YYW6dmLFgqicCknErDcotW7UQDLYVmHEPvwc2vIQDv
	p68AhgdpoKq9QuvHMzCk1WpDWfRmIPnz7Gi8T+qTLkH3xuZ/kf68SKpt5NqX229KmFpwfKpqefphe
	BDLhqcsXL6KnbjrAa1Pk725z2G0xyDO2w0GdzU/8573wMiMGWuNXWlHu7vUfZYOdOVnly1zMxPZ/c
	1uWa7TVDqaTJOKd4Gb5ZoVPaxx6yJu41siZjVmq+SDYGPDP5EsuUie6PXw8LthWeffXT+cZKk7emi
	xL1zmoow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47004)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w6Yp4-000000007M3-3wn7;
	Sat, 28 Mar 2026 18:55:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w6Yp1-000000000sd-3WOM;
	Sat, 28 Mar 2026 18:55:47 +0000
Date: Sat, 28 Mar 2026 18:55:47 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Ong Boon Leong <boon.leong.ong@intel.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: simplify GSO/TSO test in
 stmmac_xmit()
Message-ID: <acgkM2FGS2h-fPVN@shell.armlinux.org.uk>
References: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
 <E1w63fl-0000000E3Vb-3JkY@rmk-PC.armlinux.org.uk>
 <aceQRSc5o4D-HHmq@shell.armlinux.org.uk>
 <acegAqUb-Dzy87d8@shell.armlinux.org.uk>
 <acgPJgW9r0l952qu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acgPJgW9r0l952qu@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272803-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.688];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[davemloft.net:email,intel.com:email,shell.armlinux.org.uk:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2CD134FB45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 05:25:58PM +0000, Russell King (Oracle) wrote:
> On Sat, Mar 28, 2026 at 09:31:46AM +0000, Russell King (Oracle) wrote:
> > On Sat, Mar 28, 2026 at 08:24:37AM +0000, Russell King (Oracle) wrote:
> > > On Fri, Mar 27, 2026 at 09:40:09AM +0000, Russell King (Oracle) wrote:
> > > > The test in stmmac_xmit() to see whether we should pass the skbuff to
> > > > stmmac_tso_xmit() is more complex than it needs to be. This test can
> > > > be simplified by storing the mask of GSO types that we will pass, and
> > > > setting it according to the enabled features.
> > > > 
> > > > Note that "tso" is a mis-nomer since commit b776620651a1 ("net:
> > > > stmmac: Implement UDP Segmentation Offload"). Also note that this
> > > > commit controls both via the TSO feature. We preserve this behaviour
> > > > in this commit.
> > > > 
> > > > Also, this commit unconditionally accessed skb_shinfo(skb)->gso_type
> > > > for all frames, even when skb_is_gso() was false. This access is
> > > > eliminated.
> > > > 
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > 
> > > AI review of this patch regurgitates Jakub's point that was discussed.
> > > 
> > > > @@ -3700,7 +3700,7 @@ static int stmmac_hw_setup(struct net_device *dev)
> > > >  	stmmac_set_rings_length(priv);
> > > >  
> > > >  	/* Enable TSO */
> > > > -	if (priv->tso) {
> > > > +	if (priv->gso_enabled_types) {
> > > >  		for (chan = 0; chan < tx_cnt; chan++) {
> > > >  			struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[chan];
> > > >  
> > > 
> > > ...
> > > 
> > > > @@ -7828,7 +7834,7 @@ static int __stmmac_dvr_probe(struct device *device,
> > > >  		ndev->hw_features |= NETIF_F_TSO | NETIF_F_TSO6;
> > > >  		if (priv->plat->core_type == DWMAC_CORE_GMAC4)
> > > >  			ndev->hw_features |= NETIF_F_GSO_UDP_L4;
> > > > -		priv->tso = true;
> > > > +		stmmac_set_gso_types(priv, true);
> > > 
> > > Clearly, the issue it is regurgitating has been there for a long time
> > > and isn't a new issue introduced by this patch.
> > > 
> > > AI needs to stop doing this, because it is encouraging multiple changes
> > > in a single patch, which is against the normal kernel process.
> > > 
> > > As already pointed out, there are multiple issues with stmmac TSO
> > > support, particularly with glue drivers that enable TSO on some
> > > queues/channels and not others, since netdev core TSO support is
> > > global across all channels.
> > > 
> > > So, won't the AI response in this patch - it's just another pre-
> > > existing issue that needs fixing in a separate patch.
> > 
> > Looking at the TSO vs TBS issue (which precludes the use of TSO on a
> > channel in stmmac) I can't find an obvious reason for this in the
> > available documentation. However, unfortunately, iMX8MP doesn't support
> > TSO, so the TSO bits are elided there, but does support TBS (needing
> > enhanced descriptors to be enabled). STM32MP151 on the other hand
> > supports TSO but not TBS, and thus fails to mention anything about
> > enhanced descriptors or TBS.
> > 
> > When stmmac_enable_tbs() enables TBS, it isn't actually enabling a
> > feature specific bit, but switching the channel to use enhanced
> > descriptor format. This format extends the basic descriptors by
> > placing four extra 32-bit words before the basic descriptor.
> > 
> > Looking at the enhanced normal descriptor format for TDES3, it
> > indicates that the format includes bit 18 in the control field, which
> > is the TSE bit (TCP segmentation enable for this packet.) So, it seems
> > it's not a limitation of the descriptor format.
> > 
> > So, either "TSO and TBS cannot co-exist" is incorrect, or there is a
> > hardware limitation that isn't documented between these two manuals.
> > 
> > One other interesting point is that stmmac_tso_xmit() seems to
> > handle the case where TSO and TBS are enabled on the channel:
> > 
> >                 if (tx_q->tbs & STMMAC_TBS_AVAIL)
> >                         mss_desc = &tx_q->dma_entx[tx_q->cur_tx].basic;
> >                 else
> >                         mss_desc = &tx_q->dma_tx[tx_q->cur_tx];
> > 
> >                 stmmac_set_mss(priv, mss_desc, mss);
> > ...
> >         if (tx_q->tbs & STMMAC_TBS_AVAIL)
> >                 desc = &tx_q->dma_entx[first_entry].basic;
> >         else
> >                 desc = &tx_q->dma_tx[first_entry];
> >         first = desc;
> > 
> > etc.
> > 
> > Avoiding enabling TSO for a TBS channel was added by this commit:
> > 
> > commit 5e6038b88a5718910dd74b949946d9d9cee9a041
> > Author: Ong Boon Leong <boon.leong.ong@intel.com>
> > Date:   Wed Apr 21 17:11:49 2021 +0800
> > 
> >     net: stmmac: fix TSO and TBS feature enabling during driver open
> > 
> >     TSO and TBS cannot co-exist and current implementation requires two
> >     fixes:
> > 
> >      1) stmmac_open() does not need to call stmmac_enable_tbs() because
> >         the MAC is reset in stmmac_init_dma_engine() anyway.
> >      2) Inside stmmac_hw_setup(), we should call stmmac_enable_tso() for
> >         TX Q that is _not_ configured for TBS.
> > 
> >     Fixes: 579a25a854d4 ("net: stmmac: Initial support for TBS")
> >     Signed-off-by: Ong Boon Leong <boon.leong.ong@intel.com>
> >     Signed-off-by: David S. Miller <davem@davemloft.net>
> > 
> > which doesn't really explain the background, and leaves all the TBS
> > cruft in the TSO transmit path (nothing like properly updating the
> > driver, eh? No wonder stmmac is such a mess!)
> 
> The more I look at this, the more I'm convinced this commit is
> incorrect, even if it is the case that the hardware doesn't support
> TSO and TBS together.
> 
> When TSO is enabled (NETIF_F_TSO set in the netif's features) then
> the core net layer can submit skbuffs that need to be processed using
> TSO.
> 
> If such a skbuff hits a channel that has TSO disabled (because the
> above commit caused:
> 
> 	stmmac_enable_tso(priv, priv->ioaddr, 1, chan);
> 
> not to be called) then the TSE bit in the transmit control register
> will not be set, thereby disabling TSO on this particular channel.
> 
> However, stmmac_xmit() will still call through to stmmac_tso_xmit()
> which will dutifully populate the transmit ring with descriptors that
> assume TSE has been set in the transmit control register.
> 
> It seems to me _that_ is even more broken than "the hardware doesn't
> support TSO and TBS together" - I have no idea what the stmmac hardware
> does if it encounters descriptors with TSE set but TSE is disabled in
> the transmit control register. My guess would be it would ignore the
> TSE bit in the descriptor and assume that it's one very large packet
> to be sent - and either error out because it's longer than the
> maximum the hardware can support or it will just try to transmit it
> anyway.

Okay, I've found a statement in the stm32mp25xx documentation which
backs up Intel's commit, but that commit is still wrong because it
only half does the job.

However, I think I now have a solution - implementing
.ndo_features_check() which will mask out the NETIF_F_GSO_MASK
features if either the header length is greater than 1023 (the
hardware maximum) or the queue (as returned by
skb_get_queue_mapping(skb)) is for a queue which has TBS available,
and thus has TSO disabled.

I'm surprised we haven't had reports of brokenness in this area.

I think it's time to re-shuffle these patches (plus I think there's
a bit more scope to clean up some of the TSO code which would mean
placing stmmac_set_gso_types() in a different location to keep
all the TSO-related code together. I'll mark this series as
superseded once I have its replacement ready.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

