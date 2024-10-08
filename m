Return-Path: <netdev+bounces-133133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC49951CC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499FFB220BF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663C31DF96B;
	Tue,  8 Oct 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VKXdr3c4"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABE1DE2AE;
	Tue,  8 Oct 2024 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397292; cv=none; b=e/p8bgAxKjIuG4w9pgnRX0S9u00OzwIxizCHUmteox5s/2jpYtnTnQ9GC9qC3Umi1cCJ3YKWZFX3AsoKN3ZyORHIYDN7Cd6JbWQ7Jdg0H5MD1F71ZH5Vbr4DN7x51+7xEIRo9lwS415cy1QaO81vTUpCQrrqTIfuIXfsl6cAqN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397292; c=relaxed/simple;
	bh=m3KUbwqtWaR6bmYjQdpyjFp9exQ2YBNqwsD4RVETg4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MEehA/5K2isabZ2p0cq1cQHW0BD8XedCwsK5rdrfoSjDmG00dPFkf5cLVMn2aSIjlxzbt+JVFs4xC+290AHviC7E4krngpalayZiYiV2Tv8Nkbsu0THIwHR02g33XPuS7KRvPeZ9ohLxOjU72k9xEj1P09rgFAn0S3mhfZFoA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VKXdr3c4; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 15ADC1BF209;
	Tue,  8 Oct 2024 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728397282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CoL/bQFuFrffN2073/mKg1lZJ27Axt4FPy1eN4O+9UI=;
	b=VKXdr3c4M5o41DAk1jDy79n2+zNorAmkWoU/pF14M0VWxfjOc5JerD+Qshy8kIBZTNjqot
	LCapaHsnf75IYAjMSFpRfZZsq+3GC2hdlBfKV63djAn+rij4qirR5wGMBTYOJQyi4vlXmV
	b31NIQQuv/QX+0BS8S11DqXxDJB5jPDIskJNWeifvFLFJvVLlUGnj+HaD8rMhONVN990JS
	6AZLEQL1PF/EubycMUI6+30BYvnYJaQJmrOiHj/9GFpI14YMwJs551iSjEy56i9j4pFj/E
	pfctNULpcPf/osR0GeYnIHhuX/WGfANkfhPN1KBTnymFExsKWmx6zFqxAwmUSg==
Date: Tue, 8 Oct 2024 16:21:20 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de
Subject: Re: [PATCH net-next 08/12] net: pse-pd: pd692x0: Add support for
 PSE PI priority feature
Message-ID: <20241008162120.18aa0a6c@kmaincent-XPS-13-7390>
In-Reply-To: <ZwU6QuGSbWF36hhF@pengutronix.de>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<20241002-feature_poe_port_prio-v1-8-787054f74ed5@bootlin.com>
	<1e9cdab6-f15e-4569-9c71-eb540e94b2fe@lunn.ch>
	<ZwU6QuGSbWF36hhF@pengutronix.de>
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

On Tue, 8 Oct 2024 15:57:22 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Thu, Oct 03, 2024 at 01:41:02AM +0200, Andrew Lunn wrote:
> > > +	msg =3D pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
> > > +	msg.sub[2] =3D id;
> > > +	/* Controller priority from 1 to 3 */
> > > +	msg.data[4] =3D prio + 1; =20
> >=20
> > Does 0 have a meaning? It just seems an odd design if it does not. =20
>=20
> 0 is not documented. But there are sub-priority which are not directly
> configured by user, but affect the system behavior.
>=20
> Priority#: Critical =E2=80=93 1; high =E2=80=93 2; low =E2=80=93 3
>  For ports with the same priority, the PoE Controller sets the
>  sub-priority according to the logic port number. (Lower number gets
>  higher priority).
>=20
> Port priority affects:
> 1. Power-up order: After a reset, the ports are powered up according to
>  their priority, highest to lowest, highest priority will power up first.
> 2. Shutdown order: When exceeding the power budget, lowest priority
>  ports will turn off first.
>=20
> Should we return sub priorities on the prio get request?
>=20
> If i see it correctly, even if user do not actively configures priorities,
> they are always present. For example port 0 will have always a Prio
> higher than Port 10.

We could add a subprio ehtool attribute, but it won't be configurable.
In fact it could be configurable by changing the port matrix order but it i=
s not
a good idea. Applying a new port matrix turn off all the ports.

I am not sure if it is specific to Microchip controller or if it is generic
enough to add the attribute.
I would say not to return it for now.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

