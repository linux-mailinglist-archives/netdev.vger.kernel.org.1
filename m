Return-Path: <netdev+bounces-114998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA07944DE6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C8CB2251E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD821A4B28;
	Thu,  1 Aug 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja5VYown"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE481A489D;
	Thu,  1 Aug 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722522233; cv=none; b=jwgfMiGit6t71h9ZMzo+4vtmLav7rZK7BUV5821u00+Tl1IiOkgC3PK8Lp+v6OdgJSAvSyka5kUvKLHkHolFzJt628Rj2Z6cYgkT6x7Fx041tG8tqf3LKK8L/5mJAGyj/r8FGKupeTaSDilWzWIeaYjEodQzBQpGAzQ0eda1/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722522233; c=relaxed/simple;
	bh=h8imtv17rvrOvyKv4gWYuT6nIHwd6hUakN89NTUAn6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqeUwYicAvoR5IZpou7K9lVoGuPRwuaLkptbT7epjXhkG870PZOaXc+G3gTEHODsU2VxVARJjLCRFdDuVRgqXhMc6j32HAMOV/fiXeI/F4cOUXISTAfMxSz1VjtKP7euOcgQcMcJFM/Vbj2m0TY3bfvMBgqi2SMCZNWhflnQTKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja5VYown; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D74C32786;
	Thu,  1 Aug 2024 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722522232;
	bh=h8imtv17rvrOvyKv4gWYuT6nIHwd6hUakN89NTUAn6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ja5VYownUqOdOYkYE72eDukM3bmYiamU/KPQL0ZfT3UItNb57INa8foQEpDTSn5H7
	 KFMuWQcWqBHH4UbKZMhZ/zxhQWOPQ7EuMUHUIyZHXm5DPSQfl1H+eFBuFNHZ82YsXM
	 I+PcDYIoGl76Wg0U63W86ZOe/jr62yN+qugsm8UeZArXPBSKclJlk8qOm7PjPGgARm
	 sfuBvFDolYotGzQ6/QJC54S4oPhzvhMrzUT7cPtA3nIgdDmG9wuV0TbCbWIU9XJVv3
	 P2i9BUjIfYqojvjp2NDBWGdJItwall8rxsY7kpTT38PNtJ5ePGneA0G5+C7ZYC+A7q
	 WuKfufUPglQ4A==
Message-ID: <ea7fd29c-c320-45b7-8da6-4819ec76c543@kernel.org>
Date: Thu, 1 Aug 2024 16:23:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: net: motorcomm: Add chip mode cfg
To: "Frank.Sae" <Frank.Sae@motor-comm.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, yuanlai.cui@motor-comm.com,
 hua.sun@motor-comm.com, xiaoyong.li@motor-comm.com,
 suting.hu@motor-comm.com, jie.han@motor-comm.com
References: <20240727092009.1108640-1-Frank.Sae@motor-comm.com>
 <ac84b12f-ae91-4a2f-a5f7-88febd13911c@kernel.org>
 <f18fa949-b217-4373-82c4-7981872446b4@motor-comm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f18fa949-b217-4373-82c4-7981872446b4@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/08/2024 11:49, Frank.Sae wrote:
> 
> On 7/27/24 02:25, Krzysztof Kozlowski wrote:
>> On 27/07/2024 11:20, Frank.Sae wrote:
>>>   The motorcomm phy (yt8821) supports the ability to
>>>   config the chip mode of serdes.
>>>   The yt8821 serdes could be set to AUTO_BX2500_SGMII or
>>>   FORCE_BX2500.
>>>   In AUTO_BX2500_SGMII mode, SerDes
>>>   speed is determined by UTP, if UTP link up
>>>   at 2.5GBASE-T, SerDes will work as
>>>   2500BASE-X, if UTP link up at
>>>   1000BASE-T/100BASE-Tx/10BASE-T, SerDes will work
>>>   as SGMII.
>>>   In FORCE_BX2500, SerDes always works
>>>   as 2500BASE-X.
>> Very weird wrapping.
>>
>> Please wrap commit message according to Linux coding style / submission
>> process (neither too early nor over the limit):
>> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
>>
>>> Signed-off-by: Frank.Sae<Frank.Sae@motor-comm.com>
>> Didn't you copy user-name as you name?
> 
> sorry, not understand your mean.

Does your ID (e.g. passport) has exactly that name? With dot? Really?

> 
>>> ---
>>>   .../bindings/net/motorcomm,yt8xxx.yaml          | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>> Also, your threading is completely broken. Use git send-email or b4.
> 
> sorry, not understand your mean of threading broken. the patch used git
> send-email.

Email threading is completely broken. It means all reviewers see it as
complete unrelated emails which makes any review annoyingly more difficult.


> 
> 
>>> diff --git a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>> index 26688e2302ea..ba34260f889d 100644
>>> --- a/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>> +++ b/Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
>>> @@ -110,6 +110,23 @@ properties:
>>>         Transmit PHY Clock delay train configuration when speed is 1000Mbps.
>>>       type: boolean
>>>   
>>> +  motorcomm,chip-mode:
>>> +    description: |
>>> +      Only for yt8821 2.5G phy, it supports two chip working modes,
>> Then allOf:if:then disallowing it for the other variant?
> 
> sorry, not understand your mean.

So you did not understand anything from any comments?

You miss if:then: block which disallows this for other chips. You claim
only one device supports it, so why the property should be valid for
other devices?


> 
> 
>>> +      one is AUTO_BX2500_SGMII, the other is FORCE_BX2500.
>>> +      If this property is not set in device tree node then driver
>>> +      selects chip mode FORCE_BX2500 by default.
>> Don't repeat constraints in free form text.
>>
>>> +      0: AUTO_BX2500_SGMII
>>> +      1: FORCE_BX2500
>>> +      In AUTO_BX2500_SGMII mode, serdes speed is determined by UTP,
>>> +      if UTP link up at 2.5GBASE-T, serdes will work as 2500BASE-X,
>>> +      if UTP link up at 1000BASE-T/100BASE-Tx/10BASE-T, serdes will
>>> +      work as SGMII.
>>> +      In FORCE_BX2500 mode, serdes always works as 2500BASE-X.
>>
>> Explain why this is even needed and why "auto" is not correct in all
>> cases. In commit msg or property description.
> 
> yt8821 phy does not support strapping to config the serdes mode, so config the
> serdes mode by dts instead.
> 
> even if auto 2500base-x serdes mode is default mode after phy hard reset, and
> auto as default must be make sense, but from most our customers's feedback,
> force 2500base-x serdes mode is used in project usually to adapt to mac's serdes
> settings. for customer's convenience and use simplicity, force 2500base-x serdes
> mode selected as default here.

Sorry, this is not a proper sentence and I cannot parse it.

> 
> 
>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>> Make it a string, not uint8.
>>
> why do you suggest string, the property value(uint8) will be wrote to phy
> register.

Because it is much more readable. I don't care about your phy register.

Best regards,
Krzysztof


