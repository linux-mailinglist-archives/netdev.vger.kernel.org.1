Return-Path: <netdev+bounces-119186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BA895486C
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 14:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23BF5B20DCE
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB615573C;
	Fri, 16 Aug 2024 12:01:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A978563E;
	Fri, 16 Aug 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809684; cv=none; b=QPDfb2PwffDOHseyxTfdRFJpXf6b/zBk/9jU203xzrPc3SNltySn+i2rK1Bo6cAPbw63zNc4NHPmZLW476fGD7w04lSLHvRMD39zpl/JdlOjnAPiATmCFDkK7TRNKVtzUwNMThfPWsXJiiPHv9w7ee7IVR6RPuclWY+pVDpWb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809684; c=relaxed/simple;
	bh=5xbALISqvkvqGTvMtBsQvjDDQrwH0JiPBK086Qe5fi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KRZnBzG+mMvEqGdWPLXQG/e8+Q0VW9hqtbTjh8USwP/5b4xhCnqg1A6g3yzuqRIjGqepWhjGNn5sQ3sqzGu9NazsnxPBjUdppI4Npa+BfEPcpXsKzwXs2BsUrg9rnIaIEP/GD5c6twclwdIKh6IfdZ6zg0rZEFosM3t+2EHk7ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WlgSS6FY2z1j6c7;
	Fri, 16 Aug 2024 19:56:24 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5635914037D;
	Fri, 16 Aug 2024 20:01:19 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 Aug 2024 20:01:19 +0800
Message-ID: <5905bad4-8a98-4f9d-9bd6-b9764e299ac7@huawei.com>
Date: Fri, 16 Aug 2024 20:01:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 11/14] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-12-linyunsheng@huawei.com>
 <d9814d6628599b7b28ed29c71d6fb6631123fdef.camel@gmail.com>
 <7f06fa30-fa7c-4cf2-bd8e-52ea1c78f8aa@huawei.com>
 <CAKgT0Uetu1HA4hCGvBLwRgsgX6Y95FDw0epVf5S+XSnezScQ_w@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Uetu1HA4hCGvBLwRgsgX6Y95FDw0epVf5S+XSnezScQ_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/15 23:25, Alexander Duyck wrote:
> On Wed, Aug 14, 2024 at 8:05 PM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/8/15 5:00, Alexander H Duyck wrote:
> 
> ...
> 
>>>> +static inline void page_frag_alloc_abort(struct page_frag_cache *nc,
>>>> +                                     unsigned int fragsz)
>>>> +{
>>>> +    nc->pagecnt_bias++;
>>>> +    nc->remaining += fragsz;
>>>> +}
>>>> +
>>>
>>> This doesn't add up. Why would you need abort if you have commit? Isn't
>>> this more of a revert? I wouldn't think that would be valid as it is
>>> possible you took some sort of action that might have resulted in this
>>> memory already being shared. We shouldn't allow rewinding the offset
>>> pointer without knowing that there are no other entities sharing the
>>> page.
>>
>> This is used for __tun_build_skb() in drivers/net/tun.c as below, mainly
>> used to avoid performance penalty for XDP drop case:
> 
> Yeah, I reviewed that patch. As I said there, rewinding the offset
> should be avoided unless you can verify you are the only owner of the
> page as you have no guarantees that somebody else didn't take an
> access to the page/data to send it off somewhere else. Once you expose
> the page to any other entity it should be written off or committed in
> your case and you should move on to the next block.

Yes, the expectation is that somebody else didn't take an access to the
page/data to send it off somewhere else between page_frag_alloc_va()
and page_frag_alloc_abort(), did you see expectation was broken in that
patch? If yes, we should fix that by using page_frag_free_va() related
API instead of using page_frag_alloc_abort().

