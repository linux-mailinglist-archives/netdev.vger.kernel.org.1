Return-Path: <netdev+bounces-180742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F3DA8250B
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BC33173D09
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A27425E465;
	Wed,  9 Apr 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZImdO5Zr"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6825E464;
	Wed,  9 Apr 2025 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744202306; cv=none; b=TceBLw3kDaeql4/GWUopwOtaZpAuN6SxwVC+l+1fmAjI+SCXzbUW2iQFSKIxg53UzS9RNJ4woXO2obD+h5HQ8+VJOKbEUZ4vfhyu85TE0liFOTUXweN+sQe0dPi+MngPVOcYcaYC67aEFNi1F1J33TyamQaZ4ZlV8e6Ko4hFF48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744202306; c=relaxed/simple;
	bh=2SNTx5q9vFCxJlAR03UnE2J3anzFvwsnsMBxSHmXmrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RaIOXwBiqy4UFl+f5rNOnyNHPXs/h2DAXPv4u92rkOa6f8tfdDbt6E+q6jcmpVQeF1JIT9TRhpynBgHxrW8BtB7YJC81Zpn/oVfa5Tdh/ERU8RTxKxbZNt78RZrNluTO3RtSw9tcsuc61kQsNk3Oma580BoFWNWllXFcKJ+Hop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZImdO5Zr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6FCC04318F;
	Wed,  9 Apr 2025 12:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744202302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/3h/CgjlzmDrDN0HV7EfEznZDQLY9I1gv3XAhfIymWg=;
	b=ZImdO5ZrqwVVxKyD54pYYb4FSjUHL141/D4x0ROezwRe+opQflXvF69dgqrlP9HDXeZhI5
	+VNgSP2RuffvN/itbAEbaX4+8u4hpFh0tsjOKYcDp50w4d+eqgID6tSl+1ky79HYXpYzOF
	/kiTdvusXKm+29KOjin+EXIRYyLnojp13HIf59/XaFJ4Z9eJTQUkh/+FC3HvNP8VPGvqcE
	2VoCg0ZFAwHcsQEs3nbkFixNi/mCy4ypRRP2uD6lc+mUfFBJLiYcRvmzPSiqgdzXBPj5uj
	cQ049gZefmnFmff0qqgJ2P+X5HPfezqatFgs+feAH57vne8egtiXwcc/g6LSmQ==
Date: Wed, 9 Apr 2025 14:38:20 +0200
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
Message-ID: <20250409143820.51078d31@kmaincent-XPS-13-7390>
In-Reply-To: <Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
References: <20250407-feature_marvell_ptp-v2-0-a297d3214846@bootlin.com>
	<20250407-feature_marvell_ptp-v2-2-a297d3214846@bootlin.com>
	<20250408154934.GZ395307@horms.kernel.org>
	<Z_VdlGVJjdtQuIW0@shell.armlinux.org.uk>
	<20250409101808.43d5a17d@kmaincent-XPS-13-7390>
	<Z_YwxYZc7IHkTx_C@shell.armlinux.org.uk>
	<20250409104858.2758e68e@kmaincent-XPS-13-7390>
	<Z_ZlDLzvu_Y2JWM8@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeitdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptefgfeffgeelkeeugfejkeetveeffeelveetffefgeeuhfffjeejvdfgueeltdffnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrt
 ghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 13:16:12 +0100
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Apr 09, 2025 at 10:48:58AM +0200, Kory Maincent wrote:
> > On Wed, 9 Apr 2025 09:33:09 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > On Wed, Apr 09, 2025 at 10:18:08AM +0200, Kory Maincent wrote: =20
>  [...] =20
>  [...] =20
> > >  [...] =20
> > >  [...] =20
> > >  [...] =20
> > >  [...] =20
> > >  [...]   =20
>  [...] =20
>  [...] =20
> > >=20
> > > I don't spend much time at the physical location where the hardware t=
hat
> > > I need to test your long awaited code is anymore. That means the
> > > opportunities to test it are *rare*.
> > >=20
> > > So far, each time I've tested your code, it's been broken. This really
> > > doesn't help.
> > >=20
> > > If you want me to do anything more in a timely manner, like test fixe=
s,
> > > you need to get them to me by the end of this week, otherwise I won't
> > > again be able to test them for a while. =20
> >=20
> > You could try again with Vlad patch adding support to ndo_hwtstamp_get/=
set
> > to the mvpp2 drivers.
> > https://github.com/vladimiroltean/linux/commit/5bde95816f19cf2872367ecd=
bef1efe476e4f833
> > =20
>=20
> Well, I'm not sure PTP is working correctly.
>=20
> On one machine (SolidRun Hummingboard 2), I'm running ptpd v2:

...
=20
> So we can see that ptpdv2 is responding to the delay requests, but it
> seems that ptp4l doesn't see them, but it is seeing the other messages
> from the HB2 running in master mode. I don't have time to investigate
> any further until later today, and then again not until tomorrow
> evening.

Ok, thanks for the tests and these information.
Did you run ptp4l with this patch applied and did you switch to Marvell PHY=
 PTP
source?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

