Return-Path: <netdev+bounces-177429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE824A7024A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC17717700E
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7FE179BF;
	Tue, 25 Mar 2025 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MT2bSinC"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28084A95E;
	Tue, 25 Mar 2025 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909659; cv=none; b=NWFnytgJroRvi7rjuce+N6Hz16rCs/DjIV1dyugUulDXsPjnNRK8/jcJyKhWmRsBA8WQASUWRw+2+I9LIXQzylP0s/TkD+9m9nGi6DwUJQZfzvW+xtrcFjkZmMRg+P+mXKLMpk/5EuOeo3lhTLoABzpMJVDWV8joLS7s9IUWEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909659; c=relaxed/simple;
	bh=jt/sPjWjug3egJdVdkpI3A7zPt9YVkGXm+6HGHagLDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lr8ABW3daFuO1qqK3peQ8aRwSNnMsuDI/4Rm5PyuZHsm3eh0n5hcC6XoytIQvG+NwAG3fkzD/2uyJnkvRsNVikjH0mrKuMtJ9QiLdZCapiB9obUp/uL8vOPIeJ8SJfmUcC80j/l9ueEPqkKdqdqvUYqndFIXs1rAGtYRroDfv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MT2bSinC; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7921F4326B;
	Tue, 25 Mar 2025 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742909654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cp05A3ncq1r6TSS05Wy5wCIMMlphKX62znrx7IOhkM=;
	b=MT2bSinCIIJxoo+uZCXE8NobKCTATTnWXSLD+MEYn1Cbf0q4yFnCAHXwi7ksKtomi1kgg4
	O53gziaEH8muXl8V/mn5SPTQGdDkfmaMSRo3TtqiLLSN8293XcL/Pxxs4bUTrjTf2tQYd2
	MQ51TNmeNIjidkLjLWUbWNJG/219tsbchKjtxidLuHMOZV2FItfl8OvXmBsn/k7Yd2ol+Q
	Z3u58uwdkRWt64sXtcPrXNOTFr0oVKegRhq2yRQnnRxTszSKn1CON//EGSI4xq0vgtXund
	ZyndzuyJ25ixCMaNHcdqMAPW+1Ht4zbieVJUeCeNfX7RUgTTu3vFr95AEDZw5A==
Date: Tue, 25 Mar 2025 14:34:11 +0100
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
 Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: Re: [PATCH net-next v4 5/8] net: ethtool: netlink: Introduce
 per-phy DUMP helpers
Message-ID: <20250325143411.241053ec@kmaincent-XPS-13-7390>
In-Reply-To: <20250324104012.367366-6-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-6-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 24 Mar 2025 11:40:07 +0100
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
> V4 : No changes
>=20
>  net/ethtool/netlink.c | 78 +++++++++++++++++++++++++++++++++++++++++++
>  net/ethtool/netlink.h |  6 ++++
>  2 files changed, 84 insertions(+)
>=20
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 0345bffa0678..171290eaf406 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -560,6 +560,84 @@ static int ethnl_default_dump_one(struct sk_buff *sk=
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
> +/**
> + * ethnl_dump_start_perphy() - Initialise a dump for PHY cmds
> + * @ctx: Generic ethnl dump context whose cmd_ctx will be initialized
> + *
> + * Initializes a dump context for ethnl commands that may return
> + * one message per PHY on a single netdev.
> + *
> + * Returns: 0 for success, a negative value for errors.

Minimal nitpick. In the kernel doc Return does not take a s.

> +/**
> + * ethnl_dump_one_dev_perphy() - Dump all PHY-related messages for one n=
etdev
> + * @skb: skb containing the DUMP result
> + * @ctx: Dump context. Will be kept across the DUMP operation.
> + * @info: Genl receive info
> + *
> + * Some commands are related to PHY devices attached to netdevs. As there
> may be
> + * multiple PHYs, this DUMP handler will populate the reply with one mes=
sage
> per
> + * PHY on a single netdev.
> + *
> + * Returns: 0 for success or when nothing to do, a negative value otherw=
ise.

Same.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

