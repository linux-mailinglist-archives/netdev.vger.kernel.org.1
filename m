Return-Path: <netdev+bounces-30221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AEA7867AB
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85252281445
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4536124541;
	Thu, 24 Aug 2023 06:45:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A312453C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:45:29 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E822A10F7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:45:25 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99c4923195dso830003366b.2
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859524; x=1693464324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rnNGmf2WWBgfkQAyVC3feikVFhEUoK2YZ6y9s10fp+g=;
        b=ZoaOILWVeHmGVSqeM8U7E3ZXekN3WMc75pFN7wcLlHYTcopJoS9k+ERfYsEddO37UB
         lNwbBVOiwhYBlZZvGk62x2SiK5hoGOOoeze07ubjx+kvO64UaP3LFy2ss+tZax/2Ej5O
         Oqq2PQdY8LWmJVZUYc+mv7ezbTJwUHQkwPQg99g0CX+sixtpDTYDzENZUjSGBLqXN/2N
         bjr0DnPTi8kGxZCKDc1O7UgFkUrPPH8ArytEFZeeUVn4M7y2ehTZQTfSicgotjrWaNuR
         /F4ww+S+CPEElNzVsrbZuhdaxIsDPbXU3zZxRxo2hbXmXdJJzlzoes34XKmgGE/m6C6c
         uiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859524; x=1693464324;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rnNGmf2WWBgfkQAyVC3feikVFhEUoK2YZ6y9s10fp+g=;
        b=XBW+tJQ3uMIGwBmy0gzoyP3pN1ot8Oe+cCs18xhDk5Nf58F7zScoSrT6qs3Qvi/zVd
         ZZPog5IshRkv4lrNX7Blojd2TFwEoW8MljHOuGtQsl+lfTs4+ahHkXSGNz3fTWreCzu8
         9vcq2CoEoqhvq2JPFkUYL7rwU8mkR7bJWAl1Q0UzKDHBFCO/JxzFKwj9mwcWlxDriP25
         h1fdxJp6UlBNI52j/ViQXEHimSeB9qmEIgFOO961368vipNmNet+eAlo8qtbcMoxnvtI
         UqUudSJap0q2o6CmC+VoZmjVP/nbUerqYyDzPRM5di8aodn4FJ9lRBNBW/6qdnwtkdtS
         QuFA==
X-Gm-Message-State: AOJu0YzuWisYSXeYXbRdGgqI5M4DvsmUZvGZ13s5ICwGtlwhNjPhBx9W
	jZ6CwPGI7hdnjEwW4zldntRRfg==
X-Google-Smtp-Source: AGHT+IGy78witumN00EVCy5UGo3smU/gaSGULiiCcVwhomJv/wCO+KpTMU2P5OmjNabYfnDdCjVcfw==
X-Received: by 2002:a17:906:249:b0:9a1:cbe4:d033 with SMTP id 9-20020a170906024900b009a1cbe4d033mr3788327ejl.53.1692859524373;
        Wed, 23 Aug 2023 23:45:24 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709060c4700b00988c0c175c6sm10571133ejf.189.2023.08.23.23.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:45:24 -0700 (PDT)
Message-ID: <1326776f-2592-f231-2056-a231729da50a@linaro.org>
Date: Thu, 24 Aug 2023 08:45:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 2/5] dt-bindings: net: Add IEP property in ICSSG
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Randy Dunlap
 <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
 Simon Horman <simon.horman@corigine.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: nm@ti.com, srk@ti.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-3-danishanwar@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823113254.292603-3-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/08/2023 13:32, MD Danish Anwar wrote:
> Add IEP property in ICSSG hardware DT binding document.
> ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
> of ethernet packets, PTP and PPS.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Where? Please provide link.

> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Where? Please provide link.

> Reviewed-by: Simon Horman <horms@kernel.org>

Where? Please provide link.

Otherwise all of them look like fake ways to sneak patches into the
kernel. Our work here depends a lot on the trust. Trust once lost, is
tricky to get back.

> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---


Best regards,
Krzysztof


