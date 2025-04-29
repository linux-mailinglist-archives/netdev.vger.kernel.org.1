Return-Path: <netdev+bounces-186859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A6EAA1C98
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 23:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 065637AB7D7
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32D267B6B;
	Tue, 29 Apr 2025 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="E9f552v1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB713AC1;
	Tue, 29 Apr 2025 21:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745960682; cv=none; b=W6N83ePIpIWUcUIzjhnK65lC/JzYdvm28vjymeXKXr/pqalAKHTw94SRwsaRchRwIZm4ww4OInuKjr94neAm1N4VPrQEscYxfqaVeK73lFpitnER3B8xssBujAS+twarciad4z/o5cf2sLW8dTqAoqaPz9caZF+W7kyM+4Wpjjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745960682; c=relaxed/simple;
	bh=9MN7EzPl8Ix41M3eTmAMrKzzZ19Zdur1bzdSLBkorjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oEJ3tlSO7AaguX4Huz3UrclCQtKTYsqhitU3uYh5SXzN1rfk4D+bjy+xRd3I3MsGji+mJJ5gpHWU3Q4y8FapUQz/8iCWuISWHuouOCsaDsNRirmksnPYfovTkVrogwC2JHbQLK7hawIWxM/okezn9Fmqpy7hiVTtKD5TSRKmtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=E9f552v1; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 9rzNumpcYN5mI9rzQuMyVC; Tue, 29 Apr 2025 22:55:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745960147;
	bh=NqrZP5JivyxldFmAi4UVOQoQCnpE7WmY52m/wQ8PrDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=E9f552v1eFs2M5RxbiunKLS2gnnjSGCo6hzrEh6jaPK03065K+1nT5dkBAszEdjKw
	 AI7xqWuvhsHem6Nx4H3rcjsJjPr4H96CMKKa4y457EgNOCUnZXzkrERuC1M4FRE3JW
	 dDRKGu7+CG3ebjSU4g+UPa7cel34II0iYK8xkp7mp7bzgahLXjhqrUIzQy5NEDaxHB
	 cvVaEyaeGmOV/NVfldXu6B0KHjLejiTB+i6UdaBwqg41vpfyHsVQAh/hCFnnDPcL9S
	 eS+6vHW+diXwf6syIkCNoKqXzhQh6lO4XWGs9GOGdq5JdkmQ9hZzvCyaPdVPhEzYsU
	 CVV4zdRpzrBFQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 29 Apr 2025 22:55:47 +0200
X-ME-IP: 90.11.132.44
Message-ID: <85758958-0e67-4492-a9e0-40f25c554e8c@wanadoo.fr>
Date: Tue, 29 Apr 2025 22:55:37 +0200
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
 <aAJFgqrOFL_xAqtW@lore-desk> <aBDglZH4VaBlWU2a@lore-desk>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aBDglZH4VaBlWU2a@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 29/04/2025 à 16:22, Lorenzo Bianconi a écrit :
>>> If an error occurs after a successful airoha_hw_init() call,
>>> airoha_ppe_deinit() needs to be called as already done in the remove
>>> function.
>>>
>>> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>> Compile tested-only
>>> ---
>>>   drivers/net/ethernet/airoha/airoha_eth.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>>> index 69e523dd4186..252b32ceb064 100644
>>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>>> @@ -2631,6 +2631,8 @@ static int airoha_probe(struct platform_device *pdev)
>>>   		}
>>>   	}
>>>   	free_netdev(eth->napi_dev);
>>> +
>>> +	airoha_ppe_deinit(eth);
>>>   	platform_set_drvdata(pdev, NULL);
>>>   
>>>   	return err;
>>> -- 
>>> 2.49.0
>>>
>>
>> Hi Christophe,
>>
>> I agree we are missing a airoha_ppe_deinit() call in the probe error path,
>> but we should move it above after stopping the NAPI since if airoha_hw_init()
>> fails we will undo the work done by airoha_ppe_init(). Something like:
>>
>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>> index 16c7896f931f..37d9678798d1 100644
>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>> @@ -2959,6 +2959,7 @@ static int airoha_probe(struct platform_device *pdev)
>>   error_napi_stop:
>>   	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
>>   		airoha_qdma_stop_napi(&eth->qdma[i]);
>> +	airoha_ppe_init(eth);
>>   error_hw_cleanup:
>>   	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
>>   		airoha_hw_cleanup(&eth->qdma[i]);
>>
> 
> Hi Christophe,
> 
> any plan to repost this fix?

Hi,

I'll send a v2, but I currently don't have time to look at it.
Will need a few more days.

CJ

> 
> Regards,
> Lorenzo
> 
>>
>> Agree?
>>
>> Regards,
>> Lorenzo
> 
> 


