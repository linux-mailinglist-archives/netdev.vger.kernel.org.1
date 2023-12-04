Return-Path: <netdev+bounces-53511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69339803723
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EAA280EB5
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A4C1799E;
	Mon,  4 Dec 2023 14:41:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4459ED7;
	Mon,  4 Dec 2023 06:41:54 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SkR8V5xhxzShbk;
	Mon,  4 Dec 2023 22:37:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:41:51 +0800
Message-ID: <0d0e0fc4-ff7c-4e54-8fe6-2a5754cf7910@huawei.com>
Date: Mon, 4 Dec 2023 22:41:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net 1/2] net: hns: fix wrong head when modify the tx
 feature when sending packets
To: Wojciech Drewek <wojciech.drewek@intel.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20231204011051.4055031-1-shaojijie@huawei.com>
 <20231204011051.4055031-2-shaojijie@huawei.com>
 <5db8b856-27fe-41df-82df-774a3ec312a7@intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <5db8b856-27fe-41df-82df-774a3ec312a7@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected


on 2023/12/4 18:15, Wojciech Drewek wrote:
>
> On 04.12.2023 02:10, Jijie Shao wrote:
>> From: Yonglong Liu <liuyonglong@huawei.com>
>>
>> When modify the tx feature, the hns driver will modify the
> Upon changing the...
>
>> maybe_stop_tx() and fill_desc() functions, if the modify happens
>> during packet sending, will cause the hardware and software
>> pointers do not match, and the port can not work anymore.
>>
>> This patch deletes the maybe_stop_tx() and fill_desc() functions
>> modification when setting tx feature, and use the skb_is_gro()
>> to determine use tso functions or non-tso functions when packets
>> sending.
> and use the skb_is_gro() to determine which functions to use in the tx path.
>> Fixes: 38f616da1c28 ("net:hns: Add support of ethtool TSO set option for Hip06 in HNS")
>> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
> Some commit msg suggestions, other than that:
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>
Thanks，
   commit msg is refined in v3
   Jijie


