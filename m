Return-Path: <netdev+bounces-17586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E377521A8
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915E71C21380
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E815F9E3;
	Thu, 13 Jul 2023 12:48:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035C6124
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:48:17 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F252D42
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:47:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so855955f8f.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689252459; x=1691844459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z+Z95kHJar6LgJuF8EaQ4xrWI5fsRo898PQkWtblwYA=;
        b=ZWtafz1E6fk6SAsYpf4lGZD1+nSgipZ/1yHk8BiiBeCPmDYFNw/BHXw8sle+l2vVmS
         HiRfDaiEutO8CKyd/tWcIbzDH68IKAq0P+wq6L3O+yCRnGWEZXF20jAOZurQ/poTKzrb
         g2OnlU1tMldBasNoMoKBcVuVSBCTsyKGMaByUKioVd4KMVuWxyelDtQjMhVnKsq5Iagw
         6P15f+uhPUS8d9HS9De43ANQUipGV+9v29ZgjBforFnnWFgsbssKQyogmv4hd+73mvAv
         lE4BynPqwqichj7yZRCL2JXaPbqySmT8UZO4u9PrfLAkj4WOjTJ+83c7+Pw5b6vArAq9
         /iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252459; x=1691844459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Z95kHJar6LgJuF8EaQ4xrWI5fsRo898PQkWtblwYA=;
        b=dxNJRuMZDohbnGb8KIUxCNB3Hza0rgWk3Gzlvzqylu54U3QwA38HOE64fXcvEmee1B
         pJE3rGjjfzzolQAgj3X7uo4tQXuJkpc00cMwN/wdOtWptduhadrn6NhudKaXTFgZ3GgO
         4041wXmTXwwGuCbDyHoPQhUTdtmlPVSrHnrOlmNZKta7/nYO16AXXsh3ZDDRe4R7twJ1
         pHm1QG+Jdsa2Zw91t7qsILh0CaMutFXZ5xH8UOtwVYu/yPVr7DIkhHQJUiPuHsNecm9q
         Gxi8qD6VtRQp6+nf2szexhKrP2N7orOIqoZIHVNcht0/NkWogkmHEFeX6wnelRxfBfTv
         IzUg==
X-Gm-Message-State: ABy/qLZtiGTLPaAwKx4evd4M7mldSZ/gRi/YCtIJsj5awFkNHG0oMlV0
	Qf8IySOvQO4o49hbgqikJVJoAQ==
X-Google-Smtp-Source: APBJJlFbNLe7S8IsK2vPmgsjbKmKD9UvXXP3v3+dBxQYsKg50wEXZp6DtXoc8BrOfzOVUcWK2M8cHA==
X-Received: by 2002:a05:6000:18f:b0:315:a1d5:a3d5 with SMTP id p15-20020a056000018f00b00315a1d5a3d5mr1544161wrx.22.1689252459616;
        Thu, 13 Jul 2023 05:47:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m15-20020adfdc4f000000b003142ea7a661sm7905018wrj.21.2023.07.13.05.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:47:39 -0700 (PDT)
Message-ID: <cb852190-2128-ee92-ff64-a47bd262154a@linaro.org>
Date: Thu, 13 Jul 2023 14:47:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/15] dt-bindings: timer: oxsemi,rps-timer: remove
 obsolete bindings
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-oxnas@groups.io,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-4-fb6ab3dea87c@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-4-fb6ab3dea87c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 30/06/2023 18:58, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove the
> OX810 and OX820 timer bindings.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


