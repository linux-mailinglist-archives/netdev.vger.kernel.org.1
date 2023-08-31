Return-Path: <netdev+bounces-31524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F6478E881
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 10:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81402813FD
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 08:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279F79ED;
	Thu, 31 Aug 2023 08:41:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B8579C8
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 08:41:11 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309BE1A4
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:40:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52bca2e8563so631884a12.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 01:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693471248; x=1694076048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4oj9ZHh9uIvpj0ERp23NgRxjtB8A/WDYvtNWK07v2zI=;
        b=GN31XdmsfylTAo9cekW7yHl9SPIoQSERRZqVvKX9ghQGtgDJrGlRz72VEqdZXW6KCD
         TtnuLvFmoP0XGAFsX5cT+TMz3drzgOAeUgx/c3pmaz+WMY3R3+RQ7CpfUIZ32cFL4icK
         6ScXCJ29qa51V0/1izVjKUZ3ek3oikYN4S+v/x6/ZiyOuv8WDTVaP38jZAO5wHr5eRzN
         AQKMpLrCvgPkLdGkbg7OUjFop5/cYIffoh2Vc7O4BWPEEhU4rmYqMCgdtsWWNQUAleSq
         9ZSDAv3krMlnkFB4+5zA3usrBssuvJNCiTgJ9U7v6f/tTE7Wv9uj9TVZGAkaLlBBAO+w
         h9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471248; x=1694076048;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oj9ZHh9uIvpj0ERp23NgRxjtB8A/WDYvtNWK07v2zI=;
        b=iUzPBugm1mD79mO2sX+doV7gZOfNzFnvFtwTeTN8bccD0YX0lXelnrJylApGxNGL3g
         Aw+KdLU9Q4lCwD4Rp3u/CcrcJC6HgA1ix8maPvwRRrqtoOaklo2OzVtGuvitQ8JDJQkA
         7rl7ZUYUSF43M9EZ6/I+qt9qXIyu+RWwzLmN+sRfFbMkA5YcbW5vjI1JqSWbKPvk2Bfd
         Ce7X7kALNJVxaEWgBOBPdCj5fIA/XvOhfwErli6V1yCo8pxt2p72a6ODevNbuxOMotrT
         FVGAA461cJ0CWvwZl06pRX4aYtRpBpJeWKZ6sBvdi00P+FCXMzxFw9pPOblRWqRFyvKY
         H2hw==
X-Gm-Message-State: AOJu0YytppgYJq5wyv03KvGlFJt5We3lk/STHp931ItyEkphWJhVw4lM
	2GRe1eESdTTuU8N2sQ/JoLNUeg/0+kA+CAh3qlNnTg==
X-Google-Smtp-Source: AGHT+IEC5YtV2U2cEklN+/jylIkWH4T7gor9vRqdxcg0xCCXWtlM2PpTXI6h2lSgtqlfrGIVvathzQ==
X-Received: by 2002:a05:6402:646:b0:526:9c4:bc06 with SMTP id u6-20020a056402064600b0052609c4bc06mr3431058edx.18.1693471248160;
        Thu, 31 Aug 2023 01:40:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
        by smtp.gmail.com with ESMTPSA id l22-20020a056402345600b0052c11951f4asm522481edc.82.2023.08.31.01.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 01:40:47 -0700 (PDT)
Message-ID: <1cc2c8f8-1f9b-1d47-05d4-9bcad9a246cd@linaro.org>
Date: Thu, 31 Aug 2023 10:40:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 4/4] MAINTAINERS: Update MIPS/LOONGSON1 entry
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
References: <20230830134241.506464-1-keguang.zhang@gmail.com>
 <20230830134241.506464-5-keguang.zhang@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830134241.506464-5-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 30/8/23 15:42, Keguang Zhang wrote:
> Add two new F: entries for Loongson1 Ethernet driver
> and dt-binding document.
> Add a new F: entry for the rest Loongson-1 dt-binding documents.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V3 -> V4: Update the dt-binding document entry of Loongson1 Ethernet
> V2 -> V3: Update the entries and the commit message
> V1 -> V2: Improve the commit message
> 
>   MAINTAINERS | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ff1f273b4f36..2519d06b5aab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14344,9 +14344,12 @@ MIPS/LOONGSON1 ARCHITECTURE
>   M:	Keguang Zhang <keguang.zhang@gmail.com>
>   L:	linux-mips@vger.kernel.org
>   S:	Maintained
> +F:	Documentation/devicetree/bindings/*/loongson,ls1x-*.yaml
> +F:	Documentation/devicetree/bindings/net/loongson,ls1*.yaml

Why not simply squash in patch 2

>   F:	arch/mips/include/asm/mach-loongson32/
>   F:	arch/mips/loongson32/
>   F:	drivers/*/*loongson1*
> +F:	drivers/net/ethernet/stmicro/stmmac/dwmac-loongson1.c

and 3 of this series?

>   MIPS/LOONGSON2EF ARCHITECTURE
>   M:	Jiaxun Yang <jiaxun.yang@flygoat.com>


