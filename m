Return-Path: <netdev+bounces-238677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E7AC5D771
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 15:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC87434ADF1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87CE31C595;
	Fri, 14 Nov 2025 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="vfU0gKvS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE02F31BCA4
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128712; cv=none; b=rp2f2rWQfZrUtbxiewkCPS3fA1CCTC9ySJqQ5Y32XG660LnTaIxOZ5OW7w/K85NUM5V5tP1NhB6My032xekDPPUPe/h4rB/rZH1Jm6CNcuZ4q6HT+w2luWu0aggtwxrvQ6uYGc2c5SoNRH6V7MRCV/YtWBXIwUAPwSKSEgufhfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128712; c=relaxed/simple;
	bh=RtzQFfjPAzangbiodWHMnNaIZGuBL3zeXgZRurVswBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETz4ZdPPduXuXZOI6E3dv7zlrpsmEecVSeqqpgbm/IwxOc9HDMPIyw1mrR5FnMK2l93agRkp7jbVUHl5Kcatss8PyfinTqq4n4z9dOIXG3XuWNItZXitjmwXZBeDCJmmHrWS8aE/UF11HA4AD8Z3t4TIWHqw6U2xXoOpS22f4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=vfU0gKvS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lPOwklkCGtez7a9SRfMbUWXkwlNFM50+PMIKsxzKfOk=; b=vfU0gKvSuJS6wHtgR029QHVKYo
	U+xqTYYrX96F4jtrX3FxTB+xSK/WL766fz0zKECAILprBHGgk2RY9PH44mDm1Jn+f/D//1Nkhpxyr
	2+tGpQwroSECOKmiOFavGPyX25yybvGo8AtMbXCor1GxMg/KUm10lkgh58v60h3WyNp4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vJuJY-00Dz1V-G8; Fri, 14 Nov 2025 14:58:12 +0100
Date: Fri, 14 Nov 2025 14:58:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Trager <lee@trager.us>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Susheela Doddagoudar <susheelavin@gmail.com>,
	netdev@vger.kernel.org, mkubecek@suse.cz,
	Hariprasad Kelam <hkelam@marvell.com>,
	Alexander Duyck <alexanderduyck@fb.com>
Subject: Re: Ethtool: advance phy debug support
Message-ID: <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com>
 <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us>

> I have PRBS testing and configuring TX coefficent support working in an
> internal version of the fbnic driver. The problem is the interface. Right
> now I'm using DebugFS, my understanding is write access in DebugFS is
> frowned upon which is why it hasn't been up streamed yet. My original idea
> was to extend ethtool, similar to what Susheela suggested, to add support
> but I got some push back on that at netdev.

I would say ethtool is the correct API to use. At minimum it needs to
be netlink.

> I received the suggestion that
> this is really something that should be part of the phy subsystem which
> would require a new tool to be written.

phylib uses netlink/ethtool, e.g. cable test is purely in phylib, and
it uses ethtool. ethtool also has --set-phy-tunable, --get-phy-tunable,
--phy-statistics, etc.

Also, PRBS is not just a PHY thing, 802.3 defines it as part of the
PCS, and i don't see why a MAC could also implement it, not that i
have seen such a thing.

And maybe other networking technologies also have something like PRBS?
Is there an 802.11 equivalent, used for testing the analogue front
end? CAN?

> 
> Alex had started to onboard fbnic to phy as part of his work to onboard
> fbnic to phylink. My understanding is that Alex was recently asked to not
> use the phy subsystem. So the question is where does this go? What user
> space tool interacts with the API?

Linux's understanding of a PHY is a device which takes the bitstream
from the MAC and turns it into analogue signals on twisted pairs,
mostly for an RJ45 connector, but automotive uses other
connectors. Its copper, and 802.3 C22 and parts of C45 define how such
a PHY should work. There is a second use case, where a PHY converts
between say RGMII and SGMII, but it basically uses the same registers.

fbnic is not copper. It has an SFP cage. Linux has a different
architecture for that, MAC, PCS and SFP driver. Alex abused the design
and put a PHY into it as a shortcut. It not surprising there was push
back.

So, i still think ethtool is the correct API. In general, that
connects to the MAC driver, although it can shortcut to a PHY
connected to a MAC. But such a short cut has caused issues in the
past. So i would probably not do that. Add an API to phylink, which
the MAC can use. And an API to the PCS driver, which phylink can
use. And for when the PHY implements PRBS, add an API to phylib and
get phylib to call the PHY driver.

I'm not saying you need to implement all that, just the bits you need
for a PCS packet generator. But lay out the architecture such that it
can be extended with packet generators in other places.
 
> > For PRBS pattern tests testing i think there needs to be a framework
> > around it.
> > 
> > When you enable testing, the netif becomes usable, so its state needs
> > changing to "under test" as defined in RFC2863. We ideally want it
> > revert to normal operation after a time period. There are a number of
> > different PRBS patterns, so you need to be able to select one, and
> > maybe pass the test duration. It can also be performed in different
> > places. 802.3 defines a number of registers in the PCS for this. I
> > would expect to see a library that any standards conforming PCS can
> > use. There are also PHYs which support this features, but each vendor
> > implements it differently, so we need some sort of generic API for
> > PHYs. I expect we will also end up with a set of netlink message,
> > similar to how cable testing working.
> 
> Nothing can touch the comphy while PRBS testing is running. The fbnic driver
> rejects starting testing if the link is up.

That actually seems odd to me. I assume you need to set the link mode
you want. Having it default to 10/Half is probably not what you
want. You want to use ethtool_ksettings_set to force the MAC and PCS
into a specific link mode. Most MAC drivers don't do anything if that
call is made when the interface is admin down. And if you look at how
most MAC drivers are structured, they don't bind to phylink/phylib
until open() is called. So when admin down, you don't even have a
PCS/PHY. And some designs have multiple PCSes, and you select the one
you need based on the link mode, set by ethtool_ksettings_set or
autoneg. And if admin down, the phylink will turn the SFP laser off.

> When I spoke with test engineers internally in Meta I could not come up with
> a time period and over night testing came up as a requirement. I decided to
> just let the user start and stop testing with no time requirement. If
> firmware loses the host heartbeat it automatically disables PRBS testing.

O.K. So i would probably go for a blocking netlink call, and when ^C
is used, to exits PRBS and allows normal traffic. You then need to
think about RTNL, which you cannot hold for hours.

	Andrew

