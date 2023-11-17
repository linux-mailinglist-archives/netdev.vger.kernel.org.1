Return-Path: <netdev+bounces-48694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0797EF45C
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 15:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925B2281340
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9867836AF7;
	Fri, 17 Nov 2023 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="dzVl95Ca"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B09511D
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:24:10 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-41cc0e9d92aso11494831cf.3
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1700231049; x=1700835849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phxFPe55P8CNYj8QoVrvhXQbB6FUhxK+zwpdYoS3EuA=;
        b=dzVl95CaROZ+QbGRKGuLzj4fc04+o6SZFYJ5nsK+4zGnIx2NXJayYElJA9xYyvDxBU
         iPRlN8gLCbTTj5DI3tmKfdN6RDNT2K2yv2gqKx+8vHZAi508j1ImCgXeHp6LoqPXh6me
         nkies7XQTSmqthVf4jDG+xIFp3UAiaGEwpOVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700231049; x=1700835849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phxFPe55P8CNYj8QoVrvhXQbB6FUhxK+zwpdYoS3EuA=;
        b=sfQsDSTDlqI88rFs+HOqLIs0rEqGyxr7C3S+X5tsYX+Apnj/XFJRVfhyCUIXgxM9fR
         kLtpeuduqnepvFKT8rNAcuuKmvdGdzwK6m+T1+nCwmzR0myTULNNK0EkX8LSG0UwRakf
         Pexx17H4waADtjUIaiGIfR4kFMpOxExveu2sgmcLgmzFGWd4+cVQU14k+UfFa9bV4vY7
         RBMHnygSKBd0YbxvAApP130BsxV33QoYXFFbB8/NZdkzF0Vq5hG9Bb0NWjy8uMZfUiIZ
         kySCN5xOj4GPNmXXZppFwG9qTrC157S/1U85IfZlp8uRxncE7FKPzII3tS7cIWOXQaux
         gwTQ==
X-Gm-Message-State: AOJu0YxC6pDsW/d+hatZTT81uAkadWlk9BfPDqIM/JPCUmCsvt9keNx1
	I6yOPPRbkDanFHCSGSemMwH+Bw==
X-Google-Smtp-Source: AGHT+IEuLjrdxhZv4ORrxOJiHSBnRa58c0OWliziUUhyyLjiGdhNl4K1avRY5bgGmT0YeLFtSwhIoA==
X-Received: by 2002:ac8:5793:0:b0:41c:c60c:7c1f with SMTP id v19-20020ac85793000000b0041cc60c7c1fmr14651086qta.6.1700231049203;
        Fri, 17 Nov 2023 06:24:09 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id fp24-20020a05622a509800b004181e5a724csm605664qtb.88.2023.11.17.06.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 06:24:08 -0800 (PST)
Message-ID: <d60014c5-7e84-4967-8bdf-d02226b23d27@ieee.org>
Date: Fri, 17 Nov 2023 08:24:07 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/10] net: ipa: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Alex Elder <elder@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kernel@pengutronix.de
References: <20231117095922.876489-1-u.kleine-koenig@pengutronix.de>
 <20231117095922.876489-3-u.kleine-koenig@pengutronix.de>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <20231117095922.876489-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/17/23 3:59 AM, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

To be clear, this patch can't proceed until the previous
one is resolved.  Once it is, this should be fine.

Sorry for not just doing it now.  I like what you're doing,
I just don't have time to spend at the moment for the
review this will require.

					-Alex


> ---
>   drivers/net/ipa/ipa_main.c | 17 +++--------------
>   1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
> index 60e4f590f5de..2c769b85a2cd 100644
> --- a/drivers/net/ipa/ipa_main.c
> +++ b/drivers/net/ipa/ipa_main.c
> @@ -936,7 +936,7 @@ static int ipa_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int ipa_remove(struct platform_device *pdev)
> +static void ipa_remove(struct platform_device *pdev)
>   {
>   	struct ipa *ipa = dev_get_drvdata(&pdev->dev);
>   	struct ipa_power *power = ipa->power;
> @@ -979,17 +979,6 @@ static int ipa_remove(struct platform_device *pdev)
>   	ipa_power_exit(power);
>   
>   	dev_info(dev, "IPA driver removed");
> -
> -	return 0;
> -}
> -
> -static void ipa_shutdown(struct platform_device *pdev)
> -{
> -	int ret;
> -
> -	ret = ipa_remove(pdev);
> -	if (ret)
> -		dev_err(&pdev->dev, "shutdown: remove returned %d\n", ret);
>   }
>   
>   static const struct attribute_group *ipa_attribute_groups[] = {
> @@ -1002,8 +991,8 @@ static const struct attribute_group *ipa_attribute_groups[] = {
>   
>   static struct platform_driver ipa_driver = {
>   	.probe		= ipa_probe,
> -	.remove		= ipa_remove,
> -	.shutdown	= ipa_shutdown,
> +	.remove_new	= ipa_remove,
> +	.shutdown	= ipa_remove,
>   	.driver	= {
>   		.name		= "ipa",
>   		.pm		= &ipa_pm_ops,


