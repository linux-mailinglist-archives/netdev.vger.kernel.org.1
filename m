Return-Path: <netdev+bounces-110232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9731492B87E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4898828212E
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C8158201;
	Tue,  9 Jul 2024 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FIVMnqgL"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AD012DDAE;
	Tue,  9 Jul 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720525253; cv=none; b=U4XlpVY+LtOLkU0M4834YIAm+7u8e3Gii0/dBAI7w61ZJWCDUgCUoLhwUr/+D2zjqkLoqfwOB97161+hq7mzPrC3zt9hDI9F5s4I98q6anuO0B/bLjQC+eW1kszDSG8mzDtk+R028S5SLfR6hKBRBT8niHGiNF01BHRKzQtHsPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720525253; c=relaxed/simple;
	bh=ME9kBqih9xn2/LKVeGv45VJWzLFc8W8p2aab4WSL7dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp5H5E9RPRpln9rTyzv6UopSUItgmmQv5NbkCkWyvqRGA/uauJl6kAnHGcKTR35f4V2EWGZZgVtzKqVXXSm8znyNfdMk5qu+gEUXM/LB+YndcilNlhY5t3eoKrjdSeZpezy59lxmqRTNiS3dgsSMUjzOMSuJExTSJv/YSh0tsW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FIVMnqgL; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 08304885C5;
	Tue,  9 Jul 2024 13:40:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720525249;
	bh=UJYE6PRHiKlz/WnXRDAf3zPou9Z+TXP574pDUH/KQUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FIVMnqgLUWAGLxW3cN0ARNQNFoDSLgVmpIxJRogLDzUeOcIhlptkjn6bgwq7N00yd
	 sPCEyl8Z1nLhCbMKCbnHQbc0rBeJAAPxeq/4uZun4O5eCxuzH/wXsafOlY1bEIQVWq
	 00/9JXkjYZNPPI07i1L0PwF5zTMarR8dTEC86EjT3mCG1EAuko/xaSOlDXPMHbgRxG
	 Stg7Hu3TVan6wRgigot79DvTT4GmfEM9PF28ttOqFGCULfMQwKsa+5e9G3eHsWSAK4
	 5Mx8theEKyjTDalYb8y3GBd7rCCHwW9EXLFa/SVq2CBJ+72VHgS/uFvT87NuJva4zy
	 wZOpiut5D8kWA==
Message-ID: <46dd1da1-1d80-47ac-9873-ab41019eae5a@denx.de>
Date: Tue, 9 Jul 2024 13:37:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 RTL8211F LED support
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, kernel@dh-electronics.com,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 devicetree@vger.kernel.org
References: <20240705215207.256863-1-marex@denx.de>
 <20240708205856.GA3874098-robh@kernel.org>
 <40249f5c-f034-41a5-8088-8b4c298ab6c6@denx.de>
 <2ba9b185-e9dc-4594-9b2d-983c74b0c55a@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <2ba9b185-e9dc-4594-9b2d-983c74b0c55a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/9/24 11:01 AM, Krzysztof Kozlowski wrote:
> On 08/07/2024 23:01, Marek Vasut wrote:
>>>>    
>>>> +allOf:
>>>> +  - $ref: ethernet-phy.yaml#
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: ethernet-phy-id001c.c916
>>>> +    then:
>>>> +      properties:
>>>> +        leds: true
>>>
>>> This has no effect. 'leds' node is already allowed with the ref to
>>> ethernet-phy.yaml. I suppose you could negate the if and then, but I'm
>>> not really that worried if someone defines LEDs for a device with no
>>> LEDs.
>>
>> So shall I simply do:
>>
>> leds: true
>>
>> and by done with it, as the easier way out ?
> 
> No, you should not have to do anything. Do you see any dtbs_check error
> without this patch?

Not yet, but I do plan to describe PHY LEDs on a board I have locally, 
with RTL8211F PHY.

I sent a V2 of this patch with leds:true and this conditional inverted.

