Return-Path: <netdev+bounces-12552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831A0737F8D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 12:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343F4281568
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 10:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347D4FC04;
	Wed, 21 Jun 2023 10:26:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280288BF8
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 10:26:25 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E419BB
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:26:23 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-987accb4349so692878566b.0
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687343181; x=1689935181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcl/mkU9nXIhvMdXPVz6mSenFfwzfIPrN42NIXl5kI4=;
        b=mU6ZIIUtRa/sdiidVkimjlwvSwTuPqtoC7WcpCVShqzlRohQhACtesKUVq7WQMvzf3
         V8ghhupL8eNUrafY5IdtezWrAL3RBENeyY3avIF9kk6Wp6xBEAe1TYmMK5KHlrbvDCpY
         oIiz31p8n8EornPTuQAXENoFe5OwZ8GaMq3CsFp+ZF19ND25JdlxEcpIcqYg5sS0R9Oy
         15N8ZmBVLZQWSpnM0u/z77XCQc+29AHKoL1C9j1mIbxf5BJh6+KC0I2fZ3bKAvYoNjP7
         HeFAtrWRI1nfsbH4yRXZ0Uy/38JF4Nmz8dCVReR3hrrN3XOvFWE1By3YGpagpOTNCMDR
         0stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343181; x=1689935181;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dcl/mkU9nXIhvMdXPVz6mSenFfwzfIPrN42NIXl5kI4=;
        b=jkaMo7/uJiY9P7j+xj5STY9hYdkdpwajX1++lpzjRbmqdx9XJcb+KpP/hrRFAEh3hn
         IrUcEbkz5ppIEH1v55BJRMXPmW8aQT5frMnlCGoFIjDs4I4yP4wRS0oLu6/ZfMVKwVxi
         Iiz/fcT20RYEKo/1ZGTM/QN0fwxTNSwrH/v5+PXrxoqLiBmiD3jq+50CHce6l2Sqb7oi
         NoMESm+8FXGuxHccKmSFUIqg4+tIDFHlhhZQaqOD2FBRKICILwbfGDjIsJmldmBDLA4k
         t53BhMcTpMJrawMilhcaWqgsULR5jQ6T6rSo1ItCRU/b7WeBkfNBGdryIe8sqwXw4jPz
         KUqw==
X-Gm-Message-State: AC+VfDwUxHDoWEhMUDv/bFtWjKCaBe+OOR+sql0xSUjGIVBhisB2wL7P
	g6+/9p88TU82+KgLBcQeIz7D0A==
X-Google-Smtp-Source: ACHHUZ690EzI8mAWGFm9FGAZap8ahsbyAMf9kbLN7HZZoYoMnF8SIStoZXztypCmbxhPKpCUyxqd/A==
X-Received: by 2002:a17:906:4793:b0:965:ff38:2fbb with SMTP id cw19-20020a170906479300b00965ff382fbbmr14974192ejc.1.1687343181722;
        Wed, 21 Jun 2023 03:26:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t13-20020a170906a10d00b009745b0cb326sm2913093ejy.109.2023.06.21.03.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 03:26:21 -0700 (PDT)
Message-ID: <3d4fdc26-4fd5-9900-68b5-7476996839b5@linaro.org>
Date: Wed, 21 Jun 2023 12:26:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/6] dt-bindings: can: tcan4x5x: Add tcan4552 and
 tcan4553 variants
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Wolfgang Grandegger <wg@grandegger.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Conor Dooley <conor+dt@kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Michal Kubiak <michal.kubiak@intel.com>, Vivek Yadav
 <vivek.2311@samsung.com>, linux-can@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <simon.horman@corigine.com>
References: <20230621093103.3134655-1-msp@baylibre.com>
 <20230621093103.3134655-2-msp@baylibre.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230621093103.3134655-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 21/06/2023 11:30, Markus Schneider-Pargmann wrote:
> These two new chips do not have state or wake pins.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> index e3501bfa22e9..170e23f0610d 100644
> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> @@ -4,7 +4,10 @@ Texas Instruments TCAN4x5x CAN Controller
>  This file provides device node information for the TCAN4x5x interface contains.
>  
>  Required properties:
> -	- compatible: "ti,tcan4x5x"
> +	- compatible:
> +		"ti,tcan4552", "ti,tcan4x5x"
> +		"ti,tcan4553", "ti,tcan4x5x" or
> +		"ti,tcan4x5x"

One more example why wildcards are not allowed. Ehh,


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


