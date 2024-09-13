Return-Path: <netdev+bounces-128228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC389789E7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3159F286C1A
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 20:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DCD14F9EE;
	Fri, 13 Sep 2024 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I1ZXgwCx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA514EC6E
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726259085; cv=none; b=S6ia3TDvnosl00hM3kfJUlEJ4FVPFsPsz6DZSAo3cdsQNqH4q2mA4alvOa4N2KiGvl/zZ02TmChTcOLuNL1WgcdT+o9XFWd9w37Iu95bVA0jct7a2O2Z9F1rEuN+CavhlO5dpEbgxuWRNUbbN4qbzEO9JTd34tEK+umnbXBe5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726259085; c=relaxed/simple;
	bh=aeHHirsDTzlsKVKlkvJxIJprybC9ohBEqeiu92MY3xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSbbmain3K7pfnXH6U3Uqn51df2IdtOc7UeXpCoYSZBOrnpCXcxZO4uNbT9RDuK1cNA1vyUV05hGBBZPjCrJwt2L7GHoQBfMoZ2ZxeRDsPKdOmNSc11cHw1oMbPvZkzXjXMJmfvgLjlj/NVIjTxZj2AfFew34PykKH9e5qbvTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I1ZXgwCx; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id pCqCs5pkRXiYbpCqDs5fby; Fri, 13 Sep 2024 22:24:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726259074;
	bh=IFlge7GQc7i+yk+ZZfEDZaPwa4VYufyWQBRelpdZhAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=I1ZXgwCxzN4AkerjsejnGQV9v+1T/tFRqmuj96Ku2S9RRbEmqH/TvBEk+/RpBUKbU
	 hIx/QEzJ9R7AuM6YDPGKYxSplhCPdfDUFQVVSr4OQamd2cDwYcUjfEuKxhPL3T1Osd
	 hBbNLS8eHOodu0R+vLSGe/5SiQco1FBGrPnaIXk0QFR/cdcQpbKpg8ljcAnivBWIlL
	 /81LRski1PZZ9fAZxpXzZM462Y2jHiIzfjxabcMrlP/3ZANdY5qg4RjQ4+yd2qrCyg
	 qfKtXVN9Pdi4yBF/5/pPGlUhH560RBO/0RN3lWnyvRFwyMhr7qowwYiSPyC5oLFtO6
	 3D5kOkPeCdcvg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Sep 2024 22:24:34 +0200
X-ME-IP: 90.11.132.44
Message-ID: <4e4defa9-ef2f-4ff1-95ca-6627c24db20c@wanadoo.fr>
Date: Fri, 13 Sep 2024 22:24:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/8] net: ethernet: fs_enet: simplify clock
 handling with devm accessors
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, Herve Codina <herve.codina@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org
References: <20240904171822.64652-1-maxime.chevallier@bootlin.com>
 <20240904171822.64652-8-maxime.chevallier@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240904171822.64652-8-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/09/2024 à 19:18, Maxime Chevallier a écrit :
> devm_clock_get_enabled() can be used to simplify clock handling for the
> PER register clock.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>   .../ethernet/freescale/fs_enet/fs_enet-main.c    | 16 ++++------------
>   drivers/net/ethernet/freescale/fs_enet/fs_enet.h |  2 --
>   2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index c96a6b9e1445..ec43b71c0eba 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -900,14 +900,9 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	 * but require enable to succeed when a clock was specified/found,
>   	 * keep a reference to the clock upon successful acquisition
>   	 */
> -	clk = devm_clk_get(&ofdev->dev, "per");
> -	if (!IS_ERR(clk)) {
> -		ret = clk_prepare_enable(clk);
> -		if (ret)
> -			goto out_deregister_fixed_link;
> -
> -		fpi->clk_per = clk;
> -	}
> +	clk = devm_clk_get_enabled(&ofdev->dev, "per");
> +	if (IS_ERR(clk))
> +		goto out_deregister_fixed_link;

Hi,

I don't know if this can lead to the same issue, but a similar change 
broke a use case in another driver. See the discussion at[1].

It ended to using devm_clk_get_optional_enabled() to keep the same 
behavior as before.

CJ

[1]: 
https://lore.kernel.org/all/20240912104630.1868285-2-ardb+git@google.com/

>   
>   	privsize = sizeof(*fep) +
>   		   sizeof(struct sk_buff **) *
> @@ -917,7 +912,7 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	ndev = alloc_etherdev(privsize);
>   	if (!ndev) {
>   		ret = -ENOMEM;
> -		goto out_put;
> +		goto out_deregister_fixed_link;
>   	}
>   
>   	SET_NETDEV_DEV(ndev, &ofdev->dev);
> @@ -979,8 +974,6 @@ static int fs_enet_probe(struct platform_device *ofdev)
>   	fep->ops->cleanup_data(ndev);
>   out_free_dev:
>   	free_netdev(ndev);
> -out_put:
> -	clk_disable_unprepare(fpi->clk_per);
>   out_deregister_fixed_link:
>   	of_node_put(fpi->phy_node);
>   	if (of_phy_is_fixed_link(ofdev->dev.of_node))
> @@ -1001,7 +994,6 @@ static void fs_enet_remove(struct platform_device *ofdev)
>   	fep->ops->cleanup_data(ndev);
>   	dev_set_drvdata(fep->dev, NULL);
>   	of_node_put(fep->fpi->phy_node);
> -	clk_disable_unprepare(fep->fpi->clk_per);
>   	if (of_phy_is_fixed_link(ofdev->dev.of_node))
>   		of_phy_deregister_fixed_link(ofdev->dev.of_node);
>   	free_netdev(ndev);
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> index ee49749a3202..6ebb1b4404c7 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
> @@ -119,8 +119,6 @@ struct fs_platform_info {
>   	int napi_weight;	/* NAPI weight			*/
>   
>   	int use_rmii;		/* use RMII mode		*/
> -
> -	struct clk *clk_per;	/* 'per' clock for register access */
>   };
>   
>   struct fs_enet_private {


