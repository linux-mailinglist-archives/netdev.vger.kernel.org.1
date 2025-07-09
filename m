Return-Path: <netdev+bounces-205475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2EBAFEE2F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25D35A8099
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09722E92DC;
	Wed,  9 Jul 2025 15:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="myFOEgTC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA96928FA87
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 15:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076499; cv=none; b=KTqnDKKDoXVVWeHaxE6avtL87FZ9lF2CYNOIN1QlEMHjXFxvNSrRcOuYeYzwfuyH/13WMXxoHd6SEq9+TQx8zgQOo3ktZN+ub8Vga7U57cjLq+TI3ggpDDz8wt00FSTXh+mlXaPMcQ79nbPABMIyZcbzvoOkCBXxPoN8McUtkFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076499; c=relaxed/simple;
	bh=EGikTbvBF2syQch5jgb4dmltcuiumTrNJspLguBUfb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQ5TGtw7d/UHWKMA7wzYMU6iSwQZK2giDtpDmfKyQAK832w0DHAUbCDsNLPvaGwk98JOtIz/9v2LM8jMjO04rpJ0JQ1Y6EkekEhLlj4OP8nWoYQ/cGUGH3D1NBjxh6K2h69qrh7Yxg3XNliOkCJ1OiQjwZIdwjyzYXnwJCgRwa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=myFOEgTC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KbSirPMmB5eX3BcZjMHK6bPrETltrETej1IAsJuVw/4=; b=myFOEgTC5mS/hkCbOaQvkieYK1
	Lr+6vlXUXax0KUOBZ2gDNReWFOPpBU1a1/ydRtWuqYgz+Vu0R5srzrIAqs3iVaoIfgJotPv8ez19M
	Uav6QaK1QGUL1bFRpIlWaL/kIwgDGGcBxlpcwrZ4uqHxh7V26SAe5F6vtBl3Andg6dA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uZX88-000xV4-WB; Wed, 09 Jul 2025 17:54:45 +0200
Date: Wed, 9 Jul 2025 17:54:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 3/3] net: phylink: add
 phylink_sfp_select_interface_speed()
Message-ID: <14b442ad-c0ab-4276-8491-c692f0b7c5c9@lunn.ch>
References: <aGT_hoBELDysGbrp@shell.armlinux.org.uk>
 <E1uWu14-005KXo-IO@rmk-PC.armlinux.org.uk>
 <20250702151426.0d25a4ac@fedora.home>
 <aGU2C3ipj8UmKHq_@shell.armlinux.org.uk>
 <CAKgT0UcWGH14B0zZnpHeJKw+5VU96LHFR1vR4CXVjqM10iBJSg@mail.gmail.com>
 <aGWF5Wee3vfoFtMj@shell.armlinux.org.uk>
 <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdVW6_hewR7zNzMd_h7b_Lm_SHdt72yVhc7cLHcfFxuYQ@mail.gmail.com>

> Settings for enp1s0:
>         Supported ports: [  ]
>         Supported link modes:   50000baseCR/Full
>                                 100000baseCR2/Full
>         Supported pause frame use: Symmetric Receive-only
>         Supports auto-negotiation: No
>         Supported FEC modes: RS
>         Advertised link modes:  100000baseCR2/Full
>         Advertised pause frame use: Symmetric Receive-only
>         Advertised auto-negotiation: No
>         Advertised FEC modes: RS
>         Link partner advertised link modes:  100000baseCR2/Full
>         Link partner advertised pause frame use: No
>         Link partner advertised auto-negotiation: No
>         Link partner advertised FEC modes: RS

This all looks suspicious. If it does not support autoneg, how can it
know what the link partner is advertising?

If you look at what phylib does, for plain old 1G devices:

genphy_read_status() calls genphy_read_lpa()

genphy_read_lpa() then looks to see if autoneg is enabled, and if not
it does linkmode_zero(phydev->lp_advertising).

So it will not report any link partner information.

What is wrong, that it is reporting LP information, or that it is
reporting it does not support autoneg when in fact it is actually
doing autoneg?

	Andrew

