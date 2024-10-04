Return-Path: <netdev+bounces-132082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 489CB990586
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 16:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29BF1F2138F
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174F1217300;
	Fri,  4 Oct 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="buTDvLSk"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B1E2141B2;
	Fri,  4 Oct 2024 14:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051049; cv=none; b=RtvNfiCtsw5uUZY7vSYyRuqoVb6qzY03gBoj+9Sab/jp/qnUzyvLADi0Sgirhwct9QCSIBE6pyOx5Ld7+kwuLDAI+2VZpSB2nSjZU8u4BtLeAH0APM7Y6Iz7qfih6Hrp9L3zQFWKVoGMfnpSSHVmBPf8w5fzWtOuievhthoDtxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051049; c=relaxed/simple;
	bh=j5AlOQD2VWaaQ/2ZWxDwdHfV7PX7fB/Ru+TjZs8F8dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJPkqkX/wNZ1yh/z7tvL+GLz8b6auqtjhsGIkrk8PIfMfeg1jrg2w4U3GatbrUaSnkcP81viG3yKdXQP8F2wMOGgl2IuM4Hoku/GbpZVAVfu5zc5bAffnqJPIyr6Wac+rWxiLwtVxPmS7J4zh/3y1zubvYIlRGASMWiPkXyU7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=buTDvLSk; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4FD4240003;
	Fri,  4 Oct 2024 14:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728051044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g3tL/ZAiQMNHzQXs84jjIGk7DdTJl4yNqKkW6ctCqjY=;
	b=buTDvLSkl6l2LUhH7KKOwsGBDyKeuuuHDq0f4wO6l2o2hSDMVsUdFPVzSTmhHkh3Tl1bpV
	0lDqrrk7QNSGkxxDA+FadIyKbTG8lZvgN49TstG1YkaRzYvQyq9YXRlG2jcEUmJDFqESoX
	fuVTDF7J3Y3OzZ7u8RcNTID4ztzkGV6JL9nIHmPMcfAbYFzcezH4FIROdSL4aKosS8wEVB
	5y3XKgjChfQY89xJbawS5uo8fsBLX6dIpoN4+xZqDstLYHANpO/p8O2O2y8mQb2QnyMsJf
	xFWIbHDGwzcKlgb4ljYn53Io8ZB7Dd2YU6JGpm/7ryGbb9QZ/OaCaVQ7DpQZfw==
Date: Fri, 4 Oct 2024 16:10:41 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 11/12] net: pse-pd: Add support for event
 reporting using devm_regulator_irq_helper
Message-ID: <20241004161041.0eb3aad6@kmaincent-XPS-13-7390>
In-Reply-To: <Zv_1ZzwQJ-P36mt6@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
	<f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
	<20241003102806.084367ba@kmaincent-XPS-13-7390>
	<f97baa90-1f76-4558-815a-ef4f82913c3a@lunn.ch>
	<20241003153303.7cc6dba8@kmaincent-XPS-13-7390>
	<4b9d1adf-e9bd-47c0-ac69-5da77fcf8d0b@lunn.ch>
	<Zv_0ESPJgHKhFIwk@pengutronix.de>
	<Zv_1ZzwQJ-P36mt6@pengutronix.de>
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

On Fri, 4 Oct 2024 16:02:15 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Fri, Oct 04, 2024 at 03:56:33PM +0200, Oleksij Rempel wrote:
> > On Thu, Oct 03, 2024 at 05:22:58PM +0200, Andrew Lunn wrote: =20
>  [...] =20
>  [...] =20
>  [...] =20
> > >=20
> > > I think we will need two event, the base regulator event, and a
> > > networking event. Since it is a regulator, sending a normal regulator
> > > event makes a lot of sense. But mapping that regulator event to a
> > > netns:ifnam is going to be hard. Anything wanting to take an action is
> > > probably going to want to use ethtool, and so needs to be in the
> > > correct netns, etc. But it does get messy if there is some sort of
> > > software driven prioritisation going on, some daemon needs to pick a
> > > victim to reduce power to, and the interfaces are spread over multiple
> > > network namespaces.
> > >=20
> > > What i don't know is if we can use an existing event, or we should add
> > > a new one. Often rtnetlink_event() is used:
> > >=20
> > > https://elixir.bootlin.com/linux/v6.12-rc1/source/net/core/rtnetlink.=
c#L6679
> > >=20
> > > but without some PSE information in it, it would be hard to know why
> > > it was sent. So we probably either want a generic ethtool event, or a
> > > PSE event. =20
> >=20
> > Hm... assuming we have following scenario:
> >=20
> >                                   .---------   PI 1
> >                                  / .---------  PI 2
> >                    .=3D=3D=3D=3D=3D=3D=3D=3D=3D PSE /----------( PI 3 )=
 NNS red
> >                   //              \----------( PI 4 ) NNS blue
> > Main supply      //                `---------( PI 5 ) NNS blue
> > o=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=C2=B4--- System, CPU
> >=20
> > In this case we seems to have a new challenge:
> >=20
> > On one side, a system wide power manager should see and mange all ports.
> > On other side, withing a name space, we should be able to play in a
> > isolated sand box. There is a reason why it is isolated. So, we should
> > be able to sandbox power delivery and port prios too. Means, by creating
> > network names space, we will need a power names space.=20
> >=20
> > I can even imagine a use case: an admin limited access to a switch for
> > developer. A developer name space is created with PSE budget and max
> > prios available for this name space. This will prevent users from DoSing
> > system critical ports.
> >=20
> > At this point, creating a power name space will an overkill for this
> > patch set, so it should be enough to allow controlling prios over
> > ethtool per port and isolation support if needed.=20

Yes, I will add simple ethtool notification for now to report events on each
interfaces.

> Oh, sorry, i'm too tired. Too many words are missing in my answer ...

Nearly the weekend!! Rest well!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

