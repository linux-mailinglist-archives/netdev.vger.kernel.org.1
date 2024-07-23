Return-Path: <netdev+bounces-112584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6AB93A12C
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68C82811E9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796601527A9;
	Tue, 23 Jul 2024 13:19:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA33B152789;
	Tue, 23 Jul 2024 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740753; cv=none; b=p8/5kKD+1tsaOV92Gs5/p/qHR4ACEwOlLQZ6uey2MR09o0IT49AHr1r1N9BZSOXGVN+SG8qfoWK5ZmbqX69IeR6jcQ0mX3hJr5G6wkopm8329aY76oSGSQ7oij9c0n1fa+m9wSmZIcnB2nNzPBCQw5QAx96AU7obhoBQwHYfNs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740753; c=relaxed/simple;
	bh=y6e10y3CrqgmfUUaHCoUQqvIZBhnyH6plpe9YBvmGF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fOlfF8C3UbzbqYVRtGVaxKcTX5F8eoUSe6F30qnJJvLJxndbTAMrFtosHADPyp/UilWmI8Tkdsyacwpz13aZs4JHOHRs85SftOS/Pd8H3lz0LB4GMdcKhwo6t0MAAx7dYjpO6KsvVhpTgYlTjIcQ3NZ/Oj4KVGJGUVHqm6UrtvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WSyKK1QkWzyN4B;
	Tue, 23 Jul 2024 21:14:13 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C584918009D;
	Tue, 23 Jul 2024 21:19:02 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Jul 2024 21:19:02 +0800
Message-ID: <c7497b53-2dd7-4176-bb70-4a14558d90ab@huawei.com>
Date: Tue, 23 Jul 2024 21:19:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v11 01/14] mm: page_frag: add a test module for page_frag
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240719093338.55117-1-linyunsheng@huawei.com>
 <20240719093338.55117-2-linyunsheng@huawei.com>
 <CAKgT0UcsBGKR+AGU6wDUpXY48FnEA4hdvvti-YC87=8zfGPLdg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UcsBGKR+AGU6wDUpXY48FnEA4hdvvti-YC87=8zfGPLdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/7/22 1:34, Alexander Duyck wrote:
> On Fri, Jul 19, 2024 at 2:36 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
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
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  mm/Kconfig.debug    |   8 +
>>  mm/Makefile         |   1 +
>>  mm/page_frag_test.c | 393 ++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 402 insertions(+)
>>  create mode 100644 mm/page_frag_test.c
> 
> I might have missed it somewhere. Is there any reason why this isn't
> in the selftests/mm/ directory? Seems like that would be a better fit
> for this.
> 
>> diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
>> index afc72fde0f03..1ebcd45f47d4 100644
>> --- a/mm/Kconfig.debug
>> +++ b/mm/Kconfig.debug
>> @@ -142,6 +142,14 @@ config DEBUG_PAGE_REF
>>           kernel code.  However the runtime performance overhead is virtually
>>           nil until the tracepoints are actually enabled.
>>
>> +config DEBUG_PAGE_FRAG_TEST
> 
> This isn't a "DEBUG" feature. This is a test feature.
> 
>> +       tristate "Test module for page_frag"
>> +       default n
>> +       depends on m && DEBUG_KERNEL
> 
> I am not sure it is valid to have a tristate depend on being built as a module.

Perhaps I was copying the wrong pattern from TEST_OBJPOOL in lib/Kconfig.debug.
Perhaps mm/dmapool_test.c and DMAPOOL_TEST* *was more appropriate pattern
for test module for page_frag?

> 
> I think if you can set it up as a selftest it will have broader use as
> you could compile it against any target kernel going forward and add
> it as a module rather than having to build it as a part of a debug
> kernel.

It seems tools/testing/selftests/mm/* are all about userspace testing
tool, and testing kernel module seems to be in the same directory with
the code to be tested?

> 
>> +       help
>> +         This builds the "page_frag_test" module that is used to test the
>> +         correctness and performance of page_frag's implementation.
>> +
>>  config DEBUG_RODATA_TEST
>>      bool "Testcase for the marking rodata read-only"

...

>> +
>> +               /*
>> +                * here we allocate percpu-slot & objs together in a single
>> +                * allocation to make it more compact, taking advantage of
>> +                * warm caches and TLB hits. in default vmalloc is used to
>> +                * reduce the pressure of kernel slab system. as we know,
>> +                * minimal size of vmalloc is one page since vmalloc would
>> +                * always align the requested size to page size
>> +                */
>> +               if (gfp & GFP_ATOMIC)
>> +                       slot = kmalloc_node(size, gfp, cpu_to_node(i));
>> +               else
>> +                       slot = __vmalloc_node(size, sizeof(void *), gfp,
>> +                                             cpu_to_node(i),
>> +                                             __builtin_return_address(0));
> 
> When would anyone ever call this with atomic? This is just for your
> test isn't it?
> 
>> +               if (!slot)
>> +                       return -ENOMEM;
>> +
>> +               memset(slot, 0, size);
>> +               pool->cpu_slots[i] = slot;
>> +
>> +               objpool_init_percpu_slot(pool, slot);
>> +       }
>> +
>> +       return 0;
>> +}

