Return-Path: <netdev+bounces-245154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9790ACC7E22
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7917630EE133
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D877434B438;
	Wed, 17 Dec 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HQD4OCao"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658D33F8A3;
	Wed, 17 Dec 2025 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765977501; cv=none; b=a4+IXfCg5wWaS7LUqnZkLn6RZLWjuLfZayOUET/OBfXGYbtJB5srCDdMevL1JXnz+wdPpwcm/yDAQDC9DTG6k7YHUiP2emAZZYMM2rLjb9eerlWMbVQ1YMtSHq6OLRnjTvxF7XywD54bhN/Qmls4pkDgfBFezV+lAmglxqZehbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765977501; c=relaxed/simple;
	bh=e9htGRrLBo4DxHi/oc04WYleYBmnNxCjseFyJu1jFl8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KpQVH0+nL7vx8OiAZXX4k6PFHIRpiCgkcbDrQ1SGhWj5Q77v1fadg5XMfPIlEBwPamjDQ8vaEgN8xENKSlnKuppe/xezl97Mx93VJZ4Nh2fYia/gTO0RacOKc5BkQuJKzIeQ/CxJwxOTLWff9UTekU1a1S7oJGDVsGtga1udJAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HQD4OCao; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fT/EAGBJmoZExPyaBUMC4XGpOtO/rqpDZTWhkNmpGnE=;
	b=HQD4OCaoWOF4qRvMP2KYyh9+VP52s27rsCTgjZjQblf2n6gtctafcwamYH+Fvpt4FSIOMvN8Q
	m39yLgLVnv+9Qjwi3f3dffjnMGbQA0R40YpyMHg19aGLE923dQbozS0/yfGKfs4RKgZ2K4sXzTS
	p01GpU8miXslI6MBH7bhWLw=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dWZ615SyqzLlTs;
	Wed, 17 Dec 2025 21:15:05 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D1036140109;
	Wed, 17 Dec 2025 21:18:07 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 21:18:06 +0800
Message-ID: <b4afb7ea-28f6-4a0a-8c17-277c6a043bea@huawei.com>
Date: Wed, 17 Dec 2025 21:18:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <salil.mehta@huawei.com>, <shiyongbang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 1/6] net: phy: change of_phy_leds() to
 fwnode_phy_leds()
To: Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-2-shaojijie@huawei.com>
 <20251217103701.000066f8@huawei.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20251217103701.000066f8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/17 18:37, Jonathan Cameron wrote:
> On Mon, 15 Dec 2025 20:57:00 +0800
> Jijie Shao <shaojijie@huawei.com> wrote:
>
>> Change of_phy_leds() to fwnode_phy_leds(), to support
>> of node, acpi node, and software node together.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> One minor suggestion inline. It is a 'while you are here'
> and whilst there are uses of the _scoped loops
> in drivers/net I'm not sure how much appetite there is
> for using them wider.
>
> Jonathan
>
>
>> ---
>>   drivers/net/phy/phy_device.c | 37 +++++++++++++++++-------------------
>>   1 file changed, 17 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 8
>> -
>> -	if (!node)
>> +	if (!fwnode)
>>   		return 0;
>>   
>> -	leds = of_get_child_by_name(node, "leds");
>> +	leds = fwnode_get_named_child_node(fwnode, "leds");
>>   	if (!leds)
>>   		return 0;
>>   
>> @@ -3311,17 +3308,17 @@ static int of_phy_leds(struct phy_device *phydev)
>>   		goto exit;
>>   	}
>>   
>> -	for_each_available_child_of_node_scoped(leds, led) {
>> -		err = of_phy_led(phydev, led);
>> +	fwnode_for_each_available_child_node(leds, led) {
> Maybe use the _scoped version to simplify this a little given
> you are changing it.


Yes, it is indeed necessary to use fwnode_for_each_available_child_node_scoped()

Thanks,
Jijie Shao



