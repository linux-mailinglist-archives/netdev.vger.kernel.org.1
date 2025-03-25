Return-Path: <netdev+bounces-177324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B8A6F294
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105DA188DAF5
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E861B1F0E5A;
	Tue, 25 Mar 2025 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f0UULc8Q"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277512F3B;
	Tue, 25 Mar 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742902033; cv=none; b=ZRY9g9MxUwoPmQdMmv/Esp5y0vBhp3ZGd7xarUcoXUKcIROEHlGkqbAuoNFv3DNDFb762F1epXnLDsD6BPs6QQ2NIylxhgWk0IFTnaGSXB30/HCmxW0ca2QmC32b7TV8LRgXXz06tVGp472aXW2FOh22lowjZUzveDvdtNEkg0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742902033; c=relaxed/simple;
	bh=LHRJNm4y9hcDnYFIsgbkIebsO0SzBKkTA6w6Z7ABlwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYoJcH5Jx0Y+vWzpBlXYpfMMBe+6jiM1A+rR/93XiV1aBMC+Esgf5z4gp8/NewN4RpcyJcsiuVfZkb4DXkJEa+/HRFyKaVHqSlvBXxc3+bgIvu6/C+OMjCTuaF1oKfaHo9yoUGdXr/RgstXKQKX0l0Zv48FBKeR90QYpatZr79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f0UULc8Q; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8315643152;
	Tue, 25 Mar 2025 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742902029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lfrh2U3s5gJkhXevgALQGNGwSRMvmBuZkh+1nqK6iiw=;
	b=f0UULc8QP2HFxL2IDc1MxICDn1HxX6bk+rIOjyQkUMX8Jftk/Cg8VIU6gyn7iz3houuF69
	ZYqGoajDkXeshwoA46cMlw/AQD6DC4aHfs97vZSZiPKi2RlxnoTSbUDHscqs6D0dn9tqiq
	VOsMsdojlkK0P8vxpZtWHWe2Z6oFn6ZBPbDm9VfVvW+tj5k1I7azoSt7pShbjVrolDC9q9
	zZyDj5V3bNNHVh4UFW3gPDsLSBn5V8BFJ7Hm556Oh2Bw6j3pl94NH8hZZH+PejapK/mKIg
	2R0hccHCWaeP2BeJ3Fg7sWueDGZoao27rAjws7KaRrYLt3TZuZrKE+pYWACsoQ==
Date: Tue, 25 Mar 2025 12:27:06 +0100
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
Subject: Re: [PATCH net-next v4 2/8] net: ethtool: netlink: Allow
 per-netdevice DUMP operations
Message-ID: <20250325122706.5287774d@kmaincent-XPS-13-7390>
In-Reply-To: <20250324104012.367366-3-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-3-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 24 Mar 2025 11:40:04 +0100
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

...

> +
>  /* generic ->start() handler for GET requests */
>  static int ethnl_default_start(struct netlink_callback *cb)
>  {
> @@ -636,10 +659,10 @@ static int ethnl_default_start(struct netlink_callb=
ack
> *cb) }
> =20
>  	ret =3D ethnl_default_parse(req_info, &info->info, ops, false);
> -	if (req_info->dev) {
> -		/* We ignore device specification in dump requests but as the
> -		 * same parser as for non-dump (doit) requests is used, it
> -		 * would take reference to the device if it finds one
> +	if (req_info->dev && !ops->allow_pernetdev_dump) {
> +		/* We ignore device specification in unfiltered dump requests
> +		 * but as the same parser as for non-dump (doit) requests is
> +		 * used, it would take reference to the device if it finds

This means the dump will have a different behavior in case of filtered dump
(allow_pernetdev_dump) or standard dump.
The standard dump will drop the interface device so it will dump all interf=
aces
even if one is specified.
The filtered dump will dump only the specified interface.=20
Maybe it would be nice to have the same behavior for the dump for all the
ethtool command.
Even if this change modify the behavior of the dump for all the ethtool com=
mands
it won't be an issue as the filtered dump did not exist before, so I suppos=
e it
won't break anything. IMHO it is safer to do it now than later, if existing
ethtool command adds support for filtered dump.
We should find another way to know the parser is called from dump or doit.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

