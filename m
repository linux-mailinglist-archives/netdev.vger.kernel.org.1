Return-Path: <netdev+bounces-195710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED39AD2087
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A71F3A5CEA
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A589B25A2B4;
	Mon,  9 Jun 2025 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dHb7UP9Q"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFBF25B1FC;
	Mon,  9 Jun 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477839; cv=none; b=mVd3H0uht1kxHuz7uTBPWcvkdGE4AfSQDTIOgYP047pAxdalhMKoOSlm406eMk8aJQlelk6GKDmO4CzrzVs0BCnqg1BE9VGy6DpcZv5cCSTyHqOPRw1R3sSIAlt5jSLulclbg5/GdNIjn+MapdkEZBco1m25T10tjtreyedlW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477839; c=relaxed/simple;
	bh=G45qDbAehHP+NM/bfLTf8rrcj6I8n8nlynfPDbDRo3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qdTWd1VEHKWbn+w2L+z+QkMXZ4wkBr0c8Vsn/bhFGGASHKLlIW29uTLT7myGdQVomjNFqvlbnlmw36PeCCq18hNgY7QirOUygcCdFMj34zsOKjOd/AZTlTcgdKIDmGF8AnHgDeCH5blfJe4XXSLCV9es+jnk+v4S8IiWUXZ7dbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dHb7UP9Q; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4124243EB4;
	Mon,  9 Jun 2025 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749477829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OqMBpg9+vjtHlgxrQiNduRjtVddZANrog7hUYnBT5YU=;
	b=dHb7UP9Qm8R2b2sYhW4xHcgsGQGVkTY5pv94V/mgXxenhroYTbQr0jbuTLbIKYVTve/L/h
	YBd6keuLT7NYBJo5fOX9RD0fAqjjmCGq5h5BCoFU/trCVwbqG+nx0vv24mCUaA8fKmWE1y
	TrHh4BoFWSCS0Hx7GTU6xfNiEbd4c0HpDIiea7SNSSGvTKlqGSmec0jeiDTaFWu+FdinnG
	q4j6FB6STjwvPfEb/hHVWhWRGQ4bdB5eUOYsO3zuyQw/0t6Oa66uHgAfydzBi4kmLyxorW
	0R7UyUw4LU4cBdDSLNxnWT2eZB0EnUuqMs07cuowxpalKm6O0k/L9L8hiHStGg==
Date: Mon, 9 Jun 2025 16:03:46 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Gal Pressman <gal@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Oleksij
 Rempel <o.rempel@pengutronix.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget
 evaluation strategy
Message-ID: <20250609160346.39776688@kmaincent-XPS-13-7390>
In-Reply-To: <f5fb49b6-1007-4879-956d-cead2b0f1c86@nvidia.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
	<71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
	<20250609103622.7e7e471d@kmaincent-XPS-13-7390>
	<f5fb49b6-1007-4879-956d-cead2b0f1c86@nvidia.com>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelfeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqheftdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfejveefgeeggefhgfduhfehvdevvdeukeelveejuddvudethfdvudegtdefledunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdelpdhrtghpthhtohepghgrlhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvm
 hhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: kory.maincent@bootlin.com

Le Mon, 9 Jun 2025 14:03:46 +0300,
Gal Pressman <gal@nvidia.com> a =C3=A9crit :

> On 09/06/2025 11:36, Kory Maincent wrote:
> > Le Sun, 8 Jun 2025 09:17:59 +0300,
> > Gal Pressman <gal@nvidia.com> a =C3=A9crit :
> >  =20
> >> On 28/05/2025 10:31, Paolo Abeni wrote: =20
>  [...] =20
> >>
> >> Are all new uapi changes expected to come with a test that exercises t=
he
> >> functionality? =20
> >=20
> > I don't think so and I don't think it is doable for now on PSE. There is
> > nothing that could get the PSE control of a dummy PSE controller driver=
. We
> > need either the support for a dummy PHY driver similarly to netdevsim or
> > the support for the MDI ports.
> > By luck Maxime Chevallier is currently working on both of these tasks a=
nd
> > had already sent several times the patch series for the MDI port suppor=
t.
> >  =20
>=20
> We shouldn't rule it out so quickly, testing is important, let's try to
> accommodate to our rules.
>=20
> Why can't this be tested on real hardware using a drivers/net/hw
> selftest? The test can skip if it lacks the needed hardware.
> Or rebase this over Maxime's work?

How should I do it if I need to use ethtool to test it? It is a vicious cir=
cle
as ethtool need this to be merge before supporting it.
Would it be ok to accept it like that and wait for ethtool support to add t=
he
selftest?
Otherwise I could test it through ynl python command but there is no similar
cases in the selftest.

Nevertheless, it would have been nicer to point this out earlier in the ser=
ies.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

