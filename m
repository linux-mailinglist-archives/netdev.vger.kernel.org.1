Return-Path: <netdev+bounces-245147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 339FBCC7CA4
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBDE5308791D
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4897534E268;
	Wed, 17 Dec 2025 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EvS4qsz2"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5732134D935;
	Wed, 17 Dec 2025 13:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976734; cv=none; b=TIRFmfAZdzEQGnlPLAhmzg2BP5+MF2g3/ymrYXg6UtjD0JCMLL4eZWKjmhEyBnmA6I0wSp74LPwdeyKa1SN3CbhjuJtRpU+VAvcZ5ewLQuyCCWAODOOVSWhglibKRwU1sMejKR+tVSqUFxWBpDFVtPMbWMMgKdFOBwCw3pWwxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976734; c=relaxed/simple;
	bh=rBSLnThGYdXOJQmNwA2vsh2V2WsuUKMDD+5Am77RIPU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k2skFdfl3o/4d/7MFmW/gOhNinPAIbECnFIP1ekIojw7ITkCjfo08DCLtYZgWukAp4JDeAik9ZU+kvpTJSAM7vdPOixxBEUpkiiCmWszBxejgzK21pSmXGlMHp+IdiUteYVZVDln571zjZuG1Ev+ewNsGIJ0yAitsyxu5SD/VFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EvS4qsz2; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=q8h+7PVLmOgqTXTMkSqaOyuGn72jORseKsW7p0owwzY=;
	b=EvS4qsz2nthf3knvN7jRn2L6P3WoGPw7SdFHEfQwfWx7kiZ4TbE04Zh0GJES13trZG+fx7rWg
	0mhXR+R8Q1ryVPC2rKQiyTk1Wo68mn6goJxkHCtbr58y40GUCyAQiQZtWvQ2jCUYuS1r978+XS1
	6UJEFtSOXeXBcHCeHnSYN48=
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dWYrS4nL4z1prM3;
	Wed, 17 Dec 2025 21:03:20 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id BE71018046D;
	Wed, 17 Dec 2025 21:05:22 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 21:05:21 +0800
Message-ID: <143514a2-e538-47e2-920c-f223667cb900@huawei.com>
Date: Wed, 17 Dec 2025 21:05:20 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <d8b3a059-d877-4db6-8afb-3023b8ee5fa3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/16 15:21, Andrew Lunn wrote:
> On Mon, Dec 15, 2025 at 08:57:05PM +0800, Jijie Shao wrote:
>> fix duplex setting error for phy leds
>>
>> Fixes: 355b82c54c12 ("net: phy: motorcomm: Add support for PHY LEDs on YT8521")
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Please don't mix new development and fixes in one patchset. Please
> base this patch on net, and send it on its own.
>
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>
> Fixes are accepted any time, it does not matter about the merge
> window.
>
> 	Andrew

Yes, this is RFC, just for code review.
I sent it to net when requesting a merge.

Thanks,
Jijie Shao



