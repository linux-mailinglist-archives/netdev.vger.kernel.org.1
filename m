Return-Path: <netdev+bounces-46563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB4B7E4F82
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 04:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5832E281177
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 03:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3341C11;
	Wed,  8 Nov 2023 03:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4349A1C02
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 03:31:48 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E810F8;
	Tue,  7 Nov 2023 19:31:47 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SQ9W94fPJzMmY9;
	Wed,  8 Nov 2023 11:27:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 8 Nov
 2023 11:31:45 +0800
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20231107123825.61051-1-linyunsheng@huawei.com>
 <20231107094959.556ffe53@kernel.org>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
Date: Wed, 8 Nov 2023 11:31:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231107094959.556ffe53@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/11/8 1:49, Jakub Kicinski wrote:
> On Tue, 7 Nov 2023 20:38:24 +0800 Yunsheng Lin wrote:
>> I have added frag support for page pool, made some improvement
>> for it recently, and reviewed some related patches too.
>>
>> So add myself as reviewer so that future patch will be cc'ed
>> to my email.
> 
> Not sure what to do about this, it feels somewhat wrong to add
> as a reviewer someone who seem to not follow our basic process
> requirements:
> 
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

I reread the above doc in order not to miss anything obvious again:(

I suppose basic process requirements mean:
1. designate your patch to a tree - [PATCH net] or [PATCH net-next]
2. don't repost your patches within one 24h period

For 1, somehow I got the impression that changing to MAINTAINERS
can be targetted to net branch, so that the change can flow to other
main trees quickly, maybe I was wrong?

For 2, yes, maybe I should stick to the rule even if it is a simple
patch and obivous format error.

Please correct me if there is anything else I missed.


> 
> :(
> 
> .
> 

