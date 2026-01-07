Return-Path: <netdev+bounces-247560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 256EFCFBA7F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 03:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 840F23003855
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 02:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EA207A32;
	Wed,  7 Jan 2026 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1b36/Ro"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487979CD;
	Wed,  7 Jan 2026 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751743; cv=none; b=kN09SAFYW1Fm8Fqw03yuNnaDVm4t4Bo7gA/MArltsAED3jWrIRrP0daXFLt8liqJKwiE0MqaBTarcPsT3i7y3zw3SEH13IbkgzkfPO6f6sPRhVtjajU+JqGiwcnlNxV/OntHTO1T2L2iTfzygfk/VwDhr2z6no5lkZOGPPATWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751743; c=relaxed/simple;
	bh=zc/jxjcF6joL67iBKRqLw1dlXUV+eOqt9LCpxQHLzMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIbi5GhuIxEDJCvmoEJPbB1qHYSz4W/f/ywcz8R8V9buiFx1iV9DK5ouruwd4GiUzLjPurfGuyLin1glLYLWBa11r90cIPwh3Cp/33FuKb3QrJ0xuPHJrw/qm1DVBtX2b11tuAmgOYgyv2UDdeTFlCqUYxYFXg+bPjmQhEsF0D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1b36/Ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580F7C116C6;
	Wed,  7 Jan 2026 02:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767751742;
	bh=zc/jxjcF6joL67iBKRqLw1dlXUV+eOqt9LCpxQHLzMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A1b36/RosaUrz9qbTDLKQ62OAD4gm9IcmjQIlcNRiShtU9MzbZXy1XefApwe2k0+z
	 onpGCQtMZ09mvbgAbucuBe1aAwisrNQfj7lSX1KWo2HLMEySiAhU2+FTxxtoN3OpkD
	 HZnQ0pGCspxYd1QrKr0D45hVjSWP2kVv7yAMkeNG0eokPZhchrFrwvjR58uMj6q8YU
	 8S2VkCjZQWIbWBTmvrpLF4SQ/9AmFXWjP20Q+6qLM77E26gxx/kjwd3dkf6YELhEsU
	 kBzxvC6oeR92xzw/5iOo19C+jFG5paCR2QeOyYriiH9B/3gFsg31rXE/B808+b4RNh
	 zi8Ez0t4BSuNg==
Message-ID: <8435a4f3-9afc-46fd-a6d5-9b86a417e01c@kernel.org>
Date: Tue, 6 Jan 2026 20:09:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: net: altr,socfpga-stmmac: deprecate
 'stmmaceth-ocp'
To: Rob Herring <robh@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mamta Shukla <mamta.shukla@leica-geosystems.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 bsp-development.geo@leica-geosystems.com,
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260105-remove_ocp-v2-0-4fa2bda09521@kernel.org>
 <20260105-remove_ocp-v2-3-4fa2bda09521@kernel.org>
 <20260106190126.GA2537154-robh@kernel.org>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260106190126.GA2537154-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/6/26 13:01, Rob Herring wrote:
> On Mon, Jan 05, 2026 at 06:08:22AM -0600, Dinh Nguyen wrote:
>> Make the reset name 'stmmaceth-ocp' as deprecated and to use 'ahb' going
>> forward.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>   .../devicetree/bindings/net/altr,socfpga-stmmac.yaml          | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>> index fc445ad5a1f1..4ba06a955fe2 100644
>> --- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>> +++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
>> @@ -13,8 +13,6 @@ description:
>>     This binding describes the Altera SOCFPGA SoC implementation of the
>>     Synopsys DWMAC for the Cyclone5, Arria5, Stratix10, Agilex5 and Agilex7
>>     families of chips.
>> -  # TODO: Determine how to handle the Arria10 reset-name, stmmaceth-ocp, that
>> -  # does not validate against net/snps,dwmac.yaml.
>>   
>>   select:
>>     properties:
>> @@ -84,6 +82,15 @@ properties:
>>         - sgmii
>>         - 1000base-x
>>   
>> +  resets:
>> +    minItems: 1
> 
> That's already the min in the referenced schema.
>

Yeah, I had to add this, else it would fail the 'make dt_binding_check 
DT_SCHEMA_FILES'.

>> +
>> +  reset-names:
>> +    deprecated: true
>> +    items:
>> +      - const: stmmaceth-ocp
> 
> This says stmmaceth-ocp is the 1st entry, but it is the 2nd.
> 
> You can't really fix this to validate a DT using stmmaceth-ocp. I would
> just drop this. So that leaves this with just dropping the TODO.

Got it.

Thanks,
Dinh


