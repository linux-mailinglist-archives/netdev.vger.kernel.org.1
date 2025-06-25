Return-Path: <netdev+bounces-200900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51507AE7477
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 03:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 011A07A68CB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5125189B8C;
	Wed, 25 Jun 2025 01:48:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3F156237;
	Wed, 25 Jun 2025 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816116; cv=none; b=dIhfMyYaWdn3XOyizG5m8Hoy2e5QeUzXzXFHXl9ep8g692F7rS4ZQeBz33+B7aTtOgf8cmUJ3BbKKlPTliDxMiY7TEHUfIieLA68hjB1AhIFoobNEVkixlrMcv2jKmOcnqSCuox13S4sTUtSfXIGB6hc5H998kmFkNDWn2ppjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816116; c=relaxed/simple;
	bh=UwOpnUw7+tLe3YXOCyQZJEC4QKByBoiiNnd+FyujE38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=e3S004scFMY6l5473gS541P3ifGHNlcBgKE1V5FS2reZBKhINUGI+fyvoWEGbqmS5gbJtnSPFsyhb99YMriZE67HYOQyCtdaVY/yo3fE0y66OiECMfN2O4rVnuCc9X9n1DNen95FAjEfiS1MIZanDVBPbz23/w1RQT1aJwHCibM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bRl7F6sjvztS42;
	Wed, 25 Jun 2025 09:47:21 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F932140545;
	Wed, 25 Jun 2025 09:48:31 +0800 (CST)
Received: from [10.174.179.113] (10.174.179.113) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 25 Jun 2025 09:48:30 +0800
Message-ID: <2b969f72-b5c3-4102-a7ea-77b5c726bc76@huawei.com>
Date: Wed, 25 Jun 2025 09:48:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: fib: Remove unnecessary encap_type check
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250624140315.3929702-1-yuehaibing@huawei.com>
 <CAAVpQUAEA6jkcM4VhzgYnx-dS1FEodN7y3DSK7LAh7Evt6bgjw@mail.gmail.com>
Content-Language: en-US
From: Yue Haibing <yuehaibing@huawei.com>
In-Reply-To: <CAAVpQUAEA6jkcM4VhzgYnx-dS1FEodN7y3DSK7LAh7Evt6bgjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/6/25 2:26, Kuniyuki Iwashima wrote:
> On Tue, Jun 24, 2025 at 6:46 AM Yue Haibing <yuehaibing@huawei.com> wrote:
>>
>> lwtunnel_build_state() has check validity of encap_type,
>> so no need to do this before call it.
>>
>> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
>> ---
>>  net/ipv4/fib_semantics.c | 8 --------
>>  1 file changed, 8 deletions(-)
>>
>> diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
>> index f7c9c6a9f53e..475ffcbf4927 100644
>> --- a/net/ipv4/fib_semantics.c
>> +++ b/net/ipv4/fib_semantics.c
>> @@ -625,11 +625,6 @@ int fib_nh_common_init(struct net *net, struct fib_nh_common *nhc,
>>         if (encap) {
>>                 struct lwtunnel_state *lwtstate;
>>
>> -               if (encap_type == LWTUNNEL_ENCAP_NONE) {
>> -                       NL_SET_ERR_MSG(extack, "LWT encap type not specified");
>> -                       err = -EINVAL;
>> -                       goto lwt_failure;
>> -               }
>>                 err = lwtunnel_build_state(net, encap_type, encap,
>>                                            nhc->nhc_family, cfg, &lwtstate,
>>                                            extack);
>> @@ -890,9 +885,6 @@ static int fib_encap_match(struct net *net, u16 encap_type,
>>         struct lwtunnel_state *lwtstate;
>>         int ret, result = 0;
>>
>> -       if (encap_type == LWTUNNEL_ENCAP_NONE)
>> -               return 0;
> 
> Now this condition returns -EINVAL, which confuses fib_encap_match(), no ?

Right, sorry for overlook this, will restore in v2.

> 
> 
>> -
>>         ret = lwtunnel_build_state(net, encap_type, encap, AF_INET,
>>                                    cfg, &lwtstate, extack);
>>         if (!ret) {
>> --
>> 2.34.1
>>
> 

