Return-Path: <netdev+bounces-180829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF534A829F8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3EBE462373
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 15:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8FA262804;
	Wed,  9 Apr 2025 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VzeOMvip"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C617C224;
	Wed,  9 Apr 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744211675; cv=none; b=H59z7R4ZkzNGYrGdw8ZpI3AQb2qVqsIOlS6MkJ/LjKFULAb1va0Ctjo1PZ+8M3YLOXj/xs5QZVGbS2ZMzOJ2OBKKgncRzNSLqYO4OuzRRW2ZNDQK/Powab4exedgA+jReO++NzzCWdCUvUTsujWcSHvnW+vtywefDD5xpAQDqos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744211675; c=relaxed/simple;
	bh=4pv6xbJxx0FGOS5p+DoZTJASD5VN3ptTlbrUPvCbD0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgpdPTzd98xLmVwEnpK+aeQCEvvpetTU9Y7XFTekFLIhhPMl0At1iBP7jrKmA2g3M/cRV9kYmxNwtT2oKS0hT2QHKrXzaBZqMUvJNcmpEafqmwMFO30Fc3I95Xmf+M0lXRbWPj2sXPmRvtKApM9EX87nv0fzblOZrBbE+oDM7Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VzeOMvip; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73EBF433E8;
	Wed,  9 Apr 2025 15:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744211671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SFhdSIbhQQFQ25tC/H1tGZS1MIYQhE75YEayy/jgE8=;
	b=VzeOMvipLpW8qfpw6FnWEdsmt3E8apRA+vaip6pEQNq4YJyjnbrwm7pSGscBJhI9zlLG5T
	/AUaSu0xGngOYq1dxx5l8bZ7O/cJ+Fk5zQ3o/XgFty3Q+iAAkvO3mYg5ynx+kAOEnw+/eA
	6zx8ECZS+nqI2VMdZVvlwoTZpCRD2+VU+tTDTIjtx3d7uy5X6YtMemjg3S+PlYOr2PHMi0
	0kDKcU3VdEVJ/o600tXjO1mmpsSD887PII34Id8I2dit/iL1e9bFBRx6zw5OngWCxcBLRm
	DUCCqBH/6MwZbzjAYKSKRjOCxBmk/a9dnPV6cvi+cKyF/CQVXEhspiEkQZOgqA==
Date: Wed, 9 Apr 2025 17:14:29 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVo?=
 =?UTF-8?B?w7pu?= <kabel@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [PATCH net-next v2 0/2] Add Marvell PHY PTP support
Message-ID: <20250409171429.3e9ced7d@kmaincent-XPS-13-7390>
In-Reply-To: <20250409171055.43e51012@fedora.home>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<Z_P3FKEhv1s0y4d7@shell.armlinux.org.uk>
	<20250407182028.75531758@kmaincent-XPS-13-7390>
	<Z_P-K7mEEH6ProlC@shell.armlinux.org.uk>
	<20250407183914.4ec135c8@kmaincent-XPS-13-7390>
	<Z_WJO9g5Al1Yr_LX@shell.armlinux.org.uk>
	<20250409103130.43ab4179@kmaincent-XPS-13-7390>
	<Z_Yxb6-qclDSWk01@shell.armlinux.org.uk>
	<20250409104637.37301e01@kmaincent-XPS-13-7390>
	<Z_Y-ENUiX_nrR7VY@shell.armlinux.org.uk>
	<20250409142309.45cdd62f@kmaincent-XPS-13-7390>
	<20250409144654.67fae016@fedora.home>
	<20250409164920.5fbc3fd1@kmaincent-XPS-13-7390>
	<20250409171055.43e51012@fedora.home>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeifeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmp
 dhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 17:10:55 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> On Wed, 9 Apr 2025 16:49:20 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > On Wed, 9 Apr 2025 14:46:54 +0200
> > Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> >  =20
> > > On Wed, 9 Apr 2025 14:23:09 +0200
> > > Kory Maincent <kory.maincent@bootlin.com> wrote:

> > > How about an enum instead of a string indicating the device type, and=
 if
> > > PHY, the phy_index ? (phy ID has another meaning :) )   =20
> >=20
> > This will raise the same question I faced during the ptp series mainline
> > process. In Linux, the PTP is managed through netdev or phylib API.
> > In case of a NIC all is managed through netdev. So if a NIC has a PTP at
> > the PHY layer how should we report that? As MAC PTP because it goes tho=
ught
> > netdev, as PHY PTP but without phyindex? =20
>=20
> Are you referring to the case where the PHY is transparently handled by
> the MAC driver (i.e. controlled through a firmware of some sort) ?

Yes I was.
=20
> In such case, how do you even know that timestamping is done in a PHY,
> as the kernel doesn't know the PHY even exists ? The
> HWTSTAMP_SOURCE_XXX enum either says it's from PHYLIB or NETDEV. As
> PHYs handled by firmwares don't go through phylib, I'd say reporting
> "PHY with no index" won't be accurate.
>=20
> In such case I'd probably expect the NIC driver to register several
> hwtstamp_provider with different qualifiers
>=20
> > That's why maybe using netlink string could assure we won't have UAPI
> > breakage in the future due to weird cases.
> > What do you think? =20
>=20
> Well I'd say this is the same for enums, nothing prevents you from
> adding more values to your enum ?

Thanks! I am ok with that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

