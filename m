Return-Path: <netdev+bounces-30560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE73788031
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F44281733
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A2F17EA;
	Fri, 25 Aug 2023 06:47:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9CC1C05
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:47:16 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D073CD5
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 23:47:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a2185bd83cso66718766b.0
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 23:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692946033; x=1693550833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+h7Z3AHszYQ/48y7ylXF0wY2H5ct/DzNLRlfXyrhJo=;
        b=IJsglntmLI9Vcjx/NFhD+fRHY4miOVIc4MHlInq15VR4GK0HxPBdrkLk4IPlvZQqTk
         JoDUhhScZ25C5KID7YKJTxGblhQBdyajFPxwijwjkevEDw9znRc/X+X/gp1al4j+XKzU
         ICJSpFzfKqam1JF2gWmTe3dLetXgN3Kj6X37554seFk/vZgwNDL278trkeM28xVkuEX2
         FO3BK4ph3W5jFHVzaEhO0fGFimL3kvu4+Qk2duVZw163RoBfac9yB0db4TZIcMqTpZKl
         WeD7MR0lGUt5aB1Jn5I0uogamYlJW5IX88qYzwd5eb1EXSh1Vzchr7s6zKDGBYKgQGQc
         3MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692946033; x=1693550833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+h7Z3AHszYQ/48y7ylXF0wY2H5ct/DzNLRlfXyrhJo=;
        b=lSCo69ORDOEYBezI7XuClp1zF5P9XnjSTeVG3sVHdmf6ILoI5t5kn/JFAfYRym6CnH
         UJy+AKrpx6428ec1jP9iHuDzuJKTwWB0fJUQgVHDbBIjnnkHI7IF+S4V1R8LQqFL4XzV
         bDQlmpbQ3AgVFgNduWxjbdHS+/fj0TquEX4MtwJDU4dR/BsueR0z7I2nbhUqo3idqcu/
         BB4JPvDgJwWcNHshjIldwaF9TPJCwb6soLYRVhxULL1kCazyFvY0++ssKtSpsp+QdQOq
         9XH9dL8TWBVhxzKgRl5ofFGFjAl0XZFoGGDZFM8LgCCHSO9Wn04SAKgkgZPdeixsZl40
         DzpA==
X-Gm-Message-State: AOJu0Yxyq0wercQ7fgIpu6E3d9GNbdquYiWCB6hSQzmJ5SZo3cCqF38N
	JtUV/tb60daO+VmdU/qJXA3B1A==
X-Google-Smtp-Source: AGHT+IEGZqZgmKNIkyaAo6WLS12bV7qKfdm+d5pIB+2qw4pocaa+Qtl9RMNtvDxlYOPUTHKyZtUXUA==
X-Received: by 2002:a17:907:aa1:b0:99c:75f7:19c1 with SMTP id bz1-20020a1709070aa100b0099c75f719c1mr12244709ejc.39.1692946033029;
        Thu, 24 Aug 2023 23:47:13 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id ha19-20020a170906a89300b00992b7ff3993sm602489ejb.126.2023.08.24.23.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 23:47:12 -0700 (PDT)
Message-ID: <b8b414cf-c425-f322-51e6-c825e58ae6ed@linaro.org>
Date: Fri, 25 Aug 2023 08:47:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
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
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-5-keguang.zhang@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824125012.1040288-5-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/08/2023 14:50, Keguang Zhang wrote:
> Add two new F: entries for Loongson1 Ethernet driver
> and dt-binding document.
> Add a new F: entry for the rest Loongson-1 dt-binding documents.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V2 -> V3: Update the entries and the commit message
> V1 -> V2: Improve the commit message
> 
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 250c43c675cb..f462f3d19e4a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14341,9 +14341,12 @@ MIPS/LOONGSON1 ARCHITECTURE
>  M:	Keguang Zhang <keguang.zhang@gmail.com>
>  L:	linux-mips@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
> +F:	Documentation/devicetree/bindings/net/loongson,ls1[bc]-*.yaml

This should be just one pattern */loongson,* or even just N: loongson,
if you want to cover any future versions as well (not only ls1).

Best regards,
Krzysztof


