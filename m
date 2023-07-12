Return-Path: <netdev+bounces-17301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B377511DB
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 22:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30649280EB8
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 20:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B09DDCF;
	Wed, 12 Jul 2023 20:36:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3225029B0
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 20:36:40 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1E81FF5
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:36:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so9259254a12.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689194198; x=1691786198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qTIfZiBXGeNx2LL2qDkANMIcRNuFQoGE8jZgmUEj/Bs=;
        b=y+sINyL0AJvDXbwpXs4l+ZyafLmlSiYHCSuzz3gsyTZQVlTGfA6Lz9uFnL2VFF48vy
         Vn1iVIMiOM8BeOdr+M51utyIo/cJtoKwpOK1R82IJ58PRdl/MGvHLQZHY2PQG6y/l/kp
         OKlGDzND4jIND6udhfdWG+W2n8X5RfzOIFCT6BzxfMbRuc9dvIpshRmluKdQkD4yaPhG
         HRyQDDXpxv5+PwrFqZ1MJ+1SscC82BMk7dqtOIT7XiRWlIVC0ZIfrRN0Pfu0B7WvESCF
         kiTQ2GW/Z89xvc4X+pKKUL3wYq7h0inozKAd2Gx89lUsRhSsuVAhzgClSdvY7uAyA0Fz
         OUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194198; x=1691786198;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTIfZiBXGeNx2LL2qDkANMIcRNuFQoGE8jZgmUEj/Bs=;
        b=gTgAenHQY+NBSDYc58Lo7wOtPfBEtTjlOPG8eAjXE6zfIGwsmiioSpwhSv54sZbm93
         TFaR4GluRh1CUpUkOsgyRXyzuq0cYHkTOzawwxXexVOUzVj3N1QmMNs48aoibsq/8ELN
         XfiE1ypOUIn4R6IjsWiI2Afl7Zv95BQM7wBGMisTTBjRsIrznjK/zOpPHVoyufmG6B2k
         bZxL4ft5+KEdtukls7KyAj+W0UzPvBD7FJcVwn9pRn6K5PQa+7zyMv41PN0g0DbgrkFm
         j1y7ovkvYjArtjPzlFD/vMkSFG8UIkR+IdVx35Lynux5lgi9OeCaW/j8mnZEjmabZvrY
         8Tyg==
X-Gm-Message-State: ABy/qLYXTL2fHsutsaoN96x/hJlpolYUdEkEhGjlGYIAi5vZZPvlqBYR
	ikPEIbXEExpxi/s4taLyK81aBw==
X-Google-Smtp-Source: APBJJlHhCGGtmxYQDbv6iLN7rNp7N/lmAxjHx0hFv2Tn4xTdwchatR/400eMahUldDdsgzTE8wW+xg==
X-Received: by 2002:aa7:cd8b:0:b0:51e:1656:bb24 with SMTP id x11-20020aa7cd8b000000b0051e1656bb24mr15088788edv.26.1689194197823;
        Wed, 12 Jul 2023 13:36:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j20-20020aa7c0d4000000b0051d9ee1c9d3sm3254199edp.84.2023.07.12.13.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:36:37 -0700 (PDT)
Message-ID: <006f9599-6aa4-52ac-068a-831893ec6bf8@linaro.org>
Date: Wed, 12 Jul 2023 22:36:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: net: fsl,fec: Add TX clock controls
Content-Language: en-US
To: =?UTF-8?B?VmVzYSBKw6TDpHNrZWzDpGluZW4=?= <vesa.jaaskelainen@vaisala.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20230711150808.18714-1-vesa.jaaskelainen@vaisala.com>
 <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230711150808.18714-2-vesa.jaaskelainen@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/07/2023 17:08, Vesa Jääskeläinen wrote:
> With fsl,fec-tx-clock-output one can control if TX clock is routed outside
> of the chip.
> 
> With fsl,fec-tx-clk-as-ref-clock one can select if external TX clock is as
> reference clock.
> 
> Signed-off-by: Vesa Jääskeläinen <vesa.jaaskelainen@vaisala.com>
> ---
>  .../devicetree/bindings/net/fsl,fec.yaml          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl,fec.yaml b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> index b494e009326e..c09105878bc6 100644
> --- a/Documentation/devicetree/bindings/net/fsl,fec.yaml
> +++ b/Documentation/devicetree/bindings/net/fsl,fec.yaml
> @@ -166,6 +166,21 @@ properties:
>      description:
>        If present, indicates that the hardware supports waking up via magic packet.
>  
> +  fsl,fec-tx-clock-output:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, ENETx_TX_CLK output driver is enabled.
> +      If not present, ENETx_TX_CLK output driver is disabled.

Here...

> +
> +  fsl,fec-tx-clk-as-ref-clock:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      If present, gets ENETx TX reference clk from the ENETx_TX_CLK pin. In
> +      this use case, an external OSC provides the clock for both the external
> +      PHY and the internal controller.
> +      If not present, ENETx TX reference clock is driven by ref_enetpllx. This
> +      clock is also output to pins via the IOMUX.ENET_REF_CLKx function.

and here:
In general, Common Clock Framework and its bindings should be used for
handling clock providers and consumers. Why it cannot be used for these
two cases?


Best regards,
Krzysztof


