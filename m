Return-Path: <netdev+bounces-245267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 259B7CC9FE1
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CD1301B2F2
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA7626059B;
	Thu, 18 Dec 2025 01:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bI+d1Cr+"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B4136349;
	Thu, 18 Dec 2025 01:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021969; cv=none; b=WvVB1RfcrP1ZGK+CQhXDq0LRA2/GED3QYmul39UB/f5QuO5PgZU12W4KIPkfqhxm8+yAgb+dqcaw0WcWSQFHAovGuocgKcGgor1nB61mT21BwqaJ9OLZ2vGx535iIkS02Ms4S6EUBwud3SPOlDBB7vyZot3tYoTzMD0CS0ikf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021969; c=relaxed/simple;
	bh=LHpKZINOAzoMRY1Yhcsk8YumfpkjFssqzQgKvDQwtuc=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DWzlWeSFLjY8Kjd8WpH3OG/z+IrG/ylxAsAAFWZo5EgDgpjjedP+fVR4myYwjTWF4kIInvEPobDSI+Q2aeAV8bzyq/1fuXK9gOopAM1MNPe3YR6CXNq6JmFarPnoV7Sjm2I5lVfR8yfHe4JVk2W7z0FSWSWpOeCOkFDKGiUTnk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bI+d1Cr+; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rtNN3V6iHZLIfY324HvcuK2itKHY9ppnQFfTs7EuSXY=;
	b=bI+d1Cr+ZXG0IpG9cARQyIq7cGNQjxZLW+Sh2iZNJg7SKRsOR43yQa7/I61q/1Mep/cnRpuFA
	x+IwpYYIC89MdiajHHMwLL/eNBN06OdNR6RLCCOmvxLiGIZLTCjGRxBxVugDYXq6UTIrrR9/w0D
	O5dyx+GIouhXmsrMfPUm1sQ=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dWtYK2604zRhRm;
	Thu, 18 Dec 2025 09:36:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B2A5C1402CD;
	Thu, 18 Dec 2025 09:39:24 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 09:39:23 +0800
Message-ID: <c3f80434-ff57-4324-b0f4-3b8b5e03911b@huawei.com>
Date: Thu, 18 Dec 2025 09:39:22 +0800
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
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 6/6] net: phy: motorcomm: fix duplex setting
 error for phy leds
To: Andrew Lunn <andrew@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-7-shaojijie@huawei.com>
 <d8b3a059-d877-4db6-8afb-3023b8ee5fa3@lunn.ch>
 <143514a2-e538-47e2-920c-f223667cb900@huawei.com>
 <0bb9d5a1-e01c-4d7d-b668-3bf81e98447b@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <0bb9d5a1-e01c-4d7d-b668-3bf81e98447b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/17 21:49, Andrew Lunn wrote:
> On Wed, Dec 17, 2025 at 09:05:20PM +0800, Jijie Shao wrote:
>> on 2025/12/16 15:21, Andrew Lunn wrote:
>>> On Mon, Dec 15, 2025 at 08:57:05PM +0800, Jijie Shao wrote:
>>>> fix duplex setting error for phy leds
>>>>
>>>> Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>> Please don't mix new development and fixes in one patchset. Please
>>> base this patch on net, and send it on its own.
>>>
>>> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>>>
>>> Fixes are accepted any time, it does not matter about the merge
>>> window.
>>>
>>> 	Andrew
>> Yes, this is RFC, just for code review.
>> I sent it to net when requesting a merge.
> This is however a real fix. The motorcomm driver is broken. Why wait
> to fix it?
>
> 	Andrew


Alright, this patch shouldn't require an RFC
and has no direct relation to this patch set.

I'll send it directly to net.

Thanks!
Shao Jijie



