Return-Path: <netdev+bounces-101498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5EF8FF136
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95551F21FAE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDE198828;
	Thu,  6 Jun 2024 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="OJWfsYXr"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12393196C75;
	Thu,  6 Jun 2024 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688987; cv=none; b=pSa/n9lss9DQ05o8hHZNHENvdbqpYUYNovrBsMqoWkbrQBQXuXLy4kcg3/6O7W8uy5ja61tKUzbSTqs4aFN1DKphoT+RnGKtKUd8eHtDZo8g8DpaCMt2ltw/DHy9/JTDtKteqb5jIhUSDZIjtq/+GHQmXpZlAuu7JIQp2ja5428=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688987; c=relaxed/simple;
	bh=wAkkySakwtpXetpqy216hr8Mf/oM3hJIoPHEJd0ks+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdc8an+Al82DrdN/WQMjKoHSO11Qr+oeX6eR96vd5Kaxu50X6opHPyKoD4O8OhFoj2RjJC6aLrhENppFbreFOGk03hB79gix6J7WRnMWLisakpuGaKjN2E0KblFiGUR97fNlbttvriYHyrmS391cXY5+hrCiTb4L2g8UBfPzk7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=OJWfsYXr; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 7DB4187F5C;
	Thu,  6 Jun 2024 17:49:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717688984;
	bh=oZ6AjegqpphtNzQqTVjigVkYVuIdij5lsm+LsTd1UtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OJWfsYXrkT/xrqKKC8f0G7vpTqRVoG/3UxJo5NH1cdn0JC9Yt9dabTFrY4oPXk+W9
	 9WAFIGbDvbHPI6Ox8lgHVYwEnf1xv3jwzZYpXtslutOdUt7HNrKlXZWsCVuETRBJ/8
	 OjZ7JHCqWqSLXK3cXJaUkg/H9I7ECaLbr0y8usap/gU2Yk8HWgCel7gD5UPQhy5Jq+
	 aSRxUxkQgw4vP49wQ/ikXJJyrFeieaVg/yZ1NqhJwtcJ5e9PoHbXCtee6PPFiXhfr9
	 DTLsqYlSqWXaCBYawwS7t8z7izIKQTHpyWvaN8lNmjzd67mWPu3r/69eUI65g1/OQP
	 lvkC69ao7ueuQ==
Message-ID: <ee9a4da7-8b7a-4bd5-8a34-19e0e7cb49ff@denx.de>
Date: Thu, 6 Jun 2024 17:47:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/11] net: ethernet: stmmac: add management of
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
References: <20240604143502.154463-1-christophe.roullier@foss.st.com>
 <20240604143502.154463-8-christophe.roullier@foss.st.com>
 <3c40352b-ad69-4847-b665-e7b2df86a684@denx.de>
 <73f7b4a4-31d1-4907-b83b-2ac7758edf0d@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <73f7b4a4-31d1-4907-b83b-2ac7758edf0d@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 6/6/24 4:19 PM, Christophe ROULLIER wrote:

Hi,

>>> @@ -348,8 +360,15 @@ static int stm32_dwmac_parse_data(struct 
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
>>> +        pr_debug("Warning sysconfig register mask not set\n");
>>
>> I _think_ you need to left-shift the mode mask by 8 for STM32MP13xx 
>> second GMAC somewhere in here, right ?
>>
> The shift is performed in function stm32mp1_configure_pmcr:
> 
>      /* Shift value at correct ethernet MAC offset in SYSCFG_PMCSETR */
>      val <<= ffs(dwmac->mode_mask) - ffs(SYSCFG_MP1_ETH_MASK);
> 
> In case of MP13 Ethernet1 or MP15, shift equal 0
> 
> In case of MP13 Ethernet2 , shift equal 8  ;-)

Oh, good, thanks !

