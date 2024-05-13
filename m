Return-Path: <netdev+bounces-96194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8828C49F3
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 01:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C76F284889
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 23:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A540085272;
	Mon, 13 May 2024 23:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="KDb1W5zf"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5F84D07;
	Mon, 13 May 2024 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642139; cv=none; b=fty4U/JMuryfcDUbvTHSb12YY43EbZ12hP0oDk7hgTK9zi4J5SnhIq0jMVCK4qshZ8Rf/WFGR8kQvOFK6CbWlvzi5evD4+kgEn4ND1TI6TiGXaLRzbFmzS+MsIyCDPJOpBqmrG1x57gb/ic03BrMzDkBDPNPcL/Lmmanae1u9uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642139; c=relaxed/simple;
	bh=loyZmoPtuDA5rMTG5lqXULUHGz/rf7HlgkI14OxieQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A7jEYQaNb4Zwa9seJPtCqeI98gO1FO5gickNzBn/JCWFw5dXa1lDcoD4QdV1Nt1iw+qI+8lwJ/xJxG2b0yk2aq3rkekQn/uyxP596RuCVYz9q4D6mNaO1F0ZEq9yX6RkQmjn3kf7mz9GvXMRPUMzfShALpD1M+oGmxjPZFTWSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=KDb1W5zf; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AE06A87C75;
	Tue, 14 May 2024 01:15:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715642135;
	bh=y94VBu3rZqXoPf5qJmghmwP/Qu0OecNomu4N18OPJk8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KDb1W5zfmoUzuqSNQmrm2kabFQTBN/gm1zuaeWYez5y7rFnL1dy6ic3sgUfoasrKc
	 8TgdCpee1r/OJis2LcSjW34EIsKO9z1Zwy3Ydhcs0Z57pJZWqRrhp3Bt5xvlOZOjuS
	 URdcvQ0pnhBVgsaSDE/WxfO4501H3T1IfT7pLNZPRabvHYdospTWpEHzDxaYGJqagG
	 hMag83m+X0lzF89Q8mqru018k0xEvdOaxCulH69/72NQAx4Q/12NCgVs36jmld4YY0
	 J2fVqAmI068QXmNd0DdlW05QcOME83EsHYZ3qy+Gy4fLP9gAOY64dOHoSiXIKe+vDh
	 ah4FSmqSe7aeA==
Message-ID: <2d213010-7aae-4f5a-8332-54d7e69b862c@denx.de>
Date: Tue, 14 May 2024 00:33:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] net: stmmac: dwmac-stm32: update config
 management for phy wo cristal
To: Christophe ROULLIER <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-6-christophe.roullier@foss.st.com>
 <b790f34e-8bfb-44f6-869d-798508008483@denx.de>
 <3137049f-eac8-4522-ad2e-b2b0d3537239@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <3137049f-eac8-4522-ad2e-b2b0d3537239@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/13/24 5:11 PM, Christophe ROULLIER wrote:
> 
> On 4/26/24 17:37, Marek Vasut wrote:
>> On 4/26/24 2:57 PM, Christophe Roullier wrote:
>>> Some cleaning because some Ethernet PHY configs do not need to add
>>> st,ext-phyclk property.
>>> Change print info message "No phy clock provided" only when debug.
>>>
>>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>>> ---
>>>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 27 ++++++++++---------
>>>   1 file changed, 14 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c 
>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> index 7529a8d15492..e648c4e790a7 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> @@ -55,17 +55,17 @@
>>>    *|         |        |      25MHz    |        50MHz 
>>> |                  |
>>>    * 
>>> ---------------------------------------------------------------------------
>>>    *|  MII    |     -   |     eth-ck    |          n/a | n/a        |
>>> - *|         |        | st,ext-phyclk | |             |
>>> + *|         |        |                 | |             |
>>>    * 
>>> ---------------------------------------------------------------------------
>>>    *|  GMII   |     -   |     eth-ck    |          n/a | n/a        |
>>> - *|         |        | st,ext-phyclk | |             |
>>> + *|         |        |               | |             |
>>>    * 
>>> ---------------------------------------------------------------------------
>>>    *| RGMII   |     -   |     eth-ck    |          n/a | eth-ck      |
>>> - *|         |        | st,ext-phyclk |                    | 
>>> st,eth-clk-sel or|
>>> + *|         |        |               |                    | 
>>> st,eth-clk-sel or|
>>>    *|         |        |               |                    | 
>>> st,ext-phyclk    |
>>>    * 
>>> ---------------------------------------------------------------------------
>>>    *| RMII    |     -   |     eth-ck    |        eth-ck | n/a        |
>>> - *|         |        | st,ext-phyclk | st,eth-ref-clk-sel 
>>> |             |
>>> + *|         |        |               | st,eth-ref-clk-sel 
>>> |             |
>>>    *|         |        |               | or st,ext-phyclk 
>>> |             |
>>>    * 
>>> ---------------------------------------------------------------------------
>>>    *
>>> @@ -174,23 +174,22 @@ static int stm32mp1_set_mode(struct 
>>> plat_stmmacenet_data *plat_dat)
>>>       dwmac->enable_eth_ck = false;
>>>       switch (plat_dat->mac_interface) {
>>>       case PHY_INTERFACE_MODE_MII:
>>> -        if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
>>> +        if (clk_rate == ETH_CK_F_25M)
>>
>> I see two problems here.
>>
>> First, according to the table above, in MII mode, clk_rate cannot be 
>> anything else but 25 MHz, so the (clk_rate == ETH_CK_F_25M) condition 
>> is always true. Why not drop that condition ?
> Not agree, there is also "Normal" case MII (MII with quartz/cristal) 
> (first column in the table above), so need to keep this test to check 
> clk_rate 25MHz.

What other rate is supported in the MII mode ? Isn't the rate always 25 
MHz for MII , no matter whether it is generated by RCC or external Xtal ?

>> The "dwmac->ext_phyclk" means "Ethernet PHY have no crystal", which 
>> means the clock are provided by the STM32 RCC clock IP instead, which 
>> means if the dwmac->ext_phyclk is true, dwmac->enable_eth_ck should be 
>> set to true, because dwmac->enable_eth_ck controls the enablement of 
>> these STM32 clock IP generated clock.
> Right
>>
>> Second, as far as I understand it, there is no way to operate this IP 
>> with external clock in MII mode, so this section should always be only:
>>
>> dwmac->enable_eth_ck = true;
> Not for case "Normal" MII :-)

