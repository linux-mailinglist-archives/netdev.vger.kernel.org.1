Return-Path: <netdev+bounces-110012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB992AADC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61ED31C2116B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4B47345B;
	Mon,  8 Jul 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GPRoYSEo"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC27748A;
	Mon,  8 Jul 2024 21:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472604; cv=none; b=i6ACkf7l5d/FNzXaFy19SXBkaT733/1fzPjFrLrVvICyO3PSeq9dgGvzFCVB7LLtUIINtktde54emm4EBtI5UgpSxEp6L6zIFl+Yh/wfsJRLAbxFhX7agYeScKWJ+SczfUXSObl9gl65epUocqNaYASqL+0SCY1Pb6rLbQcYTSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472604; c=relaxed/simple;
	bh=yGezQoMEy+zGvFrwW4UjyRxSVNi5Vn7jd9oaO5/SiZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=idWPc7sn53P2doW7T7YxeRUTLnLw2pWByZGvvftuLlQO0y4pgEDUZnkM4vpUeny5C/liUMqvshw+5Vtda4bN+gq/zy3yt10Z/U4ZuBFMh8Z6471xnn3NgplG5miD0VYgyGBGmM7AYgBMvQ8RguI1eExzNL2tLhLSOiGTXpIbr9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GPRoYSEo; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4B75087F82;
	Mon,  8 Jul 2024 23:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720472600;
	bh=PLmGDjfO7Iv9kSuPhUNnyxBxOdqK2f484rToFZUPeqw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GPRoYSEoQD549TZ8uU2yCDgWuGndxj+UaW1kxa9v7UaRn7uGj6vA4fOt/6UToiXKn
	 H0T7UClybOe8egk4iYE9VUuIS7fFANwR65JNww30zzvbG37npCFY7V5SwBTPLnvQt7
	 Y0WH/3OkART/c7dcVe7PvGvDP1n+Rj7nwv5J652hJj1RhOGA9PN5QnVQyDgRcoKOu3
	 mJmSbtb7y2dI/yCiVb+6Nnlod+PV0Qop1GxKoqekYhDroRA8q0byLXgr9hnyYA6iqt
	 c2TRz5QHAgvgvp3ODLPDLQUI+pjNhkOSm4zjRGPbW2m0TQP6knUiowIf5zGI7pxDGr
	 E0wtaZo6OiiBg==
Message-ID: <40249f5c-f034-41a5-8088-8b4c298ab6c6@denx.de>
Date: Mon, 8 Jul 2024 23:01:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] dt-bindings: net: realtek,rtl82xx: Document
 RTL8211F LED support
To: Rob Herring <robh@kernel.org>
Cc: netdev@vger.kernel.org, kernel@dh-electronics.com,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 devicetree@vger.kernel.org
References: <20240705215207.256863-1-marex@denx.de>
 <20240708205856.GA3874098-robh@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240708205856.GA3874098-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 7/8/24 10:58 PM, Rob Herring wrote:
> On Fri, Jul 05, 2024 at 11:51:46PM +0200, Marek Vasut wrote:
>> The RTL8211F PHY does support LED configuration, document support
>> for LEDs in the binding document.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Andrew Lunn <andrew@lunn.ch>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Heiner Kallweit <hkallweit1@gmail.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Cc: netdev@vger.kernel.org
>> ---
>>   .../devicetree/bindings/net/realtek,rtl82xx.yaml   | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> index 18ee72f5c74a8..28c048368073b 100644
>> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>> @@ -14,9 +14,6 @@ maintainers:
>>   description:
>>     Bindings for Realtek RTL82xx PHYs
>>   
>> -allOf:
>> -  - $ref: ethernet-phy.yaml#
>> -
>>   properties:
>>     compatible:
>>       enum:
>> @@ -54,6 +51,17 @@ properties:
>>   
>>   unevaluatedProperties: false
>>   
>> +allOf:
>> +  - $ref: ethernet-phy.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            const: ethernet-phy-id001c.c916
>> +    then:
>> +      properties:
>> +        leds: true
> 
> This has no effect. 'leds' node is already allowed with the ref to
> ethernet-phy.yaml. I suppose you could negate the if and then, but I'm
> not really that worried if someone defines LEDs for a device with no
> LEDs.

So shall I simply do:

leds: true

and by done with it, as the easier way out ?

