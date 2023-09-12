Return-Path: <netdev+bounces-33035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B779C701
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D11281835
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 06:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CBF154A9;
	Tue, 12 Sep 2023 06:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3FA14F93
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 06:35:43 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F20210DF
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 23:35:42 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RlDLc5CnNz1N7xq;
	Tue, 12 Sep 2023 14:33:44 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 12 Sep 2023 14:35:39 +0800
Message-ID: <51e5fc5b-cea0-aea6-b83f-eafaa90e24c7@huawei.com>
Date: Tue, 12 Sep 2023 14:35:38 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, <chenhao418@huawei.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <lanhao@huawei.com>, <liuyonglong@huawei.com>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<shenjian15@huawei.com>, <wangjie125@huawei.com>, <wangpeiyang1@huawei.com>
Subject: Re: [PATCH RFC net-next 0/7] net: phy: avoid race when erroring
 stopping PHY
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <ZPsDdqt1RrXB+aTO@shell.armlinux.org.uk>
 <ZP7V3jHYgyvnTeuf@shell.armlinux.org.uk>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <ZP7V3jHYgyvnTeuf@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected


on 2023/9/11 16:54, Russell King (Oracle) wrote:
> Hi,
>
> It would be good if Jijie Shao could test these patches and provide a
> tested-by as appropriate.
>
> Thanks.
>
> On Fri, Sep 08, 2023 at 12:20:22PM +0100, Russell King (Oracle) wrote:
>> This series addresses a problem reported by Jijie Shao where the PHY
>> state machine can race with phy_stop() leading to an incorrect state.
>>
Hi Russell,

Sorry for late reply and thanks for your patches. It works in our case.
And it should be noted that our device does not support resuming from
suspend. So the case about suspend was not tested.

Tested-by: Jijie Shao <shaojijie@huawei.com>


