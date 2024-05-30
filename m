Return-Path: <netdev+bounces-99432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D572C8D4DAA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 16:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EBDB1F23BF2
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 14:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D32176243;
	Thu, 30 May 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="e0uiRQtl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2A17C207;
	Thu, 30 May 2024 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078505; cv=none; b=CaVbmyqiUsXzQdA+y0k07S+s+W3tbR70rvIlDVk9K2pLG7IRFQJ74GyM+sCzyaDQsLStb/orqMGLIrgi7vPEidcqekAYQnwK6LMpj1576IHdGtQEN1tqMBlS9ojUV9okDt/2f3QtoPHmeZqgYecchReZOqu2kUZDzgmdHrJWqEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078505; c=relaxed/simple;
	bh=Pf2Z/gTyeAc/zbqRUitMbkZeeedv69W+XgEHvJ6Hn3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXfD2LEAjjaHOjtM5z6n/FRDd0lIis4Q3/BjomCm4MkX5heq9MX8RI8tIReSsN2Tc5W4oyHaPInGRpdPKwII9duwEwgG0mCt/nGfKo98bUP+jxSWQN06K+tpoRKUfCZ6CXjRIfOE0ArYj8ISUpMr8KhFF4HnLFBG8KnhJohwUqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=e0uiRQtl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+qH09HiYQvWvDHiKxS0mFE3pXiGrTTL8Rn/lk654rI4=; b=e0uiRQtl/oGT1CqdT/HnuaUQNj
	8hR65B6liVHqr0bs4xqi9jIrlrlW41KRyrNxPcSrGvyoL6f13x7T77WxVH3amOOB2xqB4UYfBGgmI
	zv9T9NSHroW/ii/1Irx3C42i48zqUndGq3YlDriTlbi4ecjY1EfV6+InbUEE6oBgJeZ4BC6GMVTUI
	68pudN2jU4sGS94EEKUNOp98pdrZWncFcnl+vssSeT21hO4AG1bXnoC8gou9vwyqy6y4LKzhuSukA
	bUZc1w0cwL3B14G2ckCJr3aZIHfupadRBRBMYApFqyFhfEvvrWlp+su1xxNnoFf0jjhTKkX/9o2bs
	DlaMI/AA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44048)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sCgYK-0007TP-35;
	Thu, 30 May 2024 15:14:49 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sCgYK-0005D7-RF; Thu, 30 May 2024 15:14:48 +0100
Date: Thu, 30 May 2024 15:14:48 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Xiaolei Wang <xiaolei.wang@windriver.com>, Andrew Lunn <andrew@lunn.ch>,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net v2 PATCH] net: stmmac: Update CBS parameters when speed
 changes after linking up
Message-ID: <ZliJ2O+bj18jQ0B8@shell.armlinux.org.uk>
References: <20240530061453.561708-1-xiaolei.wang@windriver.com>
 <f8b0843f-7900-4ad0-9e70-c16175e893d9@lunn.ch>
 <20240530132822.xv23at32wj73hzfj@skbuf>
 <ZliBzo7eETml/+bl@shell.armlinux.org.uk>
 <20240530135335.yanffjb3ketmoo7u@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530135335.yanffjb3ketmoo7u@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, May 30, 2024 at 04:53:35PM +0300, Vladimir Oltean wrote:
> On Thu, May 30, 2024 at 02:40:30PM +0100, Russell King (Oracle) wrote:
> > On Thu, May 30, 2024 at 04:28:22PM +0300, Vladimir Oltean wrote:
> > > On Thu, May 30, 2024 at 02:50:52PM +0200, Xiaolei Wang wrote:
> > > > When the port is relinked, if the speed changes, the CBS parameters
> > > > should be updated, so saving the user transmission parameters so
> > > > that idle_slope and send_slope can be recalculated after the speed
> > > > changes after linking up can help reconfigure CBS after the speed
> > > > changes.
> > > > 
> > > > Fixes: 1f705bc61aee ("net: stmmac: Add support for CBS QDISC")
> > > > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > > > ---
> > > > v1 -> v2
> > > >  - Update CBS parameters when speed changes
> > > 
> > > May I ask what is the point of this patch? The bandwidth fraction, as
> > > IEEE 802.1Q defines it, it a function of idleSlope / portTransmitRate,
> > > the latter of which is a runtime variant. If the link speed changes at
> > > runtime, which is entirely possible, I see no alternative than to let
> > > user space figure out that this happened, and decide what to do. This is
> > > a consequence of the fact that the tc-cbs UAPI takes the raw idleSlope
> > > as direct input, rather than something more high level like the desired
> > > bandwidth for the stream itself, which could be dynamically computed by
> > > the kernel.
> > 
> > So what should be the behaviour here? Refuse setting CBS parameters if
> > the link is down, and clear the hardware configuration of the CBS
> > parameters each and every time there is a link-down event? Isn't that
> > going to make the driver's in-use settings inconsistent with what the
> > kernel thinks have been set? AFAIK, tc qdisc's don't vanish from the
> > kernel just because the link went down.
> > 
> > I think what you're proposing leads to the hardware being effectively
> > "de-programmed" for CBS while "tc qdisc show" will probably report
> > that CBS is active on the interface - which clearly would be absurd.
> 
> No, just program to hardware right away the idleSlope, sendSlope,
> loCredit and hiCredit that were communicated by user space. Those were
> computed for a specific link speed and it is user space's business to
> monitor that this link speed is maintained for as long as the streams
> are necessary (otherwise those parameters are no longer valid).
> One could even recover the portTransmitRate that the parameters were
> computed for (it should be idleSlope - sendSlope, in Kbps).
> 
> AKA keep the driver as it is.
> 
> I don't see why the CBS parameters would need to be de-programmed from
> hardware on a link down event. Is that some stmmac specific thing?

If the driver is having to do computation on the parameters based on
the link speed, then when the link speed changes, the parameters
no longer match what the kernel _thinks_ those parameters were
programmed with.

What I'm trying to get over to you is that what you propose causes
an inconsistency between how the hardware is _programmed_ to behave
for CBS and what the kernel reports the CBS settings are if the
link speed changes.

For example, if the link was operating at 10G, and the idle slope
set by userspace is A, and the send slope was B, tc qdisc show
will report an idle slope of A and send slope of B.

If the link speed now changes to 5G, then, without updating the
settings in the hardware, the multiplier for the register values
will have reduced by a factor of two, meaning they're twice as
large as they should be for values of A and B.

However, tc qdisc show continues to report that values of A and B
are being used, but the hardware is actually using 2 * A and 2 * B.

It's all very well saying that userspace should basically reconstruct
the tc settings when the link changes, but not everyone is aware of
that. I'm saying it's a problem if one isn't aware of this issue with
this hardware, and one looks at tc qdisc show output, and assumes
that reflects what is actually being used when it isn't.

It's quality of implmentation - as far as I'm concerned, the kernel
should *not* mislead the user like this.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

