Return-Path: <netdev+bounces-180655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFBFA82090
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DB8463D04
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 08:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ABA25D1F1;
	Wed,  9 Apr 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KQRoMoVA"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60D25C71A;
	Wed,  9 Apr 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744188544; cv=none; b=kzselmc8qvi4qaWYIBfPAbqd1huvBZ2F8KK97FcbDJMMajQxEVNriyLrhtUM8MljX7f+aXMnXqiUeLUKxzdfd3nFuT2GtExxWZuDDda9MrwGuue7ff+tfEUX/l62IzRCzQzHKEobIbY9ujChfdv8JnuvDcl05dEwOXGWcetNgtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744188544; c=relaxed/simple;
	bh=pMDhXpHEneTMYFt5i3NFp+rGFh7whXli1PrlDbT6MIg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFbTBJYAiqa7bqkwsNNGPyHsaNzBv1ylTAsQhQiBNJ/fKuksDBFkQpLLHPjqO6jTRChSmLGFh9a3QTRYZ2Wn/toxAXFQQU06g0aUOw7shLBWRE4yW17ZlWaoLvi24+M6RGraq6AEob7TISCAJo3MTJq1NPOUlIUXkrUOZjjXsNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KQRoMoVA; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 17FFF432FB;
	Wed,  9 Apr 2025 08:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744188539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RQmvAGch9i+jrpaeoacuHgLxUyYJopp3wNNPqVGXr28=;
	b=KQRoMoVAv7R4wEpDp4VQ8W/wI55S5ZoL08qXD/2EX8qgOLK1sOdq4/hgS3iqyAKlL8O6Ob
	VLolNjCovHMN0ccQadDQiCHUmll1VRaSvuD4dbgaZXq4mT6hEnDt3Mu1sFeOkyQbCF6ORP
	GgadHr4712CaDS4tAavr8GDpgX09xuc7tl3mHSEUg+CwFUCOCAWVTPQH8d7HlFfnsN1Ndj
	sTJfT7YfT/9meh1EMzHbvLNt6pOvjIy8upP9DyRHgTm+uir3vengKYgjFt7VEEl1PiA9uD
	CMRZTTxE3Oft8DBgNBru5tDHKmIIJxhaHLNsVjgX7xcdWznVvv/VGmFN3up33Q==
Date: Wed, 9 Apr 2025 10:48:58 +0200
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
Message-ID: <20250409104858.2758e68e@kmaincent-XPS-13-7390>
In-Reply-To: <Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
	<20250408154934.GZ395307@horms.kernel.org>
	<Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
	<20250409101808.43d5a17d@kmaincent-XPS-13-7390>
	<Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdehheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptefgfeffgeelkeeugfejkeetveeffeelveetffefgeeuhfffjeejvdfgueeltdffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrt
 ghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 09:33:09 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 09, 2025 at 10:18:08AM +0200, Kory Maincent wrote:
> > On Tue, 8 Apr 2025 18:32:04 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > On Tue, Apr 08, 2025 at 04:49:34PM +0100, Simon Horman wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > ... and anyway, I haven't dropped my patches, I'm waiting for the
> > > fundamental issue with merging Marvell PHY PTP support destroying the
> > > ability to use MVPP2 PTP support to be solved, and then I will post
> > > my patches.
> > >=20
> > > They aren't dead, I'm just waiting for the issues I reported years ago
> > > with the PTP infrastructure to be resolved - and to be tested as
> > > resolved.
> > >=20
> > > I'm still not convinced that they have been given Kory's responses to
> > > me (some of which I honestly don't understand), but I will get around
> > > to doing further testing to see whether enabling Marvell PHY PTP
> > > support results in MVPP2 support becoming unusable.
> > >=20
> > > Kory's lack of communication with me has been rather frustrating. =20
> >=20
> > You were in CC in all the series I sent and there was not a lot of revi=
ew
> > and testing on your side. I know you seemed a lot busy at that time but=
 I
> > don't understand what communication is missing here?  =20
>=20
> I don't spend much time at the physical location where the hardware that
> I need to test your long awaited code is anymore. That means the
> opportunities to test it are *rare*.
>=20
> So far, each time I've tested your code, it's been broken. This really
> doesn't help.
>=20
> If you want me to do anything more in a timely manner, like test fixes,
> you need to get them to me by the end of this week, otherwise I won't
> again be able to test them for a while.

You could try again with Vlad patch adding support to ndo_hwtstamp_get/set =
to
the mvpp2 drivers.
https://github.com/vladimiroltean/linux/commit/5bde95816f19cf2872367ecdbef1=
efe476e4f833

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

