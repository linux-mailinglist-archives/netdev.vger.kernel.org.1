Return-Path: <netdev+bounces-114946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42D944C1B
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CCF1C25E6E
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BD01A38E9;
	Thu,  1 Aug 2024 12:58:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FBF1A71E1;
	Thu,  1 Aug 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517127; cv=none; b=XWs/FzamQCJFXPQ3Rk9M9/5D5gKSCzU7UBQaZIh6wXXXZ+7iUOyQBsqBQP3vYmd/9P4fCrOM+lgp13IWFD379bwdK0l+REsjEof2WW3TlPdFu3JU4cjQMoArVN1EQbjTgxLLKR7fareYH5KF3RFYCmfn+w/Lo9gsUmvGW3Hf0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517127; c=relaxed/simple;
	bh=gSmc0vpIM4s9a1iCGZSOkfBK2zTfoXZQKvrDXUHTtnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uBCz4+1opqCNhwLtMiH9Utk7ruOE1BkAy63TxuP8KRyZjSko7MLdUVjVNaUvpgHYhYDWu3zwlE9R5l1M436aqdtPgBHY9Gh+tYnhRsY78VVurYIWDJf3QiIjmtCeGDv3EXk9Us+aYWOvnKe5iGBVFhko7mXKmrIWZNkOtjE2McU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZTXw370TzxVws;
	Thu,  1 Aug 2024 20:58:24 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 75F81180AE6;
	Thu,  1 Aug 2024 20:58:37 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 1 Aug 2024 20:58:37 +0800
Message-ID: <03c555c5-a25d-434a-aed4-0f2f7aa65adf@huawei.com>
Date: Thu, 1 Aug 2024 20:58:36 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Udj5Jskjvvba345DFkySuZeg927OHQya0rCcynMtmGg8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/1 2:29, Alexander Duyck wrote:
> On Wed, Jul 31, 2024 at 5:50 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> Basing on the lib/objpool.c, change it to something like a
>> ptrpool, so that we can utilize that to test the correctness
>> and performance of the page_frag.
>>
>> The testing is done by ensuring that the fragment allocated
>> from a frag_frag_cache instance is pushed into a ptrpool
>> instance in a kthread binded to a specified cpu, and a kthread
>> binded to a specified cpu will pop the fragment from the
>> ptrpool and free the fragment.
>>
>> We may refactor out the common part between objpool and ptrpool
>> if this ptrpool thing turns out to be helpful for other place.
> 
> This isn't a patch where you should be introducing stuff you hope to
> refactor out and reuse later. Your objpoo/ptrpool stuff is just going
> to add bloat and overhead as you are going to have to do pointer
> changes to get them in and out of memory and you are having to scan
> per-cpu lists. You would be better served using a simple array as your
> threads should be stick to a consistent CPU anyway in terms of
> testing.
> 
> I would suggest keeping this much more simple. Trying to pattern this
> after something like the dmapool_test code would be a better way to go
> for this. We don't need all this extra objpool overhead getting in the
> way of testing the code you should be focused on. Just allocate your
> array on one specific CPU and start placing and removing your pages
> from there instead of messing with the push/pop semantics.

I am not sure if I understand what you meant here, do you meant something
like dmapool_test_alloc() does as something like below?

static int page_frag_test_alloc(void **p, int blocks)
{
	int i;

	for (i = 0; i < blocks; i++) {
		p[i] = page_frag_alloc(&test_frag, test_alloc_len, GFP_KERNEL);

		if (!p[i])
			goto pool_fail;
	}

	for (i = 0; i < blocks; i++)
		page_frag_free(p[i]);

	....
}

The above was my initial thinking too, I went to the ptrpool thing using
at least two CPUs as the below reason:
1. Test the concurrent calling between allocing and freeing more throughly,
   for example, page->_refcount concurrent handling, cache draining and
   cache reusing code path will be tested more throughly.
2. Test the performance impact of cache bouncing between different CPUs.

I am not sure if there is a more lightweight implementation than ptrpool
to do the above testing more throughly.

> 
> Lastly something that is a module only tester that always fails to
> probe doesn't sound like it really makes sense as a standard kernel

I had the same feeling as you, but when doing testing, it seems
convenient enough to do a 'insmod xxx.ko' for testing without a
'rmmod xxx.ko'

> module. I still think it would make more sense to move it to the
> selftests tree and just have it build there as a module instead of

I failed to find one example of test kernel module that is in the
selftests tree yet. If it does make sense, please provide an example
here, and I am willing to follow the pattern if there is one.

> trying to force it into the mm tree. The example of dmapool_test makes
> sense as it could be run at early boot to run the test and then it

I suppose you meant dmapool is built-in to the kernel and run at early
boot? I am not sure what is the point of built-in for dmapool, as it
only do one-time testing, and built-in for dmapool only waste some
memory when testing is done.

> just goes quiet. This module won't load and will always just return
> -EAGAIN which doesn't sound like a valid kernel module to me.

As above, it seems convenient enough to do a 'insmod xxx.ko' for testing
without a 'rmmod xxx.ko'.

