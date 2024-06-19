Return-Path: <netdev+bounces-104889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544FA90EFCC
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D608A285BC9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A561514D0;
	Wed, 19 Jun 2024 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="CfPSkKHk"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177114C580;
	Wed, 19 Jun 2024 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806174; cv=none; b=VvEqiQkylnZnrlDXi4Tdrto7t46Sl/k7UiA4JF9aLfCJXiDt+SFAm2T6ncFdvGjDyfMNDB5anQoeZhbltGvlFkfe7WOrCNAaAiS+/mXoHltmzsUMJYkEPsP9zSJG4JyiQCn23VDt14i9xReLF/wn8eW9oKHc3gRum1JDSIKKSTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806174; c=relaxed/simple;
	bh=vNTWUvzvwPsimUHMwHuNMYFoXl+1mUAFJHC4OqY52U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h0GmzCtCf8Q/mlwxB4alEYPpBpzvqc4iCgc/ttZQRKlRk8qmp9yVu1XKSXtu34MAn7RhYTev0YKinAdzvsFzz3Q80QTMojRlg03O+y2kwFRO3S2WHxCokUb8k13RTPBDyDz+3JkiAhFQGESssSZVjg/AEsiJ91jrpaQloH2qsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=CfPSkKHk; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4629887E06;
	Wed, 19 Jun 2024 16:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718806170;
	bh=eQ6vqBt94joW7Ooa01IlSDqeWrqMQA+Hz1uPRPlEmGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CfPSkKHkACfQ6hgJUgqu2RlNphNugjv79GL2XiDs1EYtKeTKiXb5IJoanlpGWfxDd
	 NUauXk09BAtK+1vaUGjLUjvPLjXUxLk/issObN2e4envrlkJ+udHNGs44QO/v4SafL
	 057n5R5ghAWEYIsxU3i4db/Sa8EzB7G3Fo3VcaDg8VuDSSHbU4J+6lqQA6neKzv0KX
	 97Op4k+d4+C4a8jNuNRaqOjMxKk6veVOvj2QH3+4lrpkj3aika7+89RxnGxDBr3yl/
	 +L923G6m86MDL47ag24C06g/1wVz1tJAdSbmwl/pwt9Fc+alnnl4FmOuyQGd29oTq1
	 P1FQgYhcJ1qmA==
Message-ID: <c74f393d-7d0a-4a34-8e72-553ccf273a41@denx.de>
Date: Wed, 19 Jun 2024 15:14:03 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <aee3f6d2-6a44-4de6-9348-f83c4107188f@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/19/24 9:41 AM, Christophe ROULLIER wrote:

Hi,

>>>>>>> +static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data 
>>>>>>> *plat_dat)
>>>>>>> +{
>>>>>>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>>>>>> +    u32 reg = dwmac->mode_reg;
>>>>>>> +    int val = 0;
>>>>>>> +
>>>>>>> +    switch (plat_dat->mac_interface) {
>>>>>>> +    case PHY_INTERFACE_MODE_MII:
>>>>>>> +        break;
>>>>>>
>>>>>> dwmac->enable_eth_ck does not apply to MII mode ? Why ?
>>>>>
>>>>> It is like MP1 and MP13, nothing to set in syscfg register for case 
>>>>> MII mode wo crystal.
>>>>
>>>> Have a look at STM32MP15xx RM0436 Figure 83. Peripheral clock 
>>>> distribution for Ethernet.
>>>>
>>>> If RCC (top-left corner of the figure) generates 25 MHz MII clock 
>>>> (yellow line) on eth_clk_fb (top-right corner), can I set 
>>>> ETH_REF_CLK_SEL to position '1' and ETH_SEL[2] to '0' and feed ETH 
>>>> (right side) clk_rx_i input with 25 MHz clock that way ?
>>>>
>>>> I seems like this should be possible, at least theoretically. Can 
>>>> you check with the hardware/silicon people ?
>>> No it is not possible (it will work if speed (and frequency) is fixed 
>>> 25Mhz=100Mbps, but for speed 10Mbps (2,5MHz) it will not work.
>>
>> Could the pll4_p_ck or pll3_q_ck generate either 25 MHz or 2.5 MHz as 
>> needed in that case ? Then it would work, right ?
> 
> Yes you can set frequency you want for pll4 or pll3, if you set 25MHz 
> and auto-negotiation of speed is 100Mbps it should work (pad ETH_CK of 
> 25MHz clock the PHY and eth_clk_fb set to 25MHz for clk_RX)
> 
> but if autoneg of speed is 10Mbps, then 2.5MHz is needed for clk_RX (you 
> will provide 25Mhz)

What if:

- Aneg is 10 Mbps
- PLL4_P_CK/PLL3_Q_CK = 2.5 MHz
- ETH_REF_CLK_SEL = 1
- ETH_SEL[2] = 0

?

Then, clk_rx_i is 2.5 MHz, right ?

Does this configuration work ?

> . For RMII case, frequency from pll (eth_clk_fb) is 
> automatically adjust in function of speed value, thanks to diviser /2, 
> /20 with mac_speed_o.

