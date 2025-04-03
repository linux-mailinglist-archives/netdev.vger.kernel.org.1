Return-Path: <netdev+bounces-179076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F281A7A6F7
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7F83B0A04
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 15:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8242505DE;
	Thu,  3 Apr 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YxCjTO38"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B12505CB
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 15:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694208; cv=none; b=nZeRLDzLQGM5Z14+G1kbv3NNb2MYzsuyXFu23GOFQFIJj+iPKz0GUwmNMVJptwc7rxqGJsZyF/Tsu2VG7oZSObbYoCcmN/ulKBmrhygog676x32w16fFdsMbczrkhBHrvJYf19xgJ5JKRjVFmrPf4lqxwXFCk84zPBIfIIUTjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694208; c=relaxed/simple;
	bh=rX+8hE1leMUgs1R7gxulQLGDphB0zP4un/p5B//RFCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGe0f+vOUzJrGunPuAWz/s3NdMeHIvk0X9SGzuafvCyc2RYywszVd3fI5/0MLN8J6EmURGw3pLEG/6wHAtZdbU3GQCVP1GrDwfHKmVa8RC9qjwJZ1wfMwlBh7sdxkWt0n8qMHBiEFkOs4g9Y9r8/hImQ3vV7EHYgNHUbpTehumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YxCjTO38; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D9A344520;
	Thu,  3 Apr 2025 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743694198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UBQUwiQfPhVOmUZQetATJxPfdKaothmZ3z04/TUyDs=;
	b=YxCjTO383/kyzFZz5mcMMjFCGz4795dmSXTarTLJ4DuPIKLdiI096P2RutMYHNv5BRBZzL
	KlxY1wW8Nbp9/RuzETetLQwAcMFx7o+kAeIBu1q0xBNh4fYjcLAARUMmcYTIw7tpmXncg5
	75tq2lBj4nzybo9TWGtaGMNaA84aXmw+LeMeU6MGNTYzNrDE6lomz8Gh0TvtE5mrCjx0eZ
	/u9jK703tTT3S4HaiXZWW0gUeSA426DxzzxnBXgPvcO/U51pegH6nXHMn2JoPllhv5Dk3h
	dauGFa1yH4xJ8ICUrLE3s/mHiiVnLZSZ/5MoS3yXAmEipIKdAAtg08Y/KSxlnA==
Date: Thu, 3 Apr 2025 17:29:53 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <20250403172953.5da50762@fedora.home>
In-Reply-To: <Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
	<174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
	<Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeekledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepkedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghlvgigrghnuggvrhdrughuhigtkhesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkv
 ghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 3 Apr 2025 15:55:45 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Apr 01, 2025 at 02:30:06PM -0700, Alexander Duyck wrote:
