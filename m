Return-Path: <netdev+bounces-131550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3898ED32
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 12:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 574171F226D9
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E365914D44D;
	Thu,  3 Oct 2024 10:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYDvPl/7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B681413D882;
	Thu,  3 Oct 2024 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727952139; cv=none; b=Fx3LO6QrVdONulBnF+eMdnamMj6wZaVf4maRoiR02f91xK3AdXXG0jSLqLNaoZiBTwoOu8hP/xJmzD806is8xGhVmPLumNquA2L+B1J7AcX4H5UueMCJGgxlHyToQi5yPsvMjlRy4u5mjNdRPjJeh0AVSin3/gTtKnURZqqqYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727952139; c=relaxed/simple;
	bh=a9KmoXJsFEjWSCOH7kCcCjD1NTNIR2CLPy5YKmcNJKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzTp6VEjI17rUMjMVmDzCVLfu08KVYER4FmEJeHVv4od5QBJz6bHQxUZ3kkFOyLhEE4LfO0q3QzYfLGfpSDYiiguVOwvS8VG5DHeShsu/yACSG3c2SPZ6rXQ4wXuIc/zDHdJiAfRtnatHu+14p4yjHb4xjXGNEl3D0KXDOj9ww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYDvPl/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A18AC4CEC7;
	Thu,  3 Oct 2024 10:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727952138;
	bh=a9KmoXJsFEjWSCOH7kCcCjD1NTNIR2CLPy5YKmcNJKw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FYDvPl/7Y3AD+UT7KDhhmsWI/4AqOIYOSg8ZMLsUb/E0o4IHlkZQgQ7PGS4dIPIap
	 3t721t1RSCZvOrh5q1v8tlqSwlbU3bbZAzktZLuzWngvAA/437w/8PU6vvDjWoLXFt
	 Krel1zVBGmMqbMXo73G3cmMQZYNWXbP06pSZfdVJ8E3BOPOdemCjodG29d3rKFa18q
	 o4F+du1pZjTDiajhO8z1Ovw/O8W6xQoEKhzEm4KXQEBrL9lwhQEvEpIUxCawV7EY8I
	 GUh2bai96Aps1tWETgz2Thzvof08CSsX4IdYr7Y4VLuLKcAu/RxZFxbujjVktkUBEK
	 REuiz2tGStUAA==
Message-ID: <8f0a6e27-df0c-41fb-8714-10fdfbe976ab@kernel.org>
Date: Thu, 3 Oct 2024 12:42:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: net: Add T-HEAD dwmac support
To: Drew Fustini <dfustini@tenstorrent.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>,
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org
References: <20240930-th1520-dwmac-v3-0-ae3e03c225ab@tenstorrent.com>
 <20240930-th1520-dwmac-v3-1-ae3e03c225ab@tenstorrent.com>
 <wtknsih2yrbylqzanp6k753kklk4myf6iezjz6swnp4nsqr2hl@7mmm6lxhqemu>
 <Zv2aE7jmE2awLwcl@x1>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zv2aE7jmE2awLwcl@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/10/2024 21:08, Drew Fustini wrote:
