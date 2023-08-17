Return-Path: <netdev+bounces-28427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D0177F67C
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 14:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147C8281F6A
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 12:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49E12B79;
	Thu, 17 Aug 2023 12:36:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D5B2907
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 12:36:44 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A416271B
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:36:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so844760a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 05:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692275802; x=1692880602;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcG9mf/4d3wJ/7xZp1niMz7S9D4w8uHltKQFa9+MD8U=;
        b=MQlGLr3eSXYjCog7306FjvsWcllKsVuWAEaBYiG5AP8C2FEPylUUjG/aGk4LOj5zkV
         W/ij12yxb6v96DgRCAHDXW5WKM+L6iDPW/ZZ9q6CXOJM5NVsNSGd2EbQMe4AZqYjFjds
         y99z8xpW7rMdPCt3NEWuI6JQKJO0YBvK/NRnwTUcspPOjwubUWcL+tdV7oJpnrRSqRJM
         Yqn08skqyey3UjL9gx0+xMy9KjxJ1JPbd9vhePqePQfklt/jjKqyFGHmjIRiOTnQg/Gp
         ufmPb4v+zrRM92UipIsNbOIpBmrgZz2niHHyHmkVv6JjKUdbiADDotEmzEHito/a3fxs
         xK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692275802; x=1692880602;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vcG9mf/4d3wJ/7xZp1niMz7S9D4w8uHltKQFa9+MD8U=;
        b=ChU3as/EwEzAdpF0eegaEAW2i7CMhXgNfPaILByBp7XHX0rbSpSus2utLR5/r4alfR
         vHC2kLbfhBwgwnj3lGL2pf9vfZ6A0/LgRNqveKKBqfmDmrdLKqhhTtIuQfNM5fvAEQ9S
         LI/51HcGvYSXqvxCd6xxs58RJiUVgVR7eHGrQjlZuv8HXW6Q0er7GBX328XocYeAgC/n
         0IqMu9pyaNdM0wsUSjgUeTVW2/NJ6MJ4FCIUj7Pct3fS7GyvjQ9L36+veV6JkwsKOEkr
         OXzqFOBlp6XkWk19tPfdVT0Ppcr0V/vyjM3E2I0PiY9kqAy8RJe4P86bOAIzoKB/JyPZ
         Bw7g==
X-Gm-Message-State: AOJu0YwLTH4Zz4SThIKmkKDQvuwvttjOc1ik+qRgt0yQSvpdIzkWJRQG
	NmEfSagqfYbMA8gKyveGFzc=
X-Google-Smtp-Source: AGHT+IFfV0NIhqgRgRqqE+v4Bb5cr4UTfpEmK1fBe+0KhaLfDcNkX0AUWEiECnjWZxOX+Hb89yTUww==
X-Received: by 2002:aa7:d614:0:b0:523:4b9d:a80f with SMTP id c20-20020aa7d614000000b005234b9da80fmr4090359edr.15.1692275801643;
        Thu, 17 Aug 2023 05:36:41 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7a3c:5e00:c9d3:59d1:96ab:8b21? (dynamic-2a01-0c22-7a3c-5e00-c9d3-59d1-96ab-8b21.c22.pool.telefonica.de. [2a01:c22:7a3c:5e00:c9d3:59d1:96ab:8b21])
        by smtp.googlemail.com with ESMTPSA id d7-20020aa7d5c7000000b0052286e8dee1sm9655054eds.76.2023.08.17.05.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 05:36:41 -0700 (PDT)
Message-ID: <201a9a79-9e60-5e06-1a8c-4c54a9ed4d51@gmail.com>
Date: Thu, 17 Aug 2023 14:36:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
To: Ruan Jinjie <ruanjinjie@huawei.com>, rafal@milecki.pl,
 bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, opendmb@gmail.com,
 florian.fainelli@broadcom.com, bryan.whitehead@microchip.com,
 andrew@lunn.ch, linux@armlinux.org.uk, mdf@kernel.org, pgynther@google.com,
 Pavithra.Sathyanarayanan@microchip.com, netdev@vger.kernel.org
References: <20230817121631.1878897-1-ruanjinjie@huawei.com>
 <20230817121631.1878897-4-ruanjinjie@huawei.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net-next v2 3/4] net: bcmgenet: Fix return value check for
 fixed_phy_register()
In-Reply-To: <20230817121631.1878897-4-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17.08.2023 14:16, Ruan Jinjie wrote:
> The fixed_phy_register() function returns error pointers and never
> returns NULL. Update the checks accordingly.
> 
> And it also returns -EPROBE_DEFER, -EINVAL and -EBUSY, etc, in addition to
> -ENODEV, just return -ENODEV is not sensible, use PTR_ERR to
> fix the issue.
> 
It's right that by returning -ENODEV detail information about the
error cause is lost. However callers may rely on the function to
return -ENODEV in case of an error. Did you check for this?
Even if yes: This second part of the patch is an improvement,
and therefore should be a separate patch.

> Fixes: b0ba512e25d7 ("net: bcmgenet: enable driver to work without a device tree")
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
> ---
> v2:
> - Remove redundant NULL check and fix the return value.
> - Update the commit title and message.
> - Add the fix tag.
> ---
>  drivers/net/ethernet/broadcom/genet/bcmmii.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> index 0092e46c46f8..97ea76d443ab 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
> @@ -617,9 +617,9 @@ static int bcmgenet_mii_pd_init(struct bcmgenet_priv *priv)
>  		};
>  
>  		phydev = fixed_phy_register(PHY_POLL, &fphy_status, NULL);
> -		if (!phydev || IS_ERR(phydev)) {
> +		if (IS_ERR(phydev)) {
>  			dev_err(kdev, "failed to register fixed PHY device\n");
> -			return -ENODEV;
> +			return PTR_ERR(phydev);
>  		}
>  
>  		/* Make sure we initialize MoCA PHYs with a link down */


