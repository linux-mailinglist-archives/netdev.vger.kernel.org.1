Return-Path: <netdev+bounces-172814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD11A5633E
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 10:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105A53B32FE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1D91B0416;
	Fri,  7 Mar 2025 09:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kgfoQ6Zy"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2E168B1;
	Fri,  7 Mar 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741338501; cv=none; b=YUeBYxUHfMAxFBfq45QgkoWiYpmDYwqWA7sIG5IxaehKcBYU+rgafnsJjmerjnbbFEWShf9FoXyqrrTGkhCHo3HhmQi6/txe7jrYKYsMsGtCp4mnPNCzd150kPo8yBb40Mm5dmei4SfXmLnUWERw17ekYF6r1NxkJykSsfFFPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741338501; c=relaxed/simple;
	bh=jOsiZoxoFzlTIhij6u4HaEvVq0vQLmO2U5xEqzBcz7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRvRu39w6kJH5R15byFgJ7FqGlvbpLYYM86gzyak4koeFfIOuxX3jnKTRQb6XPlS5MLrOBTA6ygfmOHH9o2yeBS2h9Ti14dSwaMKeYGKoWK2N2V51PrP5jcta8s50m8TUgCYtq6DlYB7eMmuNymch1k6LadcGaYF0lZL9kUWjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kgfoQ6Zy; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 339EE42FF4;
	Fri,  7 Mar 2025 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741338493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxdZ0Ku1n71J8CTAjlvJAGWeCY/e13LyHsQRhYqRe0Y=;
	b=kgfoQ6ZyI+B/x+wq5Xp0AXdaDaVcelUCNuzcnSS1tKniUx2KBPqb1T5Pj5MhIBrd1sLTDC
	vBVTSuJgtvq4dC/PhKM8a3GxkNAuVH37CgzcP16eQDhGbyGNk8WyriXq7kJBQ5S3buyvTS
	xpI6Y2FeuFYhop44Wk9Caf+/vGkVirrpHFOsq+4txB1CRYfoqCk1srdlj7X9zZxwAdIth7
	ySXkzIhlXNI2v/G1GwyfwJcq9uX0MhNgk5r9AWjOrK/A6nezD9CqOib+t4ppSrmmscs93M
	hOqPyNt08DegzFnODAAY8sMZRrSqxfTtUltJzmRDeqeNvqd4CsiMnIkfAzEQjQ==
Date: Fri, 7 Mar 2025 10:08:09 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Rob Herring
 <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
 <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 02/12] net: pse-pd: Add support for
 reporting events
Message-ID: <20250307100809.3de6db1e@kmaincent-XPS-13-7390>
In-Reply-To: <20250306174345.51a1d56d@kernel.org>
References: <20250304-feature_poe_port_prio-v6-0-3dc0c5ebaf32@bootlin.com>
	<20250304-feature_poe_port_prio-v6-2-3dc0c5ebaf32@bootlin.com>
	<20250306174345.51a1d56d@kernel.org>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeektdhfheemgegulegvmeejugehsgemjeeggeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemkedtfhehmeegugelvgemjeguhegsmeejgeegfedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvn
 hhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 6 Mar 2025 17:43:45 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 04 Mar 2025 11:18:51 +0100 Kory Maincent wrote:
> > +      -
> > +        name: events
> > +        type: u32 =20
>=20
> type: uint
> enum: your-enum-name
>=20
> and you need to define the events like eg. c33-pse-ext-state
> in the "definitions" section

Oh indeed, I forgot to use enum in the specs. Thanks for spotting it.
=20
> BTW I was hoping you'd CC hwmon etc. Did you forget or some
> of the CCed individuals are representing other subsystems?

I have Cced Regulator maintainers Mark and Liam. hwmon are not related the
regulator events.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

