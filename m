Return-Path: <netdev+bounces-239557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BF2C69BA2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D8B9038741C
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B43590A3;
	Tue, 18 Nov 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gOU0Moux"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7135A948
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473855; cv=none; b=oJpjq8PFa/a9XOdXg5rWVaEqRmHmR4KIJd0HnXQDQwpkc28MLeCU6cZGqTGBqNTn8ptNSASWlN+8KdrHcD57raypEe3UzELas+Et5rNobShZ+Eo5E3pu2thtvNRI24TXUeiu9EUw+O3YhNPrbLiJF2CwiwospTLCobU+cRAIUHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473855; c=relaxed/simple;
	bh=y7/K4goWitQnjGt6rQWX5T3/zWKYEM/eQanLE9dJWO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0gdXQ4fTJ+UFx2bJlzMNbQqtPaFZM0hIek12TeVoIDPT414O9NgiG+BpqHGTngOwy15oFiwHI3/+ZJIgrmSoI7mywQQqzJdQnIbR9tBOFjT9qyw/8ttJqMxbdpj20UyI0sfT2a3B6KuruGPFqoJ5W8XzoNLHYdbCtFX8N8NQMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gOU0Moux; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=//SwCgfiIZvNj0Mg0En9h4YXKpn27wFP8YJOCeIrWgM=; b=gOU0Mouxd1HBEoYGjIpj+IJIkY
	ITlm0+2/lvGHdqt/UORn4gVxb3lOWROPPQulMfJZB9JC2OFU7KsEP9d5L5XnkBUS6T9U7Xr00MX8N
	ydqvnKTmZqlvzc1qsu0g6F/uJo2aEtyNGNcrC5r3m5exYb9WHqOmwdfI4PbwsgdAd0ak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vLM6L-00ELue-U0; Tue, 18 Nov 2025 14:50:33 +0100
Date: Tue, 18 Nov 2025 14:50:33 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander H Duyck <alexander.duyck@gmail.com>
Cc: Lee Trager <lee@trager.us>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Susheela Doddagoudar <susheelavin@gmail.com>,
	netdev@vger.kernel.org, mkubecek@suse.cz,
	Hariprasad Kelam <hkelam@marvell.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: Ethtool: advance phy debug support
Message-ID: <e38b51f0-b403-42b0-a8e5-8069755683f6@lunn.ch>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
 <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <399ca61a-abf0-4b37-af32-018a9ef08312@trager.us>
 <2fcc7d12-b1cf-4a24-ac39-a3257e407ef7@lunn.ch>
 <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b7f0ce90f17bd0168cbf3192a18b48cdabfa14b.camel@gmail.com>

> > As i said before, what is important is we have an architecture that
> > allows for PRBS in different locations. You don't need to implement
> > all those locations, just the plumbing you need for your use case. So
> > MAC calling phylink, calling into the PCS driver. We might also need
> > some enumeration of where the PRBSes are, and being able to select
> > which one you want to use, e.g. you could have a PCS with PRBS, doing
> > SGMII connecting to a Marvell PHY which also has PRBS.
> 
> It seems to me like we would likely end up with two different setups.
> For the SerDes PHYs they would likely end up with support for many more
> test patterns than a standard Ethernet PHY would.
> 
> I know I had been looking at section 45.2.1.168 - 45.2.1.174 of the
> IEEE 802.3 spec as that would be the standard for a PMA/PMD interface,
> or section 45.2.3.17 - 45.2.3.20 for the PCS interface, as to how to do
> this sort of testing on Ethernet using a c45 PHY. I wonder if we
> couldn't use those registers as a general guide for putting together
> the interface to enable the PHY testing with the general idea being
> that the APIs should translate to similar functionality as what is
> exposed in the IEEE spec.

It probably needs somebody to look at the different PRBS and see what
is common and what is different. 802.3 is a good starting point.
If you look around you can find some Marvell documents:

https://www.mouser.com/pdfDocs/marvell-phys-transceivers-alaska-c-88x5113-datasheet-2018-07.pdf
https://www.marvell.com/content/dam/marvell/en/public-collateral/phys-transceivers/marvell-phys-transceivers-alaska-m-88e21x0-datasheet.pdf
https://www.marvell.com/content/dam/marvell/en/public-collateral/phys-transceivers/marvell-phys-transceivers-alaska-x-88x2222-datasheet.pdf

And there are other vendors:

https://www.ti.com/lit/ds/symlink/dp83tc811r-q1.pdf

But we should also make use of the flexibility of netlink. We can
probably get a core set of attributes, but maybe also allow each PRBS
to make use of additional attributes?

> It isn't so much hard wired as limited based on the cable connected to
> it. In addition the other end doesn't do any sort of autoneg.

For PRBS, i doubt you want negotiation. Do you actually have a link
partner? Or it is some test equipment? If you are tuning SERDES
windows/eyes, you have to assume you are going to make the link worse,
before it gets better, and so autoneg will fail. So i expect the
general case of anybody using PRBS is going to want to use 'ethtool -s
autoneg off' to force the system into a specific mode.

> As far as the testing itself, we aren't going to be linking anyway. So
> the configured speed/duplex won't matter.

I'm surprised about that. Again, general case, would a 1G 1000baseX
allow/require different tuning to a 2500BaseX link? It is clocked at a
different frequency? Duplex however is probably not an issue, does an
SGMII SERDES running at 100Half even look different to a 100Full? The
SERDES always runs at the same speed, 10/100 just require symbol
duplication to full the stream up to 1G. And link modes > 1G don't
have a duplex setting.

> When we are testing either
> the PCS or the PMA/PMD is essentially running the show and everything
> above it is pretty much cut off. So the MAC isn't going to see a link
> anyway. In the grand scheme of things it is basically just a matter of
> setting up the lanes and frequency/modulation for those lanes.

And the kernel API for that, at the top level is ksettings_set(). I
agree the MAC is not sending packets etc, but it is the one
configuring everything below it, via phylink/phylib or firmware. Is
there really any difference between a real configuration and a PRBS
configuration for testing a link mode?

And then we need a second API to access whatever you want to tune,
which i guess is vendor specific. As far as i remember, Lee's basic
design did separate this into a different API after looking around at
what different vendors provided.

> This is one of the reasons why I was thinking of something like a
> phydev being provided by the driver. Specifically it provides an
> interface that can be inspected by a netdev via standard calls to
> determine things like if the link is allowed to come up. In the case of
> the phydev code it already had all the bits in place for PHY_CABLETEST
> as a state.

And this is why i talked about infrastructure, or core for PRBS,
something which can deal with a netdev state transitions. A don't see
a phydev as a good representation of a PRBS. We probably want a PRBS
'device' which can be embedded in a phydev, or a PCS, or a generic
PHY, which registers itself to the PRBS core, and it is associated to
a netdev.

	Andrew

