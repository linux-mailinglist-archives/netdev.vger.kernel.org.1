Return-Path: <netdev+bounces-27451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4467377C08F
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA832811CD
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 19:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5055ECA71;
	Mon, 14 Aug 2023 19:17:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F6CA4B
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 19:17:00 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B2B124
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:16:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe8a1591c7so32045565e9.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692040614; x=1692645414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zk52dSLQXvnZfsG9cL2HfOVudu1/6ehfGHh58zQ7WKc=;
        b=WzK+v8D9fBfcGt2l2zHWaJQVsWPb5h+54DMm28xTsegwHgkSeTRz6GpZZld8gZNFpJ
         bz8bhG4r0P0kbyyt1Fv8mToIOohdCD1qPxpbVI511WA25ZcOK9h/TxiW31/KtTy4vVl9
         jLNSz794VBldh4CAUXtaEdaxYKUHhvnKln5SABRePzS1MRgFJu3LG8ZpC1ZICvQvuwBq
         DBOkMklhjN06SmZh2LWKaeULJ3lOpcWPxqgMZVSkUAlcSsNI+coIPF/Ncwm5C7BrGv7g
         YMhU5Dj4rv1Igg0cy4fQTn4vsPV2G8IuuOF+oPqmtI/3iYjckh5aLzXGnBjHt2CH8FJp
         kw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040614; x=1692645414;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk52dSLQXvnZfsG9cL2HfOVudu1/6ehfGHh58zQ7WKc=;
        b=Q/FqUOrC2KfwsWkypfxTI/kHZKZT2SPNk6FchZKXTJV5ZLL5FnkEZzCTrB5G7fivd8
         dogcMQ3U38kOfwCilsk/3G7GCjun8nbfGgpriD6FUtPJemwWVlIryKk00+K8QbReFcwu
         iwCC0tRjIj4kgG30ahAOxwuAwgNsSSOVoo6yAMGpCrJC8rZ5IUC7YbcaqBOigutwao2j
         1uUgM3BoBkRTF5Dj8VeZUC/0LJCcVDlMVgTWcHT81ewYVnfy94BmzI2Zu5WDc9dkyrUM
         KdQmM2Xg5ARO/9al5/XooVW2s4+mT+BfRdUYCJqN6R9VGeP6J7RK1ObxPXbEEe5QfJQa
         bD0w==
X-Gm-Message-State: AOJu0YzatcLHZDW2qcO08N+J3MFGs9dMIFGNDej/6YwWs0JZGNi8Ld20
	WnsgriOhUZotbjoqpUjdtq8Tfxh/rsgsb5JL1/w=
X-Google-Smtp-Source: AGHT+IHjDcPCnZSFZ3J95HmdbzIaL2PJhovvSQpmTT7VnaTH2iV8HA5WTvsuus5E6GYRLw8+/p7wFQ==
X-Received: by 2002:a7b:ca52:0:b0:3fe:2e0d:b715 with SMTP id m18-20020a7bca52000000b003fe2e0db715mr8105986wml.18.1692040614620;
        Mon, 14 Aug 2023 12:16:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c025400b003fa98908014sm18330895wmj.8.2023.08.14.12.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:16:54 -0700 (PDT)
Message-ID: <a24a0b8a-ee97-e440-c67a-df315027075c@linaro.org>
Date: Mon, 14 Aug 2023 21:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/5] MAINTAINERS: Add entry for Loongson-1 DWMAC
Content-Language: en-US
To: Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-6-keguang.zhang@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230812151135.1028780-6-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 12/08/2023 17:11, Keguang Zhang wrote:
> Update MAINTAINERS to add Loongson-1 DWMAC entry.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 02a3192195af..3f47f2a43b41 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14309,9 +14309,11 @@ MIPS/LOONGSON1 ARCHITECTURE
>  M:	Keguang Zhang <keguang.zhang@gmail.com>
>  L:	linux-mips@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
>  F:	arch/mips/include/asm/mach-loongson32/
>  F:	arch/mips/loongson32/
>  F:	drivers/*/*loongson1*
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

Since you do not add dedicated entry, just squash each part with commit
adding this file.

Best regards,
Krzysztof


