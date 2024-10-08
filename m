Return-Path: <netdev+bounces-133167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0280A99529A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F8D1F2297D
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F461DF998;
	Tue,  8 Oct 2024 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KXdzmkXR"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE91DDDC;
	Tue,  8 Oct 2024 14:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399473; cv=none; b=F14L8DEMiR/OBdfTCOPGrjgfDCGygKEaMnjSA8cZnSUnHCWBcQCk6Wr7o2iadJIRJWaiPOcQ1kiJ2Sg5+4JKbZ8ELMm8t0mYYeUDdOBfyBGNDE5LcpyaYBlILhVFGriQdUMsx8p+pjMSISHBOOXYZ8Twm9TVzxcd7B6TG72NINk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399473; c=relaxed/simple;
	bh=uQbrUZhdL7Of+AWNbFwR1OBlXOpAm1/L9nYDzNP/DbY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFrr7efDVrk2e8Q6fixR9+Z+SQOMUSFtjqTneEArzYwByH6fwe0U8t5h9MLINBuBYuDjXBjpY8keR7hq/G+Hm4AQGxxQXx+oLvT0Ob4V43IYKMdIIDbBGqZisW+5IbOHQfgWYjKcY43g7er9lvt8RQYJz4pJFKrakAE7qBI7r44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KXdzmkXR; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37622FF80C;
	Tue,  8 Oct 2024 14:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728399469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uB1b35olEARgImOYJ2aTic64hN7fMke7/SA61OC6r4A=;
	b=KXdzmkXRCv70JRDdsDNDP4msb3672nMfZ2s7nOfSHdk9Vuz63Q6YqBcSQEx7SbfC/z0OCz
	U6gQLnmDmLbBU4EBT5zOyZhdIN7nTvu1Lw/S7FFJIb5pBEBW42ws7zwCP8lzyEjinTxJcU
	7PtmLFjqAJxo4+0qb9Rk5+oNeK8BAwiOCtd1XUn6q71UceyYG99Wpx2aOAymXNLEx+sw9y
	F/5epLGYSOnXFUDLXkOYAveOMLyivIV29iHjx5ij1pt1k7gRKgaVB/nCD1REjL9HyE0rre
	nR0YcybpdPu9NqcHjcYHaygp792pevXy6WRBXFnxj60IHviuP4jtiGFlv4B+Rw==
Date: Tue, 8 Oct 2024 16:57:42 +0200
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
Message-ID: <20241008165742.71858efa@device-21.home>
In-Reply-To: <f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<20241004161601.2932901-8-maxime.chevallier@bootlin.com>
	<4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
	<ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
	<20241007123751.3df87430@device-21.home>
	<6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
	<20241007154839.4b9c6a02@device-21.home>
	<b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
	<20241008092557.50db7539@device-21.home>
	<f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
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

On Tue, 8 Oct 2024 15:00:53 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > > So you have at least regulators under Linux control? Is that what you
> > > mean by power down? Pulling the plug and putting it back again is
> > > somewhat different to isolation. All its state is going to be lost,
> > > meaning phylib needs to completely initialise it again. Or can you
> > > hide this using PM? Just suspend/resume it?  
> > 
> > Ah no, I wasn't referring to regulators but rather the BMCR PDOWN bit to
> > just shut the PHY down, as in suspend.  
> 
> Ah! I wounder what 802.3 says about PDOWN? Does it say anything about
> it being equivalent to ISOLATE? That the pins go HI-Z? Are we talking
> about something semi-reliable, or something which just happens to work
> for this PHY?

The spec doesn't say anything about hi-z on the MII for power-down, it
simply says (22.2.4.1.5 Power down) :

"During the transition to the power-down state and while
in the power-down state, the PHY shall not generate spurious
signals on the MII or GMII"

So my best guess is that it just happens to work for this PHY. It won't
work for serdes links for the same reasons as the isolate mode I guess,
reflections would make it too unstable ?

> > Indeed the state is lost. The way I'm supporting this is :
> > 
> >  - If one PHY has the link, it keeps it until link-down
> >  - When link-down, I round-robin between the 2 phys: 
> > 
> >   - Attach the PHY to the netdev
> >   - See if it can establish link and negotiate with LP
> >   - If there's nothing after a given period ( 2 seconds default ), then
> > I detach the PHY, attach the other one, and start again, until one of
> > them has link.  
> 
> This sounds pretty invasive to the MAC driver. I don't think you need
> to attach/detach each cycle, since you don't need to send/receive any
> packets. You could hide this all in phylib. But that should be
> considered as part of the bigger picture.

