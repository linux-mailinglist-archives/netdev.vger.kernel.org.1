Return-Path: <netdev+bounces-120429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC47959521
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBEFBB26521
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B29192584;
	Wed, 21 Aug 2024 06:53:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCE0192580;
	Wed, 21 Aug 2024 06:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724223204; cv=none; b=tDNAQ8FJHkSJAruT3dCiIkfgbVj6f4KxGN4/czI6R90oowiYNM0UumGkUeSOzFx2QwirC4BT0lUWjiYKI2B92m1a5Gb5jHMKuZumniX1X7/QpoPf9wQO4StJqWk4ZiJCgiPLy5Xjs2dUtvdcqR9Pico91hq9lPo/1qVIYBuruNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724223204; c=relaxed/simple;
	bh=fEFQBUjRnr5q9/spUBIqPAEk0j+C1rcG+HWPQS+mfKM=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mqjuRfbthCO7lEKAgeNOwBhEhS7OQdHvBieAPwRyuBUO4OpmZD/4pgA/8QZ32kACBRysMZFWyad/c24XofgVerN9X1kq4jvRhdEpxvAxGLOVviWGrKWkTFwEBQ8/UklIIkDJdIRBxRUJujLV7rKYTiVElqNyJu+5twjugZiRFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WpcQm6cZcz1HGwF;
	Wed, 21 Aug 2024 14:50:08 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id C7ABD1A016C;
	Wed, 21 Aug 2024 14:53:20 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 14:53:19 +0800
Message-ID: <93cacc08-158c-413e-9d4d-dafcfcb57dcd@huawei.com>
Date: Wed, 21 Aug 2024 14:53:18 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>, <andrew@lunn.ch>,
	<jdamato@fastly.com>, <horms@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 net-next 00/11] Add support of HIBMCGE Ethernet Driver
To: Jakub Kicinski <kuba@kernel.org>
References: <20240820140154.137876-1-shaojijie@huawei.com>
 <20240820185533.054901d9@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20240820185533.054901d9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/8/21 9:55, Jakub Kicinski wrote:
> On Tue, 20 Aug 2024 22:01:43 +0800 Jijie Shao wrote:
>> This patch set adds the support of Hisilicon BMC Gigabit Ethernet Driver.
>>
>> This patch set includes basic Rx/Tx functionality. It also includes
>> the registration and interrupt codes.
>>
>> This work provides the initial support to the HIBMCGE and
>> would incrementally add features or enhancements.
>
> Does not build
>
>    ERROR: modpost: "phy_attached_info" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "phy_ethtool_set_link_ksettings" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "phy_connect_direct" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "phy_ethtool_get_link_ksettings" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "phy_start" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "phy_remove_link_mode" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "phy_print_status" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "devm_mdiobus_alloc_size" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "mdiobus_get_phy" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    ERROR: modpost: "__devm_mdiobus_register" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!
>    WARNING: modpost: suppressed 2 unresolved symbol warnings because there were too many)Hi

Hi Jakub:

I can build successfully. Can you tell me your build command?
I think the cause of this problem is that the PHYLIB is not selected in Kconfig.
So I will add "select PHYLIB" in v3

Thanks,

Jijie Shao


