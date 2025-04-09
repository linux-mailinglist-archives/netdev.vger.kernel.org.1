Return-Path: <netdev+bounces-180637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A95A81F93
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AB34A7D1D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4192505AA;
	Wed,  9 Apr 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SXbU84yx"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09818FC75;
	Wed,  9 Apr 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186695; cv=none; b=ubOpkhR8FJwBjYKveeTVVwrauI/r9nGfKVd4ZCffhNR3ZX7lwaehiXSrSCJcHZb0Yn7EIfNARRsuRaGNfyhtkDO3YahFoFpmd8r7ppL+VWLXYucdKsU3MLmgydFGnimx/t4kJVNzoutOgsLBXaRccVQ+ew5pemMj6CtJqAlgiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186695; c=relaxed/simple;
	bh=ZWg+mSGoUBjLS3Iq/MflbPPUiI1DmKUlohQQrKNWe58=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gGvLl8i33Mxpf8wIuQrKg8uFAG7B0y1Y1QoBFED9chGJl1IOqft7AWbh1t0iO3B3b0Ksv4SL6YFH3l9bmzvBZ1lqLjTVo/ek9Fo650bMgRPmoP2Kdmk7K8B4sjv/nIz4hGLH7FmorItTZ3sZIrq5H+IFkitVO+jn682K9aHIGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SXbU84yx; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3F4F543281;
	Wed,  9 Apr 2025 08:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744186691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7/sUB4NKSKcBZ2AS73T3m/vvUDAL6vhtK3n+glPbSU=;
	b=SXbU84yxeIjUgNSlnWszEPbWrUZATdskY+g4qvNrroLs1qbcM8ARdcwmCKSmsWt2iyLHN1
	AO79A+BH1KPUDvrtlOboJzCPsv1k5PkNqLWrcarzrUj9jkpdryFXYYOp6sWFruPKYpCTle
	7Mi23qPgvKrRfyf8oCr+yfRsZ4kYcUJPluUe3NmrRw9QCVEen0R1itge0OA7HnTUdCYgWA
	e+XKhxZIwOdQ3HlOWfudaKaKKNdQTQ7Gl+1Y6Wg8FnqBbjHy1S7Fith32wu1IncEedV8O7
	P9KjNiuMWhE7K9j4HPyR0V9Df30QpiKTdjo8S/EHMCnb3j4dUQFk9/XXseSIqw==
Date: Wed, 9 Apr 2025 10:18:08 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250409101808.43d5a17d@kmaincent-XPS-13-7390>
In-Reply-To: <Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
	<20250408154934.GZ395307@horms.kernel.org>
	<Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghms
 egurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 8 Apr 2025 18:32:04 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Tue, Apr 08, 2025 at 04:49:34PM +0100, Simon Horman wrote:
> > On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote: =20
> > > From: Russell King <rmk+kernel@armlinux.org.uk>
> > >=20
> > > From: Russell King <rmk+kernel@armlinux.org.uk>
> > >=20
> > > Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> > > timestamping the egress and ingress of packets, but does not support
> > > any packet modification.
> > >=20
> > > The PHYs support hardware pins for providing an external clock for the
> > > TAI counter, and a separate pin that can be used for event capture or
> > > generation of a trigger (either a pulse or periodic).  This code does
> > > not support either of these modes.
> > >=20
> > > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > > drivers.  The hardware is very similar to the implementation found in
> > > the 88E6xxx DSA driver, but the access methods are very different,
> > > although it may be possible to create a library that both can use
> > > along with accessor functions.
> > >=20
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > >=20
> > > Add support for interruption.
> > > Fix L2 PTP encapsulation frame detection.
> > > Fix first PTP timestamp being dropped.
> > > Fix Kconfig to depends on MARVELL_PHY.
> > > Update comments to use kdoc.
> > >=20
> > > Co-developed-by: Kory Maincent <kory.maincent@bootlin.com>
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
> >=20
> > Hi Kory,
> >=20
> > Some minor feedback from my side.
> >  =20
> > > ---
> > >=20
> > > Russell I don't know which email I should use, so I keep your old SOB=
. =20
> >=20
> > Russell's SOB seems to be missing. =20
>=20
> ... and anyway, I haven't dropped my patches, I'm waiting for the
> fundamental issue with merging Marvell PHY PTP support destroying the
> ability to use MVPP2 PTP support to be solved, and then I will post
> my patches.
>=20
> They aren't dead, I'm just waiting for the issues I reported years ago
> with the PTP infrastructure to be resolved - and to be tested as
> resolved.
>=20
> I'm still not convinced that they have been given Kory's responses to
> me (some of which I honestly don't understand), but I will get around
> to doing further testing to see whether enabling Marvell PHY PTP
> support results in MVPP2 support becoming unusable.
>=20
> Kory's lack of communication with me has been rather frustrating.

You were in CC in all the series I sent and there was not a lot of review a=
nd
testing on your side. I know you seemed a lot busy at that time but I don't
understand what communication is missing here?=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

