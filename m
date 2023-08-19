Return-Path: <netdev+bounces-29105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB67819FE
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 16:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB001281B06
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 14:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A5D6ADE;
	Sat, 19 Aug 2023 14:23:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB246BC
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 14:23:46 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB8BA8C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 07:23:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5259cf39154so2348829a12.2
        for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 07:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692455021; x=1693059821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+H6LiI1fuzN7XDYYZHmb/bhyxb5oDWpcZV5MPYgeNM=;
        b=cdwgqQ2/540qB6iDOetvo5+7VCwQmYK4ucktUn2S6tKhleFEfC1EpTZ4JYACvovMTs
         q80w44G8zoYpOEESt9mribtnkSPAHijp742ibvWl8G2spBUc7A2iyJpbe/+hSxq1JiLX
         VvttIM0PsbTvRlYBAFBKAbcmgwA9etZvKcfnollWct4wPA0vhah6KZEW2ZD6QuU7zPN2
         NWFsh418VeYs6g5dM9/AzGVVFrneFiV7dBvS2oVMsPO3IkEoH9oLi6HM9FA+Fl6QJLwC
         XmB91+4b+nQ3SNqUIn062zB3z3DnD8GY7VgF1SO/tA9mYy1gS8dq8ebRWlR97rZ67gAC
         tDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692455021; x=1693059821;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+H6LiI1fuzN7XDYYZHmb/bhyxb5oDWpcZV5MPYgeNM=;
        b=Fyzy67c/yx1CRctmKtxBECHCQGCtu+qK7+tIYnVqTIrdgYYSYYbr9X8O1X9iLQ5dUL
         YWQLCJMfok1PhbC8/yM7kr9YK9MfUCA9kwQmpfXT9fs+VpQ+EhDPIzY+F8rokPQCh4uN
         6+NK+5vJ/1a5EQtq3nZx+Hm6MVZKfNJnNXzcCb3AgVA2QVDAJ+KfEmrNOX1gzBSFQvFU
         /qmcdTVK09LxJVI7vGZxFUAA2HbCiJYXwPVcx9QbV1F+7rjjNz9GykL0LZvJqmpd59oI
         Kxy7jbwuZMXEnT8tBY8zs0YNyikPKCG4MzFt/XqD+J0FS721SdjvD/HUSMjHptkjkLv4
         Qsxg==
X-Gm-Message-State: AOJu0Yz4h9aHYxBqkRK0Ab0P8Np7IK5qBi6HV7rEGJPzJBTZtT4zsafA
	j82WrOLRHHjyIjQkYVLpuqNrKg==
X-Google-Smtp-Source: AGHT+IHfb3IPptZFQYePiW40IL2RA9ejCLE2dfITH1lklobH/LC3t12t/Nl9vvFFC1Zf4mKowMUWvA==
X-Received: by 2002:a05:6402:1610:b0:525:70b3:72c2 with SMTP id f16-20020a056402161000b0052570b372c2mr1608371edv.14.1692455021626;
        Sat, 19 Aug 2023 07:23:41 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7c2ca000000b005257580f5ddsm2606079edp.71.2023.08.19.07.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:23:40 -0700 (PDT)
Message-ID: <a9a7b65c-ef0b-9f66-b197-548733728d44@linaro.org>
Date: Sat, 19 Aug 2023 16:23:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
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
References: <20230816111310.1656224-1-keguang.zhang@gmail.com>
 <20230816111310.1656224-2-keguang.zhang@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816111310.1656224-2-keguang.zhang@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 16/08/2023 13:13, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.

I asked not to use the same compatible for different blocks. Compatible
is dwmac, but are you still going to use for other blocks? Please write
proper description of the hardware.

> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Make the syscon compatibles more specific
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 8103154bbb52..d701fff02abe 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -49,6 +49,8 @@ properties:
>                - hisilicon,peri-subctrl
>                - hpe,gxp-sysreg
>                - intel,lgm-syscon
> +              - loongson,ls1b-dwmac-syscon
> +              - loongson,ls1c-dwmac-syscon


Best regards,
Krzysztof


