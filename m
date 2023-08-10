Return-Path: <netdev+bounces-26186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7C77721E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:08:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A2F281F4D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A551ADE7;
	Thu, 10 Aug 2023 08:08:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D429A2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:08:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9741703
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:08:31 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RLzx64KKGztSDZ;
	Thu, 10 Aug 2023 16:04:58 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:08:28 +0800
Message-ID: <c9e12861-e0e0-ede0-7d2b-4dc191f90035@huawei.com>
Date: Thu, 10 Aug 2023 16:08:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 3/5] bonding: remove unnecessary NULL check in
 debugfs function
To: Hangbin Liu <liuhangbin@gmail.com>, Jay Vosburgh <j.vosburgh@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andy@greyhouse.net>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-4-shaozhengchao@huawei.com>
 <CAAoacN=Lmh0h_9wQvAe_NRDw_SV22NYA3CN_-uvkOoPs6kQmxg@mail.gmail.com>
 <ZNRUnUV92x1s3Aj0@Laptop-X1>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZNRUnUV92x1s3Aj0@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/10 11:08, Hangbin Liu wrote:
> On Wed, Aug 09, 2023 at 09:13:31AM -0700, Jay Vosburgh wrote:
>> On 8/9/23, Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>>> Because debugfs_create_dir returns ERR_PTR, so bonding_debug_root will
>>> never be NULL. Remove unnecessary NULL check for bonding_debug_root in
>>> debugfs function.
>>
>> So after this change it will call debugfs_create_dir(), et al, with
>> the ERR_PTR value?  Granted, the current behavior is probably not
>> right, but I don't see how this makes things better.
> 
> I guess Zhengchao means to remove Redundant checks? The later
> debugfs_create_dir/debugfs_remove_recursive/debugfs_remove_recursive functions
> will check the dentry with IS_ERR(). But I think the commit description need
> an update.
> 
> Hangbin
> 
Yes, I will update this commit description.

Zhengchao Shao
>>
>> -J
>>
>>>
>>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>>> ---
>>>   drivers/net/bonding/bond_debugfs.c | 9 ---------
>>>   1 file changed, 9 deletions(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_debugfs.c
>>> b/drivers/net/bonding/bond_debugfs.c
>>> index e4e7f4ee48e0..4c83f89c0a47 100644
>>> --- a/drivers/net/bonding/bond_debugfs.c
>>> +++ b/drivers/net/bonding/bond_debugfs.c
>>> @@ -49,9 +49,6 @@ DEFINE_SHOW_ATTRIBUTE(bond_debug_rlb_hash);
>>>
>>>   void bond_debug_register(struct bonding *bond)
>>>   {
>>> -	if (!bonding_debug_root)
>>> -		return;
>>> -
>>>   	bond->debug_dir =
>>>   		debugfs_create_dir(bond->dev->name, bonding_debug_root);
>>>
>>> @@ -61,9 +58,6 @@ void bond_debug_register(struct bonding *bond)
>>>
>>>   void bond_debug_unregister(struct bonding *bond)
>>>   {
>>> -	if (!bonding_debug_root)
>>> -		return;
>>> -
>>>   	debugfs_remove_recursive(bond->debug_dir);
>>>   }
>>>
>>> @@ -71,9 +65,6 @@ void bond_debug_reregister(struct bonding *bond)
>>>   {
>>>   	struct dentry *d;
>>>
>>> -	if (!bonding_debug_root)
>>> -		return;
>>> -
>>>   	d = debugfs_rename(bonding_debug_root, bond->debug_dir,
>>>   			   bonding_debug_root, bond->dev->name);
>>>   	if (!IS_ERR(d)) {
>>> --
>>> 2.34.1
>>>
>>>

