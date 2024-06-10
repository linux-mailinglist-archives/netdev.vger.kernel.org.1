Return-Path: <netdev+bounces-102220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C629E901F86
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB5C1F25BFC
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC6F78C7B;
	Mon, 10 Jun 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="GdCSF+Jv"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4121A953;
	Mon, 10 Jun 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718016255; cv=none; b=ruJtfeO5WCdr2pGpapkA6Ii/KhqxheEg5rkD6E/I/gN/O9wLykZacjD772fh3r5cyTYoFiunXv8F0DLooOpdJr78HrR2syTdqRoIpYJL76FYaTVd3VjuOXi0nD1JFDNqa6OxgS2FER7zMmS26KGY50+TlG6/9WRhkMcEd++NEog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718016255; c=relaxed/simple;
	bh=+R6ktbArqrrTQdXWZojOAhLBZuFDaJj1+bBiXK2n6TE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0LSK3XD0WMss6kh0uRvoof4TP1Tkv724v0ggqZtFbn1bu5tyoBgbzGm4YLoujPp1A6oomJvSpI8Mn3wvYQFTTXN7HiYpVYTQOEEnNCgztmESH4y+pTmh+J9nkXmcMHyY/j8rqXjIulCu7x8+ZV74SwDB3uecp0EzoUREKvCG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=GdCSF+Jv; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 15B6888452;
	Mon, 10 Jun 2024 12:44:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718016245;
	bh=UGsRKAQcP9Xl+f3DvdpljlZ5s9R51tFrDXOpqku0T3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GdCSF+Jvh5LOk4DOCcUWT5R6bfzs4ZRtALDz+GLfhVnuJsTfOhKh/dRS5SX5UWVWa
	 y21C6sCLS/WoifQjjVePn4h4f3von3szlNrJuphrcAu9o4R6dG/N+fJH/MlVkrVhfZ
	 z81NlvdFoSb77nRWhE0YyNXdAG6lqSQtvw70sK1xpBA2A19c+tTfoEQA0fUQqoJp5k
	 eA8JGo93OjToYPWfvpMg3uqpZvvnES3kAObiFhnsVQv7st+kFTpvZ7GcSu/HJv9ZQT
	 l5gcucGYEuRjXShdTsbegqf/XnEbaQxYGbblkwfGnmZ1SV8kkBw/7TgAuQ63WLoptc
	 XCnN4ZY0Rgrzg==
Message-ID: <c5cb092d-dccd-48a4-b1da-4f057581618e@denx.de>
Date: Mon, 10 Jun 2024 12:37:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] ARM: dts: stm32: add ethernet1 and ethernet2
 support on stm32mp13
To: Alexandre TORGUE <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-10-christophe.roullier@foss.st.com>
 <6d60bbc6-5ed3-4bb1-ad72-18a2be140b81@denx.de>
 <036c9f0d-681d-461d-b839-f781fa220e94@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <036c9f0d-681d-461d-b839-f781fa220e94@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/10/24 10:06 AM, Alexandre TORGUE wrote:
> Hi Marek

Hi,

> On 6/7/24 14:48, Marek Vasut wrote:
>> On 6/7/24 11:57 AM, Christophe Roullier wrote:
>>
>> [...]
>>
>>> @@ -1505,6 +1511,38 @@ sdmmc2: mmc@58007000 {
>>>                   status = "disabled";
>>>               };
> no space here ?
>>> +            ethernet1: ethernet@5800a000 {
>>> +                compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
>>> +                reg = <0x5800a000 0x2000>;
>>> +                reg-names = "stmmaceth";
>>> +                interrupts-extended = <&intc GIC_SPI 62 
>>> IRQ_TYPE_LEVEL_HIGH>,
>>> +                              <&exti 68 1>;
>>> +                interrupt-names = "macirq", "eth_wake_irq";
>>> +                clock-names = "stmmaceth",
>>> +                          "mac-clk-tx",
>>> +                          "mac-clk-rx",
>>> +                          "ethstp",
>>> +                          "eth-ck";
>>> +                clocks = <&rcc ETH1MAC>,
>>> +                     <&rcc ETH1TX>,
>>> +                     <&rcc ETH1RX>,
>>> +                     <&rcc ETH1STP>,
>>> +                     <&rcc ETH1CK_K>;
>>> +                st,syscon = <&syscfg 0x4 0xff0000>;
>>> +                snps,mixed-burst;
>>> +                snps,pbl = <2>;
>>> +                snps,axi-config = <&stmmac_axi_config_1>;
>>> +                snps,tso;
>>> +                access-controllers = <&etzpc 48>;
>>
>> Keep the list sorted.
> 
> The list is currently not sorted. I agree that it is better to have a 
> common rule to easy the read but it should be applied to all the nodes 
> for the whole STM32 family. Maybe to address by another series. For the 
> time being we can keep it as it is.

Why is the st,... and snps,... swapped anyway ? That can be fixed right 
here.

Why is the access-controllers at the end ? That can be fixed in separate 
series, since that seems to have proliferated considerably.

