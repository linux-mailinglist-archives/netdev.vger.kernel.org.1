Return-Path: <netdev+bounces-132966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D906993F4F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 09:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F0C1F23B82
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 07:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77C21DF735;
	Tue,  8 Oct 2024 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dEwTCqEn"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34BC14A0B8;
	Tue,  8 Oct 2024 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368944; cv=none; b=dieRtz0LJVHZbiQ9uKeKv9K9dtLXQ7LkEcBWaV2VVgCvlzGOnPLMVY/5G0+qH1IcCevpNYu1XufuZNVM4nxf7jwkHzDVXj58MEdNnTUji7hmK25IIq7mvnBG4wc709gLgOTiq8++oVnRs6X4NZHGph0YUJnxfZW1fhxZLyxzlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368944; c=relaxed/simple;
	bh=XfcCA7GBdsZVtnUU6+wVEgKZoMQ1JO+TzKlxKNhCcwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3u9GFQBDqGikjhwNqf8oHKonrdZM0HrDS+7U4OJ1JtdtRIS+voFMs+4reOtYeRRI/VOOCZ5mw3E1/gB77mBu/b5cVUGzjwDeV4KJBxBm/1VMFaimU+JNNTwiFZYlypJyZikD0JLVg6YSdyLQS4iCyevZl4kgtPkRsl/g2IajpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dEwTCqEn; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 49FC560002;
	Tue,  8 Oct 2024 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728368940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wMjB+ql8r09QyY3NNz0RWv1F2k3haxl0jC1S2UqOXoE=;
	b=dEwTCqEnJPizC1pSETrTjRK7qew2H+iFZgrzoSdQ+tZnKMgnaDNYU03GZp2ZxP3Yr7HR8J
	dNgx+7GMWC2PYEj5Di09COk3ODG4mBy2FmInVndSEv0CoTvpewESi1CZW21+dhEHKebIgs
	9SY9HBM0FMWc4itxHE9HG9l6SqtURExsZHphX+Z9e77qNsgAtIjw7JBNzTZWkQ5mGyNh8T
	+NDBqO3io6Jmlpq0M+CxtStJdL8RPgGHV1CNPOkReFWDDKfY+3QnbTiOtirY0dZIqhYa4l
	FKOgJx6fNrJcKXHNz9ASoz9JDzXcpM/XDL9aORW2yp/M0bvCimaXo0r27PxfuA==
Date: Tue, 8 Oct 2024 08:28:57 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 0/9] Allow isolating PHY devices
Message-ID: <20241008082857.115a2272@device-21.home>
In-Reply-To: <ZwQD_ByawFLEQ1MZ@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<ZwAfoeHUGOnDz1Y1@shell.armlinux.org.uk>
	<20241007122513.4ab8e77b@device-21.home>
	<ZwQD_ByawFLEQ1MZ@shell.armlinux.org.uk>
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

Hi Russell,

