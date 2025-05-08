Return-Path: <netdev+bounces-189002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CBBAAFD0E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 435987B24BC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC03270575;
	Thu,  8 May 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ZrcfFu5n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3181270576;
	Thu,  8 May 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714620; cv=none; b=EYvtcxlxXPApIct6Mpm4wdXRVKnDUYWWfQeWOYEPcE/iDrVr98Pea2JdNpcHv2E7ALtMnl1vZ5UVkzUOycwFOf9M1a6TzAnBWAiwju2m+RX+R8eTjKzlk0WEiM5z3jutHHCrx0dfXFSSYqb9HL95LuGmiyq/ued74CqSebpvVcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714620; c=relaxed/simple;
	bh=XmK4L8D40BizidLQ++veBm5QIUu961oHkS9vLUJFiIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DkxxcqluaIB4W2cTv5tMpJ8gYBpQ2EbVsupZuBapy1hQV1Q60gWC/OgonrfUDIAGjbJPDDjWmoC9tlKyGrjc26YKNIHvp+W9s2iKuFyaDRZDQN6nobCAqWDqMt17TeEESIbJoayB203s6m8DCvh8yLFPa/b2c1j1E0OgaaZWakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ZrcfFu5n; arc=none smtp.client-ip=80.12.242.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id D2GEu1z1amoFgD2GEuuBtk; Thu, 08 May 2025 16:30:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746714609;
	bh=fpp/CpJ6xlI15L8sPW0Jp6SE3VDWw42deKh4JBWQdx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ZrcfFu5n7ZtmYSlFZkMdnsjEPhPDs77wpnjGP7l88XTgLs32YS81aR066EKU2zYhO
	 nhpTCjZVPyeBmfB4Dl7G8oJ6RswNwQ+6JzetDGryhhKJL3ZfXCPbwO0cnq/3WomdB/
	 oyZvnMRcojkxdYNtP7zxK14K6jzuGt0xT9Zbl9V59KcrHOmhwzmgs88l+1H2A2vShD
	 Pi5SYj0VROdx/jM4W2Q+vuG91v5tuNzutrWDAdwMSxV/C8UPvHWvNCx7UaQ9TMARAh
	 ar8NILkN5znUdVFQ0NG4bqQwzcMY++KF8muR1A7jxDYG/z3MnEJo7VlNwUn6BRONLF
	 0K8ggDkF+A5Dw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 08 May 2025 16:30:09 +0200
X-ME-IP: 90.11.132.44
Message-ID: <f7386884-cf6f-451a-aa39-6ce26ca22832@wanadoo.fr>
Date: Thu, 8 May 2025 16:30:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: airoha: Fix an error handling path in airoha_probe()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <f4a420f3a8b4a6fe72798f9774ec9aff2291522d.1744977434.git.christophe.jaillet@wanadoo.fr>
 <aAJFgqrOFL_xAqtW@lore-desk>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aAJFgqrOFL_xAqtW@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/04/2025 à 14:28, Lorenzo Bianconi a écrit :
>> If an error occurs after a successful airoha_hw_init() call,
>> airoha_ppe_deinit() needs to be called as already done in the remove
>> function.
>>
>> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested-only
>> ---
>>   drivers/net/ethernet/airoha/airoha_eth.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>> index 69e523dd4186..252b32ceb064 100644
>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>> @@ -2631,6 +2631,8 @@ static int airoha_probe(struct platform_device *pdev)
>>   		}
>>   	}
>>   	free_netdev(eth->napi_dev);
>> +
>> +	airoha_ppe_deinit(eth);
>>   	platform_set_drvdata(pdev, NULL);
>>   
>>   	return err;
>> -- 
>> 2.49.0
>>
> 
> Hi Christophe,
> 
> I agree we are missing a airoha_ppe_deinit() call in the probe error path,
> but we should move it above after stopping the NAPI since if airoha_hw_init()
> fails we will undo the work done by airoha_ppe_init(). Something like:

Agreed.

I'll send a v2 with as a small series, because of another leak I found 
while looking at it.

And while at it, I'll propose a few clean-ups.

CJ


> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 16c7896f931f..37d9678798d1 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2959,6 +2959,7 @@ static int airoha_probe(struct platform_device *pdev)
>   error_napi_stop:
>   	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
>   		airoha_qdma_stop_napi(&eth->qdma[i]);
> +	airoha_ppe_init(eth);
>   error_hw_cleanup:
>   	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
>   		airoha_hw_cleanup(&eth->qdma[i]);
> 
> 
> Agree?
> 
> Regards,
> Lorenzo


