Return-Path: <netdev+bounces-45405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4C7DCB48
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EC6281022
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 11:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FAE18C2D;
	Tue, 31 Oct 2023 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ut52fJKP"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387C111BA;
	Tue, 31 Oct 2023 11:01:07 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA4A6;
	Tue, 31 Oct 2023 04:01:05 -0700 (PDT)
Received: from [100.116.17.117] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 357F766073A4;
	Tue, 31 Oct 2023 11:01:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1698750064;
	bh=7i4L1gq9GTQdB9bIM1L/ajdeUm7F+CvMd9bg+rP0cDY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ut52fJKPN1zfqlv6rUpMovwC7ndfxzSTZs7G3NPsVQFCGhKFXlA8Ka//XbDcXfPf5
	 NWRV3qXXXV3NFtYoJHJEz44vaWYtmUGOK4YAQPTl6Br5B/UjpEqlVtaaWjQdeZAxli
	 9YwX0zOsUIPSPJ9hEI80CMqOsobA+55TBDZakhPKwInf5DjkcxUgWQC67UcVXXfzWL
	 mF3I24QkTAvlie/uYqlZtG7mPDzLKulDUspn2b4NnFS/CUC0yEqMEaSOIahs3BSARQ
	 Rzv1ciPJ1Dr0tr/GXXJFk1dbo2Crq62HeM7cFU4W8nQ2SoQV+MyXL2TNKk8x269C4R
	 uJPUqBNrpfsww==
Message-ID: <f3b66f3a-50a2-4c1b-830b-ad6d87b471e5@collabora.com>
Date: Tue, 31 Oct 2023 13:00:59 +0200
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
 <3016eff2-fce5-4b5e-bbb2-d56cbb45df85@linaro.org>
 <05186c62-fcad-4d56-8ae8-d802f87a39e2@collabora.com>
 <98d90ba9-7e69-4b54-830d-bdbc0e6c54fe@linaro.org>
 <d532514a-524c-4607-b97b-2f89bc563406@collabora.com>
 <b67ee496-397b-42f1-8109-542878934385@linaro.org>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <b67ee496-397b-42f1-8109-542878934385@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/23 07:48, Krzysztof Kozlowski wrote:
> On 30/10/2023 20:07, Cristian Ciocaltea wrote:
>> On 10/30/23 09:26, Krzysztof Kozlowski wrote:
>>> On 29/10/2023 23:24, Cristian Ciocaltea wrote:
>>>> On 10/29/23 13:25, Krzysztof Kozlowski wrote:
>>>>> On 29/10/2023 05:27, Cristian Ciocaltea wrote:
>>>>>> The Synopsys DesignWare MAC found on the StarFive JH7100 SoC requires
>>>>>> just the 'ahb' reset name, but the binding allows selecting it only in
>>>>>> conjunction with 'stmmaceth'.
>>>>>>
>>>>>> Fix the issue by permitting exclusive usage of the 'ahb' reset name.
>>>>>>
>>>>>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 2 +-
>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>>>> index 5c2769dc689a..a4d7172ea701 100644
>>>>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>>>>> @@ -146,7 +146,7 @@ properties:
>>>>>>    reset-names:
>>>>>>      minItems: 1
>>>>>>      items:
>>>>>> -      - const: stmmaceth
>>>>>> +      - enum: [stmmaceth, ahb]
>>>>>
>>>>> Also, this makes sense only with patch #4, so this should be squashed there.
>>>>
>>>> I added this as a separate patch since it changes the generic schema
>>>> which is included by many other bindings.  JH7100 just happens to be the
>>>> first use-case requiring this update.  But I can squash the patch if
>>>> that's not a good enough reason to keep it separately.
>>>
>>> If there is no single user of this, why changing this? I would even
>>> argue that it is not correct from existing bindings point of view -
>>> nothing allows and uses ahb as the only reset. Even the commit msg
>>> mentions your hardware from patch 4.
>>
>> Sorry, I'm not sure I follow. JH7100 is (or will be) the user of it and,
>> as a matter of fact, something similar has been done recently while
>> adding support for JH7110.
> 
> Every patch should stand on its own and at this point nothing uses it.
> We apply this patch #1 and we add dead code, unused case.
> 
>>
>> In particular, commit [1] changed this binding before the JH7110
>> compatible was introduced in a subsequent patch. On a closer look that
>> commit made a statement which is not entirely correct:
>>
>> "dwmac controller may require one (stmmaceth) or two (stmmaceth+ahb)
>> reset signals"
>>
>> That's because stmmaceth is also optional in dwmac's driver, hence the
>> correct message would have been:
>>
>> "[...] may require one (stmmaceth OR ahb) [...]"
> 
> Driver does not describe the hardware. The bindings do, so according to
> that description all supported hardware required MAC reset (stmmaceth).
> Otherwise please point me to any hardware which skips MAC reset and
> requires AHB reset instead (not future hardware, but current).

I might have found one (arch/arm/boot/dts/allwinner/sun6i-a31.dtsi):

    gmac: ethernet@1c30000 {
        compatible = "allwinner,sun7i-a20-gmac";
        [...]
        resets = <&ccu RST_AHB1_EMAC>;
        reset-names = "stmmaceth";
        [...]
    };

It's possible the 'stmmaceth' naming has been used instead of 'ahb' just
to avoid updating the binding, but that's just an assumption looking at
RST_AHB1_EMAC.

I will proceed with the squash for v3.

Thanks for clarifying,
Cristian

