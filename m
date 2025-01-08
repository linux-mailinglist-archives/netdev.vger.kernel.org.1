Return-Path: <netdev+bounces-156171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EEDA05478
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 08:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13B03A5C1D
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0D01AC444;
	Wed,  8 Jan 2025 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g59C+m/5"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6A1ACEB5;
	Wed,  8 Jan 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321121; cv=none; b=dEDReEsokppXglQ5yx3PT+YyrTN1wDB/aHcSNi5H1kvPxwOXf0mhQlHLKDg1fJPnpZ8GLNX5pfRlvoZF1jmnAm9RBPmPmCY8ttXEZLwp6mZ9C0zE1NS/VjZDfWMIFsBnVoY5NgCijrbMOHdC9BUhPHDfDliFaAZOOAz3jeqEeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321121; c=relaxed/simple;
	bh=JB8TIkGyNdvj/uaFSxiJLRqx7/0OoacLcMvx6tUfyfw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L6PSL4m0AGpnG8xivHmwRUpI4zC96r+PTOp0A1NvN+Gk725AbJQYqVICqgouUzv8pj1EoQeLsCQuj747IuKC2kTaC93lRneYoxQdd1FeltzFARJKQOIHsgHj9M81nJg/vat7M15nuFi4PNeYY/TvSuEpc0RSeVjsa3+CR1/guQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g59C+m/5; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 344E71C0008;
	Wed,  8 Jan 2025 07:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736321110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bR6G+K9Dutyc+IwAr+/OpGU5fx+TprPG1rZR3NvO4/8=;
	b=g59C+m/5OZoTSO6OJG3AkWUmnTY2aQONEWYLtTjP42JjbAM4v0ccqMpfvsDTcIX9sYhUfr
	mVtVuXIgBTv9l0vlVAmaDI8OvAEFy4CNsELSMPEj2/4YBu0OLzOr8iNdRynfTZvTDioV9+
	ct6MHCGW50DdU7vij3buGA5j2Q9gKlK7LgQto/xSrPiPCQESnnA9sRqPmcFmrZyubbTlI0
	Iwb7+CycqSbB/uE4Qd3reacU8tTnmF4NlEqLM9nDNtzdk1RloyzrdApGQRxvJ/aaqDzvo4
	SZXVThSzadr3dzxk8dX3lXyQt5O4gIl3/hMgJWvBDlXkUOK+e4qHAXQg6WLL8Q==
Date: Wed, 8 Jan 2025 08:25:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>, Kory Maincent <kory.maincent@bootlin.com>,
 davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, Simon Horman <horms@kernel.org>,
 mwojtas@chromium.org, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next RFC 0/5] net: phy: Introduce a port
 representation
Message-ID: <20250108082507.0402f158@fedora.home>
In-Reply-To: <Z31ZOjLcE34CNj0S@pengutronix.de>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
	<Z2g3b_t3KwMFozR8@pengutronix.de>
	<Z2hgbdeTXjqWKa14@pengutronix.de>
	<Z3Zu5ZofHqy4vGoG@shell.armlinux.org.uk>
	<Z3bG-B0E2l47znkE@pengutronix.de>
	<20250107142605.6c605eaf@kmaincent-XPS-13-7390>
	<Z31EVPD-3CGGXxnq@shell.armlinux.org.uk>
	<20250107171507.06908d71@fedora.home>
	<601067b3-2f8a-4080-9141-84a069db276e@lunn.ch>
	<Z31ZOjLcE34CNj0S@pengutronix.de>
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

On Tue, 7 Jan 2025 17:41:30 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> On Tue, Jan 07, 2025 at 05:22:51PM +0100, Andrew Lunn wrote:
> > >   I have however seen devices that have a 1G PHY connected to a RJ45
> > > port with 2 lanes only, thus limiting the max achievable speed to 100M.
> > > Here, we would explicietly describe the port has having 2 lanes.   
> 
> I can confirm existence of this kind of designs. One industrial real life
> example: a SoC connected to 3 port Gigabit KSZ switch. One port is
> typical RJ45 connector. Other port is RJ11 connector.
> 
> The speed can be reduced by using max-speed property. But i can't
> provide any user usable diagnostic information just by saying pair A or
> B is broken.
> 
> This is one of the reasons why i propose detailed description.

While I get the point, I'm wondering if it's relevant to expose this
diag information for the user. As this is a HW design feature we're
representing, and it's described in devicetree, the information that the
HW design is wrong or uncommon is already known. So, exposing this to
the user ends-up being a pretty way to display plain devicetree data,
without much added value from the PHY stack ? Or am I missing the point
?

I would see some value if we could detect that pairs are miswired or
disconnected at runtime, then report this to user. Here the information
is useful.

The minimal information needed by software is in that case "how many
working pairs are connected between the PHY and the connector", and
possibly "are they swapped ?" but I think we already have a DT property
for that ?

Maxime

