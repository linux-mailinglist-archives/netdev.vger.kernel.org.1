Return-Path: <netdev+bounces-165157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE35A30B23
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 13:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3BE7165910
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8FE1FBCBC;
	Tue, 11 Feb 2025 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VtAkFhbA"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E8D1F12FC;
	Tue, 11 Feb 2025 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739275719; cv=none; b=ZFzzrOF7FOBXPZ8C3zoOPM4KkVMe2dKPbK+OqUr8Fpdohp1bg0bzLhs9rHnSdRVBZQOUY37/MDCWKK4T9iZKkP/sEYSOfk8kDx2bdiNku1jF4VCgV0BBb3ae1C+YSQQgvkwEuNRmf3TxgnsZKXFPCNFZMcY2k8hjgsUE1K2Y6b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739275719; c=relaxed/simple;
	bh=iaxaLe63jvfdcGs98she5ZOmX8j+McmROb7osfhGF1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDtskwGI9aUHrAJ441xv9SPLRVRY86u7G9NK/5Y7uNOF4wzo4dToN77i4dLLKhXJIfeyv82mFdaD7V9PIJ/jeysV0ImSTSDEEiwuE6EOKCjDscTtKuEgjZ57dZB5CaRMkLNw0BTX/DCagISucJQjVPGlcDrvqe18BvUE4P0NixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VtAkFhbA; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6626844206;
	Tue, 11 Feb 2025 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739275714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjM6wR9lV3rjjatXl5KU7qPYxVjUzsxsOmxpjHWtsxE=;
	b=VtAkFhbAS3bE2SKQENlezoNTiJPUHb07Kf/zDfc78REU3jItmxKRYLPJXAWRl0MAWXM5Tz
	1jjoLHWM7IG3BzdF0j123Sd1yOWtYhtkcMuI+UfkXSukxFEuSvm5RYxA9glWHiaqVtgW7G
	u9GmyyhmyZbKpcJeO4FPAs04Un2a1ostkVoNzl7nH96RcHRBQsmPDhFmSwmmCh7iU8k2eH
	9kcKRXACG7Tr/uuw+gmeobox7XiENpzstu6KHVfN6YcUCRmrf/h1cIkwqXnQLs2aAy91x6
	7Pi6tZorp7z5MpMK+TRD+yZS4jZOOrQduOywVRol1FFn/uYHWG77M9Zx7IyViw==
Date: Tue, 11 Feb 2025 13:08:30 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>
Subject: Re: [PATCH net-next RFC v2 2/6] net: ethtool: Introduce
 ETHTOOL_LINK_MEDIUM_* values
Message-ID: <20250211130830.25dbafb3@fedora.home>
In-Reply-To: <20250123103534.1ca273af@kmaincent-XPS-13-7390>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
	<20250122174252.82730-3-maxime.chevallier@bootlin.com>
	<20250123103534.1ca273af@kmaincent-XPS-13-7390>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegtdeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedviedprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi K=C3=B6ry,

On Thu, 23 Jan 2025 10:35:34 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> On Wed, 22 Jan 2025 18:42:47 +0100
> Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
>=20
> > In an effort to have a better representation of Ethernet ports,
> > introduce enumeration values representing the various ethernet Mediums.
> >=20
> > This is part of the 802.3 naming convention, for example :
> >=20
> > 1000 Base T 4
> >  |    |   | |
> >  |    |   | \_ lanes (4)
> >  |    |   \___ Medium (T =3D=3D Twisted Copper Pairs)
> >  |    \_______ Baseband transmission
> >  \____________ Speed
> >=20
> >  Other example :
> >=20
> > 10000 Base K X 4
> >            | | \_ lanes (4)
> >            | \___ encoding (BaseX is 8b/10b while BaseR is 66b/64b)
> >            \_____ Medium (K is backplane ethernet)
> >=20
> > In the case of representing a physical port, only the medium and number
> > of lanes should be relevant. One exception would be 1000BaseX, which is
> > currently also used as a medium in what appears to be any of
> > 1000BaseSX, 1000BaseFX, 1000BaseCX and 1000BaseLX. =20
>=20
>=20
>=20
> > -	__DEFINE_LINK_MODE_PARAMS(100, T, Half),
> > -	__DEFINE_LINK_MODE_PARAMS(100, T, Full),
> > -	__DEFINE_LINK_MODE_PARAMS(1000, T, Half),
> > -	__DEFINE_LINK_MODE_PARAMS(1000, T, Full),
> > +	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Half, T),
> > +	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Full, T),
> > +	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Half, T),
> > +	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Full, T), =20
>=20
>=20
> > -	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full),
> > -	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full),
> > -	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full),
> > +	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full, K),
> > +	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full, K),
> > +	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full, K), =20
>=20
> The medium information is used twice.
> Maybe we could redefine the __DEFINE_LINK_MODE_PARAMS like this to avoid
> redundant information:
> #define __DEFINE_LINK_MODE_PARAMS(_speed, _medium, _encoding, _lanes, _du=
plex)
>=20
> And something like this when the lanes are not a fix number:
> #define __DEFINE_LINK_MODE_PARAMS_LANES_RANGE(_speed, _medium, _encoding,
> _min_lanes, _max_lanes, _duplex)
>=20
> Then we can remove all the __LINK_MODE_LANES_XX defines which may be
> wrong as you have spotted in patch 1.

My apologies, I missed your review and didn't address it in the new
iteration :(

I will give this a try, see hw this looks, so that we can separate the
encoding info from the medium info.

Thanks !

Maxime

> Regards,


