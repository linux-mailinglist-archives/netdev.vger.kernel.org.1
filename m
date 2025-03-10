Return-Path: <netdev+bounces-173470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4145A5921D
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 11:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716F318834C5
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 10:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBB5226D1E;
	Mon, 10 Mar 2025 10:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TzK4TmYs"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E1E226CE3;
	Mon, 10 Mar 2025 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741604341; cv=none; b=aCftHSvHIqexIuTb8cRmkD8nd+5Dr4YuE1X9UEqF5LLnKZNQV9eEBUjfQs/6eu+qdFL1IUaZ0cFcQfKQdCrb8R2xNV5780bO2+BSrBD0eU+cygZL8PprqHqSeY1pg7aFUEXKraZr28J74TAW3R6GrHNGioiaqnmO8JM6LNcHI8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741604341; c=relaxed/simple;
	bh=9wNbV3c1RbB+bTecqq7dwB/tG1SFaMvgUKBpSaTbysw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oS7woxmP0SBa0p1a9d7lo/QeE4PrTSfBZpcMScbtJWqgOKv4EmzwyhjYtOQNJMFwSpr2khCGM2Q1Pc+P1Y37ubawqYUJ/yemlXcHWA26f7S3p3/0LFH8zgzu/X6PZp2HtxYs77kjOjTHBWse6dnThdk5eAMD//k/iS1vM0bfaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TzK4TmYs; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 559DC433E9;
	Mon, 10 Mar 2025 10:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741604331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgsLfidqIhlHf3EJwMY3mp/OkWEZkG2Dv0GxRVFknvc=;
	b=TzK4TmYsJBOQ5EYDy0mNyCM+pPktsxgHe5f34lRQAb1LQs5uS5VyA218yw0AkE8fpCMCL1
	pzQnDO4egdAuf7MZXDr1+8GWzOp1zQOES7kdoOwdl2HzSI9lnsfps61eXrAxqKghyKd3NN
	bWcJIldW27eXbth5gnGWiY8gevMuSdKg7bhAX1ycZuJTJAz0cAs99B+NhCHivdCulu/YMs
	IZBRqfk37H+eti87iJU7/HUEy+ky0Ax9eZznJezoxJgpZY82UdjzZGNBw0opsstWhVXTmg
	cXwWDUKidx9ZEoBlOUpMuNhmC9cfvGv26ET+8k8ThPB3jz+V16sCf2jaXi0fDA==
Date: Mon, 10 Mar 2025 11:58:45 +0100
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
Subject: Re: [PATCH net-next v2 1/7] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
Message-ID: <20250310115845.17a04100@kmaincent-XPS-13-7390>
In-Reply-To: <20250308155440.267782-2-maxime.chevallier@bootlin.com>
References: <20250308155440.267782-1-maxime.chevallier@bootlin.com>
	<20250308155440.267782-2-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudeludejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeegiedrudekkedrvdefledruddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepgeeirddukeekrddvfeelrddutddphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddvpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Sat,  8 Mar 2025 16:54:33 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> We have a number of netlink commands in the ethnl family that may have
> multiple objects to dump even for a single net_device, including :
>=20
>  - PLCA, PSE-PD, phy: one message per PHY device
>  - tsinfo: one message per timestamp source (netdev + phys)
>  - rss: One per RSS context
>=20
> To get this behaviour, these netlink commands need to roll a custom
> ->dumpit(). =20
>=20
> To prepare making per-netdev DUMP more generic in ethnl, introduce a
> member in the ethnl ops to indicate if a given command may allow
> pernetdev DUMPs (also referred to as filtered DUMPs).
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V2: - Rebase
>     - Fix kdoc
>     - Fix bissectabilitu by using the right function names
>=20
>  net/ethtool/netlink.c | 45 ++++++++++++++++++++++++++++---------------
>  net/ethtool/netlink.h |  2 ++
>  2 files changed, 31 insertions(+), 16 deletions(-)
>=20
> diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
> index 70834947f474..11e4122b7707 100644
> --- a/net/ethtool/netlink.c
> +++ b/net/ethtool/netlink.c
> @@ -586,21 +586,34 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
>  	int ret =3D 0;
> =20
>  	rcu_read_lock();
> -	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
> -		dev_hold(dev);
> +	if (ctx->req_info->dev) {
> +		dev =3D ctx->req_info->dev;
>  		rcu_read_unlock();
> -
> -		ret =3D ethnl_default_dump_one(skb, dev, ctx,
> genl_info_dump(cb)); -
> +		/* Filtered DUMP request targeted to a single netdev. We
> already
> +		 * hold a ref to the netdev from ->start()
> +		 */
> +		ret =3D ethnl_default_dump_one(skb, dev, ctx,
> +					     genl_info_dump(cb));
>  		rcu_read_lock();
> -		dev_put(dev);
> -
> -		if (ret < 0 && ret !=3D -EOPNOTSUPP) {
> -			if (likely(skb->len))
> -				ret =3D skb->len;
> -			break;

You are not checking -EOPNOTSUPP, so you can return this error in the
ctx->req_info->dev condition. I am not sure about the policy but do we want=
 to
report the EOPNOTSUPP error in the dump command instead of simply returning
nothing.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

