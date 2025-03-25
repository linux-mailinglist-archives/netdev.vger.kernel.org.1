Return-Path: <netdev+bounces-177422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A422CA70223
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABCD178AF0
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9CB25C6E4;
	Tue, 25 Mar 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LKMr+1s0"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107925BAD6;
	Tue, 25 Mar 2025 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909000; cv=none; b=RMMimBNv6JTmndIZZHgg9TWQHwQAmXVttgm87DmPOSCn60S3idP4kcWEklQTQWbSSF0Fh7FHHij6y0qdXplQujaLPd9nijCi29IsdyqeppNEI87JXDU6i+y/F7dofi+WTVw1ZBnXc3PnjAn3/34VSFEoFnm1it5d101VvZyN2E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909000; c=relaxed/simple;
	bh=vdEsbEtk+7p0UT7+RlZ+OGgqnolY34sAgPNR7Nhsm0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mXO0nFcDQhwZeLYCPOYrL88H7whLrxxlJ+yKmHPrNUosJN7r0fQKGOF6UGks4Jw+LfE85eqXeE9CH92xOb2zgfAzQ4J/R+lCA/Ce3YEL4yt17Y2o78TOY+ZTjuExCc1LEF6FgeHx/CG1M00Qf6SK1jwBjmZ3gAG8J3NGsJnuAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LKMr+1s0; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 422A44328C;
	Tue, 25 Mar 2025 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742908990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0Y4rbi2Stkd9XDs1slFcKcfqbdAPedwVnV7eZWlBTw=;
	b=LKMr+1s0QxpyenqwrJ5FOsOMT1KFchsJR6tnFf5EfFKfkrdU7q7IsdRiVQ9jcVQn5HgHSv
	x8+0tNH4e4gH240CDTEsp4Uu3ygcWKyf0ghT60MSmgag2pqNY73ofHiw5rJpcCodkNhUlA
	NC5S73rmFOSsEGNoKCtCCAoELK6mRmfRJR+m8OaJAccw4rLoaR9j9syGYosyKcDhZ+WVJU
	SmYIXi6y1V+2ozKMIrrOBnU73GBomJ3UigtQBdwWGaF14Xx1GjSI83zDvLfpcfY9/jvYII
	hZeazBA8DcAuYlVVyBQH3Bjh62QYG0KYUi49KYarNbcH5hlPFW8IzBjRc9+k0A==
Date: Tue, 25 Mar 2025 14:23:07 +0100
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
Subject: Re: [PATCH net-next v4 4/8] net: ethtool: netlink: Introduce
 command-specific dump_one_dev
Message-ID: <20250325142307.7c1b229d@kmaincent-XPS-13-7390>
In-Reply-To: <20250324104012.367366-5-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-5-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 24 Mar 2025 11:40:06 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Prepare more generic ethnl DUMP hanldling, by allowing netlink commands
> to register their own dump_one_dev() callback. This avoids having to
> roll with a fully custom genl ->dumpit callback, allowing the re-use
> of some ethnl plumbing.
>=20
> Fallback to the default dump_one_dev behaviour when no custom callback
> is found.
>=20
> The command dump context is maintained within the ethnl_dump_ctx, that
> we move in netlink.h so that command handlers can access it.
>=20
> This context can be allocated/freed in new ->dump_start() and
> ->dump_done() callbacks. =20
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V4 : No changes
>=20
>  net/ethtool/netlink.c | 61 +++++++++++++++++++++++++------------------
>  net/ethtool/netlink.h | 35 +++++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 26 deletions(-)
>=20
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 63ede3638708..0345bffa0678 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -339,24 +339,6 @@ int ethnl_multicast(struct sk_buff *skb, struct
> net_device *dev)=20
>  /* GET request helpers */
> =20
> -/**
> - * struct ethnl_dump_ctx - context structure for generic dumpit() callba=
ck
> - * @ops:        request ops of currently processed message type
> - * @req_info:   parsed request header of processed request
> - * @reply_data: data needed to compose the reply
> - * @pos_ifindex: saved iteration position - ifindex
> - *
> - * These parameters are kept in struct netlink_callback as context prese=
rved
> - * between iterations. They are initialized by ethnl_default_start() and=
 used
> - * in ethnl_default_dumpit() and ethnl_default_done().
> - */
> -struct ethnl_dump_ctx {
> -	const struct ethnl_request_ops	*ops;
> -	struct ethnl_req_info		*req_info;
> -	struct ethnl_reply_data		*reply_data;
> -	unsigned long			pos_ifindex;
> -};
> -
>  static const struct ethnl_request_ops *
>  ethnl_default_requests[__ETHTOOL_MSG_USER_CNT] =3D {
>  	[ETHTOOL_MSG_STRSET_GET]	=3D &ethnl_strset_request_ops,
> @@ -540,9 +522,9 @@ static int ethnl_default_doit(struct sk_buff *skb, st=
ruct
> genl_info *info) return ret;
>  }
> =20
> -static int ethnl_default_dump_one_dev(struct sk_buff *skb, struct net_de=
vice
> *dev,
> -				      const struct ethnl_dump_ctx *ctx,
> -				      const struct genl_info *info)
> +static int ethnl_default_dump_one(struct sk_buff *skb,
> +				  const struct ethnl_dump_ctx *ctx,
> +				  const struct genl_info *info)
>  {
>  	void *ehdr;
>  	int ret;
> @@ -553,15 +535,15 @@ static int ethnl_default_dump_one_dev(struct sk_buff
> *skb, struct net_device *de if (!ehdr)
>  		return -EMSGSIZE;
> =20
> -	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
>  	rtnl_lock();
> -	netdev_lock_ops(dev);
> +	netdev_lock_ops(ctx->reply_data->dev);
>  	ret =3D ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
> -	netdev_unlock_ops(dev);
> +	netdev_unlock_ops(ctx->reply_data->dev);
>  	rtnl_unlock();
>  	if (ret < 0)
>  		goto out;
> -	ret =3D ethnl_fill_reply_header(skb, dev, ctx->ops->hdr_attr);
> +	ret =3D ethnl_fill_reply_header(skb, ctx->reply_data->dev,
> +				      ctx->ops->hdr_attr);

Instead of modifying all these lines you could simply add this at the begin=
ning:
struct net_device *dev =3D ctx->reply_data->dev;

With that:
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

