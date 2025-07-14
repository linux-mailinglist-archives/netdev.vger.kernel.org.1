Return-Path: <netdev+bounces-206572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB89B03812
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 09:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F593B1D90
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 07:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45678227B8E;
	Mon, 14 Jul 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTXk/goN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1430B1CAA62;
	Mon, 14 Jul 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752478531; cv=none; b=RaVwGzCvXx6OaQIE/GW5tfqSd0lwm1WmenUijKVPsFEp/R21JxU1gHMvik+BSBGjz6jcT71PFPXbLSS2BjdHwdnQAUqHmbpGeEHXcMru+Nna5bL9pVg1OI0cWeR/OMKz1s/2h1UC7ukmveagMxnpXXEPynTt1ryP3DOdAmYylT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752478531; c=relaxed/simple;
	bh=UzOybdurVkBFbtK9y1JfirSq35txfgT24XFPq/uINYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JPY8CSC5yE0WQacwPea2iBKjy/GdE6XeqvsBZUJwQ9VG/lUJ5i0JR++YShUy9ghRwHLf/UwCDqaIjggYSjZnRKPP70BpQP3ORg51X4RPEKOoVOBqjZSFiUITPV95Qgxa2BxDaflek+Lh//jTYhGxQDGBX9Q59yLLN6fmBSM1PsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTXk/goN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A4FC4CEED;
	Mon, 14 Jul 2025 07:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752478530;
	bh=UzOybdurVkBFbtK9y1JfirSq35txfgT24XFPq/uINYQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cTXk/goNVucYezY9NgJ9kLrNITZJrNdYKUGfo7n9O/4o6Ns4hsUvRz4/SeFQa5Xzq
	 qkha2o1jpS7M4tcatv9dq+J2BT2c83BDVcgkzdRPD/E9/qu/yGWpgP3IF6p5SBCAeu
	 8m13RXL2iH41Er1CiTfhpVdJcBXwH5CjsbSBp2oVmeQqZrvr8BG4KqyRXKzchIOXl3
	 IyQSaAulJV1F2ZkNKfaqG6c/N8OpaDZBjeDXE9ZHUgxrweyJ+aAIrFzUx59G4OL+oZ
	 BkspU59A6k34dDBWmUXZolkrYI1hZ2/ASqd1nFsTTyLy5T+PU6aOWgYT8XUFxl0bAF
	 qha0xFRMU+/Xw==
Message-ID: <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
Date: Mon, 14 Jul 2025 09:35:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
To: Wei Fang <wei.fang@nxp.com>
Cc: "F.S. Peng" <fushi.peng@nxp.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "richardcochran@gmail.com" <richardcochran@gmail.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang
 <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 09:32, Wei Fang wrote:
>> On 11/07/2025 08:57, Wei Fang wrote:
>>> Add device tree binding doc for the PTP clock based on NETC Timer.
>>
>>
>> A nit, subject: drop second/last, redundant "bindings for". The "dt-bindings"
>> prefix is already stating that these are bindings.
> 
> Okay, I will fix it, thanks
> 
>>> +
>>> +title: NXP NETC Timer PTP clock
>>
>> What is NETC?
>>
> 
> NETC means Ethernet Controller, it is a multi-function PCIe Root Complex
> Integrated Endpoint (RCiEP), Timer is one of its PCIe functions.

This must be explained in description, not here.

> 
>>> +
>>> +description:
>>> +  NETC Timer provides current time with nanosecond resolution,
>>> +precise
>>> +  periodic pulse, pulse on timeout (alarm), and time capture on
>>> +external
>>> +  pulse support. And it supports time synchronization as required for
>>> +  IEEE 1588 and IEEE 802.1AS-2020.
>>> +
>>> +maintainers:
>>> +  - Wei Fang <wei.fang@nxp.com>
>>> +  - Clark Wang <xiaoning.wang@nxp.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - pci1131,ee02
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    maxItems: 1
>>> +
>>> +  clock-names:
>>> +    oneOf:
>>
>> Why oneOf? Drop
>>
>>> +      - enum:
>>> +          - system
>>> +          - ccm_timer
>>> +          - ext_1588
>>
>> Why is this flexible?
>>
> 
> The NETC Timer has 3 reference clock sources, we need to select one
> of them as the reference clock. Set TMR_CTRL[CK_SEL] by parsing the
> clock name to tell the hardware which clock is currently being used.
> Otherwise, we need to add another property to select the clock source.
> 
>>> +
>>> +  nxp,pps-channel:
>>> +    $ref: /schemas/types.yaml#/definitions/uint8
>>> +    default: 0
>>> +    description:
>>> +      Specifies to which fixed interval period pulse generator is
>>> +      used to generate PPS signal.
>>> +    enum: [0, 1, 2]
>>
>> Cell phandle tells that. Drop property.
> 
> Sorry, I do not understand what you mean, could you explain it in more
> detail?

Use phandle cells for that - look at other PTP bindings.

> 
> This property is similar to the "fsl,ptp-channel" which has been added
> to fsl,fec.yaml
> https://elixir.bootlin.com/linux/v6.16-rc5/source/Documentation/devicetree/bindings/net/fsl,fec.yaml#L186

This is not FEC. And if you have existing property, you don't add
entirely different one!

> 
> The NETC Timer has three 3 PPS generators, and each corresponding
> to an output pin, but these pins are multiplexed with other devices,
> so the pin of the PPS output depends on the design of the board. This
> property is used to tell the driver which PPS generator/pin the board
> uses.


Again, phandle cells tells you that. And driver does not use it in the
first place.


Best regards,
Krzysztof

