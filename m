Return-Path: <netdev+bounces-183630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F9FA9156C
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 09:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA441904EFF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 07:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5696E21ABCA;
	Thu, 17 Apr 2025 07:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JgMatfmv"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE25219A8C;
	Thu, 17 Apr 2025 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744875521; cv=none; b=jmdDztoOy3lH7EPb8XmFWOVQETm0SC6GEdSSsCN1nSBrteVBS6YreKIYQe8DNQLugK1KAIZVK+wrS6daXngOo9BbVqih70/uSHf4XzgHTMwuHKHcOWhmNq3SUYvcz5E9iBaRQ5p4UwjpSLYsg1LOAKHgmlW6l+nuT2demgX5AZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744875521; c=relaxed/simple;
	bh=EJoTJ5iX+M3cy1cKrEbfUcGMxWLht9r3wKQYcXdE6U8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gxKT7VvpgvkD7xpDphnmPTXuL1/DrDpTmii9J1VjzmHm3Wcy15AugOcU0/5BE9t0A/ENs5Xm3FGJB6DTM/UtK7yIjciQhnLNRSLUDTbbm7PZ9H0WE6GyyU3z23ijsUell+gFzBgtoBeAcCMsUMbDVT2KiIBwaYvRnrL9legt3oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JgMatfmv; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2FB9A43A54;
	Thu, 17 Apr 2025 07:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744875516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rJGVKPE3wmhJoFU6+S7XBj9IMoZY+TYW8WtG+e6fhFA=;
	b=JgMatfmv3YDmQc8F1fIpJgHGgZYPCBdpv/izit9gTwKVVmca77MokyDQC6Tlsaz75SuFGI
	+Shn94z5jdsbt3pBxN/ED+9cBcXDfHv6imd2ZB2VounWucwG4K98VqJjG9faTBBCz7gtSH
	kwS86gqk2CCLjlmDZwXs9HKB28Fi9Semug/j83Lk1LdCKyiBcOoJFMAm+iLht5RVhN887Y
	3bIjOVQywto07M2buUoaT9FC23HkNQq4PIRTCSC0gbpSnDvvhN9rZ037zgA5OJZ645OW8n
	pKpCinFAvT5LB8z6krp5mcmc5tBJOpaTqfGgDMiP13ekjEMxL6M4NJcqyLNk+w==
Date: Thu, 17 Apr 2025 09:38:34 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Qingfang Deng <dqfext@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>, Nathan Sullivan <nathan.sullivan@ni.com>,
 Josh Cartwright <josh.cartwright@ni.com>, Zach Brown <zach.brown@ni.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Chuanhong Guo
 <gch981213@gmail.com>, Qingfang Deng <qingfang.deng@siflower.com.cn>, Hao
 Guan <hao.guan@siflower.com.cn>
Subject: Re: [PATCH net] net: phy: leds: fix memory leak
Message-ID: <20250417093834.4e1d29b6@fedora.home>
In-Reply-To: <20250417032557.2929427-1-dqfext@gmail.com>
References: <20250417032557.2929427-1-dqfext@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdekieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeevledtvdevueehhfevhfelhfekveeftdfgiedufeffieeltddtgfefuefhueeknecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjedphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepughqfhgvgihtsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepl
 hhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Thu, 17 Apr 2025 11:25:56 +0800
Qingfang Deng <dqfext@gmail.com> wrote:

> From: Qingfang Deng <qingfang.deng@siflower.com.cn>
> 
> A network restart test on a router led to an out-of-memory condition,
> which was traced to a memory leak in the PHY LED trigger code.
> 
> The root cause is misuse of the devm API. The registration function
> (phy_led_triggers_register) is called from phy_attach_direct, not
> phy_probe, and the unregister function (phy_led_triggers_unregister)
> is called from phy_detach, not phy_remove. This means the register and
> unregister functions can be called multiple times for the same PHY
> device, but devm-allocated memory is not freed until the driver is
> unbound.

Are there historical reasons for the triggers not to be registered at
probe time ? I agree with your analysis otherwise.

Maxime

