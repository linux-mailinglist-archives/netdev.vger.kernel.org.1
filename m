Return-Path: <netdev+bounces-19839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AEC75C8D5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5872282246
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8EE1E524;
	Fri, 21 Jul 2023 14:01:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE91DDDD
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 14:01:49 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BE530D0
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:01:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3144098df56so1687286f8f.2
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689948104; x=1690552904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGZ5LqU0Zryf5RXxHBpf5dofqREFTyZTeFWlFYPBfA8=;
        b=ZiVB2hHSTZRmiaMmbMREaMhbawMx/KUt3cg1qeF1gBfCQQAGIBGPHjWK50hX362tpU
         fMapfTUkHNiMW2EcbBz3SgWGkAp6pnHxDhqm4HHqfVuIIfYvxWb4ogcWbai4vpYhJADI
         nWulY7lsgECJ57xXy/eajLo129aMmkczTVRAjkIe0wiSagmvvtOEMM8dttszF+P0remm
         RGTV8zYGxv0/wyu9CCIL2fyYMd0tbEu3edlaV1yZeI84Bkx+jEwwKA/R03nUuupkA/DL
         bFjJcVPJ1Os8KPfwF5c406w0MGIwcfg3il9N5GJ9UXq+jvImjTaQ3Zov5AQGHQM9OcQ+
         H5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689948104; x=1690552904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGZ5LqU0Zryf5RXxHBpf5dofqREFTyZTeFWlFYPBfA8=;
        b=HwNHR/i5xz9xp45g7uUM8GPaFmOKRSX98F+AyXE8Wmdl99ZjIN8FTYnHLcVvItFa1N
         +8YRbQluOM8sSuA7JrmnwdwMQk0tZv2UbN045TeRgodfMuqQar9TPMrSILV3XOQ7vI1U
         vrqP84Pbg+ZcThHPtQjVNikOuysLV4upqlzXBAP2AC8tihfr70/Fzn+vM0kCuCJ5UnuX
         V70/1Wt6Dlvv+1Vv2mMsyQfNIo+VUSItHyt67GS05nVCXLW3g3eVJ9d4ibYrKk+zyvY1
         Y9XtEJz/jPrxEy4DvIPE/l3CBGgjbtgy3GsUq4aBJOZdOjqqZn/eCvNTzpJk09JQGyDR
         +o4w==
X-Gm-Message-State: ABy/qLaQ8mfEMC6gBlHcJU8TlsMX02g6KTDhoCpBDj9knZG10oohQWwH
	CS3DAJZvAKExYUyvL4BwVNe5rA==
X-Google-Smtp-Source: APBJJlFl0X021T0an8cBRN2rsT+BJ+nZ0MYlRyFEpg2gd2RFuh46KGFuFZP+LfRCosw99RkgkE80Jg==
X-Received: by 2002:adf:ea50:0:b0:314:2732:e81e with SMTP id j16-20020adfea50000000b003142732e81emr1636390wrn.8.1689948103685;
        Fri, 21 Jul 2023 07:01:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id r5-20020adff105000000b003145521f4e5sm4278545wro.116.2023.07.21.07.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 07:01:42 -0700 (PDT)
Message-ID: <66fba798-c6ef-1105-656a-5d593a056448@linaro.org>
Date: Fri, 21 Jul 2023 16:01:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/42] dt-bindings: pinctrl: Add Cirrus EP93xx
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
 <20230605-ep93xx-v3-4-3d63a5f1103e@maquefel.me>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-4-3d63a5f1103e@maquefel.me>
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
> Add YAML bindings for ep93xx SoC pinctrl.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/pinctrl/cirrus,ep9301-pinctrl.yaml    | 58 ++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
> new file mode 100644
> index 000000000000..d5682531b0da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/cirrus,ep9301-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus ep93xx pins mux controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-pinctrl
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-pinctrl
> +              - cirrus,ep9307-pinctrl
> +              - cirrus,ep9312-pinctrl
> +              - cirrus,ep9315-pinctrl
> +          - const: cirrus,ep9301-pinctrl
> +
> +patternProperties:
> +  '^pins-':
> +    type: object
> +    description: pin node
> +    $ref: pinmux-node.yaml#

You need:
unevaluatedProperties: false



Best regards,
Krzysztof


