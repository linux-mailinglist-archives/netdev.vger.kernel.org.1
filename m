Return-Path: <netdev+bounces-165446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 732BFA32108
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 09:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8B44188ABFD
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C7F2054E0;
	Wed, 12 Feb 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IHMcyV8h"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBB8204F73;
	Wed, 12 Feb 2025 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739348747; cv=none; b=Yluvx4uRKnjnE2YDJVIuX3rvGwENJBHXERupJw8YzdNHOpxyjUni7MTVjSND6bXGDGO15LrHVMGMp+XUp7blYb+kDW41rUte2qRTiM8bbx/3aid5WvVJ58lH69ToCiSaD7uZs7GC8E18WI90iYFYNlNSqZkGJMv+fZky185BwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739348747; c=relaxed/simple;
	bh=ukrkJzE51VQLzsAENhN/N7LN/GMW+1t1gZXt+vPnv1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0cz6MYbY+EJcGBNwQgMoNWPTpectjQ7m570rt4wbNfW2/eNfqo/DQsSkdGkGzgZL8vouf3g1DxgayYJoSU2LqLh7ZnOQDlR3x1wOKsDcBZhyL2QzyqG0nKjFQO2MGCTE+8Yi7umkMVi3jmjkim0V+xbTX0+hO9yqnwP6D4g3Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IHMcyV8h; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 05D781F764;
	Wed, 12 Feb 2025 08:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739348736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIgUAEyu8qolGLYGKy5KFxfJEdAWp4C5nM5+ktv2GAc=;
	b=IHMcyV8h5M35NbOnH2TZErLdEosb8U02k4tCGIImqJ6EV8fbbMmqTqCSKzDlZNQo8Wco1u
	8uW+ROGU8eRUvgKrTKcurNmd2W10HGBEpwW0z9NF8d9FLXtU5HCfk7IUsYrohzGnKwDJH/
	mvqcKl/1z/1VcISm8IA6+Uut6geE5JyF94KQeCR+MEcMgN4s3nIixUtJ8/odC9NJQoU2si
	pcqia8BfBySgTwAGCzLxkT8sXSxSziBm85Yt5lwjY9SLKjyVbID5IbK8Pwil388Vr/AVaH
	lCL0i74qj6/yahizFabye0IMDx90ma4miNOaUEi5xFbzbXHjSJFe/lMsUrjPBg==
Date: Wed, 12 Feb 2025 09:25:26 +0100
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
Message-ID: <20250212092526.544fb80e@fedora.home>
In-Reply-To: <20250211130830.25dbafb3@fedora.home>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
	<20250122174252.82730-3-maxime.chevallier@bootlin.com>
	<20250123103534.1ca273af@kmaincent-XPS-13-7390>
	<20250211130830.25dbafb3@fedora.home>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeuhfefgffgtdfhgffhvdfhhffhteeutdektefghfetveehheejjefgudeiudehudenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedviedprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi again K=C3=B6ry,

> Hi K=C3=B6ry,
>=20
> On Thu, 23 Jan 2025 10:35:34 +0100
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > On Wed, 22 Jan 2025 18:42:47 +0100
> > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> >  =20
> > > In an effort to have a better representation of Ethernet ports,
> > > introduce enumeration values representing the various ethernet Medium=
s.
> > >=20
> > > This is part of the 802.3 naming convention, for example :
> > >=20
> > > 1000 Base T 4
> > >  |    |   | |
> > >  |    |   | \_ lanes (4)
> > >  |    |   \___ Medium (T =3D=3D Twisted Copper Pairs)
> > >  |    \_______ Baseband transmission
> > >  \____________ Speed
> > >=20
> > >  Other example :
> > >=20
> > > 10000 Base K X 4
> > >            | | \_ lanes (4)
> > >            | \___ encoding (BaseX is 8b/10b while BaseR is 66b/64b)
> > >            \_____ Medium (K is backplane ethernet)
> > >=20
> > > In the case of representing a physical port, only the medium and numb=
er
> > > of lanes should be relevant. One exception would be 1000BaseX, which =
is
> > > currently also used as a medium in what appears to be any of
> > > 1000BaseSX, 1000BaseFX, 1000BaseCX and 1000BaseLX.   =20
> >=20
> >=20
> >  =20
> > > -	__DEFINE_LINK_MODE_PARAMS(100, T, Half),
> > > -	__DEFINE_LINK_MODE_PARAMS(100, T, Full),
> > > -	__DEFINE_LINK_MODE_PARAMS(1000, T, Half),
> > > -	__DEFINE_LINK_MODE_PARAMS(1000, T, Full),
> > > +	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Half, T),
> > > +	__DEFINE_LINK_MODE_PARAMS_LANES(10, T, 2, 4, Full, T),
> > > +	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Half, T),
> > > +	__DEFINE_LINK_MODE_PARAMS_LANES(100, T, 2, 4, Full, T),   =20
> >=20
> >  =20
> > > -	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full),
> > > -	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full),
> > > -	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full),
> > > +	__DEFINE_LINK_MODE_PARAMS(1000, KX, Full, K),
> > > +	__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full, K),
> > > +	__DEFINE_LINK_MODE_PARAMS(10000, KR, Full, K),   =20
> >=20
> > The medium information is used twice.
> > Maybe we could redefine the __DEFINE_LINK_MODE_PARAMS like this to avoid
> > redundant information:
> > #define __DEFINE_LINK_MODE_PARAMS(_speed, _medium, _encoding, _lanes, _=
duplex)
> >=20
> > And something like this when the lanes are not a fix number:
> > #define __DEFINE_LINK_MODE_PARAMS_LANES_RANGE(_speed, _medium, _encodin=
g,
> > _min_lanes, _max_lanes, _duplex)
> >=20
> > Then we can remove all the __LINK_MODE_LANES_XX defines which may be
> > wrong as you have spotted in patch 1. =20
>=20
> I will give this a try, see hw this looks, so that we can separate the
> encoding info from the medium info.

So I did give it a go, but it turns out to be much more complex than
expected... The _type information from definitions like :

__DEFINE_LINK_MODE_PARAMS(10000, KX4, Full, K),

(here _type is KX4) can't really be split into the individual
attributes <Medium, Encoding, Lanes> without having some complex macro
logic. This type is used to convert to actual linkmodes that already
exist in the kernel :

#define ETHTOOL_LINK_MODE(speed, type, duplex) \
	ETHTOOL_LINK_MODE_ ## speed ## base ## type ## _ ## duplex ## _BIT

Say we want to generate the _type from <Medium, Encoding, Lanes> with a
macro, we have to cover all the weird cases :

1000BaseT =3D> No encoding, no lanes
10000BaseKX4 =3D> K medium, X encoding, 4 lanes
10000BeseKX =3D> K medium, X encding, no lanes (which means 1 lane)
1000BaseX =3D> Just encoding
100000BaseLR4_ER4 =3D> One link mode that applies for 2 mediums ?

While doable, this will probably end-up more complex and hard to
maintain than re-specifying the medium :(

Maxime

