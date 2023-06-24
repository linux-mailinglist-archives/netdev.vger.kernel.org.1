Return-Path: <netdev+bounces-13689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C0173C917
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 10:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F97B28202F
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 08:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1E20FA;
	Sat, 24 Jun 2023 08:23:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012893D9F
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 08:23:39 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD022130
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 01:23:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so543835a12.1
        for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687595015; x=1690187015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iw/ywJG51HUTwkPghusRkjWUXteVCmP/Fv5gaFgQqkU=;
        b=IsOfPPALsc6kgiSVlUoR59ZJkgFCtFF5TGUwt1sbTFoWRMQOqCvWPTIR5S4VBZ7wwO
         U+Tfcj6D2UZWfSg6R9maL5SVaczzgRsCGFn3w3hx97Rmn0RbCb+dz8mN7fo1OhBYO1YQ
         54oNjUFMACNKqmgtbF97PqAckUG/2az/K+ImnC3CequpWgOAVohV3SkCnVPNu1hfXpIY
         qSBKOgbw6rHxDUkAQDvMik5GXkFpd4yw9FALSXz9sR/ZAgWV+QM0FhTv8QIuM4SSMc+2
         /nbK/R/EUUxlTLqExeuaZfJ7NLx2+2g0GulfxjKCtNGXlBg5sxnH4072KmidxffszrB8
         88VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687595015; x=1690187015;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iw/ywJG51HUTwkPghusRkjWUXteVCmP/Fv5gaFgQqkU=;
        b=JrpM2YgM/yNWC6prt0lHqDit42BD0Igy5lHtDuZ1ssL7vn4rC4gBMaaGLiV968tfvN
         ZO4L41zMY0Vy+YoCOi0t50aCQtgdAug2DTi8PyInIjAbvqH6fvxN7ARNcC7TBzY3IJrR
         eFGgGjO0R7HHArSQubRL2ADwUOoop+a/IY+kIE71riDm2MDgrZuQwvC1eo7rbLRcT3eA
         IBGxwM9+fHZG/FVGHPUxH5bMC5CXyHpHtHzpmuFEjSMpQqRRCwf2h4jrTzLG6AduEVYb
         lBgfNWuSWhrzeTLfOp7ZP+8vdJnKsP7QCyN/v345+17YPiJrieUlDA1KLxSu0AnTwEk6
         xgcQ==
X-Gm-Message-State: AC+VfDx6eYC1GjFm0hUyJJXYH6P/k11HZrLe8GLDj4++HsPYKe2J+0ci
	ZAt5E16zy/Bms14jKcj5rm6YWA==
X-Google-Smtp-Source: ACHHUZ43qIJ7DSZr3vq3pOJ8EpVNA3z/s2kop3/I0gBWTVNNyPwlCA/pGa/4aeeS2b9dek8ZmCoz3A==
X-Received: by 2002:a05:6402:550:b0:51a:543b:2c8c with SMTP id i16-20020a056402055000b0051a543b2c8cmr11889190edx.35.1687595015160;
        Sat, 24 Jun 2023 01:23:35 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m16-20020aa7c490000000b005187d2ba7c1sm419224edq.91.2023.06.24.01.23.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:23:34 -0700 (PDT)
Message-ID: <e7f7eab2-7fbc-99ae-641b-075ff0610127@linaro.org>
Date: Sat, 24 Jun 2023 10:23:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 19/45] dt-bindings: mfd: at91: Add SAM9X7 compatible
 string
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
 tglx@linutronix.de, maz@kernel.org, lee@kernel.org, ulf.hansson@linaro.org,
 tudor.ambarus@linaro.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linus.walleij@linaro.org, p.zabel@pengutronix.de, olivia@selenic.com,
 a.zummo@towertech.it, radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
 gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
 wim@linux-watchdog.org, linux@roeck-us.net, arnd@arndb.de, olof@lixom.net,
 soc@kernel.org, linux@armlinux.org.uk, sre@kernel.org,
 jerry.ray@microchip.com, horatiu.vultur@microchip.com,
 durai.manickamkr@microchip.com, andrew@lunn.ch, alain.volmat@foss.st.com,
 neil.armstrong@linaro.org, mihai.sain@microchip.com,
 eugen.hristev@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux-pm@vger.kernel.org
Cc: Hari.PrasathGE@microchip.com, cristian.birsan@microchip.com,
 balamanikandan.gunasundar@microchip.com, manikandan.m@microchip.com,
 dharma.b@microchip.com, nayabbasha.sayed@microchip.com,
 balakrishnan.s@microchip.com
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
 <20230623203056.689705-20-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-20-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Document sam9x7 DT for flexcom.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-flexcom.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> index 9d837535637b..449e0af93a13 100644
> --- a/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> +++ b/Documentation/devicetree/bindings/mfd/atmel-flexcom.txt
> @@ -5,7 +5,7 @@ controller and an USART. Only one function can be used at a time and is chosen
>  at boot time according to the device tree.
>  
>  Required properties:
> -- compatible:		Should be "atmel,sama5d2-flexcom"
> +- compatible:		Should be "atmel,sama5d2-flexcom" or "microchip,sam9x7-flexcom"

That's not what your DTS is saying. NAK.

Best regards,
Krzysztof


