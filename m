Return-Path: <netdev+bounces-124371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DFE9691C8
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 05:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D9E1F239B3
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 03:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22461A2624;
	Tue,  3 Sep 2024 03:21:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99791A4E6B;
	Tue,  3 Sep 2024 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725333686; cv=none; b=HHv73TTx8NM/aUPoyy+T6fLMeWowdYsDmrkXGzYEEX2DP8Tp82b9qELX7v4WuCS17tUdanJggs4yxARFNbF9rj9y44zyjgO/IRfSrbI2ujiLdQDX9rWnzgv4VRqw+nsWWAhp2n1gmY2KbCRMe6hwAWR5dLQAENB0zA9hpZ/bBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725333686; c=relaxed/simple;
	bh=ntJPOe9QrzzPPbK8pisKeLudwfh6tjCh4wyUBXnkJXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ULetYg4vNN0aTzrxEhBP6VJmYgj4nM/q5bBDsmrWmJBrp+c0gV5N8OsTSin6lsA7g8a6jAHjp0tyEpGkkW/YbKOfkCqnTmAK5VjcCaWosNcwleSiFiIyJeFVEalBYKq8zYqgFihI9014jjKVIS6bg/JV92nTVGW9qz8dXIkGFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WyW8n1QCXzyQyx;
	Tue,  3 Sep 2024 11:20:25 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 26F551400D1;
	Tue,  3 Sep 2024 11:21:21 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Sep 2024 11:21:20 +0800
Message-ID: <19a47bf1-44cc-4c01-d515-36b5f982a4fe@huawei.com>
Date: Tue, 3 Sep 2024 11:21:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] eth: fbnic: Fix modpost undefined error
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <alexanderduyck@fb.com>, <kuba@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew@lunn.ch>,
	<kernel-team@meta.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240902131947.3088456-1-ruanjinjie@huawei.com>
 <20240902190620.GM23170@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240902190620.GM23170@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/3 3:06, Simon Horman wrote:
> On Mon, Sep 02, 2024 at 09:19:47PM +0800, Jinjie Ruan wrote:
>> When CONFIG_FBNIC=m, the following error occurs:
>>
>> 	ERROR: modpost: "priv_to_devlink" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "page_pool_create" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "devlink_info_serial_number_put" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "page_pool_alloc_pages" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "devlink_priv" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "page_pool_put_unrefed_page" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "devlink_unregister" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "devlink_alloc_ns" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "devlink_register" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>> 	ERROR: modpost: "devlink_free" [drivers/net/ethernet/meta/fbnic/fbnic.ko] undefined!
>>
>> The driver now uses functions exported from a helper module
>> but fails to link when the helper is disabled, select them to fix them
>>
>> Fixes: 546dd90be979 ("eth: fbnic: Add scaffolding for Meta's NIC driver")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Thanks,
> 
> I believe a patch for this problem is already present upstream.

Sorry, I compile the mainline kernel and find this problem, and not
notice it.

> 
> - 9a95b7a89dff ("eth: fbnic: select DEVLINK and PAGE_POOL")
>   https://git.kernel.org/netdev/net-next/c/9a95b7a89dff
> 

