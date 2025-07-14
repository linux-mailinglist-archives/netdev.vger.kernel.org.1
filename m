Return-Path: <netdev+bounces-206479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D47B0342B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 03:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8C51897B48
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 01:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00150156C40;
	Mon, 14 Jul 2025 01:32:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD1A2114;
	Mon, 14 Jul 2025 01:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752456752; cv=none; b=hyRBQfVMLNp6ggn7yRaL97MKl9lAoAHec/+ICPiFWAXO2MB1QZnf7690C0AY/dthltDuWNzcRY+QEPgR+ILl9ETqrKSs5wM7sm/TxU6p9Hoy35PgX96I+85rwanFsw7alFDA5S+8G82hwCPOFzcS0mJO1UblhaZadUj8tbVjzNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752456752; c=relaxed/simple;
	bh=J87hDMifmjUwUTFd7ku73pfQf31y4ATa5tbb4Vx1I2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lUe9aWlbixX+R+5+Rv8XTEfrAFyyK7/5NQlp24NTRt2mFcusuHKeBE9z9uajI926eQG3GLS0m4tjdHTefR3ZaJw6n++lH5787Ug8pJUuJp7PlwUhUMvYYW3/b2LEVYZddv8XDZjabP2m/1g7sQtyHC7PaaSi6TQrhASWs+xkmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bgPp74SkYzXf9P;
	Mon, 14 Jul 2025 09:27:59 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 81BAB1401F2;
	Mon, 14 Jul 2025 09:32:27 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 14 Jul 2025 09:32:26 +0800
Message-ID: <5e714038-3460-42b9-b003-616a394ee2b3@huawei.com>
Date: Mon, 14 Jul 2025 09:32:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv6: mcast: Remove unnecessary null check in
 mld_del_delrec()
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250712092811.2992283-1-yuehaibing@huawei.com>
 <CAAVpQUC-mV=SuNNhKbpy_1Mbh_sOs856+oNqDVJ4KcLjhDh2kw@mail.gmail.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <CAAVpQUC-mV=SuNNhKbpy_1Mbh_sOs856+oNqDVJ4KcLjhDh2kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/7/13 6:12, Kuniyuki Iwashima wrote:
> On Sat, Jul 12, 2025 at 2:06 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> These is no need to check null for pmc twice.
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  net/ipv6/mcast.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
>> index 6c875721d423..f3dae72aa9d3 100644
>> --- a/net/ipv6/mcast.c
>> +++ b/net/ipv6/mcast.c
>> @@ -794,9 +794,7 @@ static void mld_del_delrec(struct inet6_dev *idev, struct ifmcaddr6 *im)
> 
> Rather early return after the first loop if (!pmc) and
> remove 1 nest level below.

Thanks, will do in v2.
> 
> 
>>                         rcu_assign_pointer(pmc_prev->next, pmc->next);
>>                 else
>>                         rcu_assign_pointer(idev->mc_tomb, pmc->next);
>> -       }
>>
>> -       if (pmc) {
>>                 im->idev = pmc->idev;
>>                 if (im->mca_sfmode == MCAST_INCLUDE) {
>>                         tomb = rcu_replace_pointer(im->mca_tomb,
>> --
>> 2.34.1
>>
> 

