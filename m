Return-Path: <netdev+bounces-119405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3F7955785
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF401F21B8F
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8036149DE8;
	Sat, 17 Aug 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VyYjgXp8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0313BC35;
	Sat, 17 Aug 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894972; cv=none; b=aHmku645xACz7OTjloS4ZvEbNRCkJFYAhfvMab5X9cwbvQ90PZbLN1HHHZ2e+DWj5vwYX9Qas+4AjkrmYu7DAETjAkxHXUjyfj6kvQifaCxp65BhLJLZJop8ToVszi0xjDehdKvHKKWGtD7kRMLJVVlVMyGGoC9plfG720qfEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894972; c=relaxed/simple;
	bh=rxFQbgsli5u5X3yvibgECN7D5xxmrWak8vejPh2RtWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shuDJ/JiLSMh8sQVQHEkQQaxLjZMwDAgjkwWKXsZQa+lKXHa5IkElb4gmAno8OX+5qReDHVZ1FyTHA0mAQ5GavnqYKmbjFwvj8iPLgLxotpVFsHDNzcReLcnB8IXWbEZTdf1PVyAF8lYBSjvgMJUPKNh5tb7F0SluktksTzPJtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=VyYjgXp8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=odtZsN2r31c6Y4mLYHFwJQ8Ut4xfX0epn4tT7wnEwSo=; b=VyYjgXp82jchU/02GzL5t+NqEy
	CTQKSDso4x1pmwDO4AsDos+iJrE5U5WK8wAK80b7d/Qyu2/05+V5lGb/Yrh3pbfgO+tRwDVZbPOgB
	92MIiunCPIu2AyvVmVvP5ps6pBiK1zLRk/ac8L10yi1z6I/Elnu76P1CTjS5/3ZKC449dulFhow3h
	xWhMqBalZ7ZG+oOp6HWp0qdjOn4mS39WedXUVa1cBkVtQicWVTq/++9KkmkvWJhV3vTkIMHgqp1qj
	AlQygiJ4MHPnTbAXh+2XeWNIAafdHMYVkebpVNiEIcfV5YwUrRBqYgsHagm7xkJYBIKJAKRHj4Hkx
	6dQTmXpA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57076)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sfHpQ-0006pF-13;
	Sat, 17 Aug 2024 12:42:40 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sfHpU-00056a-SJ; Sat, 17 Aug 2024 12:42:44 +0100
Date: Sat, 17 Aug 2024 12:42:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: Ronnie.Kunin@microchip.com, netdev@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, andrew@lunn.ch, horms@kernel.org,
	hkallweit1@gmail.com, richardcochran@gmail.com,
	rdunlap@infradead.org, Bryan.Whitehead@microchip.com,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3 3/4] net: lan743x: Migrate phylib to phylink
Message-ID: <ZsCMtARGCOLsbF9h@shell.armlinux.org.uk>
References: <20240730140619.80650-1-Raju.Lakkaraju@microchip.com>
 <20240730140619.80650-4-Raju.Lakkaraju@microchip.com>
 <Zqj/Mdoy5rhD2YXx@shell.armlinux.org.uk>
 <ZqtrcRfRVBR6H9Ri@HYD-DK-UNGSW21.microchip.com>
 <Zqu3aHJzAnb3KDvz@shell.armlinux.org.uk>
 <PH8PR11MB79655D0005E227742CBA1A8A95B22@PH8PR11MB7965.namprd11.prod.outlook.com>
 <Zqyau+JjwQdzBNaI@shell.armlinux.org.uk>
 <PH8PR11MB796562D6C8964A6B6A1CC7E595B92@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZrUzkF8jj50ZgGhk@shell.armlinux.org.uk>
 <Zr+OsygS+YRkRnL6@HYD-DK-UNGSW21.microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr+OsygS+YRkRnL6@HYD-DK-UNGSW21.microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 16, 2024 at 11:08:59PM +0530, Raju Lakkaraju wrote:
> Hi Russell King,
> 
> Thank you for quick response.
> 
> The 08/08/2024 22:07, Russell King (Oracle) wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Thu, Aug 08, 2024 at 08:23:38PM +0000, Ronnie.Kunin@microchip.com wrote:
> > > We looked into an alternate way to migrate our lan743x driver from phylib to phylink continuing to support our existing hardware out in the field, without using the phylib's fixed-phy approach that you opposed to, but without modifying the phylib framework either.
> > > While investigating how to implement it we came across this which Raju borrowed ideas from: https://lore.kernel.org/linux-arm-kernel/YtGPO5SkMZfN8b%2Fs@shell.armlinux.org.uk/ . He is in the process of testing/cleaning it up and expects to submit it early next week.
> > 
> > That series died a death because it wasn't acceptable to the swnode
> > folk. In any case, that's clearly an over-complex solution for what is
> > a simple problem here.
> > 
> > The simplest solution would be for phylink to provide a new function,
> > e.g.
> > 
> > int phylink_set_fixed_link(struct phylink *pl,
> >                            const struct phylink_state *state)
> > {
> >         const struct phy_setting *s;
> >         unsigned long *adv;
> > 
> >         if (pl->cfg_link_an_mode != MLO_AN_PHY || !state ||
> >             !test_bit(PHYLINK_DISABLE_STOPPED, &pl->phylink_disable_state))
> >                 return -EINVAL;
> > 
> >         s = phy_lookup_setting(state->speed, state->duplex,
> >                                pl->supported, true);
> >         if (!s)
> >                 return -EINVAL;
> > 
> >         adv = pl->link_config.advertising;
> >         linkmode_zero(adv);
> >         linkmode_set_bit(s->bit, adv);
> >         linkmode_set_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, adv);
> > 
> >         pl->link_config.speed = state->speed;
> >         pl->link_config.duplex = state->duplex;
> >         pl->link_config.link = 1;
> >         pl->link_config.an_complete = 1;
> > 
> >         pl->cfg_link_an_mode = MLO_AN_FIXED;
> >         pl->cur_link_an_mode = pl->cfg_link_an_mode;
> > 
> >         return 0;
> > }
> > 
> > You can then call this _instead_ of attaching a PHY to switch phylink
> > into fixed-link mode with the specified speed and duplex (assuming
> > they are supported by the MAC.)
> > 
> > Isn't this going to be simpler than trying to use swnodes that need
> > to be setup before phylink_create() gets called?
> > 
> 
> Your suggestion seems to be working well for us. I'm currently testing it on
> different boards and checking for corner cases.
> I plan to submit it for code review next week.
> 
> Quick question: Should I submit your suggested code along with our patches, or
> will you be submitting it separately?

Note the point in my signature, which means I won't be doing very much
likely for through the rest of August and - given the timeline I expect,
nothing at all through much of September.

So, please include it as a separate patch with my authorship. You'll
need to add a prototype to linux/phylink.h for it as well. I'm giving
you explicit permission to add my sign-off for such a patch. Thanks.

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

