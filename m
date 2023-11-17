Return-Path: <netdev+bounces-48652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC9C7EF1A3
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 12:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA51C20A00
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413C22E622;
	Fri, 17 Nov 2023 11:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VWPl67PS"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34313131;
	Fri, 17 Nov 2023 03:22:40 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25E0640004;
	Fri, 17 Nov 2023 11:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1700220158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fOkcD53K2X7G4s1f8bk4UTCX0fMzMsSeEhZvt45ySJg=;
	b=VWPl67PS3AfKt8VvL1wMfbZBojORBn/Ix+LPQcsRJptePEqD1KyCPT6eadL8PGkgJB0Le2
	2mj7RcXQm0z+7LlMIWtsUc+JeMHHqupdKhlxpiJqSYgrnWx4GkeIxpV5BKexez8XtQaHgr
	PI0zp2s6eeiDcyzYWUpajSHZRQpRq2Jq8vT+t9UkrwWGdtTVd7/9AWKhquccKG+PkD2KXL
	2cHxy6b2ZcYO9O3oNV1h6ldKKouQuNGQdEmwxp6vyk4WWA7UvcaLEbx0lHtK/lAI0tQsY5
	uhw2BSWoUZnmdqQHWPPl6b6TfLKZfn83I+3lgM6bOv4Kv5V2rskJUIfC8K+5oQ==
Date: Fri, 17 Nov 2023 12:22:36 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: pse-pd: Add PD692x0 PSE controller
 driver
Message-ID: <20231117122236.3138b45e@kmaincent-XPS-13-7390>
In-Reply-To: <8e077bbe-3b65-47ee-a3e0-fdb0611a2d3a@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
	<20231116-feature_poe-v1-9-be48044bf249@bootlin.com>
	<8e077bbe-3b65-47ee-a3e0-fdb0611a2d3a@lunn.ch>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Thanks for your review!

On Thu, 16 Nov 2023 23:41:55 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> > +struct pd692x0_msg {
> > +	struct pd692x0_msg_content content;
> > +	u16 delay_recv;
> > +}; =20
>=20
> > +	if (msg->delay_recv)
> > +		msleep(msg->delay_recv);
> > +	else
> > +		msleep(30); =20
>=20
> > +	if (msg->delay_recv)
> > +		msleep(msg->delay_recv);
> > +	else
> > +		msleep(30); =20
>=20
> > +	if (msg->delay_recv)
> > +		msleep(msg->delay_recv);
> > +	else
> > +		msleep(30);
> > + =20
>=20
> As far as i can see with a quick search, nothing ever sets delay_recv?
>=20
> 	Andrew

In fact I wrote the driver taking into account that there are two commands =
(save
and restore) that need a different delay response. As currently we do not
support them I can indeed drop it for now and add it back when I will add t=
heir
support.

Regards,

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

