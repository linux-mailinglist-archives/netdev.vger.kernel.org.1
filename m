Return-Path: <netdev+bounces-267533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FqVBMw8tGmDjQAAu9opvQ
	(envelope-from <netdev+bounces-267533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:35:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A449287196
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28E56302EA87
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 16:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741F63C5DD9;
	Fri, 13 Mar 2026 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vyZ719YD"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D0B3C278F
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419721; cv=none; b=VM+oWtiCAJ+9HxP/8CZ4bNmzR89qOS1hmaDOHslsohNqvYF9icVmZHfXeQonLPlST3VjGOloP8REzXkhho5xPe2hbSDf45HTIzIiZg2e3Pn41kmcVMstkKx1i57fWVd3kjRGbk0/nTzGqxelN4cgb5xz6uX9GB1nllMMst2W9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419721; c=relaxed/simple;
	bh=np69cj0ha6lIKpsgdPN3ovhuYbn1R54I4uN1jWBDB8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPJxp0dkjJT6RNz3nKoLBWSs2iYfFX+PYN+/22Dbs/MDgKPjief6rjD4rWSuYnMEyJ8ZLX9VXM9S6GdVk3dQze3+EYQJ0Fc2/fAkVuiTVDloHKKPYc5Fqp+jgzJAYr/3cnRB1vIzyuLbqb5XLBxr5Q9nrMCNu+OtFlk/uZJGvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vyZ719YD; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K4UYISWV9qsLkjeT4fVqIPgPQOAh7Ipf/hHHbX4km0c=; b=vyZ719YDZ7x1Wv2Yziaf0ilgd8
	GVAoLBpJyrEPbe/ZVuu4/iCYIeN9QzHcaKjigbe1Z44LRjN4ubkTSVUtWj4wiuRIv4f0UwdTYGwdp
	H2ZBENCKH2+jP4v+/CkRpbantH82zSQVIcpIpUlM1L75V8Aawc1pKeJ5ZZQFOHZtiNkHsCRL3qwAU
	Hx3LNSUvhGGRFKO22eIQi2lDAgRqWOMbZScTQLvCiTUucBwrW2O19RQSwlS/O+CgSMwUaCx+CxiLt
	JqaTPxXl4XY3wp96Js9j8TnBGh1XV/V6H/pIhubXOZh7zkShC5wmh6k4Da0t45rXYwEtkWGT3iYrK
	vPvVrgvA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47814)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w15Td-000000001GI-369L;
	Fri, 13 Mar 2026 16:35:05 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w15Ta-000000008MN-2V7O;
	Fri, 13 Mar 2026 16:35:02 +0000
Date: Fri, 13 Mar 2026 16:35:02 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Christoffer Sandberg <cs@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH net-next] net: stmmac: fix dwmac4 transmit performance
 regression
Message-ID: <abQ8tlRYrU5W4VaK@shell.armlinux.org.uk>
References: <E1vgY1k-00000003vOC-0Z1H@rmk-PC.armlinux.org.uk>
 <6f4929c3-d727-44a3-abc5-c33923dc69d7@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4929c3-d727-44a3-abc5-c33923dc69d7@tuxedocomputers.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267533-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,foss.st.com,davemloft.net,google.com,kernel.org,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,tuxedocomputers.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,armlinux.org.uk:url,et.al:url,shell.armlinux.org.uk:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A449287196
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:03:16PM +0100, Georg Gottleuber wrote:
> Am 16.01.26 um 01:49 schrieb Russell King (Oracle):
> > dwmac4's transmit performance dropped by a factor of four due to an
> > incorrect assumption about which definitions are for what. This
> > highlights the need for sane register macros.
> > 
> > Commit 8409495bf6c9 ("net: stmmac: cores: remove many xxx_SHIFT
> > definitions") changed the way the txpbl value is merged into the
> > register:
> > 
> >         value = readl(ioaddr + DMA_CHAN_TX_CONTROL(dwmac4_addrs, chan));
> > -       value = value | (txpbl << DMA_BUS_MODE_PBL_SHIFT);
> > +       value = value | FIELD_PREP(DMA_BUS_MODE_PBL, txpbl);
> > 
> > With the following in the header file:
> > 
> >  #define DMA_BUS_MODE_PBL               BIT(16)
> > -#define DMA_BUS_MODE_PBL_SHIFT         16
> > 
> > The assumption here was that DMA_BUS_MODE_PBL was the mask for
> > DMA_BUS_MODE_PBL_SHIFT, but this turns out not to be the case.
> > 
> > The field is actually six bits wide, buts 21:16, and is called
> > TXPBL.
> > 
> > What's even more confusing is, there turns out to be a PBLX8
> > single bit in the DMA_CHAN_CONTROL register (0x1100 for channel 0),
> > and DMA_BUS_MODE_PBL seems to be used for that. However, this bit
> > et.al. was listed under a comment "/* DMA SYS Bus Mode bitmap */"
> > which is for register 0x1004.
> > 
> > Fix this up by adding an appropriately named field definition under
> > the DMA_CHAN_TX_CONTROL() register address definition.
> > 
> > Move the RPBL mask definition under DMA_CHAN_RX_CONTROL(), correctly
> > renaming it as well.
> > 
> > Also move the PBL bit definition under DMA_CHAN_CONTROL(), correctly
> > renaming it.
> > 
> > This removes confusion over the PBL fields.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thank you for this patch, which significantly speeds up the transmit (by
> more than a factor of nine on our devices with Motorcomm yt6801).
> 
> Unfortunately, this patch also causes DMA errors on two of our devices;
> logs from a iperf3 test are attached.
> 
> Strangely enough, a third device with the same Motorcomm yt6801 does not
> appear to be affected by the DMA errors. However, further testing is needed.
> 
> Do you have any ideas for further tests?

I would suggest dumping the contents of these control registers prior
to commit 8409495bf6c9, and after this commit, comparing their values
to identify what has changed. I'm sorry, I don't have the bandwidth to
inspect the patches to see what may have been inadvertently changed.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

