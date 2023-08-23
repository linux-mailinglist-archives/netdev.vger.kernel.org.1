Return-Path: <netdev+bounces-29947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04645785539
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 12:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317B71C20C5A
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88853AD4F;
	Wed, 23 Aug 2023 10:17:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73430AD3D
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 10:17:30 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330F1CDF
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:17:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52a1132b685so3542200a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 03:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692785793; x=1693390593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PkhmhhTWHkeRQp2PPUUxTCXWp1T0OTe7aVdp4fg5upo=;
        b=LO6EWlz79jJJ9v/UQCg4OZKmPJO9+j6QHM1tngs1xZjP73VY2yTNyozqbCEjmHkgOJ
         /I25kU9siRPAlFrz9dpUhrfTb7C4hK1nJcapsvmczx4ZFMRu+Id4skeNROqiKQ5j7fC1
         ZyyN0rEkpFnovXZ/Y9YFpI+20NzFPUlKW8oib55lhQS8AfgOyDR1cSStWeGIk4mOE/f8
         e8jk+ITZo8/vSFO72g6rBQt9NS7/HQQrfF/hlcYS6bEX+Ay7j17UK9K0sHHCYLh/aFQD
         moxfheS5gy+jsjw+9CZRAFxsIYJOD76OVSKpIkrcpc8QGv+VCkZ89LVZ+6AtV/ge1cjC
         e99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692785793; x=1693390593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkhmhhTWHkeRQp2PPUUxTCXWp1T0OTe7aVdp4fg5upo=;
        b=M32CV9jaJcaAJWc0ztX5p9B7mT7QxTs1FbhQ3H5w2ln/mYY88K0C4a3kW5g1AeQ195
         cY1Utvtl/jrj3vGZVgX7/qVCEm1U+KB9+eYkE6g69O/uhC7Zlwo11rU61lkYoKYCgaea
         wBswBUe1oRv6o9pjDxn4Lpc1CubBpfWL1lM+xGXdlukYF+aCYq9z6HZC1PoGiKSTTUUJ
         rbedFA9Mnpq+aeDajxGKIHTXaVWjE4zvE9hammCWrMC+omoaLw+5peSjQ0AMdF8SKRxi
         L2oNrrZDP/kevgD2xPo+WrmvepusciApv/VnMU15F1+6OTvU8H92ZOtpSb0BkAVXrtkj
         X4Zg==
X-Gm-Message-State: AOJu0YynVT2rKcJhoExWdWJCzOoDrRvbp6hmslu+SFtYTdDaj91JtvQU
	7NhhLOhrTnt8lK1Xr2jto3oOIQ==
X-Google-Smtp-Source: AGHT+IG4cl/3Fz/QSS2cl3WXZt2VKfaSb/kNTKY6FTxfUyaMgKaOK/vEjbIWyu1Ae6CwwBgVchcQyg==
X-Received: by 2002:a05:6402:1614:b0:522:1e2f:fa36 with SMTP id f20-20020a056402161400b005221e2ffa36mr8763754edv.28.1692785793520;
        Wed, 23 Aug 2023 03:16:33 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fc0f000000b0051e1660a34esm9063699edr.51.2023.08.23.03.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 03:16:32 -0700 (PDT)
Message-ID: <61b9e036-7864-65c6-d43b-463fff896ddc@linaro.org>
Date: Wed, 23 Aug 2023 12:16:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 29/42] dt-bindings: rtc: Add ST M48T86
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
 <20230605-ep93xx-v3-29-3d63a5f1103e@maquefel.me>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230605-ep93xx-v3-29-3d63a5f1103e@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 20/07/2023 13:29, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Add YAML bindings for ST M48T86 / Dallas DS12887 RTC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


