Return-Path: <netdev+bounces-155042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D95A00C67
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51D47A2028
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D56B1FA8F1;
	Fri,  3 Jan 2025 16:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SIjH7vjb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057691F9419;
	Fri,  3 Jan 2025 16:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735922885; cv=none; b=KynOs6aALZc61POqKPYZzBbiThJVCY1viGoHgcMrwYt7mgi39uWVXyyxR1EuzrCSgzwniYPS4C+uMub8Z0wr9IcdeQF/d1lU6I08B+77SPKadFQzUPOWyHjKOn1KD48H8D07pCwz0RjDd+ABHDtay7J184d5haDtvLxbliThRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735922885; c=relaxed/simple;
	bh=jxmr4GnD+hcZYvcqvzZ/R3egkOdYk4fRpyLFFOptZIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ADYKfMFnwDPIHTu+ZQKA2qJXCXDmD0OPFKCEjI055bPALkQTwa696niIS58vxLfO8YwjmUhyBb6dTOYpRPw9YCFNeFsjGlQhRAbeLcQCLRh7XKpT7RQuNwnOOtgcGX4cU3fF72XYqEv5X70cqgrgeJjSha4axwWS6ruytM1O2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SIjH7vjb; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Tkh7thvQlgiluTkhAtJugY; Fri, 03 Jan 2025 17:38:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735922332;
	bh=GImteROnqULHiFchXLQTzhpJttZLzgZN6ofwaQa8E98=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SIjH7vjbbSJIaxUKmhBM3ov4wfqI0MWG9M5HncSgPDIZwGkA8cuMe9jaoJ9kCQJcN
	 l6X1mLcu0p0afX4EQLWzCU1tk6JHQWsSoYCNxxRvqKDryVgbJoAa+NZ3FUVY5VDmBk
	 fGsQSUs6nLeRW8VFjrtGtXikEuPUUg/+vmABh2SAFy4UdH+Bv7FAcUYRM5vo3gDaeT
	 xnd4f8akpir9p8Gv1eJx7n0gUxch0qZdDB7LqeBcWT/+Sg8X4rvQIQa3/SxeBMjoDt
	 KMaLhw3/Ym00PLFzdpfP8SK6jcCqcSXHwkHqVlBcg1raOiko71QEvISzZZgboc2Kek
	 bmSEmk7QzeXQQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 03 Jan 2025 17:38:52 +0100
X-ME-IP: 90.11.132.44
Message-ID: <2736ccd3-680d-4f5d-a31a-156dec056f22@wanadoo.fr>
Date: Fri, 3 Jan 2025 17:38:40 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: Joey Lu <a0987203069@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20250103063241.2306312-1-a0987203069@gmail.com>
 <20250103063241.2306312-4-a0987203069@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250103063241.2306312-4-a0987203069@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 03/01/2025 à 07:32, Joey Lu a écrit :
> Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac driver.
> 
> Signed-off-by: Joey Lu <a0987203069@gmail.com>

...

> +	/* Nuvoton DWMAC configs */
> +	plat_dat->has_gmac = 1;
> +	plat_dat->tx_fifo_size = 2048;
> +	plat_dat->rx_fifo_size = 4096;
> +	plat_dat->multicast_filter_bins = 0;
> +	plat_dat->unicast_filter_entries = 8;
> +	plat_dat->flags &= ~STMMAC_FLAG_USE_PHY_WOL;
> +
> +	priv_data = nvt_gmac_setup(pdev, plat_dat);
> +	if (IS_ERR(priv_data))
> +		return PTR_ERR(priv_data);
> +
> +	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);

stmmac_pltfr_remove() is called by the .remove function.
Is it correct to call stmmac_dvr_probe() here, and not stmmac_pltfr_probe()?

> +	if (ret)
> +		return ret;
> +
> +	/* The PMT flag is determined by the RWK property.
> +	 * However, our hardware is configured to support only MGK.
> +	 * This is an override on PMT to enable WoL capability.
> +	 */
> +	plat_dat->pmt = 1;
> +	device_set_wakeup_capable(&pdev->dev, 1);
> +
> +	return 0;
> +}

...

> +static struct platform_driver nvt_dwmac_driver = {
> +	.probe  = nvt_gmac_probe,
> +	.remove = stmmac_pltfr_remove,
> +	.driver = {
> +		.name           = "nuvoton-dwmac",
> +		.pm		= &stmmac_pltfr_pm_ops,
> +		.of_match_table = nvt_dwmac_match,
> +	},
> +};

...

CJ

