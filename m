Return-Path: <netdev+bounces-194040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF5AC70FF
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 20:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9185F1C0175B
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 18:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C2428DF44;
	Wed, 28 May 2025 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Wosndm3Q"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE9D2AD00;
	Wed, 28 May 2025 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748457303; cv=none; b=fDQgaXJ6YlooQVqjjaVU+ZmoLl7oO/AtAdbgc9kXZiJ/p2oTHQ20c+1rAKE0huPFvBk5Js0Re3QuIrZTe5bXGZYDQzw0rx+zdoRNYENqcTXFzG1ZPjJ1rz7TOvOIOwysRYIOG0O7zt/T+gFv9PGYDXDZyopYHsyxqK6g7Qlw/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748457303; c=relaxed/simple;
	bh=o9psRuqLrZuh6dkcqaKQG63amKvh7ilq2Ah+aLkz5sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu8p+KFWL1NfXLxdpz2xYWVwyp9nqqxo9vPcQSuZ54Z4Ty94oZjy+CfndDkCSws7YTuVlLtGnnVkS+bSgR3vUXolNqcHYzi4+VOHRVe0JYxfFjHa/TTl6IclQpIcHbaLKEg8pz4v0G4ai9GP/FvgZhV8GmlPTUBWUbuDMG7bBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Wosndm3Q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oEfLgoqZZlV3CauhRyPut9aS8+kFBL6RAy2mXOuaG1k=; b=Wosndm3QpTZVvNqtddTO/EUoXb
	G2aSMfofpfTs0Lj9HH36ZoGLLfL29XW2NdZptgFMhsLa4HiLJmIRkdeqv7/651xgC0r0P/ve6nFjK
	QFQxC/4Ql5Bi0PD/gU1UHyqdJMizemvlygAL97MKyKy/l31HXEXeKcuTqXtchmTqSG3u7BbvuNwUl
	wR4TI0dfDpSr3+Keyxz27/QnzYt/qxEsxU02bJbw0JG54MYdZwnf6PKG2ee1/3m98EsDkdlnl5nGy
	wu5BiJNG0PHlg6yVdKWTnIIuO7RJ8l0+gdQCwwtIoYJo7bvIaE1s1Cqc1C9Mg9iX9fpnKBjlFABZS
	jcD17Cog==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50888)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uKLc2-0000ci-1Y;
	Wed, 28 May 2025 19:34:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uKLbx-0002d3-0P;
	Wed, 28 May 2025 19:34:45 +0100
Date: Wed, 28 May 2025 19:34:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: wens@csie.org, Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-sunxi@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] net: stmmac: allow drivers to explicitly select
 PHY device
Message-ID: <aDdXRPD2NpiZMsfZ@shell.armlinux.org.uk>
References: <CADvTj4rGdb_kHV_gjKTJNkzYEPMzqLcHY_1xw7wy5r-ryqDfNQ@mail.gmail.com>
 <fe8fb314-de99-45c2-b71e-5cedffe590b0@lunn.ch>
 <CADvTj4qRmjUQJnhamkWNpHGNAtvFyOJnbaQ5RZ6NYYqSNhxshA@mail.gmail.com>
 <014d8d63-bfb1-4911-9ea6-6f4cdabc46e5@lunn.ch>
 <CADvTj4oVj-38ohw7Na9rkXLTGEEFkLv=4S40GPvHM5eZnN7KyA@mail.gmail.com>
 <aDbA5l5iXNntTN6n@shell.armlinux.org.uk>
 <CADvTj4qP_enKCG-xpNG44ddMOJj42c+yiuMjV_N9LPJPMJqyOg@mail.gmail.com>
 <f915a0ca-35c9-4a95-8274-8215a9a3e8f5@lunn.ch>
 <CAGb2v66PEA4OJxs2rHrYFAxx8bw4zab7TUXQr+DM-+ERBO-UyQ@mail.gmail.com>
 <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvTj4qyRRCSnvvYHLvTq73P0YOjqZ=Z7kyjPMm206ezMePTpQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, May 28, 2025 at 11:25:20AM -0600, James Hilliard wrote:
