Return-Path: <netdev+bounces-101964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D93900CA7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 21:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B3D1C21A88
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 19:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAF214D446;
	Fri,  7 Jun 2024 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="ZIBnH1r7"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6203D50263;
	Fri,  7 Jun 2024 19:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790169; cv=none; b=FPz6cEvfFvVj2ldWUTxVkQ/DVXVSWpiAEZGBTw4nAdwYNykQT/BttKZhkAiFzXR1r7X5LogAUuJSOrOpVLSQXok+FowOd4pGp+i8wYR/pQvBcSq6XeHsDycOV/CdmMYgWx5ABaECj2zcq+j4x6UbaW4FtwgwACHF2vfYlvb168A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790169; c=relaxed/simple;
	bh=/Q1flr7dswNeFYnTGX4Jad+BBlVofWzXVfjrUHO+k9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VKIumdELzPOVYpBQox4f0hYzVFXpQpPP3Hsbvwudj+UULkIffCM7YBPnJ0zm6YDtT6tFQ4qwrH9nsSlWTH4qfIfvaCSYxf0YigkkDY32UCfF1slDQ5OUZVgkZGs5JtLG4H6Obwy8FqZI2O/RSHrQOE7X17pLSnObpoqebOfAJWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=ZIBnH1r7; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id C4C2A88495;
	Fri,  7 Jun 2024 21:56:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717790165;
	bh=fcZUQQypZFORhc7qwo/JAaFB/BTgCpG8ND7fMIEShJ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZIBnH1r7UGj/1c2aR6Ncyb7LZofhdrqOjYfLniiVescmnvmglFwIS7p/f2d+D/HFd
	 Czqdd3YaX9quFL3YM0z7/PQL+TIYC16wgR8H6Ykyvnh/OCRkW0Oj+wA4ADrxhTwIO+
	 4HivpYevvRLxlffePldFv0VTazeQeUftkazfs0UO9s7M2z2wACBuHcMXkF3CZa79aD
	 Mbek8ciDILkweF+jGqeqUq1yUlVSxI9649daiKtmzNSA61d9GE+X++5Ye5XdPiTZOO
	 Wu4Fnrdk+wVuEu2Zu3L7N7ZvFQrM214cc9UrhTZAJAFePsmpGCO/oO4xGx77UEnQlc
	 qlRqjxRJuU+zg==
Message-ID: <329fb476-405e-458e-98a8-883ecd9cf15a@denx.de>
Date: Fri, 7 Jun 2024 21:54:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] net: stmmac: dwmac-stm32: add management of
 stm32mp13 for stm32
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
References: <20240607095754.265105-1-christophe.roullier@foss.st.com>
 <20240607095754.265105-9-christophe.roullier@foss.st.com>
 <6f44537a-3d60-46f5-a159-919cc2a144ec@denx.de>
 <c3e21cbf-bf9e-45d5-b6eb-f1f4d50e39a3@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <c3e21cbf-bf9e-45d5-b6eb-f1f4d50e39a3@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/7/24 2:59 PM, Christophe ROULLIER wrote:
> 
> On 6/7/24 14:48, Marek Vasut wrote:
>> On 6/7/24 11:57 AM, Christophe Roullier wrote:
>>
>> [...]
>>
>>> @@ -224,11 +225,18 @@ static int stm32mp1_configure_pmcr(struct 
>>> plat_stmmacenet_data *plat_dat)
>>>   {
>>>       struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>>>       u32 reg = dwmac->mode_reg;
>>> -    int val;
>>> +    int val = 0;
>>
>> Is the initialization really needed ? It seems the switch-case below 
>> does always initialize $val .
> 
> Yes it is needed otherwise:
> 
>>> drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c:239:4: warning: 
>>> variable 'val' is uninitialized when used here [-Wuninitialized]
> 
> val |= SYSCFG_PMCR_ETH_SEL_MII;
>                             ^~~
>     drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c:228:9: note: 
> initialize the variable 'val' to silence this warning
>             int val;

OK, thanks for checking.

