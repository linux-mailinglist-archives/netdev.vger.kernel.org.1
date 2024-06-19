Return-Path: <netdev+bounces-104867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A557F90EB84
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A76286F64
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 12:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7B014388C;
	Wed, 19 Jun 2024 12:57:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABE143873;
	Wed, 19 Jun 2024 12:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801878; cv=none; b=OauqgrKsDPjVf9WsFsegmyc20ccrNrK9EwFJdmli9jWogb4q6MIO3IpAm++SB3yPp0KykU/kduDmg7rz88pJhnva8APLqr8BkpYHNcQNViNhg4WTJOGxJ4FsWPwdqFc4+ByI52j+R6ZHnpLrkb5SPY0KtgZ3sDSgVtvNlWygKP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801878; c=relaxed/simple;
	bh=uk5hm7TKh2yMcxEW5i9dKkR0mT9ncyfCEXcuyrUdsK0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=aFGekEmBjgQ8EI9Qkc6xKIoifvV2tBIQN04xpQVfaNTsxkahxtoawG/cl6L5b2UbnS8z10BZaTWje1r/UbsKjtubq7lhcUK/fuvCWEG5NzH0TweSNMRcfV8oCmBhhOaC0rsfYfvExicgpFqa3ugrempi7F630BCQz4ib6iLsvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4W43TF3QhQz1M8v2;
	Wed, 19 Jun 2024 20:53:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 79F9118007A;
	Wed, 19 Jun 2024 20:57:52 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 19 Jun
 2024 20:57:52 +0800
Subject: Re: [PATCH net-next v7 01/15] mm: page_frag: add a test module for
 page_frag
To: wang wei <a929244872@163.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
References: <20240607123819.40694-1-linyunsheng@huawei.com>
 <20240607123819.40694-2-linyunsheng@huawei.com>
 <45a90c2.baa1.1902bcfd33a.Coremail.a929244872@163.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <a0396334-e9fa-9ceb-5d6e-7bf798ed545a@huawei.com>
Date: Wed, 19 Jun 2024 20:57:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <45a90c2.baa1.1902bcfd33a.Coremail.a929244872@163.com>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/6/18 22:45, wang wei wrote:
> 
>>+
>>+static struct objpool_head ptr_pool;
>>+static int nr_objs = 512;
>>+static atomic_t nthreads;
>>+static struct completion wait;
>>+static struct page_frag_cache test_frag;
>>+
>>+static int nr_test = 5120000;
>>+module_param(nr_test, int, 0600);
> 
> 
> "S_IRUSR | S_IWUSR" is better than "0600".

Yes, it is better.
But as we do the testing in module init, it seems we could just
use module_param(nr_test, int, 0) instead.

> 
> 
>>+MODULE_PARM_DESC(nr_test, "number of iterations to test");
>>+
>>+static bool test_align;
>>+module_param(test_align, bool, 0600);
>>+MODULE_PARM_DESC(test_align, "use align API for testing");
>>+
>>+static int test_alloc_len = 2048;
>>+module_param(test_alloc_len, int, 0600);
>>+MODULE_PARM_DESC(test_alloc_len, "alloc len for testing");
>>+
>>+static int test_push_cpu;
>>+module_param(test_push_cpu, int, 0600);
>>+MODULE_PARM_DESC(test_push_cpu, "test cpu for pushing fragment");
>>+
>>+static int test_pop_cpu;
>>+module_param(test_pop_cpu, int, 0600);
>>+MODULE_PARM_DESC(test_pop_cpu, "test cpu for popping fragment");
>>+
>>+static int page_frag_pop_thread(void *arg)
>>+{
>>+	struct objpool_head *pool = arg;
>>+	int nr = nr_test;
>>+
>>+	pr_info("page_frag pop test thread begins on cpu %d\n",
>>+		smp_processor_id());
>>+
>>+	while (nr > 0) {
>>+		void *obj = objpool_pop(pool);
>>+
>>+		if (obj) {
>>+			nr--;
>>+			page_frag_free(obj);
>>+		} else {
>>+			cond_resched();
>>+		}
>>+	}
>>+
>>+	if (atomic_dec_and_test(&nthreads))
>>+		complete(&wait);
>>+
>>+	pr_info("page_frag pop test thread exits on cpu %d\n",
>>+		smp_processor_id());
>>+
>>+	return 0;
>>+}
>>+
>>+static int page_frag_push_thread(void *arg)
>>+{
>>+	struct objpool_head *pool = arg;
>>+	int nr = nr_test;
>>+
>>+	pr_info("page_frag push test thread begins on cpu %d\n",
>>+		smp_processor_id());
>>+
>>+	while (nr > 0) {
>>+		void *va;
>>+		int ret;
>>+
>>+		if (test_align)
>>+			va = page_frag_alloc_align(&test_frag, test_alloc_len,
>>+ GFP_KERNEL, SMP_CACHE_BYTES);
> 
> 
> Every page fragment max size is PAGE_FRAG_CACHE_MAX_SIZE, hence the value of test_alloc_len needs to be checked.
> 

yes, that needs to be checked.
limit the test_alloc_len to PGAE_SIZE seems better, as we may fail back to
order 0 page.

> 


