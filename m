Return-Path: <netdev+bounces-22257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E6766BFA
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 13:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1231C218A9
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 11:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A67412B6B;
	Fri, 28 Jul 2023 11:44:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F397125D0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 11:44:36 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C79235B5
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:44:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso2057399f8f.0
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690544673; x=1691149473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtqrNXvAqbGnaFK11beQhojgaNwjRzpnOxCudKS4U2A=;
        b=gbuLTQF6hBW6TizMdQO6/NLNVTDxN+mlQ2Vxjli3wD7IhNmQctyZmLCVOPMAMhxznv
         zvkKnFhsWBXLNhiFHarqWWXSMetgX/+8oJuTzCDCSdjBtBvC77qk/VHq7RjmquOQqk1I
         1FqBEI0m22dfXpsLkTb827+PBD/i/t28Azgu9tev/4s4cFzFpLwk9+8N5bkAaoKPJidK
         Ei8pobXVwGaFPt4sn8fnybGqzhI/dCYSAPAHBUxg3Zr6n/LYEPnFFegACQBSjzPe27OW
         efzS5/T0IjsdpqTk5iHnmxkC7QmwILb0qUa3qAxUsZCfNCroj9+O9HiJVi8ecpHZX1ce
         XzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544673; x=1691149473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtqrNXvAqbGnaFK11beQhojgaNwjRzpnOxCudKS4U2A=;
        b=SSaRBhLvw63EMd98daEtorr2y0dRfdtHMwcioLzJ3KvMLyFbah75KEC+u33/P5RVqg
         nMN/wYMvtMQKnNoEvrXgjqVsC7FvkWQIKJh7A/L3LS0G05xmt28QJJSjtoK7O2OsBHFW
         DCA35msPamRAezexSeQr+hzgiT+Re7YTaE6thHi3OTLV9JWKdyDALd42piAoKl7B4AgO
         yJ1OoFkcj7PKrZMypKf5A8obQfOKX6GX1k2NJp74DCY5jlYanTAGgJzj9PW6R2QPKU9C
         A0qFEmDXqgbdlfBY0SLQbFj2dmfv/GRLot0I2AbYnZungnpAWON9cfid8nWxIVtamhT5
         aEIA==
X-Gm-Message-State: ABy/qLarm9JXfOWYukpkqzfvoD4ojH/u3feBFtksUIk3Dxie5uMjcMJo
	N1WDmqum2WmdV131Vr9uKvpA7w==
X-Google-Smtp-Source: APBJJlHYs+xENUPYc1+K2ZgnFIU2Jzx2/+CtsWQ5tAoIjmJR8Eme6SfLjAQZhrp6VLYuMGplZGJwMg==
X-Received: by 2002:adf:f291:0:b0:317:636b:fcb1 with SMTP id k17-20020adff291000000b00317636bfcb1mr1364548wro.27.1690544673618;
        Fri, 28 Jul 2023 04:44:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b00311d8c2561bsm4562595wrt.60.2023.07.28.04.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:44:33 -0700 (PDT)
Message-ID: <11947259-1e05-40dd-c20f-422bb649214a@linaro.org>
Date: Fri, 28 Jul 2023 13:44:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/50] dt-bindings: net: cdns,macb: add sam9x7 ethernet
 interface
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@microchip.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
References: <20230728102328.265410-1-varshini.rajendran@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102328.265410-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 28/07/2023 12:23, Varshini Rajendran wrote:
> Add documentation for sam9x7 ethernet interface.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index bf8894a0257e..c9840a284322 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -59,6 +59,12 @@ properties:
>            - cdns,gem                  # Generic
>            - cdns,macb                 # Generic
>  
> +      - items:
> +          - enum:
> +              - microchip,sam9x7-gem  # Microchip SAM9X7 gigabit ethernet interface
> +          - enum:
> +              - microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface

That's entirely different patch than before. Not correct also - drop the
second enum, because it cannot be enum.

Please provide changelogs explaining what happened in the patch. Sending
such huge patchset with changelog only in cover letter with very vague
description of changes is not helping.

Best regards,
Krzysztof


