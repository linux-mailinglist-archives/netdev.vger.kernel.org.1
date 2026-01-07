Return-Path: <netdev+bounces-247661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D80CFCF9C
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C0430A36E4
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C84E31E0F2;
	Wed,  7 Jan 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="P1snuVUM"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188DE308F23;
	Wed,  7 Jan 2026 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767778995; cv=none; b=LIeB1ol93BlItIC62BpFIug2xjVOikSI/RNR4+xtVVaqCIZtfJrNOPc4kZ5Cnst03ycseFhQ8BFiukArbe8C0zBzNIcMC07o6WuBxfqpAzdbOZHsPbIJDHJqcW1c3VUaEA8q61uYURbPcCMvZFy4Bfdm53+Sp6l1uzewJiV9cyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767778995; c=relaxed/simple;
	bh=LV318xn+Kurhf1Wo89/uufqdn1Tp2VD3weaZx0d3cwE=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MHf0z3P1X/NSnj0Tb0AGGvAnHKCwlWr77at9QSY5y1wmPZzrSyAQeZzwAAE699oh7R+KDMsyTUQ0Pw1w3dxNuXRR68DviDFPTUU6syp0QQKOwQz7ysxiOz5HGzSK9LSOoXoSCdIk47k4DoaUzs/DuEiqkl7Ed3hpSNfUMT0S6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=P1snuVUM; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=LV318xn+Kurhf1Wo89/uufqdn1Tp2VD3weaZx0d3cwE=;
	b=P1snuVUM6DDpCFxwUUzCD6d1TLi4VihNSzEwA6NwXEojTqmDQ2DYn2Y6SLZtpXJ3BfMeTe5tB
	EF0aUxwJtRCHpeX7oMUM2bWGoLIMhmfUMos49RkzPKl0MYiiLbJI6msuVG23TgXQuVUoAnq8ZeI
	dVpfTIdHo8R+XVtyr4vhhQc=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dmNL35B20zLlSr;
	Wed,  7 Jan 2026 17:39:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 73E0C40539;
	Wed,  7 Jan 2026 17:43:10 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 17:43:09 +0800
Message-ID: <2d94db98-9484-438f-8e25-6b836c63ff71@huawei.com>
Date: Wed, 7 Jan 2026 17:43:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, Andrew Lunn <andrew@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<Frank.Sae@motor-comm.com>, <hkallweit1@gmail.com>, <shenjian15@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<shiyongbang@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC net-next 2/6] net: phy: add support to set default
 rules
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
References: <20251215125705.1567527-1-shaojijie@huawei.com>
 <20251215125705.1567527-3-shaojijie@huawei.com>
 <fe22ae64-2a09-45ce-8dbf-a4683745e21c@lunn.ch>
 <647f91c7-72c2-4e9d-a26d-3f1b5ee42b21@huawei.com>
 <aVerWcPPteVKRHv1@shell.armlinux.org.uk>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aVerWcPPteVKRHv1@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/1/2 19:26, Russell King (Oracle) wrote:
> On Wed, Dec 17, 2025 at 08:54:59PM +0800, Jijie Shao wrote:
>> on 2025/12/16 15:09, Andrew Lunn wrote:
>>> On Mon, Dec 15, 2025 at 08:57:01PM +0800, Jijie Shao wrote:
>>>> The node of led need add new property: rules,
>>>> and rules can be set as:
>>>> BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX)
>>> Please could you expand this description. It is not clear to my why it
>>> is needed. OF systems have not needed it so far. What is special about
>>> your hardware?
>> I hope to configure the default rules.
>> Currently, the LED does not configure rules during initialization; it uses the default rules in the PHY registers.
>> I would like to change the default rules during initialization.
> One of the issues here is that there are boards out there where the boot
> loader has configured the PHY LED configuration - and doesn't supply it
> via DT (because PHY LED configuration in the kernel is a new thing.)
>
> Adding default rules for LEDs will break these platforms.
>
> Please find a way to provide the LED rules via firmware rather than
> introducing some kind of rule defaulting.


Actually, in my code, `default_rules` is an optional configuration;
you can choose not to set default rules.

Thanks,
Jijie Shao


