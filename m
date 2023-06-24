Return-Path: <netdev+bounces-13687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269C373C8EB
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 10:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3096281FD9
	for <lists+netdev@lfdr.de>; Sat, 24 Jun 2023 08:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA8620E8;
	Sat, 24 Jun 2023 08:23:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D0F17C3
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 08:23:21 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCA51992
	for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 01:23:17 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9786fc23505so133659866b.2
        for <netdev@vger.kernel.org>; Sat, 24 Jun 2023 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687594995; x=1690186995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jOoygUb7kSHIpN5lybNjJ7pb4+07CvDFGFSEAWg/P0=;
        b=ec6K00Eu52RtxLZxjW0JYHaWOW05eAsNVQa3fbURmfvLxhhHUsL/vo+XD7IxNtRePh
         JohCb25+mAcVfKb/YN+guqWWxbVhqnLzklgOO9uFtKw0RFBC9yJxxzNgOi64QyaM424F
         RmiT8u2UwuPuUSUhHwPnSkycYDe+tBDbBvQp175h0ZlO4sGNgoJ9Sm36oSmG+y+1oCJq
         Ugd5MdJ3J7yzVkB1/2PMhMutGJmMM9irNZzcvCrhMFIsCDDstLxTvOX/LT/6WMSzis7L
         OQQHj9eqbdo2ie5+OJ+eMrmXU3Nh/xq85pZkXhCa41L8Y3noqh8aZ2h4igPYT3ZoBtgo
         n7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687594995; x=1690186995;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0jOoygUb7kSHIpN5lybNjJ7pb4+07CvDFGFSEAWg/P0=;
        b=jqWKwlSPmEF/kScljXE8ZMakbShc1C7apAPCxZByiBSLXK6+ebN+dQeCNIzpy9xoDA
         84/M8zz0Q3PlP7KZr69KGzBsaqCVcJykpeDFtWl1Me2EqdebT0dYjiZPLIGg6+veXHKA
         8ZPPaLF5pfoTaUYlELFVokNlRBFkz9THuBeJ5xgKGkxKCpZOOUOHvIe9cIHOj/hjm3iv
         IKmT31t7eYrRh4wW5iLWPy+CN3cz9NV1ueY/ZXLbwil7ifYVJ5kJ2mW4RdgmYo++EoXC
         9jXKb2yh6cYjwf0MO3p2p1g7vgHQkodaunGHkxx3IIZfTWsHwS7ZvPIWHwYdZWvB6lF8
         j1mQ==
X-Gm-Message-State: AC+VfDxMtBidntuIXhrcMD1mi7LZ+y+S8RX0lkEeLrhS1aLsx5zA5YeF
	Fb8etwje8KeKRT38CCegVJ0Eyw==
X-Google-Smtp-Source: ACHHUZ7wgj4gsi8hg4wR0wtrFMRanc+m7UZMBoLi+JkS2EAGQsWnYXwufugaxa43LtT20lkJlSWblw==
X-Received: by 2002:a17:907:72c7:b0:98c:e72c:6b8a with SMTP id du7-20020a17090772c700b0098ce72c6b8amr7272419ejc.10.1687594995603;
        Sat, 24 Jun 2023 01:23:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id qo5-20020a170907212500b00988c93c85a5sm599842ejb.183.2023.06.24.01.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 01:23:15 -0700 (PDT)
Message-ID: <6e95fe03-9e35-a237-0392-8eef9c7e4cec@linaro.org>
Date: Sat, 24 Jun 2023 10:23:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 33/45] dt-bindings: usb: atmel: Update DT bindings
 documentation for sam9x7
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
 <20230623203056.689705-34-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230623203056.689705-34-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/06/2023 22:30, Varshini Rajendran wrote:
> Add sam9x7 bindings.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
>  Documentation/devicetree/bindings/usb/atmel-usb.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> index 12183ef47ee4..6359af0123bf 100644
> --- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
> @@ -3,8 +3,8 @@ Atmel SOC USB controllers
>  OHCI
>  
>  Required properties:
> - - compatible: Should be "atmel,at91rm9200-ohci" for USB controllers
> -   used in host mode.
> + - compatible: Should be "atmel,at91rm9200-ohci" or "microchip,sam9x7-ohci"

That's not what your DTS is saying. NAK.

Best regards,
Krzysztof


