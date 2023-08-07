Return-Path: <netdev+bounces-24729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555BC7717A0
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 03:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C4D1C2090E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C13238E;
	Mon,  7 Aug 2023 01:01:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A919D
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 01:01:52 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328B6170D
	for <netdev@vger.kernel.org>; Sun,  6 Aug 2023 18:01:51 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RJyd15Z8lz1Z1X8;
	Mon,  7 Aug 2023 08:59:01 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 09:01:48 +0800
Message-ID: <e341abc3-fb99-862b-62fa-d671a35eb9c9@huawei.com>
Date: Mon, 7 Aug 2023 09:01:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] team: remove unreferenced header in
 activebackup/broadcast/roundrobin files
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <jiri@resnulli.us>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230804113035.1698118-1-shaozhengchao@huawei.com>
 <ZM43D2GuL7lU0k4X@vergenet.net>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZM43D2GuL7lU0k4X@vergenet.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/5 19:48, Simon Horman wrote:
> On Fri, Aug 04, 2023 at 07:30:35PM +0800, Zhengchao Shao wrote:
>> Because linux/errno.h is unreferenced in activebackup/broadcast/roundrobin
>> files, so remove it.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/net/team/team_mode_activebackup.c | 1 -
>>   drivers/net/team/team_mode_broadcast.c    | 1 -
>>   drivers/net/team/team_mode_roundrobin.c   | 1 -
>>   3 files changed, 3 deletions(-)
>>
>> diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
>> index e0f599e2a51d..419b9083515e 100644
>> --- a/drivers/net/team/team_mode_activebackup.c
>> +++ b/drivers/net/team/team_mode_activebackup.c
>> @@ -8,7 +8,6 @@
>>   #include <linux/types.h>
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>> -#include <linux/errno.h>
>>   #include <linux/netdevice.h>
>>   #include <net/rtnetlink.h>
>>   #include <linux/if_team.h>
> 
> Hi Zhengchao Shao,
> 
> Removing the inclusion of errno.h from team_mode_activebackup.c doesn't
> seem right to me, ENOENT is used in that file.
> 
> The other two below seem fine to me.
> 
Hi Simon:
	Thank you for your review. You are right here and I will send V2.

Zhengchao Shao
>> diff --git a/drivers/net/team/team_mode_broadcast.c b/drivers/net/team/team_mode_broadcast.c
>> index 313a3e2d68bf..61d7d79f0c36 100644
>> --- a/drivers/net/team/team_mode_broadcast.c
>> +++ b/drivers/net/team/team_mode_broadcast.c
>> @@ -8,7 +8,6 @@
>>   #include <linux/types.h>
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>> -#include <linux/errno.h>
>>   #include <linux/netdevice.h>
>>   #include <linux/if_team.h>
>>   
>> diff --git a/drivers/net/team/team_mode_roundrobin.c b/drivers/net/team/team_mode_roundrobin.c
>> index 3ec63de97ae3..dd405d82c6ac 100644
>> --- a/drivers/net/team/team_mode_roundrobin.c
>> +++ b/drivers/net/team/team_mode_roundrobin.c
>> @@ -8,7 +8,6 @@
>>   #include <linux/types.h>
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>> -#include <linux/errno.h>
>>   #include <linux/netdevice.h>
>>   #include <linux/if_team.h>
> 

