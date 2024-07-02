Return-Path: <netdev+bounces-108522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ADE924182
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5564C1F213F3
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C361BA071;
	Tue,  2 Jul 2024 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RQzDQwfc"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2770B26AE4;
	Tue,  2 Jul 2024 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932194; cv=none; b=vENcww2RMEMsHv3YRkaSxs0gcOYPxWnXW8zNlsFDAdHe7b1RwfCWLZwr+G8b6Nv3wjCX0Hb6t6Ot3Eb7K5compOT0cEq3XWhgeMUPFMkd35x1zC3SmkZh/dU0t+a9QLPem/ab4ApYgucxUb0X9i794knz05ShqA7NU9Ka3LJmZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932194; c=relaxed/simple;
	bh=r/X3Fgqbe0g3YlCS5QP2bZqhFsTxvqwwDlO1LN2XmUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pM+Z1+bKcPSCNdXbbdCNUg4FVnhzX3quYzOkbaBwtKH2d1lJ6JHCUQ97kEJ1sFhq2La7n88bzoC4VpFWXuG75qNFwRNHbfuqQa/sXGpHXDImAWuoyETgweyQUi+39wZEPBHoT8jd0N4q054Gh6+ab9tQ0R67SqytDfQHx7lMtck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RQzDQwfc; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39A3EE0008;
	Tue,  2 Jul 2024 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719932190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2gIS2qvw7Igcf1LZ8tL2Djwdqh6L38YKw8PsS7JKw8=;
	b=RQzDQwfc9uc9Wcz++M/+rpFd4SJHt/kTip010eUncOXPRzX5eWXSlJSJ9TuQIic8IaLFNY
	NutcR7nMJMSukdPsIu0eaidmkvTKZvqsxwQBRtG0RlryaJ6EGlZbY6tZZN5Pa+LFPMV+N6
	cS5tGunRQhyTVa+hFpQGvvIFN+9+fxp1d+qOzHK4t+GQpvNxpaqJVPF5yfRnWjBCTs/VaW
	vU1D81RGZKFPvvHjZNhpmZaxJsUA/DFZ7jdJu5I0pM8AeVW0S6bW0Nx1PvECrydpOTm3JH
	zdTJGjlTi43mxnrGkzjvqa3PKZJhJ+viQl3Zkt5ql7WwG51nzkUk5X6H+1pw3Q==
Date: Tue, 2 Jul 2024 16:56:28 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net: phy: dp83869: Support SGMII SFP
 modules
Message-ID: <20240702165628.273d7f11@fedora-5.home>
In-Reply-To: <b3ff54a1-5242-46d7-8d9d-d469c06a7f7b@lunn.ch>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
	<20240701-b4-dp83869-sfp-v1-5-a71d6d0ad5f8@bootlin.com>
	<f9ed0d60-4883-4ca7-b692-3eedf65ca4dd@lunn.ch>
	<2273795.iZASKD2KPV@fw-rgant>
	<b3ff54a1-5242-46d7-8d9d-d469c06a7f7b@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Andrew,

On Tue, 2 Jul 2024 15:21:09 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Tue, Jul 02, 2024 at 10:11:07AM +0200, Romain Gantois wrote:
> > Hello Andrew, thanks for the review!
> > 
> > I think this particular patch warrants that I explain myself a bit more.
> > 
> > Some SGMII SFP modules will work fine once they're inserted and the appropriate 
> > probe() function has been called by the SFP PHY driver. However, this is not 
> > necessarily the case, as some SFP PHYs require further configuration before the 
> > link can be brought up (e.g. calling phy_init_hw() on them which will 
> > eventually call things like config_init()).
> > 
> > This configuration usually doesn't happen before the PHY device is attached to 
> > a network device. In this case, the DP83869 PHY is placed between the MAC and 
> > the SFP PHY. Thus, the DP83869 is attached to a network device while the SFP 
> > PHY is not. This means that the DP83869 driver basically takes on the role of 
> > the MAC driver in some aspects.
> > 
> > In this patch, I used the connect_phy() callback as a way to get a handle to 
> > the downstream SFP PHY. This callback is only implemented by phylink so far.
> > 
> > I used the module_start() callback to initialize the SFP PHY hardware and 
> > start it's state machine.  
> 
> The SFP PHY is however a PHY which phylib is managing. And you have
> phylink on top of that, which knows about both PHYs. Architecturally,
> i really think phylink should be dealing with all this
> configuration.
> 
> The MAC driver has told phylink its pause capabilities.
> phylink_bringup_phy() will tell phylib these capabilities by calling
> phy_support_asym_pause(). Why does this not work for the SFP PHY?
> 
> phylink knows when the SFP PHY is plugged in, and knows if the link is
> admin up. It should be starting the state machine, not the PHY.

When the SFP upstream is a PHY, phylink isn't involved in managing the
SFP PHY, only the sfp-bus.c code will, using the SFP upstream ops, for
which phylink is one possible provider. When phylink is the SFP
upstream, it does all the mod_phy handling, so other upstream_ops
providers should also do the same.

But I do agree with you in that this logic should not belong to any
specific PHY driver, and be made generic. phylink is one place to
implement that indeed, but so far phylink can't manage both PHYs on the
link (if I'm not mistaken). I don't know how this all fits in phylink
itself, or if this should rather be some phylib / sfp-bus helpers and
extra plumbing to ease writing phy drivers that do SFP and want to
better manage the module PHY.

If I'm not mistaken, Romain's setup uses a MAC that doesn't even use
phylink yet (but the porting guide was updated recently fortunately ;) )

> 
> Do you have access to a macchiatobin? I suggest you play with one, see
> how the marvell PHY driver works when you plug in a copper SFP module.

On my side I have access to one, but it's hard to tell as the 3310 only
really supports 10G copper SFPs so far and I only have one. However from
testing on other boards, it looks like when a PHY is acting as
upstream, copper SFP will work when their default behaviour is to start
autoneg, link establishment and so on automatically when inserted.

The behaviour is currently not consistent between systems that have
phylink as the SFP upstream (no media converter) and systems that have
a media converter.

I think Romain has tested the platform he's using for this series with
multiple copper SFPs, some will work fine, and some just don't. Same
copper SFP work just fine when used on systems that have a straight
MAC <-> SFP link managed by phylink.

Maxime

