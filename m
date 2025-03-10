Return-Path: <netdev+bounces-173515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34345A59404
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1BB188E735
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364F22579E;
	Mon, 10 Mar 2025 12:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fJYw8Hnh"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD63322423B;
	Mon, 10 Mar 2025 12:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608862; cv=none; b=Y7BQ/it0Po4XU7X6Psqi3X4JeU9tXzEtKJcJoVaaATZDiHjzAcecMYZz68BRZa8CTlP/VxMMRCzKNy1sObS7X3oPxw0Of02Jzix7wB1yscB0Na+pfc/cIm+4BQqlAtJQeDLVDLUi2OKWfhIFgE3/+Vof15QftBV8Llx/iOLNSHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608862; c=relaxed/simple;
	bh=vuWxLW4zopk6VcKQXVcgbQeqQ+HqIL5/riOEkc+yDYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=duyWPlQ+Nh97GIRtAfh5pzI/zsI1mJt+m5m5s3mRM4nfD5Sksc4FP58L1mTRfwUSLFkkZYQo1/Vtn8AEZKssDR/NnwNdevCrsvaSZFrihnhcsJ4T9nUoqjUDLc1GIv8gf9X95NzMG1jB+MxePOoAQnBAQ1BIr2DAm0uP3qQqXt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fJYw8Hnh; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 922A1443F5;
	Mon, 10 Mar 2025 12:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741608858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CNm9BSsOfq9YjNo6tMCG7wnV+C6YM+88UmyM3ASeUTg=;
	b=fJYw8HnhXuhCIVN13OSw37EfydbxcYN7vD4cPiEwIhg0ewJwR4m5AGcunzenv2lFQXEHXw
	mnreD61Hvp4HRIX/qRmMigw7T7thB/GbXLTUGueG+M6Td45rLGqbC8HCXJQT1294f/ivHM
	WkqMX/mMzZt6ehIcOeCh3BXGjMaxXA6qRrZeXPwosH6vicCiWjwQNb8IY8GzlL3ZxhiTXn
	appYtMEllu/YTF5yRqxF2lRzEpq1nFFVMRn7gtE6nX8RMZLNUgQOve7xZVWAaSIiPd3qNA
	heRpjAjelZWHnfNKv2h0eBbbM4crWd6ETjsYEws5j1IlfUQjN/O28xY4MzzFhg==
Date: Mon, 10 Mar 2025 13:14:13 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Oleksij Rempel <o.rempel@pengutronix.de>, Simon
 Horman <horms@kernel.org>, Romain Gantois <romain.gantois@bootlin.com>,
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH net-next v2 5/7] net: ethtool: phy: Convert the PHY_GET
 command to generic phy dump
Message-ID: <20250310131413.505e676f@kmaincent-XPS-13-7390>
In-Reply-To: <20250308155440.267782-6-maxime.chevallier@bootlin.com>
References: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
	<20250308155440.267782-6-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeegiedrudekkedrvdefledruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepgeeirddukeekrddvfeelrddutddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Sat,  8 Mar 2025 16:54:37 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Now that we have an infrastructure in ethnl for perphy DUMPs, we can get
> rid of the custom ->doit and ->dumpit to deal with PHY listing commands.
>=20
> As most of the code was custom, this basically means re-writing how we
> deal with PHY listing.

Only nitpick ;)

> -static int
> -ethnl_phy_fill_reply(const struct ethnl_req_info *req_base, struct sk_bu=
ff
> *skb) +static int phy_prepare_data(const struct ethnl_req_info *req_info,
> +			    struct ethnl_reply_data *reply_data,
> +			    const struct genl_info *info)
>  {
> -	struct phy_req_info *req_info =3D PHY_REQINFO(req_base);
> -	struct phy_device_node *pdn =3D req_info->pdn;
> -	struct phy_device *phydev =3D pdn->phy;
> -	enum phy_upstream ptype;
> +	struct phy_reply_data *rep_data =3D PHY_REPDATA(reply_data);
> +	struct phy_link_topology *topo =3D reply_data->dev->link_topo;
> +	struct nlattr **tb =3D info->attrs;
> +	struct phy_device_node *pdn;
> +	struct phy_device *phydev;
 =20
Reverse xmas tree.

> -	ptype =3D pdn->upstream_type;
> +	/* RTNL is held by th caller */

Small typo here *the*.

The rest is good for me.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