On Mon, 7 Oct 2024 16:53:32 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Oct 07, 2024 at 12:25:13PM +0200, Maxime Chevallier wrote:
> > Hello Russell
> > 
> > On Fri, 4 Oct 2024 18:02:25 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >   
> > > I'm going to ask a very basic question concerning this.
> > > 
> > > Isolation was present in PHYs early on when speeds were low, and thus
> > > electrical reflections weren't too much of a problem, and thus star
> > > topologies didn't have too much of an effect. A star topology is
> > > multi-drop. Even if the PCB tracks go from MAC to PHY1 and then onto
> > > PHY2, if PHY2 is isolated, there are two paths that the signal will
> > > take, one to MAC and the other to PHY2. If there's no impediance match
> > > at PHY2 (e.g. because it's in high-impedance mode) then that
> > > transmission line is unterminated, and thus will reflect back towards
> > > the MAC.
> > > 
> > > As speeds get faster, then reflections from unterminated ends become
> > > more of an issue.
> > > 
> > > I suspect the reason why e.g. 88x3310, 88E1111 etc do not support
> > > isolate mode is because of this - especially when being used in
> > > serdes mode, the topology is essentially point-to-point and any
> > > side branches can end up causing data corruption.  
> > 
> > I suspect indeed that this won't work on serdes interfaces. I didn't
> > find any reliable information on that, but so far the few PHYs I've
> > seen seem to work that way.
> > 
> > The 88e1512 supports that, but I was testing in RGMII.  
> 
> Looking at 802.3, there is no support for isolation in the clause 45
> register set - the isolate bit only appears in the clause 22 BMCR.
> Clause 22 registers are optional for clause 45 PHYs.
> 
> My reading of this is that 802.3 has phased out isolation support on
> the MII side of the PHY on more modern PHYs, so this seems to be a
> legacy feature.
> 
> Andrew has already suggested that we should default to isolate not
> being supported - given that it's legacy, I agree with that.
> 
> > > So my questions would be, is adding support for isolation mode in
> > > PHYs given todays network speeds something that is realistic, and
> > > do we have actual hardware out there where there is more than one
> > > PHY in the bus. If there is, it may be useful to include details
> > > of that (such as PHY interface type) in the patch series description.  
> > 
> > I do have some hardware with this configuration (I'd like to support
> > that upstream, the topology work was preliminary work for that, and the
> > next move would be to send an RFC for these topolopgies exactly).
> > 
> > I am working with 3 different HW platforms with this layout :
> > 
> >       /--- PHY
> >       |
> > MAC  -|  phy_interface_mode == MII so, 100Mbps Max.
> >       |
> >       \--- PHY
> > 
> > and another that is similar but with RMII. I finally have one last case
> > with MII interface, same layout, but the PHYs can't isolate so we need
> > to make sure all but one PHYs are powered-down at any given time.  
> 
> You have given further details in other response to Andrew. I'll
> comment further there.
> 
> > I will include that in the cover.  
> 
> Yes, it would be good to include all these details in the cover message
> so that it isn't spread out over numerous replies.
> 
> > Could we consider limiting the isolation to non-serdes interfaces ?
> > that would be :
> > 
> >  - MII
> >  - RMII
> >  - GMII
> >  - RGMII and its -[TX|RX] ID flavours
> >  - TBI and RTBI ?? (I'm not sure about these)
> > 
> > Trying to isolate a PHY that doesn't have any of the interfaces above
> > would result in -EOPNOTSUPP ?  
> 
> I think the question should be: which MII interfaces can electrically
> support multi-drop setups.
> 
> 22.2.4.1.6 describes the Clause 22 Isolate bit, which only suggests
> at one use case - for a PHY connected via an 802.3 defined connector
> which shall power up in isolated state "to avoid the possibility of
> having multiple MII output drivers actively driving the same signal
> path simultaneously". This connector only supports four data signals
> in each direction, which precludes GMII over this defined connector.
> 
> However, it talks about isolating the MII and GMII signals in this
> section.
> 
> Putting that all together, 802.3 suggests that it is possible to
> have multiple PHYs on a MII or GMII (which in an explanatory note
> elsewhere, MII means 100Mb/s, GMII for 1Gb/s.) However, it is
> vague.

Yes it's vague, as as testing showed, vendors are pretty liberal with
how/if they implement this feature :(

> Now... I want to say more, but this thread is fragmented and the
> next bit of the reply needs to go elsewhere in this thread,
> which is going to make reviewing this discussion later on rather
> difficult... but we're being drip-fed the technical details.

TBH I wasn't expecting this series on isolation to be the place to
discuss the multiplexing use-cases, hence why I didn't include a full
descriptin of every setup I have in the cover.

Given what Andrew replied, this whole series on controling isolation
from userspace isn't relevant.

Let me start a proper discussion thread and summarize what has been
said so far.

Maxime


