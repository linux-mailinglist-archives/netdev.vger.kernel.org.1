Return-Path: <netdev+bounces-160216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1919A18DDD
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BED503A1A0F
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 08:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330471F7569;
	Wed, 22 Jan 2025 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pkJiL2VE"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8F1B6D09
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536027; cv=none; b=DhU388B4Df8F1A1m9nRIDb3xeH7gQTk+0eQV/c+GM6B9eM4egkqE2pwmIXwmH/WHSh60TGU0GjyXWhQzTX2YFxMR6TjIxb+i+4vOX0fpkoOEZV5I/GVa961RC7VNSKu4g34zrPQP7oF7Wb60EA9QCB9Ui+liq6goE58w2OXnfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536027; c=relaxed/simple;
	bh=iYRWkyrj9Yl0zSVqrL+4SLx+qrRtRF9ZIOYaH0wQ52U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpmKs5CrfcA0P7CaID5yM81ZFNRoVri5cVZiRMWpo4tv1thghatbiaXdidikLJHUH6nFBcfc/NLJ4Cfv3enyCh1WOhFu32kLCqoWxDY9aaPcNUnLW9bRFBA1y1OzB21dUHxC9jG0EyvgQrlp8PO/wGaA8qm6REHWRVAbI3ujgyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pkJiL2VE; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b77ce124-af98-40e3-84bb-b743cc6f5f92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737536022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPHh4o1lPQkilVrtbsin/eTCIIZYrxoGW244xwenI0c=;
	b=pkJiL2VEgFS1aN3VlxYEhXAS/JvVfYXAjPTqAETezFtvU28UEFy3gUtrOubsKcgri8BJO+
	XxMc9Gtxd2l3dfgpQ87OSFRPKnygNvfqkI/5OemLWNsBXkGvQ333yUhr4UkWaCg5HBtKQK
	hQTf7ywIcEw7RVGtyaPbxY+Onw06vAE=
Date: Wed, 22 Jan 2025 16:53:25 +0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <7073a4e9-2a6b-a3e9-769e-5069b0e9772c@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2025/1/22 09:31, Qunqin Zhao 写道:
>
> 在 2025/1/21 下午9:41, Yanteng Si 写道:
>>
>> 在 1/21/25 16:25, Qunqin Zhao 写道:
>>> Loongson's GMAC device takes nearly two seconds to complete DMA reset,
>>> however, the default waiting time for reset is 200 milliseconds
>> Is only GMAC like this?
> At present, this situation has only been found on GMAC.

>>> @@ -566,6 +578,7 @@ static int loongson_dwmac_probe(struct pci_dev 
>>> *pdev, const struct pci_device_id
>>>         plat->bsp_priv = ld;
>>>       plat->setup = loongson_dwmac_setup;
>>> +    plat->fix_soc_reset = loongson_fix_soc_reset;
>>
>> If only GMAC needs to be done this way, how about putting it inside 
>> the loongson_gmac_data()?
>
> Regardless of whether this situation occurs in other devices(like 
> gnet), this change will not have any impact on gnet, right?
>
Yeah，However, it is obvious that there is now a more suitable
place for it. In the Loongson driver, `loongson_gmac_data()`
and `loongson_default_data()` were designed from the beginning.
When GNET support was added later, `loongson_gnet_data()`
was designed. We once made great efforts to extract these codes
from the `probe()` . Are we going to go back to the past?

Of course, I'm not saying that I disagree with you fixing the
GMAC in the `probe()`. I just think it's a bad start. After that,
other people may also put similar code here, and eventually
it will make the `probe` a mess.

If you insist on doing this, please change the function name
to `loongson_gmac_fix_reset()`, just like `loongson_gnet_fix_speed`.


Thanks,
Yanteng

