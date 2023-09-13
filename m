Return-Path: <netdev+bounces-33612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E169D79ED91
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E07281FA5
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209661F924;
	Wed, 13 Sep 2023 15:46:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9061A721
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 15:46:00 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAD7E3
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:45:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a49a42353so8998566a12.2
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 08:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694619958; x=1695224758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWMmHby+0Ho6yfR2tcaVbJfSP8pJ0Ogv81Df7xoDU78=;
        b=S6V0qjdhXqzXmU7lSA6fFc5Zz7QZLykBGd5c91lcWcw7eicz4QLGCUtFDiC4qb3qgF
         L/559aDHwxQ40wMuBReylB7me+apQkS8fFoZwCN3nO0S4YI6KfrhQnhJGRK8sS0JOO2n
         rDE5pNSksPVkQouhcKMtW6J82AZF/BDa+f9QE+ChTeGBlomZ5x51f9sYL1IutaAet2Gy
         fQLAb4z7YWCpn4hOE2bgYpWrA2m9MjLH8lPHOwsG9GYxBWhjz5aM8ij92+Z1SCBaVLXa
         vSSCJ867eJBpyFFJ0U9atMZAaWHtTGY6lgnh6o55xq3hVutvH0pMmNmkKRG8ak6AryxL
         Er5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619958; x=1695224758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWMmHby+0Ho6yfR2tcaVbJfSP8pJ0Ogv81Df7xoDU78=;
        b=SeykohdMsyV3xb8dzbW+b6eBnU75sCiCayXDNiEG5BS16ovyWKp/oZ+eXDs9c8FRjx
         cFNdrEQzB5S+Z8TrzyM1V8NzZj/yenlei6CjSXPIm3NEJjv/JlmegYXPbaV0czOepFhV
         YZFWVk/rlNdbDfUpyGwrO2mwdoGKgje4VajBHETW/OfiHldCkG5gctMr3mBM185WDeG1
         4sY3owtnXGrgUBw0AwO7TLZkfcHvmHECyNaUdRKnGSKwOlOswjXpTeWvF3v+PfuiRUnF
         l41S92HQNhrKcPbHJKVNdPzK8HTEaNf2V3UNjpYAP7L66Y3wbFnG+XMafyUrJvXS8JYR
         0Ygw==
X-Gm-Message-State: AOJu0Yxj6EcD63AhDx4ydHy/LMmB8Nh1iXMfuuf4yje90a3c8Pwnj7W/
	GEzoTSCKU10405u3my5zCX8ir/wNwIYfGNSfSN4=
X-Google-Smtp-Source: AGHT+IG+j7fagSsVnPo1xWjGNdW2WcBfrquWrkAv0F12qO6ETU4PsXAeD0r9nP+0+/bEg76v7UR5Vg==
X-Received: by 2002:a17:906:2091:b0:99d:dc0b:a89a with SMTP id 17-20020a170906209100b0099ddc0ba89amr2762962ejq.63.1694619958378;
        Wed, 13 Sep 2023 08:45:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id z24-20020a170906075800b0099b7276235esm8557639ejb.93.2023.09.13.08.45.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:45:57 -0700 (PDT)
Message-ID: <588db15e-62f1-ca9e-211c-21d58e15bd73@linaro.org>
Date: Wed, 13 Sep 2023 17:45:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 0/6] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Content-Language: en-US
To: Parthiban.Veerasooran@microchip.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Horatiu.Vultur@microchip.com, Woojung.Huh@microchip.com,
 Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
 Thorsten.Kummermehr@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, corbet@lwn.net,
 Steen.Hegelund@microchip.com, rdunlap@infradead.org, horms@kernel.org,
 casper.casan@gmail.com, andrew@lunn.ch
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <eef69aa5-73c2-9789-9f6d-c3300553c44d@linaro.org>
 <fab8908e-ce74-eff0-8e67-6259b3ad5e1e@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fab8908e-ce74-eff0-8e67-6259b3ad5e1e@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2023 15:26, Parthiban.Veerasooran@microchip.com wrote:
> Hi Krzysztof,
> 
> On 10/09/23 4:25 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 08/09/2023 16:29, Parthiban Veerasooran wrote:
>>> This patch series contain the below updates,
>>> - Adds support for OPEN Alliance 10BASE-T1x MACPHY Serial Interface in the
>>>    net/ethernet/oa_tc6.c.
>>> - Adds driver support for Microchip LAN8650/1 Rev.B0 10BASE-T1S MACPHY
>>>    Ethernet driver in the net/ethernet/microchip/lan865x.c.
>>
>> And why is this RFC? Do you mean by that it is buggy and not finished,
>> so we should not review?
> 
> No, this is not a buggy/unfinished patch series. I have added RFC as 

I don't understand how people name their stuff RFC. Some send totally
buggy and untested bindings under RFC and, after receiving feedback,
respond surprised - it was just RFC!

Other send RFC and expect review.

Just call it a PATCH. PATCH is Requesting for Comments.

Best regards,
Krzysztof


