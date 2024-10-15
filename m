Return-Path: <netdev+bounces-135612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91E99E6AE
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 13:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E22B262D1
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 11:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BB21EF089;
	Tue, 15 Oct 2024 11:43:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE019B3FF;
	Tue, 15 Oct 2024 11:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992632; cv=none; b=ipYScYaV2AFei2Oh3lfFj4tX3zdqRLYmo209HajYz4LO0IvYfbkuaUAwf9v/00eCaaIqDEMHaGXOYcJj2SVU0MK9JsbJTMHeTdaCX73g6jXKL5StgIn2VNBQBxPZ18jGDo8ZzTyLfWyXX9YYNp+e6YdVZjI9g2Oyk/TCsLd+XUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992632; c=relaxed/simple;
	bh=LyeO++gxMXeIsertvvHiY2szir0HJvoZmpgq+Y8HsUU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gfn1+Q4eLVzRzu6C8wL6Nh/HNjAi3HepgDNkhP1f3fqvwvIrOOfmMHQG/exnxbEW1Q13ud3wKF4TCHfCulVDEBSkq8O5spaHKCKrglQxCBcQNG1sqprDeysG0IaARSE4BiVH7jlDAwJFpp46ZM5zm/FuacMZ4IHjwY9onugRnwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XSXLK14nCz1ymk1;
	Tue, 15 Oct 2024 19:43:53 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 73FA41A0188;
	Tue, 15 Oct 2024 19:43:47 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 19:43:46 +0800
Message-ID: <9c6778b6-81f3-48da-930e-125d1442bc46@huawei.com>
Date: Tue, 15 Oct 2024 19:43:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>,
	<wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<sudongming1@huawei.com>, <xujunsheng@huawei.com>, <shiyongbang@huawei.com>,
	<libaihan@huawei.com>, <andrew@lunn.ch>, <jdamato@fastly.com>,
	<horms@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
	<christophe.jaillet@wanadoo.fr>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V12 net-next 10/10] net: hibmcge: Add maintainer for
 hibmcge
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>
References: <20241010142139.3805375-1-shaojijie@huawei.com>
 <20241010142139.3805375-11-shaojijie@huawei.com>
 <d1ead515-8ecb-4b43-8077-92229618aa43@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <d1ead515-8ecb-4b43-8077-92229618aa43@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/15 18:30, Paolo Abeni wrote:
> On 10/10/24 16:21, Jijie Shao wrote:
>> Add myself as the maintainer for the hibmcge ethernet driver.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>> ChangeLog:
>> v11 -> v12:
>>    - remove the W entry of hibmcge driver from MAINTAINERS, suggested 
>> by Jakub.
>>    v11: 
>> https://lore.kernel.org/all/20241008022358.863393-1-shaojijie@huawei.com/
>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1389704c7d8d..371d4dc4aafb 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10275,6 +10275,12 @@ S:    Maintained
>>   W:    http://www.hisilicon.com
>>   F:    drivers/net/ethernet/hisilicon/hns3/
>>   +HISILICON NETWORK HIBMCGE DRIVER
>> +M:    Jijie Shao <shaojijie@huawei.com>
>> +L:    netdev@vger.kernel.org
>> +S:    Maintained
>> +F:    drivers/net/ethernet/hisilicon/hibmcge/
>> +
>>   HISILICON NETWORK SUBSYSTEM DRIVER
>>   M:    Yisen Zhuang <yisen.zhuang@huawei.com>
>>   M:    Salil Mehta <salil.mehta@huawei.com>
>
> Unfortunately does not apply anymore. Please rebase, thanks.
>
> Paolo

Ok, I'll resend it.

Thanks，

Jijie Shao


