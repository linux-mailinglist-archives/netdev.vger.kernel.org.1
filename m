Return-Path: <netdev+bounces-99330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804AC8D483A
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E1A1F224F1
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01C6F315;
	Thu, 30 May 2024 09:17:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C07183999;
	Thu, 30 May 2024 09:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060649; cv=none; b=Y4HKiSr7lNbV8xcsYwsSKaYnZKCYhVcWveJQNatOjTLQ0gzUxukSfaYKA1g2Wzm6UzdzE4gEf+WRB3zFWdlpgzEWpcphiNniYPrUVg6GSsO8Ld/iupVgO3OdWc3hMPg7QC9E07konZRUwocYP/1JqPYU8KpCeJ9S5oq+btJNHcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060649; c=relaxed/simple;
	bh=VbCuYWnDuuZtszV0CuVZ+7Q7O7FJs/brfDVK4kQKl6c=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=D8cMJBaaguf+w/Zu8O2x29BtV5zP3+4IVmZrwbOeUFo1Uvr4bBHLDSGPJxwlnoPvKs9FLzV7fOZYtuYAf2sanLq/evrJxh/P/7AV8NraQVrzKkW+yJgPf7QJqOVMn+hAO8Gd5fMr4bXEh1gbyuwB06WFYy9pSkczox6+QcwvBqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VqgXZ0cLqzxR9d;
	Thu, 30 May 2024 17:13:34 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 3905614037E;
	Thu, 30 May 2024 17:17:24 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 30 May
 2024 17:17:18 +0800
Subject: Re: [PATCH net-next v5 01/13] mm: page_frag: add a test module for
 page_frag
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
References: <20240528125604.63048-1-linyunsheng@huawei.com>
 <20240528125604.63048-2-linyunsheng@huawei.com>
 <20240529172938.3a83784d@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <1cba403b-a2c7-5706-78b7-91ccc6caa53b@huawei.com>
Date: Thu, 30 May 2024 17:17:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240529172938.3a83784d@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2024/5/30 8:29, Jakub Kicinski wrote:
> On Tue, 28 May 2024 20:55:51 +0800 Yunsheng Lin wrote:
>> Basing on the lib/objpool.c, change it to something like a
>> ptrpool, so that we can utilize that to test the correctness
>> and performance of the page_frag.
>>
>> The testing is done by ensuring that the fragments allocated
>> from a frag_frag_cache instance is pushed into a ptrpool
>> instance in a kthread binded to a specified cpu, and a kthread
>> binded to a specified cpu will pop the fragmemt from the
> 
> fragment
> 
>> ptrpool and free the fragmemt.
>>
>> We may refactor out the common part between objpool and ptrpool
>> if this ptrpool thing turns out to be helpful for other place.
> 
> Is this test actually meaningfully testing page_frag or rather
> the objpool construct and the scheduler? :S

For the objpool part, I guess it is ok to say that it is a
meaningfully testing for both page_frag and objpool if there is
changing to either of them.

For the scheduler part, this test provides the below module param
to avoid the the noise from scheduler.

+static int test_push_cpu;
+module_param(test_push_cpu, int, 0600);
+MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
+
+static int test_pop_cpu;
+module_param(test_pop_cpu, int, 0600);
+MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");

Or is there any better idea for testing page_frag?

Thanks for taking a look.

> 
> .
> 

