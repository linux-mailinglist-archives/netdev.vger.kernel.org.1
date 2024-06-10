Return-Path: <netdev+bounces-102274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90E3902333
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 15:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81ACF282D25
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 13:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D891412F5B6;
	Mon, 10 Jun 2024 13:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="oswnRRgJ"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088E1824A7;
	Mon, 10 Jun 2024 13:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718027130; cv=none; b=PxF8crccpttrEtJfBjVpGn8cA2ojq5VVOOAQcLRteOkjV3C4o/vCenjxCA2VJP8opP4z8XLucVCRF2MntCPLx5eqojAOUo3482OL7NBPxN82AA43NzkxWVmYtSjEYCiDPB0RhnafqJ2nBHblChIH0BdF68Y1giPd1yhmdPu9UXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718027130; c=relaxed/simple;
	bh=HUzVcOKwt3n8v4S633OoGkbwS2m/jgHHZmt+g82ohZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dCH6zQAlChgHc8eE3EmtCVtdMrXcQmaWuMlqP7lEBv+OjtMlYdd8um5oBH6LZG81R5y3Jb2l/ti+bMnBQWl+YtbyC0ncl2Tm1AzlwiGeZSp6GHXRNMmwSVWhyKJ5bH3rP2Rq9HZXnyE+dYaBos1mthXm4rxTsiOGhoxjZ662Rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=oswnRRgJ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CB023883D2;
	Mon, 10 Jun 2024 15:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718027127;
	bh=z+YAHBI/Z+3VNc3TEhUT33G8bD0GATdmtiU4ObQgIxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oswnRRgJs0dZeDx6cEzRP+cjqeMFnq3UbuJLyc5aJTofIafPTT9C8bKu9mgtbOqAc
	 +V6Y9/sXhHD8dNsYWqwsSsyLtHOw25bbSc1AV5moxNghJeMYnZ3x2fZstr6cHrt5rz
	 A7jNAkDI/liwIuAQk4YweZns11YDYRMu/KdZMjrmm+wMC+NP2uQKd02tqTmUY5i+gC
	 Hb+ya75YE4ks9RncB4P1ZlH7tG8qdngaFYwSxp31zRfo0SIV1bku5KxLeT/pG1ewzY
	 tO09rOcb9RaUY3rC5qsLHbJYxQETX/nwayPj9oTG5pBShdPehD5OBmM9TuQRv3zvPU
	 i/taDf05suEhg==
Message-ID: <09105afe-1123-407a-96c3-2ea88602aad0@denx.de>
Date: Mon, 10 Jun 2024 15:43:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH v6 7/8] net: stmmac: dwmac-stm32: Mask support
 for PMCR configuration
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
References: <20240610071459.287500-1-christophe.roullier@foss.st.com>
 <20240610071459.287500-8-christophe.roullier@foss.st.com>
 <20139233-4e95-4fe5-84ca-734ee866afca@denx.de>
 <c5ea12e7-5ee6-4960-9141-e774ccd9977b@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c5ea12e7-5ee6-4960-9141-e774ccd9977b@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/10/24 1:45 PM, Christophe ROULLIER wrote:
> 
> On 6/10/24 12:39, Marek Vasut wrote:
>> On 6/10/24 9:14 AM, Christophe Roullier wrote:
>>
>> [...]
>>
>>>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>>> @@ -303,7 +307,7 @@ static int stm32mcu_set_mode(struct 
>>> plat_stmmacenet_data *plat_dat)
>>>       dev_dbg(dwmac->dev, "Mode %s", 
>>> phy_modes(plat_dat->mac_interface));
>>>         return regmap_update_bits(dwmac->regmap, reg,
>>> -                 dwmac->ops->syscfg_eth_mask, val << 23);
>>> +                 SYSCFG_MCU_ETH_MASK, val << 23);
>>>   }
>>>     static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, 
>>> bool suspend)
>>> @@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct 
>>> stm32_dwmac *dwmac,
>>>           return PTR_ERR(dwmac->regmap);
>>>         err = of_property_read_u32_index(np, "st,syscon", 1, 
>>> &dwmac->mode_reg);
>>> -    if (err)
>>> +    if (err) {
>>>           dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
>>> +        return err;
>>> +    }
>>> +
>>> +    dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>>> +    err = of_property_read_u32_index(np, "st,syscon", 2, 
>>> &dwmac->mode_mask);
>>> +    if (err)
>>> +        dev_dbg(dev, "Warning sysconfig register mask not set\n");
>>
>> Isn't this an error , so dev_err() ?
> No, it is only "warning" information, for MP1 the mask is not needed 
> (and for backward compatibility is not planned to put mask parameter 
> mandatory)

Should this be an error for anything newer than MP15 then ?

