Return-Path: <netdev+bounces-30223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFD87867B8
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A3FC1C20DB6
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27B624545;
	Thu, 24 Aug 2023 06:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D471724541
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:47:46 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22B0E59
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:47:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52a1ce52ef4so3190501a12.2
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859663; x=1693464463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rWyCqPmgJ3hv088pfINrZgnv5A96Iv0KRz5jP4Vn3gE=;
        b=Q1YxpQjwCSojzu8J7+jwEuQ5tsa8M8oZ/+fvYjx8tgyKlcSZKO1lJZAFcjvoM1qP7B
         YWGXCzpqecdVLPDMIfxvovI6TgUmHg+AZfaarnDtkhGHEYwHNLnZiQPOBWF/1ENdHUyQ
         2XjKvZVXv1XvXbx4xN0Sf3kp6r3muB35cVXIni3qM+o/6ipGnJPvAjuDS5hnIyUFT2H7
         Haq9br+D7bFShH/PrPIu2fEDb9mUcZ8dyNkEqOh4iV+91xcMzLkMqboRXHt/5e3N02la
         rpcHvpTLkZ32A48bPvzRmY+eqQFr4wGLscI2XdERPtvtRaIGrefupRoFbjFpxborNAN/
         P2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859663; x=1693464463;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWyCqPmgJ3hv088pfINrZgnv5A96Iv0KRz5jP4Vn3gE=;
        b=DRxMadIXd4vg5xxEE/Ye5UdA24c2PyU1Gc+L+cGsjE66gBXiIHGcJZUobI0ddacA1C
         L3KtVJEzZ4X6i4RUA/vRqLNB/yTzMs6vlyI8DEBWum8xY+dxa8DqCQB/8wbwv1q7vCL3
         jt+PBbj0emQXKKpT/OLE18VhK7oymCgAx+m5uszyf/XHFbkRaMmB2ShCZ2N27VPCqq08
         CWrnY2iOOGAWXoVqpdhudE8dHXzCAzdAqyWG9Ldc8tbR7KPjxYU5YVQhgJbJi4CFtaN4
         +QbuzLYI6t+JaIjryuuLfuIdCoboHbj9iwyLSCrp4Q8QkoeU+xdDJWzTBum+nCqDxfwE
         IWvw==
X-Gm-Message-State: AOJu0YyakBsqlLL9SGm3kZw9Q7bp9rX8N+RTq7k7QIOjk1/pvlxIR6x8
	vedpzI+Lvb1KR0h0QNt+6eAk5w==
X-Google-Smtp-Source: AGHT+IHfYRd2GZMGltUOIDuVqHLml+WqQhUAkxEy8QUA1nMKr5wWj9DOhrwgjT4jD06tdPeXmUeVIA==
X-Received: by 2002:a17:906:53d9:b0:9a1:aa7b:482e with SMTP id p25-20020a17090653d900b009a1aa7b482emr5956781ejo.26.1692859663054;
        Wed, 23 Aug 2023 23:47:43 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id i12-20020a1709061ccc00b00991e2b5a27dsm10595780ejh.37.2023.08.23.23.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:47:42 -0700 (PDT)
Message-ID: <d07213a9-6cf5-3577-a2c7-d0f2773a8247@linaro.org>
Date: Thu, 24 Aug 2023 08:47:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 4/5] net: ti: icssg-prueth: add packet timestamping and
 ptp support
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
 <20230823113254.292603-5-danishanwar@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823113254.292603-5-danishanwar@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/08/2023 13:32, MD Danish Anwar wrote:
> From: Roger Quadros <rogerq@ti.com>
> 
> Add packet timestamping TS and PTP PHC clock support.
> 
> For AM65x and AM64x:
>  - IEP1 is not used
>  - IEP0 is configured in shadow mode with 1ms cycle and shared between
> Linux and FW. It provides time and TS in number cycles, so special
> conversation in ns is required.
>  - IEP0 shared between PRUeth ports.
>  - IEP0 supports PPS, periodic output.
>  - IEP0 settime() and enabling PPS required FW interraction.
>  - RX TS provided with each packet in CPPI5 descriptor.
>  - TX TS returned through separate ICSSG hw queues for each port. TX TS
> readiness is signaled by INTC IRQ. Only one packet at time can be requested
> for TX TS.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Co-developed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

How patch author could review or not review its own code? How does it
even work? I write a patch and for example judge - oh no, it is wrong,
but I will still send it, just without my review. Or I write a patch -
oh, I like it, I wrote excellent code, let me add review tag for my own
code!

> Reviewed-by: Simon Horman <horms@kernel.org>

Where?


Best regards,
Krzysztof


