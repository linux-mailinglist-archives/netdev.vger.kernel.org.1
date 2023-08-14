Return-Path: <netdev+bounces-27260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06477B3BB
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CBFC1C209B9
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 08:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470369475;
	Mon, 14 Aug 2023 08:17:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD2F1842
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:17:17 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C9D10F2
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:17:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31969580797so1618425f8f.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692001034; x=1692605834;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e3CFhGYYBnmc/7BGz71n+APKSrpv4uhL75vkasqQJ4o=;
        b=iQkwPbQN3DsEDOtJk3CJaT+avcrhQmZRMrmuydv4HhzxFDJqxw9vGX/2VyMkUMA1wL
         jk+ff37u88MZw/dBof5+1vAQrQoUsZRVs3rlTi0p0x633eGOAj0RobNrihc/vuOa7pHG
         6eAH/89w+vFWZOFZKuerCFUtKJltGh7FmZ8pO7PYlqTZ0a/VC8XtnkggkA2JAFhJv0Bq
         XuPNI1tM13nTx7WnwNrHP7EJRu30NfUNL14KiE7pfsaKcQNbGHrbWnb6HNFNCHTwS0HG
         GcFhASxwqz+vqOX7V/nyAXR1aQ+K6hWKSIyZVhA20KJfGBBz8iVnsEyNGQ2cl706sOdd
         157Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692001034; x=1692605834;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3CFhGYYBnmc/7BGz71n+APKSrpv4uhL75vkasqQJ4o=;
        b=fkvz+4OFQ7t3yygLaz4j3W9FHfnU/g9FYQ0ab0TtqE79jqfZb9vQxXv5tJ+IhSPTve
         at5bh5pmQ1bYdkOPYXwH89x/pWhNz9LOhk3RWBOgSXgGaA6HFp4SgyDfkcouN7w45SD+
         yPTuVeIbJsAGrguITDZsi+wbdQ9A8L5oyN+DE4k5hyy1DYqOsXWGbw3lK1AWx3d9ieW9
         y1ImUMkQ6AONBaEVBlB7b4idQFonXShhdcsvRBEIqEmxuSlRhgG/rmoMJapthHTzYX79
         bkC9pnkt9xoRVEsQMr+ETGgGmJholW3mzvgi4MxdkdIkLNNKz4SZ3vzsmDrp7mbEKLar
         oFNQ==
X-Gm-Message-State: AOJu0YxEvVo3alunizf32xEU4xx+w5ZDsKxifb3hg2+aFcNZIz5OtkhW
	4GbeHxIQ4PNj3icGs/9c4cosEQ==
X-Google-Smtp-Source: AGHT+IEXbvgn6LW0yU+nkhHkcfkiCGwjUBAMcP+fKEDjyEF9E2V8kNEM6NVC/BjPKkIdX0hZ6fKCKg==
X-Received: by 2002:adf:f24e:0:b0:319:7b50:cf5e with SMTP id b14-20020adff24e000000b003197b50cf5emr880096wrp.19.1692001034196;
        Mon, 14 Aug 2023 01:17:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0? ([2a01:e0a:982:cbb0:a3d8:b217:d82c:9bc0])
        by smtp.gmail.com with ESMTPSA id x13-20020a5d444d000000b00317f29ad113sm13580045wrr.32.2023.08.14.01.17.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:17:13 -0700 (PDT)
Message-ID: <ff999018-8490-0f58-0a50-e82f1effce5c@linaro.org>
Date: Mon, 14 Aug 2023 10:17:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 09/15] pinctrl: pinctrl-oxnas: remove obsolete pinctrl
 driver
Content-Language: en-US
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Andy Shevchenko <andy@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mtd@lists.infradead.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-oxnas@groups.io,
 Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-9-fb6ab3dea87c@linaro.org>
 <a9074f2d-ffa2-477f-e3b5-2c7d213ec72c@linaro.org>
 <CACRpkdbMy=JWAgybtimQXJRQ7jsVZ1g-DfqjryjP31JT9f=Prg@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CACRpkdbMy=JWAgybtimQXJRQ7jsVZ1g-DfqjryjP31JT9f=Prg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/08/2023 15:44, Linus Walleij wrote:
> On Mon, Jul 31, 2023 at 4:44 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>> On 30/06/2023 18:58, Neil Armstrong wrote:
>>> Due to lack of maintenance and stall of development for a few years now,
>>> and since no new features will ever be added upstream, remove support
>>> for OX810 and OX820 pinctrl & gpio.
>>
>> Do you plan to take patches 9, 10 & 11 or should I funnel them via a final SoC PR ?
> 
> I tried to apply them to the pinctrl tree but that fails ...
> Could you rebase patches 9,10,11 onto my "devel" branch
> and send separately? Then I will apply them right away.

Sure, sent them right now!

Thx,
Neil

> 
> Yours,
> Linus Walleij


