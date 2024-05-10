Return-Path: <netdev+bounces-95461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC2C8C24EA
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 14:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2E71F2298A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB6684E1E;
	Fri, 10 May 2024 12:32:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0407710E;
	Fri, 10 May 2024 12:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715344341; cv=none; b=UN0B1xHjY8iw6486qT6cs2Yj+sG+6rnsQYMB4/BiliqlNJKqIUaTl6UdeCTXf8CbMxQ9+pqKGk8yuA9TnTr8KhO/nK1qEr5D5D4oMCcMZv/+fBVyGXTIdPxY97tOrGQDmlEAQqhSHmWtSofcdDdnp65nK6qVs3pCMqA6HIYCuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715344341; c=relaxed/simple;
	bh=svbvXxDmVnO4Tq8gBc3g88zQQCnetE8Ld/NCaM3Q3+w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=WAmfNjwJBmcowJ8EZzfmaf/rW0yPhzknqrRG6809ap/qn37/6RiRMAt76rY4XhHrgTZwVMjCuv+XYMTQuE8J+IFs6I+dOHDC4zWMFdY5XNNBvWwXux2/g04yiyAbTPd2p/oP70xQEtGpM2yGnxqQ4nxUaVCCUBkEE4RSUQBYvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VbSqD2Xl0z1j1M5;
	Fri, 10 May 2024 20:28:56 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F356140124;
	Fri, 10 May 2024 20:32:14 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 May
 2024 20:32:14 +0800
Subject: Re: [PATCH net-next v3 12/13] mm: page_frag: update documentation for
 page_frag
To: Randy Dunlap <rdunlap@infradead.org>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-doc@vger.kernel.org>
References: <20240508133408.54708-1-linyunsheng@huawei.com>
 <20240508133408.54708-13-linyunsheng@huawei.com>
 <0ac5219b-b756-4a8d-ba31-21601eb1e7f4@infradead.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <ff1089c8-ad02-04bb-f715-ca97c118338b@huawei.com>
Date: Fri, 10 May 2024 20:32:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0ac5219b-b756-4a8d-ba31-21601eb1e7f4@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/5/9 8:44, Randy Dunlap wrote:
> 
> 

>>  
>> +/**
>> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
>> + * @nc: page_frag cache from which to check
>> + *
>> + * Used to check if the current page in page_frag cache is pfmemalloc'ed.
>> + * It has the same calling context expection as the alloc API.
>> + *
>> + * Return:
>> + * Return true if the current page in page_frag cache is pfmemalloc'ed,
> 
> Drop the (second) word "Return"...

Did you mean something like below:

* Return:
* Return true if the current page in page_frag cache is pfmemalloc'ed,
* otherwise false.

Or:

* Return:
* true if the current page in page_frag cache is pfmemalloc'ed, otherwise
* return false.


> 
>> + * otherwise return false.
>> + */
>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>>  {
>>  	return encoded_page_pfmemalloc(nc->encoded_va);
>> @@ -92,6 +109,19 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>>  				 unsigned int fragsz, gfp_t gfp_mask,
>>  				 unsigned int align_mask);
>>  
>> +/**
>> + * page_frag_alloc_va_align() - Alloc a page fragment with aligning requirement.
>> + * @nc: page_frag cache from which to allocate
>> + * @fragsz: the requested fragment size
>> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
> 
>                                                       needs
> 
>> + * @align: the requested aligning requirement for 'va'
> 
>                  or                                  @va

What does the 'or' means?

> 

...

> 
>                                                  needs
> 
>> + *
>> + * Prepare a page fragment with minimum size of ‘fragsz’, 'fragsz' is also used
> 
>                                                    'fragsz'. 'fragsz'
> (don't use fancy single quote marks)

You mean using @parameter to replace all the parameters marked with single
quote marks, right?

...

>>  
>> +/**
>> + * page_frag_alloc_prepare - Prepare allocing a page fragment.
>> + * @nc: page_frag cache from which to prepare
>> + * @offset: out as the offset of the page fragment
>> + * @fragsz: in as the requested size, out as the available size
>> + * @va: out as the virtual address of the returned page fragment
>> + * @gfp: the allocation gfp to use when cache need to be refilled
>> + *
>> + * Prepare a page fragment with minimum size of ‘fragsz’, 'fragsz' is also used
> 
>                                                    'fragsz'. 'fragsz'
> (don't use fancy single quote marks)
> 
> You could also (in several places) refer to the variables as
>                                                     @fragsz. @fragsz
> 
>> + * to report the maximum size of the page fragment. Return both 'page' and 'va'
>> + * of the fragment to the caller.
>> + *
>> + * Return:
>> + * Return the page fragment, otherwise return NULL.
> 
> Drop second "Return". But the paragraph above says that both @page and @va
> are returned. How is that done?

struct page *page_frag_alloc_prepare(struct page_frag_cache *nc,
				     unsigned int *offset,
				     unsigned int *fragsz,
				     void **va, gfp_t gfp);

As above, @page is returned through the function return, @va is returned
through double pointer.

Thanks for the detailed review.

