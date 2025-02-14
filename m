Return-Path: <netdev+bounces-166277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B32A3550E
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5F23A1492
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 02:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45456139D1B;
	Fri, 14 Feb 2025 02:51:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12307C2EF;
	Fri, 14 Feb 2025 02:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501497; cv=none; b=G/4CxZmVXN6PwexzwwH5lpvoJP69FR1y6FiEMolSOFQiGyombBtCu1dNfs5SeX9JJKQtmwxp/gGFof//Sr0IlMDxccTlYFFjiQj8c0neXIY01q+v9AXzsa6s1RK7AGyjIJAelXZvjmG6mhwG2t/7c5qHBjpSPqwbQALBJWbpPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501497; c=relaxed/simple;
	bh=uYEvXIlH77DtDJv1meBQQGz5Emd0FgKcJraBJP49Yas=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h+MwJJNgM8r8OMvzZxCPOhrVMCY02v3tIQP4SLT2HlapOP8hguJwfmg2j2VexFqfA62EC2mL51sjyVJ6+XdiN/nsVdKqi/qBQTGMen6y4nMOLTkx0GXb7oszwQ/ML4TJPoxhgD/Dy4t+8uWaOAC+bvahOqFMH3TN9bpkaVZ69iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YvGgs0mgszgcfG;
	Fri, 14 Feb 2025 10:48:09 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C695140121;
	Fri, 14 Feb 2025 10:51:30 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:51:29 +0800
Message-ID: <7594549d-4f5f-4a46-a1c6-b341fc290a43@huawei.com>
Date: Fri, 14 Feb 2025 10:51:28 +0800
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
Subject: Re: [PATCH net-next 1/7] net: hibmcge: Add dump statistics supported
 in this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-2-shaojijie@huawei.com>
 <47e8bab3-61cb-4c5a-9b40-03011b6267b3@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <47e8bab3-61cb-4c5a-9b40-03011b6267b3@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/14 3:54, Andrew Lunn wrote:
> On Thu, Feb 13, 2025 at 11:55:23AM +0800, Jijie Shao wrote:
>> The driver supports many hw statistics. This patch supports
>> dump statistics through ethtool_ops and ndo.get_stats64().
>>
>> The type of hw statistics register is u32,
>> To prevent the statistics register from overflowing,
>> the driver dump the statistics every 5 minutes
>> in a scheduled task.
> u32 allows the counter to reach 4294967295 before wrapping. So over 5
> minutes, that is around 14,316,557 per second. Say this is your
> received byte counter? That means your line rate cannot be higher than
> 114Mbps? Is this device really only Fast Ethernet?
>
> 	 Andrew


Haha, maybe my formula is wrong and I missed a unit conversion.

Thank you very much for pointing out the error. I'll recalculate the correct value.

Jijie Shao


