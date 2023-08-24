Return-Path: <netdev+bounces-30227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634927867D3
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E9DD281451
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA0F2454C;
	Thu, 24 Aug 2023 06:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD6B24545
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:52:32 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80201E4B
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:52:31 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so8223161a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859950; x=1693464750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tec2kZ0UKM8W+HhApP5ewEurz9N6NjLpNOz2ZhRdTI0=;
        b=y4ZL8J/hT/4lhwdW1JUK1rVUuPaCA6ziZUrBMqPLtCfiko/o1x47nAFofn/Sf2FQV3
         a9VCbPYrOpgf+5G5PRLhYyUVkv2853dYRke2aAFL0kQayHW5iyUlBmZccAZKv5ZCuQYp
         vPZ0N0daHWZ0InXx6Y53eIqCD41jxKMvz5b51jxcn+y5h0Ti9QCH3c0UEZyVpjJyySna
         vQRs2DAQFEmQwOA2L8GViFdF+1khWa3P5r3FGjmFlQACnBhrNtRHw9W590aNoaaX+G1o
         8HXxJfX3msHrqRJyILRE7S3ahy5TNH237lEO3Fvf1JWx67xJDML9yqD6yA2MgjVRXdN8
         GjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859950; x=1693464750;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tec2kZ0UKM8W+HhApP5ewEurz9N6NjLpNOz2ZhRdTI0=;
        b=WRF5ETWYHXQpWGsOA0VXGh+ooNxv5o0VdWD13luHuxT7gIhr7OXIdc+7zFPDrDZKrG
         aHl4wkLia4tChdsEO+c6ASjbWX3wlkNFub/h0A7hQbR1RdCdbEifKXctiD9QLtyS5PQ+
         bSrUUNAi/8jmw7TBq9JyvJMJFVSLkR2IAESvMAwRsvWXJ1NXUUZlwt1HQ5fu6njk2FAN
         BAvScaIzKmTRO/dQa3DOBVv22PpRVGs2rTCvubvTNmY+KyB2nvLE+bO5vYOt4z1eb7L9
         E0h4pJEj/mLcpqi71Gi9xd/bQnnk+dR9/RK/QXW6fevvUKpcnPvwOdj7vyPZnvqbbb8b
         KyZw==
X-Gm-Message-State: AOJu0YzB16IueWmxTei7unzZkQfR4G0X4eADBn1pPRqqChTigkFFFMDu
	N0NpLJeFVrtAXtxq20+E7JhNgw==
X-Google-Smtp-Source: AGHT+IF8mGk66KD1/hFdUuDrD7JYFjxRsc7Z6C/GO3AEZx1GBNE0jZUAwcxYLUKpOcCH3vti2NmJAA==
X-Received: by 2002:a17:906:2219:b0:9a1:c3ae:b014 with SMTP id s25-20020a170906221900b009a1c3aeb014mr4417705ejs.20.1692859949947;
        Wed, 23 Aug 2023 23:52:29 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id p25-20020a17090628d900b0098963eb0c3dsm10564592ejd.26.2023.08.23.23.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:52:29 -0700 (PDT)
Message-ID: <97445129-3cb6-d0bb-b1f8-dea997408ac4@linaro.org>
Date: Thu, 24 Aug 2023 08:52:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 2/5] dt-bindings: net: Add IEP property
 in ICSSG
Content-Language: en-US
To: Md Danish Anwar <a0501179@ti.com>, MD Danish Anwar <danishanwar@ti.com>,
 Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
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
 <1326776f-2592-f231-2056-a231729da50a@linaro.org>
 <78d315b9-f8b1-0012-ceb9-5c3c5034c7dc@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <78d315b9-f8b1-0012-ceb9-5c3c5034c7dc@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/08/2023 08:51, Md Danish Anwar wrote:
> On 24/08/23 12:15 pm, Krzysztof Kozlowski wrote:
>> On 23/08/2023 13:32, MD Danish Anwar wrote:
>>> Add IEP property in ICSSG hardware DT binding document.
>>> ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
>>> of ethernet packets, PTP and PPS.
>>>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Where? Please provide link.
>>
> 
> https://lore.kernel.org/all/20230814-quarters-cahoots-1fbd583baad9@spud/
> 
>>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>>
>> Where? Please provide link.
> 
> https://lore.kernel.org/all/5d077342-435f-2829-ba2a-cdf763b6b8e1@kernel.org/
> 
>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>> Where? Please provide link.
> 
> https://lore.kernel.org/all/ZN9aSTUOT+SKESQS@vergenet.net/
> 
>>
>> Otherwise all of them look like fake ways to sneak patches into the
>> kernel. Our work here depends a lot on the trust. Trust once lost, is
>> tricky to get back.
>>
> 
> It's not fake. They provided they RB tags, after that while preparing next
> revision I use b4 to get all the tags and apply to applicable patches. I know
> trust is important and I won't do such things like faking tags. They gave their
> tags in v4 and v5, you must have missed those probably.
> 

Yes, I missed that while searching. Sorry for the noise and questions.
Thank you for providing the links.

Best regards,
Krzysztof


