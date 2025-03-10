Return-Path: <netdev+bounces-173519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9926A5941A
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 13:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3C818891EC
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 12:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F452221704;
	Mon, 10 Mar 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KzKTd0NL"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45C21D3E0;
	Mon, 10 Mar 2025 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741609271; cv=none; b=mXtJFHlhdwpl5vfK2m6yVyVbfNJgHMZdOeeAGkUsZZ9DNxbGAZV9m0O1600ALpMDjDdZn3dPm6qHtkksTGG4fT543NK/PuUsbd00QKxfWMo6PGxcHysA0CQNqCHh79fWfG41tqPERnG5xH37tM8Hq7dKtSIHgQQflq2Tgiaaoog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741609271; c=relaxed/simple;
	bh=kG/6duLH6+JR8sgCLdXA4bryNVV8tArPOwtlBWm0xAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMdr4yFnnHHGxFZynsjmrq9McbOypWFx7YlAqt5JebWIAaZ5d+XkmB9Vwo1ntc5ptzkQtZxPwXKFxTVfJ5b++rNB8gRAyVWLOgZp3jlgsksLZ0QEXB3DWrcxjyRv72WfL/nuFpfCpFjLVaAuQH/4BsIEfKf5TwqeJP9iHincspw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KzKTd0NL; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F34EB41DF6;
	Mon, 10 Mar 2025 12:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741609267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pre1cSCwMLHczqZ320YehUnrIubHHxclwoUWIKmSuYM=;
	b=KzKTd0NL0Gh0+LAjVx7C1mOxj0epcbNR7LZUlElc9gq/dUVHVQGK3VtS1ICqHMQYSrITzd
	FWu2rwS0OJAfbiKaMZAO1OVIpTvX0/C4cuM50Kfg0AgmAxZdqgf6riug27aQVU4AUs8NuP
	OOPDbHfUO2fGM/6oDuJL+cFU/WdQx+t+BJTD8hv1mSuF9ttVGwxfoYV0SpniSJw4gbb+2i
	dmiSSTc8LNnGwb3m8vtkLCk77NaNfFTMc2n2ipXzjdH6DxQTIEp0qHcm0MaekdR+OZWsT4
	Jwa0Qa3an69kdqyhSOiz3ACUcbBFPUHKaE0I/Pbhs5dC7RV4a4ihlgtUiRyxDg==
Date: Mon, 10 Mar 2025 13:21:03 +0100
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
Subject: Re: [PATCH net-next v2 4/7] net: ethtool: netlink: Introduce
 per-phy DUMP helpers
Message-ID: <20250310132103.1312d1b6@kmaincent-XPS-13-7390>
In-Reply-To: <20250308155440.267782-5-maxime.chevallier@bootlin.com>
References: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
	<20250308155440.267782-5-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelfeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeegiedrudekkedrvdefledruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepgeeirddukeekrddvfeelrddutddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Sat,  8 Mar 2025 16:54:36 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> As there are multiple ethnl commands that report messages based on
> phy_device information, let's introduce a set of ethnl generic dump
> helpers to allow DUMP support for each PHY on a given netdev.
>=20
> This logic iterates over the phy_link_topology of each netdev (or a
> single netdev for filtered DUMP), and call ethnl_default_dump_one() with
> the req_info populated with ifindex + phyindex.
>=20
> This allows re-using all the existing infra for phy-targetting commands
> that already use ethnl generic helpers.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V2: Rebase
>=20
>  net/ethtool/netlink.c | 53 +++++++++++++++++++++++++++++++++++++++++++
>  net/ethtool/netlink.h |  6 +++++
>  2 files changed, 59 insertions(+)
>=20
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index ae06b72239a8..a09bcd67b38f 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -559,6 +559,59 @@ static int ethnl_default_dump_one(struct sk_buff *sk=
b,
>  	return ret;
>  }
> =20
> +/* Specific context for phy-targeting command DUMP operatins. We keep in
> context
> + * the latest phy_index we dumped, in case of an interrupted DUMP.
> + */
> +struct ethnl_dump_ctx_perphy {
> +	unsigned long phy_index;
> +};
> +
> +int ethnl_dump_start_perphy(struct ethnl_dump_ctx *ctx)

Could you add comments or event better, kdoc for non static function to exp=
lain
their purpose.

> +{
> +	struct ethnl_dump_ctx_perphy *dump_ctx;
> +
> +	dump_ctx =3D kzalloc(sizeof(*dump_ctx), GFP_KERNEL);
> +	if (!dump_ctx)
> +		return -ENOMEM;
> +
> +	ctx->cmd_ctx =3D dump_ctx;
> +
> +	return 0;
> +}
> +
> +void ethnl_dump_done_perphy(struct ethnl_dump_ctx *ctx)

same.

> +{
> +	kfree(ctx->cmd_ctx);
> +}
> +
> +int ethnl_dump_one_dev_perphy(struct sk_buff *skb,
> +			      struct ethnl_dump_ctx *ctx,
> +			      const struct genl_info *info)

same.

> +{
> +	struct ethnl_dump_ctx_perphy *dump_ctx =3D ctx->cmd_ctx;
> +	struct net_device *dev =3D ctx->reply_data->dev;
> +	struct phy_device_node *pdn;
> +	int ret =3D 0;
> +
> +	if (!dev->link_topo)
> +		return 0;
> +
> +	xa_for_each_start(&dev->link_topo->phys, dump_ctx->phy_index,
> +			  pdn, dump_ctx->phy_index) {
> +		ctx->req_info->phy_index =3D dump_ctx->phy_index;
> +
> +		/* We can re-use the original dump_one as ->prepare_data in
> +		 * commands use ethnl_req_get_phydev(), which gets the PHY
> from
> +		 * what's in req_info
> +		 */
> +		ret =3D ethnl_default_dump_one(skb, ctx, info);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}

Regards,
---
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

