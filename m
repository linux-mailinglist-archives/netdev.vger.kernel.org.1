Return-Path: <netdev+bounces-168811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACB0A40E12
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 11:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7619A1899B85
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD6B1FCFC6;
	Sun, 23 Feb 2025 10:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PJu2gik0"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2D61EB36;
	Sun, 23 Feb 2025 10:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306765; cv=none; b=O34EGB0NF5CsGfVwgByvmF9OOLBL6WGiObtS/Y9UnZ2VP73XdlPaE0ZBnWCF0ohCyDLAi9VUR8doBE2xn3HnqD22vOJg0hId8zk4vfibbjAji6vt9wvkw0LEm0VxhPqY2Ol8AWXfIfTo7zEJPP9TnomM98Xu7HUqvgMysBjwffY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306765; c=relaxed/simple;
	bh=UeSf7qZC3uC+4elUHoxZwfMIm5R2qsKyGGBBhDQVbTw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jbdOCgMBUIeaBp6ImMjBPYThf1hSkDHjpb7hRUw2Gth+Q5vO+Ef4BULiJMT+bvHiOonUS8x0BE4VZcIPHmwsMmYEQ93jE+Ib4gGtCqXTK4YspOWGIYOlwG4rZnaXuL2SGwDVBd20/e7bBRJxkkgYSFaF17V8UG+dyzA7VNltCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PJu2gik0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C30043317;
	Sun, 23 Feb 2025 10:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740306755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3q8V+cm8pIkEgY8WNYRuv1HhLOCUVuFOZ7NL4x+JRvA=;
	b=PJu2gik02LsnUsoTvziJ0WU+C7YYrfTfpv4qiGLeG4lV/hz3f1REW+aKTVJKdNgZ4qyaqa
	FPYvCWviN3Vq0QEyp3Wk5OwGyDrNaZXKBdtYdj73/VWi0RWk6jeSIi0Y9OuplS+G4BwmaY
	kgL/7pzrLp+gEuaBi0/mLCS428JAQaYXnT3wVlAV8J0K6BNEmQsIec6uZKwHBq2ClJUStX
	LlcYSIZF96a7YLBswGAg5PJRgAi4kILQ7GR+g5y+/t43ECpdnEmRFJbBO18zhf8q22f8Fb
	sl3vWCF2CaG2+O3jiINfvWnLgNADVXy8EZx9Had0oUgdKREYQcxMyCC26oYavQ==
Date: Sun, 23 Feb 2025 11:32:32 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Cc: hfdevel@gmx.net, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/7] net: phy: aquantia: add essential
 functions to aqr105 driver
Message-ID: <20250223113232.3092a990@fedora.home>
In-Reply-To: <20250222-tn9510-v3a-v5-4-99365047e309@gmx.net>
References: <20250222-tn9510-v3a-v5-0-99365047e309@gmx.net>
	<20250222-tn9510-v3a-v5-4-99365047e309@gmx.net>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejheehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedufedprhgtphhtthhopeguvghvnhhulhhlodhhfhguvghvvghlrdhgmhigrdhnvghtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhfhguvghvvghlsehgmhigrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnn
 hdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi,

On Sat, 22 Feb 2025 10:49:31 +0100
Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
wrote:

> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> This patch makes functions that were provided for aqr107 applicable to
> aqr105, or replaces generic functions with specific ones. Since the aqr105
> was introduced before NBASE-T was defined (or 802.3bz), there are a number
> of vendor specific registers involved in the definition of the
> advertisement, in auto-negotiation and in the setting of the speed. The
> functions have been written following the downstream driver for TN4010
> cards with aqr105 PHY, and use code from aqr107 functions wherever it
> seemed to make sense.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> ---
>  drivers/net/phy/aquantia/aquantia_main.c | 242 ++++++++++++++++++++++++++++++-
>  1 file changed, 240 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 86b0e63de5d88fa1050919a8826bdbec4bbcf8ba..38c6cf7814da1fb9a4e715f242249eee15a3cc85 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -33,6 +33,9 @@
>  #define PHY_ID_AQR115C	0x31c31c33
>  #define PHY_ID_AQR813	0x31c31cb2
>  
> +#define MDIO_AN_10GBT_CTRL_ADV_LTIM		BIT(0)

This is a standard C45 definition, from :
45.2.7.10.15 10GBASE-T LD loop timing ability (7.32.0)

So if you need this advertising capability, you should add that in the
generic definitions for C45 registers in include/uapi/linux/mdio.h

That being said, as it looks this is the first driver using this
feature, do you actually need to advertise Loop Timing ability here ?
I guess it comes from the vendor driver ?

Thanks,

Maxime

