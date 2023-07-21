Return-Path: <netdev+bounces-19841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C475C8F2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED025282130
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166861E528;
	Fri, 21 Jul 2023 14:04:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A291EA65
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:04:44 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F662737
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:04:41 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3159d75606dso1552490f8f.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948279; x=1690553079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0hqft4rLykA1Qm+aWWngJrri1KXMWVHpmrflE+PpLU=;
        b=KzPxa8KXQz5MfDDt2Hr8NCdHH7Er0bPAv4YoqoUulZL1A8MaW/bte3T3bZOaEAFzNk
         w7TwDzBzdkd+MfZmcsSfoFDYZqgPdOWH/zIlJq+LLZ1Vbj5su7wnHbzRpJr6idQpOQkD
         TMXdIAYABzBME16eyIKHrRCF5J5lYTJRHp+a5ylZ/xWp0yyhZkyrV1z8RjyxGweXTwcx
         qKx+GVxwZG1dv3OUuLAHhBNV793Wvoh6bVToxBmIU9Z2bWRRFxoY/A80A3Rs1rQFoqlE
         ykdC2iiTvU9r5XMzHOiUfLIC8odjwnJLl1L7bI4Sv0CIkQSSatzOfTp3PslQcKdZ00Fw
         hnLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948279; x=1690553079;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i0hqft4rLykA1Qm+aWWngJrri1KXMWVHpmrflE+PpLU=;
        b=ShCxz/oQ7mGaWhbiUGce+HyHQq+ZYvDeBLsxgbDheG0TDNPE9rXp0Dg70hVwCrKUCU
         Wqn9JzWtIXhdxzVjHeqSXD3GKklCHOenEZb8jfU/vOale4cgF6IG0YKivkw2bGTIbXAu
         AzNTyltZxB/5vu1ZJRfOISB+AlRtdP+4C2jC/nSQ/kAOLfbF7aCRIfQLGoSjQgBZj3x6
         tSPZb89ulJq5p4Rv7wCLWB6kuPwY/Ufe6QIrT8lsTrrhzCgPKzSig4yRROa409SZ2CXl
         d9pkJTvWVu4AMELzRoas1vKvDvbQh4Sgo1mkblkxK8F2QeFcmol8tdqg5nHDTECT9y21
         8HIw==
X-Gm-Message-State: ABy/qLYPh1l66I7sgIEJ4ku42XfPFj398JR844RpwP83EdCv8TnjBTx0
	0dVhNRa7NeATJwhYzMAdoyDwwg==
X-Google-Smtp-Source: APBJJlEsMYe5JQ+pU4AezELFYdRQHmI7TefsDs6cDm78/h68oOlcICdvW129lDjtJ/t6VHgFfG467Q==
X-Received: by 2002:adf:fc03:0:b0:314:1634:491e with SMTP id i3-20020adffc03000000b003141634491emr1269926wrr.20.1689948279591;
        Fri, 21 Jul 2023 07:04:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x8-20020a1c7c08000000b003f90b9b2c31sm6142028wmc.28.2023.07.21.07.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:04:38 -0700 (PDT)
Message-ID: <5603264e-2efe-48ce-b025-797501f29fde@linaro.org>
Date: Fri, 21 Jul 2023 16:04:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/42] dt-bindings: soc: Add Cirrus EP93xx
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
 <20230605-ep93xx-v3-6-3d63a5f1103e@maquefel.me>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-6-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> This adds device tree bindings for the Cirrus Logic EP93xx.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/arm/cirrus/ep9301-syscon.yaml         | 59 ++++++++++++++++++++++

syscon goes to soc directory. Also, please add vendor prefix to the
filenames.

>  .../devicetree/bindings/arm/cirrus/ep9301.yaml     | 39 ++++++++++++++
>  2 files changed, 98 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml b/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml
> new file mode 100644
> index 000000000000..77fbe1f006fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/cirrus/ep9301-syscon.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/cirrus/ep9301-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic EP93xx Platforms System Controller
> +
> +maintainers:
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-syscon
> +              - cirrus,ep9307-syscon
> +              - cirrus,ep9312-syscon
> +              - cirrus,ep9315-syscon
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +      - items:
> +          - const: cirrus,ep9301-syscon
> +          - const: syscon
> +          - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  reboot:
> +    type: object
> +    properties:
> +      compatible:
> +        const: cirrus,ep9301-reboot

Patch introducing it should be before this one. Also, do not use
different styles for your child nodes. Your other nodes use $ref.

> +
> +  clock-controller:
> +    type: object
> +    $ref: ../../clock/cirrus,ep9301-clk.yaml

Absolute path, so /schemas/clock/cirrus.....

> +
> +  pinctrl:
> +    type: object
> +    $ref: ../../pinctrl/cirrus,ep9301-pinctrl.yaml

Ditto

> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@80930000 {
> +      compatible = "cirrus,ep9301-syscon",
> +                   "syscon", "simple-mfd";
> +      reg = <0x80930000 0x1000>;

Incomplete example.

> +    };
> diff --git a/Documentation/devicetree/bindings/arm/cirrus/ep9301.yaml b/Documentation/devicetree/bindings/arm/cirrus/ep9301.yaml
> new file mode 100644
> index 000000000000..6087784e93fb
> --- /dev/null


Best regards,
Krzysztof


