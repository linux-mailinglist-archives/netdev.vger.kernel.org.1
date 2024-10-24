Return-Path: <netdev+bounces-138528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B539AE005
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B03C1F23548
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 09:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548551B219E;
	Thu, 24 Oct 2024 09:01:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB323CB;
	Thu, 24 Oct 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760498; cv=none; b=jTFotaIA819Q3So53cP/aSsoVJWnTHnWAgAWf5onLhyyAiJurWvgDqroGd570zE9AlvgfxGtuoJD+smKAQL4ek5mNYK+HBFWGK6fjEeKXFGixI4+NMsTkX4Z629SiFmCbez56a9P+sqvUsB+NIwuObovhIjhiJabRbwgSq7HHFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760498; c=relaxed/simple;
	bh=86RwdYNnZhoVzz9f/soUGnWuGwDz+UOZt81K5y2tbd0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KIHFM6M4e6KRmRSI28Yvxhr1pNQl4gGNre+CqirRDYF2YKKZhG+kaCGV16+WWnhlz7hs9K7ojR1lYhTKZDjvxdP22XcJe2KPrz1/r2GAaaJ/UgMZ7SEWcCsVnI5i1CRsWJNekzr0TzTGjFiFRVXjgCKSNkjcSecVbYs+xnFhNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZ0Fq0BKVzdkS3;
	Thu, 24 Oct 2024 16:58:55 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C2A140135;
	Thu, 24 Oct 2024 17:01:25 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 17:01:24 +0800
Message-ID: <5a2786ab-1c7c-4641-a3f6-3c3722f2ac14@huawei.com>
Date: Thu, 24 Oct 2024 17:01:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <lanhao@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 2/9] net: hns3: add sync command to sync io-pgtable
To: Paolo Abeni <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <shenjian15@huawei.com>,
	<salil.mehta@huawei.com>
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-3-shaojijie@huawei.com>
 <214d37cc-96c0-4d47-bea0-3985e920d88c@redhat.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <214d37cc-96c0-4d47-bea0-3985e920d88c@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/24 16:36, Paolo Abeni wrote:
> On 10/18/24 12:10, Jijie Shao wrote:
>> From: Jian Shen <shenjian15@huawei.com>
>>
>> To avoid errors in pgtable prefectch, add a sync command to sync
>> io-pagtable.
>>
>> In the case of large traffic, the TX bounce buffer may be used up.
> It's unclear to me what do you mean for large traffic. Is that large
> packets instead?
>
> Skimming over the previous patch, it looks like the for the bugger H/W
> driver will use the bounce buffer for all packets with len < 64K. As
> this driver does not support big tcp, such condition means all packets.
>
> So its not clear to me the 'may' part - it looks like the critical path
> will always happen on the bugged H/W

Sorry, actually not, I mean with tools like iperf3, we can hit the speed limit.
In this case, many packets are sent within a short period of time.
Therefore, the TX bounce buffer may be used up.
In this case, mapping/unmapping is used for packets that cannot use the TX bounce buffer.

Thanks,
Jijie Shao

>
>> At this point, we go to mapping/unmapping on TX path again.
>> So we added the sync command in driver to avoid hardware issue.
> I thought the goal of the previous patch was to avoid such sync-up.
>
> So I don't understand why it's there.
>
> A more verbose explanation will help.
>
>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Also we need a fixes tag.
>
> Thanks,
>
> Paolo
>
>