> 
> 
>>
>>>> +static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
>>>> +                                         gfp_t gfp_mask)
>>>>  {
>>>> +    struct page *page;
>>>> +
>>>>      if (likely(nc->encoded_va)) {
>>>> -            if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
>>>> +            page = __page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias);
>>>> +            if (page)
>>>>                      goto out;
>>>>      }
>>>>
>>>> -    if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
>>>> -            return false;
>>>> +    page = __page_frag_cache_refill(nc, gfp_mask);
>>>> +    if (unlikely(!page))
>>>> +            return NULL;
>>>>
>>>>  out:
>>>>      /* reset page count bias and remaining to start of new frag */
>>>>      nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>>      nc->remaining = page_frag_cache_page_size(nc->encoded_va);
>>>> -    return true;
>>>> +    return page;
>>>> +}
>>>> +
>>>
>>> None of the functions above need to be returning page.
>>
>> Are you still suggesting to always use virt_to_page() even when it is
>> not really necessary? why not return the page here to avoid the
>> virt_to_page()?
> 
> Yes. The likelihood of you needing to pass this out as a page should
> be low as most cases will just be you using the virtual address
> anyway. You are essentially trading off branching for not having to
> use virt_to_page. It is unnecessary optimization.

As my understanding, I am not trading off branching for not having to
use virt_to_page, the branching is already needed no matter we utilize
it to avoid calling virt_to_page() or not, please be more specific about
which branching is traded off for not having to use virt_to_page() here.


> 
> 
>>
>>>> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
>>>> +                            unsigned int *offset, unsigned int fragsz,
>>>> +                            gfp_t gfp)
>>>> +{
>>>> +    unsigned int remaining = nc->remaining;
>>>> +    struct page *page;
>>>> +
>>>> +    VM_BUG_ON(!fragsz);
>>>> +    if (likely(remaining >= fragsz)) {
>>>> +            unsigned long encoded_va = nc->encoded_va;
>>>> +
>>>> +            *offset = page_frag_cache_page_size(encoded_va) -
>>>> +                            remaining;
>>>> +
>>>> +            return virt_to_page((void *)encoded_va);
>>>> +    }
>>>> +
>>>> +    if (unlikely(fragsz > PAGE_SIZE))
>>>> +            return NULL;
>>>> +
>>>> +    page = __page_frag_cache_reload(nc, gfp);
>>>> +    if (unlikely(!page))
>>>> +            return NULL;
>>>> +
>>>> +    *offset = 0;
>>>> +    nc->remaining = remaining - fragsz;
>>>> +    nc->pagecnt_bias--;
>>>> +
>>>> +    return page;
>>>>  }
>>>> +EXPORT_SYMBOL(page_frag_alloc_pg);
>>>
>>> Again, this isn't returning a page. It is essentially returning a
>>> bio_vec without calling it as such. You might as well pass the bio_vec
>>> pointer as an argument and just have it populate it directly.
>>
>> I really don't think your bio_vec suggestion make much sense  for now as
>> the reason mentioned in below:
>>
>> "Through a quick look, there seems to be at least three structs which have
>> similar values: struct bio_vec & struct skb_frag & struct page_frag.
>>
>> As your above agrument about using bio_vec, it seems it is ok to use any
>> one of them as each one of them seems to have almost all the values we
>> are using?
>>
>> Personally, my preference over them: 'struct page_frag' > 'struct skb_frag'
>>> 'struct bio_vec', as the naming of 'struct page_frag' seems to best match
>> the page_frag API, 'struct skb_frag' is the second preference because we
>> mostly need to fill skb frag anyway, and 'struct bio_vec' is the last
>> preference because it just happen to have almost all the values needed.
> 
> That is why I said I would be okay with us passing page_frag in patch
> 12 after looking closer at the code. The fact is it should make the
> review of that patch set much easier if you essentially just pass the
> page_frag back out of the call. Then it could be used in exactly the
> same way it was before and should reduce the total number of lines of
> code that need to be changed.

So the your suggestion changed to something like below?

int page_frag_alloc_pfrag(struct page_frag_cache *nc, struct page_frag *pfrag);

The API naming of 'page_frag_alloc_pfrag' seems a little odd to me, any better
one in your mind?

> 
>> Is there any specific reason other than the above "almost all the values you
>> are using are exposed by that structure already " that you prefer bio_vec?"
>>
>> 1. https://lore.kernel.org/all/ca6be29e-ab53-4673-9624-90d41616a154@huawei.com/
> 
> My reason for preferring bio_vec is that of the 3 it is the most setup
> to be used as a local variable versus something stored in a struct
> such as page_frag or used for some specialty user case such as
> skb_frag_t. In addition it already has a set of helpers for converting
> it to a virtual address or copying data to and from it which would
> make it easier to get rid of a bunch of duplicate code.

