Return-Path: <netdev+bounces-102335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC0C9027E8
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 19:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D2C1C21EAD
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 17:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AC3147C74;
	Mon, 10 Jun 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="WQBUSD37"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89B1142E79;
	Mon, 10 Jun 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718041385; cv=none; b=a6J+4d+aDI+/wFeCm6CITIFUrBUdu19Wuk0hr0gM08rqxXwX7PCpTqnO1gRZyxeHQiuDpLuS38Mm5ExSpEadEWSbiIBkxK8e+zzVQdFfPgCWAW/Scb1Lp+FverM1p60QegVb9nU9dycCsCCEUecF7iaHrIHvxJD0/v2ZjOZpJI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718041385; c=relaxed/simple;
	bh=pukq89EYTWZWICSg4WGUTWv7xVz+jUHs/C8/2F8z0KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuwxqlTmhe2Mq2e40yNTk9LXPVw3NxflUJeHF8xt4GYrZzsJmJ1Q6Tu3y47nmYJLtm8cDKqlDiPWCZuEsEUlBK7XJDlB0+nDH3Au46qLrT5zMI62Qif/M2eOVDeqoYCGm7JskBwDSAPBbd3bVKvqwGIt2OAYLTPY9mWurKmHx/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=WQBUSD37; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 684A2885A5;
	Mon, 10 Jun 2024 19:42:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1718041381;
	bh=oaOQDVrDft+8XHfut53lIpAIfzu9c8ayaQ0+Eg7Nxow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WQBUSD3704u5IksQ+4ToSk+UzpJxx5XDQUX1YPYUz2ydq/y8quhOFWlrcza8nueUx
	 YjyxaYOzD3WEXXa6xqFxLJrdCr6zaNB9WgGZY/cwqTySfG2ktmoLSn+IAAWJ39aYaz
	 lPQro+4RKDvhuztSWyu8q/z3j1tMDLNlwddixzQkrqjyXL2HnaTqIiulZaLTRSXTEv
	 f8smfN95RqhPw7Oe0wrkOqrAfmJtowy0aeaOUH9SM+MfZjRXqzbNp6lgRvVKq1y57y
	 RJ6FKOabNXnR1VORrukqhc/kzNhX7sErSjR5iOTp5aBK2NyQwk34IH9z00pYbnV5NW
	 O/HppF4vFXwGA==
Message-ID: <bf3238fb-4fad-49b2-975c-e35d93cafe7c@denx.de>
Date: Mon, 10 Jun 2024 19:29:31 +0200
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
 <09105afe-1123-407a-96c3-2ea88602aad0@denx.de>
 <91af5c61-f23f-4f72-a8c8-f32b2c368768@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <91af5c61-f23f-4f72-a8c8-f32b2c368768@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/10/24 3:49 PM, Christophe ROULLIER wrote:
> 
> On 6/10/24 15:43, Marek Vasut wrote:
>> On 6/10/24 1:45 PM, Christophe ROULLIER wrote:
>>>
>>> On 6/10/24 12:39, Marek Vasut wrote:
>>>> On 6/10/24 9:14 AM, Christophe Roullier wrote:
>>>>
>>>> [...]
>>>>
>>>>>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
>>>>> @@ -303,7 +307,7 @@ static int stm32mcu_set_mode(struct 
>>>>> plat_stmmacenet_data *plat_dat)
>>>>>       dev_dbg(dwmac->dev, "Mode %s", 
>>>>> phy_modes(plat_dat->mac_interface));
>>>>>         return regmap_update_bits(dwmac->regmap, reg,
>>>>> -                 dwmac->ops->syscfg_eth_mask, val << 23);
>>>>> +                 SYSCFG_MCU_ETH_MASK, val << 23);
>>>>>   }
>>>>>     static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac, 
>>>>> bool suspend)
>>>>> @@ -348,8 +352,15 @@ static int stm32_dwmac_parse_data(struct 
>>>>> stm32_dwmac *dwmac,
>>>>>           return PTR_ERR(dwmac->regmap);
>>>>>         err = of_property_read_u32_index(np, "st,syscon", 1, 
>>>>> &dwmac->mode_reg);
>>>>> -    if (err)
>>>>> +    if (err) {
>>>>>           dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
>>>>> +        return err;
>>>>> +    }
>>>>> +
>>>>> +    dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>>>>> +    err = of_property_read_u32_index(np, "st,syscon", 2, 
>>>>> &dwmac->mode_mask);
>>>>> +    if (err)
>>>>> +        dev_dbg(dev, "Warning sysconfig register mask not set\n");
>>>>
>>>> Isn't this an error , so dev_err() ?
>>> No, it is only "warning" information, for MP1 the mask is not needed 
>>> (and for backward compatibility is not planned to put mask parameter 
>>> mandatory)
>>
>> Should this be an error for anything newer than MP15 then ?
> For MP25, no need of mask, so for moment it is specific to MP13.

Make this a warning for MP15, error for MP13, do not check st,syscon 
presence for MP2 at all. Would that work ?

