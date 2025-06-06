Return-Path: <netdev+bounces-195361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD09ACFE1E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 10:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C196A172A6E
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 08:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40261C861D;
	Fri,  6 Jun 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B5Ey5XQo"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9378A1FECDD;
	Fri,  6 Jun 2025 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749197979; cv=none; b=EwgyhqVCYruFcPRcK7GRIXZuv5frNYnuy1R1Y2YCq4B4GHtJUdo4StqegQMDyZlcQMuI8+9D+8LHFeDy34bPNQiEXqryfNwFEmVe4GpBwi4NS5iiQNSXs2kj6UzOIlYm2TwBcd+GMeTUybLLMZERVw84ANPWqIgWfrDEk7UwoSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749197979; c=relaxed/simple;
	bh=xZlhkRAkf9NtLVuWaJZVBEvuhnY31s4L7SnFMDiGwoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b1IvGZZBI5q3ImX7YZeDFi108xhI4+CEnqeJlgIKLeWt2MyOri/xzqEodap8u/Ix57s2BpDkEyHBbN7mpQDtPrG092C3m88alVmw4faXxnWqxS6kyujvTGnlhHgVVRebWPJ05Z+yl9i4dozcO7h4fQSyKZxD96bw2Rzr7ozErgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B5Ey5XQo; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AC86241D02;
	Fri,  6 Jun 2025 08:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749197969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L9OL/AoGykLh8iv60m7BkynFYdgLzm2qSbm2BGgS4HQ=;
	b=B5Ey5XQoeq+ZDoSg7Va76oi/nJ1WxdKyLsALXCcWuruWFaEr67IuHf2UXOO1OjnxCYe4qZ
	d6M+EyQFkLbu6svj00TePXK+ejdXSwQhZtfc3ftuv2K0zbBIi5krTPh9W/jIBto10YVpjr
	faJlFIUwuQSRnce4pgMuwLl19MANeKyuGRmTW9ELDbxC6Ydut0rkssSHOPAnABdrWO76JF
	MhSE7R1o9LgLTBrHj17K5jmpoSnZdjMAUZ8KIeoUsYiU/RruDafw+6z9TjLSurAaYh7oLB
	AN3s/sNoIsv/ZJtXnzGNP6B4hv/mGbTXm/5OODafrxi9irPbxRf9imyt2Sovjw==
Date: Fri, 6 Jun 2025 10:19:23 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Simon Horman <horms@kernel.org>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Romain Gantois <romain.gantois@bootlin.com>,
 Jijie Shao <shaojijie@huawei.com>
Subject: Re: [PATCH net] net: phy: phy_caps: Don't skip better duplex macth
 on non-exact match
Message-ID: <20250606101923.04393789@fedora>
In-Reply-To: <ef3efb3c-3b5a-4176-a512-011e80c52a06@redhat.com>
References: <20250603083541.248315-1-maxime.chevallier@bootlin.com>
	<ef3efb3c-3b5a-4176-a512-011e80c52a06@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeeftdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepleehgeevfeejgfduledtlefhlefgveelkeefffeuiedtteejheduueegiedvveehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdduvddruddthedrudehtddrvdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvuddvrddutdehrdduhedtrddvhedvpdhhvghlohepfhgvughorhgrpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhgl
 hgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 5 Jun 2025 12:24:54 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 6/3/25 10:35 AM, Maxime Chevallier wrote:
> > When performing a non-exact phy_caps lookup, we are looking for a
> > supported mode that matches as closely as possible the passed speed/duplex.
> > 
> > Blamed patch broke that logic by returning a match too early in case
> > the caller asks for half-duplex, as a full-duplex linkmode may match
> > first, and returned as a non-exact match without even trying to mach on
> > half-duplex modes.
> > 
> > Reported-by: Jijie Shao <shaojijie@huawei.com>
> > Closes: https://lore.kernel.org/netdev/20250603102500.4ec743cf@fedora/T/#m22ed60ca635c67dc7d9cbb47e8995b2beb5c1576
> > Fixes: fc81e257d19f ("net: phy: phy_caps: Allow looking-up link caps based on speed and duplex")
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> > ---
> >  drivers/net/phy/phy_caps.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> > index 703321689726..d80f6a37edf1 100644
> > --- a/drivers/net/phy/phy_caps.c
> > +++ b/drivers/net/phy/phy_caps.c
> > @@ -195,7 +195,7 @@ const struct link_capabilities *
> >  phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
> >  		bool exact)
> >  {
> 	> -	const struct link_capabilities *lcap, *last = NULL;
> > +	const struct link_capabilities *lcap, *match = NULL, *last = NULL;
> >  
> >  	for_each_link_caps_desc_speed(lcap) {
> >  		if (linkmode_intersects(lcap->linkmodes, supported)) {
> > @@ -204,16 +204,19 @@ phy_caps_lookup(int speed, unsigned int duplex, const unsigned long *supported,
> >  			if (lcap->speed == speed && lcap->duplex == duplex) {
> >  				return lcap;
> >  			} else if (!exact) {
> > -				if (lcap->speed <= speed)
> > -					return lcap;
> > +				if (!match && lcap->speed <= speed)
> > +					match = lcap;
> > +
> > +				if (lcap->speed < speed)
> > +					break;
> >  			}
> >  		}
> >  	}
> >  
> > -	if (!exact)
> > -		return last;
> > +	if (!match && !exact)
> > +		match = last;  
> 
> If I read correctly, when user asks for half-duplex, this can still
> return a non exact matching full duplex cap, even when there is non
> exact matching half-duplex cap available.

That would be only if there's no half-duplex match at the requested
speed, but yes indeed.

> 
> I'm wondering if the latter would be preferable, or at least if the
> current behaviour should be explicitly called out in the function
> documentation.

Looking at the previous way of doing this, we looked at the following
array in descending order : 

[...]
	/* 1G */
	PHY_SETTING(   1000, FULL,   1000baseT_Full		),
	PHY_SETTING(   1000, HALF,   1000baseT_Half		),
	PHY_SETTING(   1000, FULL,   1000baseT1_Full		),
	PHY_SETTING(   1000, FULL,   1000baseX_Full		),
	PHY_SETTING(   1000, FULL,   1000baseKX_Full		),
	/* 100M */
	PHY_SETTING(    100, FULL,    100baseT_Full		),
	PHY_SETTING(    100, FULL,    100baseT1_Full		),
	PHY_SETTING(    100, HALF,    100baseT_Half		),
	PHY_SETTING(    100, HALF,    100baseFX_Half		),
	PHY_SETTING(    100, FULL,    100baseFX_Full		),
[...]

The matching logic was pretty much the same, walk that (and and'ing
with the passed supported modes), note the partial matches, return
either an exact or non-exact match.

None of the logic actually cared about the duplex for non-exact
matches, only the speed. I think we would have faced the same behaviour.

In reality, the case you're mentioning would be a device that supports
1000/Full, 100/Full and 100/Half, user asks for 1000/Half, and 100/Full
would be reported.

That's unlikely to exist, but I'll document it as I've been surprised
in the past with setups that shouldn't exist that actually do :)

All of this really makes me want to add some test scripts to cover all
these corner-case behaviours and test for future regressions.
Hopefully when I get a bit more bandwidth I'll be finally able to
finish the netdevsim PHY support...

Thanks,

Maxime

> /P
> 


