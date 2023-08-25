Return-Path: <netdev+bounces-30624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3EC78841E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 11:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B522816EF
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6947C8EB;
	Fri, 25 Aug 2023 09:57:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3A4C8C4
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 09:57:17 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E9A1FD3;
	Fri, 25 Aug 2023 02:57:16 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RXFdM6g8TztSKq;
	Fri, 25 Aug 2023 17:53:27 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 25 Aug 2023 17:57:13 +0800
Message-ID: <ebe4eca2-9f7d-d084-7d31-114605bf1078@huawei.com>
Date: Fri, 25 Aug 2023 17:57:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next,v2] selftests: bonding: create directly devices
 in the target namespaces
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>, <j.vosburgh@gmail.com>, <andy@greyhouse.net>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230824135715.1131084-1-shaozhengchao@huawei.com>
 <ZOgTxefEAVNPkZ23@Laptop-X1>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZOgTxefEAVNPkZ23@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/25 10:36, Hangbin Liu wrote:
> On Thu, Aug 24, 2023 at 09:57:15PM +0800, Zhengchao Shao wrote:
>> If failed to set link1_1 to netns client, we should delete link1_1 in the
>> cleanup path. But if set link1_1 to netns client successfully, delete
>> link1_1 will report warning. So it will be safer creating directly the
>> devices in the target namespaces.
>>
>> Reported-by: Hangbin Liu <liuhangbin@gmail.com>
>> Closes: https://lore.kernel.org/all/ZNyJx1HtXaUzOkNA@Laptop-X1/
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v2: create directly devices in the target namespaces
>> ---
>>   .../drivers/net/bonding/bond-arp-interval-causes-panic.sh | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
>> index 7b2d421f09cf..fe7c34f89fc7 100755
>> --- a/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
>> +++ b/tools/testing/selftests/drivers/net/bonding/bond-arp-interval-causes-panic.sh
>> @@ -22,14 +22,12 @@ server_ip4=192.168.1.254
>>   echo 180 >/proc/sys/kernel/panic
>>   
>>   # build namespaces
>> -ip link add dev link1_1 type veth peer name link1_2
>> -
>>   ip netns add "server"
>> -ip link set dev link1_2 netns server up name eth0
>> +ip netns add "client"
>> +ip link add dev eth0 netns client type veth peer name eth0 netns server
> 
> When we already have an eth0 interface on init net, this cmd will failed
> 
> # ip link add dev eth0 netns client type veth peer name eth0 netns server
> RTNETLINK answers: File exists
> 
> You should create the eth0 in the namespace, e.g.
> 
> # ip -n client link add eth0 type veth peer name eth0 netns server
> 
> Thanks
> Hangbin
Hi Hangbin:
	Thank you for your testing. I will modify in v3

Zhengchao Shao

