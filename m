Return-Path: <netdev+bounces-180818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC1A82939
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B69A231D
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5646526773F;
	Wed,  9 Apr 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ATAPiJmn"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE4264633;
	Wed,  9 Apr 2025 14:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210173; cv=none; b=VXSLDfkb35gX16zvG4+Gx3M8A9xOUMVHp2VVpevgdBeQy+YUMH8Z3wPPCvjDv94xMVEVIzSaxR98TIJT4MrNf3N8HHvjl+Y8phYI1fbRZ/jndKmEX0PUaTxLGp7piSzAbQIpiRN1v7mOCRbzemvQERAvG7IddINwdPa1XpVAbEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210173; c=relaxed/simple;
	bh=07QypnSemJ6N4KpkR5GbszKUU6eGU0VWeKKzV9WAYkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVuzzg7rzJ8jvHZ4RYd/HwL8x2ylHttALmH4EyuMzdqYEOZn1pmGck/ohrP6peef3UJ3RxRrvRp2fDK+tKMOd63udXKDWy5XpHajdGyM1BrVPnW4U46sGWfnYOL1FgDi4VsxrgQQ+NIAySgfdzT9a+b+1VlLs7TWR1CYA0oI2Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ATAPiJmn; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E239E441AE;
	Wed,  9 Apr 2025 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744210162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsP1KTv2XYPfGaf4M7Q7suclDVzNu6V2bzVq2CpRjnQ=;
	b=ATAPiJmn3ezHE9H5bkksUbLkZzerTfqYRTtXDvk81wyHnoc8tNfPf1liuoh5Kk2mhuYbws
	M9iOSaQzhqlDZ7dc2vjsv73jJul6MRBwp3XQhN4pU1T0HcxhvUuh7LD95PkRH4bH4EHE3E
	TJWPZuX0g0Qu66sWRXzaG2yG3Zgmcei+sqL2r7WqP39CbboXO2HdRw9/xgGNqZGvDJ7jOn
	qavWCztoh2eT5gxjNEeNJ87m3RRvEDiDjQLyrLC8zZJjWutue5NxUM2txr7rmVhK7GWnUQ
	ZIuDtVDwM3mv1ucTZtqgZqZyiw1BOkMkOfmn0K+XvDj7Egw/Uy2ecAS8z9duxQ==
Date: Wed, 9 Apr 2025 16:49:20 +0200
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
Message-ID: <20250409164920.5fbc3fd1@kmaincent-XPS-13-7390>
In-Reply-To: <20250409144654.67fae016@fedora.home>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeivdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmp
 dhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 9 Apr 2025 14:46:54 +0200
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> On Wed, 9 Apr 2025 14:23:09 +0200
> Kory Maincent <kory.maincent@bootlin.com> wrote:
>=20
> > On Wed, 9 Apr 2025 10:29:52 +0100
> > "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
> >  =20
> > > On Wed, Apr 09, 2025 at 10:46:37AM +0200, Kory Maincent wrote:   =20
>  [...] =20
> >  =20
>  [...] =20
>  [...] =20
> > >=20
> > > How do I know that from the output? Nothing in the output appears to
> > > tells me which PTP implementation will be used.
> > >=20
> > > Maybe you have some understanding that makes this obvious that I don't
> > > have.   =20
> >=20
> > You are right there is no report of the PTP source device info in ethto=
ol.
> > With all the design change of the PTP series this has not made through =
my
> > brain that we lost this information along the way.
> >=20
> > You can still know the source like that but that's not the best.
> > # ls -l /sys/class/ptp
> >=20
> > It will be easy to add the source name support in netlink but which nam=
es
> > are better report to the user?
> > - dev_name of the netdev->dev and phydev->mdio.dev?
> >   Maybe not the best naming for the phy PTP source
> >   (ff0d0000.ethernet-ffffffff:01)
> > - "PHY" + the PHY ID and "MAC" string? =20
>=20
> How about an enum instead of a string indicating the device type, and if
> PHY, the phy_index ? (phy ID has another meaning :) )

This will raise the same question I faced during the ptp series mainline
process. In Linux, the PTP is managed through netdev or phylib API.
In case of a NIC all is managed through netdev. So if a NIC has a PTP at th=
e PHY
layer how should we report that? As MAC PTP because it goes thought netdev,=
 as
PHY PTP but without phyindex?
That's why maybe using netlink string could assure we won't have UAPI break=
age
in the future due to weird cases.
What do you think?
=20
Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

