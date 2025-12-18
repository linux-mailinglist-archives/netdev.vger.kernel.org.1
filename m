Return-Path: <netdev+bounces-245266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 001C8CC9FD2
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 02:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E89BF301D58E
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 01:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F192550D5;
	Thu, 18 Dec 2025 01:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sQ/PPclu"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9311E51E0;
	Thu, 18 Dec 2025 01:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021756; cv=none; b=HvAKfUkteC79HGjJUDPP/5qsr/Fd2aDBB3UVi3VsZ9za0NU/YNp5HCwlpbV090Dh64CWbm6e84NgSQiSRgLX2pl2h5KsnWcISOHtZ3LdlKilAPVCf4dRp18d0xpyrJaYadEAJa0v0pTvabwCUwDdImOghA2GecXNRm53AEBRGcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021756; c=relaxed/simple;
	bh=dUYjz3x4duQmDYCsRRxFLItDK5IBVEGcZKlgS+29cw4=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KakadgP50GF58e5DlX+bEPT0pVLSpf+sdsQwu5ojNP8F2oqVQX1CDaUl7LW9Zg9ckpoZzXex60rG/eicfWN28Wi8EGuPN1a9B0OVljELZXmDHcURaBu52ozHT6Iw146t9UY4XTU6Mn1wKD6AECJ2+iB7BwOVb7Swwd7CWX7+ptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sQ/PPclu; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jVUdXUUQ2l+WZpInycdq2kkefSBGPGDBrcepu3eHXVQ=;
	b=sQ/PPclujM49IYxtZPaHZ5NtUnVQEv0DD+qV9s9VQvTKIg4HaeHOx/h8StE6i78mO5JsI9Gll
	UrYHkmbNXQLEXSJ+ZBovkfi26IGgdgucKHCaoDLdRKAn2jpLOEGWxKVVxiQZXQi8fwCD6Ol9oHX
	a6r6AJYPEWfetCmc/+ihigU=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dWtV46ghtz1T4GD;
	Thu, 18 Dec 2025 09:33:32 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0745F140203;
	Thu, 18 Dec 2025 09:35:46 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 09:35:45 +0800
Message-ID: <3c82f4e1-0702-4617-b40c-d7f1cbd5a1de@huawei.com>
Date: Thu, 18 Dec 2025 09:35:44 +0800
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
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <4e884fc2-9f64-48dd-b0be-e9bb6ec0582d@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/12/17 21:53, Andrew Lunn wrote:
>> Some of our boards have only one LED, and we want to indicate both
>> link and active(TX and RX) status simultaneously.
> Configuration is generally policy, which is normally done in
> userspace. I would suggest a udev rule.
>
> 	Andrew

Yes, the PHY LED framework supports configuration from user space,
allowing users to configure their preferred policies according to their own requirements.
I believe this is the original intention of the LED framework.

However, we cannot require users to actively configure policies,
nor can we restrict the types of OS versions they use.
Therefore, I personally think that the driver should still provide a reasonable default policy
to ensure that the LED behavior meets the needs of most scenarios.


Thanks!
Jijie Shao



