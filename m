Return-Path: <netdev+bounces-177673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD80A711AE
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 08:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 318C9188F7DC
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 07:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031041A23AD;
	Wed, 26 Mar 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mKKZrAU0"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E21A0BFD;
	Wed, 26 Mar 2025 07:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975564; cv=none; b=aB1d2q1DzKol77D5mXkvReYv6EghqIgdnwrs1Rr3mgTfW6Xgz9Ra+6yIQQ5KNxUgpwCPZjZKXpNpop0KtQ88yWO4MuxTJmoFXvfZfsn/oksjExK2V5ad0SZWOC7+RZ2G3wi9fAffMj7bVj+nIt2Kp2gcS9AepaskSqEU3dCOxYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975564; c=relaxed/simple;
	bh=JlOo6lbdSJoKXgHirTe6VKRRlXLcY56QZ21/hHnA6Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trGEECx2WuNkBEMYuy8YSCQ4W/h3HX2ZxsJBUusTxERoYSsUz1bAPxi2SN75FirHNgBaYmF9is1f2XxunQLsJvScbM1qq0IZDuEtGskTJBBJ3rN8d1HJvLuh/ahGGnruiJPQusCrVbvTKxDY+lY3nvIi9xovNM1Kz0keH0BhcUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mKKZrAU0; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4816120485;
	Wed, 26 Mar 2025 07:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742975559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=22VVT/IdUfbn7Nm3ltcmZG99Pcs+4KpPbX15z8OZADw=;
	b=mKKZrAU03dnwsMUGTPxUFqi8kkMGztO/ATNyWhoXP7lNAzlivdJrWNE6V2Xs8VWqqivIwx
	rI8ty9WrMBp25D4OVHPZEMxV7fJY8a+skXw5V9i1Jfil4+saAH7Pz+7XPHvq0jm2lym4/Q
	GF6DYRchLiSLFuQb61tymzyQyYTpfxGGWDzOgy82e0cVGqzx7NEs+b8Dwu7ayXtE2pIBs6
	zb0zb7kST1N95kDBMveYwBONT2etZQBJMQ3vNjPxCKM0OqxgS0tFyVr0XyBPyHSNEXaGI5
	rEPSY9JkrTkCkU8fM62Z7sZ9pFmjFPiBqvPTUpAOd22mJ5M4RJkur1Fc6yIrqQ==
Date: Wed, 26 Mar 2025 08:52:36 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 0/8] net: ethtool: Introduce ethnl dump
 helpers
Message-ID: <20250326085236.0481e6fa@fedora.home>
In-Reply-To: <20250325143111.4a9e26c2@kernel.org>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250325143111.4a9e26c2@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieegleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepuefhfefggfdthffghfdvhffhhfetuedtkeetgffhteevheehjeejgfduieduhedunecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddtpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepvgguu
 hhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi Jakub,

On Tue, 25 Mar 2025 14:31:11 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 24 Mar 2025 11:40:02 +0100 Maxime Chevallier wrote:
> > The patches 1 and 2 introduce the support for filtered DUMPs, where an
> > ifindex/ifname can be passed in the request header for the DUMP
> > operation. This is for when we want to dump everything a netdev
> > supports, but without doing so for every single netdev. ethtool's
> > "--show-phys ethX" option for example performs a filtered dump.
> >=20
> > Patch 3 introduces 3 new ethnl ops :  =20
> >  ->dump_start() to initialize a dump context
> >  ->dump_one_dev(), that can be implemented per-command to dump   =20
> >  everything on a given netdev =20
> >  ->dump_done() to release the context   =20
>=20
> Did you consider ignoring the RSS and focusing purely on PHYs?
> The 3 callbacks are a bit generic, but we end up primarily
> using them for PHY stuff. And the implementations still need=20
> to call ethnl_req_get_phydev() AFAICT

True, one can even argue that the start() and done() aren't really
useful (allocate/free a ctx, we only really need to know the size of
the context), we'd end-up with just one dedicated helper for PHY dump.

I'll rework this and spin a new version when net-next re-opens, and
I'll clarify the DUMP behaviour for filtering, based on the discussin
with K=C3=B6ry.

Thanks a lot for taking a look then,

Maxime

