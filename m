Return-Path: <netdev+bounces-177696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FEFA714EB
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9AB188E734
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6F1B424A;
	Wed, 26 Mar 2025 10:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZkVnWLoQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5941B412A;
	Wed, 26 Mar 2025 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984985; cv=none; b=HYHNEUgr6HjNfmrfmJ2Gl1bnIWVaTMjrObB74IZkKux2B+Bn7zmfSvA70jPh6pOY+1+iuk9L8Zdddkr5XvwK9Wf0t7bkjkoHYeH4fTJu3DBLA46ekzRPm7fzbynqR+tzLLgIET0kk/PTwiIjkck+oR9AcDRsY5RDfgwnJ+vPsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984985; c=relaxed/simple;
	bh=TOgi/Jjaf0RpvCLJTunj57XUy+5rudcp0XhlwUL45eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvII0H6Y012gBM+wzGhbS9l+bCR7pvmkffDJB1OzU0VJo8A03YmEEmi68Ejxaz8/fOkS0K6Da0wpRAOqf1/I7hco5uSZBa0161QDzS0UmQy8wYvSOwn9eLI5GdgAb4e71xF2LO5VEvjPBK3+LoZrpDymmBaktZiETf8Yuv/VcS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZkVnWLoQ; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AE6194318E;
	Wed, 26 Mar 2025 10:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742984981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PaB+63UMpKqA/cMni297B+HHa1pb6tlIFYAG3q6MvzE=;
	b=ZkVnWLoQ+OawRtwQyePP9oplAMy9EpwY/udMgBcZP7VWRM6OO4LWMZb6ktH2TxjO6uuFYE
	T5Ho940K+8eFUiol4RmF8ZhGZbSuMrIryI7R3PLEmRGu7SVFuA+t2VxWTFs6vuBFQ+ZGPk
	8X3Fw/aj1LuIYLv9GSyhZlAYy9M7HZVbn2zCKQ3pJdegmF6n/mxwuXzkhI79WOd/Ga5ZNZ
	oY1b4nzhUf0OMr39m37HwtoJC40ZOEMdTufhoDPPq5B8cDYvjOODfGS0weY4pNhnXxwI+p
	7AONu/dVWaYnEQht37AZlLYRA0tNdNgzRudBRdVsjeFygqn7P6vlCLpYbDQo6A==
Date: Wed, 26 Mar 2025 11:29:36 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 2/8] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
Message-ID: <20250326112936.16f8b075@kmaincent-XPS-13-7390>
In-Reply-To: <20250326085906.62a7c9fc@fedora.home>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
 <20250324104012.367366-3-maxime.chevallier@bootlin.com>
 <20250325122706.5287774d@kmaincent-XPS-13-7390>
 <20250325141507.4a223b03@kernel.org>
 <20250325142202.61d2d4b3@kernel.org>
 <20250326085906.62a7c9fc@fedora.home>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieehvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudelmeekheekjeemjedutddtmeelkegvsgemjeejvggsmeejieefmegufeefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekheekjeemjedutddtmeelkegvsgemjeejvggsmeejieefmegufeefvgdphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhto
 hepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Wed, 26 Mar 2025 08:59:06 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> On Tue, 25 Mar 2025 14:22:02 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
>=20
> > On Tue, 25 Mar 2025 14:15:07 -0700 Jakub Kicinski wrote: =20
>  [...] =20
> > >=20
> > > Let's try. We can probably make required_dev attr of
> > > ethnl_parse_header_dev_get() a three state one: require, allow, rejec=
t?
> > > =20
> >=20
> > Ah, don't think this is going to work. You're not converting all=20
> > the dumps, just the PHY ones. It's fine either way, then. =20
>=20
> Yeah I noticed that when implementing, but I actually forgot to mention
> in in my cover, which I definitely should have :(
>=20
> What we can also do is properly support multi-phy dump but not filtered
> dump on all the existing phy commands (plca, pse-pd, etc.) so that be
> behaviour is unchanged for these. Only PHY_GET and any future per-phy
> commands would support it.

Couldn't we remove the existence check of ctx->req_info->dev in
ethnl_default_start and add the netdev_put() in the ethnl_default_dumpit()?
Would this work?

Or we could keep your change and let the userspace adapt to the new support=
 of
filtered dump. In fact you are modifying all the ethtool commands that are
already related to PHY, if you don't they surely will one day or another so=
 it
is good to keep it.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

