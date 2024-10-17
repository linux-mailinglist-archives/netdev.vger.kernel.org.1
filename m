Return-Path: <netdev+bounces-136529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667559A201C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB261F21E74
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E7C1D31B8;
	Thu, 17 Oct 2024 10:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G98204VL"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB41D270B;
	Thu, 17 Oct 2024 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729161371; cv=none; b=b5qMUd8VDfii0vhK+UL8g3LTJfV8qo69+2ygIesJsji/ymncV09mb41inc6c8fJF+LptDyNe07ypfJ9+PRkm0ObTlC+ujIofTmqnnBtyIuIj98/Yc555oB4fMMtlpXmPO1Ewih8YKaf0qmLozdO5kz4apsaGH9rg8f/LOJLfn/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729161371; c=relaxed/simple;
	bh=bN0ynZ5VvEebxpXgXh2TCBbbaoPHNbGQrJn45V3ZuV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFzQ70O68clmj1Sq71U3ePTYb4KfnUsNDGt1YnaKzJ2yIWvK1tsyticTAu7Y1IVFuooBVGoHL/UC5CnSJ2iIQrHV42zQofn8q0wn/sRUeHSEJ1V0eVT0KUNyGGRewiN+unMGnv4kQN92VgRryFBH2cJJGs5s/VerVOCr5K+c/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G98204VL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ADEE91BF204;
	Thu, 17 Oct 2024 10:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729161360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FU3ajgfKVQdp/DGYqfIoFwgjGz2NDpydxrXXIn2bE1U=;
	b=G98204VLPKaAcWsavGd30rRwqEypallNrziTcStzdHkRWaKtaMkSoHfpTQYq6rlY1nQ9AX
	oA97FMVpRw7r7fNmacsDX2Wo3haxFqhvQGZwRhHfs5DmGTcNPCPk1gnmvMdodkgnJs/8Lv
	yOb4mGFH/6qKarFgC398y2e6MV1wuOtFtUUX3vDEzXCNrbPV8jmIf06Fjrcs9BR4K6Us/H
	eRuyPpFGdEVEsDn09l0eqt0bqDUEJCdA6E269M8MKpWpK2iNhfq+wr2m+KhyJWNU9x9sS/
	hY8egc0q6dio7a5KWPfC6PoqxbjxHxru/zYSduyYqpE+moqvOJ0piu8KKv2Ozw==
Date: Thu, 17 Oct 2024 12:35:57 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Kyle Swenson <kyle.swenson@est.tech>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Dent Project
 <dentproject@linuxfoundation.org>, "kernel@pengutronix.de"
 <kernel@pengutronix.de>
Subject: Re: [PATCH net-next 00/12] Add support for PSE port priority
Message-ID: <20241017123557.68189d5b@kmaincent-XPS-13-7390>
In-Reply-To: <20241015114352.2034b84a@kmaincent-XPS-13-7390>
References: <20241002-feature_poe_port_prio-v1-0-787054f74ed5@bootlin.com>
	<ZwaLDW6sKcytVhYX@p620.local.tld>
	<20241009170400.3988b2ac@kmaincent-XPS-13-7390>
	<ZwbAYyciOcjt7q3e@est-xps15>
	<ZwdpQRRGst1Z0eQE@pengutronix.de>
	<20241015114352.2034b84a@kmaincent-XPS-13-7390>
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

On Tue, 15 Oct 2024 11:43:52 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> > Policy Variants and Implementation
> >=20
> > In cases where we are discussing prioritization, we are fundamentally
> > talking about over-provisioning. This typically means that while a devi=
ce
> > advertises a certain maximum per-port power capacity (e.g., 95W), the t=
otal
> > system power budget (e.g., 300W) is insufficient to supply maximum powe=
r to
> > all ports simultaneously. This is often due to various system limitatio=
ns,
> > and if there were no power limits, prioritization wouldn't be necessary.
> >=20
> > The challenge then becomes how to squeeze more Powered Devices (PDs) on=
to
> > one PSE system. Here are two methods for over-provisioning:
> >=20
> > 1. Static Method:
> > =20
> >    This method involves distributing power based on PD classification. =
It=E2=80=99s
> >    straightforward and stable, with the software (probably within the P=
SE
> >    framework) keeping track of the budget and subtracting the power
> > requested by each PD=E2=80=99s class.=20
> > =20
> >    Advantages: Every PD gets its promised power at any time, which
> > guarantees reliability.=20
> >=20
> >    Disadvantages: PD classification steps are large, meaning devices re=
quest
> >    much more power than they actually need. As a result, the power supp=
ly
> > may only operate at, say, 50% capacity, which is inefficient and wastes
> > money.
> >=20
> > 2. Dynamic Method: =20
> >=20
> >    To address the inefficiencies of the static method, vendors like
> > Microchip have introduced dynamic power budgeting, as seen in the PD692=
x0
> > firmware. This method monitors the current consumption per port and
> > subtracts it from the available power budget. When the budget is exceed=
ed,
> > lower-priority ports are shut down. =20
> >=20
> >    Advantages: This method optimizes resource utilization, saving costs.
> >=20
> >    Disadvantages: Low-priority devices may experience instability. A
> > possible improvement could involve using LLDP protocols to dynamically
> > configure power limits per port, thus allowing us to reduce power on
> > over-consuming ports rather than shutting them down entirely. =20
>=20
> Indeed we will have only static method for PSE controllers not supporting
> system power budget management like the TPS2388x or LTC426.
> Both method could be supported for "smart" PSE controller like PD692x0.
>=20
> Let's begin with the static method implementation in the PSE framework for
> now. It will need the power domain notion you have talked about.

While developing the software support for port priority in static method, I
faced an issue.

Supposing we are exceeding the power budget when we plug a new PD.
The port power should not be enabled directly or magic smoke will appear.
So we have to separate the detection part to know the needs of the PD from =
the
power enable part.

Currently the port power is enabled on the hardware automatically after the
detection process. There is no way to separate power port process and detec=
tion
process with the PD692x0 controller and it could be done on the TPS23881 by
configuring it to manual mode but: "The use of this mode is intended for sy=
stem
diagnostic purposes only in the event that ports cannot be powered in
accordance with the IEEE 802.3bt standard from semiauto or auto modes."
Not sure we want that.

So in fact the workaround you talked about above will be needed for the two=
 PSE
controllers.
=20
> Both methods have their pros and cons. Since the dynamic method is not al=
ways
> desirable, and if there's no way to disable it in the PD692x0's firmware,=
 one
> potential workaround could be handling the budget in software and dynamic=
ally
> setting per-port limits. For instance, with a total budget of 300W and un=
used
> ports, we could initially set 95W limits per port. As high-priority PDs (=
e.g.,
> three 95W devices) are powered, we could dynamically reduce the power lim=
it on
> the remaining ports to 15W, ensuring that no device exceeds that
> classification threshold.

We would set port overcurrent limit for all unpowered ports when the power
budget available is less than max PI power 100W as you described.
If a new PD plugged exceed the overcurrent limit then it will raise an inte=
rrupt
and we could deal with the power budget to turn off low priority ports at t=
hat
time.=20

Mmh in fact I could not know if the overcurrent event interrupt comes from a
newly plugged PD or not.

An option: When we get new PD device plug interrupt event, we wait the end =
of
classification time (Tpon 400ms) and read the interrupt states again to kno=
w if
there is an overcurrent or not on the port.

What do you think?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

