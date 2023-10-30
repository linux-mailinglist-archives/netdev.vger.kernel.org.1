Return-Path: <netdev+bounces-45311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C17DC0E6
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 21:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114A2B20D52
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069CC1A728;
	Mon, 30 Oct 2023 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KMC8RmIq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9A1D266;
	Mon, 30 Oct 2023 20:02:46 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DAFF9;
	Mon, 30 Oct 2023 13:02:44 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4E56A6607393;
	Mon, 30 Oct 2023 20:02:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698696163;
	bh=uO9kOx6FyYOhUQqCre9IC5JYGMe00wfHPt3Z51gKaCw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KMC8RmIq7yyYms1wPJND7cKAylDHwfxmvbG0kAnRHCIBhAdNzjbC5YNsAosIOBVaW
	 KDt+6NUawFqs/TozlkoipWSu3hQKjL0n0JIXE4zlPqW/fJt55X9wkC+NsTqKaEzhB4
	 iQzUqHzI1A/+cGNCBugC3nhz3o13Ms8geoOpXkPmSUkGku2RaxmqirWtYnabCAtCE2
	 BuI6e8+d3jTVlv22YZjXNxLOU9GAIog9TmkcHhrKVuYI4NCXf3n6X+X7dppOUxvN5l
	 vMS5suy4PyZPRVoYFtH6/Nm1S3PxuhpIEmE1F9JrU26ELv+qtx28N9igxBTlmMRpOq
	 yZQgG+niCuAaA==
Message-ID: <c47d2730-cbb4-43d2-aa51-ce439d67eabf@collabora.com>
Date: Mon, 30 Oct 2023 22:02:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/12] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>,
 Samin Guo <samin.guo@starfivetech.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20231029042712.520010-1-cristian.ciocaltea@collabora.com>
 <20231029042712.520010-5-cristian.ciocaltea@collabora.com>
 <e8f18634-7187-4e5a-a494-329c7c602fd2@linaro.org>
 <e86247b3-a6f4-44cf-90c4-583d850f6dd8@collabora.com>
 <35556392-3b9a-4997-b482-082dc2f9121f@linaro.org>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <35556392-3b9a-4997-b482-082dc2f9121f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/23 09:30, Krzysztof Kozlowski wrote:
> On 29/10/2023 23:15, Cristian Ciocaltea wrote:
>> On 10/29/23 13:24, Krzysztof Kozlowski wrote:
>>> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>>>> The Synopsys DesignWare MAC found on StarFive JH7100 SoC is quite
>>>> similar to the newer JH7110, but it requires only two interrupts and a
>>>> single reset line.
>>>>
>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>> ---
>>>>  .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
>>>>  .../bindings/net/starfive,jh7110-dwmac.yaml   | 74 +++++++++++++------
>>>>  2 files changed, 54 insertions(+), 21 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> index a4d7172ea701..c1380ff1c054 100644
>>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>> @@ -95,6 +95,7 @@ properties:
>>>>          - snps,dwmac-5.20
>>>>          - snps,dwxgmac
>>>>          - snps,dwxgmac-2.10
>>>> +        - starfive,jh7100-dwmac
>>>>          - starfive,jh7110-dwmac
>>>>  
>>>>    reg:
>>>> diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>>>> index 44e58755a5a2..70e35a3401f4 100644
>>>> --- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
>>>> @@ -13,10 +13,14 @@ maintainers:
>>>>  
>>>>  properties:
>>>>    compatible:
>>>> -    items:
>>>> -      - enum:
>>>> -          - starfive,jh7110-dwmac
>>>> -      - const: snps,dwmac-5.20
>>>> +    oneOf:
>>>> +      - items:
>>>> +          - const: starfive,jh7100-dwmac
>>>> +          - const: snps,dwmac
>>>> +      - items:
>>>> +          - enum:
>>>> +              - starfive,jh7110-dwmac
>>>> +          - const: snps,dwmac-5.20
>>>
>>> Why do you use different fallback?
>>
>> AFAIK, dwmac-5.20 is currently only used by JH7110.
> 
> What is used by JH7000?

Driver reports "Synopsys ID: 0x37", so it could be 3.70a or 3.710, as
those are the only compatibles available for 3.7x.

It's worth noting the driver does not rely on the compatibles for
implementing version specific logic, as it gets the IDs directly from
chip registers.

The usage of generic snps,dwmac fallback was borrowed from downstream code.

Regards,
Cristian

