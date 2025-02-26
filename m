Return-Path: <netdev+bounces-169892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BADB7A4645B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29D73AC90B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B402222C6;
	Wed, 26 Feb 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oQYj+R7W"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68320C008;
	Wed, 26 Feb 2025 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583010; cv=none; b=WhGKOJlV4cymwuW9DgHyvpyzJK7kM6Tw1AdbXdNcZNyqBNDOgaIY+1QlPksrLqfkNcLwxrsLlqeYvUdMKztIC4MHdpexv2hkND+VAHPi/VisDW2c1BVSvg4FhSEW1Mj9e8rd6jQOkD1NZBwAWupheN+4IlZIyewQMdcBf/+pHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583010; c=relaxed/simple;
	bh=SVdD8U7d/FDoTOYHC+jT1skSEd46CNF33xakYMMnULk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F1bOuiuJcHi0TzDJM+hiIEBxsQFzMOi6nxNWrUlK+sLLQHYK7RfIkXQbQbw47VJQSFz+/nnpQEOSjFvPlgfbfQhhQ12QzrvzlohzUdiIJPINE5uzH0go1c4a/1nHINMR8UTeF5hlzhlbs/dWuNjiBTZTBXUmdgK55PCYObaLbDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oQYj+R7W; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CF6E4433C;
	Wed, 26 Feb 2025 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740583000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJaZnLfOjI4LHuqpMppLemf30WiM8BMZnVVa5Y1FR+4=;
	b=oQYj+R7WOnYA+MwRlTQIzmLyjq+90/o3hskqoEiVmNBKzmv/6rvFw3UgwaZHhz6jMc2OyI
	9y0kuwsHY6qlDLb5e0z1Xm/6QmttvRq5lOpiQE/Lu02zCkUyYHSKcgXbY2AtU4M67KN3pW
	W1n1ocgqqeVvlDNaw81c1/Ae47EhCR/djL9MNHB9nj9DjDod0rT0/YfSPMduXOTsPLpMuA
	KhN8xZRXSf+BFuaABamiBdWznDI3hE+6RfJDVarHq/ZAhjEByQ8onXeBje9yMdSkltML50
	dliR5gV7ykHjenp5GXJJwgJy/VlRqg7ecWeiutKp2d7ZFHfedKZy9zX+GyV2/g==
Date: Wed, 26 Feb 2025 16:16:37 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v2 09/13] net: phy: phylink: Use
 phy_caps_lookup for fixed-link configuration
Message-ID: <20250226161637.58597e28@fedora.home>
In-Reply-To: <Z78e1dmEuQzMER5L@shell.armlinux.org.uk>
References: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
	<20250226100929.1646454-10-maxime.chevallier@bootlin.com>
	<Z78e1dmEuQzMER5L@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeelvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtt
 hhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Russell,

On Wed, 26 Feb 2025 14:01:57 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> Please use a subject line of "net: phylink: " for phylink patches, not
> "net: phy: " which is for phylib.

Sure thing, I wasn't sure about the subject line for this one.

> On Wed, Feb 26, 2025 at 11:09:24AM +0100, Maxime Chevallier wrote:
> > When phylink creates a fixed-link configuration, it finds a matching
> > linkmode to set as the advertised, lp_advertising and supported modes
> > based on the speed and duplex of the fixed link.
> > 
> > Use the newly introduced phy_caps_lookup to get these modes instead of
> > phy_lookup_settings(). This has the side effect that the matched
> > settings and configured linkmodes may now contain several linkmodes (the
> > intersection of supported linkmodes from the phylink settings and the
> > linkmodes that match speed/duplex) instead of the one from
> > phy_lookup_settings().
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

[...]

> > @@ -879,8 +880,10 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> >  	linkmode_copy(pl->link_config.advertising, pl->supported);
> >  	phylink_validate(pl, pl->supported, &pl->link_config);
> >  
> > -	s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
> > -			       pl->supported, true);
> > +	c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
> > +			    pl->supported, true);
> > +	if (c)
> > +		linkmode_and(match, pl->supported, c->linkmodes);  
> 
> What's this for? Surely phy_caps_lookup() should not return a link mode
> that wasn't in phy_caps_lookup()'s 3rd argument.

The new lookup may return a linkmode that wasn't in the 3rd argument,
as it will return ALL linkmodes that matched speed and duplex, provided
that at least one of said linkmodes matched the 3rd parameter.

Say you pass SPEED_1000, DUPLEX_FULL and a bitset containing only
1000BaseTFull, you'll get :

 - 1000BaseTFull, 1000BaseKX, 1000BaseT1, etc. in c->linkmodes.

That's the reason for re-andf'ing the modes afterwards.

If that API is too convoluted or error-prone, I can come up with an API
returning only what matched.

Maxime

