Return-Path: <netdev+bounces-131613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0366298F076
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A222830A6
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2051919ADA3;
	Thu,  3 Oct 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bxIJQ26U"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180681386BF;
	Thu,  3 Oct 2024 13:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727962392; cv=none; b=LKyZuAwFIlULFuNbbzezahleaAIw4NfwVsT/OFxnY/b7GUfBEJdkowL+UatB7GoBz+c3z5IfA7GM2R2NRW6sMZ/Ub3m/+gdJJo6KqrEaWEs/kgd+AedRKfqu+o+BJ/CsYXmSEmJjjEa7nHalSxojmVnUym/U7Z59DhwyI7L2BKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727962392; c=relaxed/simple;
	bh=BbWFHSCeKOog5uUGwT6s985CRXarW7ZSOywjwtyAGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZF6kbu0Cg1h7rKIWfuUtozrlrgDb8VylcUlBKUf4gU1mVWiPZn/L3w09mZIMbhK9sl68XVUe9O8zaEobq/3S0wq6XEu4/i99SJMuecYcKpt/SwXnP7RrxLK6s0DThzGrtUPvh1k9URhWaZSyaTfaR9z/sX5+I1tqUjJnrABdfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bxIJQ26U; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6C59C1BF20E;
	Thu,  3 Oct 2024 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727962387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbWFHSCeKOog5uUGwT6s985CRXarW7ZSOywjwtyAGNg=;
	b=bxIJQ26UcRjzjl8axX9BBwkcfHhVvruFRINYXHSwH0+krChDc98iu+CgrRIBASfSV/b2Yb
	wsrufmni/S9crlySRh1PkEzihOW6lW+XhQ78Pw24ZDpNSSSxJYqYXVVBYwZtJJxKPSYrBl
	nyjDQ+UDcY47qI6KfSdI2coFYG71HJ8SEl292eWISWQ90aebb3Jlisg1+nPUrs8x+YT+GQ
	tMYaOpz1vXBbkQHJC5S9/KN9hojYE75atH/7bWVf5Bn8yCKvhxHp5TuydJ3RxKphd1Rl4K
	MLnBDy81I4eylVd+9gyWNz9YJbXpoAd4U9bKkw0rqrExJdsmEJadpmls6idpYw==
Date: Thu, 3 Oct 2024 15:33:03 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next 11/12] net: pse-pd: Add support for event
 reporting using devm_regulator_irq_helper
Message-ID: <20241003153303.7cc6dba8@kmaincent-XPS-13-7390>
In-Reply-To: <f97baa90-1f76-4558-815a-ef4f82913c3a@lunn.ch>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-11-787054f74ed5@bootlin.com>
	<f56780af-b2d4-42d7-bc5d-c35b295d7c52@lunn.ch>
	<20241003102806.084367ba@kmaincent-XPS-13-7390>
	<f97baa90-1f76-4558-815a-ef4f82913c3a@lunn.ch>
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

On Thu, 3 Oct 2024 14:56:21 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > > https://docs.kernel.org/power/regulator/consumer.html#regulator-events
> > >=20
> > > Suggests these are internal events, using a notification chain. How
> > > does user space get to know about such events? =20
> >=20
> > When events appears, _notifier_call_chain() is called which can generate
> > netlink messages alongside the internal events:
> > https://elixir.bootlin.com/linux/v6.11.1/source/drivers/regulator/core.=
c#L4898
> > =20
>=20
> Ah, O.K.
>=20
> But is this in the correct 'address space' for the want of a better
> term. Everything else to do with PSE is in the networking domain of
> netlink. ethtool is used to configure PSE. Shouldn't the notification
> also close by to ethtool? When an interface changes state, there is a
> notification sent. Maybe we want to piggyback on that?

Indeed, but regulator API already provide such events, which will even be s=
ent
when we enable or disable the PSE. Should we write a second event managemen=
t.
Using regulator event API allows to report over current internal events to =
the
parents regulator the power supply of the PSE which could also do something=
 to
avoid smoke.

Or maybe we should add another wrapper which will send PSE ethtool netlink
notification alongside the regulator notifications supported by this patch.

> Also, how do regulator events work in combination with network
> namespaces? If you move the interface into a different network
> namespace, do the regulator events get delivered to the root namespace
> or the namespace the interface is in?

regulator events are sent in root namespace.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