...

>> +/* release whole objpool forcely */
>> +static void objpool_free(struct objpool_head *pool)
>> +{
>> +       if (!pool->cpu_slots)
>> +               return;
>> +
>> +       /* release percpu slots */
>> +       objpool_fini_percpu_slots(pool);
>> +}
>> +
> 
> Why add all this extra objpool overhead? This seems like overkill for
> what should be a simple test. Seems like you should just need a simple
> array located on one of your CPUs. I'm not sure what is with all the
> extra overhead being added here.

As mentioned in the commit log:
"We may refactor out the common part between objpool and ptrpool
if this ptrpool thing turns out to be helpful for other place."

The next thing I am trying to do is to use ptrpool to optimization
the pcp for mm subsystem. so I would rather not tailor the ptrpool
for page_frag_test, and it doesn't seem to affect the testing that
much.

> 
>> +static struct objpool_head ptr_pool;
>> +static int nr_objs = 512;
>> +static atomic_t nthreads;
>> +static struct completion wait;
>> +static struct page_frag_cache test_frag;
>> +
>> +static int nr_test = 5120000;
>> +module_param(nr_test, int, 0);
>> +MODULE_PARM_DESC(nr_test, "number of iterations to test");
>> +
>> +static bool test_align;
>> +module_param(test_align, bool, 0);
>> +MODULE_PARM_DESC(test_align, "use align API for testing");
>> +
>> +static int test_alloc_len = 2048;
>> +module_param(test_alloc_len, int, 0);
>> +MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
>> +
>> +static int test_push_cpu;
>> +module_param(test_push_cpu, int, 0);
>> +MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
>> +
>> +static int test_pop_cpu;
>> +module_param(test_pop_cpu, int, 0);
>> +MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
>> +
>> +static int page_frag_pop_thread(void *arg)
>> +{
>> +       struct objpool_head *pool = arg;
>> +       int nr = nr_test;
>> +
>> +       pr_info("page_frag pop test thread begins on cpu %d\n",
>> +               smp_processor_id());
>> +
>> +       while (nr > 0) {
>> +               void *obj = objpool_pop(pool);
>> +
>> +               if (obj) {
>> +                       nr--;
>> +                       page_frag_free(obj);
>> +               } else {
>> +                       cond_resched();
>> +               }
>> +       }
>> +
>> +       if (atomic_dec_and_test(&nthreads))
>> +               complete(&wait);
>> +
>> +       pr_info("page_frag pop test thread exits on cpu %d\n",
>> +               smp_processor_id());
>> +
>> +       return 0;
>> +}
>> +
>> +static int page_frag_push_thread(void *arg)
>> +{
>> +       struct objpool_head *pool = arg;
>> +       int nr = nr_test;
>> +
>> +       pr_info("page_frag push test thread begins on cpu %d\n",
>> +               smp_processor_id());
>> +
>> +       while (nr > 0) {
>> +               void *va;
>> +               int ret;
>> +
>> +               if (test_align) {
>> +                       va = page_frag_alloc_align(&test_frag, test_alloc_len,
>> +                                                  GFP_KERNEL, SMP_CACHE_BYTES);
>> +
>> +                       WARN_ONCE((unsigned long)va & (SMP_CACHE_BYTES - 1),
>> +                                 "unaligned va returned\n");
>> +               } else {
>> +                       va = page_frag_alloc(&test_frag, test_alloc_len, GFP_KERNEL);
>> +               }
>> +
>> +               if (!va)
>> +                       continue;
>> +
>> +               ret = objpool_push(va, pool);
>> +               if (ret) {
>> +                       page_frag_free(va);
>> +                       cond_resched();
>> +               } else {
>> +                       nr--;
>> +               }
>> +       }
>> +
>> +       pr_info("page_frag push test thread exits on cpu %d\n",
>> +               smp_processor_id());
>> +
>> +       if (atomic_dec_and_test(&nthreads))
>> +               complete(&wait);
>> +
>> +       return 0;
>> +}
>> +
> 
> So looking over these functions they seem to overlook how the network
> stack works in many cases. One of the main motivations for the page
> frags approach is page recycling. For example with GRO enabled the
> headers allocated to record the frags might be freed for all but the
> first. As such you can end up with 17 fragments being allocated, and
> 16 freed within the same thread as NAPI will just be recycling the
> buffers.
> 
> With this setup it doesn't seem very likely to be triggered since you
> are operating in two threads. One test you might want to look at
> adding is a test where you are allocating and freeing in the same
> thread at a fairly constant rate to test against the "ideal" scenario.

I am not sure if the above is still the "ideal" scenario, as you mentioned
that most drivers are turning to use page_pool for rx, the page frag is really
mostly for tx or skb->data for rx.

> 


