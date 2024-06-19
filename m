Return-Path: <netdev+bounces-105003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA03690F6C9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 21:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768671F21563
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 19:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD4158A08;
	Wed, 19 Jun 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Cd0+vLiX"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D353398;
	Wed, 19 Jun 2024 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824514; cv=none; b=tswks0PsKuQZ31kfoppyX200qCppZMnLhvLftcs4AjCBp2TX41GhT20BGXXDCJvWECRByx2s94T2aNdkrxV1OCOp/v/KjDNyI1T23CxJYYj8iW5A7EDQl/+xE9PpLQOy7lOMF+HnS2utYpsb0vIeRKMi5FBd5nGgu4QestIb1+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824514; c=relaxed/simple;
	bh=i1O+8SuJRlMo4HLcHbCW/vbpdUEkEZ114ilGvFd19Ic=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RZ5GnmGTrhymODJgW2IZlC7b8sYXigAs8QVl6tOptr4sbyN6FJTcB7iGhauvYy2BInYli7U2PJhEC/Be2VUDJ402nVYV5xBuD9knodiTSdDwx6pUSQAIkfgIC2VzeBBFbwMpIliqmcO9k5xNlk7IW9LktBv173ZYTBkDVIALRUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=Cd0+vLiX; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 5B74C80E9A;
	Wed, 19 Jun 2024 21:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718824509;
	bh=2sBQZJl5GOkXP3lCyMuq4jH0kmltgWo/xNkz+SDOjYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cd0+vLiXuXd7IoP6GMpUo+GrIyTzbVea4Xu335PLbu6D/Yc6LFvWzly2fNYHc2m7H
	 Yjm4LrPiwU9KJS83HZrpsHUmgj3lqqh2NXA5snyQ1JjTP5n25zXtJ5EocpLmiVIThs
	 eq5FKj01f6LceN/HxDjcERepanO7x6UHBgxsAx3R3Klda7ISxU3p1/IOqY/Qmf3Kv7
	 I+9sMR+27WkqjXBz/iogHaDdF7kJscPA2KOoa/tQE+LPe9N3gLDuccEFce9BMB739+
	 0IolR48QcLxw5NVvYI4vq70puRptIKievYIdjcqTARywnZFdy5chlQjqSf7okigfay
	 CTMqyLUAZYn5A==
Message-ID: <b760c6ba-36aa-4486-891a-c40a8cac7c1b@denx.de>
Date: Wed, 19 Jun 2024 20:56:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] net: stmmac: dwmac-stm32: stm32: add
 management of stm32mp25 for stm32
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
References: <20240614130812.72425-1-christophe.roullier@foss.st.com>
 <20240614130812.72425-3-christophe.roullier@foss.st.com>
 <4c2f1bac-4957-4814-bf62-816340bd9ff6@denx.de>
 <09010b02-fb55-4c4b-9d0c-36bd0b370dc8@foss.st.com>
 <39d35f6d-4f82-43af-883b-a574b8a67a1a@denx.de>
 <8c3f1696-d67c-4960-ad3a-90461c896aa5@foss.st.com>
 <3dee3c8a-12f0-42bd-acdf-8008da795467@denx.de>
 <aee3f6d2-6a44-4de6-9348-f83c4107188f@foss.st.com>
 <c74f393d-7d0a-4a34-8e72-553ccf273a41@denx.de>
 <01e435a5-3a69-49a5-9d5e-ab9af0a2af7b@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <01e435a5-3a69-49a5-9d5e-ab9af0a2af7b@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/19/24 5:40 PM, Christophe ROULLIER wrote:
> 
> On 6/19/24 15:14, Marek Vasut wrote:
>> On 6/19/24 9:41 AM, Christophe ROULLIER wrote:
>>
>> Hi,
>>
>>>>>>>>> +static int stm32mp2_configure_syscfg(struct 
>>>>>>>>> plat_stmmacenet_data *plat_dat)
>>>>>>>>> +{
>>>>>>>>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>>>>>>>> +    u32 reg = dwmac->mode_reg;
>>>>>>>>> +    int val = 0;
>>>>>>>>> +
>>>>>>>>> +    switch (plat_dat->mac_interface) {
>>>>>>>>> +    case PHY_INTERFACE_MODE_MII:
>>>>>>>>> +        break;
>>>>>>>>
>>>>>>>> dwmac->enable_eth_ck does not apply to MII mode ? Why ?
>>>>>>>
>>>>>>> It is like MP1 and MP13, nothing to set in syscfg register for 
>>>>>>> case MII mode wo crystal.
>>>>>>
>>>>>> Have a look at STM32MP15xx RM0436 Figure 83. Peripheral clock 
>>>>>> distribution for Ethernet.
>>>>>>
>>>>>> If RCC (top-left corner of the figure) generates 25 MHz MII clock 
>>>>>> (yellow line) on eth_clk_fb (top-right corner), can I set 
>>>>>> ETH_REF_CLK_SEL to position '1' and ETH_SEL[2] to '0' and feed ETH 
>>>>>> (right side) clk_rx_i input with 25 MHz clock that way ?
>>>>>>
>>>>>> I seems like this should be possible, at least theoretically. Can 
>>>>>> you check with the hardware/silicon people ?
>>>>> No it is not possible (it will work if speed (and frequency) is 
>>>>> fixed 25Mhz=100Mbps, but for speed 10Mbps (2,5MHz) it will not work.
>>>>
>>>> Could the pll4_p_ck or pll3_q_ck generate either 25 MHz or 2.5 MHz 
>>>> as needed in that case ? Then it would work, right ?
>>>
>>> Yes you can set frequency you want for pll4 or pll3, if you set 25MHz 
>>> and auto-negotiation of speed is 100Mbps it should work (pad ETH_CK 
>>> of 25MHz clock the PHY and eth_clk_fb set to 25MHz for clk_RX)
>>>
>>> but if autoneg of speed is 10Mbps, then 2.5MHz is needed for clk_RX 
>>> (you will provide 25Mhz)
>>
>> What if:
>>
>> - Aneg is 10 Mbps
>> - PLL4_P_CK/PLL3_Q_CK = 2.5 MHz
>> - ETH_REF_CLK_SEL = 1
>> - ETH_SEL[2] = 0
>>
>> ?
>>
>> Then, clk_rx_i is 2.5 MHz, right ?
> Yes that right
>>
>> Does this configuration work ?
> For me no, because PHY Ethernet Oscillator/cristal need in PAD 25Mhz or 
> 50Mhz, I think it is does not work if oscillator frequency provided is 
> 2.5MHz (To my knowledge there is no Ethernet PHY which have oscillator 
> working to 2.5MHz)

Would it work if the PHY had a dedicated Xtal , while the clocking of 
the MAC was done using RCC ?