> On Wed, May 28, 2025 at 8:12 AM Chen-Yu Tsai <wens@csie.org> wrote:
> >
> > On Wed, May 28, 2025 at 9:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Wed, May 28, 2025 at 05:57:38AM -0600, James Hilliard wrote:
> > > > On Wed, May 28, 2025 at 1:53 AM Russell King (Oracle)
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Tue, May 27, 2025 at 02:37:03PM -0600, James Hilliard wrote:
> > > > > > On Tue, May 27, 2025 at 2:30 PM Andrew Lunn <andrew@lunn.ch> wrote:
> > > > > > >
> > > > > > > > Sure, that may make sense to do as well, but I still don't see
> > > > > > > > how that impacts the need to runtime select the PHY which
> > > > > > > > is configured for the correct MFD.
> > > > > > >
> > > > > > > If you know what variant you have, you only include the one PHY you
> > > > > > > actually have, and phy-handle points to it, just as normal. No runtime
> > > > > > > selection.
> > > > > >
> > > > > > Oh, so here's the issue, we have both PHY variants, older hardware
> > > > > > generally has AC200 PHY's while newer ships AC300 PHY's, but
> > > > > > when I surveyed our deployed hardware using these boards many
> > > > > > systems of similar age would randomly mix AC200 and AC300 PHY's.
> > > > > >
> > > > > > It appears there was a fairly long transition period where both variants
> > > > > > were being shipped.
> > > > >
> > > > > Given that DT is supposed to describe the hardware that is being run on,
> > > > > it should _describe_ _the_ _hardware_ that the kernel is being run on.
> > > > >
> > > > > That means not enumerating all possibilities in DT and then having magic
> > > > > in the kernel to select the right variant. That means having a correct
> > > > > description in DT for the kernel to use.
> > > >
> > > > The approach I'm using is IMO quite similar to say other hardware
> > > > variant runtime detection DT features like this:
> > > > https://github.com/torvalds/linux/commit/157ce8f381efe264933e9366db828d845bade3a1
> > >
> > > That is for things link a HAT on a RPi. It is something which is easy
> > > to replace, and is expected to be replaced.
> >
> > Actually it's for second sourced components that are modules _within_
> > the device (a tablet or a laptop) that get swapped in at the factory.
> > Definitely not something easy to replace and not expected to be replaced
> > by the end user.
> 
> Yeah, to me it seems like the PHY situation is similar, it's not replaceable
> due to being copackaged, it seems the vendor just switched over to a
> second source for the PHY partway through the production run without
> distinguishing different SoC variants with new model numbers.
> 
> Keep in mind stmmac itself implements mdio PHY scanning already,
> which is a form of runtime PHY autodetection, so I don't really see
> how doing nvmem/efuse based PHY autodetection is all that different
> from that as both are forms of PHY runtime autodetection.

What is different is using "phys" and "phy-names" which historically
has never been used for ethernet PHYs. These have been used for serdes
PHYs (e.g. multi-protocol PHYs that support PCIe, SATA, and ethernet
protocols but do not provide ethernet PHY capability).

Historically, "phys" and "phy-names" have been the domain of
drivers/phy and not drivers/net/phy. drivers/net/phy PHYs have
been described using "phy-handle".

So, you're deviating from the common usage pattern, and I'm not sure
whether that has been made clear to the DT maintainers that that is
what is going on in this patch series.

As for the PHY scanning is a driver implementation issue; it doesn't
have any effect on device tree, it doesn't "abuse" DT properties to
do so. The PHY scanning is likely historical, probably from times
where the stmmac platform data was provided by board files (thus
having the first detected PHY made things simpler.) Therefore, I
don't think using it as a justification for more "autodetection"
stands up.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

