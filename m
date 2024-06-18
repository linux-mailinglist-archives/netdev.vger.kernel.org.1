Return-Path: <netdev+bounces-104591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F10D90D74C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 17:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487B8281DC8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BB72D030;
	Tue, 18 Jun 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="sLM3Shlt"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226BD4A35;
	Tue, 18 Jun 2024 15:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724622; cv=none; b=V5DJVghLEjmzwix0u7nY6ASae0yrXET+oux+rczBQRIuBhivN7oBEqV489Wj7Y22Oj02k+zKPLZJde2i/DBRXjxRGvb/KF680NeUdKf5DBHAijGML8YpCnG1RhpW+yUQexTvufU74A3xMle7L1ORemImUBJy/vECsN1zH5bJ29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724622; c=relaxed/simple;
	bh=+3+WEWy9yRWcbnapoHm1Wuk132/d/aeQzbXgYGX4PEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8NxuHKMDao31f4qh2Je85sIMZw/T0ghNYT6KF7YCKV/zltGkhcEcCzTirb0ufcW5Bfg/C/Id3ViEBb4Gp1CotK4kfFK6UXEY8GgNTfVEsjMC49VPOC/QEsybK5kCrQqSsyWJzUCryFJa8f1BChA4VXfdDiCTNHxaUlB+xFDlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=sLM3Shlt; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 339BF882EF;
	Tue, 18 Jun 2024 17:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718724618;
	bh=nhLaeYCPpeb5WH3lwke9ZKW0zsxGr0EgQUIFEEETETk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sLM3ShltpeRBYmZqreax/4suIoG+bBj7tlHfRhC9IFldcP0z5L4vX0yxSlgX8p53d
	 6ABrMbCTTSVR0bUQAPIZ3M/1fDBJtuMGSJJTHOuzpJrmXogyTlqEjwQMegZ1AuhgoR
	 IQlWy6ehQiZwO7s31znp3kKHEHpWrfnlAgmU3KlR03ZjCYqdcgNKns51/yu4sQ84/S
	 2XecyvmCEAOMrI5Sl2phtaWQVb5Sbsta8ph4T+8pzM2jJ4aZJqi4f/ze19MY2xKQJi
	 YEH7IDKlyn5gXHAJI4C+KoEmpFAlYiUpYm+kUfpxH1aG2cvqpnuBcNDRaDQL1HkyYw
	 KPaCiQuVCx1Jg==
Message-ID: <3dee3c8a-12f0-42bd-acdf-8008da795467@denx.de>
Date: Tue, 18 Jun 2024 17:00:33 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <8c3f1696-d67c-4960-ad3a-90461c896aa5@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/18/24 11:09 AM, Christophe ROULLIER wrote:

Hi,

>>>>> +static int stm32mp2_configure_syscfg(struct plat_stmmacenet_data 
>>>>> *plat_dat)
>>>>> +{
>>>>> +    struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>>>> +    u32 reg = dwmac->mode_reg;
>>>>> +    int val = 0;
>>>>> +
>>>>> +    switch (plat_dat->mac_interface) {
>>>>> +    case PHY_INTERFACE_MODE_MII:
>>>>> +        break;
>>>>
>>>> dwmac->enable_eth_ck does not apply to MII mode ? Why ?
>>>
>>> It is like MP1 and MP13, nothing to set in syscfg register for case 
>>> MII mode wo crystal.
>>
>> Have a look at STM32MP15xx RM0436 Figure 83. Peripheral clock 
>> distribution for Ethernet.
>>
>> If RCC (top-left corner of the figure) generates 25 MHz MII clock 
>> (yellow line) on eth_clk_fb (top-right corner), can I set 
>> ETH_REF_CLK_SEL to position '1' and ETH_SEL[2] to '0' and feed ETH 
>> (right side) clk_rx_i input with 25 MHz clock that way ?
>>
>> I seems like this should be possible, at least theoretically. Can you 
>> check with the hardware/silicon people ?
> No it is not possible (it will work if speed (and frequency) is fixed 
> 25Mhz=100Mbps, but for speed 10Mbps (2,5MHz) it will not work.

Could the pll4_p_ck or pll3_q_ck generate either 25 MHz or 2.5 MHz as 
needed in that case ? Then it would work, right ?

> (you can 
> see than diviser are only for RMII mode)

Do you refer to /2 and /20 dividers to the left of mac_speed_o[0] ?

