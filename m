Return-Path: <netdev+bounces-178358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C12A76BD9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 18:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38ADD188965F
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A7E211A35;
	Mon, 31 Mar 2025 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BSO6Mxqp"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D884136347;
	Mon, 31 Mar 2025 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743438010; cv=none; b=luwb9n2IbIC60pgXgAGpbxw2y0oW++hbzrfycWBaXmzCLaSE46LMmb6224YYGHziQT8MUWiCaYuuNo1kVQv8BBqPCQ2XCW2hV1gAz5NCW8zYjeq2/XwZ8/PWMy9Xa+DUxURRuVC7I9mJHDyWZanMxdU9tPrLqLF9VawUzDEjED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743438010; c=relaxed/simple;
	bh=mjyKu4v10FijIC6PaGIIgvxeDHbyaTw2Vd0LUmOfcSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jSDQ6KNA00AbT65/5XdCcYZL0yaZXGmRWFQOSMZq63DQsHLC+F+LFF0yyZau/Pm10zjasjjXVRO0rNLJcKWF//TfEubm2QetBbT85qpm/kdXD2Jt4fOJm2JtaSgL3eOhnaUtlcowY1ztpstCojRJ3ihevVMiwB6GymJgyufAVBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BSO6Mxqp; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EAAF444FD;
	Mon, 31 Mar 2025 16:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743438006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytyW6Ib7JG7PXGq9nIWUTfnzofsAb7FeQ+Sz3N7/aBA=;
	b=BSO6MxqpZban1/3AGE86T0zuVdxHLOfZ8zSYuybSVfZ/B2G7lXHXGU8dw3v0WCRgEY4RPa
	KuMZOc3PUYOt/9G5xWKgXq7bZVZvg0P+hTuI8PAoKT5ykkTSII+UB2onkDcyPcuZR+F4qt
	rzcLGexPwJbsTpcnZQ/GrYVPSwJH1RNwo1PvfTYfvsm7UxXddNvuXX3a14S5j/MWXi4kJq
	6+GvMGVZf8zRo8Xz8zxuWo1za1p+xeoP6r9JbPwpVSKGjTo5mCslu5afiPzBmAuU4haEoi
	fcmztvXOZ3zfodOCmYrl4KU06KOhXAxBffuyN0zQNavonYVu0PvMg9EVCgJMaw==
Date: Mon, 31 Mar 2025 18:20:00 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexander Duyck
 <alexander.duyck@gmail.com>, davem@davemloft.net, Jakub Kicinski
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
Subject: Re: [PATCH net-next v5 09/13] net: phylink: Use phy_caps_lookup for
 fixed-link configuration
Message-ID: <20250331182000.0d94902a@fedora.home>
In-Reply-To: <Z-qsnN4umaz0QrG0@shell.armlinux.org.uk>
References: <20250307173611.129125-1-maxime.chevallier@bootlin.com>
	<20250307173611.129125-10-maxime.chevallier@bootlin.com>
	<8d3a9c9bb76b1c6bc27d2bd01f4831b2cac83f7f.camel@gmail.com>
	<20250328090621.2d0b3665@fedora-2.home>
	<CAKgT0Ue_JzmJAPKBhe6XaMkDCy+YNNg5_5VvzOR6CCbqcaQg3Q@mail.gmail.com>
	<12e3b86d-27aa-420b-8676-97b603abb760@lunn.ch>
	<CAKgT0UcZRi1Eg2PbBnx0pDG_pCSV8tfELinNoJ-WH4g3CJOh2A@mail.gmail.com>
	<02c401a4-d255-4f1b-beaf-51a43cc087c5@lunn.ch>
	<Z-qsnN4umaz0QrG0@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukedtfeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegrlhgvgigrnhguvghrrdguuhihtghksehgmhgrihhlrdgto
 hhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Mon, 31 Mar 2025 15:54:20 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Mar 31, 2025 at 04:17:02PM +0200, Andrew Lunn wrote:
> > On Fri, Mar 28, 2025 at 04:26:04PM -0700, Alexander Duyck wrote:  
> > > A serdes PHY is part of it, but not a traditional twisted pair PHY as
> > > we are talking about 25R, 50R(50GAUI & LAUI), and 100P interfaces. I
> > > agree it is a different beast, but are we saying that the fixed-link
> > > is supposed to be a twisted pair PHY only?  
> > 
> > With phylink, the PCS enumerates its capabilities, the PHY enumerates
> > its capabilities, and the MAC enumerates it capabilities. phylink then
> > finds the subset which all support.
> > 
> > As i said, historically, fixed_link was used in place of a PHY, since
> > it emulated a PHY. phylinks implementation of fixed_link is however
> > different. Can it be used in place of both a PCS and a PHY? I don't
> > know.  
> 
> In fixed-link mode, phylink will use a PCS if the MAC driver says there
> is one, but it will not look for a PHY.
> 
> > You are pushing the envelope here, and maybe we need to take a step
> > back and consider what is a fixed link, how does it fit into the MAC,
> > PCS, PHY model of enumeration? Maybe fixed link should only represent
> > the PHY and we need a second sort of fixed_link object to represent
> > the PCS? I don't know?  
> 
> As I previously wrote today in response to an earlier email, the
> link modes that phylink used were the first-match from the old
> settings[] array in phylib which is now gone. This would only ever
> return _one_ link mode, which invariably was a baseT link mode for
> the slower speeds.
> 
> Maxime's first approach at adapting this to his new system was to
> set every single link mode that corresponded with the speed. I
> objected to that, because it quickly gets rediculous when we end
> up with lots of link modes being indicated for e.g. 10, 100M, 1G
> but the emulated PHY for these speeds only indicates baseT. That's
> just back-compatibility but... in principle changing the link modes
> that are reported to userspace for a fixed link is something we
> should not be doing - we don't know if userspace tooling has come
> to rely on that.
> 
> Yes, it's a bit weird to be reporting 1000baseT for a 1000BASE-X
> interface mode, but that's what we've always done in the past and
> phylink was coded to maintain that (following the principle that
> we shouldn't do gratuitous changes to the information exposed to
> userspace.)
> 
> Maxime's replacement approach is to just expose baseT, which
> means that for the speeds which do not have a baseT mode, we go
> from supporting it but with a weird link mode (mostly baseCR*)
> based on first-match in the settings[] table, to not supporting the
> speed.

I very wrongfully considered that there was no >10G fixed-link users, I
plan to fix that with something like the proposed patch in the
discussion, that reports all linkmodes for speeds above 10G (looks less
like a randomly selected mode, you can kind-of see what's going on as
you get all the linkmodes) but is a change in what we expose to
userspace.

Or maybe simpler, I could extend the list of compat fixed-link linkmodes
to all speeds with the previous arbitrary values that Russell listed in
the other mail (that way, no user-visible changes :) )

I was hoping Alexander could give option 1 a try, but let me know if
you think we should instead adopt option 2, which is probably the safer
on.

Maxime

