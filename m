Return-Path: <netdev+bounces-19842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E662875C910
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BE61C216BB
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3861E530;
	Fri, 21 Jul 2023 14:08:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53F1E522
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:08:29 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A6730DF
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:08:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso12644765e9.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948473; x=1690553273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2qkUshKHVzVp+c/Y0demp7gaQXxbXWhnsTKXjZPyo0=;
        b=UywUc+C0GWGsJmsnwwyJfmenKpLuppCyVgn7fiVYk6w8oSQSyUPADu9CVzT0lItaIY
         JormQX7Bee7HUdM1Us0r3vshqvTW9dDS77pz9B/D2/ZA9svRp6qlgOzmPqZwXZh6JV1/
         jFAXc0VCSjO1FhzSB/42DbWYEZLCPHvRoJtnZSW/6xd3CWsvpKl50jxs8bWH4bIonPhx
         mfuI8ES1EO+wJ7wjJ7D30ET7A/S3K9wdVKebziw7EOvtZk48W3EgUDtaXZXX93H2sArO
         cOiSlGVXpphHHUVrTWcN6efAAohsXSYhMb2r+xKhHw3ppirNHnquGubX9HEPBDh6NwUV
         LT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948473; x=1690553273;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2qkUshKHVzVp+c/Y0demp7gaQXxbXWhnsTKXjZPyo0=;
        b=SvL1mJz6Ai0JNB5qr4sI7Vo+lSjIY05HwZDx/Xvk1v7ErfIYCk4LIpkXedDG7Olp5i
         71oG046m9dtUfopkN3qVvbo6bXdLlgJhFujtt/jSbUi3mRbLixbhAperztH/vdwcYgcY
         Zkx7AyQ7EO6jeHPBCpqF4oflQwJZwkenpDLSVMIM/kYKPjxH1DPCz3MyBKFO9Ob9Brg/
         3hWbQieOHGvIXHH3/+XZKTrwF+rSQ+dZzfNLDS/hbzpwDQMpwODQ75CvlZXDKtiCn4ru
         9Xk2QQFhEyEGCkPF3GRcE5GLBPT5WTTuU1AZyzZqdkrFSVC7qzibYTWmScTbAJ+80VwE
         sj+w==
X-Gm-Message-State: ABy/qLZJPRjx4I2AkofvC+Hg56ehaKTRqr9O7/1HuLMbTm+YRK0eZw3t
	Oc9hjL0I5/orhVQ2ZlXeRNWiYg==
X-Google-Smtp-Source: APBJJlHD6QFq7rMNB+KGBdqcP5NQHt4EfBmeBFQNK2CYYyWBzSCftYAyfr7ps7sa61qFYb64TkY4Cg==
X-Received: by 2002:a05:600c:1d1b:b0:3f9:68f:9c1a with SMTP id l27-20020a05600c1d1b00b003f9068f9c1amr7732579wms.15.1689948473091;
        Fri, 21 Jul 2023 07:07:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g9-20020a7bc4c9000000b003fbca05faa9sm3387097wmk.24.2023.07.21.07.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:07:52 -0700 (PDT)
Message-ID: <3267b625-4597-7658-9faf-800862ca07a5@linaro.org>
Date: Fri, 21 Jul 2023 16:07:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/42] dt-bindings: rtc: Add Cirrus EP93xx
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
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
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
 <20230605-ep93xx-v3-10-3d63a5f1103e@maquefel.me>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-10-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx
> RTC block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml b/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> new file mode 100644
> index 000000000000..63572c197e92
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/rtc/cirrus,ep9301-rtc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus EP93xx Real Time Clock controller
> +
> +maintainers:
> +  - Hartley Sweeten <hsweeten@visionengravers.com>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +

allOf: with $ref to rtc.yaml

> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-rtc
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-rtc
> +              - cirrus,ep9307-rtc
> +              - cirrus,ep9312-rtc
> +              - cirrus,ep9315-rtc
> +          - const: cirrus,ep9301-rtc
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

and then unevaluatedProperties instead.

> +
> +examples:
> +  - |
> +    rtc@80920000 {
> +      compatible = "cirrus,ep9301-rtc";
> +      reg = <0x80920000 0x100>;
> +    };
> +


Each of your file has a trailing blank line.

Best regards,
Krzysztof


