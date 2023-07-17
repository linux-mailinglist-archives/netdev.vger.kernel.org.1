Return-Path: <netdev+bounces-18361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA08756986
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DA01C204DA
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8C15D0;
	Mon, 17 Jul 2023 16:47:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEF610E7
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:47:41 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C752AD1
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:47:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991da766865so667554166b.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689612458; x=1692204458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JK6TkOQBHFr4q96srFPr4OjrpsieTptoErK+rdA0Pjs=;
        b=gSVw5wcPbsf/QbpAH0hRSagM9a9kzssQWbI6taOsnZI7l2LvzXCps64xOZn4gkhSU0
         VOg60k5Q+3/LglcekmxcrdMyHmB5OJxtspd+ZWW1eqD5Cu84C8zFkh4q2G3RYCv4T+ur
         WobKpSvcRu+vALFSu0nNRRtNiSXKlxdSPDycdiuYam+noheKXbGRr104HAojgjhKTLki
         hzdezggTjMF40whEQPEVlWXLKeAD5A8t7EQzRTHc/a4rRu3V0bpHI3gi2ZP1NYW3UIhE
         bcnfghSfTbDRJIRAdUcCAUwc8dXgXakX4mgmDb5N5ECFGIKeJxvpScEr3fFYpVInMzn/
         CqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612458; x=1692204458;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JK6TkOQBHFr4q96srFPr4OjrpsieTptoErK+rdA0Pjs=;
        b=OzVsrDTCrlD0Fw9Rt+Le9jPavN6TM32vO0ulqm/mgPBUfvHoZtC+L7YRszQhPyRHiO
         6CsqhMrfnh3ywNAj3aRmnmeCbumosrzRrse68J97DPmyo2DD1SSO+kxL5wgfwKJOyIm0
         fOBI3K1KFA5Fwn37ShwZGGsvoO7taLM4RkZqo4M7h6WA8MSm4WVIr8dFKU5Jxw7ype1X
         WV8F1hflEnuzB8ONgEUpWseBsZd+5Z63BA4qQLOF3bgUiDgWeZdBcAhdyW/dgp1BCZWK
         8PvqF4X80Z1cAGtHyEfVVgx+xTrzRwGFMTcsuRhMo+l2YZAapha8TCD6j/91E7zgzllq
         Q6NA==
X-Gm-Message-State: ABy/qLZkRpQW+0PfXu93UbSpQoH8GMZTKdZ3jk1X7SN7v/jUVIo3t8x+
	dhZnPJTg+js8Q/fYI6HZX1JOaQ==
X-Google-Smtp-Source: APBJJlH0qMy8XozwM95e5By8BV0d4jRKCPbiiNYUEYx+N2c06vencG+JUCyJcZsjwFwwdoHev4v5Bg==
X-Received: by 2002:a17:906:3109:b0:994:54ff:10f6 with SMTP id 9-20020a170906310900b0099454ff10f6mr6962190ejx.30.1689612458219;
        Mon, 17 Jul 2023 09:47:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n7-20020a1709062bc700b00992e14af9c3sm4616559ejg.143.2023.07.17.09.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 09:47:37 -0700 (PDT)
Message-ID: <a34ef1ed-e204-77ba-a4b1-1a4bbabdac7a@linaro.org>
Date: Mon, 17 Jul 2023 18:47:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: snps,dwmac: add phy-supply
 support
To: Marco Felsch <m.felsch@pengutronix.de>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 peppe.cavallaro@st.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230717164307.2868264-1-m.felsch@pengutronix.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717164307.2868264-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/07/2023 18:43, Marco Felsch wrote:
> Document the common phy-supply property to be able to specify a phy
> regulator.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> index 363b3e3ea3a60..f66d1839cf561 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -159,6 +159,9 @@ properties:
>        can be passive (no SW requirement), and requires that the MAC operate
>        in a different mode than the PHY in order to function.
>  
> +  phy-supply:
> +    description: PHY regulator
> +

Isn't this property of the PHY? Why would the Ethernet controller play
with a supply of a phy?

Best regards,
Krzysztof


