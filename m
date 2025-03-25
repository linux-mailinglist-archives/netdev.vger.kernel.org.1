Return-Path: <netdev+bounces-177430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F29CDA702E8
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 14:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB500846BB7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58EF25A338;
	Tue, 25 Mar 2025 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mpCSdXTo"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F6325A349;
	Tue, 25 Mar 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909707; cv=none; b=M6HVFQoEoQmnvhh/ZIL0DEWqUFqGQOL3Zhgo5uiqDqv06WpNqdyHT0lOY6NB6vUlaMyP1iJtQBV6hepBRwdkSlPut6IHu5NLiqO7Bq1C/o8GssaSXD2cl4XTTnUYQIJTjm0sQQs9l6WtJajI7pxV5yjh1qT68eY8PFO2pQyVdSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909707; c=relaxed/simple;
	bh=WI41gQeUVwlwx/C5aVo4GOyLB3bQLZwTkYbzcXT0gJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvn+m8KTYdIbhEBCUaZpp61nvX92MnO0+6A1pleQDznKlmLhgyI0NJGbLk1iQV1Fgw6Ro4UspMcPiPmGMu/9bpaVN40P9ie8IroF1TpzApNquNKn9NQIjPiAcT6nnXnRa5QwpbxbSI8ZMYcfZCDalsxFKf8rTr7x7nfv4bPte8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mpCSdXTo; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 65FFF44288;
	Tue, 25 Mar 2025 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742909704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laPzi6AI5df0hYY8xCpaxh0N0Q/AFGk3Kz/EhxGguPo=;
	b=mpCSdXTo+eVQSvjH2mkqzNcJ3dA0St0l8cbiIWzog554Nstg13Ec+f9qeBFJZJya/rr6D/
	PFmcm9zItkOtmf2lnVqHpcBqL2bFJ9zJl9wLDPMqcr8JeyZMO2J4/pCwm7oNanvkarN5D3
	45OsuA6Y5Tldb2CzDwrr76OueVSWySifM9qRKj0caKixcai5PUiN45Cm6eHCixQOcc8AVr
	Flp1Zyez1cNCQlvZgzSN9YqzI1K4nKlo9Xbvn+6z+XdcWYZmBOAB2nytcm4Hy8LLI8bpU4
	dXIpO9aNq/GNYIFKuhA7TXj87qWGUeOxsckPFdbNQ939OzmXCp1fYpi1Y9jABA==
Date: Tue, 25 Mar 2025 14:35:02 +0100
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
Subject: Re: [PATCH net-next v4 8/8] net: ethtool: pse-pd: Use per-PHY DUMP
 operations
Message-ID: <20250325143502.515e0bde@kmaincent-XPS-13-7390>
In-Reply-To: <20250324104012.367366-9-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-9-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 24 Mar 2025 11:40:10 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> Leverage the per-phy ethnl DUMP helpers in case we have more that one
> PSE PHY on the link.
>=20
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
> V4 : No changes
>=20
>  net/ethtool/pse-pd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
> index 4f6b99eab2a6..f3d14be8bdd9 100644
> --- a/net/ethtool/pse-pd.c
> +++ b/net/ethtool/pse-pd.c
> @@ -314,4 +314,10 @@ const struct ethnl_request_ops ethnl_pse_request_ops=
 =3D {
> =20
>  	.set			=3D ethnl_set_pse,
>  	/* PSE has no notification */
> +
> +	.dump_start		=3D ethnl_dump_start_perphy,
> +	.dump_one_dev		=3D ethnl_dump_one_dev_perphy,
> +	.dump_done		=3D ethnl_dump_done_perphy,
> +
> +	.allow_pernetdev_dump	=3D true,
>  };

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

