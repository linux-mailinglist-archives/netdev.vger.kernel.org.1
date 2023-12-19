Return-Path: <netdev+bounces-58750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DD817F68
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 02:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823631F25B26
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C71381;
	Tue, 19 Dec 2023 01:45:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BD2137C;
	Tue, 19 Dec 2023 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SvKD211V6z1FF8x;
	Tue, 19 Dec 2023 09:41:22 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 609E11404D8;
	Tue, 19 Dec 2023 09:45:04 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Dec 2023 09:45:03 +0800
Message-ID: <5fa71441-a3c0-46ee-802d-5b08492f4e8f@huawei.com>
Date: Tue, 19 Dec 2023 09:45:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <lanhao@huawei.com>,
	<wangpeiyang1@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 net-next 4/4] net: hns3: move constants from
 hclge_debugfs.h to hclge_debugfs.c
To: Simon Horman <horms@kernel.org>
References: <20231216070018.222798-1-shaojijie@huawei.com>
 <20231216070018.222798-5-shaojijie@huawei.com>
 <20231218153533.GE6288@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231218153533.GE6288@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2023/12/18 23:35, Simon Horman wrote:
> On Sat, Dec 16, 2023 at 03:00:18PM +0800, Jijie Shao wrote:
>> some constants are defined in hclge_debugfs.h,
>> but only used in hclge_debugfs.c.
>> so move them from hclge_debugfs.h to hclge_debugfs.c.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Thanks Jijie,
>
> this looks good, but I think it should come before patch 2/4,
> to avoid warnings about unused symbols being flagged until this patch is
> applied.
>
> ...

Thanks for your suggestion, this will be fixed in v4.


