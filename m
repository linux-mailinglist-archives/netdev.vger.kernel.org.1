Return-Path: <netdev+bounces-99339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1949E8D4898
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3953C1C216C1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682F6F304;
	Thu, 30 May 2024 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ehny38kh"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172F145B38;
	Thu, 30 May 2024 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061633; cv=none; b=Lc3c/99xJl1rF9IRUMLpXlTTMpEywj+ZzrlTf40uqilK/cwX0hEN6bW970CVfPA0sriPrV63+HNYAM1JnJLSC4N4tikEc0G6Qye5s/CcKWU7LdLtc+3mQLNbWAPUK0kSA6JsLSVfQkfBzB9JYjeU2RLdtXMO/SfbXyp9Y4pmdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061633; c=relaxed/simple;
	bh=hgS8VKpsnoGNLurT4aSMHtModguZRSzXJGIC1bs3hLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BkygzkwfF/A08oinBjwTcIL/81zQtKiRQXJ160RXByvGJ/KJsqW7NGm3DVw1ol9rSi8acTTCF5ouHzJ9xssDWqN/txLwtrMWLg6YXa2AXa4uZbvlroa4d8+6G0qfjKRB/YXsygnTHItxNg7rhj/tjxnC2jnSfJrLo2KE12NY59U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ehny38kh; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 374851C0008;
	Thu, 30 May 2024 09:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717061623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kktmPQ8UkkibGHep0ZYqlFfuJ4jZwmWmpyZWosFkVgE=;
	b=ehny38khWiMM/cdQIjCq5EdFThIKnQV0uDrKL7hQ6hmZ5J71NpyH6j70jotn2ksxlvkUun
	KRmrwSg7CFPUTeFkpgTqvp3TF2r6Ru76YG3PFF23C+xQNxUrjZBAuahI4dBSI2TDi5ZufU
	k1ZUJwgjJVVNz2g5kQzFBnFUiGmTp1DRoOYhdcvOdLj4MTqK8DQ30zlJ0lUk7V3OqmAx3b
	/dI4al/oUlohRi/TpVMLUVse5v1W4K+l6pNy2if4c58F5SnA4GZaPqytj1dqG1PY7M6IW5
	4M/LFuCVeoJkUj3QzjOIgQopKaOqbceKNIpKT88YMcXptK83h/mL4KTYwOuGOw==
Date: Thu, 30 May 2024 11:33:41 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Oleksij
 Rempel <o.rempel@pengutronix.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de
Subject: Re: [PATCH 4/8] net: pse-pd: pd692x0: Expand ethtool status message
Message-ID: <20240530113341.36865f09@kmaincent-XPS-13-7390>
In-Reply-To: <d6aab44f-5e9a-4281-8c67-4b890b726337@lunn.ch>
References: <20240529-feature_poe_power_cap-v1-0-0c4b1d5953b8@bootlin.com>
	<20240529-feature_poe_power_cap-v1-4-0c4b1d5953b8@bootlin.com>
	<d6aab44f-5e9a-4281-8c67-4b890b726337@lunn.ch>
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

Thanks for the review!

On Thu, 30 May 2024 01:13:59 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +static const struct pd692x0_status_msg pd692x0_status_msg_list[] =3D {
> > +	{.id =3D 0x06, .msg =3D "Port is off: Main supply voltage is high."},
> > +	{.id =3D 0x07, .msg =3D "Port is off: Main supply voltage is low."},
> > +	{.id =3D 0x08, .msg =3D "Port is off: Disable all ports pin is
> > active."},
> > +	{.id =3D 0x0C, .msg =3D "Port is off: Non-existing port number."},
> > +	{.id =3D 0x11, .msg =3D "Port is yet undefined."},
> > +	{.id =3D 0x12, .msg =3D "Port is off: Internal hardware fault."},
> > +	{.id =3D 0x1A, .msg =3D "Port is off: User setting."},
> > +	{.id =3D 0x1B, .msg =3D "Port is off: Detection is in process."},
> > +	{.id =3D 0x1C, .msg =3D "Port is off: Non-802.3AF/AT powered device."=
},
> > +	{.id =3D 0x1E, .msg =3D "Port is off: Underload state."},
> > +	{.id =3D 0x1F, .msg =3D "Port is off: Overload state."},
> > +	{.id =3D 0x20, .msg =3D "Port is off: Power budget exceeded."},
> > +	{.id =3D 0x21, .msg =3D "Port is off: Internal hardware routing
> > error."},
> > +	{.id =3D 0x22, .msg =3D "Port is off: Configuration change."},
> > +	{.id =3D 0x24, .msg =3D "Port is off: Voltage injection into the
> > port."},
> > +	{.id =3D 0x25, .msg =3D "Port is off: Improper Capacitor Detection"},
> > +	{.id =3D 0x26, .msg =3D "Port is off: Discharged load."}, =20
>=20
> I don't know of any other driver returning strings like this. Have you
> seen any other PSE driver with anything similar?

We would like to be able to return the failure reason but there is nothing
generic in the IEEE 802.3 standard to be able to add it to the UAPI.
The TI controller has SUPPLY and FAULT EVENT Register which could report few
messages. I am not aware of other PoE controller and how they deal with it.
We could add sysfs for reporting the status messages for all the ports but I
don't think it is a better idea.

> > +	{.id =3D 0x34, .msg =3D "Port is off: Short condition."},
> > +	{.id =3D 0x35, .msg =3D "Port is off: Over temperature at the port."},
> > +	{.id =3D 0x36, .msg =3D "Port is off: Device is too hot."},
> > +	{.id =3D 0x37, .msg =3D "Unknown device port status."},
> > +	{.id =3D 0x3C, .msg =3D "Power Management-Static."},
> > +	{.id =3D 0x3D, .msg =3D "Power Management-Static\u2014OVL."}, =20
>=20
> Is there something going on with UTF here? the \u2014 ?

Some copy paste of the messages bring a non utf-8 character :/
Will fix it, thanks for spotting it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

