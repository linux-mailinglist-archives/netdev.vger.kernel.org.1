Return-Path: <netdev+bounces-169033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57355A4226F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11627A788F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6CD254AE5;
	Mon, 24 Feb 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FaCKg6cs"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4371519B1;
	Mon, 24 Feb 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405886; cv=none; b=DocfmpUyGX7TO9HOAo2y9sDhY2lCyOil/8RTgymdSJNlw8OjzIeioB8TGOgLVlitnci7etM/x1VOdr5RX2I86F6jdrIscekgl4RON+LbZ2QcE3rxgKPqYfIQZP0Z3XV0AyuZu4xVRo9jBKl7FETNOfuCpH5JOQWkWPUWMNYMOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405886; c=relaxed/simple;
	bh=wpz590THDcE9wqMfPaT5hc7NmvHv6lJEXmYoo0dMfV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P7AQgG8arI5wFMU/c/yKdFx0ZQyfZ0hHbKpYu0EnwiC/pr1jgbO1Dcnt88lH4qvdwN+sunmzxvP1ZY1BxV2E8MZaaF8bhgVt7TzM1NzreqmeB4F9NjrUOJZslfvttLLWp5jd2sefoR21k1/c3TTR1isGAI8eTAnkrM23aTcpZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FaCKg6cs; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F66F44124;
	Mon, 24 Feb 2025 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740405882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EPcHCivrgVNEm/ByMHyUufAZZi+qh9K6loCNTwKX1V0=;
	b=FaCKg6csEf5Yj70+AItRKH2YVOKtzEd4JKrPyZsWGELHjx66vdfqN0tMT1FtlsZ9tuZYmY
	3gavhs9ZLYl1nbadbctHOZOmYWNhLMKjRVHVUhYjaB2R2QChme68lbkXqTmrZOj1Svq6ba
	EZOwMv91cOBXdNfC5RyG1h5743HAX9fE6D/s4iDD1lJUx45mvoTtjqcFAZBf5sV4H94BGr
	/HaRDCgYqGsEcU6qlLCyfRSeooFiNZjT/4TJ/A6fZA96OB5UAMCTthxFLpwrqpUuhRZjn0
	9wG9wvNqrwseXAx/l5B8CZcJ5PF+36yiFq6y1RwYjO3nuHE/T/+r6t18Pai+ZQ==
Date: Mon, 24 Feb 2025 15:04:40 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 12/13] net: phy: phylink: Use phy_caps_lookup
 for fixed-link configuration
Message-ID: <20250224150440.7fe5458d@kmaincent-XPS-13-7390>
In-Reply-To: <Z7x52C5dE3eXWomq@shell.armlinux.org.uk>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
	<20250222142727.894124-13-maxime.chevallier@bootlin.com>
	<20250224144431.2dca9d19@kmaincent-XPS-13-7390>
	<Z7x52C5dE3eXWomq@shell.armlinux.org.uk>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrt
 ghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 24 Feb 2025 13:53:28 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Mon, Feb 24, 2025 at 02:44:31PM +0100, Kory Maincent wrote:
> > On Sat, 22 Feb 2025 15:27:24 +0100
> > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> >  =20
> > > When phylink creates a fixed-link configuration, it finds a matching
> > > linkmode to set as the advertised, lp_advertising and supported modes
> > > based on the speed and duplex of the fixed link.
> > >=20
> > > Use the newly introduced phy_caps_lookup to get these modes instead of
> > > phy_lookup_settings(). This has the side effect that the matched
> > > settings and configured linkmodes may now contain several linkmodes (=
the
> > > intersection of supported linkmodes from the phylink settings and the
> > > linkmodes that match speed/duplex) instead of the one from
> > > phy_lookup_settings(). =20
> >=20
> > ...
> >  =20
> > > =20
> > >  	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
> > >  	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
> > > @@ -588,9 +591,9 @@ static int phylink_parse_fixedlink(struct phylink=
 *pl,
> > > =20
> > >  	phylink_set(pl->supported, MII);
> > > =20
> > > -	if (s) {
> > > -		__set_bit(s->bit, pl->supported);
> > > -		__set_bit(s->bit, pl->link_config.lp_advertising);
> > > +	if (c) {
> > > +		linkmode_or(pl->supported, pl->supported, match);
> > > +		linkmode_or(pl->link_config.lp_advertising,
> > > pl->supported, match); =20
> >=20
> > You are doing the OR twice. You should use linkmode_copy() instead. =20
>=20
> No, we don't want to copy pl->supported to
> pl->link_config.lp_advertising. We just want to set the linkmode bit
> that corresponds to the speed/duplex in each mask.
>=20
> That will result in e.g. the pause mode bits will be overwritten despite
> being appropriately set in the advertising mask in the code above this.

Ok, so the right thing should be this:
linkmode_or(pl->link_config.lp_advertising, pl->link_config.lp_advertising,
	    match)

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

