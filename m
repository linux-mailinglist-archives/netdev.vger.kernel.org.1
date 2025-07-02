Return-Path: <netdev+bounces-203339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C242AF582E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBD5174E5A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E42749DC;
	Wed,  2 Jul 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pamtEIBP"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A078A24DD18
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461929; cv=none; b=FgCR1lW448G4uM9AITD9xdO9luj1ffJseGkp+dhAPbehQdWDxnWfHj0uNU2klSk8op8yADt57zP6PUtbflwGzsfO0aa/LPlyGvsPXcF4eOJqbe9B2JoLaiA5IPpnJl2Ek+ktpMVmS2g4R0m+Asm0KGAjfNT2IEt4Qvomwk7lPeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461929; c=relaxed/simple;
	bh=ZScY/86v9KyFXwifYPN75p64yv0pDY8lPQNFywkOAtE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=esuNQOgp6VOMg/TbI+ZiYDnpKG88y5eqq51B+llBonwG7RdDGXaIche/do6kZxjrcWLKxRHF13CVEJP3TCIebor9+O0DH66J1k3dT48XZsxCiifJaFgdTYLS4e0EroZTjRa5Zv0Kghs906iwq8Txc3HRQKbbdGZFuXD/K5uTh/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pamtEIBP; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D1A24383D;
	Wed,  2 Jul 2025 13:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751461920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AyhjB0RIepAPlBS+0exfN71rZWuzPQ7rKbNUsw2Z7bE=;
	b=pamtEIBPLX7Pk66rCWf/5XNwZh63l2bRz+TCu/5yoBqI7zmEFvpbyOxGBwb19DTkZQxbQe
	7HZ/VdOlm7axrjiH/nQZ+b0Oo5cVB4kNnsTarCxcCOfsj3eQYk02cEwPkYcQaDuWuGu2Mq
	HNm0iHTuZ5AvdWedf3AQrGfoZg+2h8zPK0zXICK03qIfBFG47d3uC+sjuLni5ye6WXmgJq
	hevOGzmOBVowsFpcoErEnLzRHzfROlf7LXTbAyQNQi5w3klr6CeOUlYftbszdwIEMIGSms
	8Uj3lLSKEVhATCOzuLvwXZaIx3eTkrsEXeTg2GPNls7LsUbn8RrcnNFb9g19/w==
Date: Wed, 2 Jul 2025 15:11:57 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: phylink: restrict SFP interfaces to
 those that are supported
Message-ID: <20250702151157.5e5178b9@fedora.home>
In-Reply-To: <E1uWu0u-005KXc-A4@rmk-PC.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
	<E1uWu0u-005KXc-A4@rmk-PC.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemieehieekmedvlegsudemlegvfhehmegvkegtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeeiheeikeemvdelsgdumeelvghfheemvgektgejpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeelpdhrtghpthhtoheprhhmkhdokhgvrhhnvghlsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmp
 dhrtghpthhtoheprghlvgigrghnuggvrhdrughuhigtkhesghhmrghilhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

On Wed, 02 Jul 2025 10:44:24 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> When configuring an optical SFP interface, restrict the bitmap of SFP
> interfaces (pl->sfp_interfaces) to those that are supported by the
> host, rather than calculating this in a local variable.
> 
> This will allow us to avoid recomputing this in the
> phylink_ethtool_ksettings_set() path.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks Russell,

Maxime

