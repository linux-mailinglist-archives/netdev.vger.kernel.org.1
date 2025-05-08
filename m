Return-Path: <netdev+bounces-189030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CA7AAFF3B
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82C0C7A5A32
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F4F27055B;
	Thu,  8 May 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="J8CnUdJw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA181223DC6;
	Thu,  8 May 2025 15:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718236; cv=none; b=FtUZcClhy40DljnTW0jso3/9bvR9KsMqoYtOu+Ng/+2uU8mI0UhotnMX61FfOUGkUo/AXv23QlCMwM1mRGZWZZ10OB/N+jPN+DkF9VuXUheDU7KR2DS5L2npxOKaWKI1Xg4XomxEXs1BByOxqbdPOaYXqc54O9UY8w1CKpULTSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718236; c=relaxed/simple;
	bh=OHuyuDzawYwtMUYkiddu3AdB4z1CVCUAKplQq5a1zUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eigmheckstDw02r+t4ZASevacibXHQ99KzR3haGy2ZjgNd+Way9p5plaW9Ef0xmXqCO9ldBQ+St/p8hJ7MYMImET3UkhkLBiVKc5GPLWSpjeLEBCH02uK1YT2XD6qpETXYt7nOCsnnnw0/xNDIL9RWIwexVCQ9/y7QPYByPp34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=J8CnUdJw; arc=none smtp.client-ip=80.12.242.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id D33cuMejiCaH2D33cu8B4q; Thu, 08 May 2025 17:21:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746717671;
	bh=/aqOR78xCKbgwFiDVPw/MgZTZLn+uIVqWHT4kXJ4tLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=J8CnUdJwFn5FHAXlFR8ZkPazq64kfzu6rxQfO3bp4oYWlJR9yw7QZga+jkcHw8Lj3
	 59DlKyXiWVDflM4F3pjSXbdRl8J3n4nmEYwk6cij3i9lBC2dXOv4jHAUS2x2ZLZ4At
	 J4p289z8w3uB1RTTguqgEIONbMC3RwaVIU9BF5f6yRT56eUo4yOpO14QaYnwU4YTkX
	 xPEanpuM6dKRpcweXAnz5a4iL6lmWQQtAowORrji8ha6QsrSzbCgwdJ3PXv+Nhbahj
	 xG+HeZ7o5pMxM3CKoEseHRZwwSATlEKc2RmRq3qwY1HcWszZvxZkLh8zuz9rMTfdU5
	 R0AYedfcV2qqQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 May 2025 17:21:11 +0200
X-ME-IP: 90.11.132.44
Message-ID: <23517507-bf1a-47fa-9a96-b27922e1e05f@wanadoo.fr>
Date: Thu, 8 May 2025 17:21:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] net: airoha: Fix an error handling path in
 airoha_probe()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
 <3791c95da3fa3c3bd2a942210e821d9301362128.1746715755.git.christophe.jaillet@wanadoo.fr>
 <aBzJZCIvE9u_IAM-@lore-desk>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aBzJZCIvE9u_IAM-@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 08/05/2025 à 17:10, Lorenzo Bianconi a écrit :
>> If an error occurs after a successful airoha_hw_init() call,
>> airoha_ppe_deinit() needs to be called as already done in the remove
>> function.
>>
>> Fixes: 00a7678310fe ("net: airoha: Introduce flowtable offload support")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Changes in v2:
>>    - Call airoha_ppe_init() at the right place in the error handling path
>>      of the probe   [Lorenzo Bianconi]
>>
>> Compile tested only.
>> ---
>>   drivers/net/ethernet/airoha/airoha_eth.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>> index af8c4015938c..d435179875df 100644
>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>> @@ -2967,6 +2967,7 @@ static int airoha_probe(struct platform_device *pdev)
>>   error_napi_stop:
>>   	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
>>   		airoha_qdma_stop_napi(&eth->qdma[i]);
>> +	airoha_ppe_init(eth);
> it was actually a typo in my previous email but this should be clearly
> airoha_ppe_deinit().

My bad!
Sorry for not spotting myself it.

We can really trust no one, nowadays ! :)

The good news is that my cocci script would have spotted it the next 
time I would have run it, because it would still find a 
airoha_ppe_deinit() in the remove function, but none in the probe.

I give you some time to review the other patches, and I'll a v3 later.

CJ

>
> Regards,
> Lorenzo
>
>>   error_hw_cleanup:
>>   	for (i = 0; i < ARRAY_SIZE(eth->qdma); i++)
>>   		airoha_hw_cleanup(&eth->qdma[i]);
>> -- 
>> 2.49.0
>>

