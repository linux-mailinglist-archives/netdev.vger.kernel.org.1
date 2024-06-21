Return-Path: <netdev+bounces-105767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64568912B4B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 18:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1549C288666
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F26615FCED;
	Fri, 21 Jun 2024 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fstB0gTb"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F8A15FA7F;
	Fri, 21 Jun 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718987128; cv=none; b=SSnxY3oU9otJ2CqgKUi4sJV4Rrw4/Xln8e8xFcVW8lg/G0VhZeg46D7wRRnrD/8wIxh7hVpXGkgnqvP9/6+I36rtWDJSZs9yQHfwUcj3L6yG44NTGtjmp2FL4teoVJuKJMawCQ8acYZpG4mH0BuXI3BHv4CsSxZeqIgdRu8hNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718987128; c=relaxed/simple;
	bh=RsBI3FTC5NF4E2+nPg2P0qSDMe0OTQD52zffffD4VW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyk9S1t0IzVZgC7N33l6gw4Y/MiNcKZyMeO+zfgG4x8iazGSYSK6UmAz7lVuu5IJ9GYXKW6uPnnuvV2jLF2sFFleIdk81pdaL7LlGlIr9uVlIj22nT+we6AMquj7C/CpqxDO064iK4rFQMgOUj7nv00HRI59U8HG4ICFYEOWiL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fstB0gTb; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3A97760005;
	Fri, 21 Jun 2024 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718987123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUsl04IPFEuQ2R6be8vZ3IpQhl5WFGdoLZzSAo7Lu5k=;
	b=fstB0gTbaNiIuPZzE2NEFqwlHqgcbkUurqcSf0TUzcL3lTYizlP3iOZxT61dif7AoqM4ci
	ikOjvSVmtQVDbOzHTfeue0q8N0SJKfYHJVhK/D3EHFE8jG5FtcJSk+uXF6XnpS3QVNsoqv
	u2yqC8/p81vk/mCLW9XD3zEusD6lxqeDDJ+/QxLWSIA6r4GVBYqzmMKhXiQZ490akcCAzL
	LoclipYLEakArdxmKb9pwC1Jmmhw/+tRY4YYsoAwTN8+lM23A53YFG9CtvG74+UZZ2r2MO
	uStXy9epWok46w7xv4zG8TRRM7Swpz5lFYXLmxS2ig0RimcCIwPVGo8Cs8d3UQ==
Date: Fri, 21 Jun 2024 18:25:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, Radu Pirea
 <radu-nicolae.pirea@oss.nxp.com>, Jay Vosburgh <j.vosburgh@gmail.com>, Andy
 Gospodarek <andy@greyhouse.net>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH net-next v15 13/14] net: ethtool: tsinfo: Add support
 for hwtstamp provider and get/set hwtstamp config
Message-ID: <20240621182520.6f28d751@kmaincent-XPS-13-7390>
In-Reply-To: <20240621085600.5b7aa934@kernel.org>
References: <20240612-feature_ptp_netnext-v15-0-b2a086257b63@bootlin.com>
	<20240612-feature_ptp_netnext-v15-13-b2a086257b63@bootlin.com>
	<20240617184331.0ddfd08e@kernel.org>
	<20240621105408.6dda7a0e@kmaincent-XPS-13-7390>
	<20240621085600.5b7aa934@kernel.org>
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
X-GND-Sasl: kory.maincent@bootlin.com

On Fri, 21 Jun 2024 08:56:00 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 21 Jun 2024 10:54:08 +0200 Kory Maincent wrote: =20
>  [...] =20
> >=20
> > As I described it in the documentation it replaces SIOCGHWTSTAMP:
> > "Any process can read the actual configuration by requesting tsinfo net=
link
> > socket ETHTOOL_MSG_TSINFO_GET with ETHTOOL_MSG_TSINFO_GHWTSTAMP netlink
> > attribute set.
> >=20
> > The legacy usage is to pass this structure to ioctl(SIOCGHWTSTAMP) in t=
he
> > same way as the ioctl(SIOCSHWTSTAMP).  However, this has not been
> > implemented in all drivers." =20
>=20
> I did see the words, just didn't get the meaning :> Couple of years
> from now hopefully newcomers won't even know ioctls exited, and
> therefore what they did. From the user perspective the gist AFAIU is
> that instead of *supported* we'll return what's currently *configured*.
>=20
> This feels a little bit too much like a muxed operation for me :(
> Can we create a separate commands for TSCONFIG_GET / _SET ?
> Granted it will be higher LOC, but hopefully cleaner ?
> Or we can add the configured as completely new attrs, but changing
> meaning of existing attrs based on a request flag.. =F0=9F=99=82=E2=80=8D=
=E2=86=94=EF=B8=8F=EF=B8=8F

Ok so, you prefer to use a separate command to manage the hwtstamp
configurations. Keeping TSINFO for reading the hwtstamp capabilities.
I will bring back the TS_GET and TS_SET I have used from an older version of
this patch series but renaming it to TSCONFIG ;)

>  [...] =20
> >=20
> > I am not a naming expert but "hwtstamp_provider" is the struct name I h=
ave
> > used to describe hwtstamp index + qualifier and the prefix of the netli=
nk
> > nested attribute, so IMHO it fits well.
> > Have you another proposition to clarify what you would expect? =20
>=20
> Oh, I just meant that it's way to long. I know y'all youngsters use
> IDEs but I have it on good authority that there's still people in
> this community who use text editors they wrote themselves, and those
> lack auto-completion.. It's good to be more concise.

Don't have too high expectations of me, I am still using vim. Maybe I belong
also to the "old" people. ;)
Now that we can reach 100 characters by line we can write variable names as=
 long
as we want! ^^
I will look for a shorter name then.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

