Return-Path: <netdev+bounces-132985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C19993FA5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DE71F21E71
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F41DEFC8;
	Tue,  8 Oct 2024 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N9OPW9gh"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B6C1DE4F3;
	Tue,  8 Oct 2024 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728372364; cv=none; b=fTUp2d7vCJwtjPuyc5221PuYDnuDCHYlP6UMceqSOR7mMAnD8SY/SYhA7+Lj6gTYnj5OMweJSSUyUb+NqrJgiyQtFwubp9e+dOgo6QOrK2tsqghDIA03L9CemF0UsLhFiau1VixEWyadbm1rVSCdhQgGXtQZHt+Ryf63K/fTmt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728372364; c=relaxed/simple;
	bh=z2P9eJzMxO7Wy9K/gU2Ripg7WG5/Qq2PJ4dUe+DraPA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEeTQkLFEN4dLqN9SiJgjxCD1oArLe9n6TZ/LX4FfBO+840RX1UCc/C793rxXs/fNMN0C0kP33ucIlAj2yQlbHwq8fCAp5psP8CNL4fAtwpjKhhGBAfs2ICdIMQCSGNRAiMRBCzG1kkKzB2PfYmA9IJ/CSV8s6ddkdnhTtlSXfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N9OPW9gh; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 12AFEE0004;
	Tue,  8 Oct 2024 07:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728372359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y2Eov6yFpaMhBa+zRN8cKs/RYWnxfaxocRnMjKu5r/s=;
	b=N9OPW9ghUApwMwLVnBcXpiSVmIgOeRi3NcixPpyq4UcWVz5fFLn4G4h9bokE7Y6jyFjjBd
	hSqsmYbjS7UV/w8MAhFrSxDEYtH32oLyhnZV3Bk2CT1dRCXBUKFzKbQKbXM4ujMGYGqWwC
	y24XT12GTiJV7hp786Lms6QgpfX4Mq4YXVo7w4BP3NObjCerBqFZiSMWO2n4rjnUHRTs09
	tHPj2IGrvMCbPFlG3VzxGzhFx/ICzGbmChQTsZWXTxbyulPn7PfWBz0X1JvxdYnz3gl7l5
	lIk3tOl/KBhGeCBkPgWpAVNMbuupDN8LGJmfgMcNniwMgKBbFzW4nzZZM+WNMg==
Date: Tue, 8 Oct 2024 09:25:57 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <20241008092557.50db7539@device-21.home>
In-Reply-To: <b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<20241004161601.2932901-8-maxime.chevallier@bootlin.com>
	<4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
	<ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
	<20241007123751.3df87430@device-21.home>
	<6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
	<20241007154839.4b9c6a02@device-21.home>
	<b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 7 Oct 2024 18:37:29 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > That's a legit point. I mentioned in the cover for V1 that this in
> > itself doesn't really bring anything useful. The only point being that
> > it makes it easy to test if a PHY has a working isolation mode, but
> > given that we'll assume that it doesn't by default, that whole point
> > is moot.
> > 
> > I would therefore understand if you consider that having a kAPI for
> > that isn't very interesting and that I shall include this work as part
> > of the multi-PHY support.  
> 
> kAPI add a lot of Maintenance burden. So we should not add them unless
> they are justified. to me, there is not a good justification for this.

That's fine by me.

> 
> > Sure thing. There are multiple devices out-there that may have multiple
> > PHYs accessible from the MAC, through muxers (I'm trying to be generic
> > enough to address all cases, gpio muxers, mmio-controlled muxers, etc.),
> > but let me describe the HW I'm working on that's a bit more problematic.
> > 
> > The first such platform I have has an fs_enet MAC, a pair of LXT973
> > PHYs for which the isolate mode doesn't work, and no on-board circuitry to
> > perform the isolation. Here, we have to power one PHY down when unused :
> > 
> >                 /--- LXT973
> > fs_enet -- MII--|
> >                 \--- LXT973  
> 
> So you have at least regulators under Linux control? Is that what you
> mean by power down? Pulling the plug and putting it back again is
> somewhat different to isolation. All its state is going to be lost,
> meaning phylib needs to completely initialise it again. Or can you
> hide this using PM? Just suspend/resume it?

