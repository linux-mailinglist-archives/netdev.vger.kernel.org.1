Return-Path: <netdev+bounces-177486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 660EBA704F7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 16:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4F471675C2
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621F025D8F7;
	Tue, 25 Mar 2025 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YQc+EsDG"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6038425BAD7;
	Tue, 25 Mar 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916348; cv=none; b=lhypNuMa1D9lwmNwi2XP0jG5WqnagttoDxN4dwzqQxY9CDWd6NWoCKfiPBAeQny2kcxYD8gkROkWp6aB7sNJRdBQxN0AOqyS+gPXhHsP+UzJVRa0rInEon7tdtbyR4fH9jjCOVYxjbA1QkLgHiJWQPpi/hzGKgO5hAh1WexRIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916348; c=relaxed/simple;
	bh=VQWn4M7EP2MF3fIYO7HiCsSuFD2znXteEraa+9LgTc4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+w7SvIvO8w94fe6A4lxs6T0V7SAyVg8dGM940A2oUkknV1j/3E7tOQCFNw4M/B5O+sGl/PY8VWbXoKa96uZJMk3dTaJqv8FE1c1GD3rMUEVjbl4udseyx17RvsslgIxijvWy8CxanjinX2gBpGVGxYyS7/+SZluqfgAZk9DcDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YQc+EsDG; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 37E1744363;
	Tue, 25 Mar 2025 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742916336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WNERZZ738wDx61ssPaDcdyrzrk/vAGydwo3/RwU91Ls=;
	b=YQc+EsDG9MNKN2meN0b8m3atUfX1A+O4OTFfF4aouPgBRniDp7T0fa1KR0XwfkkHN/PrGB
	FgBpgI8Dv0Wp9YIlFOsoCq+MX7G8ZCEHxcYt4W/BWW5NbfBvuzu6I5KZtWug7E7qcaynbD
	iyprLoygSC7aX6i6BmNN9AcN3wpu0g3KY6QwInjb3QjaiSLcI0GBOroovkGNnosImbKrpy
	GUEDs/fn5Mt7xGmOFNlG3CJzD5URbzxtj4tpl6luAszSG0e3jWh08adetTI9LcvvBzTAr5
	xB6k9Qo8d9nvGEVZDoWh+REL5yceuRQAjNy6auSSdA/CpK9wjHgRRKemrXxilw==
Date: Tue, 25 Mar 2025 16:25:34 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kyle Swenson <kyle.swenson@est.tech>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Dent Project
 <dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v6 06/12] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250325162534.313bc066@kmaincent-XPS-13-7390>
In-Reply-To: <Z-JAWfL5U-hq79LZ@pengutronix.de>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-6-3dc0c5ebaf32@bootlin.com>
	<Z9gYTRgH-b1fXJRQ@pengutronix.de>
	<20250320173535.75e6419e@kmaincent-XPS-13-7390>
	<20250324173907.3afa58d2@kmaincent-XPS-13-7390>
	<Z-GXROTptwg3jh4J@p620>
	<Z-JAWfL5U-hq79LZ@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieeftddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehkhihlvgdrshifvghnshhonhesvghsthdrthgvtghhpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvght
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 25 Mar 2025 06:34:17 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi,
>=20
> On Mon, Mar 24, 2025 at 05:33:18PM +0000, Kyle Swenson wrote:
> > Hello Kory,
> >=20
> > On Mon, Mar 24, 2025 at 05:39:07PM +0100, Kory Maincent wrote: =20
> > > Hello Kyle, Oleksij, =20
> > ... =20
> > >=20
> > > Small question on PSE core behavior for PoE users.
> > >=20
> > > If we want to enable a port but we can't due to over budget.
> > > Should we :
> > > - Report an error (or not) and save the enable action from userspace.=
 On
> > > that case, if enough budget is available later due to priority change=
 or
> > > port disconnected the PSE core will try automatically to re enable the
> > > PoE port. The port will then be enabled without any action from the u=
ser.
> > > - Report an error but do nothing. The user will need to rerun the ena=
ble
> > >   command later to try to enable the port again.
> > >=20
> > > How is it currently managed in PoE poprietary userspace tools? =20
> >=20
> > So in our implementation, we're using the first option you've presented.
> > That is, we save the enable action from the user and if we can't power
> > the device due to insufficient budget remaining, we'll indicate that st=
atus
> > to the user.  If enough power budget becomes available later, we'll pow=
er up
> > the device automatically. =20
>=20
> It seems to be similar to administrative UP state - "ip link set dev lan1=
 up".
> I'm ok with this behavior.

Ack I will go for it then, thank you!

Other question to both of you:
If we configure manually the current limit for a port. Then we plug a Power=
ed
Device and we detect (during the classification) a smaller current limit
supported. Should we change the current limit to the one detected. On that =
case
we should not let the user set a power limit greater than the one detected =
after
the PD has been plugged.

What do you think? Could we let a user burn a PD?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

