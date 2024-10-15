Return-Path: <netdev+bounces-135594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F38C699E4D6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831B0B22A24
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF421E764A;
	Tue, 15 Oct 2024 10:58:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D421E490B;
	Tue, 15 Oct 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989926; cv=none; b=bcHMqDAARinrov7KhI/MEH6okBtFKGAYRapbaxnzG9HyN2ePZTmylefVWlPwgEdnzBf8DZ/AZbE4I+OU7anF8LVLRqazfvIAKA20G+Uh7MIax0Y3qW46y+Nb4rL4hoYZOMqeQheiWADnBeXPiFx1/iMjXxGIwGXdMPHG05RKlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989926; c=relaxed/simple;
	bh=zMHsowq5udoENrH4VBjjEDVjw8UknD0mJVneCrtHFs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rbC+OIZqJ635vjuoIIKeE8fso20PF/USSuuvpFWmgvmGBlsBAkdWLch82IoIKtRi8geTqhWPLcQ+u2EhLOOsOkuAb5cyOwO+jXUA8qFT5O/47DGhecgykxEbNc96StwOvMug5sIcWCQOJYplK4mOBxP5kdPIJKrdOh3I0mcFAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XSWJY5zD0zySdf;
	Tue, 15 Oct 2024 18:57:17 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A66D1180AE9;
	Tue, 15 Oct 2024 18:58:40 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Oct 2024 18:58:40 +0800
Message-ID: <d814c044-8a0d-48fd-9fc1-06aa457c46c6@huawei.com>
Date: Tue, 15 Oct 2024 18:58:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v21 13/14] mm: page_frag: update documentation
 for page_frag
To: Bagas Sanjaya <bagasdotme@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: Linux Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>, Linux Documentation
	<linux-doc@vger.kernel.org>
References: <20241012112320.2503906-1-linyunsheng@huawei.com>
 <20241012112320.2503906-14-linyunsheng@huawei.com>
 <Zw37nCqT4RY1udAK@archie.me>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <Zw37nCqT4RY1udAK@archie.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/15 13:20, Bagas Sanjaya wrote:

...

>>  
>> +/**
>> + * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
>> + * @nc: page_frag cache from which to check
>> + *
>> + * Used to check if the current page in page_frag cache is pfmemalloc'ed.
>                                                            is allocated by pfmemalloc()?

There seems to be no pfmemalloc() function.

Perhaps change it to something like below as the comment in
page_is_pfmemalloc():
Used to check if the current page in page_frag cache is allocated from the
pfmemalloc reserves.


>> + * It has the same calling context expectation as the alloc API.
>> + *
>> + * Return:
>> + * true if the current page in page_frag cache is pfmemalloc'ed, otherwise
>> + * return false.
>> + */
>>  static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
>>  {
>>  	return encoded_page_decode_pfmemalloc(nc->encoded_page);
>>  }
>>  
>> +/**
>> + * page_frag_cache_page_offset() - Return the current page fragment's offset.
>> + * @nc: page_frag cache from which to check
>> + *
>> + * The API is only used in net/sched/em_meta.c for historical reason, do not use
>> + * it for new caller unless there is a strong reason.
> 
> Then what does page_frag_cache_page_offset() do then?

It is used to replace the the below direct access of 'page_frag_cache':
https://elixir.bootlin.com/linux/v6.11/source/net/sched/em_meta.c#L585

Each one of 'page_frag_cache' instance has its own allocation context
to ensure lockless access, it is not encouraged to access 'page_frag_cache'
directly outside of the allocation context as the accessing is unreliable.

