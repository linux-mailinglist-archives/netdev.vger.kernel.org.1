Return-Path: <netdev+bounces-13665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA31073C791
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 09:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9499E1C2137A
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2074A45;
	Sat, 24 Jun 2023 07:53:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66210E8
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 07:53:40 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD862950
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 00:53:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-988b204ce5fso163649166b.3
        for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 00:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687593213; x=1690185213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d0dU3KHDoF8oZzutBDKpvFK9O6jXuVzZS7UeXmnvOCk=;
        b=qL+14ZF0SFDS92k57he/MqJcbZWj42LI8iTDe5f6UYIF6jj69Jgr0nJO9ZKFef0TUo
         97WraEyayeMo+lJuOUrJK7R4eJVDqCzjfRmhLG3P8cyutMpOzOWG/lQIHosPAX4ha2E9
         zMU/72ZWCKk3PZdPbJDC10ZHfV68fkWiuDOPnvDrzAWl4ttHZ/GP3O4Ox1Q1s9xdYpYS
         2KSNZFsLSyFMd/9XzPC8BdcOaV+EvQg7dZxPuDxO7s3T8cuSuKYXpGtE7vaH7AQxM9f4
         bJAsKHAKvYjav2XjXHTrmIboFnd594b8tp61wr6olfTnGaBDiPapYgy5Df8wNpjx/XnY
         9F1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687593213; x=1690185213;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0dU3KHDoF8oZzutBDKpvFK9O6jXuVzZS7UeXmnvOCk=;
        b=QlF+Av68NMH8ThQZD6FVtkK67LAsvED/PTH+QPsju55FSVaXaqN5W/40gQHENqICSF
         KDnaya74Z75MXRY4p/FPeatPsFm5qTRbzS5YDPdPyoaJ19P5F5xEcclrgAou76QoAdPz
         DUnUx8/UbTBpM/uGDoYLC67pO9eRMIXZtkB5mjqU34XgB0kYoJU9cxRl1C5A9XAjy8X+
         qZq5cTAyo5hvej101E40bGTckpSqfPrDWDUsny98aPcMANfOuEjatC4TBQHU6q2WfGli
         QJaqIyklbGQEFk4D0ke65BfJVjRIUKllMaeVmaXawGX2cB22gEMJyIrdCzcqGcI6eqN7
         u7eQ==
X-Gm-Message-State: AC+VfDw0GaWRyHSh4AaH9VdWqAk7lxqhRqD6FjTJLUy6Db0LmlGyYeqk
	s6Rd1kcVcrFhlV0hIHzfOY2EBQ==
X-Google-Smtp-Source: ACHHUZ6rxF9D2gin1FtwSBjnqHQU40ChmXYOoZkfDSe/Nou9AC2VX7R26o19SB77+MsKurZ8l61ESw==
X-Received: by 2002:a17:906:7a19:b0:98d:b73b:b5f2 with SMTP id d25-20020a1709067a1900b0098db73bb5f2mr1706603ejo.71.1687593213726;
        Sat, 24 Jun 2023 00:53:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id g25-20020a1709064e5900b00987e76827b2sm602028ejw.53.2023.06.24.00.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 00:53:33 -0700 (PDT)
Message-ID: <8574bbcc-2dfd-3fed-ff4c-cab1f6e79f7b@linaro.org>
Date: Sat, 24 Jun 2023 09:53:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 02/45] dt-bindings: usb: ehci: Add atmel
 at91sam9g45-ehci compatible
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
 <20230623203056.689705-3-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-3-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Document at91sam9g45-ehci compatible for usb-ehci.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof


