Return-Path: <netdev+bounces-34870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397407A59AA
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 08:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFED5281FB2
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 06:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF75D35883;
	Tue, 19 Sep 2023 06:00:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E5EBE
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 06:00:46 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4DA10F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 23:00:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c012232792so23819791fa.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 23:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1695103242; x=1695708042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VgNHTKSkbSOtaatePZgGr9Nmudwl37ZZrI+xoYFAR3A=;
        b=iLoIOJqRkLTW2n+ZDZ5HiMpO0x3g9ADkTfYWXW91MzkzO4lq/ri/QGSsdetfoOiiTU
         mlidTpeffaEGO2oYvZvwNX+CYDsRY7+s4qYczSZNS7zd0atmTyOjqIc8euJrZjjWlYjF
         AjP2b7j5f5AiQ2YcHXMXYHPnPUTvCJMnrppoT6mGUYzMJUrugpAAg7jrNsxSdmSTOx7W
         vFFQrh947Z/XpTwsYOk0W0W33c1pHvkH7vLggD2ZIObUoUfv8gE4gjX0K0Q4Zg6OHGCK
         WXHUzjUpHui9Po9up73MRVIq7YwJRx0+eZAV3mOfcc0CgP3Daj8WKNiKRS1RzYXe6Zx9
         wNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695103242; x=1695708042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgNHTKSkbSOtaatePZgGr9Nmudwl37ZZrI+xoYFAR3A=;
        b=H3tXBP7Pu4hkgJmvs3r5LJqZ2FRjZ3EfgbVlMaQe9UbRfP5UzYONR5NupiKE8wmNLj
         CKwTX/3yGxwJ6C/SHBSTM1cnOdNEkrqVVS10XwnaxaATfW8CykYnVm5/u4i3Hs0QVnV0
         iarh7Vt6H7CaR59Sz2jqfxDsvFWryaEbjY6ZAZkuvbEyTWtwt6uEJtnVWAwv1W5uEwP1
         IzqtF98M91I3Xp4670mqPsgS/GrwMTP+gv8gTurpYq/OK9iJPSUazXbJiLGdnBvr7PPB
         HPeW10+bsh0EH1bTjq325ideHjehZoxN2f0RRPe6tAN0UBfOzof+U4fWjV2mxhKLgTbm
         KrgA==
X-Gm-Message-State: AOJu0YygI3nxlqQAfDOLNOOHZajfJcbwsY80lXDLUBHFZMZ4TTI3Bd41
	l3625hrkUyNgwMVj8MhCQSFzvQ==
X-Google-Smtp-Source: AGHT+IEWk65L+7FWQjdFZjoHNDgnHDVFURHXC4jCaDVAR/pbtltiHCIlAp9KHKFfJgMEL+UUl4Cn8w==
X-Received: by 2002:ac2:5223:0:b0:503:9a4:26f7 with SMTP id i3-20020ac25223000000b0050309a426f7mr4870302lfl.40.1695103242457;
        Mon, 18 Sep 2023 23:00:42 -0700 (PDT)
Received: from [192.168.32.2] ([82.78.167.145])
        by smtp.gmail.com with ESMTPSA id u23-20020aa7d997000000b0052a3edff5c3sm6850147eds.87.2023.09.18.23.00.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 23:00:42 -0700 (PDT)
Message-ID: <c436e4f0-1cfa-de9a-ca76-6f6aa0a5bfc3@tuxon.dev>
Date: Tue, 19 Sep 2023 09:00:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 12/54] net: ethernet: cadence: Convert to
 platform remove callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 kernel@pengutronix.de
References: <20230918204227.1316886-1-u.kleine-koenig@pengutronix.de>
 <20230918204227.1316886-13-u.kleine-koenig@pengutronix.de>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20230918204227.1316886-13-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 18.09.2023 23:41, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new() which already returns void. Eventually after all drivers
> are converted, .remove_new() is renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  drivers/net/ethernet/cadence/macb_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
> index b940dcd3ace6..cebae0f418f2 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -5156,7 +5156,7 @@ static int macb_probe(struct platform_device *pdev)
>  	return err;
>  }
>  
> -static int macb_remove(struct platform_device *pdev)
> +static void macb_remove(struct platform_device *pdev)
>  {
>  	struct net_device *dev;
>  	struct macb *bp;
> @@ -5181,8 +5181,6 @@ static int macb_remove(struct platform_device *pdev)
>  		phylink_destroy(bp->phylink);
>  		free_netdev(dev);
>  	}
> -
> -	return 0;
>  }
>  
>  static int __maybe_unused macb_suspend(struct device *dev)
> @@ -5398,7 +5396,7 @@ static const struct dev_pm_ops macb_pm_ops = {
>  
>  static struct platform_driver macb_driver = {
>  	.probe		= macb_probe,
> -	.remove		= macb_remove,
> +	.remove_new	= macb_remove,
>  	.driver		= {
>  		.name		= "macb",
>  		.of_match_table	= of_match_ptr(macb_dt_ids),

