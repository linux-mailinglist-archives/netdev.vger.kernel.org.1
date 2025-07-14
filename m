Return-Path: <netdev+bounces-206478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29516B03418
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AED11894C6C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D5C15B971;
	Mon, 14 Jul 2025 01:06:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0971FC3;
	Mon, 14 Jul 2025 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752455162; cv=none; b=uNvs2W8RWXQUSZd2ieAsGmp0v04mBvNaGb4sKsPKC90AHdg2s9l5La17VxKsCj4IHULVoUdJoeBDN8oFQvwV1+QxfSjVde7bUuNYoHZdQegw3292h6YMSr0F2vEGKKjbWELniyKQjzg57nOUtDr530XoJY2RtVcKsbvL+zOsb8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752455162; c=relaxed/simple;
	bh=bJRJQ30ihyl+2uSUUGcMy1ghyKNWXsYlVJ4mGZwrp8k=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MuspcsX0Pqz4Cr9t/mFKgwgPPn1kLIEPkOKzES3V2rpR0YazF6bClh1dXzSGKyT5jcS0BGlB3kJDD7XPoDiIxNQaGZrcPN/GJdS9gLtRUXtyv8eVZiX4PjIuBsbqhDJsE6imQYUeaf9DvngP7yFHtZUW8yWbYXCfKfVqADZY2ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bgPFF44xCz2FbNt;
	Mon, 14 Jul 2025 09:02:57 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CDA7140277;
	Mon, 14 Jul 2025 09:04:58 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 09:04:57 +0800
Message-ID: <df1c269a-085a-47cc-83ef-294ea84b98a2@huawei.com>
Date: Mon, 14 Jul 2025 09:04:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<shenjian15@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <arnd@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 00/11] net: hns3: use seq_file for debugfs
To: Simon Horman <horms@kernel.org>
References: <20250711061725.225585-1-shaojijie@huawei.com>
 <20250712121920.GX721198@horms.kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250712121920.GX721198@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/12 20:19, Simon Horman wrote:
> On Fri, Jul 11, 2025 at 02:17:14PM +0800, Jijie Shao wrote:
>> Arnd reported that there are two build warning for on-stasck
>> buffer oversize. As Arnd's suggestion, using seq file way
>> to avoid the stack buffer or kmalloc buffer allocating.
>>
>> ---
>> ChangeLog:
>> v1 -> v2:
>>    - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
>>    - Remove unnecessary cast, suggested by Andrew Lunn
>>    v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
>> ---
>>
>> Jian Shen (5):
>>    net: hns3: clean up the build warning in debugfs by use seq file
>>    net: hns3: use seq_file for files in queue/ in debugfs
>>    net: hns3: use seq_file for files in tm/ in debugfs
>>    net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in
>>      debugfs
> Thanks for the update, but unfortunately I don't think this is enough.
>
> W=1 builds with bouth Clang 20.1.7 and GCC 15.1.0 warn that
> hns3_dbg_fops is unused with the patch (10/11) above applied.
>
>>    net: hns3: remove the unused code after using seq_file
> I suspect this patch (11/11) needs to be squashed into the previous one (10/11).
>
> ...

Yes, it looks like so...

However, in this case, the operation of patch10 is not singular.
It modified a debugfs file through a patch while also removing unused code frameworks.

In fact, this warning was cleared in patch 11...

...

I will merge patch 11 into patch 10 in v3.

Thanks,
Jijie Shao









