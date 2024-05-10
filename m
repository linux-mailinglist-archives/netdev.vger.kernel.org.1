Return-Path: <netdev+bounces-95552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7414E8C29F0
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E7E0281E93
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F060D31A60;
	Fri, 10 May 2024 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m0gx9mlq"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D688511713;
	Fri, 10 May 2024 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715365855; cv=none; b=f/klpoYYH9RrBBEEopubT+CqYc6vEoHF8RHY0DEcITdhS757H9bramjGgnAT6nyHLMnr2AC08ikuIHts2Ac7wBBmWgCW9aSg1rI4cNr9HNhAef8aHm5LTo+uixoyux71XbNfLdnUakunXbPHcs6JxgfTTHXEaAA/mR0nrEg3thE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715365855; c=relaxed/simple;
	bh=3iPOfcunpN3iBQwE1TT0LZMff8smSsv0J6fKYFJXBeE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tS8vYR/iShMJP5Sfg/mjfV4Db6S0bb36q/AUTtBLYpJIS8YKxtePEC4UzSIU8ROIrXafisuEwrzKTfOf9gktDPpzMMMi0UWWv45n8qLt/+/oujFTfDRPc+i25iJ2w9PV8YjbWZtr+ZppBCI8pwk34UtWTsrnZSoAMlRqgfgSxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m0gx9mlq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=aONa/loSB4zk1VdXAk5+sCgpvMBlByp57fP/65dugMk=; b=m0gx9mlqN2qsVRL4rOqe25juBc
	yA0kqCouo2T4ssz09wwpNdH7mciXKGsckJ9h4wZx5M0NEj/pn0Au4FsOokOQwWA598kWpsKMzVwMx
	8pJPR9OmJipZANVa8/cA/TqsToThER+ithPi34BkEbVzx+xud1JpoRiujhkZ4Nx5rFFCEuXOGPARR
	YZu3xjc0Vh8RxrfkNQ94R//eogMRxW9YXvi4VFxfI/uetE9ucwLCwDXo2AeItI/uLl+P2zxcXEefF
	OMaciRmWwrT9sTVx+JJZ3TWyoDQIT+oMBIY6auFOUjVXmWL3s/P3ggHhWx8rYXJyIYVfq+mPFwual
	Ux5fBVVA==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5V18-000000068zh-3Gsl;
	Fri, 10 May 2024 18:30:50 +0000
Message-ID: <463d6564-ea67-4f1f-92f2-196a1334cc3c@infradead.org>
Date: Fri, 10 May 2024 11:30:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/13] mm: page_frag: update documentation for
 page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20240508133408.54708-1-linyunsheng@huawei.com>
 <20240508133408.54708-13-linyunsheng@huawei.com>
 <0ac5219b-b756-4a8d-ba31-21601eb1e7f4@infradead.org>
 <ff1089c8-ad02-04bb-f715-ca97c118338b@huawei.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ff1089c8-ad02-04bb-f715-ca97c118338b@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi.

On 5/10/24 5:32 AM, Yunsheng Lin wrote:
> On 2024/5/9 8:44, Randy Dunlap wrote:
>>
>>
> 
>>>  
>>> +/**
>>> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
>>> + * @nc: page_frag cache from which to check
>>> + *
>>> + * Used to check if the current page in page_frag cache is pfmemalloc'ed.
>>> + * It has the same calling context expection as the alloc API.
>>> + *
>>> + * Return:
>>> + * Return true if the current page in page_frag cache is pfmemalloc'ed,
>>
>> Drop the (second) word "Return"...
> 
> Did you mean something like below:
> 
> * Return:
> * Return true if the current page in page_frag cache is pfmemalloc'ed,
> * otherwise false.
> 
> Or:
> 
> * Return:
> * true if the current page in page_frag cache is pfmemalloc'ed, otherwise
> * return false.

This one ^^^^^^^^^^^^^^^^^^^^.

> 
>>
>>> + * otherwise return false.
>>> + */
>>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>>>  {
>>>  	return encoded_page_pfmemalloc(nc->encoded_va);
>>> @@ -92,6 +109,19 @@ void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
>>>  				 unsigned int fragsz, gfp_t gfp_mask,
>>>  				 unsigned int align_mask);
>>>  
>>> +/**
>>> + * page_frag_alloc_va_align() - Alloc a page fragment with aligning requirement.
>>> + * @nc: page_frag cache from which to allocate
>>> + * @fragsz: the requested fragment size
>>> + * @gfp_mask: the allocation gfp to use when cache need to be refilled
>>
>>                                                       needs
>>
>>> + * @align: the requested aligning requirement for 'va'
>>
>>                  or                                  @va
> 
> What does the 'or' means?

I was just trying to say that you could use
     'va'
or
     @va
here.

> 
>>
> 
> ...
> 
>>
>>                                                  needs
>>
>>> + *
>>> + * Prepare a page fragment with minimum size of ‘fragsz’, 'fragsz' is also used
>>
>>                                                    'fragsz'. 'fragsz'
>> (don't use fancy single quote marks)
> 
> You mean using @parameter to replace all the parameters marked with single
> quote marks, right?

That's what I would do, but there is also the issue of the first occurrence of
quoted fragsz that uses Unicode quote marks, but the second occurrence of
quoted fragsz uses plain ASCII quote marks. This happens in multiple places
(probably due to copy-paste).

> 
> ...

Thanks.

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

