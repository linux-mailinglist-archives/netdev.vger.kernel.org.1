Return-Path: <netdev+bounces-112301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB9C93826E
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD131C20B00
	for <lists+netdev@lfdr.de>; Sat, 20 Jul 2024 18:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF021487E1;
	Sat, 20 Jul 2024 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBa+ekli"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983F3D66;
	Sat, 20 Jul 2024 18:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721499933; cv=none; b=Y5lRZ2yOwF5Mf400ZOhZGO5sgf/SRI7Tb/e5QHAq1C9SMTravSDOSOHK9+Hts4r7AqfRuCJ1xvOQyXfn5EkxK+Qi5X4GjyrZx8m0OIRWfBc7tIensC7cgb4olHVqS8ujArD65R5a8IciRENE6PH2m3eX59NDDrD5ZQkSsyMUpuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721499933; c=relaxed/simple;
	bh=XoPwgzprGDn3+eLd4n5lyqkYKtC39c939dOeKl5SAtM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uesj96HWnF/mkO+aIuwj6p9/rKxlQ7PBgB6tvvlnIPbZbmSfbqLjfMSBWImNquEMtln5f4dyHNRubVc3QY2Vom4TAzYeGNez6hd4/Ek+yEjADHoq5SJIMhWKj7ufmnl0ZbI2/M7S1wlLC/iF0u1SsWCQ0lnTB0tJr4yPLtHcYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBa+ekli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2317FC2BD10;
	Sat, 20 Jul 2024 18:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721499933;
	bh=XoPwgzprGDn3+eLd4n5lyqkYKtC39c939dOeKl5SAtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cBa+eklitNsi+5X0PT1B8DLx4q07C4cr2pFk0Q0UGBF5v7Vddvgnpl6cHGu3VoqGL
	 Ms5oTJtEuUSVgILgBnx2jxOGWUdGGo6oa4UnDA+/wYjfpZuyPPFeqjDjd3j54+Uen5
	 i1NQchfyjre0pgiKvtwfKeYTm7zkRoeVqOTrbc6pWY1qriKzaGv8QCSTMm1YkHFF9l
	 1RO7aV+bM0u9C0K+SYsnuZqUuZ7eT6VwtDS/XObUqA4hf2IirF4hQry6vWUANe/vvr
	 aTu6bT5ECGFIYGajhfdgsutsVzPSBrbRKoT0sMeW/Cgh9R73O7xCEFnIcI576vREBT
	 F+fYiMIyNbNVQ==
Message-ID: <1582443b-c20a-4e3a-b633-2e7204daf7e0@kernel.org>
Date: Sat, 20 Jul 2024 20:25:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add support for
 Amlogic Bluetooth
To: Yang Li <yang.li@amlogic.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240718-btaml-v2-0-1392b2e21183@amlogic.com>
 <20240718-btaml-v2-1-1392b2e21183@amlogic.com>
 <18f1301f-6d93-4645-b6d9-e4ccd103ff5d@kernel.org>
 <30cf7665-ff35-4a1a-ba26-0bbe377512be@amlogic.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <30cf7665-ff35-4a1a-ba26-0bbe377512be@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/07/2024 10:20, Yang Li wrote:
> Dear Krzysztof
> 
> Thanks.
> 
> On 2024/7/18 19:40, Krzysztof Kozlowski wrote:
>> On 18/07/2024 09:42, Yang Li via B4 Relay wrote:
>>> From: Yang Li <yang.li@amlogic.com>
>>>
>>> Add binding document for Amlogic Bluetooth chipsets attached over UART.
>>>
>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>> ---
>>>   .../bindings/net/bluetooth/amlogic,w155s2-bt.yaml  | 66 ++++++++++++++++++++++
>>>   1 file changed, 66 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>>> new file mode 100644
>>> index 000000000000..2e433d5692ff
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/amlogic,w155s2-bt.yaml
>>> @@ -0,0 +1,66 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +# Copyright (C) 2024 Amlogic, Inc. All rights reserved
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/net/bluetooth/amlogic,w155s2-bt.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Amlogic Bluetooth chips
>>> +
>>> +description:
>>> +  This binding describes UART-attached Amlogic bluetooth chips.
>> <form letter>
>> This is a friendly reminder during the review process.
>>
>> It seems my or other reviewer's previous comments were not fully
>> addressed. Maybe the feedback got lost between the quotes, maybe you
>> just forgot to apply it. Please go back to the previous discussion and
>> either implement all requested changes or keep discussing them.
>>
>> Thank you.
>> </form letter>
> 
> Apologies for the earlier omission. I have amended the description of the
> 
> UART-attached Amlogic Bluetooth chips in the patch:
> 
> "This binding describes Amlogic Bluetooth chips connected via UART,
> 
> which function as dual-radio devices supporting Wi-Fi and Bluetooth.
> 
> It operates on the H4 protocol over a 4-wire UART, with RTS and CTS lines
> 
> used for firmware download. It supports Bluetooth and Wi-Fi coexistence."

You still say what is the binding which is pointless. Binding is a
binding... awesome. No, say what the hardware is.



>>
>>> +    description: bluetooth chip 3.3V supply regulator handle
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +    description: clock provided to the controller (32.768KHz)
>>> +
>>> +  antenna-number:
>>> +    default: 1
>>> +    description: device supports up to two antennas
>> Keep it consistent - either descriptions are the last property or
>> somewhere else. Usually the last.
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> And what does it mean? What happens if BT uses antenna number 2, not 1?
>> What is connected to the other antenna? It really feels useless to say
>> which antenna is connected to hardware.
> 
> Sorry, the antenna description was incorrect, it should specify whether
> 
> Bluetooth and WiFi coexist. I will change it as below:
> 
>      aml,work-mode:
>      type: boolean
>      description: specifywhether Bluetooth and WiFi coexist.

So one device can be used on different boards - some without WiFi
antenna? But, why in the binding of bluetooth you describe whether there
is WiFi antenna?

Best regards,
Krzysztof