Ah no, I wasn't referring to regulators but rather the BMCR PDOWN bit to
just shut the PHY down, as in suspend.

Indeed the state is lost. The way I'm supporting this is :

 - If one PHY has the link, it keeps it until link-down
 - When link-down, I round-robin between the 2 phys: 

  - Attach the PHY to the netdev
  - See if it can establish link and negotiate with LP
  - If there's nothing after a given period ( 2 seconds default ), then
I detach the PHY, attach the other one, and start again, until one of
them has link.

That's very limited indeed, we have no way of saying "first that has
link wins".


> > The second board has a fs_enet MAC and a pair of KSZ8041 PHYs connected
> > in MII.
> > 
> > The third one has a pair of KSZ8041 PHYs connected to a
> > ucc_geth MAC in RMII.
> > 
> > On both these boards, we isolate the PHYs when unused, and we also
> > drive a GPIO to toggle some on-board circuitry to disconnect the MII
> > lines as well for the unused PHY. I'd have to run some tests to see if
> > this circuitry could be enough, without relying at all on PHY
> > isolation :
> > 
> >                    /--- KSZ8041
> >                    |
> >       MAC ------ MUX
> >                  | | 
> >   to SoC <-gpio--/ \--- KSZ8041
> > 
> > 
> > One point is, if you look at the first case (no mux), we need to know
> > if the PHYs are able to isolate or not in order to use the proper
> > switching strategy (isolate or power-down).  
> 
> That explains the hardware, but what are the use cases? How did the
> hardware designer envision this hardware being used?

The use-case is link redundancy, if one PHY loses the link, we hope
that we still have link on the other one and switchover. This is one of
the things I discussed at netdev 0x17.

> If you need to power the PHY off, you cannot have dynamic behaviour
> where the first to have link wins. But if you can have the media side
> functional, you can do some dynamic behaviours.

True.

> Although, is it wise
> for the link to come up, yet to be functionally dead because it has no
> MAC connected?

Good point. What would you think ? I already deal with the identified
issue which is that both PHYs are link-up with LP, both connected to
the same switch. When we switch between the active PHYs, we send a
gratuitous ARP on the new PHY to refresh the switch's FDB.

Do you see that as being an issue, having the LP see link-up when the
link cannot actually convey data ? Besides the energy detect feature
you mention, I don't see what other options we can have unfortunately :(

> There are some Marvell Switches which support both internal Copper
> PHYs and a SERDES port. The hardware allows first to get link to have
> a functional MAC. But in Linux we have not supported that, and we
> leave the unused part down so it does not get link.

My plan is to support these as well. For the end-user, it makes no
difference wether the HW internally has 2 PHYs each with one port, or 1
phy with 2 ports. So to me, if we want to support phy_mux, we should
also support the case you mention above. I have some code to support
this, but that's the part where I'm still getting things ironed-out,
this is pretty tricky to represent that properly, especially in DT.

>
> Maybe we actually want energy detect, not link, to decide which PHY
> should get the MAC?  But i have no real idea what you can do with
> energy detect, and it would also mean building out the read_status()
> call to report additional things, etc.

Note that I'm trying to support a bigger set of use-cases besides the
pure 2-PHY setup. One being that we have a MUX within the SoC on the
SERDES lanes, allowing to steer the MII interface between a PHY and an
SFP bus (Turris Omnia has such a setup). Is it possible to have an
equivalent "energy detect" on all kinds of SFPs ?

As a note, I do see that both Russell and you may think you're being
"drip-fed" (I learned that term today) information, that's not my
intent at all, I wasn't expecting this discussion now, sorry about that.

I was saying to Russell that I would start a new thread, but we already
have a discussion going here, let me know if we shall continue the
discussion here or on a new thread.

Thanks,

Maxime

