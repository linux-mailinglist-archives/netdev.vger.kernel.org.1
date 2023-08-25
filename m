Return-Path: <netdev+bounces-30664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03672788781
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 346B31C21018
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 12:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC90FD523;
	Fri, 25 Aug 2023 12:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1606101C2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 12:29:37 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63B2701
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 05:29:12 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1989255a12.0
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 05:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692966523; x=1693571323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FhBMwE3MHaDX6ND3qGNugUwUVOyYbmNTlBBuciUOviU=;
        b=aH7vGVSRCLDmoTWkEC7IZ1dxd68MnPouE/QYJjQCkH/C4i+4dEEIkFZ0acfdePNkR/
         1KY+w5wnDJ9OBswFzVzNrZcVEFeqKaM1++X68UMw85vIhod7QZoq6j5/hl7povGcq1MB
         DwS0FpeG3lY+v+lVl8qkUv4Px1o3JPYtZx6Eyzmyj2/DtKN/RTIQWW/Sbv7rrxiYgfUM
         xOBPiRs4VAlyBeqXdcbHOgnE74hdirl4kLDlm4hgaXbQz9067XeSrb/tb3VkYiRySopS
         eYoI8M0aaR6NtTDDwzd83LRqTmqT6XXTOQwde8zpezccRUBD4rYB4rpI7F+Aik8p3BLF
         J8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692966523; x=1693571323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FhBMwE3MHaDX6ND3qGNugUwUVOyYbmNTlBBuciUOviU=;
        b=j9EdUOTOF5C/LFkASg5xplnrqIYU/rG0abNFefvP+hC9cRAuXI24hen5LTXUUFnFNP
         +AyW5Ar0Ug3uAYVNtvJTdEsIXu8jjvfpoTQOvtfnGwa1mrZsi6vfoPP8j/m6vXZ/Frn9
         xG7sJ6Ee2YhDh4ACuboSlcCtiAPyvMHQ92JJH4VN4NmiulIG1eTs0+wD5gSbQj35y9lQ
         vLvNDGWqxHWUwRRYaIJyTC5+HU/zFn3vtmfe3Mwgc/V8rM6bD4SobG9cNjZ/2eRy973u
         NEUSL2+PYRc/PhhRqPqV+HbqrwY7MyIBBaHFbe0fGlKBTB3edMhvM9m6F5iaHEFIzHvY
         2qDw==
X-Gm-Message-State: AOJu0YxwmXXQ8wTf5JDYFSihUVfy59fdkPcr4GKlrYQUI1GZw1BvJUPP
	OHu4HI+gKWk8fVBCi9P1xkO8iA==
X-Google-Smtp-Source: AGHT+IElSbp36KrzVD5bvYcQ7Jekn8F93SVqrRsyyl1c1Vm8K052ePheCMZItL9tFxamFHFADIvCdA==
X-Received: by 2002:a05:6402:11c8:b0:51e:5bd5:fe7e with SMTP id j8-20020a05640211c800b0051e5bd5fe7emr22520456edw.17.1692966523565;
        Fri, 25 Aug 2023 05:28:43 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id h11-20020aa7c60b000000b005227e53cec2sm957223edq.50.2023.08.25.05.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 05:28:43 -0700 (PDT)
Message-ID: <da744640-9f06-69cd-16fc-44ddd1e8c7c2@linaro.org>
Date: Fri, 25 Aug 2023 14:28:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V2 2/7] dt-bindings: clock: gcc-ipq9574: Add definition
 for GPLL0_OUT_AUX
Content-Language: en-US
To: Devi Priya <quic_devipriy@quicinc.com>, andersson@kernel.org,
 agross@kernel.org, konrad.dybcio@linaro.org, mturquette@baylibre.com,
 sboyd@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 p.zabel@pengutronix.de, richardcochran@gmail.com, arnd@arndb.de,
 geert+renesas@glider.be, nfraprado@collabora.com, rafal@milecki.pl,
 peng.fan@nxp.com, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: quic_saahtoma@quicinc.com
References: <20230825091234.32713-1-quic_devipriy@quicinc.com>
 <20230825091234.32713-3-quic_devipriy@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230825091234.32713-3-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25/08/2023 11:12, Devi Priya wrote:
> Add the definition for GPLL0_OUT_AUX clock.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  include/dt-bindings/clock/qcom,ipq9574-gcc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> index 08fd3a37acaa..f5749bf53898 100644
> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> @@ -216,4 +216,5 @@
>  #define GCC_CRYPTO_AHB_CLK				207
>  #define GCC_USB0_PIPE_CLK				208
>  #define GCC_USB0_SLEEP_CLK				209
> +#define GPLL0_OUT_AUX					210

Although you remove here blank line...

Best regards,
Krzysztof


