Return-Path: <netdev+bounces-30999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC68378A652
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39588280D99
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 07:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15596ED6;
	Mon, 28 Aug 2023 07:15:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07276EC2
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 07:15:24 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFA1116
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 00:15:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcfe28909so357837766b.3
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693206919; x=1693811719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HJAzGXxVLZwUhvU/AbwqXIQG//zHq0gh5RxbohWoMzQ=;
        b=IAPS6RTDr+Uuos2iktTsV6YF4O0gf9AMecbKe0U1yvoJY+4RpFvnUKOeILUOzN9fZd
         bJwoaK97ve5ZzSZVaBaosV3ZEswi2I9AVBNzAdGbc3p4cMqN2ZhK6MRvgNcLVtJ+hSzD
         gE0vT4GkyZ/7FB6ZcoO8vnoE476dx1WQdvTuJHZ+Anz57RiGI1lPkcd0FSNGH2Hg5Qd+
         FQhS/I9Oww6456S5v4C1Kme9W3UZOusUXKv2KHtboGIp0y9t7w5lysWwhnIvnopFWWds
         WztDvXU+2dsWMOyjMom12SUquq71oEeatqwgRfmeOGtqnf1uUnIBdsrONQY58Aq5bDsb
         VRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693206919; x=1693811719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJAzGXxVLZwUhvU/AbwqXIQG//zHq0gh5RxbohWoMzQ=;
        b=DRvZq0k2o2vuTlE+Q1xkHxfoMpHmo+7HJouP8CsIFzqvlkwgDRqcJosl5dLZNmSwNZ
         cDcSICEvyHeUXkyaz6aF1rSM0FXZ9aZpit00cNAy92/esGOvfULC+3zH2RmwlVlSEyEb
         Vrks6CW2RENnW2RATP2RCViVQJLYcoAL1GJGr8+k3EVMU3pDhink0LaGvQWMGKiLjZfX
         3lOj8aY8sexap14asYyRptBQV7cK0ANBL6k2dH+z/hgZCZ9fxXXONnanVbd/hAMIpkfJ
         fbrH64rIdE64k2za6zlGgXpvZxeofHGeRWZkdaGRBQwuDKtQ2EomRUyEpk8WJwMfmuos
         sQBw==
X-Gm-Message-State: AOJu0Yx9PtrjA7ccWMDtzNtKkTuevzny2Nii2RUDNrl5q79kOPNP/3DB
	MqY53vv/ruU7zOe6kwhlG0CRMA==
X-Google-Smtp-Source: AGHT+IGKvH+GBgAKQHWDhZZV09OE+zv1MgYwJxJsoDg2/XCIHmz1dXnuC31AHBwhEWMoUKUR5gkSfQ==
X-Received: by 2002:a17:906:5d:b0:9a5:846d:d823 with SMTP id 29-20020a170906005d00b009a5846dd823mr6109942ejg.45.1693206919659;
        Mon, 28 Aug 2023 00:15:19 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.225])
        by smtp.gmail.com with ESMTPSA id fx13-20020a170906b74d00b00982be08a9besm4376385ejb.172.2023.08.28.00.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:15:19 -0700 (PDT)
Message-ID: <d6f796aa-c468-037c-3f53-d0c4306c8890@linaro.org>
Date: Mon, 28 Aug 2023 09:15:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/4] dt-bindings: net: Add Loongson-1 Ethernet
 Controller
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230824125012.1040288-1-keguang.zhang@gmail.com>
 <20230824125012.1040288-3-keguang.zhang@gmail.com>
 <dwe4oyunc2uitullflhryg7kmgeklj5wlx6ztrg5hahl64tkuz@koe4tijgj3bp>
 <c32130ab-27dc-e991-10fd-db0fba25cc97@linaro.org>
 <q7o7wqodz5epyjdj7vlryaseugr2fjhef2cgsh65trw3r2jorm@5z5a5tyuyq4d>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <q7o7wqodz5epyjdj7vlryaseugr2fjhef2cgsh65trw3r2jorm@5z5a5tyuyq4d>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/08/2023 23:01, Serge Semin wrote:
> Hi Krzysztof
> 
> On Sun, Aug 27, 2023 at 09:56:06AM +0200, Krzysztof Kozlowski wrote:
>> On 26/08/2023 23:04, Serge Semin wrote:
>>>> +  clock-names:
>>>> +    items:
>>>> +      - const: stmmaceth
>>>
>>>   clock-names:
>>>     const: stmmaceth
>>> ?
>>
> 
>> The existing syntax is correct. This is a string array.
> 
> Could you please clarify whether it's a requirement (always specify
> items: property for an array) or just an acceptable option (another
> one is suggested in my comment)? I am asking because:
> 1. In this case the "clock-names" array is supposed to have only one
> item. Directly setting "const: stmmaceth" with no items: property
> shall simplify it.
> 2. There are single-entry "clock-names" property in the DT-bindings
> defined as I suggested.
> 3. There is a "compatible" property which is also a string array but
> it can be defined as I suggested (omitting the items property).
> 
> so based on all of that using the "items:"-based constraint here seems
> redundant. Am I wrong to think like that? If so in what aspect?

Syntax is correct in both cases. However the single list compatible
*cannot grow*, while single list clock might, when developer notices
that the binding was incomplete. People add binding matching drivers,
not the hardware, thus having incomplete list of clocks is happening all
the time.

Best regards,
Krzysztof


