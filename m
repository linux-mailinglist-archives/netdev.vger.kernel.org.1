Return-Path: <netdev+bounces-100242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EA38D84FB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49AF1C21128
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0112F37F;
	Mon,  3 Jun 2024 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="SDMgS2UV"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F126E12D1FC;
	Mon,  3 Jun 2024 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425012; cv=none; b=ZvTR/gtb8irNOujWYgPlbwJSTYd4xhFZ/5U9Wscg9NDKD1bKLaAOnQJceZoyQVhCFVQzhY4s14nlI8SkAVEZYx5q/WsWYJLk8dAw37PGVduY+VNnfAkI3vz1ElCP4Ye2ItddRwZ4xr+6xpbUkc+vuN9l/fIh3qp5NAiD6YToK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425012; c=relaxed/simple;
	bh=0w3zP0hgy7Op0EkykpMwlsweE7iDTQYTQbzFF77SK48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YE6YOd17vj7XjYvnl19J0fiu39NiLCSjO3A2bvbxUS4GYq38Pep3WRA3ErE3kC6HbiXU9t7nl0N3V+WFt/S4A+H6WFD2aMgF01PEGXuyxeVzUwRSe4e2riPDhPqO/w2WZGhh8MVlnWwzRJShrC62pcfBRpobtwSOFumGHyuYTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=SDMgS2UV; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 1754387ECD;
	Mon,  3 Jun 2024 16:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717425007;
	bh=tS16nMscNeuJBS5c0fzS669yLH9RtEi4tcYfyXkUhuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SDMgS2UVdOI8UvPt8wogrk8xp1A3xjV8ZOsZUD1gY28a8Ya1HY55XyZcmVeX6X+Cm
	 ROCnzlw9Fp4qyi/4wW2rlEzq8ZlRSms9GkU9Cr9FfJjFYLfDseOmsEMUOkxx6z2r24
	 SIfotgjkAuf+3cP7a7wUlyoZSfWJe6PyNbGijmIsguRB3PQPMAqNaYnu88jmnxgDNs
	 sHbmIBytATd4WaV5abPrbDi4sJGG8YrPrSStAMs/GJJakkxcQU6KUTbbSnON1mU/P5
	 LNyVnEu7Xpz0vcuzYmXQ6w/Ob34Do32T2mc/dYo3kco8LauQ/TYoI6G7GjkQXqw4fq
	 bQnh5hf++mA3g==
Message-ID: <a992ecc9-bbb7-41af-9a0a-ff63a55d1652@denx.de>
Date: Mon, 3 Jun 2024 15:01:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/11] net: ethernet: stmmac: add management of
 stm32mp13 for stm32
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
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
References: <20240603092757.71902-1-christophe.roullier@foss.st.com>
 <20240603092757.71902-8-christophe.roullier@foss.st.com>
 <d5ce5037-7b77-42bc-8551-2165b7ed668f@prevas.dk>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <d5ce5037-7b77-42bc-8551-2165b7ed668f@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/3/24 1:30 PM, Rasmus Villemoes wrote:
> On 03/06/2024 11.27, Christophe Roullier wrote:
> 
>> @@ -259,13 +268,17 @@ static int stm32mp1_configure_pmcr(struct plat_stmmacenet_data *plat_dat)
>>   
>>   	dev_dbg(dwmac->dev, "Mode %s", phy_modes(plat_dat->mac_interface));
>>   
>> +	/* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
>> +	val <<= ffs(dwmac->mode_mask) - ffs(SYSCFG_MP1_ETH_MASK);
>> +
>>   	/* Need to update PMCCLRR (clear register) */
>> -	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
>> -		     dwmac->ops->syscfg_eth_mask);
>> +	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
>> +		     dwmac->mode_mask);
>>   
>>   	/* Update PMCSETR (set register) */
>>   	return regmap_update_bits(dwmac->regmap, reg,
>> -				 dwmac->ops->syscfg_eth_mask, val);
>> +				 dwmac->mode_mask, val);
>>   }
>>   
>>   static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
> 
> This hunk is broken, and makes the patch not apply:
> 
> Applying: net: ethernet: stmmac: add management of stm32mp13 for stm32
> error: corrupt patch at line 70
> 
> The -259,13 seems correct, and the net lines added by previous hunks is
> indeed +9, but this hunk only adds three more lines than it removes, not
> four, so the +268,17 should have been +268,16.
> 
> Have you manually edited this patch before sending? If so, please don't
> do that, it makes people waste a lot of time figuring out what is wrong.
> 
> Also, please include a base-id in the cover letter so one knows what it
> applies to.

Just out of curiosity, I know one can generate cover letter from branch 
description with git branch --edit-description and git format-patch 
--cover-from-description= , but is there something to automatically fill 
in the merge base (I assume that's what you want) ?

Or are you looking for git send-email --subject-prefix="net-next,PATCH" 
to fill in the net/net-next subject prefix ?

