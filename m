Return-Path: <netdev+bounces-203340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F45AF5834
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 15:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0931BC1ED6
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9BB275842;
	Wed,  2 Jul 2025 13:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JnbklXd5"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA324DD18
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461964; cv=none; b=C9XPTxh4ytNtBZE+pqWCpyOx1GCC0uUWZRgdvbBVljhPXFkHCjDrW2JX/60qJcte48q9uLBRQj6x0hAVati6dZW2iCaendZh/47xtKTiw1AC8S7E7zN05Ec9s8TK0YzLUgbe6mMWiJ3QJKyTrDxUO26mJy3OLX4rk0znxSHOpH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461964; c=relaxed/simple;
	bh=c6eIxpJ7az3L+OsYq9YR2Aa5anEZeVDSJbHdj4C/R3A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tDCbWD4HVY42ET9qQA9YnzojvdLkQw2xPXnVO+/A1YUMMzvbcoI8kw8flrFOQJOQd8FsFXSrK65m6Qw9mi2mWoohYjcKzVejpXAMsrRoDDn64ZwwDemLoS5j3baWBgPNatoYxwAdGCq7dYvEi8FZHIlp2t6HlNqBvYneWXpGPeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JnbklXd5; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3EAA643A19;
	Wed,  2 Jul 2025 13:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1751461955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PMBzDClA3r83eYd0VVI/IzgedDv07I5CYy7KEhkq5K4=;
	b=JnbklXd5H6Q/V9g68Au5Ia0E1odv9X5agZ/+Ymx+pCgMuO+4t4TP+VdfMe5+jaeeBvCshu
	dKhMssvgbdzKsetv3X2gtVzYc4Yb316D4WWRM1yuMnQDGKhyQ6HxIAj+Y5+dq/s42KzZ1J
	0vFE0vtw/+QYtZwmsFQIO54wwW/6xFiQFc34ipJvpdY8mY8F90PmJrTOHIRXPzxUeYf4Go
	bv/FC1L7Imv+D/7U38qS11d/loQulk2IUaEsZeEnre+Kw9kwvF/b7Y7atGnra+wn5MZ2pw
	VSTVFXibZ0lDheqU5nRwCC1MAfkJ1MrDf6BNEe85rbj7j8Cozbi9L6w3sc1iGA==
Date: Wed, 2 Jul 2025 15:12:33 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: phylink: clear SFP interfaces when
 not in use
Message-ID: <20250702151233.6c75e84d@fedora.home>
In-Reply-To: <E1uWu0z-005KXi-EM@rmk-PC.armlinux.org.uk>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
	<E1uWu0z-005KXi-EM@rmk-PC.armlinux.org.uk>
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

On Wed, 02 Jul 2025 10:44:29 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Clear the SFP interfaces bitmap when we're not using it - in other
> words, when a module is unplugged, or we're using a PHY on the
> module.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

