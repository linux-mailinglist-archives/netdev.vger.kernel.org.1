Return-Path: <netdev+bounces-193564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E62D1AC47C0
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A106C1893412
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 05:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B551917F4;
	Tue, 27 May 2025 05:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="RuqfKSZE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E718D3594A;
	Tue, 27 May 2025 05:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748324722; cv=none; b=qBVgI2p4dBExH4qbAn7EbA3jpdRrhECD7RygUMHnB+mkmZMu5ZF4hW4wbVnGrTttaewK3R508Ho2Fftx0YIe9kFiPgxjDr8J4xKPqAEvYd+0nzhyz6C/ClFRzzKh0HiUpiwz/8An9gi7P1tJe0TuxZ9muVHHFgDwQ9C4HjuGCgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748324722; c=relaxed/simple;
	bh=UwirAYtlq4PYk8TsYpItR7qKlQL3pnxC3ACBwNJOxXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iBwqh9UUkqMerWQgisLqeSbxJaU8lkiCFOqAMgNw9LYn7W1js4IoNoUWhVYfHKfGoRA9sNGx0z7YyXlSssdVreBLojJ5kRV+N5UWyD9Q/j1ZgjmUusPer2kMGKtW+R6uc/oBUPJFGpxwU6SnrTC/Ff0EJNUxCKxIjdZwvb5LqDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=RuqfKSZE; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Jn6TuvW38K8x9Jn6TuJ1uT; Tue, 27 May 2025 07:44:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1748324645;
	bh=XaSDramaQ4ealF19zsjhv/7XrCvZ3oUf+OpS7nGNI+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=RuqfKSZEr3CG4BWdedgN5eVB3GxhSwHwxSTbYH9h7RUR5j4mU7wXvS51e1Eh7spnr
	 VZEt6ixH2w73IfHBCz5gbF34YZwiMMuv7x1QVLLUUCUT+p7r4eF18zjdglLAoJjfde
	 DueN8tNY+/fcyYDpvtdPpXgf5+K7jCKExyhWjWb1DJe+Zn0X2ljOpOrEXOib0oNTwO
	 ssnhI8HZFd+1ocoiNCg7SDPLh4//RcuYV9+AUWMlULPgxE8SC60zHwDLXa0DJMeCDe
	 ZT6vkRllvZ0LUWkTBi4kM1dsd1X72xNeKq97GF7SJ1LGiThP56Rytoh3UjKmXv3Ycd
	 LAW+0luDsoOxQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 27 May 2025 07:44:05 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <be687d2d-4c16-46d6-8828-b0e4866d91de@wanadoo.fr>
Date: Tue, 27 May 2025 07:43:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dwmac-rk: No need to check the return value of the
 phy_power_on()
To: =?UTF-8?B?5p2O5ZOy?= <sensor1010@163.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 jonas@kwiboo.se, rmk+kernel@armlinux.org.uk, david.wu@rock-chips.com,
 wens@csie.org, jan.petrous@oss.nxp.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250526161621.3549-1-sensor1010@163.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250526161621.3549-1-sensor1010@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 26/05/2025 à 18:16, 李哲 a écrit :
> since the return value of the phy_power_on() function is always 0,
> checking its return value is redundant.

Can you elaborate why?

Looking at  (1], I think that it is obvious that non-0 values can be 
returned.


CJ

[1]: 
https://elixir.bootlin.com/linux/v6.15/source/drivers/phy/phy-core.c#L305

> 
> Signed-off-by: 李哲 <sensor1010@163.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 700858ff6f7c..6e8b10fda24d 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1839,11 +1839,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>   		dev_err(dev, "NO interface defined!\n");
>   	}
>   
> -	ret = phy_power_on(bsp_priv, true);
> -	if (ret) {
> -		gmac_clk_enable(bsp_priv, false);
> -		return ret;
> -	}
> +	phy_power_on(bsp_priv, true);
>   
>   	pm_runtime_get_sync(dev);
>   


