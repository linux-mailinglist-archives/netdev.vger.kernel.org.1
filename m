Return-Path: <netdev+bounces-219600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F7B4236A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546971A87ADD
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3630AAAD;
	Wed,  3 Sep 2025 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rTYnTc4y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D01F4CB2;
	Wed,  3 Sep 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756909200; cv=none; b=VHPAeBmO++ctuquBN6NBgsmYMLe9pa+DS1/T2N+6DSIPKJEPxmT4zftQuqt9jwMTa1hjypaiwdRIjWa5xNNlxbcv+WGW+KfJbirE3NVE4hwbZWm+BpIz3suCKqRMZ3H3Cub2K7JHS+/eZXTkMinAwrtYkWvFrJL+SX45EfLBfBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756909200; c=relaxed/simple;
	bh=82KpDV1PvR2wNvrkgtAIHeyUyj1MQlrsKRL99mRDZBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pguEp815ZRVo2E6uegME22gSfWv+L9E8edWJjSLub2qbt/rifWUHAJgMzs5ZRHgYpN3KigUi+23mjLur9nmJzTXC5Te/ilB/r9UTjntORm6Hu80jzCNWWZ+TjHs7sjwEtlSbmgU51z/Flwm5Zx3tdCPQtLwRdpCUZpRuue02Tpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rTYnTc4y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64960C4CEE7;
	Wed,  3 Sep 2025 14:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756909199;
	bh=82KpDV1PvR2wNvrkgtAIHeyUyj1MQlrsKRL99mRDZBs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rTYnTc4yE0MczD5gf388EJftHMhVDIb7K97+qI8yphSe8s6QtmkejjXb+d8GJTmt6
	 9cVe0Rd0ingn3ucmy/fba5ChlZuxw9VxgICeBrk5+T3byxSscBwtdzB3u5q1POsB2/
	 S7NhFIhw+aFBixFRCPZO37J1227jFcN2bkuENiD1TUGY5QON21fQiVbReovZ3gdvBw
	 7JYD7den7jFxsrR8ltXDV74H9mCTmUO0+k3QPTpOatu9YLcWf6Moteg33kohNt9njG
	 /6YYhB6XJqT+ahKXXzEdAEURKMgct0Kpx9tSUFNwlxcro0ThpySo5hqiIIDmIoNHje
	 T7aUset+eHlzA==
Message-ID: <ea75a30b-01f4-4c2d-b3ab-0a9ab0d9de80@kernel.org>
Date: Wed, 3 Sep 2025 16:19:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/8] dt-bindings: remoteproc: k3-r5f: Add
 rpmsg-eth subnode
To: "Anwar, Md Danish" <a0501179@ti.com>, MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mengyuan Lou <mengyuanlou@net-swift.com>, Xin Guo <guoxin09@huawei.com>,
 Lei Wei <quic_leiwei@quicinc.com>, Lee Trager <lee@trager.us>,
 Michael Ellerman <mpe@ellerman.id.au>, Fan Gong <gongfan1@huawei.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Suman Anna <s-anna@ti.com>, Tero Kristo <kristo@kernel.org>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, srk@ti.com,
 Roger Quadros <rogerq@kernel.org>
References: <20250902090746.3221225-1-danishanwar@ti.com>
 <20250902090746.3221225-3-danishanwar@ti.com>
 <20250903-peculiar-hot-monkey-4e7c36@kuoka>
 <d994594f-7055-47c8-842f-938cf862ffb0@ti.com>
 <f2550076-57b5-46f2-a90a-414e5f2cb8d7@kernel.org>
 <38c054a3-1835-4f91-9f89-fbe90ddba4a9@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <38c054a3-1835-4f91-9f89-fbe90ddba4a9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/09/2025 15:32, Anwar, Md Danish wrote:
> 
> 
> On 9/3/2025 6:24 PM, Krzysztof Kozlowski wrote:
>> On 03/09/2025 09:57, MD Danish Anwar wrote:
>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>>>> ---
>>>>>  .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml     | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>>> index a492f74a8608..4dbd708ec8ee 100644
>>>>> --- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>>> +++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
>>>>> @@ -210,6 +210,12 @@ patternProperties:
>>>>>            should be defined as per the generic bindings in,
>>>>>            Documentation/devicetree/bindings/sram/sram.yaml
>>>>>  
>>>>> +      rpmsg-eth:
>>>>> +        $ref: /schemas/net/ti,rpmsg-eth.yaml
>>>>
>>>> No, not a separate device. Please read slides from my DT for beginners
>>>
>>> I had synced with Andrew and we came to the conclusion that including
>>> rpmsg-eth this way will follow the DT guidelines and should be okay.
>>
>> ... and did you check the guidelines? Instead of repeating something not
>> related to my comment rather bring argument matching the comment.
>>
>>
>> ...
>>
>>> @@ -768,6 +774,7 @@ &main_r5fss0_core0 {
>>>  	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
>>>  	memory-region = <&main_r5fss0_core0_dma_memory_region>,
>>>  			<&main_r5fss0_core0_memory_region>;
>>> +	rpmsg-eth-region = <&main_r5fss0_core0_memory_region_shm>;
>>
>> You already have here memory-region, so use that one.
>>
> 
> There is a problem with using memory-region. If I add
> `main_r5fss0_core0_memory_region_shm` to memory region, to get this
> phandle from driver I would have to use
> 	
> 	of_parse_phandle(np, "memory-region", 2)
> 
> Where 2 is the index for this region. But the problem is how would the
> driver know this index. This index can vary for different vendors and
> their rproc device.

Index is fixed, cannot be anything else. Cannot vary.


> 
> If some other vendor tries to use this driver but their memory-region
> has 3 existing entries. so this this entry will be the 4th one.

None of these are reasons to add completely new node in DT. You use
arguments of drivers in hardware description. Really, can you read the
slides I asked for already?

> 
> But the driver code won't work for this. We need to have a way to know

Driver code can easily work with this. Multiple choices from using names
up to having driver match data with index.

> which index to look for in existing memory-region which can defer from
> vendor to vendor.
> 
> So to avoid this, I thought of using a new memory region. Which will
> have only 1 entry specifically for this case, and the driver can always
> 
> 	of_parse_phandle(np, "rpmsg-eth-region", 0)
> 
> to get the memory region.

Please don't drag the discussion. Look:

Q: I need a child node for my device to instantiate Linux driver"
A: NO

Q: I need new “vendor,foo-prop” property
A: Please look at existing common properties from common schemas or
devices representing similar class

Or actually let's start with most important:

"What Could You Put into DTS?"
Answers:
1. "Not the Linux Device Driver model"
2. "No Linux driver choices"

And that's exactly what you do and how you argue.

Best regards,
Krzysztof

