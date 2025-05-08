Return-Path: <netdev+bounces-189037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA3AAFFD1
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB2E16F9C5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4150320ADE6;
	Thu,  8 May 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BWEKViV9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-69.smtpout.orange.fr [80.12.242.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A518DB01;
	Thu,  8 May 2025 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720093; cv=none; b=D470tNCy3SS+I+GNwlr32fvLPOBUFbwCiH7GmbDVarNgBLT5VpTcWoNgx/ps1dRhSkBKYYdR3hE2QVc7EhfI7KrDpPC9+QyhPur6dvJcM+qyuG/1UWK/CvaIzN2G1RQlL827C0NOhl2Ohvmx6aeBh8kFLF7bs9TO/HFruPYNZio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720093; c=relaxed/simple;
	bh=FoMJWdZ1VZoh+VgPlUDE0m+2XpvQAGKfgx71UtqClrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=camXouZYDMK11ZeUtK7ks8cHJRAVEF+gui+WFOeBlc3b10A8IWbFTg8ERDCWnzDLq8b0oqJjfkBrtoW+bn9oaVZAwBHXOr3A/NT18m0CbflrAH1oIwiUgnIzbAhKbGzQsOz0XVjYa6raqxB/PmHr2WKvocVGWqY99FnykI5Gk0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BWEKViV9; arc=none smtp.client-ip=80.12.242.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id D3fTuFhAsh9deD3fTuUC05; Thu, 08 May 2025 18:00:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1746720019;
	bh=VkGBMQgjeGBCArxNyqBLEp0bu3yaKzmfKDbWpDOIDV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BWEKViV9LpG1HaJR0L1DVXeLeQZazyjHC14DAaINZvMXNWG4ClO8+K7ZgNGHD6bx7
	 kO84ccrRyDSX6Y5vwBLgupmSSoAZx9QT0GyvgxQxL1JR7s0k6e2kiu/4uJujpB0f79
	 w43JX7RmvYk8GJ32Yzil07MPI4pHxG/KJ2aqFiqRGLSR1bj8uD8ZwNTrvEpl+yf+u/
	 /LGuBf7uWyvyxDOXT7g9qR8BOYIe9NufZ9J/3h/lFS3iFjPp3WbxWQr8/7WOxlKZ5B
	 uXmZMP9fusoaopK7pCI+GdS84hFTQJAOnPHU31hf79+b0l2dYZtBKeP32ugC/b+I7n
	 LrJFIySFD5WDQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Thu, 08 May 2025 18:00:19 +0200
X-ME-IP: 90.11.132.44
Message-ID: <aeab63d4-9740-4213-86c3-ca975762046e@wanadoo.fr>
Date: Thu, 8 May 2025 18:00:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] net: airoha: Use dev_err_probe()
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
References: <5c94b9b3850f7f29ed653e2205325620df28c3ff.1746715755.git.christophe.jaillet@wanadoo.fr>
 <1b67aa9ea0245325c3779d32dde46cdf5c232db9.1746715755.git.christophe.jaillet@wanadoo.fr>
 <aBzROQyQ_5oHmYr3@lore-desk>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <aBzROQyQ_5oHmYr3@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/05/2025 à 17:43, Lorenzo Bianconi a écrit :
> On May 08, Christophe JAILLET wrote:
>> Use dev_err_probe() to slightly simplify the code.
>> It is less verbose, more informational and makes error logging more
>> consistent in the probe.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Changes in v2:
>>    - New patch
>>
>> Compile tested only.
>> ---
>>   drivers/net/ethernet/airoha/airoha_eth.c | 21 +++++++++------------
>>   1 file changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
>> index 2335aa59b06f..7404ee894467 100644
>> --- a/drivers/net/ethernet/airoha/airoha_eth.c
>> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
>> @@ -2896,10 +2896,9 @@ static int airoha_probe(struct platform_device *pdev)
>>   	eth->dev = &pdev->dev;
>>   
>>   	err = dma_set_mask_and_coherent(eth->dev, DMA_BIT_MASK(32));
>> -	if (err) {
>> -		dev_err(eth->dev, "failed configuring DMA mask\n");
>> -		return err;
>> -	}
>> +	if (err)
>> +		return dev_err_probe(eth->dev, err,
>> +				     "failed configuring DMA mask\n");
> 
> Can dma_set_mask_and_coherent() return -EPROBE_DEFER? The other parts are fine.
> 
> Regards,
> Lorenzo
> 

No, it can't, but using dev_err_probe() does not hurt.

Using dev_err_probe():
   - saves 1 LoC
   - is consistent in the function
   - log the error code in a human readable format
   - generate smaller binaries (can easily be checked with size)

So, even if "unneeded", I think it is still a improvement.

CJ

