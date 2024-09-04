Return-Path: <netdev+bounces-124834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D429596B1C9
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 08:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1881F26A00
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 06:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A313BC11;
	Wed,  4 Sep 2024 06:33:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57ADF13AD13
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 06:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725431612; cv=none; b=AL82Km649CMss8L5eL8l6lKubcG9QbTWJit6Hj7uI1nIXR4J2wEFOSeZek56CdDCZ00icdl9O3IvSeeEDNq8Ax7aBkADsZ9l3CH3xs+ddLOaLIATQgSCngDozHKVVIH9ScPpzghULOmz0slNfDc6gFH7jadk02ApUpqmKe6wIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725431612; c=relaxed/simple;
	bh=RHMvkXT1VPoT7Ef+ACJJOFyxKdRggxjXDXqpIqxft9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=thYBWZJs8qnqNh/hO+FXuRnqK13djkFlpZg6Z+ek+qyXlZYb7kqYdlRxxv+yzRSAC5SXFHghiinrxYoYYQ+RG7uRQMk6eQEIt5ypcq/WHLYhmgHfhCabCyvirEN8BcI8oCxrw8Airg5Os99Sq9PsJDmhrGKetgNQxtJHWrgW3gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WzCMy2VqGz1BGv0;
	Wed,  4 Sep 2024 14:32:30 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F2EF1400CA;
	Wed,  4 Sep 2024 14:33:27 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 14:33:23 +0800
Message-ID: <5cfbde6c-0e6e-6c1f-c872-23fd00494b77@huawei.com>
Date: Wed, 4 Sep 2024 14:33:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next] net: lan743x: Use NSEC_PER_SEC macro
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>
References: <20240902071841.3519866-1-ruanjinjie@huawei.com>
 <aa679b67-6580-4426-9edb-d0f5365ae3e9@lunn.ch>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <aa679b67-6580-4426-9edb-d0f5365ae3e9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/3 0:26, Andrew Lunn wrote:
> On Mon, Sep 02, 2024 at 03:18:41PM +0800, Jinjie Ruan wrote:
>> 1000000000L is number of ns per second, use NSEC_PER_SEC macro to replace
>> it to make it more readable.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/net/ethernet/microchip/lan743x_ptp.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.c b/drivers/net/ethernet/microchip/lan743x_ptp.c
>> index dcea6652d56d..9c2ec293c163 100644
>> --- a/drivers/net/ethernet/microchip/lan743x_ptp.c
>> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.c
>> @@ -409,7 +409,7 @@ static int lan743x_ptpci_settime64(struct ptp_clock_info *ptpci,
>>  				   ts->tv_sec);
>>  			return -ERANGE;
>>  		}
>> -		if (ts->tv_nsec >= 1000000000L ||
>> +		if (ts->tv_nsec >= NSEC_PER_SEC ||
>>  		    ts->tv_nsec < 0) {
>>  			netif_warn(adapter, drv, adapter->netdev,
>>  				   "ts->tv_nsec out of range, %ld\n",
> 
> https://elixir.bootlin.com/linux/v6.10.7/source/include/linux/time64.h#L92
> 
> /*
>  * Returns true if the timespec64 is norm, false if denorm:
>  */
> static inline bool timespec64_valid(const struct timespec64 *ts)
> {
>         /* Dates before 1970 are bogus */
>         if (ts->tv_sec < 0)
>                 return false;
>         /* Can't have more nanoseconds then a second */
>         if ((unsigned long)ts->tv_nsec >= NSEC_PER_SEC)
>                 return false;
>         return true;
> }
> 
> And the next question is, why is the driver checking this? It would
> make more sense that the PTP core checked this before calling
> ptp->info->settime64()

There are 2 places call ptp->info->settime64(), it may make more sense
to check timespec64_valid() here and remove these check internal like
lan743x_ptp.c?

drivers/net/phy/micrel.c:4721:          ptp->settime64(ptp, &ts);
drivers/ptp/ptp_clock.c:103:    return  ptp->info->settime64(ptp->info, tp);

> 
> 	Andrew

