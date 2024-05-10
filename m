Return-Path: <netdev+bounces-95374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C9B8C2143
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB981C20AF3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CEF1635BC;
	Fri, 10 May 2024 09:48:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1AC80BF8;
	Fri, 10 May 2024 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715334529; cv=none; b=FhvmMITKov2jrjlRSli1rl1LIcsVFVi25AlHv28laklhxcC093q9kVwcgx2jxERlrqXoGWRLKYEy0EVChKlg9BHISVl8ITYJAAANHHEffKMwUBSZVBqOWG/LgcHampdq1o6DlJ5K7cb8FA7n/wDPyGHjAYXrjMvjfcXj2S5ysiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715334529; c=relaxed/simple;
	bh=Xil9cHz9oqs+92T/ENlvQu/A3K8EA3wr2TLDeo2amOE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rBQULUQdGitjZo/z+zbzokbmI18ISI/qy2fzm4Ds9j1hDtXNGhkOtsFkytFyNzlN9VKdBzZlYcaKrSqiMlm0wvqWzn+ibMUsEVTABVbGVUzPdGUl+N6ISz0uCFC9lusfIsiaoVoGJiEZBAQb8JSxw/vkcCrMcoADm3240tfmGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VbP9s42bYzfbh9;
	Fri, 10 May 2024 17:44:49 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 445551400E3;
	Fri, 10 May 2024 17:48:43 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 10 May
 2024 17:48:43 +0800
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
Message-ID: <28447d18-dc61-3652-f572-617e718c8bd5@huawei.com>
Date: Fri, 10 May 2024 17:48:42 +0800
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
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/5/9 8:44, Randy Dunlap wrote:
> 
> 
> On 5/8/24 6:34 AM, Yunsheng Lin wrote:
>> Update documentation about design, implementation and API usages
>> for page_frag.
>>
>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>> ---
>>  Documentation/mm/page_frags.rst | 156 +++++++++++++++++++++++++++++++-
>>  include/linux/page_frag_cache.h |  96 ++++++++++++++++++++
>>  mm/page_frag_cache.c            |  65 ++++++++++++-
>>  3 files changed, 314 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
>> index 503ca6cdb804..9c25c0fd81f0 100644
>> --- a/Documentation/mm/page_frags.rst
>> +++ b/Documentation/mm/page_frags.rst
>> @@ -1,3 +1,5 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>>  ==============
>>  Page fragments
>>  ==============
>> @@ -40,4 +42,156 @@ page via a single call.  The advantage to doing this is that it allows for
>>  cleaning up the multiple references that were added to a page in order to
>>  avoid calling get_page per allocation.
>>  
>> -Alexander Duyck, Nov 29, 2016.
>> +
>> +Architecture overview
>> +=====================
>> +
>> +.. code-block:: none
>> +
>> +                +----------------------+
>> +                | page_frag API caller |
>> +                +----------------------+
>> +                            ^
>> +                            |
>> +                            |
>> +                            |
>> +                            v
>> +    +------------------------------------------------+
>> +    |             request page fragment              |
>> +    +------------------------------------------------+
>> +        ^                      ^                   ^
>> +        |                      | Cache not enough  |
>> +        | Cache empty          v                   |
>> +        |             +-----------------+          |
>> +        |             | drain old cache |          |
>> +        |             +-----------------+          |
>> +        |                      ^                   |
>> +        |                      |                   |
>> +        v                      v                   |
>> +    +----------------------------------+           |
>> +    |  refill cache with order 3 page  |           |
>> +    +----------------------------------+           |
>> +     ^                  ^                          |
>> +     |                  |                          |
>> +     |                  | Refill failed            |
>> +     |                  |                          | Cache is enough
>> +     |                  |                          |
>> +     |                  v                          |
>> +     |    +----------------------------------+     |
>> +     |    |  refill cache with order 0 page  |     |
>> +     |    +----------------------------------+     |
>> +     |                       ^                     |
>> +     | Refill succeed        |                     |
>> +     |                       | Refill succeed      |
>> +     |                       |                     |
>> +     v                       v                     v
>> +    +------------------------------------------------+
>> +    |         allocate fragment from cache           |
>> +    +------------------------------------------------+
>> +
>> +API interface
>> +=============
>> +As the design and implementation of page_frag API implies, the allocation side
>> +does not allow concurrent calling. Instead it is assumed that the caller must
>> +ensure there is not concurrent alloc calling to the same page_frag_cache
>> +instance by using its own lock or rely on some lockless guarantee like NAPI
>> +softirq.
>> +
>> +Depending on different aligning requirement, the page_frag API caller may call
>> +page_frag_alloc*_align*() to ensure the returned virtual address or offset of
>> +the page is aligned according to the 'align/alignment' parameter. Note the size
>> +of the allocated fragment is not aligned, the caller need to provide a aligned
> 
>                                                         needs to provide an aligned
> 
>> +fragsz if there is a alignment requirement for the size of the fragment.
> 
>                       an alignment

Will update them accordingly, thanks for the review.

