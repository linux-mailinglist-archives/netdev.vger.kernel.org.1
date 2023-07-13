Return-Path: <netdev+bounces-17585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC977521A1
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 14:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E8E21C21364
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 12:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107FDDB7;
	Thu, 13 Jul 2023 12:47:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245C5100B0
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:47:53 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCC626BC
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:47:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so5627585e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689252443; x=1691844443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQ3qFqjqaXg+xhPM/OfBCqCifetSEr6v0qh2wFRe3uY=;
        b=i92G8JKNvparwYPbnBagAXWtkyNe6OrAoGY9MTlkldD3dcYsmXZ3Bt9jlIdwM2BXw8
         y7VwQuUjzVfo2hn/Z4OmMX5D4XvCfjpmVWf0+sN7AhHmbLD1K7WWAcxUskC/EWIteL8z
         pgwUmWYhX8oZBy3/z3S3eTV3rj9qdeF+eLnSaryryK2Fn2XtSu1bcxYL6zRfHFZcWQbj
         o95SzvzKnzTUxrsIQTRwhPZDtDeOX3bI0wN+8BVAJtYu5K496kx8UGOBm5TXXoXPyfxj
         ahgWHaBBmBLhBgcffwYFyZzltxlkgbx/Ofx9KG2EfQV3SNejzzzEUu1cmN1xW095yUcD
         p+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689252443; x=1691844443;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ3qFqjqaXg+xhPM/OfBCqCifetSEr6v0qh2wFRe3uY=;
        b=GKT9yMPyhQH+Y6vqb+QU4CfowdV3H9j9SKuH6Kq42fWmooCAKh3BT+J8E52THbRMCV
         B1+zN6L+tumlKBpDVbAFcD2GSDvM09xJDtvr49zu9hCJD+5Xvicd5h6aXQlKPTt+KOBZ
         gVtct+itCr74usedceq/XKsL1ZiCo5Emp3x9rV8tsUr1E9NCM3eGniue4/RZNbg8YJDo
         7bELQb+2CTBuvHYsGmyCgdW0tmpxqa1vsy+6MABR+G2vzTYbBPu3pj3wCD/mpovwpXm4
         9Y4HYTLU05ht3Lb0ti1oAuGBKJ6usQyR+wz99nY/KBNx6Op8Q5fnZfoEkDxBDG2P19hx
         0x0Q==
X-Gm-Message-State: ABy/qLZaNg72sl3XRRDpnGwnVPX+kXvPJ83wl74xs3pYtpVdKXKJ6XlL
	KJ/FHCeKyP7y+MvxHNI7CIfufg==
X-Google-Smtp-Source: APBJJlFv2JV2cNu6AAcxonI8NW8JRqwtxih4OqWDpmqP+QB4MCgD6qwhTqxWsmWLF+OTALNCxkZ9hQ==
X-Received: by 2002:a7b:cd95:0:b0:3f7:3699:c294 with SMTP id y21-20020a7bcd95000000b003f73699c294mr1277212wmj.29.1689252442663;
        Thu, 13 Jul 2023 05:47:22 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id fa16-20020a05600c519000b003fbb1ce274fsm5488171wmb.0.2023.07.13.05.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 05:47:22 -0700 (PDT)
Message-ID: <2ddb2042-a654-bc60-2060-b21e3acd6f31@linaro.org>
Date: Thu, 13 Jul 2023 14:47:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 03/15] clksource: timer-oxnas-rps: remove obsolete
 timer driver
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
 Arnd Bergmann <arnd@arndb.de>, Daniel Golle <daniel@makrotopia.org>
References: <20230630-topic-oxnas-upstream-remove-v2-0-fb6ab3dea87c@linaro.org>
 <20230630-topic-oxnas-upstream-remove-v2-3-fb6ab3dea87c@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-3-fb6ab3dea87c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 30/06/2023 18:58, Neil Armstrong wrote:
> Due to lack of maintenance and stall of development for a few years now,
> and since no new features will ever be added upstream, remove support
> for OX810 and OX820 timer.
> 
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


