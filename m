Return-Path: <netdev+bounces-152072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F809F2947
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B227A1784
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB99433B1;
	Mon, 16 Dec 2024 04:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="sCAinMDt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42C11804E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734323083; cv=none; b=WxQ6/k5OZnY2OA6qOpWgITPe9Dxtfg6Txskoch7J4i2isLK8LrF6q2xm3NUeK3A1OFZU+fECvQMZtS66642qIRKVYcKFa9mEGnkwDnudYBOwpy54nf7scMtmXczMDGFgy0WL0VoIUgziqKejFaSIvW7fBGZb4lC+7aRyEacEU/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734323083; c=relaxed/simple;
	bh=i3zFgM6LIQa6DuKwr1u6ufCispZepDle59RgEeqXwII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LYsslsfyRDMWdoyOPdBK8GWvlo/0vC5uuuenkqrtc/7mkGy8j5sMmohQexpsVHrGbNobr3MhTAA9tP56oyvFORB6LidIJ9GAbbcQpxKmG77Zz0aioFZb7RkbiDaucn0LDyoVeVXjBTMSFKFiTKihxRx1hLycZTbcZgPETvYU3AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=sCAinMDt; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so3065552a91.3
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 20:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734323081; x=1734927881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/gC73FYk94f1X6UyfOXdbcGWXPkq3OckoQQgeuUDe4U=;
        b=sCAinMDt99dK1O44kZwUxpit+XuGgaPWyFIVE5DjtK53OHsm6oAtFe1ltbA+FGrkzw
         w4GHEoStSKCliu3+EAoUAKezb0ulzNH5NlMsktXvjEEYVoBY8cmW3D5aduYsNWgQXC/x
         88DXsjHd5z9uBvljr9FmB4pQDzBgSPgeD1kGt57kvs1r+qV/DqqKqnLznfKM3H6hbA6y
         eu/qmSstsNUW0DIoG9Yugttb9EBG35p+KKXJeLu+zEIOF8VvZEgW8tYUCVgLnS7YlQGt
         Kh/byGQGJ4pWHdObVAkRvBeCQy4JishYkLIfZFWNwoZSyhoLJCBVTuMMrc27ykTqrxc+
         qVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734323081; x=1734927881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/gC73FYk94f1X6UyfOXdbcGWXPkq3OckoQQgeuUDe4U=;
        b=lyzhmrIfgMGXm47ctG2c6PEJMM6TXzpxd4sFkr/8rWsAMmuR6Uev0RFacCUSwtr4de
         yCeMfJ7praPr4ChGCp1f9yRs8TReqqHGWh1o5fnZ8kwWkbBOdewjUhmYj+HExFV8/Y0b
         gnwhMbIbYv2DRkXuMgn+dDNDbHRuTCJXIItIUFxih+mDzbqugAVdzWBs9YV+eI8ufJ5m
         ozsAWxu1Lf2ASXZYkj3I/0QA8JAmdD6ZNVzWk7+IXIQPjvrhKAqQVCmGr4/bdx8sPKci
         T4vi0oOa+lwxpcBoK1K1uQZzb74yb2VCKgpJx/e1rXkzLnr7DOUutdJZKgu7bLOAZ9h/
         1x8Q==
X-Gm-Message-State: AOJu0YyUiFOgQPVXeUgiIOoF3riKTEqCp2XnaddA2MoK9/0hI59MApb4
	yPGfcOV2cMk9YArORQDEU18iNDMERBEQBVCbP/V2/TjgSSmNwUWWLL80gD8AoGo=
X-Gm-Gg: ASbGncsmIWuzzk9Cv7sOIZpcgu87EQkyrqH85CqGUlZ/zR07TNFWvUbi76nFo/QWSHS
	AV6WtnANZy1MVsHU6PoS9FblkKTMvWzubIitwt5imKnEqdd6bEIU1zrv0ILvzu76sktDKhfsTbz
	ChoTB0j85rBTCBF0ODjzTRxl5RwvkqesJkzjfYyB0mB0YAw8uvZeZVLzUbuLDqYyRGStkIENGZM
	tv+PrtVY0fb2jEfj46TyNuK1WfnLwrM+iJirH9xJcurEm9TqvQ2RImHD2/oeUOU+RbUIahK8ujT
	rtKJCownsPM1SaeiqD4Rcj/SdBQFwbgo0JY/
X-Google-Smtp-Source: AGHT+IFhnNxGAIUDyiW1N/3neoV2bPsDUhM0oix0nnmen02zPr+bj+bBxf7YNe1w3ikHijZ4cBm8bw==
X-Received: by 2002:a17:90b:5345:b0:2ee:d96a:5831 with SMTP id 98e67ed59e1d1-2f2900a6003mr16781562a91.30.1734323081091;
        Sun, 15 Dec 2024 20:24:41 -0800 (PST)
Received: from ?IPV6:2001:f70:39c0:3a00:11b4:f79d:62a5:8fff? ([2001:f70:39c0:3a00:11b4:f79d:62a5:8fff])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d919f6sm7054809a91.6.2024.12.15.20.24.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Dec 2024 20:24:40 -0800 (PST)
Message-ID: <6fa9d756-633c-4323-b205-47040f403f57@pf.is.s.u-tokyo.ac.jp>
Date: Mon, 16 Dec 2024 13:24:37 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mv643xx_eth: fix an OF node reference leak
To: sebastian.hesselbarth@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20241216041536.485250-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Language: en-US
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241216041536.485250-1-joe@pf.is.s.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please disregard this patch as I sent a v2 patch.

On 12/16/24 13:15, Joe Hattori wrote:
> Current implementation of mv643xx_eth_shared_of_add_port() calls
> of_parse_phandle(), but does not release the refcount on error. Call
> of_node_put() in the error path and in mv643xx_eth_shared_of_remove().
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 76723bca2802 ("net: mv643xx_eth: add DT parsing support")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
>   drivers/net/ethernet/marvell/mv643xx_eth.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
> index a06048719e84..fa30f8c4a0cc 100644
> --- a/drivers/net/ethernet/marvell/mv643xx_eth.c
> +++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
> @@ -2705,8 +2705,11 @@ static struct platform_device *port_platdev[3];
>   static void mv643xx_eth_shared_of_remove(void)
>   {
>   	int n;
> +	struct mv643xx_eth_platform_data *pd;
>   
>   	for (n = 0; n < 3; n++) {
> +		pd = dev_get_platdata(&port_platdev[n]->dev);
> +		of_node_put(pd->phy_node);
>   		platform_device_del(port_platdev[n]);
>   		port_platdev[n] = NULL;
>   	}
> @@ -2769,8 +2772,10 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>   	}
>   
>   	ppdev = platform_device_alloc(MV643XX_ETH_NAME, dev_num);
> -	if (!ppdev)
> -		return -ENOMEM;
> +	if (!ppdev) {
> +		ret = -ENOMEM;
> +		goto put_err;
> +	}
>   	ppdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>   	ppdev->dev.of_node = pnp;
>   
> @@ -2792,6 +2797,8 @@ static int mv643xx_eth_shared_of_add_port(struct platform_device *pdev,
>   
>   port_err:
>   	platform_device_put(ppdev);
> +put_err:
> +	of_node_put(ppd.phy_node);
>   	return ret;
>   }
>   

Best,
Joe

