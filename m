Return-Path: <netdev+bounces-177315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED73A6EE65
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB926188D466
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B052B251790;
	Tue, 25 Mar 2025 11:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iqNRSa8/"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F2818E351;
	Tue, 25 Mar 2025 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900591; cv=none; b=ehlGgDAppulZpmnRgJD1kwIl8mgPbWoB6PYdfhruyWRA3MZgjdxjTG4156Lr/fhOdWulN6PKKz4N/X2Tnwg8AXF1jm9EHjDzPClqrfLgBVu2ieRyC96ACJfjO7BZmYl0HXNic5HCiZnclBFYJjtlpgHkg/0s0OfUOG6O9V0WBZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900591; c=relaxed/simple;
	bh=ecI0siXMihXoord9l1qi/ipKBBj6g0IZTOk0hWEjN3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwNQaDbhahvEMSQqYPlsYAyZ5SnQFykB795qnqDuhsSux+O1+79N86EMST3a7VvC40ePQ2eBgOmdzzPWn001EEdOWMcm8fYuKvVHul5atEB4Do4T/hWHblslckgghPb713Wq3mH45Q/Tx11Ftj+fkNBeS31vtGsbBpCRc1yeFu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iqNRSa8/; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D33844268;
	Tue, 25 Mar 2025 11:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742900587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QdYd+vEdamak2MCnqAsE3kD8l4P2fha+M49/OdiAbBM=;
	b=iqNRSa8/yPLQTgVKWPi+RLTphyxOq4JVLBg3B2sCSYLzaAmHtwnyFX1fU4yezUdeaCfn4F
	ctIN8baZucCaWhOoHvKnfwwxfv+aFYqYHbC6VwP1rnfVpRMiT1pB/hZ9ukgXXE391Emqjs
	aVkP/ooFYfWZtclKdzUukz8ouq+PmAuxnj2kdG9eRtolJvyszH5sz2gN4rHd9VbY6aT6CW
	/8JXUWmBWo65hqknFSz5uPpQxYy1wh8hAGiu5VB5gIcAKTzVp4laUYnPL8MzGn5nytPdFk
	WppW0HmnjULiONbEX2SB0jbG596/aj47G6Vx/FBpVzFbm1ZEIBA9sVlqJIUuaw==
Date: Tue, 25 Mar 2025 12:03:05 +0100
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
Subject: Re: [PATCH net-next v4 1/8] net: ethtool: Set the req_info->dev on
 DUMP requests for each dev
Message-ID: <20250325120305.0650bb0a@kmaincent-XPS-13-7390>
In-Reply-To: <20250324104012.367366-2-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
	<20250324104012.367366-2-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvgeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhop
 egvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 24 Mar 2025 11:40:03 +0100
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:

> There are a few netlink commands that rely on the req_info->dev field
> being populated by ethnl in their ->prepare_data() and ->fill_reply().
>=20
> For a regular GET request, this will be set by ethnl_default_parse(),
> which calls ethnl_parse_header_dev_get().
>=20
> In the case of a DUMP request, the ->prepare_data() and ->fill_reply()
> callbacks will be called with the req_info->dev being NULL, which can
> cause discrepancies in the behaviour between GET and DUMP results.
>=20
> The main impact is that ethnl_req_get_phydev() will not find any
> phy_device, impacting :
>  - plca
>  - pse-pd
>  - stats
>=20
> Some other commands rely on req_info->dev, namely :
>  - coalesce in ->fill_reply to look for an irq_moder
>=20
> Although cable_test and tunnels also rely on req_info->dev being set,
> that's not a problem for these commands as :
>  - cable_test doesn't support DUMP
>  - tunnels rolls its own ->dumpit (and sets dev in the req_info).
>  - phy also has its own ->dumpit
>=20
> All other commands use reply_data->dev (probably the correct way of
> doing things) and aren't facing this issue.
>=20
> Simply set the dev in the req_info context when iterating to dump each
> dev.

Tested-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you, this fixes the PSE dump!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

