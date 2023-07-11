Return-Path: <netdev+bounces-16804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F5D74EBF4
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 12:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785472815DB
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 10:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE41C174EB;
	Tue, 11 Jul 2023 10:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8C2598
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 10:48:58 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CAAE69
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:48:56 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fbb281eec6so8538254e87.1
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 03:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689072535; x=1691664535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k3hVozTzTK3YpKr6keu2WXQ1FFPISWGGNo2UDTZRi9Q=;
        b=nU/C676GyY21hAj+KRX6jRPDoXxBLxRpQ5tiHgw/ZMtBl1OUkqwjasHhY6RDZsyNVU
         4GGS4GTyrQTnU41lUp8zeu51RqkNmwwfawQanRriSSMpKrj1OBR1wz242jRO4aitsGxm
         //q83alAYwGQk7ekHZ9mvV7cYdsgwz7yUDg6jFW3ipXf/PZvu6CmDDbDWFiPM87pd0aH
         7vaQgg6rdWHH/klRgqVJX/bDS8XioTllvSejePpOsUADiYqtqkiD/wibaFzHSOYExBhM
         R5UOyVWk5IMkCml0yhWUgy5Uwro76it/Ax9LXJ8Ha40dqTjJYHwKRUckQmGb25/kn/xJ
         5uxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072535; x=1691664535;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k3hVozTzTK3YpKr6keu2WXQ1FFPISWGGNo2UDTZRi9Q=;
        b=JSUhsFi14jBBQNB+Fu4swRHQRbUCs/+hSEhNOM4I1Ib8xSvX3d2T7uoILkowWJTIL+
         RQ/GITTow2ff+YzGSZtXtLvdw5cvIaLnR2swUzz9uitT+DpZeeFdH4Y8ZhUP0EEAh/5r
         NjMdJPvizGI5xvdGjh7ubVPuli/4e+QemmblYu7b95nn82r7eRvLhiQ8rW0vO5W/JqM8
         U76xzHkKMpNTtQFZ+7k4jWXydAnWH10OMCaQkLVFze3VX+Awxe5scj53M/aZ+Uk6u8sw
         xNDbmWxTlrhv7CwVP2SSZP60mz5KnYidpEcOpl+i0Fa/AFetJG0jatLLZ3HCetolYJ/v
         hMdQ==
X-Gm-Message-State: ABy/qLZmyjRLyeCmhpyW3KshTbd3UZFDoe7cndDLggPu/2OQz8xliv2d
	fdyoT2Pijac/3BBC6Vk8lOetTQ==
X-Google-Smtp-Source: APBJJlHyMlnWO4airaDPNcfvE8dSS4VL8N9jsft2L9pAPDgY0hTH+0GFSvSQwhNkgEST/eS/lAkWyA==
X-Received: by 2002:a05:6512:3da1:b0:4f8:7781:9870 with SMTP id k33-20020a0565123da100b004f877819870mr14270790lfv.60.1689072534973;
        Tue, 11 Jul 2023 03:48:54 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id u12-20020a056512040c00b004fb57f28773sm264107lfk.285.2023.07.11.03.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 03:48:54 -0700 (PDT)
Message-ID: <f234891f-c508-20de-6d6b-c7b37f6adb2b@linaro.org>
Date: Tue, 11 Jul 2023 13:48:53 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/6] arm64: defconfig: Build NSS Clock Controller driver
 for IPQ9574
Content-Language: en-GB
To: Devi Priya <quic_devipriy@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 p.zabel@pengutronix.de, richardcochran@gmail.com, arnd@arndb.de,
 geert+renesas@glider.be, neil.armstrong@linaro.org, nfraprado@collabora.com,
 rafal@milecki.pl, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: quic_saahtoma@quicinc.com
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-7-quic_devipriy@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230711093529.18355-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/07/2023 12:35, Devi Priya wrote:
> Build Qualcomm IPQ9574 NSSCC driver.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 9ce0f1554f4d..d10083da2401 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1180,6 +1180,7 @@ CONFIG_IPQ_GCC_5332=y
>   CONFIG_IPQ_GCC_6018=y
>   CONFIG_IPQ_GCC_8074=y
>   CONFIG_IPQ_GCC_9574=y
> +CONFIG_IPQ_NSSCC_9574=y

Can it work if it is built as a module? This defconfig is used on all 
variety of platforms, including even non-Qualcomm ones. We are trying to 
limit the built-in drivers list to the crucial-only ones.

>   CONFIG_MSM_GCC_8916=y
>   CONFIG_MSM_GCC_8994=y
>   CONFIG_MSM_MMCC_8994=m

-- 
With best wishes
Dmitry


