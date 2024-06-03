Return-Path: <netdev+bounces-100246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A78D850C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B15C1F2187D
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3198A134410;
	Mon,  3 Jun 2024 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="EFtn/JfO"
X-Original-To: netdev@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCB61311A7
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425017; cv=none; b=RbPCmYPaDJw28j9mQHUii8V8kddm7ehE0RdLzobgkINtVGn36ctBPCt1WITwWrbvfZE8KhgYdYPgiMChs44KBlWT+JU537b79oeqc8iP2Q8VwZWvF8cnnqSUnlOwihwZbOKodzYM5eIaDe98jNcAn+EiIVDEwDBeqGnGHK+xAU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425017; c=relaxed/simple;
	bh=RIFC2dLClnA5GSHx4hCgUcQeo7MGnIwwf6LZNjvHqVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LadmCcwJqabyraXSHMFDQ1VeA5j+pPrSXO5lBrJuSpimZdOCvnela7idwcC7xJW54pzxVV+4yzC34JoMsWhpi4YptW7YcaQlZ36ctQjyZb9Z9S3oAw9WifKy0Z0ovvcLaUcsmHec6MFPogNAfvw3zvkTI32cksQKoWNvKlPN0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=EFtn/JfO; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CF707882AF;
	Mon,  3 Jun 2024 16:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717425013;
	bh=lqnIEjB6gWuRJxieyOxq6KGZD2sIbDGcg8/jyWxGVSc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EFtn/JfOq8gVGoTUIGT88zgMKJdOYAup8klZKLrB82doMp1py1obVTTJXe2BpUIeR
	 AYFek3j5tCkT+4z3pQvHFLUYGWyhxA2DQan2T0pJ6qZXTsViQTAhbbsPdSqxYurwji
	 iSfQw3kDOl3zvzebhv94FFhZH5eyWlLFDEJgK6Wf8rd5h8YTRfajSDge1NrP+4NhQS
	 5vB94HQM2L/nrbp3bR19CKsKLqtlyH6KRqfVLi2jY346dyMALK3YKHtuPN0/k5SZI0
	 JYQwymvNc1ey+iOlJGZRnYCZe7X8lfcnWzm0wlQPizRWF+tPykwetTGTwi9TG8YSXq
	 8rVtZxnRK1UAQ==
Message-ID: <d1aac0b0-c985-40c2-8a6f-29a4617edaf8@denx.de>
Date: Mon, 3 Jun 2024 16:26:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32: Separate out
 external clock rate validation
To: Sai Krishna Gajula <saikrishnag@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christophe Roullier <christophe.roullier@foss.st.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>
References: <20240427215113.57548-1-marex@denx.de>
 <BY3PR18MB4707314AE781472140361D62A01B2@BY3PR18MB4707.namprd18.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <BY3PR18MB4707314AE781472140361D62A01B2@BY3PR18MB4707.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 4/29/24 9:19 AM, Sai Krishna Gajula wrote:
> 
>> -----Original Message-----
>> From: Marek Vasut <marex@denx.de>
>> Sent: Sunday, April 28, 2024 3:21 AM
>> To: netdev@vger.kernel.org
>> Cc: Marek Vasut <marex@denx.de>; David S. Miller <davem@davemloft.net>;
>> Alexandre Torgue <alexandre.torgue@foss.st.com>; Christophe Roullier
>> <christophe.roullier@foss.st.com>; Eric Dumazet <edumazet@google.com>;
>> Jakub Kicinski <kuba@kernel.org>; Jose Abreu <joabreu@synopsys.com>;
>> Maxime Coquelin <mcoquelin.stm32@gmail.com>; Paolo Abeni
>> <pabeni@redhat.com>; linux-arm-kernel@lists.infradead.org; linux-
>> stm32@st-md-mailman.stormreply.com
>> Subject: [net-next,RFC,PATCH 1/5] net: stmmac: dwmac-stm32:
>> Separate out external clock rate validation
>>
>> Pull the external clock frequency validation into a separate function, to avoid
>> conflating it with external clock DT property decoding and clock mux register
>> configuration. This should make the code easier to read and understand.
>>
>> This does change the code behavior slightly. The clock mux PMCR register
>> setting now depends solely on the DT properties which configure the clock
>> mux between external clock and internal RCC generated clock. The mux
>> PMCR register settings no longer depend on the supplied clock frequency, that
>> supplied clock frequency is now only validated, and if the clock frequency is
>> invalid for a mode, it is rejected.
>>
>> Previously, the code would switch the PMCR register clock mux to internal RCC
>> generated clock if external clock couldn't provide suitable frequency, without
>> checking whether the RCC generated clock frequency is correct. Such behavior
>> is risky at best, user should have configured their clock correctly in the first
>> place, so this behavior is removed here.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> ---
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
>> Cc: Christophe Roullier <christophe.roullier@foss.st.com>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Jose Abreu <joabreu@synopsys.com>
>> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-stm32@st-md-mailman.stormreply.com
>> Cc: netdev@vger.kernel.org
>> ---
>>   .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 54 +++++++++++++++----
>>   1 file changed, 44 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> index c92dfc4ecf570..43340a5573c64 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
>> @@ -157,25 +157,57 @@ static int stm32_dwmac_init(struct
>> plat_stmmacenet_data *plat_dat, bool resume)
>>   	return stm32_dwmac_clk_enable(dwmac, resume);  }
>>
>> +static int stm32mp1_validate_ethck_rate(struct plat_stmmacenet_data
>> +*plat_dat) {
>> +	struct stm32_dwmac *dwmac = plat_dat->bsp_priv;
>> +	const u32 clk_rate = clk_get_rate(dwmac->clk_eth_ck);
> 
> Please check reverse x-mass tree is followed for these variables, if possible.
> 
>> +
>> +	switch (plat_dat->mac_interface) {
>> +	case PHY_INTERFACE_MODE_MII:
>> +		if (clk_rate == ETH_CK_F_25M)
>> +			return 0;
>> +		break;
>> +	case PHY_INTERFACE_MODE_GMII:
>> +		if (clk_rate == ETH_CK_F_25M)
>> +			return 0;
>> +		break;
> 
> Please check, whether we can combine the two cases..

I hope those would be addressed in v4 of:

[PATCH v3 02/11] net: stmmac: dwmac-stm32: Separate out external clock 
rate validation

Thanks !

