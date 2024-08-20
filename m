Return-Path: <netdev+bounces-120167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E096F958799
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 15:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650892834A6
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161C6190463;
	Tue, 20 Aug 2024 13:08:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FA17B4ED;
	Tue, 20 Aug 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724159290; cv=none; b=iSED1bYoIb1dvuS4B5h9n4eEWAj20R/C5ibemoTyDDhzDKt4+rY0DFk6l/mKzRT5Ukf2vDEWcGSP5Zhzv2I2+ompxlCu5A1MxcU4hSjtF0yo1mORWkFqRXf5jvO1EgGlyJ7Ug72Ivb+jA/7cctXVeJtF4+cvhjUSfAxFCLdAqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724159290; c=relaxed/simple;
	bh=RpCKBDqMTsj/+QOE8XMbCFaxwEtCyitUh5A+Zn9qtLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RUnK8anCMAe8EuFDZpNTb9NG+BsrfVOgBdZAn0Q5/TRywSYCujYccaSRxDxU+fO2vStqMxxwbBhuhpQRreOOe+pDFKVvJrH3TD6s/wuWJF+xE6PtL/yi+AZBrhKYUoJv+Od2gXg3jysvL8WQkrx9YuyDDx3ovpNVTPC5KMK+8RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wp8lv5K1LzQq66;
	Tue, 20 Aug 2024 21:03:23 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D1AFE140133;
	Tue, 20 Aug 2024 21:08:04 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 21:08:04 +0800
Message-ID: <37fc4b01-43f1-4a2c-af35-96cf3f7fe3d5@huawei.com>
Date: Tue, 20 Aug 2024 21:08:04 +0800
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
 <5905bad4-8a98-4f9d-9bd6-b9764e299ac7@huawei.com>
 <CAKgT0Ucz4R=xOCWgauDO_i6PX7=hgiohXngo2Mea5R8GC_s2qQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0Ucz4R=xOCWgauDO_i6PX7=hgiohXngo2Mea5R8GC_s2qQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/8/19 23:52, Alexander Duyck wrote:

>>
>> Yes, the expectation is that somebody else didn't take an access to the
>> page/data to send it off somewhere else between page_frag_alloc_va()
>> and page_frag_alloc_abort(), did you see expectation was broken in that
>> patch? If yes, we should fix that by using page_frag_free_va() related
>> API instead of using page_frag_alloc_abort().
> 
> The problem is when you expose it to XDP there are a number of
> different paths it can take. As such you shouldn't be expecting XDP to
> not do something like that. Basically you have to check the reference

Even if XDP operations like xdp_do_redirect() or tun_xdp_xmit() return
failure, we still can not do that? It seems odd that happens.
If not, can we use page_frag_alloc_abort() with fragsz being zero to avoid
atomic operation?

> count before you can rewind the page.
> 
>>>
>>>
>>>>
>>>>>> +static struct page *__page_frag_cache_reload(struct page_frag_cache *nc,
>>>>>> +                                         gfp_t gfp_mask)
>>>>>>  {
>>>>>> +    struct page *page;
>>>>>> +
>>>>>>      if (likely(nc->encoded_va)) {
>>>>>> -            if (__page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias))
>>>>>> +            page = __page_frag_cache_reuse(nc->encoded_va, nc->pagecnt_bias);
>>>>>> +            if (page)
>>>>>>                      goto out;
>>>>>>      }
>>>>>>
>>>>>> -    if (unlikely(!__page_frag_cache_refill(nc, gfp_mask)))
>>>>>> -            return false;
>>>>>> +    page = __page_frag_cache_refill(nc, gfp_mask);
>>>>>> +    if (unlikely(!page))
>>>>>> +            return NULL;
>>>>>>
>>>>>>  out:
>>>>>>      /* reset page count bias and remaining to start of new frag */
>>>>>>      nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
>>>>>>      nc->remaining = page_frag_cache_page_size(nc->encoded_va);
>>>>>> -    return true;
>>>>>> +    return page;
>>>>>> +}
>>>>>> +
>>>>>
>>>>> None of the functions above need to be returning page.
>>>>
>>>> Are you still suggesting to always use virt_to_page() even when it is
>>>> not really necessary? why not return the page here to avoid the
>>>> virt_to_page()?
>>>
>>> Yes. The likelihood of you needing to pass this out as a page should
>>> be low as most cases will just be you using the virtual address
>>> anyway. You are essentially trading off branching for not having to
>>> use virt_to_page. It is unnecessary optimization.
>>
>> As my understanding, I am not trading off branching for not having to
>> use virt_to_page, the branching is already needed no matter we utilize
>> it to avoid calling virt_to_page() or not, please be more specific about
>> which branching is traded off for not having to use virt_to_page() here.
> 
> The virt_to_page overhead isn't that high. It would be better to just
> use a consistent path rather than try to optimize for an unlikely
> branch in your datapath.

