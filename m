Return-Path: <netdev+bounces-243348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C8DC9D806
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 02:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E423A9029
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 01:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03F1DEFE9;
	Wed,  3 Dec 2025 01:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sLoW5Xpg"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B011B4138;
	Wed,  3 Dec 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764725446; cv=none; b=u3CZ7UGPMUsC/svCLO0nvsuJSfX0kD75c6O3MiI1VXjnm89e2omudAqh57/y1lLH4jeX5q8t1Gb3tgvX8JVSdec0TrgrNvJ/KdmcjiIcvwiw3c6pPGdkDI0dXxlHJITbU1++E2aJ5RWKZ79lnDuTDt+EvSj/egM2SFOQiqCH1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764725446; c=relaxed/simple;
	bh=ovfLwLsXkBB0u4yjDJk3NJc8uW/6cuJBVErz9Kr3oP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prFXMVJvhlTRxMxoGuL4glC+aTSXIHSx894e7uVZ4w10x0jz1SkGBhbf0vt4KND1Go//D17Uj1g0AVScBQvIbjF1mhKgmc7hQmDg2IN8ztAbI7BpQzWj+gwjug1N/Mo87PaWTJwJOIeIgZfDf5lCtD6OXsZ4xHtvTGa4iwrJ4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=sLoW5Xpg; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dLg7b3YqLz9tkk;
	Wed,  3 Dec 2025 02:30:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1764725435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wXh5W9jMqRcOXCsJjM2PP5pnAUQs9VOMsyI3J7suNk=;
	b=sLoW5XpgIMCojc3bBGANOJsyPV4QPHF36vxsd8zfEuXrDC8JKHVI3pS59kZFSg+X99sk8w
	WR/BGs7aR2CxuWqpbvvl3eSShcv/+2WAXCWin4PE8ejULTsPMz2SpO8P7918Mxi5Lxa1ru
	NAQLWGC5TAyTzg8ws+cRithP2teg6j0uSPOtzvKhnlRznNuN+rRVoPFxuc/jkjYsSjkPa0
	tS2HyOIVLj15Vtqs9pBIf61UPh93d4EpM4I7Vfytyz8OIbhdXtK6tXKjM+YrygmKyVcDfj
	CaswTSUh7U1ho8LLDXTTW2n7y3qBVMUcJ2p+A0ImEz5iEKtLG1fHz04uQZH24w==
Message-ID: <4aaa73b4-3a2a-44f6-ad81-74c30be13431@mailbox.org>
Date: Wed, 3 Dec 2025 02:30:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH 2/3] dt-bindings: net: realtek,rtl82xx: Document
 realtek,ssc-enable property
To: Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-2-marek.vasut@mailbox.org>
 <f3046826-a44c-4aa9-8a94-351e7fe83f06@kernel.org>
 <a861aa24-e350-4955-be5a-f6d2f4bc058f@mailbox.org>
 <043053ec-0f57-45e9-9767-be9b518dea4d@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <043053ec-0f57-45e9-9767-be9b518dea4d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 382a994154142a10bf5
X-MBO-RS-META: dbtpdimpw6urkcfsebudhdca9e5ayr75

On 12/1/25 8:20 AM, Krzysztof Kozlowski wrote:
> On 30/11/2025 14:41, Marek Vasut wrote:
>> On 11/30/25 9:20 AM, Krzysztof Kozlowski wrote:
>>
>> Hello Krzysztof,
>>
>>>> diff --git a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>>>> index eafcc2f3e3d66..f1bd0095026be 100644
>>>> --- a/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>>>> +++ b/Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml
>>>> @@ -50,6 +50,11 @@ properties:
>>>>        description:
>>>>          Disable CLKOUT clock, CLKOUT clock default is enabled after hardware reset.
>>>>    
>>>> +  realtek,ssc-enable:
>>>> +    type: boolean
>>>> +    description:
>>>> +      Enable SSC mode, SSC mode default is disabled after hardware reset.
>>>
>>> I don't want more SSC properties. We already had a big discussions about
>>> it - one person pushing vendor property and only shortly after we learnt
>>> that more vendors want it and they are actually working on this.
>> What kind of a property would you propose I use for this ?
> 
> I don't know, please look at existing work around SSC from Peng. If
> nothing is applicable, this should be explained somewhere.

The work from Peng you refer to (I guess) is this "assigned-clock-sscs" 
property ? This is not applicable, because this is a boolean property of 
the PHY here, the clock does not expose those clock via the clock API.

However, I can call the property "ssc-enable" without the realtek, 
vendor prefix ?

The remaining question is, should I have one property "ssc-enable" to 
control all SSC in the PHY or one for each bit "realtek,ssc-enable-rxc" 
/ "realtek,ssc-enable-clkout" ?

-- 
Best regards,
Marek Vasut

