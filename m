Return-Path: <netdev+bounces-275924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FlQOGbR1GlJxwcAu9opvQ
	(envelope-from <netdev+bounces-275924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 283853AC36D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 401CE300A619
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 09:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4439B49C;
	Tue,  7 Apr 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lcxnp3wZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A3C397E9F;
	Tue,  7 Apr 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554839; cv=none; b=WSOiR6ORWn3uQNiakBa6c+OKQbBMU+NF62Nd0K9o/LMCoixd+gmalTjbU2A053TRlRKaDlh17u2yON2BcMYc4FzjADWTd5gQcsy5yCpxU6DRqqO6srVyjNPRBGvMeNCQU5f05NNhxli6ittibq2jtLfMWQKO4wFEEPKy9o585tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554839; c=relaxed/simple;
	bh=4lyCBGNQl/3+m1BK3GENq+afc9cSJKlavGL0IGYAg0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmDiwc1q32lB7xLM8HD20UZG7lnnuV6G1pu6N7ZZ7ytpb9oTbYL20p8wi4Ehbhw3+BQWv/zb6AA2iZVRlm2LCJ3Cx5RzKPNQ4ER0OmDT5uSAHC3wv9jqQj6RNCvdfEHFa07VKCYkcpLkjp5d5Quw6mESGR08aMrSjffSvC8Ihog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lcxnp3wZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 228ED1A31B3;
	Tue,  7 Apr 2026 09:40:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EACA8603C7;
	Tue,  7 Apr 2026 09:40:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 18AED1045017D;
	Tue,  7 Apr 2026 11:40:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775554835; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7i4+STDc0ibhW0/mMo7y7QeOw6BMz3TT9b7HewYcv4E=;
	b=lcxnp3wZXO0F6B8ALu88ruzpEAowiinyeFN8O/61TDxyAL8AaB9UhtV/2texsuYG8DVQQQ
	wj0l/fzDMZxm7CeLar+phAveyndZUseU7XXt8BJY0qu7UdXt0vjC60MD9jNy/PIPiyJ/nY
	zW/HcY6NkIIVhaQZLncvaF/wY8GGGBztxt3YQzGYZY+Awj4AAhR+KxerVaPGIMeKwY/h6h
	g1Gd0sSFRP4s6RDe21GlKyAQU4de1FnxjCCwBQ29+cvIH1Y1mFuCg5KNyc3I/AFkirysnY
	NrAKlhn4/mlZ7VwkCyQxoRdIFtCVoqW0b3Z8IbPW5I/VO8lIftMOeLkzo4c/gA==
Date: Tue, 7 Apr 2026 11:40:30 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Carlo Szelinsky <github@szelinsky.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Jakub
 Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as
 non-fatal during PHY registration
Message-ID: <20260407114030.4cd0d6a4@kmaincent-XPS-13-7390>
In-Reply-To: <adO_Za-X1cMjCEEa@pengutronix.de>
References: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
	<20260405185730.3937952-1-github@szelinsky.de>
	<adN9Ha5FgJ8sp6gj@pengutronix.de>
	<1df8b470-2449-418d-a4a8-9cd929ced463@lunn.ch>
	<adO_Za-X1cMjCEEa@pengutronix.de>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275924-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,szelinsky.de,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.972];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 283853AC36D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 6 Apr 2026 16:12:53 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Mon, Apr 06, 2026 at 02:22:16PM +0200, Andrew Lunn wrote:
> > > The core question, do we need PSE for PHY functionality? =20
> >=20
> > I don't think the PHY should require PSE in order to send/receive
> > frames. If the PSE is not supplying power, the link peer is probably
> > off, but that is not so different from the cable being unplugged.
> >  =20
> > > We can make a step back and re-evaluate - what functionality and what
> > > order is actually required to find potentially better implementation.
> > >=20
> > > We have a lot of current flowing over wires, budget and port
> > > prioritization issues, things which may damage HW if done not correct=
ly.
> > > With other word, if we do not have properly operational environment
> > > providing system specific policies, it is better to run safe
> > > configuration - all ports/regulators are off.
> > >=20
> > > This means:
> > > - PSE controller driver should be registered as early as possible,
> > >   without caring about existence of PHYs, ports or network interfaces.
> > >   And configure ports in to default safe operation - off. Accept we
> > >   have some controller/firmware which would care about safety. =20
> >=20
> > Don't most PSE have I2C or SPI interfaces? So they have a different
> > life cycle to PHYs, ports or netdevs. Only PSEs which are embedded
> > within a PHY, on an MDIO bus, will have a closely linked life
> > cycle. But do such devices exist? =20
>=20
> i'm not aware of any.

Same here, but it's not impossible to have such device in the future.=20

> > As soon as the PSE probes with all the resources it needs, and can
> > impose a safe default setting. And that can be independent of PHY and
> > netdev. I _think_ we only need the netdev for configuration, since
> > ethtool addresses netdev's.  There would only be issues with user
> > space listening to udev creation events, it knows the PSE exists, but
> > it has no way to access it until the netdev is created. =20
>=20
> Ack. netdev is for configuration as virtual representation of PSE PI. And=
 it
> is easier to assign corresponding interface for the LLDP.
> We do not really care about the PHY; it just happens to represent the
> port at the farthest end described in the Device Tree.
>=20
> > > - as soon as we have all needed components, we can start provide
> > >   controllable interfaces to serve external consumers. =20
> >=20
> > Yep.
> >  =20
> > > If we decouple PSE and PHY registration (and we probably will need to=
 do
> > > it some day), we would need to have own implementation of deferred
> > > probing in the PSE core.  Event driven or by polling - which sounds n=
ot
> > > like very good idea. Pick your poison... =20
> >=20
> > I don't see why. Maybe i'm missing something. We have two cases:
> >=20
> > 1) PSE probes first. When the PHY looks up the PSE, it exists, and it
> > is passed a handle to the PSE.
> >=20
> > 2) PHY probes first. The PSE core returns EPROBE_DEFFER, and the PHY
> > will try again later.
> >=20
> > I don't think there is any chicken/egg problems. =20
>=20
> Ack, i guess it is optimization problem.

Yes, as I reply in another mail of the thread:
We should be able to get the PSE control either at PSE register time or at =
PHY
(or PHY port) probe time.

Maybe if the PHY can't find the PSE PI, we could save the phandle of the PS=
E PI
somewhere in the PHY structure. Then at PSE register time, look for each PH=
Y to
resolve every unresolved phandle.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

