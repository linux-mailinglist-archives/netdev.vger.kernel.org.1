Return-Path: <netdev+bounces-172397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DCA54765
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BD13A8BFC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 10:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66701FDA84;
	Thu,  6 Mar 2025 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IYTXaMVi"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467919DF49;
	Thu,  6 Mar 2025 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255949; cv=none; b=Rg2ZocLPYSt67Q0HSG2VnbLpEWtMT1MRs2Qw/GNz53o4QLXvTet5G74mji+t27Sd84f5ftgGLyztCJ0xg1lJsAwL8FdyFbjWo/ACihN8/gvfQ5xxfPt5Kbgzm6ffFk+6NOm32yl6e3QbUkclSrMX/7GsqHV7X2YPLVPO2eifk0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255949; c=relaxed/simple;
	bh=+Q2TKrmnqRPjFBfedzQDDBN91ONCtFQtTZ2XIciyg3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/9YPHY3xur+mOml05VkiX+7iB56QvVVJATaFuiFkMQOQ0YNOCDVK4ScjmYQxF6uCgfYvWwcxyMsil7h6Hgqr9bVD06HvRXU7gnBxqHIyKSCFBKddlGL1mJR2AeibHvirUsPiUoMMsGLZOoxdWuNWbopV2hkg+QR79mPNk3TCeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IYTXaMVi; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCE0E4316C;
	Thu,  6 Mar 2025 10:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741255944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SFqK7fZR0TmLvJNaC6gEPC6OF78JWtmfQ3Z2qsh5268=;
	b=IYTXaMViXgT4KDoKBENK6wDNSEV6WK78C9Au7GqDTJzzAT2HcOM7fAAZJSA8MwgO7w+jNY
	5IwSkf6puZecNxcMRlYPdotuX+ILjvpfD4OMVpC8rKHEGIMseZLKhZto/yvChJ5fTpjpt6
	W38VbKmpRiVWpRf7Dv/+KEJRPBmMim7AOSvLhKbow+PP9cCdNDirlyKQIrdjsOo1qe6+78
	Ta/oj1Q/VrSkeYjHQzw7WDqHLo8O/1vaQn5eUpb6w/FMAm22cIn0qXM2FClpmoMaKdpLET
	tQ66l08Xfge6lqjH5Htj5r4Ui4QuTPuYmBYGMjtwsXje6T88ogtgVEBYMlGD2A==
Date: Thu, 6 Mar 2025 11:12:20 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Russell King
 <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>,
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
Message-ID: <20250306111220.28798e6b@fedora.home>
In-Reply-To: <350bb4f6-f4b5-44c3-a821-ac53c8641705@redhat.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
	<20250303090321.805785-10-maxime.chevallier@bootlin.com>
	<350bb4f6-f4b5-44c3-a821-ac53c8641705@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 6 Mar 2025 09:56:32 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 3/3/25 10:03 AM, Maxime Chevallier wrote:
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
> How about using only the first bit from `c->linkmodes`, to avoid
> behavior changes?

If what we want is to keep the exact same behaviour, then we need to
go one step further and make sure we keep the same one as before, and
it's not guaranteed that the first bit in c->linkmodes is this one.

We could however have a default supported mask for fixed-link in phylink
that contains all the linkmodes we allow for fixed links, then filter
with the lookup, something like :


-       linkmode_fill(pl->supported);
+       /* (in a dedicated helper) Linkmodes reported for fixed links below
+        * 10G */
+       linkmode_zero(pl->supported);
+
+       linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT, pl->supported);
+       linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT, pl->supported);
+
        linkmode_copy(pl->link_config.advertising, pl->supported);
        phylink_validate(pl, pl->supported, &pl->link_config);
 
-       s = phy_lookup_setting(pl->link_config.speed, pl->link_config.duplex,
-                              pl->supported, true);
+       c = phy_caps_lookup(pl->link_config.speed, pl->link_config.duplex,
+                           pl->supported, true);
+       if (c)
+               linkmode_and(match, pl->supported, c->linkmodes);

That way we should have a consistent behaviour with what we currently
have, and to me it's more explicit what will the  fixed-link linkmodes
be.

I'd like to make sure Russell is OK with that though :)

Thanks you for the review Paolo !

Maxime

