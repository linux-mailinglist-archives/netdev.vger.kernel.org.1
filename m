Return-Path: <netdev+bounces-45104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D27DAEB3
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80AD21C208CA
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 22:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0612E51;
	Sun, 29 Oct 2023 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O+GZqN62"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCED11C97;
	Sun, 29 Oct 2023 22:02:26 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B23EB7;
	Sun, 29 Oct 2023 15:02:25 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.143.101])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B00166072BB;
	Sun, 29 Oct 2023 22:02:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698616943;
	bh=vk26fELTpT3lCmDhyB1BjvWl5h7dQQR7ACLCNBDPifc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=O+GZqN62WN5APTjARqZkYPmUNIns8iAzqU5RwVcknHv5gn2dalAdOrAvgfZZAN1wO
	 FR82nLLqV7LKaCA7id+z6mFSgps0dFV/FVfrU722pMDmqJAhs2QB+72cdXVQc4mbJm
	 ugmR5k8zhDJur7w4odrYO6R9fzpo8xTaNIDiOc+I8d9lL5nI7uONAbE9g99uLOcFYp
	 iKLWHjI0BNIHuPBK0QNimyIhU/DPJ6bRVtAC4C4vnL2sstX4h0/vYgTydKKegOW1p9
	 jI9XG6Nb3s2U5Qo/oOAeoxmpiYi2fBBwM0sTcipjkdQC5sO398jKwS7iXzNMKYSnqo
	 JxdXwhGZ4fZjw==
Message-ID: <ee857617-9be9-45ae-a488-3842caf9013b@collabora.com>
Date: Mon, 30 Oct 2023 00:02:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: net: snps,dwmac: Allow exclusive
 usage of ahb reset
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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
 <20231029042712.520010-2-cristian.ciocaltea@collabora.com>
 <e2c65d01-3498-4287-a6dc-b926135df762@linaro.org>
 <564503dd-b779-4e9f-851d-f34d9ea5fa65@collabora.com>
In-Reply-To: <564503dd-b779-4e9f-851d-f34d9ea5fa65@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/23 23:55, Cristian Ciocaltea wrote:
> On 10/29/23 13:21, Krzysztof Kozlowski wrote:
>> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>>> The Synopsys DesignWare MAC found on the StarFive JH7100 SoC requires
>>> just the 'ahb' reset name, but the binding allows selecting it only in
>>> conjunction with 'stmmaceth'.
>>>
>>> Fix the issue by permitting exclusive usage of the 'ahb' reset name.
>>>
>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> index 5c2769dc689a..a4d7172ea701 100644
>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> @@ -146,7 +146,7 @@ properties:
>>>    reset-names:
>>>      minItems: 1
>>>      items:
>>> -      - const: stmmaceth
>>> +      - enum: [stmmaceth, ahb]
>>
>> Your patch #3 says you have minimum two items. Here you claim you have
>> only one reset. It's confusing.
> 
> At least the following use-cases need to be supported:
> 
> - JH7110: reset-names = "stmmaceth", "ahb";
> - JH7110: reset-names = "ahb";

I've just realized my mistake here - this is for JH7100, sorry for the
confusion:

- JH7100: reset-names = "ahb";

> - other:  reset-names = "stmmaceth";
> 
> Since this is the schema which gets included later in other bindings,
> the property needs to be generic enough to cope with all the above.
> [added actual content here for more clarity]
> 
>   reset-names:
>     minItems: 1
>     items:
>       - enum: [stmmaceth, ahb]
>       - const: ahb
> 
> Therefore, only the lower limit (1) is enforced here, while
> starfive,jh7110-dwmac.yaml (which PATCH 3 relates to) adds further
> constraints (limiting to precisely two items):
> 
>     reset-names:
>       items:
>         - const: stmmaceth
>         - const: ahb
> 
> I understand the generic binding also allows now specifying 'ahb' twice,
> but I'm not sure if there's a convenient way to avoid that (e.g. without
> complicating excessively the schema).

