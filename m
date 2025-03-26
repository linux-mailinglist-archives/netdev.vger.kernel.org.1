Return-Path: <netdev+bounces-177675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59CA711D1
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 09:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F571171AC0
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 07:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3DE19CC02;
	Wed, 26 Mar 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O2rD/Q8H"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C909F142E67;
	Wed, 26 Mar 2025 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975954; cv=none; b=atE/V3w0orZN+7RtieXQwLmx4xVLqZD7ClRQ6HM9JmTfd7N7ZNlIrSbJwyTSD1r6eyN07tHCQEkqKHfO6WCyGim2IfA7UZdsFNLN3uY8O9dXB1/xq/aKZeE2NaU0du+t+ozighSMEVJR591vp9IjYI0tMNZT9XLNAQNuEDpNHNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975954; c=relaxed/simple;
	bh=H5Hp8j0vw64UlnCa7LhevF1ZrFJPM/LjYzCF98r0TLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZireUY9MVwbfjtfoDZy9R/N2Yd3GtfytHrZKZNy3DQh0+OuWwSZ2eFVX/G54U380YslAb8rmXFPF1lww6w+3wDOkP1zGqZpgROwBW8wXMcdkVvf0pBAhDVzIlLx4rucg8NP+/iMsdEKLHw2lf8HGxh1KDuFXjqh2Cn9atns/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O2rD/Q8H; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2EBE8443B3;
	Wed, 26 Mar 2025 07:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742975949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dTWyui4Xr7KMh10WBhiXRlOoGq1yggOO8oiSujDwR4E=;
	b=O2rD/Q8Ho4tVxJBvL6/k+eaT0h0doMXKQ2STOuMEdL2NI4hyFAFqEUDqMMsKjkKG0npELf
	mqUQ2jwrqiE8aeK32fmaCadF38+ooLU2Q7VdfU2iYMYw1RLSrkjiL2kttFSwlyyBqnX5RT
	+7o5icB71s9vQrDd8wUtmEMJYuFh/PY1FSzt/bJr8JCl5jigv7qPhCG0dkMZuhj1umbek5
	Er+zqrloy3s0Hl4bgy8NTJw8kI3nX+UbO9rWvTb1apCbuw3sBWw1mKv6By/+nsO+bAOxlx
	v1fmkj2KHHByQuu4zb4VB1IwycZ+kcNhqdaR+moE0Z0NrMxZll7SJYK7g1mSwg==
Date: Wed, 26 Mar 2025 08:59:06 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>, davem@davemloft.net, Andrew
 Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 2/8] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
Message-ID: <20250326085906.62a7c9fc@fedora.home>
In-Reply-To: <20250325142202.61d2d4b3@kernel.org>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-3-maxime.chevallier@bootlin.com>
	<20250325122706.5287774d@kmaincent-XPS-13-7390>
	<20250325141507.4a223b03@kernel.org>
	<20250325142202.61d2d4b3@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegleelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvt
 hdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Tue, 25 Mar 2025 14:22:02 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 25 Mar 2025 14:15:07 -0700 Jakub Kicinski wrote:
> > > This means the dump will have a different behavior in case of filtered dump
> > > (allow_pernetdev_dump) or standard dump.
> > > The standard dump will drop the interface device so it will dump all interfaces
> > > even if one is specified.
> > > The filtered dump will dump only the specified interface. 
> > > Maybe it would be nice to have the same behavior for the dump for all the
> > > ethtool command.
> > > Even if this change modify the behavior of the dump for all the ethtool commands
> > > it won't be an issue as the filtered dump did not exist before, so I suppose it
> > > won't break anything. IMHO it is safer to do it now than later, if existing
> > > ethtool command adds support for filtered dump.
> > > We should find another way to know the parser is called from dump or doit.    
> > 
> > Let's try. We can probably make required_dev attr of
> > ethnl_parse_header_dev_get() a three state one: require, allow, reject?  
> 
> Ah, don't think this is going to work. You're not converting all 
> the dumps, just the PHY ones. It's fine either way, then.

Yeah I noticed that when implementing, but I actually forgot to mention
in in my cover, which I definitely should have :(

What we can also do is properly support multi-phy dump but not filtered
dump on all the existing phy commands (plca, pse-pd, etc.) so that be
behaviour is unchanged for these. Only PHY_GET and any future per-phy
commands would support it.

Maxime

