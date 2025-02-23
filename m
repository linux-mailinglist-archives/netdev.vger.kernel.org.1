Return-Path: <netdev+bounces-168824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCB2A40F21
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 14:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C577AA109
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 13:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E6520766A;
	Sun, 23 Feb 2025 13:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oBlq8azH"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A268205E31;
	Sun, 23 Feb 2025 13:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740318056; cv=none; b=tpHOAIbuau7V45JTNMW9d047HQn068giE64GpmymOoFqExy8vGOHn3NpdOgFnAHUVw0E7YQwNd/nf/CXnz5GUELCl29jGqxUQZxasjv7G/OKwMxyts246QtAtPJhaVFYVWRYxmYgZCa9mnpqvjzG+k6v16w/NWUNAP7zdurVtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740318056; c=relaxed/simple;
	bh=hcf7+7C3MEhs4rmBsctVJxr+hv1xZgTKJoSQHXSsCz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WV0D8lQZ7Hd4npYIfgk3UhS/GCVH9g+RnbdxNracDuJoaJSTfVA+AS2uICpGQCDNd0CdZITV/wPpOG5TzX3SqeMTlk/x4J8btn8gDPH7fVta7MZuHaYPQflQoBvnfW2lQgZrashtTxBM6cy465yIIxv4mqPmCfVvxvN3hh0bpvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oBlq8azH; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D908844388;
	Sun, 23 Feb 2025 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740318045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K6bIJuULWhsZxJCwa0hMVmk2iWw7cX6L/3fW6XmaZJY=;
	b=oBlq8azH+BF3Jjf44h2fXFP4YWqwNaegZtOSOGTfSqIOT1AFfSfYqFmyz5BobJH+FtwYxX
	7rUdaZtPc/VvY69ZzMXGzrvYXIwY2/SSLKHiIIchfSsW1sRCgkLv2NAQuQ8bMTw2Y+g/0r
	WoTcPJ5UU2/7+qzv/EsMrNX0aohLiMbKuVMkn16JUdTb5jQwX3VQL6ZTv1dl9vl3DsdfAu
	gcIZy5TWsnQU1dUPVNKhJiwHoutc5YyMTCH3KwfwUFaSUF0tVh7/lr4Rt035QzlGD5jdgQ
	ioXiVTa6R6kIl+KSX1yjoJJYSPXoBm3rhqwgPtbU3jB1X0wM22iqVIuDVHTkUg==
Date: Sun, 23 Feb 2025 14:40:41 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: kernel test robot <lkp@intel.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next 08/13] net: phy: phy_caps: Introduce
 link_caps_valid
Message-ID: <20250223144041.1bf253ca@fedora.home>
In-Reply-To: <202502231409.QTfXTqrD-lkp@intel.com>
References: <20250222142727.894124-9-maxime.chevallier@bootlin.com>
	<202502231409.QTfXTqrD-lkp@intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejheeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegveeltddvveeuhefhvefhlefhkeevfedtgfeiudefffeiledttdfgfeeuhfeukeenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

On Sun, 23 Feb 2025 14:38:46 +0800
kernel test robot <lkp@intel.com> wrote:

> >> drivers/net/phy/phy_caps.c:152: warning: Function parameter or struct member 'speed' not described in 'phy_caps_valid'
> >> drivers/net/phy/phy_caps.c:152: warning: Function parameter or struct member 'duplex' not described in 'phy_caps_valid'
> >> drivers/net/phy/phy_caps.c:152: warning: Function parameter or struct member 'linkmodes' not described in 'phy_caps_valid'  
> 

Ah indeed, I'm missing the kdoc description here.

Meh and the commit title should be :

	net: phy: phy_caps: Introduce phy_caps_valid

I'll wait a bit for reviews and fix that in the next round.

Thanks mister robot,

Maxime


