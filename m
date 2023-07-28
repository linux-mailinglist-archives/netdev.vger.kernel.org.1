Return-Path: <netdev+bounces-22255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E677766BCD
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9F31C2186A
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361E2125DD;
	Fri, 28 Jul 2023 11:33:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC3125D0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:33:03 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DEA3C0F
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:32:57 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3178dd81ac4so412662f8f.3
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690543975; x=1691148775;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bvt6gTVxDn+2sUGsn1CSbJgPH86R0eTVqQfCu4TXUDo=;
        b=ihYG/3HHPl5FBpQ+akutSxXPgMXuWO0DzvVRM1SksGA8Z6z6pOdw0xIixvMEZJwJcd
         4Z9oCv17ECKWSDIarWP03zMzkLYWgMwcwhoxSSaT5GUpRNxEjtRo4EY8oOokfuAmg2K3
         X3bV9VHSl8t4uwTz1mse0RuhyVeDc9KRKdziDQTXDWRDJdS8WyXvQtCDSSpsLP63bbdW
         cOiiI52GZVUebGyMsG2X5E6fYT0OIJFnxGAXUetZKDydkrF3Wl2/fb0Wxp0Z75TVQh6T
         giWorb/o+3LTFwvzrenWwbszz2vm7NxrLdr+hhPHn+acqPkmYagZ70swmgFq3rn/3E7w
         YSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543975; x=1691148775;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bvt6gTVxDn+2sUGsn1CSbJgPH86R0eTVqQfCu4TXUDo=;
        b=Fywk29sHdcln4eL+QI+p33TDyLPOivkRG2A7z5w32QoHWBXTZzxRBsd2VuLMrkLHXV
         szL0wnOSVzj83GEW9jmswL8HeMIRUBnGQmZNgabc/j2SUeCxcZDTXnXeoL4XptrBd69l
         vWb8wRHj6a+sBwezs1RNq1KcUvSX9peJsDhwoYNkdKLTJ5RDsgB6MLCXHPjkHcy1KOWr
         DTSDVRioP79BqLaGARp96yoFWXIEr13Rh8yUuF4GN3Oj5Be3m1GOto9X7r8N8O7k7Nq4
         tkrJ7BpTK+DuQlofol0BFM3d6KPrK8lWBfGoFsxEUTZjiW57pZmtDsb0EwmKwOBmTGZu
         uETw==
X-Gm-Message-State: ABy/qLaT+3WVLDbdrsmm5WF3oqi1dWvZ2t4LRxrNSr7dV0vwVhHLM3XD
	O3nQkCSs5NriLxd4fxq8Tkbt1w==
X-Google-Smtp-Source: APBJJlGzFqci86oHnzgj2vDsZF3+rlLFEk6DPLtkPGOiNL5NezUh1WtcFdshRpGeLkVsg8nMnAV0bg==
X-Received: by 2002:a5d:554b:0:b0:317:6816:578c with SMTP id g11-20020a5d554b000000b003176816578cmr2003464wrw.5.1690543975603;
        Fri, 28 Jul 2023 04:32:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y8-20020adffa48000000b003159d2dabbasm4575839wrr.94.2023.07.28.04.32.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:32:55 -0700 (PDT)
Message-ID: <75fb91cc-e505-7aa9-b90d-0b4d5c643b69@linaro.org>
Date: Fri, 28 Jul 2023 13:32:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 00/50] Add support for sam9x7 SoC family
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, vkoul@kernel.org,
 andi.shyti@kernel.org, tglx@linutronix.de, maz@kernel.org, lee@kernel.org,
 ulf.hansson@linaro.org, tudor.ambarus@linaro.org, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linus.walleij@linaro.org, sre@kernel.org,
 p.zabel@pengutronix.de, olivia@selenic.com, a.zummo@towertech.it,
 radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
 gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
 wim@linux-watchdog.org, linux@roeck-us.net, linux@armlinux.org.uk,
 durai.manickamkr@microchip.com, andrew@lunn.ch, jerry.ray@microchip.com,
 andre.przywara@arm.com, mani@kernel.org, alexandre.torgue@st.com,
 gregory.clement@bootlin.com, arnd@arndb.de, rientjes@google.com,
 deller@gmx.de, 42.hyeyoo@gmail.com, vbabka@suse.cz, mripard@kernel.org,
 mihai.sain@microchip.com, codrin.ciubotariu@microchip.com,
 eugen.hristev@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-usb@vger.kernel.org,
 linux-watchdog@vger.kernel.org
References: <20230728102223.265216-1-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102223.265216-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/07/2023 12:22, Varshini Rajendran wrote:
> This patch series adds support for the new SoC family - sam9x7.
>  - The device tree, configs and drivers are added
>  - Clock driver for sam9x7 is added
>  - Support for basic peripherals is added
>  - Target board SAM9X75 Curiosity is added
> 
>  Changes in v3:
>  --------------
> 
>  - Fixed the DT documentation errors pointed out in v2.

That's too generic. What changed?

Best regards,
Krzysztof


