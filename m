Return-Path: <netdev+bounces-28431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23CF77F691
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BF6A281F3E
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA0134C2;
	Thu, 17 Aug 2023 12:43:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2E134BA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:43:14 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA7F2D61
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:43:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so1900903a12.0
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692276191; x=1692880991;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCf5q5yQe8Z4hHkCQL2AhutzJh9apDTJNFFPSf/zknk=;
        b=HsCWdPiKcTm2ACIUDYtoBJH+fioJdsn4qB2ZczgpLf6RqdfFqdqcl7eh5gMAnKRSrK
         wYord/BjTSOwPrG7sTDhH8WhOMzbSgrW8NZaXAmhYXI7bN/ZeUSi2nyxc3CCfVU6I7Sp
         Vr8EthC//oifbqtzAWxppPel/YUBc+1EGuLNbuSKXaSQrKQBHXD6QUGjGgcdLPz2gKcP
         o+v9yYh+WFC5T1KgY1Vyot9sKXWrmWI5HoNBC/VneXFPhthhnb3N8FgFSdRIRcCwSIfU
         BW+2w/UoOq+3aULW3OwirQyrqdHE0NixgApiox13QX9mfA4kRkTxiG0mLfLZqsY9bmrx
         +m1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276191; x=1692880991;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCf5q5yQe8Z4hHkCQL2AhutzJh9apDTJNFFPSf/zknk=;
        b=SHQ7cj78rtFi6BlqezXvdGF6g3nGB0MvdCuHHqrZtS3G7rEiDfNOTHQ2Zu6AoIp/w1
         svkoOmhKAHAbIKt0561NSNDdkn6Zkgf++ncLuQBJgJlkHWmv8ZkUkrBIJoY3UHG2IXjR
         Xw/a23lTwBnFBOL/xGiWwKonr34QE70B3FdAeZ61tcYuUS7mCiVZTHBihs+paUlrK6Fz
         EgpJtIpJyUw+cXU+cw273aTS6Bm0GF8nIrmg+l4HCYeIyLIHxSEGTUCZ2swDi263kYgA
         Mw22WsGeotiX1pReVbQoQ8tU+iEpU6Zt+ic6vwd4p2iNr5o42EC38sbG76LcGEQWl5zj
         +SlA==
X-Gm-Message-State: AOJu0YzgCBpmOx1IaCrxNZ3tr79MfkNu/lGFrG3t48aHhtw6nJBzOaXh
	ndtkDTkdy/nAavGt6Fms62ULJ/WD074=
X-Google-Smtp-Source: AGHT+IHANn8J79Ld6+1oY6u9204lsiRyVmszPYfM450hgmiFcBJauvj6HoZ0mWQ5MZZADkReh4MnCg==
X-Received: by 2002:a05:6402:3494:b0:525:4d74:be8c with SMTP id v20-20020a056402349400b005254d74be8cmr3031960edc.14.1692276191341;
        Thu, 17 Aug 2023 05:43:11 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a3c:5e00:c9d3:59d1:96ab:8b21? (dynamic-2a01-0c22-7a3c-5e00-c9d3-59d1-96ab-8b21.c22.pool.telefonica.de. [2a01:c22:7a3c:5e00:c9d3:59d1:96ab:8b21])
        by smtp.googlemail.com with ESMTPSA id n21-20020a05640204d500b005233885d0c6sm9693204edw.41.2023.08.17.05.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 05:43:10 -0700 (PDT)
Message-ID: <db0fd284-0b5b-3290-6661-f159908e9918@gmail.com>
Date: Thu, 17 Aug 2023 14:43:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 4/4] net: lan743x: Fix return value check for
 fixed_phy_register()
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bryan.whitehead@microchip.com,
 andrew@lunn.ch, linux@armlinux.org.uk, mdf@kernel.org, pgynther@google.com,
 Pavithra.Sathyanarayanan@microchip.com, netdev@vger.kernel.org
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-5-ruanjinjie@huawei.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <20230817121631.1878897-5-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17.08.2023 14:16, Ruan Jinjie wrote:
> fixed_phy_register() function returns -EPROBE_DEFER, -EINVAL and -EBUSY,
> etc, but not return -EIO. use PTR_ERR to fix the issue.
> 
> Fixes: 624864fbff92 ("net: lan743x: add fixed phy support for LAN7431 device")

This isn't a fix. Returning -EIO isn't wrong. Returning the original errno values
may be better, but that's an improvement.
Also combining "net-next" with a Fixes tag is wrong, except the functionality
was added very recently.

> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index a36f6369f132..c81cdeb4d4e7 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -1515,7 +1515,7 @@ static int lan743x_phy_open(struct lan743x_adapter *adapter)
>  							    &fphy_status, NULL);
>  				if (IS_ERR(phydev)) {
>  					netdev_err(netdev, "No PHY/fixed_PHY found\n");
> -					return -EIO;
> +					return PTR_ERR(phydev);
>  				}
>  			} else {
>  				goto return_error;


