Return-Path: <netdev+bounces-56367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87F80E9A5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 12:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1140C28154C
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C495CD29;
	Tue, 12 Dec 2023 11:09:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E9A0;
	Tue, 12 Dec 2023 03:09:21 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SqG8R64l7zWjbg;
	Tue, 12 Dec 2023 19:09:11 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 75C451800D0;
	Tue, 12 Dec 2023 19:09:19 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Dec 2023 19:09:18 +0800
Message-ID: <c2d1a759-7cab-410b-ad9a-71ef3031ba2c@huawei.com>
Date: Tue, 12 Dec 2023 19:09:17 +0800
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
	<linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, Ido Schimmel
	<idosch@nvidia.com>
Subject: Re: [PATCH net-next 5/6] net: hns3: Add support for some CMIS
 transceiver modules
To: Jakub Kicinski <kuba@kernel.org>
References: <20231211020816.69434-1-shaojijie@huawei.com>
 <20231211020816.69434-6-shaojijie@huawei.com>
 <20231211192122.14da98f0@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20231211192122.14da98f0@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2023/12/12 11:21, Jakub Kicinski wrote:
> On Mon, 11 Dec 2023 10:08:15 +0800 Jijie Shao wrote:
>> Add two more SFF-8024 Identifier Values that according to the standard
>> support the Common Management Interface Specification (CMIS) memory map
>> so the hns3 driver will be able to dump, parse and print their EEPROM
>> contents.This two SFF-8024 Identifier Values are SFF8024_ID_QSFP_DD (0x18)
>> and SFF8024_ID_QSFP_PLUS_CMIS (0x1E).
> Hm, you don't implement the ethtool get_module_eeprom_by_page op?
> I thought for QSFP DD page support was basically required.

Yeah, the ethtool op was ignored. And it will be added in v2.


