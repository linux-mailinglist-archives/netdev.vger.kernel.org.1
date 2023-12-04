Return-Path: <netdev+bounces-53359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91248029C8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 02:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883E0280BDF
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 01:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E8C818;
	Mon,  4 Dec 2023 01:20:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D8E7;
	Sun,  3 Dec 2023 17:20:04 -0800 (PST)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Sk5N14z2dz1P93b;
	Mon,  4 Dec 2023 09:16:17 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 09:20:01 +0800
Message-ID: <c10de383-829e-4c24-bf21-0a2cfd0e4cec@huawei.com>
Date: Mon, 4 Dec 2023 09:20:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 2/2] net: hns: fix fake link up on xge port
To: Jakub Kicinski <kuba@kernel.org>
References: <20231201102703.4134592-1-shaojijie@huawei.com>
 <20231201102703.4134592-3-shaojijie@huawei.com>
 <20231201211926.3807dd7f@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231201211926.3807dd7f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected


on 2023/12/2 13:19, Jakub Kicinski wrote:
> On Fri, 1 Dec 2023 18:27:03 +0800 Jijie Shao wrote:
>> +void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
> drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c:69:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>     69 | void hns_mac_link_anti_shake(struct mac_driver *mac_ctrl_drv, u32 *link_status)
>        | ^
>        | static

Thanks,
   v2 patch is sent to fix it.


