Return-Path: <netdev+bounces-123032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEE29637F9
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 03:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33A81F233CF
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4954383AB;
	Thu, 29 Aug 2024 01:48:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF278814;
	Thu, 29 Aug 2024 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724896082; cv=none; b=bHMPbxqpB2bpj/kS266llMc0GZzV6gGJulzZY9/9K/+tNeDE3ZAOIeBYRIVpqtT86yr8JXP4w/xecTdqpM9rg5LYYhWxu+Zke30orxdN3FjtwkLu2+BaFzOmeMKYzjFWiPltnp6GUu4uIKAEvy/mJo/vaUlUNMg34MEpSm/0y30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724896082; c=relaxed/simple;
	bh=65uLomZEV8871d1GCTHmy9S9rvjIdMtAIZRCgEbyMlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pjUyUP4Tq65H0CH7pxy1nQkoEnDoSY+MTkUN0RCt2zhzI0evHY2EWj2ynMdMt1M0vIDL8Yg5nCCzQNZ48RJmyDEZJ8PjebzzsL6Hs9Rjdy4+iGxVMiUjjrMVynpnYaK483hGRn0KTpEb4E86kD4vNpYpgiBphlQV6WuZhxzDnVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WvPJ01sthzfbTG;
	Thu, 29 Aug 2024 09:45:52 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 746B61800D2;
	Thu, 29 Aug 2024 09:47:56 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 Aug 2024 09:47:56 +0800
Message-ID: <1bf791fc-0990-4f7a-9879-f0677bc1628f@huawei.com>
Date: Thu, 29 Aug 2024 09:47:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: ipa: make use of dev_err_cast_probe()
To: Alex Elder <elder@ieee.org>, Simon Horman <horms@kernel.org>, Yuesong Li
	<liyuesong@vivo.com>
CC: <elder@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
References: <20240828160728.GR1368797@kernel.org>
 <5622e611-ce5d-4d0b-852f-759616f9452c@ieee.org>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <5622e611-ce5d-4d0b-852f-759616f9452c@ieee.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/29 9:27, Alex Elder wrote:
> On 8/28/24 11:07 AM, Simon Horman wrote:
>> On Wed, Aug 28, 2024 at 04:41:15PM +0800, Yuesong Li wrote:
>>> Using dev_err_cast_probe() to simplify the code.
>>>
>>> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
>>> ---
>>>   drivers/net/ipa/ipa_power.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
>>> index 65fd14da0f86..248bcc0b661e 100644
>>> --- a/drivers/net/ipa/ipa_power.c
>>> +++ b/drivers/net/ipa/ipa_power.c
>>> @@ -243,9 +243,8 @@ ipa_power_init(struct device *dev, const struct 
>>> ipa_power_data *data)
>>>       clk = clk_get(dev, "core");
>>>       if (IS_ERR(clk)) {
>>> -        dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
>>> -
>>> -        return ERR_CAST(clk);
>>> +        return dev_err_cast_probe(dev, clk,
>>> +                "error getting core clock\n");
>>>       }
>>>       ret = clk_set_rate(clk, data->core_clock_rate);
>>
>> Hi,
>>
>> There are lot of clean-up patches floating around at this time.
>> And I'm unsure if you are both on the same team or not, but in
>> any case it would be nice if there was some co-ordination.
>> Because here we have two different versions of the same patch.
>> Which, from a maintainer and reviewer pov is awkward.
I apologize for causing confusion, and I will strive to submit patches 
that are truly valuable in the future.

Thanks,
Hongbo

> 
> I just noticed this (looking at the patch from Hongbo Li).
> 
>> In principle the change(s) look(s) fine to me. But there are some minor
>> problems.
>>
>> 1. For the patch above, it should be explicitly targeted at net-next.
>>     (Or net if it was a bug fix, which it is not.)
>>
>>     Not a huge problem, as this is the default. But please keep this 
>> in mind
>>     for future posts.
>>
>>     Subject: [PATCH vX net-next]: ...
>>
>> 2. For the patch above, the {} should be dropped, as in the patch below.
> 
> Agreed.
> 
>> 3. For both patches. The dev_err_cast_probe should be line wrapped,
>>     and the indentation should align with the opening (.
>>
>>         return dev_err_cast_probe(dev, clk,
>>                       "error getting core clock\n");
>>
>> I'd like to ask you to please negotiate amongst yourselves and
>> post _just one_ v2 which addresses the minor problems highlighted above.
> 
> Thank you Simon, you are correct and I appreciate your proposed
> solution.  I'll await a followup patch (perhaps jointly signed
> off?)
> 
>                      -Alex
> 
>> Thanks!
>>
>> On Wed, Aug 28, 2024 at 08:15:51PM +0800, Hongbo Li wrote:
>>> Using dev_err_cast_probe() to simplify the code.
>>>
>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>> ---
>>>   drivers/net/ipa/ipa_power.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
>>> index 65fd14da0f86..c572da9e9bc4 100644
>>> --- a/drivers/net/ipa/ipa_power.c
>>> +++ b/drivers/net/ipa/ipa_power.c
>>> @@ -242,11 +242,8 @@ ipa_power_init(struct device *dev, const struct 
>>> ipa_power_data *data)
>>>       int ret;
>>>       clk = clk_get(dev, "core");
>>> -    if (IS_ERR(clk)) {
>>> -        dev_err_probe(dev, PTR_ERR(clk), "error getting core clock\n");
>>> -
>>> -        return ERR_CAST(clk);
>>> -    }
>>> +    if (IS_ERR(clk))
>>> +        return dev_err_cast_probe(dev, clk, "error getting core 
>>> clock\n");
>>>       ret = clk_set_rate(clk, data->core_clock_rate);
>>>       if (ret) {
>>
> 
> 

