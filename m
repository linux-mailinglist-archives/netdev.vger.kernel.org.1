Return-Path: <netdev+bounces-169329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3ACA437CA
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E56B18910F7
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0D325D541;
	Tue, 25 Feb 2025 08:38:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6446C1C8607;
	Tue, 25 Feb 2025 08:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740472691; cv=none; b=br0Tmn1oGnsYB7EGMjy+PynFtDWjUqdEzbd3e/0hYBzKwXb7L1+GJMcCLn36Spikz5xrS/67pu95ID+QojOnwjgb9Dnh5xmUDHaxTDfK1h5I6JjHlSO9mjYSEgEDErjAlP68aYO4HbQ2JA1KyuOS9mzL+wSL1AvYbg1xKVFuORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740472691; c=relaxed/simple;
	bh=/1rQNvsIxFUtvXe2WIhVNnMewTk3RyEV8aZ7XXjztBU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e0UP+pDgfCHTqQbYsnPFFdpqLjCPr57DHxrq0EMVcsaRclIAlYNH3ZtYzT+ngY0zOs1CI5phBCOp9PmyVSZb02VT+6GzXLtnvGCEVVkkmPxcsQ6bLNT9bK3ybLzIMzeTgBMsV2SSQF7dkVBvWwxoLJYd22H7h080tI6cPhW0Sc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Z29pz3j6Vz1GDhb;
	Tue, 25 Feb 2025 16:33:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 3355E140203;
	Tue, 25 Feb 2025 16:37:59 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Feb 2025 16:37:58 +0800
Message-ID: <53672c20-82d1-4efa-8192-1c1d3ce15c1c@huawei.com>
Date: Tue, 25 Feb 2025 16:37:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <wangpeiyang1@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <sudongming1@huawei.com>, <xujunsheng@huawei.com>,
	<shiyongbang@huawei.com>, <libaihan@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH v3 net-next 4/6] net: hibmcge: Add support for mac link
 exception handling feature
To: Jakub Kicinski <kuba@kernel.org>
References: <20250221115526.1082660-1-shaojijie@huawei.com>
 <20250221115526.1082660-5-shaojijie@huawei.com>
 <20250224190908.1a5ba74e@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250224190908.1a5ba74e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/25 11:09, Jakub Kicinski wrote:
> On Fri, 21 Feb 2025 19:55:24 +0800 Jijie Shao wrote:
>> +	if (!(priv->stats.np_link_fail_cnt % HBG_NP_LINK_FAIL_RETRY_TIMES)) {
> This adds a 64b divide which breaks the build on some 32b arches:
>
> ERROR: modpost: "__umoddi3" [drivers/net/ethernet/hisilicon/hibmcge/hibmcge.ko] undefined!

Okay, I'll fix this in the next version.

Thanks
Jijie Shao


