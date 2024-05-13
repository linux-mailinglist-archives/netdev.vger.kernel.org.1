Return-Path: <netdev+bounces-96079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B406E8C43C6
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A30E1F22484
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC1E57860;
	Mon, 13 May 2024 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="FzGVcKZC"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94536481B4;
	Mon, 13 May 2024 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612813; cv=none; b=pBH6moSjAoDBHFvuJzZ16y3w/yJWu4JtLkfONo1RM6yyFLBDbMlZNDqd3q7M3nqcqqqYFsG+Rh2ADVXvEEveqoaKFo/S03dTpCENSiOykDBn8uskYi0a0AFXOQS0K5xQ0Hmzbva06ut0Ubqb7NeDy868OylUt6cI5dkFSXP8E9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612813; c=relaxed/simple;
	bh=IN5FgUhtlMjFxTzDgVX2FWKYY5fLiLonCvVQazjK9KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cXdTC7Q/4cc1RXCuzdbw8/hY0Gj3bzAdxawfAirsdYHtFlnArv403f0b+yupc7KG6gsQ6aw84A+azfAQGLQ1Wep31RA7IzpWcto2FPKpxy8lhqYAUrJTO/sYvqg/zyxHWG/lV26Dq4rsHNim/5eFXE3E6yVrNEpZxg3UV0ZlTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=FzGVcKZC; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id AD39D882ED;
	Mon, 13 May 2024 17:06:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715612809;
	bh=YhXmpuQMSBlWuqvNlqebAMChQCjfvMpYn7wSLo1Cbdw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FzGVcKZCVERzROGGwpxMg9kiTbE8/p+IQYQLDbtuLDUIaHDOYfn8Un7/qT30EgVbm
	 io1mW0ZEzY3A/1toRYEeiFrHh8mOpghp5A/+6dJ2/s+vIXSG/wvN0JmZDwkp654ARH
	 Bc5d3r/+XrdNapW2lYTjqjqs8ae4ZxX/m1/uwHuqVoaBbHM8nCnarfTsqOxhwAbtk2
	 05QvdApfQR1mYm4Gv6YfA4M7zXa2fYwalYemwuxJeLZY+b0gxMgw3vvItTRkhUL0up
	 dN2cq+njdvptMZuZFT9PRzFnC2jinvFHoN957Q5PZiadJLgBLhlKmWoH+tF+aU8OAd
	 4Thv1bK0VM0vg==
Message-ID: <2b1ed649-ab05-4cfe-86be-96e1a96ec76f@denx.de>
Date: Mon, 13 May 2024 16:23:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] net: stmmac: dwmac-stm32: rework glue to
 simplify management
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
 <20240426125707.585269-4-christophe.roullier@foss.st.com>
 <56f2d023-82d5-4910-8c4e-68e9d62bd1fe@denx.de>
 <4da0ce80-2120-4d67-aaaa-7dbf13b1da73@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <4da0ce80-2120-4d67-aaaa-7dbf13b1da73@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/13/24 2:48 PM, Christophe ROULLIER wrote:
> Hi
> 
> On 4/26/24 16:53, Marek Vasut wrote:
>> On 4/26/24 2:56 PM, Christophe Roullier wrote:
>>> Change glue to be more generic and manage easily next stm32 products.
>>> The goal of this commit is to have one stm32mp1_set_mode function which
>>> can manage different STM32 SOC. SOC can have different SYSCFG register
>>> bitfields. so in pmcsetr we defined the bitfields corresponding to 
>>> the SOC.
>>>
>>> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
>>> ---
>>>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 76 +++++++++++++------
>>>   1 file changed, 51 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c 
>>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> index c92dfc4ecf57..68a02de25ac7 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>>> @@ -23,10 +23,6 @@
>>>     #define SYSCFG_MCU_ETH_MASK        BIT(23)
>>>   #define SYSCFG_MP1_ETH_MASK        GENMASK(23, 16)
>>> -#define SYSCFG_PMCCLRR_OFFSET        0x40
>>> -
>>> -#define SYSCFG_PMCR_ETH_CLK_SEL        BIT(16)
>>> -#define SYSCFG_PMCR_ETH_REF_CLK_SEL    BIT(17)
>>>     /* CLOCK feed to PHY*/
>>>   #define ETH_CK_F_25M    25000000
>>> @@ -46,9 +42,6 @@
>>>    * RMII  |   1     |   0      |   0       |  n/a  |
>>>    *------------------------------------------
>>>    */
>>> -#define SYSCFG_PMCR_ETH_SEL_MII        BIT(20)
>>> -#define SYSCFG_PMCR_ETH_SEL_RGMII    BIT(21)
>>> -#define SYSCFG_PMCR_ETH_SEL_RMII    BIT(23)
>>>   #define SYSCFG_PMCR_ETH_SEL_GMII    0
>>>   #define SYSCFG_MCU_ETH_SEL_MII        0
>>>   #define SYSCFG_MCU_ETH_SEL_RMII        1
>>> @@ -90,19 +83,33 @@ struct stm32_dwmac {
>>>       int eth_ref_clk_sel_reg;
>>>       int irq_pwr_wakeup;
>>>       u32 mode_reg;         /* MAC glue-logic mode register */
>>> +    u32 mode_mask;
>>>       struct regmap *regmap;
>>>       u32 speed;
>>>       const struct stm32_ops *ops;
>>>       struct device *dev;
>>>   };
>>>   +struct stm32_syscfg_pmcsetr {
>>> +    u32 eth1_clk_sel;
>>> +    u32 eth1_ref_clk_sel;
>>> +    u32 eth1_selmii;
>>> +    u32 eth1_sel_rgmii;
>>> +    u32 eth1_sel_rmii;
>>> +    u32 eth2_clk_sel;
>>> +    u32 eth2_ref_clk_sel;
>>> +    u32 eth2_sel_rgmii;
>>> +    u32 eth2_sel_rmii;
>>> +};
>>
>> [...]
>>
>>> @@ -487,8 +502,19 @@ static struct stm32_ops stm32mp1_dwmac_data = {
>>>       .suspend = stm32mp1_suspend,
>>>       .resume = stm32mp1_resume,
>>>       .parse_data = stm32mp1_parse_data,
>>> -    .syscfg_eth_mask = SYSCFG_MP1_ETH_MASK,
>>> -    .clk_rx_enable_in_suspend = true
>>> +    .clk_rx_enable_in_suspend = true,
>>> +    .syscfg_clr_off = 0x44,
>>> +    .pmcsetr = {
>>> +        .eth1_clk_sel        = BIT(16),
>>> +        .eth1_ref_clk_sel    = BIT(17),
>>> +        .eth1_selmii        = BIT(20),
>>> +        .eth1_sel_rgmii        = BIT(21),
>>> +        .eth1_sel_rmii        = BIT(23),
>>> +        .eth2_clk_sel        = 0,
>>> +        .eth2_ref_clk_sel    = 0,
>>> +        .eth2_sel_rgmii        = 0,
>>> +        .eth2_sel_rmii        = 0
>>> +    }
>>>   };
>>
>> Is this structure really necessary ?
>>
> I prefer to keep this implementation for the moment, as it is working 
> fine. Maybe at a later stage, I will send some optimizations.

BIT() and left shift by 8 works all the same, without all this 
complexity and new structures, since all you really have on MP13 are two 
identical bitfields (one at offset 16, the other at offset 24) with the 
same bits in them, so why not make this simple ?