Sure, that's what I came-up with so far but that's indeed an implem
problem.

> 
> I assume it is not actually 2 seconds, but some random number in the
> range 1-3 seconds, so when both ends are searching they do eventually
> find each other?

Oleksji pointed that out to me at LPC, that makes sense indeed.

> 
> > > That explains the hardware, but what are the use cases? How did the
> > > hardware designer envision this hardware being used?  
> > 
> > The use-case is link redundancy, if one PHY loses the link, we hope
> > that we still have link on the other one and switchover. This is one of
> > the things I discussed at netdev 0x17.  
> 
> > > If you need to power the PHY off, you cannot have dynamic behaviour
> > > where the first to have link wins. But if you can have the media side
> > > functional, you can do some dynamic behaviours.  
> > 
> > True.
> >   
> > > Although, is it wise
> > > for the link to come up, yet to be functionally dead because it has no
> > > MAC connected?  
> > 
> > Good point. What would you think ? I already deal with the identified
> > issue which is that both PHYs are link-up with LP, both connected to
> > the same switch. When we switch between the active PHYs, we send a
> > gratuitous ARP on the new PHY to refresh the switch's FDB.  
> 
> It seems odd to me you have redundant cables going to one switch? I
> would have the cables going in opposite directions, to two different
> switches, and have the switches in at a minimum a ring, or ideally a
> mesh.
> 
> I don't think the ARP is necessary. The link peer switch should flush
> its tables when the link goes down. But switches further away don't
> see such link events, yet they learn about the new location of the
> host. I would also expect the host sees a loss of carrier and then the
> carrier restored, which probably flushes all its tables, so it is
> going to ARP anyway.

While I would agree with you on the theory, while testing we discovered
that sending that ARP was necessary to reliably update the switch's
tables :/

This is also what bonding does in active-backup mode.

> > 
> > Do you see that as being an issue, having the LP see link-up when the
> > link cannot actually convey data ? Besides the energy detect feature
> > you mention, I don't see what other options we can have unfortunately :(  
> 
> Maybe see what 802.3 says about advertising with no link
> modes. Autoneg should complete, in that the peers exchange messages,
> but the result of the autoneg is that they have no common modes, so
> the link won't come up. Is it clearly defined what should happen in
> this case? But we are in a corner case, similar to ISOLATE, which i
> guess rarely gets tested, so is often broken. I would guess power
> detection would be more reliable when implemented. 

I'll need to perform further tests on that, I haven't looked into
energy detect. Let me take a look :)

> > > There are some Marvell Switches which support both internal Copper
> > > PHYs and a SERDES port. The hardware allows first to get link to have
> > > a functional MAC. But in Linux we have not supported that, and we
> > > leave the unused part down so it does not get link.  
> > 
> > My plan is to support these as well. For the end-user, it makes no
> > difference wether the HW internally has 2 PHYs each with one port, or 1
> > phy with 2 ports. So to me, if we want to support phy_mux, we should
> > also support the case you mention above. I have some code to support
> > this, but that's the part where I'm still getting things ironed-out,
> > this is pretty tricky to represent that properly, especially in DT.
> >   
> > >
> > > Maybe we actually want energy detect, not link, to decide which PHY
> > > should get the MAC?  But i have no real idea what you can do with
> > > energy detect, and it would also mean building out the read_status()
> > > call to report additional things, etc.  
> > 
> > Note that I'm trying to support a bigger set of use-cases besides the
> > pure 2-PHY setup. One being that we have a MUX within the SoC on the
> > SERDES lanes, allowing to steer the MII interface between a PHY and an
> > SFP bus (Turris Omnia has such a setup). Is it possible to have an
> > equivalent "energy detect" on all kinds of SFPs ?  
> 
> The LOS pin, which indicates if there is light entering the SFP.
> 
> > As a note, I do see that both Russell and you may think you're being
> > "drip-fed" (I learned that term today) information, that's not my
> > intent at all, I wasn't expecting this discussion now, sorry about that.  
> 
> It is a difficult set of problems, and you are addressing it from the
> very niche end first using mechanisms which i expect are not reliably
> implemented. So we are going to ask lots of questions.

There's absolutely no problem with that :)

> You probably would of got less questions if you have started with the
> use cases for the Turris Omnia and Marvell Ethernet switch, which are
> more mainstream, and then extended it with your niche device. But i
> can understand this order, you probably have a customer with this
> niche device...

Oh but I plan to add support for the marvell switch, mcbin, and turris
first, as these boards are somewhat easily accessible and allows
converging towards a proper kAPI for that without relying on the boards
only I and a few other folks have.

That's another can of worms though :)

Maxime