> On Tue, Oct 01, 2024 at 08:58:34AM +0200, Krzysztof Kozlowski wrote:
>> On Mon, Sep 30, 2024 at 11:23:24PM -0700, Drew Fustini wrote:
>>> From: Jisheng Zhang <jszhang@kernel.org>
>>>
>>> Add documentation to describe the DesginWare-based GMAC controllers in
>>> the T-HEAD TH1520 SoC.
>>>
>>> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
>>> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>>> [drew: rename compatible, add apb registers as second reg of gmac node]
>>> Signed-off-by: Drew Fustini <dfustini@tenstorrent.com>
>>> ---
>>>  .../devicetree/bindings/net/snps,dwmac.yaml        |  1 +
>>>  .../devicetree/bindings/net/thead,th1520-gmac.yaml | 97 ++++++++++++++++++++++
>>>  MAINTAINERS                                        |  1 +
>>>  3 files changed, 99 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> index 4e2ba1bf788c..474ade185033 100644
>>> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
>>> @@ -99,6 +99,7 @@ properties:
>>>          - snps,dwxgmac-2.10
>>>          - starfive,jh7100-dwmac
>>>          - starfive,jh7110-dwmac
>>> +        - thead,th1520-gmac
>>>  
>>>    reg:
>>>      minItems: 1
>>> diff --git a/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
>>> new file mode 100644
>>> index 000000000000..fef1810b10c4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/thead,th1520-gmac.yaml
>>> @@ -0,0 +1,97 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/thead,th1520-gmac.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: T-HEAD TH1520 GMAC Ethernet controller
>>> +
>>> +maintainers:
>>> +  - Drew Fustini <dfustini@tenstorrent.com>
>>> +
>>> +description: |
>>> +  The TH1520 GMAC is described in the TH1520 Peripheral Interface User Manual
>>> +  https://git.beagleboard.org/beaglev-ahead/beaglev-ahead/-/tree/main/docs
>>> +
>>> +  Features include
>>> +    - Compliant with IEEE802.3 Specification
>>> +    - IEEE 1588-2008 standard for precision networked clock synchronization
>>> +    - Supports 10/100/1000Mbps data transfer rate
>>> +    - Supports RGMII/MII interface
>>> +    - Preamble and start of frame data (SFD) insertion in Transmit path
>>> +    - Preamble and SFD deletion in the Receive path
>>> +    - Automatic CRC and pad generation options for receive frames
>>> +    - MDIO master interface for PHY device configuration and management
>>> +
>>> +  The GMAC Registers consists of two parts
>>> +    - APB registers are used to configure clock frequency/clock enable/clock
>>> +      direction/PHY interface type.
>>> +    - AHB registers are use to configure GMAC core (DesignWare Core part).
>>> +      GMAC core register consists of DMA registers and GMAC registers.
>>> +
>>> +select:
>>> +  properties:
>>> +    compatible:
>>> +      contains:
>>> +        enum:
>>> +          - thead,th1520-gmac
>>> +  required:
>>> +    - compatible
>>> +
>>> +allOf:
>>> +  - $ref: snps,dwmac.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - thead,th1520-gmac
>>> +      - const: snps,dwmac-3.70a
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: DesignWare GMAC IP core registers
>>> +      - description: GMAC APB registers
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: dwmac
>>> +      - const: apb
>>
>> I don't get why none of snps,dwmac properties are restricted. How many
>> interrupts do you have here? How many clocks? resets?
> 
> Thanks for pointing this out. Yes, I forgot to document the clocks,
> interrupts and resets.
> 
> There needs to be 2 clocks (stmmaceth and pclk). There also needs to be
> 2 resets: each GMAC has a reset plus a seperate reset for the GMAC AXI
> interface. There is 1 interrupt (macirq) but it is optional. The BeagleV
> Ahead uses it but the LicheePi 4A does not use the interrupt.
> 
> However, I'm uncertain about how to restrict the snps,dwmac properties.
> 
> I see that starfive,jh7110-dwmac.yaml has the following logic. Should I
> be adding something like this to restrict the snps,dwmac properties?
> 
> ---------------------------------------------------------------------
> allOf:
>   - $ref: snps,dwmac.yaml#
> 
>   - if:
>       properties:
>         compatible:
>           contains:
>             const: starfive,jh7100-dwmac
>     then:
>       properties:
>         interrupts:
>           minItems: 2
>           maxItems: 2
> 
>         interrupt-names:
>           minItems: 2
>           maxItems: 2
> 
>         resets:
>           maxItems: 1
> 
>         reset-names:
>           const: ahb

No, that's not necessary. You have one device in this binding, so in
top-level should define how each such property looks like.

Best regards,
Krzysztof


