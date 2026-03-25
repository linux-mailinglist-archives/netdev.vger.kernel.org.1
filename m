Return-Path: <netdev+bounces-271732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPTqHPpBxGlHxwQAu9opvQ
	(envelope-from <netdev+bounces-271732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7732BB17
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 21:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 993103015FE2
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF71371867;
	Wed, 25 Mar 2026 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B0AC0wLn"
X-Original-To: netdev@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D38636BCDB
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 20:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774469621; cv=none; b=osgOudV14+cpkhEQaXiQqloJzuoW/df23LP0b/kGssJPWfLKvc2sKsr5ubo7HOEvqF9EQDg6PJ8u37GQ0Y5CRVHURFYS2mDBt1gHlCn2PbJOzyDz2yIiX2GbcZthwRosbPEG/lI10WQKZk76S1IBS7ge/izmClJBNabWUGXaJxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774469621; c=relaxed/simple;
	bh=7BsRlEHo9DuNRcemqGPBLT932bs5lLCqHzyJZhsZrS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kb4e+dsGdMwtrquFUcRD83GOcxApyh7j9J9U7eyYZ2RY+pjT6jx2Yg9DyQQlmE13q1wU5HAeWMLKqIyp+gOZqXOmZLJM+wnNnbIZrcymhxFNVLnDkOW5zzwU86iwjg/gf8hY2DEvx5eRocglh/+AeAkEeL8anNIV+4emB01N3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=B0AC0wLn; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from killaraus.ideasonboard.com (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 06C8D1BA;
	Wed, 25 Mar 2026 21:12:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1774469536;
	bh=7BsRlEHo9DuNRcemqGPBLT932bs5lLCqHzyJZhsZrS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0AC0wLn3Ob992yC9suQRcS93NkYNC9Ll/NgROD2xXR6oqAMCm78nzYvCg2EIY4gF
	 f6Jbp405eKuz1i9nTY0+PS5tHE8c/9RKIHI12Ecp49luwgITLgdzHPvck9js6zRLoy
	 ftEim5hQ4AMyO7uN2YyLcQ2sQLCjZrn+7inbXkvg=
Date: Wed, 25 Mar 2026 22:13:32 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: netdev@vger.kernel.org
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, imx@lists.linux.dev,
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
Message-ID: <20260325201332.GA2670326@killaraus.ideasonboard.com>
References: <20260323093933.1785583-1-laurent.pinchart@ideasonboard.com>
 <20260323093933.1785583-2-laurent.pinchart@ideasonboard.com>
 <acEOGMHfYsxv3GOk@shell.armlinux.org.uk>
 <20260323100801.GA1514659@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323100801.GA1514659@killaraus.ideasonboard.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271732-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lists.linux.dev,lunn.ch,davemloft.net,google.com,gmail.com,toradex.com,nxp.com,kernel.org,ideasonboard.com,pengutronix.de,redhat.com,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 75F7732BB17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 12:08:02PM +0200, Laurent Pinchart wrote:
> On Mon, Mar 23, 2026 at 09:55:36AM +0000, Russell King (Oracle) wrote:
> > On Mon, Mar 23, 2026 at 11:39:32AM +0200, Laurent Pinchart wrote:
> > > From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
> > > 
> > > Some platforms have problems when EEE is enabled, and thus need a way
> > > to disable stmmac EEE support. Add a flag before the other LPI related
> > > flags which tells stmmac to avoid populating the phylink LPI
> > > capabilities, which causes phylink to call phy_disable_eee() for any
> > > PHY that is attached to the affected phylink instance.
> > > 
> > > iMX8MP is an example - the lpi_intr_o signal is wired to an OR gate
> > > along with the main dwmac interrupts. Since lpi_intr_o is synchronous
> > > to the receive clock domain, and takes four clock cycles to clear, this
> > > leads to interrupt storms as the interrupt remains asserted for some
> > > time after the LPI control and status register is read.
> > > 
> > > This problem becomes worse when the receive clock from the PHY stops
> > > when the receive path enters LPI state - which means that lpi_intr_o
> > > can not deassert until the clock restarts. Since the LPI state of the
> > > receive path depends on the link partner, this is out of our control.
> > > We could disable RX clock stop at the PHY, but that doesn't get around
> > > the slow-to-deassert lpi_intr_o mentioned in the above paragraph.
> > > 
> > > Previously, iMX8MP worked around this by disabling gigabit EEE, but
> > > this is insufficient - the problem is also visible at 100M speeds,
> > > where the receive clock is slower.
> > > 
> > > There is extensive discussion and investigation in the thread linked
> > > below, the result of which is summarised in this commit message.
> > > 
> > > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Closes: https://lore.kernel.org/r/20251026122905.29028-1-laurent.pinchart@ideasonboard.com
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > 
> > As you are sending this on my behalf, you need to add your s-o-b after
> > mine:
> 
> Oops, I'm not sure how I missed that. Sorry.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Should I submit a v4, or can this series be picked for v7.1 with my SoB
added ?

> >  Any further SoBs (Signed-off-by:'s) following the author's SoB are from
> >  people handling and transporting the patch, but were not involved in its
> >  development. SoB chains should reflect the **real** route a patch took
> >  as it was propagated to the maintainers and ultimately to Linus, with
> >  the first SoB entry signalling primary authorship of a single author.

-- 
Regards,

Laurent Pinchart

