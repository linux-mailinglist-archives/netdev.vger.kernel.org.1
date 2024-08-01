Return-Path: <netdev+bounces-114925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07682944B19
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 14:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEBC51F23B00
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060D018A6B0;
	Thu,  1 Aug 2024 12:15:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552F216D9A8;
	Thu,  1 Aug 2024 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514549; cv=none; b=eyzIIUYLK+QHFi3YJ3j2ukMoB8r/aHotSwZrPznsWxT+CYUUCqJB+fwvAKzaVksvssDFGFre1mEltfSR1eto+ezdSGKSKI1t18qXLMe+GvopWY8clbgBJwJGxeC9bKURas3lwMxXdJMIxDzM9+TUmPOcjt2wuzIMdwlXtL2TCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514549; c=relaxed/simple;
	bh=O+BxKiCKiBGfIj52DaS1mJTMubjl9In0/BtaRzJnESo=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZcAvPtGq+JstlJVepMlDcPo266+p79dEVxK+fEfpZ8UAj6G1qgczDOAcurLhR/7gsfaWVbb3cL/pwmlwCX980+YLB+KOUw+77r1rKVJAdv+OZP+vLpQ9R1SCoAEJa4byyNtot2970GBgOg0gbhraSlrxGioEA2MGU2n0cWNMCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZSbR4pNCzxW90;
	Thu,  1 Aug 2024 20:15:31 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id A35FF14041B;
	Thu,  1 Aug 2024 20:15:44 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 20:15:43 +0800
Message-ID: <0fe6e62f-a6cf-4a9d-9ccc-004570c3c46e@huawei.com>
Date: Thu, 1 Aug 2024 20:15:43 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next 09/10] net: hibmcge: Add a Makefile and
 update Kconfig for hibmcge
To: Andrew Lunn <andrew@lunn.ch>
References: <20240731094245.1967834-1-shaojijie@huawei.com>
 <20240731094245.1967834-10-shaojijie@huawei.com>
 <49d41bc0-7a9e-4d2a-93c7-4e2bcb6d6987@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <49d41bc0-7a9e-4d2a-93c7-4e2bcb6d6987@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/1 9:13, Andrew Lunn wrote:
> On Wed, Jul 31, 2024 at 05:42:44PM +0800, Jijie Shao wrote:
>> Add a Makefile and update Kconfig to build hibmcge driver.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/Kconfig          | 17 ++++++++++++++++-
>>   drivers/net/ethernet/hisilicon/Makefile         |  1 +
>>   drivers/net/ethernet/hisilicon/hibmcge/Makefile | 10 ++++++++++
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/hisilicon/hibmcge/Makefile
>>
>> diff --git a/drivers/net/ethernet/hisilicon/Kconfig b/drivers/net/ethernet/hisilicon/Kconfig
>> index 3312e1d93c3b..372854d15481 100644
>> --- a/drivers/net/ethernet/hisilicon/Kconfig
>> +++ b/drivers/net/ethernet/hisilicon/Kconfig
>> @@ -7,7 +7,7 @@ config NET_VENDOR_HISILICON
>>   	bool "Hisilicon devices"
>>   	default y
>>   	depends on OF || ACPI
>> -	depends on ARM || ARM64 || COMPILE_TEST
>> +	depends on ARM || ARM64 || COMPILE_TEST || X86_64
> It is normal to have COMPILE_TEST last.

ok，

>
> Any reason this won't work on S390, PowerPC etc?

I have only compiled and tested on arm or x86.
I can't ensure that compile or work ok on other platforms.

>
>> +if ARM || ARM64 || COMPILE_TEST
>> +
> You would normally express this with a depends on.

Sorry, I can't understand how to convert if to depends on?

Thanks，

Jijie shao


