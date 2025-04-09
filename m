Return-Path: <netdev+bounces-180634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086EA81F69
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE0719E6689
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF7825B664;
	Wed,  9 Apr 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bvmb8Pp6"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0A62AEE1;
	Wed,  9 Apr 2025 08:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744186086; cv=none; b=HGopCNvdZ6OBIdlbMLo/2FUvq6QW7Psn7TxV3b740zdYt3ADuzMe8amfIAqTXURf4o5nSnLrnfksab3bekMCb9v1F8TV2joD30fsA/LoItrn3nY1dT24tGNRTm6ZryQ8HTyX+X4knSb+Q95fUQ6b3X46UYRXmMmCMgpkz+5Jnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744186086; c=relaxed/simple;
	bh=mr30LqQNuOU/mnzqldP4MFp4kss1djxh3XdJuJwiAv4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUOQ3TwrrdIZ8lNWlJvNXV8KqRGdmO1XRxMqK8F3ZiBb2lsHQ6kAg7vkWUpnLfzNUzuIIRCQqebGUmYfu1XGQUuYyDTnGEEGCrKrptd0bwelZoXkSseu8AbdWxGndgG68zb2v/8Q6YMtsLzilcVESMSzo+5mC+5TESEoTZrOJWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bvmb8Pp6; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F1A7B441AF;
	Wed,  9 Apr 2025 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744186081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFUfFgfJTA0MILjsOsmPCJVk3I0D8ZM1lWoFzTiqBKg=;
	b=bvmb8Pp6jaS92eFONTiFof35qCJj58LQjhIATmSV5tPo9ieH6i0dUdlj/g9fvhZIP3M2uD
	nZ/To+zfv+6VmNt/ep0/FRRWJ/sWllxpxFaEn1Ne5wsEZ/rqSkxMAXJAwU4JuJ17NEthNL
	zFXp1UcTNwa7r5z4N5RYvFyGAIBWkonYUyD1mEbTN/HoLAR2Cnu4ZV5/h6NPUtZD3TiQSU
	GnOxqQeOv1kRsggAmiZb1zPTPNM50flsElE5fuAwj8SgyOBWK6oBK21afj5PPXeixWagnU
	J9CwMzMQjAerTQBfNX9NvXKyAzjeRZyU2W+9mgbfMhnGEfTp/egzOHklhF6ojA==
Date: Wed, 9 Apr 2025 10:07:57 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Marek =?UTF-8?B?QmVo?=
 =?UTF-8?B?w7pu?= <kabel@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH net-next v2 2/2] net: phy: Add Marvell PHY PTP support
Message-ID: <20250409100757.07b00067@kmaincent-XPS-13-7390>
In-Reply-To: <20250408154934.GZ395307@horms.kernel.org>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
	<20250408154934.GZ395307@horms.kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehgeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghms
 egurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 8 Apr 2025 16:49:34 +0100
Simon Horman <horms@kernel.org> wrote:

> On Mon, Apr 07, 2025 at 04:03:01PM +0200, Kory Maincent wrote:
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> >=20
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> >=20
> > Add PTP basic support for Marvell 88E151x PHYs. These PHYs support
> > timestamping the egress and ingress of packets, but does not support
> > any packet modification.
> >=20
> > The PHYs support hardware pins for providing an external clock for the
> > TAI counter, and a separate pin that can be used for event capture or
> > generation of a trigger (either a pulse or periodic).  This code does
> > not support either of these modes.
> >=20
> > The driver takes inspiration from the Marvell 88E6xxx DSA and DP83640
> > drivers.  The hardware is very similar to the implementation found in
> > the 88E6xxx DSA driver, but the access methods are very different,
> > although it may be possible to create a library that both can use
> > along with accessor functions.
> >=20
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >=20
> > Add support for interruption.
> > Fix L2 PTP encapsulation frame detection.
> > Fix first PTP timestamp being dropped.
> > Fix Kconfig to depends on MARVELL_PHY.
> > Update comments to use kdoc.
> >=20
> > Co-developed-by: Kory Maincent <kory.maincent@bootlin.com>
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com> =20
>=20
> Hi Kory,
>=20
> Some minor feedback from my side.
>=20
> > ---
> >=20
> > Russell I don't know which email I should use, so I keep your old SOB. =
=20
>=20
> Russell's SOB seems to be missing.

It is, 5 lines higher, but maybe you prefer to have them all together.=20

>=20
> ...
>=20
> > diff --git a/drivers/net/phy/marvell/marvell_tai.c
> > b/drivers/net/phy/marvell/marvell_tai.c =20
>=20
> ...
>=20
> > +/* Read the global time registers using the readplus command */
> > +static u64 marvell_tai_clock_read(const struct cyclecounter *cc)
> > +{
> > +	struct marvell_tai *tai =3D cc_to_tai(cc);
> > +	struct phy_device *phydev =3D tai->phydev;
> > +	int err, oldpage, lo, hi;
> > +
> > +	oldpage =3D phy_select_page(phydev, MARVELL_PAGE_PTP_GLOBAL);
> > +	if (oldpage >=3D 0) {
> > +		/* 88e151x says to write 0x8e0e */
> > +		ptp_read_system_prets(tai->sts);
> > +		err =3D __phy_write(phydev, PTPG_READPLUS_COMMAND, 0x8e0e);
> > +		ptp_read_system_postts(tai->sts);
> > +		lo =3D __phy_read(phydev, PTPG_READPLUS_DATA);
> > +		hi =3D __phy_read(phydev, PTPG_READPLUS_DATA);
> > +	} =20
>=20
> If the condition above is not met then err, lo, and hi may be used
> uninitialised below.
>=20
> Flagged by W=3D1 builds with clang 20.1.2, and Smatch.

Indeed thanks!

> > +	tai->caps.max_adj =3D 1000000;
> > +	tai->caps.adjfine =3D marvell_tai_adjfine;
> > +	tai->caps.adjtime =3D marvell_tai_adjtime;
> > +	tai->caps.gettimex64 =3D marvell_tai_gettimex64;
> > +	tai->caps.settime64 =3D marvell_tai_settime64;
> > +	tai->caps.do_aux_work =3D marvell_tai_aux_work;
> > +
> > +	tai->ptp_clock =3D ptp_clock_register(&tai->caps, &phydev->mdio.dev);
> > +	if (IS_ERR(tai->ptp_clock)) {
> > +		kfree(tai); =20
>=20
> tai is freed on the line above, but dereferenced on the line below.
>=20
> Flagged by Smatch.

Indeed thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

