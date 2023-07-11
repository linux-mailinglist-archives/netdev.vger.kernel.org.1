Return-Path: <netdev+bounces-16789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4586274EB2D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FA2C1C20D7D
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036491801B;
	Tue, 11 Jul 2023 09:54:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7574174E5
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:54:45 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A99B7
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:54:43 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991fe70f21bso693323466b.3
        for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689069282; x=1691661282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmE4v52q1Ad8B5XbVBXzvr3xxDgynpotAOjnuTuCObk=;
        b=tA955queu1D9GTW3c+allmX+oZ+L+E+pwDxlbjo7kOEKyX57j53zqmMgskx6y8Wsc/
         eS4O/hvW2Hf7Cwzug7V5j1MgO1RLtCa55aZHvg5gcFsCeMH01VHmf2E4dkrkJSiCxhsP
         MRz9geTVL0jD+4Me96lelD2sQ8M64NPqjL1zX9vM/+msTSIyoHGrFX3SYlfB1u/0QAVu
         vlFTD0LpsOuRqxFs87hDT4GMpiJHVT3mFUreI3RaVae5Hn9H7SpcU9WpAi+WMB/U+Ogd
         WWlW7vLnnHg6kXWoEh62O8X7BcggkHW9Jpp7XfrdKbbXWhBQ4MjUFEuro6gsZYJc87RI
         1Btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689069282; x=1691661282;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmE4v52q1Ad8B5XbVBXzvr3xxDgynpotAOjnuTuCObk=;
        b=N+UOqNr/vnLtvIA4WufinjJlF7NkIIjv7bIezo47vlo2JqlxPKhOhVcRjC2QkPW9FI
         v2FKQv3l3HcLIiFJzPAlU8/6lTKR5GKled0T11JIvj2+Qqwzhn7+4bmnvYK0a58Kf303
         6YmAuKBFhF9h/ExiJCn+HRBiAjRnBhQ5sV6u4iCB2BHFnMXLCeWoZih7dQEoR40X0wHi
         qhbEU4+EqwH8ourccHq865SA4sBs3Ja5doiHlkvQurU3DxokZcyULgZsz3p1ScQ+USbo
         NbvvpB9bvipGfQlpWp7FU9LbK90Wckg+gj7aM0A4Nvcn6yeEjp4n/H4cXikCEd8rE+8V
         Ut4g==
X-Gm-Message-State: ABy/qLY2lFM4FV6spxg4DqYO8hs/7vBgTluXEs0ZNe3VpN/DUzuIfeAp
	RfpyFbR126n+WlfIVXOHIZRfhw==
X-Google-Smtp-Source: APBJJlExFhFXNm2eIyUDkRqdil/jnDmLUCHQeTiyjjUKMfJHW1Sp3RxBNmLgFFJOg5gZFfRAogTakQ==
X-Received: by 2002:a17:906:15:b0:993:f611:7c95 with SMTP id 21-20020a170906001500b00993f6117c95mr10263757eja.39.1689069282221;
        Tue, 11 Jul 2023 02:54:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j8-20020a170906830800b009927d4d7a6bsm941783ejx.53.2023.07.11.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 02:54:41 -0700 (PDT)
Message-ID: <5f16f5c0-c63e-9e16-b55d-ac90977bc863@linaro.org>
Date: Tue, 11 Jul 2023 11:54:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/6] dt-bindings: clock: Add ipq9574 NSSCC clock and reset
 definitions
Content-Language: en-US
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
 <20230711093529.18355-4-quic_devipriy@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711093529.18355-4-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/07/2023 11:35, Devi Priya wrote:
> Add NSSCC clock and reset definitions for ipq9574.
> 
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>  .../bindings/clock/qcom,ipq9574-nsscc.yaml    |  76 +++++++++
>  .../dt-bindings/clock/qcom,ipq9574-nsscc.h    | 152 ++++++++++++++++++
>  .../dt-bindings/reset/qcom,ipq9574-nsscc.h    | 134 +++++++++++++++
>  3 files changed, 362 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,ipq9574-nsscc.h
>  create mode 100644 include/dt-bindings/reset/qcom,ipq9574-nsscc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> new file mode 100644
> index 000000000000..1e8754760785
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,ipq9574-nsscc.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,ipq9574-nsscc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Networking Sub System Clock & Reset Controller on IPQ9574
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Anusha Rao <quic_anusha@quicinc.com>
> +
> +description: |
> +  Qualcomm networking sub system clock control module provides the clocks,
> +  resets and power domains on IPQ9574
> +
> +  See also::
> +    include/dt-bindings/clock/qcom,ipq9574-nsscc.h
> +    include/dt-bindings/reset/qcom,ipq9574-nsscc.h
> +

Reference gcc.yaml and drop all duplicated properties.


Best regards,
Krzysztof


