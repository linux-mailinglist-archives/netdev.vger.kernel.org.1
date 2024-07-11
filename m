Return-Path: <netdev+bounces-110755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E01792E2CB
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02571C22BE3
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443081527A1;
	Thu, 11 Jul 2024 08:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AA3gJ1fY"
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF53128372;
	Thu, 11 Jul 2024 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720688059; cv=none; b=RAkxC7l36YmJRGzy56Sxzb8jWw56syA02DDrDBzRncNsAhz3dVcpwtohyuuq3zG4WqPjkuU9juoCsvUuI9B9YK0yGVSSbAyTo3ujP8Nv4y5AtFF8J5ccK0kJqDrwlMk7RiWDx4lQrrYpqUC0cC9T3aD/Z2qtdGyrWcaXsB82T+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720688059; c=relaxed/simple;
	bh=D+QQsXFMRvw9K/Ga6VQddVnwvaukbDA+lgAqpvT47JE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hW2tqszfllNgblZZw5PssC2P6ood77fAuS+tMf2/2U6KYuSYIIPTG8ueqdfcemXi020o8mz6idk/pZPvDkUcatlMI0nnxOmjlTLrjg+n8vZ/JEiTdTR8TnGZ/dKZQv8h1eHecoD609XN5D6GBvX5sjIUpz18r3SIdWQ/uvsmruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AA3gJ1fY; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::226])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 7B8A2C6F9D;
	Thu, 11 Jul 2024 08:53:37 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6CCC0C0004;
	Thu, 11 Jul 2024 08:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720688010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llx+XP6JadpR4EDUDeetmhDEqpsogxmUXPt4IRV6jhY=;
	b=AA3gJ1fYpAWXhsN7u788NnDZ/v0vX7dvLEo/dMkPVF5FqXQ24pJWrLa4tMsc3P88ymKrBq
	6/k6Mvok52jqLwLGDrDHBqpORhVYkPhxEmvcpegNa3p8uJIaugUhdix2M2aDmKhsj4dBIx
	2JJCKR3Iqw7LHGWBqkX0rYIOoLQBa2KXf0+b54pVu58xPJUh4LNQMBGFoMCZrmavp3FOLR
	0seHoFINGYwQExywKl2/xoA8PJJVlRzRCpV2v3wRe5i7aKRjYuIAYHWV5yVJQ8klKNcm3E
	e6mFtzIssZXgr2v+afFUXJb1SrbMP+grMQlia8iERqyPY67fv92Y2SIY6KmeIg==
Date: Thu, 11 Jul 2024 10:53:26 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2 1/2] net: pse-pd: Do not return EOPNOSUPP if config
 is null
Message-ID: <20240711105326.1a5b6b0b@kmaincent-XPS-13-7390>
In-Reply-To: <20240711084300.GA8788@kernel.org>
References: <20240710114232.257190-1-kory.maincent@bootlin.com>
	<20240711084300.GA8788@kernel.org>
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

On Thu, 11 Jul 2024 09:43:00 +0100
Simon Horman <horms@kernel.org> wrote:

> On Wed, Jul 10, 2024 at 01:42:30PM +0200, Kory Maincent wrote:
> > For a PSE supporting both c33 and PoDL, setting config for one type of =
PoE
> > leaves the other type's config null. Currently, this case returns
> > EOPNOTSUPP, which is incorrect. Instead, we should do nothing if the
> > configuration is empty.
> >=20
> > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > Fixes: d83e13761d5b ("net: pse-pd: Use regulator framework within PSE
> > framework") ---
> >=20
> > Changes in v2:
> > - New patch to fix dealing with a null config. =20
>=20
> Hi Kory,
>=20
> A few thing from a process perspective:
>=20
> 1. As fixes, with fixes tags (good!), this patchset seems like it is
>    appropriate for net rather than net-next. And indeed it applies
>    to net but not net-next. However, the absence of a target tree
>    confuses our CI which failed to apply the patchset to net-next.
>=20
>    Probably this means it should be reposted, targeted at net.
>=20
>    Subject: [Patch v3 net x/y] ...
>=20
>    See: https://docs.kernel.org/process/maintainer-netdev.html

Oops indeed sorry, forgot to add the net prefix.

> 2. Please provide a cover letter for patch sets with more than one
>    (but not just one) patch. That provides an overview of how
>    the patches relate to each other. And a convenient anchor for
>    feedback such as point 1 above.
>=20
> ...

As my first version contained only one patch I did not thought of adding a
cover letter for the 2nd version but indeed I should. Sorry.

Thanks for the reminder I will try to not have my head in the cloud next ti=
me.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

