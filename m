Return-Path: <netdev+bounces-148441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E19E19A8
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62F0286A77
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C421E3760;
	Tue,  3 Dec 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iLdB6GjU"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6761E283C;
	Tue,  3 Dec 2024 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222686; cv=none; b=dvghF/RHcZta1JIKm0RWaaerlf/DXs4Wr3qsNmpxf0W2KobIiT5vlgC1jLMIRdyHw2cbVXNfhJqo322wRb0i/po5XAlgX9rRISi4etHcoxB+A66nW5fGgaEBJ+Fuf3dpDC8KIq1Z+mjVJJ9QMsbkyy9hfRu4DsLXgwTk5+AZjzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222686; c=relaxed/simple;
	bh=2cf97DStc8SXFvwZ64aN4xBO2VdeZbTFsTd5rBywIxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQ5XDpsWm6R1Xp/3ugpxVm/KGTCfOxqKTaiEDaaivBtQRUkJ3volyPZlBQno7MkAovql5NlnOp2fjdkgCwLdI0YaVz3pYBAQrlS0L03fBryiUBaBiEIW8+9IIlFofHJjdLGxvHJ+wThA5sVTHkUJ5ncDEcEWmsJZUsilHGJ0TXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iLdB6GjU; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5A9CAC0008;
	Tue,  3 Dec 2024 10:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733222681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unHsDZc/1OE8HKcVN8mWXwEJ0vAKQ8TWz8xbclpBxHc=;
	b=iLdB6GjUhUagX3VUOAGI0cppokeRj3G2mikcZFPSPQ/IAmHHFFo+ppIQxlc+ADQ2VnouQ8
	yuqC9skT/femZbIR2erDLsU1Z87gESz+k0jI7NxUeFsoxgHSc3gVYHUqlj8ummM+iOMBAl
	cPxO22wmLlyqCNHR5lFmiSnfMd1aHcq4yj0du9C6OrM6g3Cp3pnPbIkuFBMI4QLlMS7qDo
	wlCGjTw0bxy/7487JgtVfE4sWKcbY5qRcT391fnXvOuRvUzxFxuR2bcWy5ypgvPsng715p
	OJPptZicX6jaClf4IhbBNg07ciN9bHXgBf95NUgZbVrUZuZa1ZuZNbZQvGD7rQ==
Date: Tue, 3 Dec 2024 11:44:38 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, Kyle Swenson
 <kyle.swenson@est.tech>, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH RFC net-next v3 26/27] net: pse-pd: tps23881: Add
 support for static port priority feature
Message-ID: <20241203114438.4f6d4c36@kmaincent-XPS-13-7390>
In-Reply-To: <20241203102913.GD9361@kernel.org>
References: <20241121-feature_poe_port_prio-v3-0-83299fa6967c@bootlin.com>
	<20241121-feature_poe_port_prio-v3-26-83299fa6967c@bootlin.com>
	<20241203102913.GD9361@kernel.org>
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

Hello Simon,

On Tue, 3 Dec 2024 10:29:13 +0000
Simon Horman <horms@kernel.org> wrote:
>=20
> > +static int tps23881_irq_event_detection(struct tps23881_priv *priv,
> > +					u16 reg_val,
> > +					unsigned long *notifs,
> > +					unsigned long *notifs_mask)
> > +{
> > +	enum ethtool_pse_events event;
> > +	int reg, ret, i, val;
> > +	u8 chans;
> > +
> > +	chans =3D tps23881_it_export_chans_helper(reg_val, 0);
> > +	for_each_set_bit(i, (unsigned long *)&chans, TPS23881_MAX_CHANS) {
> > =20
>=20
> Hi Kory,
>=20
> The storage size of chans is only 1 byte, but here we are pretending that
> it has more space. Which seems to be a bit of a stretch. Perhaps it would
> be better to simply use unsigned long as the type of chans here and in
> tps23881_irq_event_classification().

Yes indeed. Thanks for the report.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

