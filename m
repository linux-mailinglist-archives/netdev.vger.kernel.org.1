Return-Path: <netdev+bounces-19838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD6F75C8C4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC3E2813F2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0661E522;
	Fri, 21 Jul 2023 13:58:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800E1DDDB
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 13:58:51 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5373B3AA0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:58:29 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso3285054e87.0
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 06:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689947907; x=1690552707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uoi5Y4jjgnWGfQC+MA3PSzDO/nJ69a0U86XqjtM9qm4=;
        b=hovoUSXRq28HNft26oRNivk53rfhvkFzFlsE+3eJGaPu6W9o4Hh4e/ClQ4euEk52Lc
         Ek5BSaAroh2dCUY6scEF0qTX6SJCRLeM3gAKGHAwhgN2TXx3tl8zBKhqZNypY/tWkFHc
         oe7SRYPVtulOU518is+mkTPudusWNGrbXpmSCwGn9SIS+3Qdck423+6xju48zvzmYRLu
         SrCXzGzyT5RKNGORyZpIV27gIbAKSA970kJAUEzrStzCaI6yIn2cD69S96IGPnLOrWz9
         MC4iNZlM1SAONUv1Jf8RdW+s5o5HTVZUOtOFBP3reutBNZI02r+6aCCx7r231ZzUbq/y
         Rnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947907; x=1690552707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uoi5Y4jjgnWGfQC+MA3PSzDO/nJ69a0U86XqjtM9qm4=;
        b=Cr7NXHr2Z0KXadcP4KX0kDvtiGZZPlNqNlZq2RChcNxBeLkZls1fBFkByHnWC0jbQN
         nQ8AaZTrqZZLoZHv4I47OTs9dvDkvstGQDlWZJgTNB+HmOhY1rL2zcZtmfXzp3PyVrr4
         8TBZOrmXMH9a8tyI/ecBgyPj0A6NqYuWw/UrLY7vASEq+J60zevBC/jG2u5OaMAMIdFk
         awHstduW1SKDgeclD9CGedxbIVE+ncWZ7XnYGPnO8VX7AZv9yKvKxouk/eoaDpwW0cmP
         OLcL3esYBDrVB3jLX1fplIq0lDEVzmk7ygQn5qvqArBu5yWStm/0AiFW9DVeQrXCLgUj
         A61w==
X-Gm-Message-State: ABy/qLZxuNHZSAzeIWyVJq4PTI6xuIYKJmCJISQqCECgeBr+Io4hPMLA
	zYimTnysC5QMiZZ+GSpZ50CIhg==
X-Google-Smtp-Source: APBJJlFJQPGeO+dM+/CogGYGFX3IbIoIu/R+CmmEzNoP5XS6uM+gVvd5Uqi6hxrOAM8nRxnGkKL4wA==
X-Received: by 2002:a05:6512:1095:b0:4f8:cd67:88e6 with SMTP id j21-20020a056512109500b004f8cd6788e6mr1382568lfg.44.1689947907244;
        Fri, 21 Jul 2023 06:58:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id h15-20020aa7c94f000000b0051d890b2407sm2111001edt.81.2023.07.21.06.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 06:58:26 -0700 (PDT)
Message-ID: <53c26a74-3374-cbc4-57cf-3b1cc0904300@linaro.org>
Date: Fri, 21 Jul 2023 15:58:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/42] dt-bindings: clock: Add Cirrus EP93xx
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
 <20230605-ep93xx-v3-2-3d63a5f1103e@maquefel.me>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-2-3d63a5f1103e@maquefel.me>
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
> This adds device tree bindings for the Cirrus Logic EP93xx
> clock block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/clock/cirrus,ep9301-clk.yaml          | 46 ++++++++++++++++++++++
>  include/dt-bindings/clock/cirrus,ep93xx-clock.h    | 41 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml b/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml
> new file mode 100644
> index 000000000000..111e016601fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/cirrus,ep9301-clk.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/cirrus,ep9301-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus Logic ep93xx SoC's clock controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-clk
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-clk
> +              - cirrus,ep9307-clk
> +              - cirrus,ep9312-clk
> +              - cirrus,ep9315-clk
> +          - const: cirrus,ep9301-clk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    items:
> +      - description: reference clock
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clock-controller {
> +      compatible = "cirrus,ep9301-clk";
> +      #clock-cells = <1>;
> +      clocks = <&xtali>;
> +    };
> +...
> diff --git a/include/dt-bindings/clock/cirrus,ep93xx-clock.h b/include/dt-bindings/clock/cirrus,ep93xx-clock.h
> new file mode 100644
> index 000000000000..3cd053c0fdea
> --- /dev/null
> +++ b/include/dt-bindings/clock/cirrus,ep93xx-clock.h

Keep the same filename as bindings file.

Best regards,
Krzysztof


