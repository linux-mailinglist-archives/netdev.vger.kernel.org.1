Return-Path: <netdev+bounces-172459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0788A54C18
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E610318942AC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371120E024;
	Thu,  6 Mar 2025 13:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EGIPGdpi"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E73204C28;
	Thu,  6 Mar 2025 13:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267589; cv=none; b=JqhZPKxLJX5uz9jO9o4c5Sq2iaGmirz4K/cE6Qvth0Dya0XR5lcQFiFd3BbC8q2H7BTm67tkpAhC+IE3fJaq2yYFhJEjT3hdS5kxE8Rdgg4nYO0Y3ZM+fusFd+0LcSx/+2ws6dqCi+rb93vszBCziUpUjORdUeakvPEm7Rn6UjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267589; c=relaxed/simple;
	bh=Bnuej3/nh2x7yatl8yZxq2u7lLcnOWbWFh/Cv694uls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7bNglsWhyUZ5/a4Va792koalLioBSka/N2vi85aQRG0oJ50fK+YKJ0W+/h1EEB0MWkOBVfZTTkdOWr7VlyG9CgDs2A4xbz9VXU6b6N0UJF2xES/g4L7mWE29imrEdPAkXJGiT+PiNuP7mNlGch8EwZ7fz6rmzasvpSM8npsEAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EGIPGdpi; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 62EDC442ED;
	Thu,  6 Mar 2025 13:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741267585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FryI2wdxqmeOjmXxF70lohF85fEbGcS6dJS4YcW85A=;
	b=EGIPGdpi293reUIuQ5IOmLJ/SOpH2Vp8rMxZl3DBdm5zBFV92jViNMxq/dV1CcxUz1fu2r
	ppmGhLFpAVp1+QFWxRudk1IWw/6tHwnD61TCPm8m+dh27wtbKg8USA5zUuwIKnm6FRNjsd
	uS6fCzpFGJkJhHrk8HeS0Uc/zTdjHMbPgIpZIDV0m7I+XaepLVc5L+W/WX9NssZk0yC3ZG
	a01VVfvH9P23M62TMGS/ToKMSB6D7qeaPSw5ZMrl8d2Q/fz2uoS0wW2d9toqT8CVAVMwAA
	4ceIY9EaY3tkI6tvqQFXodmRV2F5B0NhWAB2lKmByslgEoyeXglYEwB2XFxAOQ==
Date: Thu, 6 Mar 2025 14:26:20 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v4 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <20250306142620.002d8b8a@fedora.home>
In-Reply-To: <Z8maRNYsn1LzjryX@shell.armlinux.org.uk>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
	<20250303090321.805785-10-maxime.chevallier@bootlin.com>
	<350bb4f6-f4b5-44c3-a821-ac53c8641705@redhat.com>
	<20250306111220.28798e6b@fedora.home>
	<Z8maRNYsn1LzjryX@shell.armlinux.org.uk>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepudfgleelvddtffdvkeduieejudeuvedvveffheduhedvueduteehkeehiefgteehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegur
 ghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 6 Mar 2025 12:51:16 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Thu, Mar 06, 2025 at 11:12:20AM +0100, Maxime Chevallier wrote:
> > On Thu, 6 Mar 2025 09:56:32 +0100
> > Paolo Abeni <pabeni@redhat.com> wrote:
> >   
> > > On 3/3/25 10:03 AM, Maxime Chevallier wrote:  
> > > > @@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> > > >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> > > >  	phylink_validate(pl, pl->supported, &pl->link_config);
> > > >  
> > > > -	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
> > > > -			       pl->supported, true);
> > > > +	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> > > > +			    pl->supported, true);
> > > > +	if (c)
> > > > +		linkmode_and(match, pl->supported, c->linkmodes);    
> > > 
> > > How about using only the first bit from `c->linkmodes`, to avoid
> > > behavior changes?  
> > 
> > If what we want is to keep the exact same behaviour, then we need to
> > go one step further and make sure we keep the same one as before, and
> > it's not guaranteed that the first bit in c->linkmodes is this one.
> > 
> > We could however have a default supported mask for fixed-link in phylink
> > that contains all the linkmodes we allow for fixed links, then filter
> > with the lookup, something like :
> > 
> > 
> > -       linkmode_fill(pl->supported);
> > +       /* (in a dedicated helper) Linkmodes reported for fixed links below
> > +        * 10G */
> > +       linkmode_zero(pl->supported);
> > +
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, pl->supported);
> > +       linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, pl->supported);  
> 
> Good idea, but do we have some way to automatically generate the baseT
> link modes?

I think we could with some of the preliminary phy_port patches I had
sent before going into that phy_caps series :

https://lore.kernel.org/netdev/20250213101606.1154014-2-maxime.chevallier@bootlin.com/

It adds the information about medium, maybe we could adapt that, making
sure we filter out BaseT1 for example, but that would be a generic way
of generating that list indeed.

I don't necessarily mean to add this "mediums" thing into this series
right now, we could for now set that list of all BaseT modes in an
internal helper, then later on convert it to the mediums-based
linkmodes listing. I'll go back to phy_ports after phy_caps :)

Thanks,

Maxime


