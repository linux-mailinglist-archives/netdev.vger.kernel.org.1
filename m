Return-Path: <netdev+bounces-247670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E617CFD23D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7093930223E6
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 10:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB66331A5D;
	Wed,  7 Jan 2026 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hAXMnEZy"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B530331A44;
	Wed,  7 Jan 2026 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780768; cv=none; b=D/bq5DpmKCMD6oT9yoRdMQGGUuLYcWHkb9Oh4nSWOBWItDHHQezg6k4vKgt58HOqm4rurz7PsaSRzMIujr9rujuCJVsjS9fzTQEwn7mOUP7dkUxqp3x2dawoRVSiAWYaq7DKsN2zyR3squC/wxNOSJevvnNdCKtPB4zpfgSG6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780768; c=relaxed/simple;
	bh=vlS6qdRyqabvM+tHIJ06XpBFkDb6xR+kCvy8kuew0nU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fuQ5lxdSVGYo8buDEpudZfHonCgdQpEF6vuLI+d7cvwIyt3X75rPNrB3dsl8JIObMrWfJ0tG3XrdjHMiDWE748lXFp6RpVLDxuW+t12kevLXm16pJbL0LdMyK7FCEkbWbvlcr98ZE6zKaSN4aWjtGpdTHPqGwyaAzYOZzEfYlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hAXMnEZy; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=xgGBDdPkyGi0NxdVfTA0d5ZgzYrifSbg+B1MClYQnJ8=;
	b=hAXMnEZyt9rD6dS8UFGFn1fmmuXrXkAYjiAVmm2qzgjIWF4zIaaXfTOtLEQ0RBVS6QgXVCELK
	oZvUQYSAvEQhbqJyKSB3BdAS9pcVdcQ1nO/0AJAh/IiP/xdSrSoDWzsxXax3oSZlorOCU57DF3E
	ObYd96ZuXuRkU6nhMMd92dk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dmP0811bbz1cyTV;
	Wed,  7 Jan 2026 18:09:28 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F8574055B;
	Wed,  7 Jan 2026 18:12:43 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 7 Jan 2026 18:12:42 +0800
Message-ID: <dd88ed18-d348-42ea-ab15-a0f34f3bea3d@huawei.com>
Date: Wed, 7 Jan 2026 18:12:41 +0800
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
 <2d94db98-9484-438f-8e25-6b836c63ff71@huawei.com>
 <aV4sSr79IBIQRj9x@shell.armlinux.org.uk>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aV4sSr79IBIQRj9x@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2026/1/7 17:50, Russell King (Oracle) wrote:
> On Wed, Jan 07, 2026 at 05:43:08PM +0800, Jijie Shao wrote:
>> on 2026/1/2 19:26, Russell King (Oracle) wrote:
>>> On Wed, Dec 17, 2025 at 08:54:59PM +0800, Jijie Shao wrote:
>>>> on 2025/12/16 15:09, Andrew Lunn wrote:
>>>>> On Mon, Dec 15, 2025 at 08:57:01PM +0800, Jijie Shao wrote:
>>>>>> The node of led need add new property: rules,
>>>>>> and rules can be set as:
>>>>>> BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX)
>>>>> Please could you expand this description. It is not clear to my why it
>>>>> is needed. OF systems have not needed it so far. What is special about
>>>>> your hardware?
>>>> I hope to configure the default rules.
>>>> Currently, the LED does not configure rules during initialization; it uses the default rules in the PHY registers.
>>>> I would like to change the default rules during initialization.
>>> One of the issues here is that there are boards out there where the boot
>>> loader has configured the PHY LED configuration - and doesn't supply it
>>> via DT (because PHY LED configuration in the kernel is a new thing.)
>>>
>>> Adding default rules for LEDs will break these platforms.
>>>
>>> Please find a way to provide the LED rules via firmware rather than
>>> introducing some kind of rule defaulting.
>>
>> Actually, in my code, `default_rules` is an optional configuration;
>> you can choose not to set default rules.
> How is that achieved?

I use `fwnode_property_present()` to determine whether the rules exist,
and if they do not exist, I skip the configuration.

+static int fwnode_phy_led_set_rules(struct phy_device *phydev,
+				    struct fwnode_handle *led, u32 index)
+{
+	u32 rules;
+	int err;
+
+	if (!fwnode_property_present(led, "rules"))
+		return 0;

Thanks,
Jijie Shao


