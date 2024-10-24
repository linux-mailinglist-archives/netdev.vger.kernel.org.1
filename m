Return-Path: <netdev+bounces-138692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6D79AE8ED
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DBF1C21FB6
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EAB1E631A;
	Thu, 24 Oct 2024 14:31:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5F91E378F;
	Thu, 24 Oct 2024 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780276; cv=none; b=nequAoGev7vSdg99eE3bIFEqlx8kpd/U2JpNRXntQImMO+QD2dmPs1eadX63AbyX8KE0yEWBfkvLxtw710VYGhtNDxnYGhYXkrErKDSocPmpoB7279TlKsTsyKxFOBCKtBTI8qcEVnIjDJE4mfpgHzmZMXF/droOkBiNsFONQRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780276; c=relaxed/simple;
	bh=590vao4BFAZRAZ3Ka/zEyxP3lCoUxJyz14zCjwt6m80=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZZ8xNGA+o67j7LisiEgzJhI5Tv/cVZ2ifIbh+2yZt4xdYIMSKfom7sKBETOzeSXC78PU+nhFUpuU9RGfiiV/qa9xRNuVba1Y+0Is5FC+FqerNqosmn3dZNGxFuXUaxQVTo9hz3UVieXVZ90u9ziZ0n5Qxd1huNRZ0VuTpctLAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZ7Zv4LkvzpX5D;
	Thu, 24 Oct 2024 22:29:11 +0800 (CST)
Received: from kwepemm000007.china.huawei.com (unknown [7.193.23.189])
	by mail.maildlp.com (Postfix) with ESMTPS id 576071402E1;
	Thu, 24 Oct 2024 22:31:08 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 24 Oct 2024 22:31:07 +0800
Message-ID: <d8d8a4d8-b71d-4223-bcb2-933eeb306e42@huawei.com>
Date: Thu, 24 Oct 2024 22:31:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>, <sudongming1@huawei.com>,
	<xujunsheng@huawei.com>, <shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add debugfs supported in this
 module
To: Andrew Lunn <andrew@lunn.ch>
References: <20241023134213.3359092-1-shaojijie@huawei.com>
 <20241023134213.3359092-3-shaojijie@huawei.com>
 <924e9c5c-f4a8-4db5-bbe8-964505191849@lunn.ch>
 <5375ce1b-8778-4696-a530-1a002f7ec4c7@huawei.com>
 <6103ee00-175d-4a35-9081-2c500ad3c123@lunn.ch>
 <0c0de40c-7bf3-4d98-9d25-9b4f36a91e0b@huawei.com>
 <6a231891-7780-4cf4-97d9-679c67e18474@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <6a231891-7780-4cf4-97d9-679c67e18474@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)


on 2024/10/24 22:21, Andrew Lunn wrote:
> On Thu, Oct 24, 2024 at 10:06:14PM +0800, Jijie Shao wrote:
>> on 2024/10/24 20:05, Andrew Lunn wrote:
>>>>>> +	seq_printf(s, "mdio frequency: %u\n", specs->mdio_frequency);
>>>>> Is this interesting? Are you clocking it greater than 2.5MHz?
>>>> MDIO controller supports 1MHz, 2.5MHz, 12.5MHz, and 25MHz
>>>> Of course, we chose and tested 2.5M in actual work, but this can be modified.
>>> How? What API are you using it allow it to be modified? Why cannot you
>>> get the value using the same API?
>> This frequency cannot be modified dynamically.
>> There are some specification registers that store some initialization configuration parameters
>> written by the BMC, such as the default MAC address and hardware FIFO size and mdio frequency.
>>
>> When the device is in prob, the driver reads the related configuration information and
>> initializes the device based on the configuration.
> Does the BMC have an API to set these values? And show these values?
>
> 	Andrew

Currently, there are no other API except devmem.

But this is not important.
According to the discussion in patch "[PATCH net-next 4/7] net: hibmcge: Add register dump supported in this module",
this debugfs file will be deleted. I will put these informations in register dump by ethtool -d.

Thanks



