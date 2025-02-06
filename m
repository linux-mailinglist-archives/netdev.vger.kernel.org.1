Return-Path: <netdev+bounces-163409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5061EA2A34B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D0527A46E3
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 08:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FBE225796;
	Thu,  6 Feb 2025 08:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WKv5X9MI"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2453C22541D;
	Thu,  6 Feb 2025 08:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738831017; cv=none; b=L/t0qAMrCe64G2JJmr+xSDNQp7AcYwDpwaLE6K6JQRbx8/OiQFf/NCHxQAFYC0ZdrkrLwuPVhXgnRzBPk/CjSH1dVIyMB7tbD4jMqZl9cCeX0vCRWPGiA0F3v43JP10pJuF81tyEZD1ICwzx70DHnTqPXM8AQvsWwbruVQKNJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738831017; c=relaxed/simple;
	bh=jt8ujfaC69ia9GkYnhjdl7obavX9X7/hAPGeTpwe05E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oV31xGfsjCWI9H7HBcYchtVQX+DzmBS1uJAHechwqZWN21lcN85S6Z1N1nh4hF+1kAvqw0XphQAxO0fAbJGti7ebsybFFz4tUmkIPyOC6BiuMIn9pLCxiiKpjVxbJMcMUs+kDB4Xw8Z1zGS/aaZXb1X2FGiuXOmWYBZMOgvYodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WKv5X9MI; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d9901633-956d-48f2-8b10-d18a760cc5f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738831007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O0u7DtVaCKa1n9NpquVUnz53jEcq0GDnVDDM9No824o=;
	b=WKv5X9MIWoa7/iH3XGn5KcvmHnpEWI2BQrND0bJwAJa/aPZioiuviE8wzagJxwiwzgwY9E
	I2Z790Wvgi685juZ+sCufb/tV78TPkPbjpf798EKiPXxJT2qLgSuiZHOUXQ7IwScwgJbkq
	eRmzLQC4dEVciZ+IDRPpCJKmt96l5bc=
Date: Thu, 6 Feb 2025 16:36:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: stmmac: dwmac-loongson: Add fix_soc_reset function
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, chenhuacai@kernel.org,
 fancer.lancer@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250121082536.11752-1-zhaoqunqin@loongson.cn>
 <4787f868-a384-4753-8cfd-3027f5c88fd0@linux.dev>
 <7073a4e9-2a6b-a3e9-769e-5069b0e9772c@loongson.cn>
 <b77ce124-af98-40e3-84bb-b743cc6f5f92@linux.dev>
 <c5abbb5b-97f3-2b34-26db-06e0dc82be84@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <c5abbb5b-97f3-2b34-26db-06e0dc82be84@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/6/25 3:22 PM, Qunqin Zhao 写道:
>
> 在 2025/1/22 下午4:53, Yanteng Si 写道:
>>
>>
>>
>> 在 2025/1/22 09:31, Qunqin Zhao 写道:
>>>
>>> 在 2025/1/21 下午9:41, Yanteng Si 写道:
>>>>
>>>> 在 1/21/25 16:25, Qunqin Zhao 写道:
>>>>> Loongson's GMAC device takes nearly two seconds to complete DMA 
>>>>> reset,
>>>>> however, the default waiting time for reset is 200 milliseconds
>>>> Is only GMAC like this?
>>> At present, this situation has only been found on GMAC.
>>
>>>>> @@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev 
>>>>> *pdev, const struct pci_device_id
>>>>>         plat->bsp_priv = ld;
>>>>>       plat->setup = loongson_dwmac_setup;
>>>>> +    plat->fix_soc_reset = loongson_fix_soc_reset;
>>>>
>>>> If only GMAC needs to be done this way, how about putting it inside 
>>>> the loongson_gmac_data()?
>>>
>>> Regardless of whether this situation occurs in other devices(like 
>>> gnet), this change will not have any impact on gnet, right?
>>>
>> Yeah，However, it is obvious that there is now a more suitable
>> place for it. In the Loongson driver, `loongson_gmac_data()`
>> and `loongson_default_data()` were designed from the beginning.
>> When GNET support was added later, `loongson_gnet_data()`
>> was designed. We once made great efforts to extract these codes
>> from the `probe()` . Are we going to go back to the past?
>>
>> Of course, I'm not saying that I disagree with you fixing the
>> GMAC in the `probe()`. I just think it's a bad start. After that,
>> other people may also put similar code here, and eventually
>> it will make the `probe` a mess.
>>
>> If you insist on doing this, please change the function name
>> to `loongson_gmac_fix_reset()`, just like `loongson_gnet_fix_speed`.
>
> Recently, it is found that GNET may also have a long DMA reset time.  
> And the commit

It seems that you haven't tested all the gnet devices. Please test all

the devices before sending v2. Since I've left Loongson, I only have

the 7A2000(gnet) device at hand to assist with the testing.

>
> message should be "Loongson's DWMAC device may take nearly two seconds 
> to complete DMA reset,
> however, the default waiting time for reset is 200 milliseconds".

The function name can refer to loongson_dwmac_setup.

       plat->setup = loongson_dwmac_setup;

+    plat->fix_soc_reset = loongson_dwmac_fix_reset;


Oh, don't forget the necessary comments.


Thanks

Yanteng


