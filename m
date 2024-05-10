Return-Path: <netdev+bounces-95376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6138C2148
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 816BE1F21835
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78321168AE7;
	Fri, 10 May 2024 09:49:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E43280BF8;
	Fri, 10 May 2024 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334545; cv=none; b=PcZfqSyV0fRMdGCbTazUwtE11ZNA6edUmfoYqp7OmBGtADf6E1H9noLJYazv+iZBNEi9gTP8PdhY5wH/uFynSicYuFn7dhlj1WDVCzgok6ddxKKLfjDLUf3ieOJ9hHaFAjwWLfPTa+sOjEdz4MLUHWJHyvus9vFCVcZ92SDLyL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334545; c=relaxed/simple;
	bh=iBTeFMOVS9mPmWJSeecbdFD3UyXlu0mEW/gwhiAFh6I=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CY1QfrRc/28U/kjuae4Z42chJbyRLR6jtWIjGIibu9bStJfxbQKaCkzJ7PnPxqq9WnVl99UpZUkSis1YZzvxe2i1ROuoOErcEP2Ds4cn+IItYlNdLtawera4hDxNc7z0gEEgrQvOfS1eAWN9WnUuVQ+4Ef2ioUjJmAcHfJ1T824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VbPCM1tQ1z1ypGw;
	Fri, 10 May 2024 17:46:07 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B24CF14038F;
	Fri, 10 May 2024 17:48:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 May
 2024 17:48:55 +0800
Subject: Re: [PATCH net-next v3 12/13] mm: page_frag: update documentation for
 page_frag
To: Mat Martineau <martineau@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-doc@vger.kernel.org>
References: <20240508133408.54708-1-linyunsheng@huawei.com>
 <20240508133408.54708-13-linyunsheng@huawei.com>
 <2dc46fd0-fe7a-436a-5238-ff6b3f69e1a8@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <9b76e7c0-7b24-00e5-adba-214ce306ae96@huawei.com>
Date: Fri, 10 May 2024 17:48:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2dc46fd0-fe7a-436a-5238-ff6b3f69e1a8@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/5/10 0:58, Mat Martineau wrote:

...

>>
>> +/**
>> + * page_frag_alloc_probe - Probe the avaiable page fragment.
>> + * @nc: page_frag cache from which to probe
>> + * @offset: out as the offset of the page fragment
>> + * @fragsz: in as the requested size, out as the available size
> 
> Hi Yunsheng -
> 
> fragsz is never used as an input in this function. I think it would be good to make the code consistent with this documentation by checking that *fragsz <= (nc)->remaining

Yes, you are right.
It is not used as input, will update the documentation according.

> 
>> + * @va: out as the virtual address of the returned page fragment
>> + *
>> + * Probe the current available memory to caller without doing cache refilling.
>> + * If the cache is empty, return NULL.
> 
> Instead of this line, is it more accurate to say "if no space is available in the page_frag cache, return NULL" ?
> 
> I also suggest adding some documentation here like:
> 
> "If the requested space is available, up to fragsz bytes may be added to the fragment using page_frag_alloc_commit()".

Ok.

> 
>> + *
>> + * Return:
>> + * Return the page fragment, otherwise return NULL.
>> + */
>> #define page_frag_alloc_probe(nc, offset, fragsz, va)            \
>> ({                                    \
>>     struct encoded_va *__encoded_va;                \
>> @@ -162,6 +241,13 @@ static inline struct encoded_va *__page_frag_alloc_probe(struct page_frag_cache
>>     __page;                                \
>> })
>>
>> +/**
>> + * page_frag_alloc_commit - Commit allocing a page fragment.
>> + * @nc: page_frag cache from which to commit
>> + * @fragsz: size of the page fragment has been used
>> + *
>> + * Commit the alloc preparing by passing the actual used size.
> 
> Rephrasing suggestion:
> 
> "Commit the actual used size for the allocation that was either prepared or probed"

Ok.

Thanks.

> 
> 
> Thanks,
> 
> Mat
> 

