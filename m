Return-Path: <netdev+bounces-108477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4892E923F20
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04358288FFD
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B01B5831;
	Tue,  2 Jul 2024 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WMDAMzcW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E741B5839;
	Tue,  2 Jul 2024 13:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927423; cv=none; b=Xa0746zhgjcegZOS1YPB6DuxygC9dvQS2UQPTcXAdgkHYRqA8dMZ4gKnwSiA/J2hmfuTgijiFqhfWoGw20Vo9u+8OJ+8k/zhh6MjSYpAio/4QJqbTSxOpp/tgjJ48YgpaSwYJjhxz1+CZFQfRV/muUoZBFmy85ykUnEOs4fNYzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927423; c=relaxed/simple;
	bh=Rf8pytGGyJ+/UthIQrIgbJqnNdI8AH9+nt33gt482vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAYpiGUsIz3oFUm5r7jQRk6YQm7o0UQEGGb2lhzmRa1WaEbyqcu9b5J1spA//BB7cjHq+4YvyI/xVHSSFm7eJut0Dzdzst1xY9j2w2ZcQCLo/7pr7Q/eq/J3RHbbbPPR2IykPCLiSsvMMjrUPe6ZQfQ6g6pfkQMZ8DDZjqmwK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WMDAMzcW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UE/r/eX4kYFpqE2iqIBa4HA5B6YiEmH/2Pau6up8JXs=; b=WMDAMzcWuKgTBL2IfteD2ucmop
	J5acjXm5FgLmoTSFrYpvkKUd87E+6nEUkhb6u8J7wT2PkyNH+mq01dot+v/MvYrwIX1DAn1la3Pdx
	i0uxHMHACFifK1awHlq2cD2CESajgGVxjJfGkHvl8q9Crgl4fi7LvTGSuk3bhpUCp4LY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOdgL-001dn7-0r; Tue, 02 Jul 2024 15:36:29 +0200
Date: Tue, 2 Jul 2024 15:36:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Michael Walle <michael@walle.cc>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH net] net: phy: mscc-miim: Validate bus frequency obtained
 from Device Tree
Message-ID: <ed9517b1-0945-4a43-b4b0-dce942b05889@lunn.ch>
References: <20240702110650.17563-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702110650.17563-1-amishin@t-argos.ru>

On Tue, Jul 02, 2024 at 02:06:50PM +0300, Aleksandr Mishin wrote:
> In mscc_miim_clk_set() miim->bus_freq is taken from Device Tree and can
> contain any value in case of any error or broken DT. A value of 2147483648
> multiplied by 2 will result in an overflow and division by 0.
> 
> Add bus frequency value check to avoid overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: bb2a1934ca01 ("net: phy: mscc-miim: add support to set MDIO bus frequency")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/mdio/mdio-mscc-miim.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
> index c29377c85307..6380c22567ea 100644
> --- a/drivers/net/mdio/mdio-mscc-miim.c
> +++ b/drivers/net/mdio/mdio-mscc-miim.c
> @@ -254,6 +254,11 @@ static int mscc_miim_clk_set(struct mii_bus *bus)
>  	if (!miim->bus_freq)
>  		return 0;
>  
> +	if (miim->bus_freq == 2147483648) {
> +		dev_err(&bus->dev, "Incorrect bus frequency\n");
> +		return -EINVAL;
> +	}

Are you saying that only this one specific value with cause overflow?
No other value will? Can any value cause underflow?

Generally, i would expect to see a range check here. 802.3 requires
that the bus can operate at 2.5MHz. I've seen some which can operate
up to 12Mhz. 25MHz seems like a sensible upper limit. But maybe you
can do the maths and figure out the theoretical maximum. There are use
cases for going below 2.5MHz, the hardware design is broken, the edge
on the signal are two round at 2.5Mhz. So i've seen prototype hardware
need to run there MDIO clock at 100Khz until the hardware designer
fixes their error. So how about validating the frequency is > 100KHz
and < 25MHz?

> +		dev_err(&bus->dev, "Incorrect bus frequency\n");

Incorrect is also a bit odd. I would prefer Invalid.

	Andrew

