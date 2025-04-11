Return-Path: <netdev+bounces-181560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A74A8583D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F4B189BBF1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6A127CCE2;
	Fri, 11 Apr 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCqsjHb0"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9826AA7;
	Fri, 11 Apr 2025 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744364601; cv=none; b=A44/jtA9EKZ4vU0nn/cWjhhvmHIjOLXh+0gnoZita4MDqV5j2b9TTINTVpczicTIuzKWoKKxiNrebMuK6dNdsJQNyDLccRsdw9sTerGHc3sxgU5TLcd1UTHzMChjuTITphicvtSuY73mlgdboQYbtHDLmffYWJpfjJ8A5bG+pDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744364601; c=relaxed/simple;
	bh=ZME8Tn9ZexvrhNDvWXDyemzAGyiSUHmYYEAeyQD0j+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU/Kr8u9cEbqtCKJ3F7Ba1EF/srbF6bGaARQVsafxl7D9Z0k4Dgc1S5kd7U63+QeoOfSX00hFg4jN4zlxj9NtSSCDfD/1RgYDt2h+7gAz2mOwrDo7mRE1yax6n6zn458P4o6Bt+frv7bo4mW8XK9DoUs7e0IgJnY4uZD2g+cZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCqsjHb0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E97F54396B;
	Fri, 11 Apr 2025 09:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744364595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFWGjDZpJQKWyumVjSVusoS+pfr9Jcz83VYW30MbCNo=;
	b=fCqsjHb0p3H4RhP2fTJ1bBk411wyD/V8beCqlH9flF+GIlda+loLy/ToVzo0eLyE2rmduW
	TqBjU9eybhdcwg31kAp/hGSZXNdYp236DeifyS9oyJKJWhwMEYnjfKJyXAsfa56+edTC4m
	PldMctDHy4YQKJk5YMaZy2f4Q1igGm710fWax1dmQUTp0pCxGVdgl9lnNDS7o/w+3oRbwr
	mwXglju99zvQyVD22Zt0fpXwEiSIJ4iyTxFU6npEPIhVm/I6crKverLBbuEKgXNcTnmOU/
	uMOMABjYC0SUV/TxOEek1jTAiz7fAEQG7zj1myORsdtDVZFXRbfifvDxBz5Eqg==
Date: Fri, 11 Apr 2025 11:43:11 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Donald Hunter
 <donald.hunter@gmail.com>, Rob Herring <robh@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, kernel@pengutronix.de,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, Liam Girdwood
 <lgirdwood@gmail.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Dent Project <dentproject@linuxfoundation.org>, Mark Brown
 <broonie@kernel.org>, Kyle Swenson <kyle.swenson@est.tech>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 07/13] net: pse-pd: Add support for budget
 evaluation strategies
Message-ID: <20250411114311.22c869e9@kmaincent-XPS-13-7390>
In-Reply-To: <Z_e3chchKI5j6Ryv@pengutronix.de>
References: <20250408-feature_poe_port_prio-v7-0-9f5fc9e329cd@bootlin.com>
	<20250408-feature_poe_port_prio-v7-7-9f5fc9e329cd@bootlin.com>
	<Z_e3chchKI5j6Ryv@pengutronix.de>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmegsvgdvjeemvggstgegmegvtgdvfhemvghfvgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkeehkeejmeejuddttdemsggvvdejmegvsggtgeemvggtvdhfmegvfhgvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdejpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegurghvv
 ghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphhtthhopeguohhnrghlugdrhhhunhhtvghrsehgmhgrihhlrdgtohhm
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 10 Apr 2025 14:20:02 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Hi,
>=20
> looks like i started to review it and forgot to send it. Sorry :)

Hello Oleksij,

Thanks for you review and the naming fixes!

> On Tue, Apr 08, 2025 at 04:32:16PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This patch introduces the ability to configure the PSE PI budget evalua=
tion
> > strategies. Budget evaluation strategies is utilized by PSE controllers=
 to
> > determine which ports to turn off first in scenarios such as power budg=
et
> > exceedance.
> >=20
> > The pis_prio_max value is used to define the maximum priority level
> > supported by the controller. Both the current priority and the maximum
> > priority are exposed to the user through the pse_ethtool_get_status cal=
l.
> > +/**
> > + * _pse_pi_enable_sw_pw_ctrl - Enable PSE PI in case of software power
> > control.
> > + *			       Assumes the PSE lock has been acquired
> > + * @pcdev: a pointer to the PSE
> > + * @id: index of the PSE control
> > + * @extack: extack for error reporting
> > + *
> > + * Return: 0 on success and failure value on error
> > + */
> > +static int _pse_pi_enable_sw_pw_ctrl(struct pse_controller_dev *pcdev,=
 int
> > id,
> > +				     struct netlink_ext_ack *extack)
> > +{ =20
>=20
> Is it for "admin enable" or "start power delivery"?

Power delivery.=20

I will rename it to: _pse_pi_delivery_power_sw_pw_ctrl

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

