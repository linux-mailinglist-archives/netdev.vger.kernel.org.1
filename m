Return-Path: <netdev+bounces-247659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 258C4CFCE99
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41C6430024D7
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F15315777;
	Wed,  7 Jan 2026 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="LRkG+CCZ"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792CA30216D;
	Wed,  7 Jan 2026 09:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778851; cv=none; b=YLRL0B5PuhBm29O292kGlmIj0PadbqK8vk0tlgsj+e5KSkkYZPjHx+Ade7czXBHr0grOYD5V2n+NYrQyUKPe1RyCvxj2tfWr9Jk2Usv9kKVAinCWzryPsIVAieCt+FcEBGd3jHgfFlGiV7/P4RjcfywTteQyixXj6DKg//P0hhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778851; c=relaxed/simple;
	bh=YSi9esBmeYEyRGSCpsJzzuJLcgrfHriDtCZKo1Lrbi8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MQbvucx/nVMaEx/EaIfGrHOVo0mSehTH72abJIb1i1K+QNcgqo5S6errPNmaI2QDmdZ3+XEKbz2MzPOH7QMbdbKAzzOmE8Jj6XtNQxTCxZmpciSonhr5eC82WCEBPQza3/wFsSunBMMCXq/9oZHYGal/L6b5plLSytNVwVA6alE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=LRkG+CCZ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PGby5+iD4Unob2dCk7B6aOiRK3t3aCW/yTkgMFN2Yuk=;
	b=LRkG+CCZK3iga7889Gyxa23VOE5dCf1vZlu8BYqs8E80zWAVYPXwthaEfRnUYN3gBf+Tdvcmi
	dqUKLosG6k02EjC1hhQcVkK5YJrJlehGdDgpnHbgVeQhuXh74qVlLzfA9Wo1yuV7dsD9h6MPfDE
	f9UKkWlw4eB0QhAqHV5lTTM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dmNHF261Nz1prM1;
	Wed,  7 Jan 2026 17:37:29 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A2DC840363;
	Wed,  7 Jan 2026 17:40:46 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 17:40:45 +0800
Message-ID: <e5fb30bf-bf8d-417a-b031-8d706422bee0@huawei.com>
Date: Wed, 7 Jan 2026 17:40:44 +0800
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
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add support to set default
 rules
To: Andrew Lunn <andrew@lunn.ch>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
 <4e884fc2-9f64-48dd-b0be-e9bb6ec0582d@lunn.ch>
 <3c82f4e1-0702-4617-b40c-d7f1cbd5a1de@huawei.com>
 <7d6fd4f6-3cc3-4a42-a726-6cbc4d902cc3@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <7d6fd4f6-3cc3-4a42-a726-6cbc4d902cc3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/18 18:12, Andrew Lunn wrote:
> On Thu, Dec 18, 2025 at 09:35:44AM +0800, Jijie Shao wrote:
>> on 2025/12/17 21:53, Andrew Lunn wrote:
>>>> Some of our boards have only one LED, and we want to indicate both
>>>> link and active(TX and RX) status simultaneously.
>>> Configuration is generally policy, which is normally done in
>>> userspace. I would suggest a udev rule.
>>>
>>> 	Andrew
>> Yes, the PHY LED framework supports configuration from user space,
>> allowing users to configure their preferred policies according to their own requirements.
>> I believe this is the original intention of the LED framework.
>>
>> However, we cannot require users to actively configure policies,
>> nor can we restrict the types of OS versions they use.
>> Therefore, I personally think that the driver should still provide a reasonable default policy
>> to ensure that the LED behavior meets the needs of most scenarios.
> The DT Maintainers are likely to push back if you add this to the DT
> binding. You are not really describing the hardware.
>
> In your case, it is the MAC driver which has access to the
> configuration you want to use. So please think about how you can add
> an API a MAC driver could use. It is not so easy, since the PHY led is
> just a Linux LED. It can be used for anything, any trigger can be
> assigned to it, like the heartbeat, CPU load, disc activity, etc. You
> also need to look at keeping the state synchronised. The netdev
> trigger will read the state of the LED when it is bound to the
> LED. After that, it assumes it is controlling the LED. Any changes
> which go direct to the LED will not be seen by the LED trigger.

Yes, a feasible approach is for the MAC driver to immediately
call `phydriver->led_hw_control_set()` after `phy_probe()` to configure this rule.
At this point, the netdev trigger for the LED has not yet been activated.

When the netdev trigger is activated, it will retrieve the initial state
from `phydriver->yt8521_led_hw_control_get()`, which is the rule we want to configure.

Thanks,
Jijie Shao



