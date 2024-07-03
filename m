Return-Path: <netdev+bounces-109020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56549268AA
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 20:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 516CAB216D8
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D825F188CD3;
	Wed,  3 Jul 2024 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="W+OMOCYx"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F431862A8;
	Wed,  3 Jul 2024 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720033081; cv=none; b=h6RyYXxdy1ijyHpv72Dgcw/PPMb2qtj3VXldZxLxsNf78c2WTqmgp1oAk2YlnXILrIQjF3oOHhXqyWaM12bKNkE+bxrGiM7pVn4W5xn8nJmG9mt29oMLR7c2X9Qw9EJsTsSvE2VOFo3Mdf+XrGnlTOPAHCTNOGVQ3F9OQVvEK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720033081; c=relaxed/simple;
	bh=r6UVfIS51/hrDRT2rQvASqgTmeji6NSK3h7seP9vttw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJUCf74Q0M7q2IVADgjjwk2n4cuBn5/6uyJo/F6Vsl5+b7PAclrqOr7gyy9oGEIefEGwoRr0lvjXRSMPeMxcUeO43eQEgGCY/asjzuv5MenPHdSqhfoB0/EngAQU9g/1dwX0JNPa50eSdn1N/JG8pBoW0suueKNGRnT0jnEp7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=W+OMOCYx; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LQ9QFlXPCkPCJO/uXmZOKpGl6HSaTjoZz8vKdX6Htr8=; b=W+OMOCYxqfobDNoR6Ibh4jnUB5
	o0cIV7ZkAkuVqvkkeQ+UNWlecU4NI3yWbRrBEt3dhntlgmTr0zlHgp4BWA6xdRdoUOMhq7PR/jcNN
	TCFo+nGxNJVC7kYww+PONLmvkenefLZrxPN/Ar4uJa8GOm2EZpSgeIZpdfy7VGyLHq7Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sP5At-001lCA-6I; Wed, 03 Jul 2024 20:57:51 +0200
Date: Wed, 3 Jul 2024 20:57:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Yuiko Oshino <yuiko.oshino@microchip.com>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v1 2/2] net: phy: microchip: lan87xx: do not report
 SQI if no link
Message-ID: <47b227f0-d445-47ba-9386-e8b77b733c26@lunn.ch>
References: <20240703132801.623218-1-o.rempel@pengutronix.de>
 <20240703132801.623218-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703132801.623218-2-o.rempel@pengutronix.de>

On Wed, Jul 03, 2024 at 03:28:01PM +0200, Oleksij Rempel wrote:
> Do not report SQI if no link is detected. Otherwise ethtool will show
> non zero value even if no cable is attached.
> 
> Fixes: b649695248b15 ("net: phy: LAN87xx: add ethtool SQI support")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/phy/microchip_t1.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
> index a35528497a576..22530a5b76365 100644
> --- a/drivers/net/phy/microchip_t1.c
> +++ b/drivers/net/phy/microchip_t1.c
> @@ -840,6 +840,9 @@ static int lan87xx_get_sqi(struct phy_device *phydev)
>  	u8 sqi_value = 0;
>  	int rc;
>  
> +	if (!phydev->link)
> +		return 0;
> +

Is this the correct place to fix this? Can any PHY report an SQI value
if there is no link? Maybe an automotive PHY using T1 and good old
fashioned CSMA/CD could report about background noise? But do they?

Maybe this should be fixed in linkstate_get_sqi()?

Also, maybe it should return -ENETDOWN, not 0. Do we want to say
"worse than class A SQI (unstable link)" when in fact the link is
"class G SQI (very good link)" once it is up?

	Andrew

