Return-Path: <netdev+bounces-19508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B75775AFF9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 15:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EE71C212F9
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 13:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968A1801F;
	Thu, 20 Jul 2023 13:31:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8A182A0
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 13:31:10 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E812D54;
	Thu, 20 Jul 2023 06:30:30 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b8baa836a5so5705575ad.1;
        Thu, 20 Jul 2023 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689859821; x=1690464621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qIe8rMdwGK8O6waPW6ElMhYZtqXBgjIAped1KS+Lxj0=;
        b=E36Ey4hpLP1aGERgJzQAv5oQWbjP2dfI/yJ9QSqsCcAZUQqYH2EJuPmluxVpniz94+
         SqRDS4pEtomXHfRXODYYhAlZIxAatRHID9D88YI+tj+w3vKM5JieqRypSlSHOTbf2v95
         PUlca0W45r887uApCqi/zn/yh3GyTCCrBBW1XguZKYFarRPPHvkGdKJALW7+s9TgEir3
         pVPeDdLYxOZSMJ8v3iGIKvATJZHgcVErXIREn7/pOR3ivfvJWVHJWWTf1p+PnK9L0sBz
         4nG3H7SIhmhoYiEqtjnis5Ppnyac+F2VaQ2UY7v0ygr32czvJ80e2mlstFNoj9axpszx
         inAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859821; x=1690464621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qIe8rMdwGK8O6waPW6ElMhYZtqXBgjIAped1KS+Lxj0=;
        b=EvNStNqhfvdCRycMNWSDldz9nJ/3UehP9f3BLfjWgQVHod1rlOEpbw+vjBfhCY3vpC
         9jOTd/+KAo0+WXVPAtqt7PYYLCyanZ08SDuKC4qoVNLAuON+tcB3GG6O6wpKLPvfuF3c
         fu7aMx97pSwD2QPx+fT4zIj9prUQCA32bNJvOsbcF4Z9XuKHoAX1TSBTf3Ln6rxnRn2t
         5nO/1OI0mYcYlKu6lk1QQRdUjwF1XRXCzy3RCchjlQImLJUAJ3v/PYkBlLmRhf9SS5IU
         Z2MRyD3tcPHkzJ9FBMcoQU855tYRxmwirM9TfurKKf91t1KNqX+1sHEiVubcpyA1xFLV
         4nNQ==
X-Gm-Message-State: ABy/qLZyt293PadNAyus3aBUo/Nf2dFdmQz4i+vw8Nv7LEqoq+qpump9
	vHlgsurlu7/M4n6aYRds4KQ=
X-Google-Smtp-Source: APBJJlFh1AyFX2+11T9yyn39CZ9ejJo7irpyerH5jDd4rJJqhGrNwsFMVrOCBzL5cXWCBiVM2usEnA==
X-Received: by 2002:a17:903:191:b0:1b8:9b5e:65c8 with SMTP id z17-20020a170903019100b001b89b5e65c8mr25796578plg.4.1689859821611;
        Thu, 20 Jul 2023 06:30:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902728c00b001b86deba2f9sm1302975pll.284.2023.07.20.06.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 06:30:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1d8cf4f5-3004-3af1-2735-03fde48d69c7@roeck-us.net>
Date: Thu, 20 Jul 2023 06:30:16 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 32/42] wdt: ts72xx: add DT support for ts72xx
Content-Language: en-US
To: nikita.shubin@maquefel.me, Hartley Sweeten
 <hsweeten@visionengravers.com>, Lennert Buytenhek <kernel@wantstofly.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Lukasz Majewski <lukma@denx.de>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Alessandro Zummo
 <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Sebastian Reichel
 <sre@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Mark Brown <broonie@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Damien Le Moal <dlemoal@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>, soc@kernel.org,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Peters <mpeters@embeddedTS.com>, Kris Bahnsen <kris@embeddedTS.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org,
 netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-ide@vger.kernel.org,
 linux-input@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
 <20230605-ep93xx-v3-32-3d63a5f1103e@maquefel.me>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230605-ep93xx-v3-32-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/20/23 04:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add OF ID match table.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/ts72xx_wdt.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
> index 3d57670befe1..ac709dc31a65 100644
> --- a/drivers/watchdog/ts72xx_wdt.c
> +++ b/drivers/watchdog/ts72xx_wdt.c
> @@ -12,6 +12,7 @@
>    */
>   
>   #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/watchdog.h>
>   #include <linux/io.h>
> @@ -160,10 +161,17 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> +static const struct of_device_id ts72xx_wdt_of_ids[] = {
> +	{ .compatible = "technologic,ts7200-wdt" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ts72xx_wdt_of_ids);
> +
>   static struct platform_driver ts72xx_wdt_driver = {
>   	.probe		= ts72xx_wdt_probe,
>   	.driver		= {
>   		.name	= "ts72xx-wdt",
> +		.of_match_table = ts72xx_wdt_of_ids,
>   	},
>   };
>   
> 


