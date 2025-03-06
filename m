Return-Path: <netdev+bounces-172360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB82A5459F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 658057A35DA
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1442080DA;
	Thu,  6 Mar 2025 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aB2pAhX8"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF01FF7CC;
	Thu,  6 Mar 2025 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251458; cv=none; b=rhsIF6bCPNmM7FGfLZxA5NhR9sRATMEKULusHWvhH6FnZVs+2JveYJcJ0/8c+OhdMj2g908vFUH+H888375ECZhULS8KdnN7562TdT7zq44+5amTxLH4SuClGR8FDrf5x0YuXkHekbpf9KFXZHure90TBdvh34NyRqvswa5PpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251458; c=relaxed/simple;
	bh=n2BLu+Wu2eYN86k7ZRRHm5l9dQn/ExFVkpkl7i1CO1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1tPfBx9LFfQmpFk6gmsIsTZLn+eNaQ1Gudzr6gvWaJFAD/gniK8XR8VkahjTLpqWOM6dxaPzw/3j83NsH8EKW/P89zpJBEGQVEoko/RoSWF7ZlUdKD6pTGxceiDu9PM/KF/GwNbSI2ATXUp9ecxQgniA5Jycmx3RBZ6UN/GxY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aB2pAhX8; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27221443D1;
	Thu,  6 Mar 2025 08:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741251448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8Ai/j9FWWA8BuJUB3RoPY/GqoMvHgqve37LLwirBbU=;
	b=aB2pAhX86gJ5Okidw2qqL44L/5oQPxeMT8/W0NaSFXpM4wICQD+xVuyjuP0I8hLLAOHAVT
	wH9OpIbQtbFkWaXKbxzjWjLiGrlIouHnC+loz/GIPwyQEYgCJXE+9g+vM8/BebvuDf+9Xu
	yWT/9y3nbhQShoPQHgLd6KIiJdG3233LVuXyToZf+X3NzUWGA1irx00zQFPoYWAVY491GU
	xSL4L7m2lBinbXXphSxowPEzyYN2JcYiDs0CJf1pk6meg0Q311TwMlylExRJL6SM29ewzQ
	P8HKGCJMe+qTtGud89KRbhi/0iDQyLHgJNZ2/jxmHmlg7ysZDt7OdRs+EMG/OQ==
Date: Thu, 6 Mar 2025 09:57:26 +0100
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
Subject: Re: [PATCH net-next v4 02/13] net: phy: Use an internal, searchable
 storage for the linkmodes
Message-ID: <20250306095726.04125e5f@fedora.home>
In-Reply-To: <738bd67c-8688-4902-805f-4e35e6aaed4a@redhat.com>
References: <20250303090321.805785-1-maxime.chevallier@bootlin.com>
	<20250303090321.805785-3-maxime.chevallier@bootlin.com>
	<738bd67c-8688-4902-805f-4e35e6aaed4a@redhat.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdejfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepk
 hhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Paolo,

On Thu, 6 Mar 2025 09:30:11 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

> On 3/3/25 10:03 AM, Maxime Chevallier wrote:
> [...]
> > +static int speed_duplex_to_capa(int speed, unsigned int duplex)
> > +{
> > +	if (duplex == DUPLEX_UNKNOWN ||
> > +	    (speed > SPEED_1000 && duplex != DUPLEX_FULL))
> > +		return -EINVAL;
> > +
> > +	switch (speed) {
> > +	case SPEED_10: return duplex == DUPLEX_FULL ?
> > +			      LINK_CAPA_10FD : LINK_CAPA_10HD;
> > +	case SPEED_100: return duplex == DUPLEX_FULL ?
> > +			       LINK_CAPA_100FD : LINK_CAPA_100HD;
> > +	case SPEED_1000: return duplex == DUPLEX_FULL ?
> > +				LINK_CAPA_1000FD : LINK_CAPA_1000HD;
> > +	case SPEED_2500: return LINK_CAPA_2500FD;
> > +	case SPEED_5000: return LINK_CAPA_5000FD;
> > +	case SPEED_10000: return LINK_CAPA_10000FD;
> > +	case SPEED_20000: return LINK_CAPA_20000FD;
> > +	case SPEED_25000: return LINK_CAPA_25000FD;
> > +	case SPEED_40000: return LINK_CAPA_40000FD;
> > +	case SPEED_50000: return LINK_CAPA_50000FD;
> > +	case SPEED_56000: return LINK_CAPA_56000FD;
> > +	case SPEED_100000: return LINK_CAPA_100000FD;
> > +	case SPEED_200000: return LINK_CAPA_200000FD;
> > +	case SPEED_400000: return LINK_CAPA_400000FD;
> > +	case SPEED_800000: return LINK_CAPA_800000FD;
> > +	}
> > +  
> 
> What about adding some code here to help future patch updating LINK_CAPA
> definition as needed?
> 
> Something alike:
> 
> 	pr_err_once("Unknown speed %d, please update LINK_CAPS\n", speed);
> 
> 
> > +	return -EINVAL;
> > +}
> > +
> > +/**
> > + * phy_caps_init() - Initializes the link_caps array from the link_mode_params.
> > + */
> > +void phy_caps_init(void)
> > +{
> > +	const struct link_mode_info *linkmode;
> > +	int i, capa;
> > +
> > +	/* Fill the caps array from net/ethtool/common.c */
> > +	for (i = 0; i < __ETHTOOL_LINK_MODE_MASK_NBITS; i++) {
> > +		linkmode = &link_mode_params[i];
> > +		capa = speed_duplex_to_capa(linkmode->speed, linkmode->duplex);
> > +
> > +		if (capa < 0)
> > +			continue;  
> 
> Or even error-out here.

Good point yes indeed. Russell raised the point for the need of keeping
this in sync with new SPEED_XXX definitions, I'll add a check that
errors out.

I hope that's OK though, as higher speeds are introduced and used by
NICs that usually don't use phylib at all, so there's a good chance
that the developper introducing the new speed won't have CONFIG_PHYLIB
enabled.

Is that still good ?

Maxime

