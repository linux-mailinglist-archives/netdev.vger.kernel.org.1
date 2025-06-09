Return-Path: <netdev+bounces-195652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D138AD19E4
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 10:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8B2188C6CC
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 08:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274B9246333;
	Mon,  9 Jun 2025 08:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E1KIr4JU"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B013B58B;
	Mon,  9 Jun 2025 08:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749458196; cv=none; b=fyckP0xloqfiwSrV+sdBfS1e06tw201QUa8xWyNgLWx3z/GZsfGIx/WyHZvFcRxbpPjr7Yz28BgeLaP/UGDmeLCkGkjw2/Zsso/7z9ciUbXCfkA1WFkTJcBrvB7bkrereFOvD9wO0T8pGih4ZXAOzfDJR0f5oVcPVtQ/m2kEEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749458196; c=relaxed/simple;
	bh=L3nfufsxXxkliDYjJl9skzl9dEnwS4z0pKQv+TvCxeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHayUA/dD2dwThB1uRAOjIjDQuDPo8iYjCtXdS6vvXw53rH50s1BrOtuDT+UpwZn3fEITu/HNQyNPcU3T9ZyoBTn4CKAoVmlAD2aReXFJI/UtRltrGbVLSFAofq0Z9VjaPzoXOGy4hd5xxiP0WGYWj9cjbPSwVYop50XaEgehPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E1KIr4JU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 470C14316C;
	Mon,  9 Jun 2025 08:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749458185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3nfufsxXxkliDYjJl9skzl9dEnwS4z0pKQv+TvCxeU=;
	b=E1KIr4JUbM5L2fJGk+ItoUEbP+1wikt2qhg+/RB4BO4VAB+j7qbb1i1YucsyZQwrqHSeEf
	fp8Kabc1y3l6Y8deXtJSrcEOBIi2hhvz2hjY8DB8WJvLB7SS3p3VFmA4jAzaMrKtx4vqp4
	A3tgqEyhcqmWDK8IfsVHqkWTy6nGzJUHQElRBovPJzACIafOQ5HTRl0ys+FhK4HCTyvye1
	7aSqt/rejepgQlZ7kfs7g5Xp2H4kQCh1M0OBXkcGFaBnz5gpeFDpuLY4iAaC3GHusqwJN1
	CXLJloukR1EpSIBT1YUU7vwlmdzNBXOyBFMtoVTwb1pV10Fl9Wqk19064tBuQQ==
Date: Mon, 9 Jun 2025 10:36:22 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Gal Pressman <gal@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Oleksij
 Rempel <o.rempel@pengutronix.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>,
 Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon
 Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, Dent
 Project <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v12 00/13] Add support for PSE budget
 evaluation strategy
Message-ID: <20250609103622.7e7e471d@kmaincent-XPS-13-7390>
In-Reply-To: <71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
References: <20250524-feature_poe_port_prio-v12-0-d65fd61df7a7@bootlin.com>
	<8b3cdc35-8bcc-41f6-84ec-aee50638b929@redhat.com>
	<71dc12de-410d-4c69-84c5-26c1a5b3fa6e@nvidia.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeltdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdelpdhrtghpthhtohepghgrlhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehordhrvghmphgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvmhesuggrvhgvm
 hhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvth
X-GND-Sasl: kory.maincent@bootlin.com

Le Sun, 8 Jun 2025 09:17:59 +0300,
Gal Pressman <gal@nvidia.com> a =C3=A9crit :

> On 28/05/2025 10:31, Paolo Abeni wrote:
> > I'm sorry, even if this has been posted (just) before the merge window,
> > I think an uAPI extension this late is a bit too dangerous, please
> > repost when net-next will reopen after the merge window. =20
>=20
> Are all new uapi changes expected to come with a test that exercises the
> functionality?

I don't think so and I don't think it is doable for now on PSE. There is no=
thing
that could get the PSE control of a dummy PSE controller driver. We need ei=
ther
the support for a dummy PHY driver similarly to netdevsim or the support fo=
r the
MDI ports.
By luck Maxime Chevallier is currently working on both of these tasks and h=
ad
already sent several times the patch series for the MDI port support.

--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

