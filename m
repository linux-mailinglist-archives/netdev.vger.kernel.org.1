Return-Path: <netdev+bounces-26185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE96777219
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26AD4281EA9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B71ADEF;
	Thu, 10 Aug 2023 08:06:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8E1ADE5
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:06:31 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479CCF7
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:06:30 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLztl3q74ztS6N;
	Thu, 10 Aug 2023 16:02:55 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:06:25 +0800
Message-ID: <ad91a67e-40af-fcab-8521-7d2174c6c1f4@huawei.com>
Date: Thu, 10 Aug 2023 16:06:24 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 2/5] bonding: remove warning printing in
 bond_create_debugfs
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <j.vosburgh@gmail.com>,
	<andy@greyhouse.net>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-3-shaozhengchao@huawei.com>
 <ZNRRFny6lQmRYd+F@Laptop-X1>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZNRRFny6lQmRYd+F@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/10 10:53, Hangbin Liu wrote:
> On Wed, Aug 09, 2023 at 08:41:04PM +0800, Zhengchao Shao wrote:
>> Because debugfs_create_dir returns ERR_PTR, so warning printing will never
>> be invoked in bond_create_debugfs, remove it. If failed to create
>> directory, failure information will be printed in debugfs_create_dir.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/net/bonding/bond_debugfs.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
>> index 94c2f35e3bfc..e4e7f4ee48e0 100644
>> --- a/drivers/net/bonding/bond_debugfs.c
>> +++ b/drivers/net/bonding/bond_debugfs.c
>> @@ -87,9 +87,6 @@ void bond_debug_reregister(struct bonding *bond)
>>   void __init bond_create_debugfs(void)
>>   {
>>   	bonding_debug_root = debugfs_create_dir("bonding", NULL);
>> -
>> -	if (!bonding_debug_root)
> 
Hi Hangbin:
> debugfs_create_dir() does not print information for all failures. We can use
> IS_ERR(bonding_debug_root) to check the value here.
> 
	Thank you for your review. I think you are right here, and I
will modify it.

Zhengchao Shao
> Thanks
> Hangbin
>> -		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>>   }
>>   
>>   void bond_destroy_debugfs(void)
>> -- 
>> 2.34.1
>>

