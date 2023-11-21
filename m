Return-Path: <netdev+bounces-49631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811857F2D01
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F1CB218CD
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D54A997;
	Tue, 21 Nov 2023 12:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jewNDVXw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BF137
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 04:20:58 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5409bc907edso7608963a12.0
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 04:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700569257; x=1701174057; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FrwKdUOQTL6e14/zDzjYxE8ID/8xpFBXEVT3hh8Z10g=;
        b=jewNDVXwTrHeDo7yau2boJvtNp2bHe02fY1cCoZhxxdCdBY5TmDUFgCDG564rnnfKD
         Kjb+yDG1ldzl82T7IEjceoS5rW3EpZBsth+df/GEWSoodXGjjRyeX1o6Vh3XdlpP7ssq
         Zp2r/XpYCnOaRuKshF8087IjeGJ6wSzoVlV9zLj3qM4lcm2kpdwqPhdoTS9wQdC23djT
         w57F+hpMu0+h4uM29X3MKsnt/TziWPTj5yMO4H1TOlPKRB3dDJIFWANgn1fDwc6FFu/4
         FHhyySxS2JiSwxLikR8gU69UTQz72vRHsI8/38uNK7FhPkgSgp64cyPEMLU9MUm4lLZj
         x30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700569257; x=1701174057;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrwKdUOQTL6e14/zDzjYxE8ID/8xpFBXEVT3hh8Z10g=;
        b=gLZYmq6IxclwnzgHf6FhmssOy6GlqwrVWrqp4NtXOLzUMkxSIydw4JUecJ5tlbc27U
         tlZsVWvJyq4g4ql9SZSbOdFJ0PPshazpnB0iCVH666XusWm8UmRga1yLAkMUCkbhkBK5
         0RGp4uC/oVBVk0C7e2+aYhEwOsdvCwb5VIQulKgkZoIFNk7WwEHyAvw+tu21Q+aHlqXL
         8Czf9/tkBWx5IGstncyYMbnsVb2YA0pvGIMtu6F7d/uQdWFjAQ8I40Syh75wODCAIErZ
         zCwqt7Ik0Rmq3YlCZ7N4qLsP1yiCJ+QHOql3BYU0wClheRDB2zEmlGfrUUQhsICd23Tl
         3CCg==
X-Gm-Message-State: AOJu0YzCAd7sn4nzJ7qMte+U6XeefGYT1bRjr+vJhD3LG/Pflu8JoJn9
	RTieD2MfpT3njbQISiwtdOuJ6Q==
X-Google-Smtp-Source: AGHT+IFvxZl9JDbZLXAUArq09qgXb4yDQdUfnBtbSxcXXPwC9OMXQU9WljdApPNltwVtnUw8iQ0AGg==
X-Received: by 2002:a17:906:ba8e:b0:9dd:30c8:6f2f with SMTP id cu14-20020a170906ba8e00b009dd30c86f2fmr10117645ejd.27.1700569257251;
        Tue, 21 Nov 2023 04:20:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b009c3f8f46c22sm5187002ejb.77.2023.11.21.04.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 04:20:56 -0800 (PST)
Message-ID: <2ffb39c3-7939-46f2-8ca9-2b2cb44caaff@linaro.org>
Date: Tue, 21 Nov 2023 13:20:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: net: renesas,ethertsn: Add bindings for
 Ethernet TSN
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20231120160740.3532848-1-niklas.soderlund+renesas@ragnatech.se>
 <2ab74479-f1fb-4faf-b223-ae750b4c08ce@linaro.org>
 <ZVyeMKjVhjW2F2e0@oden.dyn.berto.se>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZVyeMKjVhjW2F2e0@oden.dyn.berto.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/11/2023 13:10, Niklas Söderlund wrote:
>>> +
>>> +  phy-handle:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      Specifies a reference to a node representing a PHY device.
>>
>> You miss top-level $ref to ethernet controller
> 
> Sorry I don't fully understand what you are asking here, there are a few 
> things about bindings I still need to learn. Looking at other bindings 
> some have a
> 
> maintainers:
>   ..
> 
> allOf:
>   - $ref: ethernet-controller.yaml#

This one.

> 
> properties:
>  ..
> 
> Is it this all ollOff node I'm missing?
> 
>>
>>> +
>>> +  renesas,rx-internal-delay:
>>> +    type: boolean
>>> +    description:
>>> +      Enable internal Rx clock delay, typically 1.8ns.
>>
>> Why this is bool, not delay in ns?
> 
> The TSN is only capable of enabling or disable internal delays, not set 
> how long the delay is. The documentation states that the delay depends 
> on the electronic characteristics of the particular board, but states 
> that they typically are 1.8ns for Rx and 2.0ns for Tx.

I don't understand that part. If you cannot configure the internal
delay, how could it depend on the board characteristics?

> 
> I looked at the generic properties {rx,tx}-internal-delay-ps but they 
> are of int type. So I opted for a vendor specific bool property. Do you 
> think a better route is to use the generic property and force the value 
> to be either 0 or the typical delay?
> 
>> Why this is property of a board (not SoC)?
> 
> I'm sorry I don't understand this question.

Why setting internal delay is specific to a board, not to a SoC? Why
each board would need to configure it? On which parts of hardware on the
board does this depend?


Best regards,
Krzysztof


