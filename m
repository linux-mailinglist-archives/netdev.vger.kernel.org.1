Return-Path: <netdev+bounces-207769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E465B0880E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 10:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913101A64BA6
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7989A27A445;
	Thu, 17 Jul 2025 08:40:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C92749EC;
	Thu, 17 Jul 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741607; cv=none; b=fte6+dQb+wHB9t03lAU2Jo+rMbY0AG4umpiCZmPFs7mJDogEIWO9sA04eKLjJXmUz1LUnP+Xu3FUNynBq7G7xaecMh5bpbBLWY3muu1m4L6geFTqUakPKvZxtXJ6I6MhdXBSdue7v7Lp4qPHudNuPhZzPckeC4NY1ItncXaEzuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741607; c=relaxed/simple;
	bh=qmgrTZUU3DNVDCwj2HKkfAB/iYDhGanP7RdwBgEkN4U=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u5pOMGlRssUld2Ie7F/i/UEGreJ4hm+eYSppLz1NRRG0ekVPDCcIsduca9aSSmcsFXcQNAcvuP0Gvo0Vx/K5Ts9h6JzTnqAOCIVpD89LQD136Dz/WCejWb3wae0iQqxOnJeoyLyOnaZT0hODHO5Tc0S346rZgf2Tnc3QfNOtsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bjRBq4Ldkz2RVsX;
	Thu, 17 Jul 2025 16:37:55 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 218D21400D4;
	Thu, 17 Jul 2025 16:40:01 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 16:40:00 +0800
Message-ID: <3e773022-8be8-42c4-9920-48336bf7c365@huawei.com>
Date: Thu, 17 Jul 2025 16:39:56 +0800
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
	<shameerali.kolothum.thodi@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: hibmcge: Add support for PHY LEDs on
 YT8521
To: Andrew Lunn <andrew@lunn.ch>
References: <20250716100041.2833168-1-shaojijie@huawei.com>
 <20250716100041.2833168-3-shaojijie@huawei.com>
 <023a85e4-87e2-4bd3-9727-69a2bfdc4145@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <023a85e4-87e2-4bd3-9727-69a2bfdc4145@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/7/17 0:42, Andrew Lunn wrote:
> On Wed, Jul 16, 2025 at 06:00:41PM +0800, Jijie Shao wrote:
>> hibmcge is a PCIE EP device, and its controller is
>> not on the board. And board uses ACPI not DTS
>> to create the device tree.
>>
>> So, this makes it impossible to add a "reg" property(used in of_phy_led())
>> for hibmcge. Therefore, the PHY_LED framework cannot be used directly.
>>
>> This patch creates a separate LED device for hibmcge
>> and directly calls the phy->drv->led_hw**() function to
>> operate the related LEDs.
> Extending what Russell said, please take a look at:
>
> Documentation/firmware-guide/acpi/dsd/phy.rst
>
> and extend it to cover PHY LEDs.
>
> 	Andrew

Sure. I'll take a look at this.

Thanks,
Jijie Shao




