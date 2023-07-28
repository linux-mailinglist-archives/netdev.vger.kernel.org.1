Return-Path: <netdev+bounces-22254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC09766BC0
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA39282577
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342F6125DC;
	Fri, 28 Jul 2023 11:32:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709EC8C9
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:32:22 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F0A30F5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:32:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe078dcc3aso5614175e9.2
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690543937; x=1691148737;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+F++azjWGXR/zzwHylDS5zKIIkHfazjhU13uoVBCItI=;
        b=AMnkE9WuW7Szt2FbkP+Jy7gImGXicajY9/8nwcsWkrUwhvEUvP7ntHlB4esXk3K8U4
         0i6OvKn+5MRV/VvX72hQyI3+TxZnb6cRN+AlFwW7eoAEroux8iHcBnUojCtWchKA78jl
         SY5zsDpCGe7jFTiAVJefedCk62+1uRl1DCOGCwjHw3AcI7lBvwuS6yZmpan72Z124GkA
         HzuwDVmYWrxvejLrwD5DxuP7Te8Jagm+rkOkbxUiWNpEVTWGGoMyhL+3cuwlWbXGDr0B
         nKgA+tN0Fx8WjnGsZEpQTGxaPoJXDju/pS2BVUhj93heIIMcoWmwxaaXx1t90HNC7HAh
         LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543937; x=1691148737;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+F++azjWGXR/zzwHylDS5zKIIkHfazjhU13uoVBCItI=;
        b=U3LlX5rs2f0Q7ji9a0sNchb+onVz7FzbkAjOn2E14b2BqjFYThtL1Yh6VpDEX5nADi
         2y2PlyYJC1GGgcqX0ac/RJRBAz5OMJ4kltAHpSkyV5e+z7EQlIWge3/oXf2BH1CfdXME
         xVEBfP8PBdzxKLWXhGEQqsTlNoH29yTWuHxYDqXqRDBKiFtWZdPe6I8fOvZ4VpvMww2+
         TD/hGQ15SjrIm+51iwXQvO+IXZMkL22AdAFGUL6hY6CJLAAryMFy9YvppUZkGKbC+qMS
         usyMnrfrWdbOgnlkMTbMdrqWdXxoovRMx1UdvKbfAmDZwW2xVuPHxm6ReyCtIfLJC89J
         F4YQ==
X-Gm-Message-State: ABy/qLazpxq/3N/KMZau43en/kXeHpcfeA0AtND5WEHJBkE+bhrimONh
	Tx7TeOz7ros93kj9NxlB2DqbDQ==
X-Google-Smtp-Source: APBJJlGEkskLn7KheQI/2hh6B8RIJum6fk3h7Nk91C/s4cct7x2FxIqw26uj1lGmelJK6ucVYjt8Ng==
X-Received: by 2002:adf:e94f:0:b0:314:3611:3e54 with SMTP id m15-20020adfe94f000000b0031436113e54mr1907446wrn.9.1690543937250;
        Fri, 28 Jul 2023 04:32:17 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m14-20020adffa0e000000b003177e9b2e64sm4508524wrr.90.2023.07.28.04.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:32:16 -0700 (PDT)
Message-ID: <c0792cfd-db4f-7153-0775-824912277908@linaro.org>
Date: Fri, 28 Jul 2023 13:32:12 +0200
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

Your threading is absolutely broken making it difficult to review and apply.

Best regards,
Krzysztof


