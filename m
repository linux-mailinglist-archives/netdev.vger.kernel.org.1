Return-Path: <netdev+bounces-169888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F9A46427
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DDA16BB49
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 15:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7E223321;
	Wed, 26 Feb 2025 15:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iKDOgaJ5"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719D41A01BF;
	Wed, 26 Feb 2025 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582590; cv=none; b=q2uYDed5rzxVnLK/NwhgUw/4LCx52fdbPUDutpMV7e4Q6tyOuhZfPWJXVPkCXPDXbpf6Tn9rVdvsil2dn5s8CSzIOJnusvthfr8TpcsyQ1mZeQLCaYhd7QdGbh8fZpc1xN/nafD5il9sRehQJKfoR23v/ngnRnx5eFsXyAsRIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582590; c=relaxed/simple;
	bh=AlPedn04wCTvnoDUgDbBua195xjkBTaAEu/DorTdYk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDsOFfH6WGEN99Mfe8voBdjaqwBx2G70VOxg7/BXrU/vUHLqxEyFs1JVujgsPRdU4AAGvUW2a+qKp29zM+niWbGOfiWckNP4CX+5nSUCOq8Z611Pd9lYZ/gSr51K8A0PgPuoqEF0j3RX8Hjr3rbdQoSzt1QpSjlsMK8xEf1FUW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iKDOgaJ5; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57D6044262;
	Wed, 26 Feb 2025 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740582581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qr8ZzAHwUGa1pa18g5lB7LpvO3T+N6fqzFerpRdWrhw=;
	b=iKDOgaJ5wJ04L921BEqnnpQzVMZYbO+FPuNCfmaOfFvJBXvFXqSRGdmxiiyzN5wYUKGpTe
	ksC8H3kElU61IV8Rgvtmtey+NZpSMOrM0I6A2CjP2BzPZZm/kzgTFcmqafGH1cndkgwIrA
	gjzMkWft0EEuLzTYcjzr1+AqPdSpKUMStQB+KKVbnI0SNgp95ofpXrtoFHLWe5pabEGZWT
	VZeOdtBO3EP0aXdvQ/kqXOAcpP5tLmJUdzvT8cIfUk3q4vayLkTlnZAHBR23IVzBGj9ob4
	ZZRu/JA1Fp5OnabcH56WOTsUII9MNzAB2DK/3izzPlsaNB2PD1/wmndXu56vFQ==
Date: Wed, 26 Feb 2025 16:09:38 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski
 <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Simon Horman <horms@kernel.org>, Romain Gantois
 <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v2 11/13] net: phy: phylink: Add a mapping
 between MAC_CAPS and LINK_CAPS
Message-ID: <20250226160938.101be22d@fedora.home>
In-Reply-To: <Z78fKCZl4-77NjeK@shell.armlinux.org.uk>
References: <20250226100929.1646454-1-maxime.chevallier@bootlin.com>
	<20250226100929.1646454-12-maxime.chevallier@bootlin.com>
	<Z78fKCZl4-77NjeK@shell.armlinux.org.uk>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekgeeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedugfelledvtdffvdekudeijeduueevvdevffehudehvdeuudetheekheeigfetheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgdphhgvlhhopehfvgguohhrrgdrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudelpdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepr
 ghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Wed, 26 Feb 2025 14:03:20 +0000
"Russell King (Oracle)" <linux@armlinux.org.uk> wrote:

> On Wed, Feb 26, 2025 at 11:09:26AM +0100, Maxime Chevallier wrote:
> > phylink allows MAC drivers to report the capabilities in terms of speed,
> > duplex and pause support. This is done through a dedicated set of enum
> > values in the form of the MAC_ capabilities. They are very close to what
> > the LINK_CAPA_xxx can express, with the difference that LINK_CAPA don't
> > have any information about Pause/Asym Pause support.
> > 
> > To prepare converting phylink to using the phy_caps, add the mapping
> > between MAC capabilities and phy_caps. While doing so, we move the
> > phylink_caps_params array up a bit to simplify future commits.  
> 
> I still want to know why we need to do this type of thing -

Sorry not to have included more details on the why. The main reason is
for the phy_port work. In the previous phy_port series [1] I included an
attempt at making a first step forward with PHY-driven SFP, so that
phylib itself provides the sfp_upstream_ops and not individual PHY
drivers. That's to get a better handling for multi-port PHYs, which is
one of the end-goals.

[1]: https://lore.kernel.org/netdev/20250213101606.1154014-1-maxime.chevallier@bootlin.com/

As part of that PHY-sfp work, I find it very useful for PHY drivers to
be able to tell what phy_interface_t they can expose on their serdes
interfaces, and from then build a list of linkmodes to get an idea of
what we can support on that port. That's why I'm extracting that out of
phylink.

I did see that you suggested having phylink involved for PHY sfp maybe,
but TBH I don't even know where to start, so I took a safer approach
with phylib-driven SFPs.

> unfortunately I don't have time to review all your patches at the
> moment. I haven't reviewed all your patches since you've started
> posting them. Sorry.

No worries, I understand that that whole work is quite the mouthful and
implies some involved reviews. But even discussing higher level stuff,
like we do now, helps me steer that work in the right direction and
hopefully make it easier for you and the other PHY maintainers to
review that in the future.

Maxime

