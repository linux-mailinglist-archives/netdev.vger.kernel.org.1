Return-Path: <netdev+bounces-171332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E5AA4C8E0
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F002317877A
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9873725334E;
	Mon,  3 Mar 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IuZIzNgI"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8672C22B59B;
	Mon,  3 Mar 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741020530; cv=none; b=MvFuPqN/oTXx3xPbtsjO+pT+mfHUQPQ1i8b79yqWgRe5wsAxdThGgZxQAZ3kmATyglXdZp5aqNPsLCUcuw2XK48B1IXO1F6uNsuKJNpMHfqY+jg8+ncucko5b1sofMFGhC4EgRlr1wHEOVsaV8vbNH8kLdNF0onkexdMPeLhlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741020530; c=relaxed/simple;
	bh=Yiu6Kbk6MX3ydfBVSov1djVqoS6eXTGJ/p/f3mr8Ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLWXTkTXNfvxJnxKFUZec+FapZs/K3iE7BVVja3KXjHKujWibML85VbeGj0R8R2KZRjsWbSnRif4VoRl6IQWW1BnsgtdS9ZhSe24JgjHqYQLSX2J67jlk5D4AX8Hx0siXs7obqUL+iHGCvS6KY1K/9HQx8gKUl/0Qf5b8oS4QHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IuZIzNgI; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 057814441A;
	Mon,  3 Mar 2025 16:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741020519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yiu6Kbk6MX3ydfBVSov1djVqoS6eXTGJ/p/f3mr8Ft8=;
	b=IuZIzNgIzkMgEPUZgOk63NYcqE6Zdpaxvdh1icXdM7BLSyNXBKmWE1wAipFaqEuac9gAkj
	g0oERgk+uOtooqQo5nLgX5Ei1o5AjnKIKmqGMG4LZpupZXkPLK78VhIGYWMmVP0ZA+oJdl
	hpm08La3Iq25znFTbjEOrtZJSzuPHXWfTRvkYoC2vBZJaShHPqpHiQBHxPMgaqYBm+TH5B
	LA5lCn8CBv30PpLAFS+SYIclWdJp8O6Ew4kzd2DTX4efSQlaVFoNtScyd7Mc9Bai1OTKHj
	ihty2z7BYzx8Ys4Cp2LtqFO1Fw0Ysa94H98opSbZMiL15V9jPswtRzoYVj+Yuw==
Date: Mon, 3 Mar 2025 17:48:37 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Dimitri Fedrau via B4 Relay
 <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dimitri Fedrau <dima.fedrau@gmail.com>, Marek Vasut <marex@denx.de>,
 Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH 0/2] net: phy: tja11xx: add support for TJA1102S
Message-ID: <20250303174837.4c97131f@kmaincent-XPS-13-7390>
In-Reply-To: <20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com>
References: <20250303-tja1102s-support-v1-0-180e945396e0@liebherr.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelleeigecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefguddtfeevtddugeevgfevtdfgvdfhtdeuleetffefffffhffgteekvdefudeiieenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduhedprhgtphhtthhopeguvghvnhhulhhlodguihhmihhtrhhirdhfvggurhgruhdrlhhivggshhgvrhhrrdgtohhmsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeguihhmihhtrhhirdhfvggurhgruheslhhivggshhgvrhhrrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhto
 hephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: kory.maincent@bootlin.com

On Mon, 03 Mar 2025 16:14:35 +0100
Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
wrote:

> - add support for TJA1102S
> - enable PHY in sleep mode for TJA1102S
>=20
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>

Please add net-next prefix. With b4:=20
b4 prep --set-prefixes "net-next"

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

