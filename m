Return-Path: <netdev+bounces-30360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 166AB787031
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F134B1C20E3E
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0F428904;
	Thu, 24 Aug 2023 13:25:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC65288E6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:25:41 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354B01BCC;
	Thu, 24 Aug 2023 06:25:39 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RWkLr3tm1zrS9R;
	Thu, 24 Aug 2023 21:24:04 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 24 Aug 2023 21:25:35 +0800
Message-ID: <d1b227e7-0653-da6c-a8b6-0e97121bb847@huawei.com>
Date: Thu, 24 Aug 2023 21:25:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] selftests: bonding: delete link1_1 in the
 cleanup path
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <shuah@kernel.org>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20230823032640.3609934-1-shaozhengchao@huawei.com>
 <c25141405ba52eb0eee96317407376ef68802198.camel@redhat.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <c25141405ba52eb0eee96317407376ef68802198.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/24 18:31, Paolo Abeni wrote:
> On Wed, 2023-08-23 at 11:26 +0800, Zhengchao Shao wrote:
>> If failed to set link1_1 to netns client, we should delete link1_1 in the
>> cleanup path. But if set link1_1 to netns client successfully, delete
>> link1_1 will report warning. So delete link1_1 in the cleanup path and
>> drop any warning message.
> 
> I think the same could happen also for the link1_2 device.
> 
> It would probably be safer creating directly the devices in the target
> namespaces, with the 'final' name
> 
> ip link add dev eth0 netns client type veth peer name eth0 netns server
> 
> Cheers,
> 
> Paolo
> 
Yeah, it looks good, I will send v2.
Thank you.

Zhengchao Shao

