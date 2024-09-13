Return-Path: <netdev+bounces-128046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8BA977A11
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF41FB268BB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9F1BD4F4;
	Fri, 13 Sep 2024 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q26Flae+"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1C1BC063;
	Fri, 13 Sep 2024 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213402; cv=none; b=tETedZu5JDU1Yc5/A/AEffPhWM46P2A8L1eiMaQ10a+z5Eey14495xX/wB/sHa0xwu1AfuOYOUmwCCkIHG4tsWW7Ke6qcFYhC67lKkjfOSJgah3T64mo9X7NnbVQJAqtHyi/xP0wut0N1xO21ReiLjZOlMwDZzMEtFpEmkmTtOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213402; c=relaxed/simple;
	bh=9KkMe5v4E+0qEr1YKv7MGz8qVKHNysFqzV0E+PVt14A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hgKvJZffBYw3oip6j+i33dc/0ntndDXUlXrKDRAeoba6MjJa3OCovMlPgsCDSU7wB6api8hPvxHEdZOOGYKh2QYkoRbsAJ5H5dHkhhtmN1RTN3NRUom9Di7wBj/qBmQFgLGYtvp1iL2fPYK0DMUpOXG/06VazSUTXlbhTpT/SVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q26Flae+; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C5A8240007;
	Fri, 13 Sep 2024 07:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726213397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbNBS11AUnkLj6P267FhnebVN+Afa/PIxo5XX6/e7v0=;
	b=Q26Flae+FSPLgdiUA2lHNIiJX0f3LqcDsutVu4UhmJ3NmJQk/eZBfiTnwqkbQqQewaQvEA
	GG0PIc8zXAbtYqM9eN0Fa9zarr24lkOoGkTQD5/HEGFNsDiT/o3ZXVVJQoSx2OiXvzCHuM
	6T9URrufOwTy6OHvHDNeNvhbBXG2phBFZdbnuGtApsCZqXoeGgt4kx9J6LT+OD0lbboVdz
	yvNzivWzqvRjvsKtWbKDLjTHXhD0wG50dRGq3bOx7WWwcPH/osADxoPq1DJ1UjRMfpiKvQ
	fjn+/6GKLV8BnAeWtt0FC8q+Da8IH1YjQjzyquvxEVSIeP85ydyuFlK1OJGtfQ==
Date: Fri, 13 Sep 2024 09:43:13 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Herve Codina
 <herve.codina@bootlin.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Marek =?UTF-8?B?QmVow7pu?=
 <kabel@kernel.org>, =?UTF-8?B?S8O2cnk=?= Maincent
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 1/7] net: phy: allow isolating PHY devices
Message-ID: <20240913094313.6539264a@fedora.home>
In-Reply-To: <7736f0f2-8a99-4329-b290-089454d56e36@gmail.com>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
	<20240911212713.2178943-2-maxime.chevallier@bootlin.com>
	<7736f0f2-8a99-4329-b290-089454d56e36@gmail.com>
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

Hello Florian,

On Thu, 12 Sep 2024 11:30:26 -0700
Florian Fainelli <f.fainelli@gmail.com> wrote:

> On 9/11/24 14:27, Maxime Chevallier wrote:
> > The 802.3 specifications describes the isolation mode as setting the
> > PHY's MII interface in high-impedance mode, thus isolating the PHY from
> > that bus. This effectively breaks the link between the MAC and the PHY,
> > but without necessarily disrupting the link between the PHY and the LP.
> > 
> > This mode can be useful for testing purposes, but also when there are
> > multiple PHYs on the same MII bus (a case that the 802.3 specification
> > refers to).
> > 
> > In Isolation mode, the PHY will still continue to respond to MDIO
> > commands.
> > 
> > Introduce a helper to set the phy in an isolated mode.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> Not sure where that comment belongs so I will put it here, one thing 
> that concerns me is if you have hardware that is not strapped to be 
> isolated by default, and the PHY retains the state configured by Linux, 
> such that the PHY is in isolation mode. A boot loader that is not 
> properly taking the PHY out of isolation mode would be unavailable to 
> use it and that would be a bug that Linux would likely be on the hook to 
> fix.
> 
> Would recommend adding a phy_shutdown() method which is called upon 
> reboot/kexec and which, based upon a quirk/flag can ensure that the 
> isolation bit is cleared.

Very good point. I can see the same problem occuring with loopback then
(if we use the 802.3 C22 PHY loopback bit).

I have such a patch ready actually, for the 2-PHYs-on-the-same-MAC
scenario, I will include it in the next iteration.

Thanks for your feedback,

Maxime

