Return-Path: <netdev+bounces-238901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC9BC60CB1
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 00:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F33C3AD2B8
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 23:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93121CC68;
	Sat, 15 Nov 2025 23:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XyhNtvsw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470818EAB
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 23:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763249234; cv=none; b=n84+uqi4S2d4sanO+Mt0DnokiQM7go/vO/9kujS0jyBO9RTWKwTxc4hWe1p5xygvv8hcvpsA37JJAPeFYMnq8KOPOuBcNOjU1izW+NFvS6IgvvJjgmHeHrvODz53K9y+AWB24ut8pgs5fYIFZYs2lfa4o8BDUKdVgKakmeY6Bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763249234; c=relaxed/simple;
	bh=5SIkcrHpVfQkJCfOim36ZGxZeZZvIIcbhm65bidYmJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFpmqIou1mRROoB/vaZtpoHg/IWThU8g0mWyCMWfLcJYsPeZJPMdIQpYUlKMwoTpzaDmfKrdxmAbMDQ4d8IHfqzaESnsCxeQ/FGagWnyGCFdEgLZrrHvYhvYN4Ww0Vksq8JlKVsAhCjKcaIYGvv5un8xGkMZ4f+Z7oDj+iwYeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XyhNtvsw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5X8suHKD8ooe7QZd86ThpOqubLlZ+yx/kWOd+TWEfu4=; b=XyhNtvswwzkZxAUPrju/tJERo5
	WzBPjzJpLjPqxYRZuSLH9yj0024x+Xxs/Cxi5maTqEz2EiKm9qIHliJCN+yxnrbY4xvTnnyC9qa3r
	wFIG97CDA644Q8savKvkrT/N+SJsblwdATlWzdor2Mo8mPfg8ia/JW7DnvqxGrs2//qo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vKPfc-00E7VI-9I; Sun, 16 Nov 2025 00:27:04 +0100
Date: Sun, 16 Nov 2025 00:27:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Trager <lee@trager.us>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Susheela Doddagoudar <susheelavin@gmail.com>,
	netdev@vger.kernel.org, mkubecek@suse.cz,
	Hariprasad Kelam <hkelam@marvell.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: Ethtool: advance phy debug support
Message-ID: <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>

> PRBS testing can be used as a signal integrity test between any two end
> points, not just networking. For example we have CSRs to allow PRBS testing
> on PCIE with fbnic. My thought was always to limit the scope to network use
> case. The feedback I received at Netdev was we need to handle this
> generically for any phy, thus the suggestion to do this on phy. That adds a
> ton of complexity so I'd be supportive to narrow this down to just
> networking and leverage ethtool.

We need to be careful with terms here. We have PHYs driven by phylib,
bitstreams to signals on twisted pairs, drivers/net/phy

And we have generic PHYs, which might contain a SERDES, for PCIE,
SATA, USB, /drivers/phy.

Maxime reference to comphy for Marvell is a generic PHY, and they do
implement SATA, USB and networking.

Having said that, i don't see why you should not narrow it down to
networking, and ethtool. It might well be Marvell MAC drivers could
call into the generic PHY, and the API needed for that should be
reusable for anybody wanting to do testing of PCIE via a PRBS within a
generic PHY.

As i said before, what is important is we have an architecture that
allows for PRBS in different locations. You don't need to implement
all those locations, just the plumbing you need for your use case. So
MAC calling phylink, calling into the PCS driver. We might also need
some enumeration of where the PRBSes are, and being able to select
which one you want to use, e.g. you could have a PCS with PRBS, doing
SGMII connecting to a Marvell PHY which also has PRBS.

> > That actually seems odd to me. I assume you need to set the link mode
> > you want. Having it default to 10/Half is probably not what you
> > want. You want to use ethtool_ksettings_set to force the MAC and PCS
> > into a specific link mode. Most MAC drivers don't do anything if that
> > call is made when the interface is admin down. And if you look at how
> > most MAC drivers are structured, they don't bind to phylink/phylib
> > until open() is called. So when admin down, you don't even have a
> > PCS/PHY. And some designs have multiple PCSes, and you select the one
> > you need based on the link mode, set by ethtool_ksettings_set or
> > autoneg. And if admin down, the phylink will turn the SFP laser off.
> 
> fbnic does not currently support autoneg

autoneg does not really come into this. Yes, ksettings_set can be used
to configure what autoneg offers to the link partner. But if you call
ksettings_set with the autoneg parameter set to off, it is used to
directly set the link mode. So this is going to be the generic way you
set the link to the correct mode before starting the test.

fbnic is actually very odd in that the link mode is hard wired at
production time. I don't know of any other device that does
that. Because fbnic is odd, while designing this, you probably want to
ignore it, consider 'normal' devices making use of the normal
APIs. Maybe go buy a board using stmmac and the XPCS_PCS driver, so
you have a normal system to work on? And then make sure the oddball
fbnic can be somehow coerced to do the right thing like normal
devices.

> > > When I spoke with test engineers internally in Meta I could not come up with
> > > a time period and over night testing came up as a requirement. I decided to
> > > just let the user start and stop testing with no time requirement. If
> > > firmware loses the host heartbeat it automatically disables PRBS testing.
> > O.K. So i would probably go for a blocking netlink call, and when ^C
> > is used, to exits PRBS and allows normal traffic. You then need to
> > think about RTNL, which you cannot hold for hours.
> RTNL() is only held when starting testing, its released once testing has
> begun. We could set a flag on the netdev to say PRBS testing is running,
> don't do anything else with this device until the flag is reset.

Its the ^C bit which makes it interesting. The idea is used other
places in the stack. mrouted(1) and the kernel side for multicast
routing does something similar. So long at the user space daemon holds
the socket open, the kernel maintains the multicast routing
cache. Once the socket is closed, because the daemon as died/exited,
the kernel flushes the cache. But this is an old BSD sockets
behaviour, not netlink sockets. I've no idea if you can do the same
with netlink, get a notification when a process closes such a socket.

	Andrew

