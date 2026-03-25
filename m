Return-Path: <netdev+bounces-271738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHgzFnBIxGn5xwQAu9opvQ
	(envelope-from <netdev+bounces-271738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:41:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A814A32BEEC
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84E22300CC85
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A9634F49F;
	Wed, 25 Mar 2026 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mceejZKQ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B0EBA45
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471213; cv=none; b=QtHc3A/8RDvaiskZpULj16P/v/umKxB2n5anDXh0dHgXbrwAi8tNP6wwmXS77rBc5Sd2BzKV/aVAnqHIrpv0Mzl9CAUDORKEHpeKYbbZA/QiwO61xsP+6gSqn02JBXdOXGQRBrwrE+PV/O4pDCDOytmLCHDy2UH50XRzhjAngOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471213; c=relaxed/simple;
	bh=+GEUfA+dQ7kaTZDoTzOD8hzNGGZvKoPVSlncYyIgycA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMYs61fRi4KWLmOvKqam0aI31aUC0H0TiFsEwjHeRubQP+ljPfJVrp7vWWeAYIVxFSlI1SavmkoKFJQbUY4hZS3lvw3NSSTGei3Bj5xRuE5RPzBgA4zYS74VomgpNaBAzpfw2urovJHg+Q9OD+BoMQTKSJz5xW4la838llgHGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=mceejZKQ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/L649BGHfzjPeUOm873tBDJOzKxxjacvMmrNB1ND0NY=; b=mceejZKQu1r5osaBGGu8D5bmS6
	LlEGU+Kj4Gojb9WRVpB20EU9bwop0rMed2nI16rOt/8R/YDM0mFc+tazI99PdrL+KjH3ypxVY/16a
	8NCVmvUtAcSYtTsC6D6H6ftl2pxWHEom1saTEQNov3hl7aAhxwZf/a5nwLt/BsDvGCOU1SXXVngSb
	AA2je89k6Lecuk0X0Qc8XD7TROev9I9ilXzezAxsBhz2vjciDh1JY2vSClMzk6iJ4qIsxX/Rhpozj
	s+Y6bOijsUrxL2U/SF+NqpfWXJcBYz2srxbaceuWm9TbtLhYpl7YPy67P7QNnlG0Ao5kzefy2AGmm
	wKy7OD2A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33832)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w5V1L-000000003s4-3MDN;
	Wed, 25 Mar 2026 20:40:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w5V1I-000000006Lq-1xqC;
	Wed, 25 Mar 2026 20:40:04 +0000
Date: Wed, 25 Mar 2026 20:40:04 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, imx@lists.linux.dev,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Frank Li <Frank.Li@nxp.com>, Jakub Kicinski <kuba@kernel.org>,
	Joy Zou <joy.zou@nxp.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Stefan Klug <stefan.klug@ideasonboard.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] net: stmmac: provide flag to disable EEE
Message-ID: <acRIJMQSTt-N52C0@shell.armlinux.org.uk>
References: <20260323093933.1785583-1-laurent.pinchart@ideasonboard.com>
 <20260323093933.1785583-2-laurent.pinchart@ideasonboard.com>
 <acEOGMHfYsxv3GOk@shell.armlinux.org.uk>
 <20260323100801.GA1514659@killaraus.ideasonboard.com>
 <20260325201332.GA2670326@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325201332.GA2670326@killaraus.ideasonboard.com>
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
	TAGGED_FROM(0.00)[bounces-271738-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,ideasonboard.com,pengutronix.de,redhat.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	NEURAL_HAM(-0.00)[-0.887];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,armlinux.org.uk:email,armlinux.org.uk:url]
X-Rspamd-Queue-Id: A814A32BEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:13:32PM +0200, Laurent Pinchart wrote:
> On Mon, Mar 23, 2026 at 12:08:02PM +0200, Laurent Pinchart wrote:
> > On Mon, Mar 23, 2026 at 09:55:36AM +0000, Russell King (Oracle) wrote:
> > > On Mon, Mar 23, 2026 at 11:39:32AM +0200, Laurent Pinchart wrote:
> > > > From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> > > > 
> > > > Some platforms have problems when EEE is enabled, and thus need a way
> > > > to disable stmmac EEE support. Add a flag before the other LPI related
> > > > flags which tells stmmac to avoid populating the phylink LPI
> > > > capabilities, which causes phylink to call phy_disable_eee() for any
> > > > PHY that is attached to the affected phylink instance.
> > > > 
> > > > iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> > > > along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> > > > to the receive clock domain, and takes four clock cycles to clear, this
> > > > leads to interrupt storms as the interrupt remains asserted for some
> > > > time after the LPI control and status register is read.
> > > > 
> > > > This problem becomes worse when the receive clock from the PHY stops
> > > > when the receive path enters LPI state - which means that lpi_intr_o
> > > > can not deassert until the clock restarts. Since the LPI state of the
> > > > receive path depends on the link partner, this is out of our control.
> > > > We could disable RX clock stop at the PHY, but that doesn't get around
> > > > the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
> > > > 
> > > > Previously, iMX8MP worked around this by disabling gigabit EEE, but
> > > > this is insufficient - the problem is also visible at 100M speeds,
> > > > where the receive clock is slower.
> > > > 
> > > > There is extensive discussion and investigation in the thread linked
> > > > below, the result of which is summarised in this commit message.
> > > > 
> > > > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > > Closes: https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com
> > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > 
> > > As you are sending this on my behalf, you need to add your s-o-b after
> > > mine:
> > 
> > Oops, I'm not sure how I missed that. Sorry.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Should I submit a v4, or can this series be picked for v7.1 with my SoB
> added ?

I don't see it in patchwork's pending queue, so yes please. Don't forget
to specify the tree in the subject line:

[PATCH net-next v4 0/2] net: stmmac: ...

which may be a factor in it not showing up.

It's worth keeping an eye on:

https://patchwork.kernel.org/project/netdevbpf/list/?delegate=123371

about 24h after submission in case of any issues.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

