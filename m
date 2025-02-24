Return-Path: <netdev+bounces-169021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D859A421D0
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 14:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC073A5EF5
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C367623BCE9;
	Mon, 24 Feb 2025 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fnUouyOp"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9723372B;
	Mon, 24 Feb 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740404683; cv=none; b=DhNITY3Qa5qigW0yKBWlJjU9KPwlI/eDia8ExqwXm85QxrIlmG1aIb1KVkTICBUDFt8zvS4pedfy3amDSp5BiXqRj1fBh4ZDkm1xiCnbQKzxWwUR1w4uJ+/vGwPVBLejEg6aD48hAGrbKhIXdqMlbR/WJ1bEJRYTsBKig9OBGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740404683; c=relaxed/simple;
	bh=ChsQpr6FpnfFUMruwBSOsWL9jwA+YIJCuxM/Udd+VnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNp65zKQbsQFTBwcC2deAbJ+yQfuwzuZ6xQ3Xn2Fen7SP5I3+cJ96cNtoWf1G4RycAmFBkEI/J8d70vILLXy5pZc82Ij0Q3cM8zm7oQVPAFaYDvRAU0lRmLncUUoVePuS8S5cgoMM+DruH5A2Kxl75msLux6nKSCMLOOcUHRAyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fnUouyOp; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 80E21443ED;
	Mon, 24 Feb 2025 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740404674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gduisQ65ckcL60BLQX/XNFI+VFiFYoC2kP8U8Fmb59o=;
	b=fnUouyOpgPmeRPmgEGs06nupx3E7oHo1z4CT9wU71pkwuoCZDz9g1v9k837TIAJXohvjJL
	EsGg0HBhaK8EcjD3WbjbIO02c8tRgVa02e2uUokVEQS2/W49AjC9gQ4SDCBBStSy02ay7t
	INLIEXLelC1yTqM4kI8uo3tIXRO653y6rkGWWX/0VwEmzFpWAySiUqHB8h6d0iowJbGg7e
	eHhYG+LlpW9f2Rx/XojkGw4ysoEgJFaUC9jMNqDeTDf38bQLTB8QJg4DURba6P1oWLw5VN
	jUwEIBhSPCGE7zPx4FaDWw0v+/CApeQ/nHjuG4iBMKreBkUk1wLbbOAN17GBNQ==
Date: Mon, 24 Feb 2025 14:44:31 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 12/13] net: phy: phylink: Use phy_caps_lookup
 for fixed-link configuration
Message-ID: <20250224144431.2dca9d19@kmaincent-XPS-13-7390>
In-Reply-To: <20250222142727.894124-13-maxime.chevallier@bootlin.com>
References: <20250222142727.894124-1-maxime.chevallier@bootlin.com>
	<20250222142727.894124-13-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejkeelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduledprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepv
 gguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Sat, 22 Feb 2025 15:27:24 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> When phylink creates a fixed-link configuration, it finds a matching
> linkmode to set as the advertised, lp_advertising and supported modes
> based on the speed and duplex of the fixed link.
>=20
> Use the newly introduced phy_caps_lookup to get these modes instead of
> phy_lookup_settings(). This has the side effect that the matched
> settings and configured linkmodes may now contain several linkmodes (the
> intersection of supported linkmodes from the phylink settings and the
> linkmodes that match speed/duplex) instead of the one from
> phy_lookup_settings().

...

> =20
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, mask);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, mask);
> @@ -588,9 +591,9 @@ static int phylink_parse_fixedlink(struct phylink *pl,
> =20
>  	phylink_set(pl->supported, MII);
> =20
> -	if (s) {
> -		__set_bit(s->bit, pl->supported);
> -		__set_bit(s->bit, pl->link_config.lp_advertising);
> +	if (c) {
> +		linkmode_or(pl->supported, pl->supported, match);
> +		linkmode_or(pl->link_config.lp_advertising,
> pl->supported, match);

You are doing the OR twice. You should use linkmode_copy() instead.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

