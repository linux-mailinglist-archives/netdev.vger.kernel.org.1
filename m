Return-Path: <netdev+bounces-220573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0ECB46A42
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 10:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBFB1B210AF
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FCD272E7E;
	Sat,  6 Sep 2025 08:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XeollWZr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com [220.197.32.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DB736B;
	Sat,  6 Sep 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757148546; cv=none; b=lZYbXnC7u9OHSGqXJ0ODdGU2kTMUTAkO1F0hhiLpMazVHknCcAzkmJPlNoYgm7xsKtz0X7dkfmDCRMjVHR7vPwXhcO5OguojZyycJ8fwMKu1Vxynfhf0d9HGnMqCC/TvZFXreOg0Q15+GOcC2oOkXelEOm3cRn+G5LpkLsI60ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757148546; c=relaxed/simple;
	bh=KQSgrx87mA7b5NmZQfBcbr/+bLWuPewIo/h3wQhzTYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r9aMX4socstzJYfnah4wTlJhz6WQh6ZAG37NyXrLSKNDSLHbyivvqU3PhY7UGntdrt9ohfCfNAdvU09DOVc9zdBQ2y0uoyJDvrUNLEYK8I1X61trmu2F6yK54KT1py0lK5hACr6p6PtQbsfGeGEak4tydptMZTtLqgsFKCFxico=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XeollWZr; arc=none smtp.client-ip=220.197.32.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.153] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 21e46c877;
	Sat, 6 Sep 2025 14:26:31 +0800 (GMT+08:00)
Message-ID: <5d691f5b-460e-46cb-9658-9c391058342f@rock-chips.com>
Date: Sat, 6 Sep 2025 14:26:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: dwmac-rk: Ensure clk_phy doesn't contain
 invalid address
To: Yao Zi <ziyao@disroot.org>, "Russell King (Oracle)"
 <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonas Karlman <jonas@kwiboo.se>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20250904031222.40953-3-ziyao@disroot.org>
 <aLlwv3v8ACha8b-3@shell.armlinux.org.uk>
 <b5fbeb3f-9962-444d-85b3-3b8a11f69266@rock-chips.com>
 <aLlyb6WvoBiBfUx3@shell.armlinux.org.uk>
 <aLly7lJ05xQjqCWn@shell.armlinux.org.uk> <aLvIbPfWWNa6TwNv@pie>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <aLvIbPfWWNa6TwNv@pie>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a991db47afa03abkunm6f5b97526997b6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGRlJTVZKTxpPTU4fTB1JQ05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XeollWZr90ZLf9L7AdJ3LQbsRm2o9/RlO6fnKUc1fCiUZVidPuq4AywnynalP0/pupRK5Fn/V141DZqMKg6Or8cwAa9y0ysjWi/3FI7BGU/AW4bcdOEc5Y30uM5F1jnwWVDYZe3IbI/KYC9P81XZ7KUdvA0qDfkfDWwVrYpGR48=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=iAEkg+oPP2b/JZz9myImwCnXMGQd4xA94/pfnmR4uF0=;
	h=date:mime-version:subject:message-id:from;

On 9/6/2025 1:36 PM, Yao Zi wrote:

> On Thu, Sep 04, 2025 at 12:07:26PM +0100, Russell King (Oracle) wrote:
>> On Thu, Sep 04, 2025 at 12:05:19PM +0100, Russell King (Oracle) wrote:
>>> On Thu, Sep 04, 2025 at 07:03:10PM +0800, Chaoyi Chen wrote:
>>>> On 9/4/2025 6:58 PM, Russell King (Oracle) wrote:
>>>>> On Thu, Sep 04, 2025 at 03:12:24AM +0000, Yao Zi wrote:
>>>>>>    	if (plat->phy_node) {
>>>>>>    		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>>>>>>    		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>>>>>> -		/* If it is not integrated_phy, clk_phy is optional */
>>>>>> +		/*
>>>>>> +		 * If it is not integrated_phy, clk_phy is optional. But we must
>>>>>> +		 * set bsp_priv->clk_phy to NULL if clk_phy isn't proivded, or
>>>>>> +		 * the error code could be wrongly taken as an invalid pointer.
>>>>>> +		 */
>>>>> I'm concerned by this. This code is getting the first clock from the DT
>>>>> description of the PHY. We don't know what type of PHY it is, or what
>>>>> the DT description of that PHY might suggest that the first clock would
>>>>> be.
>>>>>
>>>>> However, we're geting it and setting it to 50MHz. What if the clock is
>>>>> not what we think it is?
>>>> We only set integrated_phy to 50M, which are all known targets. For external PHYs, we do not perform frequency settings.
>>> Same question concerning enabling and disabling another device's clock
>>> that the other device should be handling.
>> Let me be absolutely clear: I consider *everything* that is going on
>> with clk_phy here to be a dirty hack.
>>
>> Resources used by a device that has its own driver should be managed
>> by _that_ driver alone, not by some other random driver.
> Agree on this. Should we drop the patch, or fix it up for now to at
> least prevent the oops? Chaoyi, I guess there's no user of the feature
> for now, is it?

This at least needs fixing. Sorry, I have no idea how to implement this in the PHY.


