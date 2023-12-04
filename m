Return-Path: <netdev+bounces-53512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5CF803730
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD331C20C0F
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 14:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4823757;
	Mon,  4 Dec 2023 14:43:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E112B3;
	Mon,  4 Dec 2023 06:43:47 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SkRB11PnYz14L99;
	Mon,  4 Dec 2023 22:38:49 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 22:43:45 +0800
Message-ID: <7f9fffe3-2fb8-41a2-9eb0-4adf91566a21@huawei.com>
Date: Mon, 4 Dec 2023 22:43:44 +0800
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
Subject: Re: [PATCH V2 net 2/2] net: hns: fix fake link up on xge port
To: Wojciech Drewek <wojciech.drewek@intel.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
References: <20231204011051.4055031-1-shaojijie@huawei.com>
 <20231204011051.4055031-3-shaojijie@huawei.com>
 <c382dc51-3a3c-4c79-90c0-13e2e716d0a9@intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <c382dc51-3a3c-4c79-90c0-13e2e716d0a9@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected


on 2023/12/4 18:19, Wojciech Drewek wrote:
>
> On 04.12.2023 02:10, Jijie Shao wrote:
>>   
>> +static void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv,
>> +				    u32 *link_status)
>> +{
> It would be cleaner to return the link status than using output arg IMO
>
Yes, it's a good suggestion, and this is modified in v3


