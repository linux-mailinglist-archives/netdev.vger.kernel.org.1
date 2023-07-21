Return-Path: <netdev+bounces-19811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E37C975C6F4
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 14:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98106282271
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6700529AB;
	Fri, 21 Jul 2023 12:36:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F5B390
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 12:36:00 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD971BFC
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 05:35:58 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4R6pt32RDSzrRpJ;
	Fri, 21 Jul 2023 20:35:07 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 20:35:54 +0800
Subject: Re: [RFC PATCH net-next 1/2] net: veth: Page pool creation error
 handling for existing pools only
To: Liang Chen <liangchen.linux@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <hawk@kernel.org>, <ilias.apalodimas@linaro.org>,
	<daniel@iogearbox.net>, <ast@kernel.org>, <netdev@vger.kernel.org>
References: <20230719072907.100948-1-liangchen.linux@gmail.com>
 <dd01d05c-015f-708f-8357-1dd4db15d5de@huawei.com>
 <CAKhg4tJRm4EMgUWca=c7jDuEPeJc2F3SY--oVo4qWRkfO0A=pQ@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <c14e49f1-3ded-1d7b-ef3d-938e8c405926@huawei.com>
Date: Fri, 21 Jul 2023 20:35:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAKhg4tJRm4EMgUWca=c7jDuEPeJc2F3SY--oVo4qWRkfO0A=pQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/21 19:17, Liang Chen wrote:

>> There is NULL checking in page_pool_destroy(),
>> priv->rq[i].page_pool is set to NULL here, and the kcalloc()
>> in veth_alloc_queues() ensure it is NULL initially, maybe it
>> is fine as it is?
>>
> 
> Sure, it doesn't cause any real problem.
> 
> This was meant to align err_page_pool handling with the case above
> (though ptr_ring_cleanup cannot take an uninitialized ring), and it
> doesn't always need to loop from start to end.
> 

I suppose it is for the preparation of the next patch, right?
In that case, maybe make it clear in the commit log.