What happens if that external clock source is not an xtal, but an 
oscillator with its own driver described in DT, and enabled e.g. using 
GPIO (that's compatible "gpio-gate-clock" for that oscillator) . Then 
you do need to enable those clock even in the "normal" (with external 
clock source instead of RCC clock source) MII case.

>>>               dwmac->enable_eth_ck = true;
>>>           val = dwmac->ops->pmcsetr.eth1_selmii;
>>>           pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
>>>           break;
>>>       case PHY_INTERFACE_MODE_GMII:
>>>           val = SYSCFG_PMCR_ETH_SEL_GMII;
>>> -        if (clk_rate == ETH_CK_F_25M &&
>>> -            (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
>>> +        if (clk_rate == ETH_CK_F_25M)
>>>               dwmac->enable_eth_ck = true;
>>> -            val |= dwmac->ops->pmcsetr.eth1_clk_sel;
>>> -        }
>>>           pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
>>>           break;
>>>       case PHY_INTERFACE_MODE_RMII:
>>>           val = dwmac->ops->pmcsetr.eth1_sel_rmii | 
>>> dwmac->ops->pmcsetr.eth2_sel_rmii;
>>> -        if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
>>> +        if (clk_rate == ETH_CK_F_25M)
>>> +            dwmac->enable_eth_ck = true;
>>> +        if (clk_rate == ETH_CK_F_50M &&
>>>               (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
>>
>> This doesn't seem to be equivalent change to the previous code . Here, 
>> if the clock frequency is 25 MHz, the clock are unconditionally 
>> enabled. Before, the code enabled the clock only if clock frequency 
>> was 25 MHz AND one of the "dwmac->eth_ref_clk_sel_reg" or 
>> "dwmac->ext_phyclk" was set (i.e. clock provided by SoC RCC clock IP).
> 
> You are right, but in STM32MP15/MP13 reference manual it is write that 
> we need to update SYSCFG (SYSCFG_PMCSETR) register only in "Ethernet 
> 50MHz RMII clock selection":
> 
> Bit 17 ETH_REF_CLK_SEL: Ethernet 50MHz RMII clock selection.
> 
>      Set by software.
> 
>        0: Writing '0' has no effect, reading '0' means External clock is 
> used. Need selection of AFMux. Could be used with all PHY
> 
>        1: Writing '1' set this bit, reading '1' means Internal clock 
> ETH_CLK1 from RCC is used regardless AFMux. Could be used only with RMII 
> PHY

Look at this:
"
RM0436 Rev 6 Reset and clock control (RCC)
Clock distribution for Ethernet (ETH)
Figure 83. Peripheral clock distribution for Ethernet
Page 575
"
See the mux at bottom left side in the PKCS group.

I suspect that no matter whether the clock are 25 MHz or 50 MHz, they 
enter this mux, the mux selects the clock source from either RCC or from 
external oscillator, and therefore the original code was correct.

>> I think it might make this code easier if you drop all of the 
>> frequency test conditionals, which aren't really all that useful, and 
>> only enable the clock if either dwmac->ext_phyclk / 
>> dwmac->eth_clk_sel_reg / dwmac->eth_ref_clk_sel_reg is set , because 
>> effectively what this entire convoluted code is implementing is "if 
>> (clock supplied by clock IP i.e. RCC) enable the clock()" *, right ?
>>
>> * And it is also toggling the right clock mux bit in PMCSETR.
>>
>> So, for MII this would be plain:
>> dwmac->enable_eth_ck = true;
>>
>> For GMII/RGMII this would be:
>> if (dwmac->ext_phyclk || dwmac->eth_clk_sel_reg)
>>   dwmac->enable_eth_ck = true;
>>
>> For RMII this would be:
>> if (dwmac->ext_phyclk || dwmac->eth_ref_clk_sel_reg)
>>   dwmac->enable_eth_ck = true;
>>
>> Maybe the clock frequency validation can be retained, but done 
>> separately?
> As explained previously, need to keep check of clock frequency in this 
> test.

I sent 5 patches which split this code up, you were on CC:

[net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32: Separate out external 
clock rate validation

Maybe you can apply those, fix them up as needed, and then add this 
series on top ? I think it would simplify this code a lot, since that 
series splits up the clock rate validation / PMCR configuration / 
external-internal clock selection into separate steps. What do you think ?