I am not sure if I understand what do you mean by 'consistent path' here.
If I understand your comment correctly, the path is already not consistent
to avoid having to fetch size multiple times multiple ways as mentioned in
[1]. As below, doesn't it seems nature to avoid virt_to_page() calling while
avoiding page_frag_cache_page_size() calling, even if it is an unlikely case
as you mentioned:

struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
                                unsigned int *offset, unsigned int fragsz,
                                gfp_t gfp)
{
        unsigned int remaining = nc->remaining;
        struct page *page;

        VM_BUG_ON(!fragsz);
        if (likely(remaining >= fragsz)) {
                unsigned long encoded_va = nc->encoded_va;

                *offset = page_frag_cache_page_size(encoded_va) -
                                remaining;

                return virt_to_page((void *)encoded_va);
        }

        if (unlikely(fragsz > PAGE_SIZE))
                return NULL;

        page = __page_frag_cache_reload(nc, gfp);
        if (unlikely(!page))
                return NULL;

        *offset = 0;
        nc->remaining -= fragsz;
        nc->pagecnt_bias--;

        return page;
}

1. https://lore.kernel.org/all/CAKgT0UeQ9gwYo7qttak0UgXC9+kunO2gedm_yjtPiMk4VJp9yQ@mail.gmail.com/

> 
>>>
>>>
>>>>
>>>>>> +struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
>>>>>> +                            unsigned int *offset, unsigned int fragsz,
>>>>>> +                            gfp_t gfp)
>>>>>> +{
>>>>>> +    unsigned int remaining = nc->remaining;
>>>>>> +    struct page *page;
>>>>>> +
>>>>>> +    VM_BUG_ON(!fragsz);
>>>>>> +    if (likely(remaining >= fragsz)) {
>>>>>> +            unsigned long encoded_va = nc->encoded_va;
>>>>>> +
>>>>>> +            *offset = page_frag_cache_page_size(encoded_va) -
>>>>>> +                            remaining;
>>>>>> +
>>>>>> +            return virt_to_page((void *)encoded_va);
>>>>>> +    }
>>>>>> +
>>>>>> +    if (unlikely(fragsz > PAGE_SIZE))
>>>>>> +            return NULL;
>>>>>> +
>>>>>> +    page = __page_frag_cache_reload(nc, gfp);
>>>>>> +    if (unlikely(!page))
>>>>>> +            return NULL;
>>>>>> +
>>>>>> +    *offset = 0;
>>>>>> +    nc->remaining = remaining - fragsz;
>>>>>> +    nc->pagecnt_bias--;
>>>>>> +
>>>>>> +    return page;
>>>>>>  }
>>>>>> +EXPORT_SYMBOL(page_frag_alloc_pg);
>>>>>
>>>>> Again, this isn't returning a page. It is essentially returning a
>>>>> bio_vec without calling it as such. You might as well pass the bio_vec
>>>>> pointer as an argument and just have it populate it directly.
>>>>
>>>> I really don't think your bio_vec suggestion make much sense  for now as
>>>> the reason mentioned in below:
>>>>
>>>> "Through a quick look, there seems to be at least three structs which have
>>>> similar values: struct bio_vec & struct skb_frag & struct page_frag.
>>>>
>>>> As your above agrument about using bio_vec, it seems it is ok to use any
>>>> one of them as each one of them seems to have almost all the values we
>>>> are using?
>>>>
>>>> Personally, my preference over them: 'struct page_frag' > 'struct skb_frag'
>>>>> 'struct bio_vec', as the naming of 'struct page_frag' seems to best match
>>>> the page_frag API, 'struct skb_frag' is the second preference because we
>>>> mostly need to fill skb frag anyway, and 'struct bio_vec' is the last
>>>> preference because it just happen to have almost all the values needed.
>>>
>>> That is why I said I would be okay with us passing page_frag in patch
>>> 12 after looking closer at the code. The fact is it should make the
>>> review of that patch set much easier if you essentially just pass the
>>> page_frag back out of the call. Then it could be used in exactly the
>>> same way it was before and should reduce the total number of lines of
>>> code that need to be changed.
>>
>> So the your suggestion changed to something like below?
>>
>> int page_frag_alloc_pfrag(struct page_frag_cache *nc, struct page_frag *pfrag);
>>
>> The API naming of 'page_frag_alloc_pfrag' seems a little odd to me, any better
>> one in your mind?
> 
> Well at this point we are populating/getting/pulling a page frag from
> the page frag cache. Maybe look for a word other than alloc such as
> populate. Essentially what you are doing is populating the pfrag from
> the frag cache, although I thought there was a size value you passed
> for that isn't there?

'struct page_frag' does have a size field, but I am not sure if I
understand what do you mean by  'although I thought there was a size
value you passed for that isn't there?‘ yet.

