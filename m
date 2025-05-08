Return-Path: <netdev+bounces-189039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87508AAFFE8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334BC3AE6E2
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102DD27C877;
	Thu,  8 May 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ATwY6ABM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89A127AC47;
	Thu,  8 May 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720402; cv=none; b=kwODx6550o+AoqadTZycxs9MYexyJ6Ov4BhEbfUmnUmvbEgDOlgVdwffBVbcH6QVXYXwEx9vkQBldcnJ1g7nUsXuWyBtbdji8uXAsxFDHr3h2Eel0u0K5CMhKBxKjed53Uff4S6Ie60Gb3sTghHtqb7k1jg8BnchRSO9G+iLqdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720402; c=relaxed/simple;
	bh=ZXF39FFw9bSaoaPc3UbH1V0LnHSE+53rFY6xbOMm1J8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hnI6xyUSom4D70YzdnXbgVurcvYzVLVDq2ag3xhxIdaoaUXLxmRANi4vJaFMYFlitQdborq2oGFettSJSbD4sEAaj64apsiwjMEsqMvoDBT+lMK23rZ/fdsWCJbEW6SiWuTGqL1VYC1RSkhJMOUas90o6DjKjsKANB4Tm6T7mMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ATwY6ABM; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id D3kUuhiTn5oOhD3kUuQpGk; Thu, 08 May 2025 18:05:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746720329;
	bh=i3Zcprdv1SvQj0eiycKQXI51YCMEuANQ9KWCXytXxLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=ATwY6ABMjL9h2bymt7e78pl9aKcyh+EW5/LzWCMpLnKdY3A2MnCK2IfN54Cblz188
	 frUSBSmFo3Mlo+ZWoWEk6Gk6woIflGmSyUb+BEg9JuLGXjzvWEzbQnuhtX9xd8xDN3
	 1HcGPT8iZJNsZH964+0wBxoS09nQ7HOhHtgS4XMixHUiF8qDVtN16RE8zjFEUeMmve
	 l9oD4xuiMRY97u+tI1uWtlIPxAgUeGkX1KFYAfUQmJNZp/7IAeCnt6EPJpwUU34YfO
	 /xiXGagHB/5+fIGOLgaCdeSONbXd0FhUslqS+faTY2gQ/df8VyzjbAtPlQZ4qoOPXS
	 1G/utI/oMG2Kg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 08 May 2025 18:05:29 +0200
X-ME-IP: 90.11.132.44
Message-ID: <68149c51-ba75-4f0f-a86a-bd810d47d684@wanadoo.fr>
Date: Thu, 8 May 2025 18:05:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] net: airoha: Fix an error handling path in
 airoha_alloc_gdm_port()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
 <aBzOaiU6Ac3ZTU-4@lore-desk>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aBzOaiU6Ac3ZTU-4@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/05/2025 à 17:31, Lorenzo Bianconi a écrit :
>> If register_netdev() fails, the error handling path of the probe will not
>> free the memory allocated by the previous airoha_metadata_dst_alloc() call
>> because port->dev->reg_state will not be NETREG_REGISTERED.
>>
>> So, an explicit airoha_metadata_dst_free() call is needed in this case to
>> avoid a memory leak.
>>
>> Fixes: af3cf757d5c9 ("net: airoha: Move DSA tag in DMA descriptor")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Changes in v2:
>>    - New patch
>>
>> Compile tested only.
>> ---
>>   drivers/net/ethernet/airoha/airoha_eth.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>> index 16c7896f931f..af8c4015938c 100644
>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>> @@ -2873,7 +2873,15 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
>>   	if (err)
>>   		return err;
>>   
>> -	return register_netdev(dev);
>> +	err = register_netdev(dev);
>> +	if (err)
>> +		goto free_metadata_dst;
>> +
>> +	return 0;
>> +
>> +free_metadata_dst:
>> +	airoha_metadata_dst_free(port);
>> +	return err;
>>   }
>>   
>>   static int airoha_probe(struct platform_device *pdev)
>> -- 
>> 2.49.0
>>
> 
> I have not tested it but I think the right fix here would be something like:
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index b1ca8322d4eb..33f8926bba25 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2996,10 +2996,12 @@ static int airoha_probe(struct platform_device *pdev)
>   	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
>   		struct airoha_gdm_port *port = eth->ports[i];
>   
> -		if (port && port->dev->reg_state == NETREG_REGISTERED) {
> +		if (!port)
> +			continue;

I think it works.

We can still have port non NULL and airoha_metadata_dst_alloc() which 
fails, but airoha_metadata_dst_free() seems to handle it correctly.

CJ


> +
> +		if (port->dev->reg_state == NETREG_REGISTERED)
>   			unregister_netdev(port->dev);
> -			airoha_metadata_dst_free(port);
> -		}
> +		airoha_metadata_dst_free(port);
>   	}
>   	free_netdev(eth->napi_dev);
>   	platform_set_drvdata(pdev, NULL);
> 
> Regards,
> Lorenzo


