Return-Path: <netdev+bounces-115284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE03945BB7
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 488331F2286E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C99014D2B9;
	Fri,  2 Aug 2024 10:02:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A353FE4A;
	Fri,  2 Aug 2024 10:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592961; cv=none; b=jM6IT/f+gl2hJzFyTrty9nY9HNr5KetEdt5pUSt290iQ7mTVORv38i6HjwFQhKVF3GkqHTzROtzlOW37U4JB+BEbAU7X2Y4maAXDNQNTacVGkKAj9X3aWsIGcc8QSlDim+FlDwCqJWHjXE7DGrH+OqxyB+lqllfkowYZzcajJag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592961; c=relaxed/simple;
	bh=6fuHU3zKyucjPRppY7ryeQ8xR45IfbyE+zsi6YIETwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mxohcZIIgwF29/bsRecAW43w7m1SpbPBThNghTkL9TUDKtZhGAjdBZV/pGYjtu625qTJAQKww+s3wdf06TZMrkDJzD8lF9WBfX9wtJyOkVFN+Lj6rxpjEVr3x4tqp2PnOujsZRFocD8rxnuxxSFpVnMSfTPBWq6uHTEpRt/0xfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Wb1YS6lzPzfZ8C;
	Fri,  2 Aug 2024 18:00:44 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 6560418005F;
	Fri,  2 Aug 2024 18:02:36 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 2 Aug 2024 18:02:36 +0800
Message-ID: <c9cc66e0-195a-4db4-98b8-cdbb986e0619@huawei.com>
Date: Fri, 2 Aug 2024 18:02:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 01/14] mm: page_frag: add a test module for
 page_frag
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-2-linyunsheng@huawei.com>
 <CAKgT0Udj5Jskjvvba345DFkySuZeg927OHQya0rCcynMtmGg8g@mail.gmail.com>
 <03c555c5-a25d-434a-aed4-0f2f7aa65adf@huawei.com>
 <CAKgT0UfXn3By_oSmNKw28biUf_ixXHMgGW_0h_3TZFAoECfPjg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UfXn3By_oSmNKw28biUf_ixXHMgGW_0h_3TZFAoECfPjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/1 22:50, Alexander Duyck wrote:

>>
>> The above was my initial thinking too, I went to the ptrpool thing using
>> at least two CPUs as the below reason:
>> 1. Test the concurrent calling between allocing and freeing more throughly,
>>    for example, page->_refcount concurrent handling, cache draining and
>>    cache reusing code path will be tested more throughly.
>> 2. Test the performance impact of cache bouncing between different CPUs.
>>
>> I am not sure if there is a more lightweight implementation than ptrpool
>> to do the above testing more throughly.
> 
> You can still do that with a single producer single consumer ring
> buffer/array and not have to introduce a ton of extra overhead for
> some push/pop approach. There are a number of different
> implementations for such things throughout the kernel.

if we limit that to single producer single consumer, it seems we can
use ptr_ring to replace ptrpool.

> 
>>
>>>
>>> Lastly something that is a module only tester that always fails to
>>> probe doesn't sound like it really makes sense as a standard kernel
>>
>> I had the same feeling as you, but when doing testing, it seems
>> convenient enough to do a 'insmod xxx.ko' for testing without a
>> 'rmmod xxx.ko'
> 
> It means this isn't a viable module though. If it supports insmod to
> trigger your tests you should let it succeed, and then do a rmmod to
> remove it afterwards. Otherwise it is a test module and belongs in the
> selftest block.
> 
>>> module. I still think it would make more sense to move it to the
>>> selftests tree and just have it build there as a module instead of
>>
>> I failed to find one example of test kernel module that is in the
>> selftests tree yet. If it does make sense, please provide an example
>> here, and I am willing to follow the pattern if there is one.
> 
> You must not have been looking very hard. A quick grep for
> "module_init" in the selftest folder comes up with
> "tools/testing/selftests/bpf/bpf_testmod/" containing an example of a
> module built in the selftests folder.

After close look, it seems it will be treated as third party module when
adding a kernel module in tools/testing/selftests as there seems to be no
config for it in Kconfig file and can only be compiled as a module not as
built-in.

> 
>>> trying to force it into the mm tree. The example of dmapool_test makes
>>> sense as it could be run at early boot to run the test and then it
>>
>> I suppose you meant dmapool is built-in to the kernel and run at early
>> boot? I am not sure what is the point of built-in for dmapool, as it
>> only do one-time testing, and built-in for dmapool only waste some
>> memory when testing is done.
> 
> There are cases where one might want to test on a system w/o console
> access such as an embedded system, or in the case of an environment
> where people run without an initrd at all.

I think moving it to tools/testing/selftests may defeat the above purpose.

> 
>>> just goes quiet. This module won't load and will always just return
>>> -EAGAIN which doesn't sound like a valid kernel module to me.
>>
>> As above, it seems convenient enough to do a 'insmod xxx.ko' for testing
>> without a 'rmmod xxx.ko'.
> 
> It is, but it isn't. The problem is it creates a bunch of ugliness in

Yes, it seems a bit ugly, but it supports the below perf cmd, I really
would like to support the below case as it is very convenient.

perf stat -r 200 -- insmod ./page_frag_test.ko test_push_cpu=16 test_pop_cpu=17

> the build as you are a tristate that isn't a tristate as you are only
> building it if it is set to "m". There isn't anything like that
> currently in the mm tree.

After moving page_frag_test to selftest, it is only bulit as module, I guess
it is ok to return -EAGAIN?

