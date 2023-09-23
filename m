Return-Path: <netdev+bounces-35990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24397AC411
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 19:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3E572282086
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 17:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DE120B3B;
	Sat, 23 Sep 2023 17:39:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006520B34
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 17:39:56 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF03193
	for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 10:39:54 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4053c6f0db8so28483015e9.3
        for <netdev@vger.kernel.org>; Sat, 23 Sep 2023 10:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695490793; x=1696095593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZ65IqURCbrJh1H5SuytbArtgpPFyuR+P9xbkBzeh10=;
        b=uJ/s3kbPNo01qhx582fOCmPyyJY40yciGxqwHXtvES3s0UB8aKPZclTk5x1ff9INxt
         Gg9lNrXqM19uBpcA/BfFr8G8997yMaG5RMirkA08WvBLVCsYJsJfgEqmS+s6DEceNY1m
         CaifcrX4jmVnNUC97lNI9FWL4siwlJSjq303yaPHhE9ORTBtZwfbJAbCgHNQKzfVlr7K
         G+XF6T1ElrWGDgZad/zZVoVNkUsn/WMSIahNu3Y3EGIClWU7+rkx/VAbQ/52mLO/ZpQr
         aYFDhOaBbZllhQVDEa0VJ47lLObT0S1+8aVCkuuQbD3sr25R7/wKUQ0waKKuKEKNF4S4
         nheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695490793; x=1696095593;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ65IqURCbrJh1H5SuytbArtgpPFyuR+P9xbkBzeh10=;
        b=J9pRMo7WWXTaZIiZnqGBAWU+u2zj4Q63vsxpXEFL9WaW7vIIH/y2KYWbaiYDBPGf7R
         GlQWfzlA7GZmsVikkRubwSiTdM4mDXmcfo4gIi6PZlU3bGx3OrGjrRMi76L60/ZaSa9c
         vRxwfnVSox2lKInIauAvKKe7X8RfIGhaIY0NgUVcr7ImGS/key2YqFDD798MqiZ5szoA
         WOwPr3ujvaiNTH5J3A6QFhn2CXTKX9tcGeMvMwhMBTivy2qu8bBcLe8x7/5DWbRaUcrI
         OzUbR9a+nVAkMw/KcULrSLGzsc/b3MfaD5wzqhe5XVGHbkk90neq27bmFCDqi/LhzP8U
         g8gg==
X-Gm-Message-State: AOJu0Yz3zJ0YWDIqLioyCZ/AvmdQ5uMoOyVPzZKH+nEDq39ZjEuDbqNR
	50/w9MF/E69MMW41kN1UnddiBQ==
X-Google-Smtp-Source: AGHT+IEEd3282Di2q0YcAJqtYDFuU8V+zYApnExmD7VbqyW5M1Qk14z70LmY7eS/A/fQK8DyM9Oszw==
X-Received: by 2002:adf:ef11:0:b0:321:4ab6:9b28 with SMTP id e17-20020adfef11000000b003214ab69b28mr2382788wro.16.1695490793135;
        Sat, 23 Sep 2023 10:39:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id h16-20020adffd50000000b0031ad5fb5a0fsm7449654wrs.58.2023.09.23.10.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 10:39:52 -0700 (PDT)
Message-ID: <5efae150-3d92-81b8-5c25-68846d27132e@linaro.org>
Date: Sat, 23 Sep 2023 19:39:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 08/30] dt-bindings: soc: fsl: cpm_qe: cpm1-scc-qmc: Add
 support for QMC HDLC
Content-Language: en-US
To: Herve Codina <herve.codina@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Qiang Zhao <qiang.zhao@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 alsa-devel@alsa-project.org, Simon Horman <horms@kernel.org>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230922075913.422435-1-herve.codina@bootlin.com>
 <20230922075913.422435-9-herve.codina@bootlin.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230922075913.422435-9-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/09/2023 09:58, Herve Codina wrote:
> The QMC (QUICC mutichannel controller) is a controller present in some
> PowerQUICC SoC such as MPC885.
> The QMC HDLC uses the QMC controller to transfer HDLC data.
> 
> Additionally, a framer can be connected to the QMC HDLC.
> If present, this framer is the interface between the TDM bus used by the
> QMC HDLC and the E1/T1 line.
> The QMC HDLC can use this framer to get information about the E1/T1 line
> and configure the E1/T1 line.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml      | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> index 82d9beb48e00..61dfd5ef7407 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> +++ b/Documentation/devicetree/bindings/soc/fsl/cpm_qe/fsl,cpm1-scc-qmc.yaml
> @@ -101,6 +101,27 @@ patternProperties:
>            Channel assigned Rx time-slots within the Rx time-slots routed by the
>            TSA to this cell.
>  
> +      compatible:
> +        const: fsl,qmc-hdlc

Why this is not a device/SoC specific compatible?

> +
> +      fsl,framer:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description:
> +          phandle to the framer node. The framer is in charge of an E1/T1 line
> +          interface connected to the TDM bus. It can be used to get the E1/T1 line
> +          status such as link up/down.
> +
> +    allOf:
> +      - if:
> +          properties:
> +            compatible:
> +              not:
> +                contains:
> +                  const: fsl,qmc-hdlc
> +        then:
> +          properties:
> +            fsl,framer: false
> +
>      required:
>        - reg
>        - fsl,tx-ts-mask
> @@ -159,5 +180,8 @@ examples:
>              fsl,operational-mode = "hdlc";
>              fsl,tx-ts-mask = <0x00000000 0x0000ff00>;
>              fsl,rx-ts-mask = <0x00000000 0x0000ff00>;
> +
> +            compatible = "fsl,qmc-hdlc";

compatible is always the first property.

> +            fsl,framer = <&framer>;
>          };
>      };

Best regards,
Krzysztof


