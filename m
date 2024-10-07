Return-Path: <netdev+bounces-132627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B989928A0
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2410F1F23F92
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE191DE3B7;
	Mon,  7 Oct 2024 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c4tBmR9o"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6631DE3B4;
	Mon,  7 Oct 2024 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294777; cv=none; b=nCZHhILgJhgIi3bsr7GEzE6vpqqqnpn8mB3bhmDPFVyn7W0H5/hucksX0/Z8fHVrnil/rxqEnFlu16635EBP310pzh1l+Gqe4gciqFuFAEQjKyUwvyeTi395zrRcKq6UNchYvitQpv0IaIiz12+MyteGgdJ2yu/5lXzOu1UNJ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294777; c=relaxed/simple;
	bh=Qtq0LINDyWYbvl+6wJZ5GVbNnHMRRoNj9HhtLALHPzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J97f47GpqfQbAWRz3zd+zsXW4XghavExD8F6C045IPoXDWk190vZSsv4VIPj2xcRuyelqF3SqjfjQ7f9nkadFoG80rvNZXhr4TIVQo21stVBGX/ufSCpLQrZvJf+kmSBJvBqHhKO9XqHuzCheYtugk5ZVFmD2jsapm2bo5iUbD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c4tBmR9o; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1662A40004;
	Mon,  7 Oct 2024 09:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728294773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbCo9Q+9TkGZ/xqMd8R2B0Tn+cbC6iUH3hkMXloVWXs=;
	b=c4tBmR9opSgnKs9fwmEb6B2T3L6empi9/Jow7h8jkpZYA/ovXf5l2eHT3vo+wp+h7CKaPf
	xxOE1fvk4Eb88yR2L3muaeAuEkBqyiNom/hMwGxYnteWadINjnCqJiujfHBNHyVAXjwOlR
	OPL122SBcxtLE6ubp5GOrb7jXe6xsftJvy+zghfBcfGV4yIxjLxmPebgoj+llYFOcnNtmT
	4MOUDezMKcxl9wKfMKo/Tbls3ltBQ4J22T9AIGTceljZ69JvFaVZp6gP8krNRpFVtTLFm5
	AQuwx9Ghoqr7BfpK9ShMdRqRH9E6A5JNmo4VQvfSJRZSuCOQkdawpR4yZa0zgQ==
Date: Mon, 7 Oct 2024 11:52:50 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Heiner
 Kallweit <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?=
 Maincent <kory.maincent@bootlin.com>
Subject: Re: [PATCH net-next v2 3/9] net: phy: Allow PHY drivers to report
 isolation support
Message-ID: <20241007115250.5c9e2f3e@device-21.home>
In-Reply-To: <ZwAb3DNWYl0ykRBl@pengutronix.de>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
	<20241004161601.2932901-4-maxime.chevallier@bootlin.com>
	<ZwAb3DNWYl0ykRBl@pengutronix.de>
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
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 4 Oct 2024 18:46:20 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Fri, Oct 04, 2024 at 06:15:53PM +0200, Maxime Chevallier wrote:
> > Some PHYs have malfunctionning isolation modes, where the MII lines
> > aren't correctly set in high-impedance, potentially interfering with the
> > MII bus in unexpected ways. Some other PHYs simply don't support it.  
> 
> Do we have in this case multiple isolation variants like high-impedance
> and "the other one"? :)  Do the "the other one" is still usable for some
> cases like Wake on LAN without shared xMII?

I don't think there are multiple variants, at least I didn't see any :/

Maxime

