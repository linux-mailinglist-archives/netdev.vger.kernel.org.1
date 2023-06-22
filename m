Return-Path: <netdev+bounces-13066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1C73A142
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3C9C1C20AD4
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762C1EA7D;
	Thu, 22 Jun 2023 12:52:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE41E522
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:52:55 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BC61BF9
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:52:52 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51be61663c8so974365a12.2
        for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687438371; x=1690030371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJn4qK5D0/zBLT8ePA8blzrHlwW1q+g3bf+ZWr4iToU=;
        b=n8kXF96Ou8tJCUZABlfYEiawtFnTorpd6T6wVvKKTS9oU8/wRhv59tqvt+uvAkNr/I
         0wmEqgx6EfnyZV9KUDTjS0YydCVrbGsC1dsZRImLRa0O9dsqeT1RrbG+YDObVXyStten
         2Xhwa00KD+H3SaTiQevquHYXLwCcP3kvSULg2frdOi1Q0l54/zm0MMd0cJ/KIAIYANOT
         obZpyacfm+blrmEvwXYTTtE1u016ho2iADX/o0dl1VV5apDMd0oqmeSxNa2PnnhR4iJY
         bg0mi6k6XBpbTiBjnEU3NiJhMzbwcoeRn3WyNinJdFigx5QvQQ9G0E/z0jLJsSOfvmZC
         NdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687438371; x=1690030371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJn4qK5D0/zBLT8ePA8blzrHlwW1q+g3bf+ZWr4iToU=;
        b=Rw08BJ25MtDQWdQlfXfQWMAdUBTRV4Rw0L0wyS6PDcJfCLjxx1WYixQ+5yRPDdtpDh
         iOG59T3UbDAiDVQYDndfEt9XUKVlzBM2c0Jn/beqgReAZ/cz2b3fPRky8fMpNpuiC6cb
         W/P5mg8AZJzg7CwGB3iAaMW5LPjvCk6vDnLXPSJx5oOufAu2GFplflzDGISXWJ0uuTXy
         BeAtr6HFsGPKRxnhp4YtThz4tzqR3kKIQH3EX8V1P0cthKqb64fx4hnypBDZmjwHv1/h
         KgksFRcFoug3RwM78kYZJMxSy7f2PPACWdoWUK3xamPY6VxBtRuW8gkzN+Zqu6XngbIs
         ewGw==
X-Gm-Message-State: AC+VfDykMhJ1GOXiUTdL8a+36jFGcf86mNVoa5hwwfVYa8DsCMGGIYPJ
	xC0OnnEyNTkBvtuJ6qAZXkFSwg==
X-Google-Smtp-Source: ACHHUZ6BL7cV1ab79Z1DXqI3js9EbbIJO29PsCcID0NCQKXDLIPdAJcdnDuaLOt1M2ocx9LetkrqQg==
X-Received: by 2002:a17:906:9b88:b0:988:91cb:afd1 with SMTP id dd8-20020a1709069b8800b0098891cbafd1mr12407657ejc.29.1687438370948;
        Thu, 22 Jun 2023 05:52:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id x14-20020a170906134e00b009828e26e519sm4559218ejb.122.2023.06.22.05.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 05:52:50 -0700 (PDT)
Message-ID: <e2cc150b-49e3-7f2f-ce7f-a5982d129346@linaro.org>
Date: Thu, 22 Jun 2023 14:52:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/6] can: tcan4x5x: Add support for tcan4552/4553
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Michal Kubiak <michal.kubiak@intel.com>, Vivek Yadav
 <vivek.2311@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-6-msp@baylibre.com>
 <32557326-650c-192d-9a82-ca5451b01f70@linaro.org>
 <20230621123158.fd3pd6i7aefawobf@blmsp>
 <21f12495-ffa9-a0bf-190a-11b6ae30ca45@linaro.org>
 <20230622122339.6tkajdcenj5r3vdm@blmsp>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230622122339.6tkajdcenj5r3vdm@blmsp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/06/2023 14:23, Markus Schneider-Pargmann wrote:
>>
>> Yeah, but your code is different, although maybe we just misunderstood
>> each other. You wrote that you cannot use the GPIOs, so I assumed you
>> need to know the variant before using the GPIOs. Then you need
>> compatibles. It's not the case here. You can read the variant and based
>> on this skip entirely GPIOs as they are entirely missing.
> 
> The version information is always readable for that chip, regardless of
> state and wake GPIOs as far as I know. So yes it is possible to setup
> the GPIOs based on the content of the ID register.
> 
> I personally would prefer separate compatibles. The binding
> documentation needs to address that wake and state GPIOs are not
> available for tcan4552/4553. I think having compatibles that are for
> these chips would make sense then. However this is my opinion, you are
> the maintainer.

We do not talk about compatibles in the bindings here. This is
discussion about your driver. The entire logic of validating DTB is
flawed and not needed. Detect the variant and act based on this.

Best regards,
Krzysztof


