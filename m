Return-Path: <netdev+bounces-45262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4D17DBC09
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 15:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43EF5B20BF5
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 14:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F517981;
	Mon, 30 Oct 2023 14:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCGDb+RF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B115EB0
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 14:45:40 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F85C2
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:45:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-32ded3eb835so3441221f8f.0
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 07:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698677136; x=1699281936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szEFjozfjQlU1fIpP+2UlllDpbLkMMNkDieto4qaR9U=;
        b=sCGDb+RFqYEkFpIx2qLRuwM+1wmDURPtAkLGN/nsHo01bFEcjhRcx6e/HHx04cp9s4
         VIo2yZsvNpexa0wR3zrvBMQNv0vfGGAsAdup+ve68q5L34bjuvPSpV8gzNFPB77bEmEU
         wJdvi0nM3RkGR32KqK1mzaHfuF6LolYZbyD0vk7rPiv/X2Dythj3a28w8K0s9pgvMzln
         5wrPFnEeKYg0XvaJqIJGA0tRz3Ty4xJu/xQDeVBVO4A0s7i8Frk0t02CQ6JokJXDWwIb
         G4EelTajE2iYk6tVjnKQSc52nnGWJ+405Dcy4oQ4Km0EFcMFm1BF0kRqPHCgAzV+WQS9
         QaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698677136; x=1699281936;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szEFjozfjQlU1fIpP+2UlllDpbLkMMNkDieto4qaR9U=;
        b=WzyXdshK19kf8NC7+f3mt+WqrY/nl2wvPynQGYfRS+4Ho7W6sdkDyzdnDwv35tsj+/
         SfeIGwF3j7Nva0XEY/RpUqP0UQVyaX8A7/KQsN36mqIXreP5NvaeUaqh41qNqTqKeQog
         TMroDj5D5D1PcJ9OvPNZFvz6cvFkxFbdjA+h/N7K2Um5gTOWkG43DBFfb4A17TL3yIzQ
         5OEB07hfgDZgxcTL0jFAWCiOJrmWaUc+HwTLTR6N38ihsopoPcLL30Sa/9KGexrxSXk0
         LwGfbdOVTkRsvYIdkwhg3N9kKIxq2Jdc9UP78dDdd8ep2VWMpzVfbNYSgeeslPGtFPXb
         dXcg==
X-Gm-Message-State: AOJu0Yyn8VeH13oPuHoN3DAuobPiD8Vlz9M21owH7rXdUoOsTQjNU9eU
	4CplgMvGBDsxHIbyc3MHgoHDyQ==
X-Google-Smtp-Source: AGHT+IHL7rufCPYYwtK8AHSway8F5cicDHnVBNyeHVBibhD4S35vO8lUcRk45zQ2iN3OloyKIi1Liw==
X-Received: by 2002:adf:9c91:0:b0:32d:adda:e8ca with SMTP id d17-20020adf9c91000000b0032daddae8camr7350366wre.22.1698677136128;
        Mon, 30 Oct 2023 07:45:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id w16-20020adfee50000000b0032db1d741a6sm8387969wro.99.2023.10.30.07.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:45:35 -0700 (PDT)
Message-ID: <08ad71a0-daf1-4588-a97c-95f3ee5df84e@linaro.org>
Date: Mon, 30 Oct 2023 15:45:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 9/9] dt-bindings: net: add Microchip's LAN865X
 10BASE-T1S MACPHY
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
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-10-Parthiban.Veerasooran@microchip.com>
 <91764d23-eed2-48f9-97c5-ac6a44f48f2b@linaro.org>
 <3ee02690-8912-47b4-a97e-6d364969c956@microchip.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3ee02690-8912-47b4-a97e-6d364969c956@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/10/2023 14:16, Parthiban.Veerasooran@microchip.com wrote:
> Hi Krzysztof,
> 
> On 24/10/23 1:33 pm, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 23/10/2023 17:46, Parthiban Veerasooran wrote:
>>> Add DT bindings for Microchip's LAN865X 10BASE-T1S MACPHY. The LAN8650/1
>>> combines a Media Access Controller (MAC) and an Ethernet PHY to enable
>>> 10BASE‑T1S networks. The Ethernet Media Access Controller (MAC) module
>>> implements a 10 Mbps half duplex Ethernet MAC, compatible with the IEEE
>>> 802.3 standard and a 10BASE-T1S physical layer transceiver integrated
>>> into the LAN8650/1. The communication between the Host and the MAC-PHY is
>>> specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6).
>>
>> It does not look like you tested the bindings, at least after quick
>> look. Please run `make dt_binding_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>> Maybe you need to update your dtschema and yamllint.
> Sorry, somehow I missed doing this check. Will fix this in the next 
> revision.

Please also build your driver.

>>
>>>
>>> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
>>> ---
>>>   .../bindings/net/microchip,lan865x.yaml       | 101 ++++++++++++++++++
>>>   MAINTAINERS                                   |   1 +
>>>   2 files changed, 102 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/microchip,lan865x.yaml b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>>> new file mode 100644
>>> index 000000000000..974622dd6846
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/microchip,lan865x.yaml
>>> @@ -0,0 +1,101 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/microchip,lan865x.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Microchip LAN8650/1 10BASE-T1S MACPHY Ethernet Controllers
>>> +
>>> +maintainers:
>>> +  - Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
>>> +
>>> +description:
>>> +  The LAN8650/1 combines a Media Access Controller (MAC) and an Ethernet
>>> +  PHY to enable 10BASE‑T1S networks. The Ethernet Media Access Controller
>>> +  (MAC) module implements a 10 Mbps half duplex Ethernet MAC, compatible
>>> +  with the IEEE 802.3 standard and a 10BASE-T1S physical layer transceiver
>>> +  integrated into the LAN8650/1. The communication between the Host and
>>> +  the MAC-PHY is specified in the OPEN Alliance 10BASE-T1x MACPHY Serial
>>> +  Interface (TC6).
>>> +
>>> +  Specifications about the LAN8650/1 can be found at:
>>> +    https://www.microchip.com/en-us/product/lan8650
>>> +
>>> +allOf:
>>> +  - $ref: ethernet-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: microchip,lan865x
>>
>> No wildcards in compatibles.
> Ah ok missed it. So it will become like below isn't it?
> 
> properties:
>    compatible:
>      enum:
>        - microchip,lan8650
>        - microchip,lan8651

Rather enum for lan8650 and items for lan8651 with fallback. Aren't they
compatible, since you wanted to use wildcard?


Best regards,
Krzysztof


