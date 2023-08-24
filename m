Return-Path: <netdev+bounces-30225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3BE07867CD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD44B281449
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 06:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DDA24548;
	Thu, 24 Aug 2023 06:51:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957DC2453C
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:51:00 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF90101
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:50:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso7960009a12.3
        for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692859857; x=1693464657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhmEfKLm2auvLzU1H0Y+LxP11/52EFLaIX+4lk/LSDc=;
        b=uTd/E1u5tM2WP4N5gUw0ZdqO06dkIsLwIzV3VW59B30K7dsNk4+Wgsv/G/VNTusLV3
         WzL44SI+wBc12C3TsBFHCT9z13n+cIfKa925OMquWlob3sVmkvhOiAdIl2bg5En25yAy
         eizvtKqx7N0PElDsXtV19Yo93PqK3v9KfZI8y9korGVDqE0eOnSvcge7cjMBUgIXh0Ib
         XByk9LhlJ1h/ipGeexkoz4snAwTBmFT+kTO8yEb51QProGbuHwkn19ElV7kSJVkwN5VR
         dJlxE6xZ6H+WFjuMFM4S0e4uURIGa1rO+fleNSuxKtTzgz6qvzh/9mvfBG86R00HVwyw
         F8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692859857; x=1693464657;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhmEfKLm2auvLzU1H0Y+LxP11/52EFLaIX+4lk/LSDc=;
        b=QXrLq1yD1MsRwSVSdeAUqfQvoLgKZxnwx6wARnxt5kru1RlUSFLMHypl7TULbLPsRF
         bhQFnveI27nWF367h9soWvlSfG5M2zEyTQXPWqPLl3iV7Nhi3G63V7hd8JQdFJfhYvI+
         jkEqm72Nk+rF0yFMtEmPNx/OxEEgRf3vk0Xoqu/U6XXt8sL3N4S/oAbFB4Tk7f0Oq36r
         oQNpOvBVI86th/e5AjzffEFYZl4kEVMx8/bCzfHKoCnhAE/89W370fW/8mrtyiMH688O
         seQ/Eb296QRiwAL24nFoVba09OFGUt7fmkGPyTIAUap7ryf2YnYJCddnLsuM/lBTij6o
         +AyQ==
X-Gm-Message-State: AOJu0Yzhlmtdx1JF+Js1pMvMv12/PKkuDDOYaQbjUz8W4km3pVvRQFf1
	lgz0BdaqPoSDFVtCFCCj/z7vhQ==
X-Google-Smtp-Source: AGHT+IFKOvRo7+2xMvm/brGQ+qgng4Ksbl2gcHnXtNfV23t2a5eGx8+E9rqMZ5Gn8A/xmHc8/noUWg==
X-Received: by 2002:a05:6402:505:b0:523:4922:c9c4 with SMTP id m5-20020a056402050500b005234922c9c4mr11878649edv.11.1692859857524;
        Wed, 23 Aug 2023 23:50:57 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id c22-20020aa7c756000000b00522572f323dsm10023230eds.16.2023.08.23.23.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Aug 2023 23:50:57 -0700 (PDT)
Message-ID: <3362bfaf-225b-0eb7-5219-9c2b365cafe5@linaro.org>
Date: Thu, 24 Aug 2023 08:50:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/5] dt-bindings: net: Add ICSS IEP
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
 <20230823113254.292603-2-danishanwar@ti.com>
 <d5a343c8-c384-6eea-94bf-e0c4f96e5fb0@linaro.org>
 <a91e7db9-e442-acff-befd-2fa63e209b0a@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a91e7db9-e442-acff-befd-2fa63e209b0a@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/08/2023 08:47, Md Danish Anwar wrote:
> Hi Krzysztof,
> 
> On 24/08/23 12:13 pm, Krzysztof Kozlowski wrote:
>> On 23/08/2023 13:32, MD Danish Anwar wrote:
>>> Add a DT binding document for the ICSS Industrial Ethernet Peripheral(IEP)
>>> hardware. IEP supports packet timestamping, PTP and PPS.
>>>
>>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>>
>> Really? Where?
> 
> Conor gave his RB tag for patch 1 and 2 in v4
> https://lore.kernel.org/all/20230814-quarters-cahoots-1fbd583baad9@spud/

OK, My mistake, cover letter was not the place where I was looking for
Conor's reviews...

>>
>>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>>
>> Now you are making things up. Please stop faking tags.
> 
> Roger provided his RB tag in v5 for all the patches
> https://lore.kernel.org/all/5d077342-435f-2829-ba2a-cdf763b6b8e1@kernel.org/
>>
>>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>> Where?
>>
> 
> Simon gave his RB tag for all the patches of this series in v5
> https://lore.kernel.org/all/ZN9aSTUOT+SKESQS@vergenet.net/

OK, I still question though reviewing own code.



Best regards,
Krzysztof