> > From: Alexander Duyck <alexanderduyck@fb.com>
> > 
> > The blamed commit introduced an issue where it was limiting the link
> > configuration so that we couldn't use fixed-link mode for any settings
> > other than twisted pair modes 10G or less. As a result this was causing the
> > driver to lose any advertised/lp_advertised/supported modes when setup as a
> > fixed link.
> > 
> > To correct this we can add a check to identify if the user is in fact
> > enabling a TP mode and then apply the mask to select only 1 of each speed
> > for twisted pair instead of applying this before we know the number of bits
> > set.
> > 
> > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
> > Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> > ---
> >  drivers/net/phy/phylink.c |   15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index 16a1f31f0091..380e51c5bdaa 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -713,17 +713,24 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> >  		phylink_warn(pl, "fixed link specifies half duplex for %dMbps link?\n",
> >  			     pl->link_config.speed);
> >  
> > -	linkmode_zero(pl->supported);
> > -	phylink_fill_fixedlink_supported(pl->supported);
> > -
> > +	linkmode_fill(pl->supported);
> >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> >  	phylink_validate(pl, pl->supported, &pl->link_config);
> >  
> >  	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> >  			    pl->supported, true);
> > -	if (c)
> > +	if (c) {
> >  		linkmode_and(match, pl->supported, c->linkmodes);
> >  
> > +		/* Compatbility with the legacy behaviour:
> > +		 * Report one single BaseT mode.
> > +		 */
> > +		phylink_fill_fixedlink_supported(mask);
> > +		if (linkmode_intersects(match, mask))
> > +			linkmode_and(match, match, mask);
> > +		linkmode_zero(mask);
> > +	}
> > +  
> 
> I'm still wondering about the wiseness of exposing more than one link
> mode for something that's supposed to be fixed-link.
> 
> For gigabit fixed links, even if we have:
> 
> 	phy-mode = "1000base-x";
> 	speed = <1000>;
> 	full-duplex;
> 
> in DT, we still state to ethtool:
> 
>         Supported link modes:   1000baseT/Full
>         Advertised link modes:  1000baseT/Full
>         Link partner advertised link modes:  1000baseT/Full
>         Link partner advertised auto-negotiation: No
>         Speed: 1000Mb/s
>         Duplex: Full
>         Auto-negotiation: on
> 
> despite it being a 1000base-X link. This is perfectly reasonable,
> because of the origins of fixed-links - these existed as a software
> emulated baseT PHY no matter what the underlying link was.
> 
> So, is getting the right link mode for the underlying link important
> for fixed-links? I don't think it is. Does it make sense to publish
> multiple link modes for a fixed-link? I don't think it does, because
> if multiple link modes are published, it means that it isn't fixed.

That's a good point. The way I saw that was :

  "we report all the modes because, being fixed-link, it can be
  any of these modes."

But I agree with you in that this doesn't show that "this is fixed,
don't try to change that, this won't work". So, I do agree with you now.

> As for arguments about the number of lanes, that's a property of the
> PHY_INTERFACE_MODE_xxx. There's a long history of this, e.g. MII/RMII
> is effectively a very early illustration of reducing the number of
> lanes, yet we don't have separate link modes for these.
> 
> So, I'm still uneasy about this approach.

So, how about extending the compat list of "first link of each speed"
to all the modes, then once the "mediums" addition from the phy_port
lands, we simplify it down the following way :

Looking at the current list of elegible fixed-link linkmodes, we have
(I'm taking this from one of your mails) :

speed	duplex	linkmode
10M	Half	10baseT_Half
10M	Full	10baseT_Full
100M	Half	100baseT_Half
100M	Full	100baseT_Full
1G	Half	1000baseT_Half
1G	Full	1000baseT_Full (this changed over time)
2.5G	Full	2500baseT_Full
5G	Full	5000baseT_Full
10G	Full	10000baseCR_Full (used to be 10000baseKR_Full)
20G	Full	20000baseKR2_Full => there's no 20GBaseCR*
25G	Full	25000baseCR_Full
40G	Full	40000baseCR4_Full
50G	Full	50000baseCR2_Full
56G	Full	56000baseCR4_Full
100G	Full	100000baseCR4_Full

To avoid maintaining a hardcoded list, we could clearly specifying
what we report in fixed-link :

 1 : Any BaseT mode for the given speed duplex (BaseT and not BaseT1)
 2 : If there's none, Any BaseK mode for that speed/duplex
 3 : If there's none, Any BaseC mode for that speed/duplex

That's totally arbitrary of course, and if one day someone adds, say,
25GBaseT, fixed-link linkmode will change. Another issue us 10G,
10GBaseT exists, but wasn't the first choice.

Another idea could be to add a Fixed linkmode BIT, like we have for
aneg, pause, asym_pause, and report 2 linkmodes :

         Supported link modes:   1000baseT/Full
				 Fixed
         Advertised link modes:  1000baseT/Full
				 Fixed
         Link partner advertised link modes:  1000baseT/Full
					      Fixed

The first "legacy" linkmode will still be reported for compat, we add a
second one to tell userspace that this is Fixed, don't try to make any
sense out of it ? But that may just overcomplicate the whole thing and
leave yet another way for the linkmodes to be abused in drivers.

Maxime

