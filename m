Return-Path: <netdev+bounces-168505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB3CA3F2F9
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 12:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFA3189F587
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC1E1F4E3B;
	Fri, 21 Feb 2025 11:34:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5692AE89;
	Fri, 21 Feb 2025 11:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740137656; cv=none; b=ugX78HigJJxvLFUHIZ2O6dGuytK3R5QT0rpQ10IyB6MiDLwT2zL2RRQ2fIAXr850wOedRen/ZsjdvE8GdyCt0PjaEARQsM7cuZzLU11LQ32DFFXofKS5um4exS+1lpLr9LGumBtGcHuHI+JcQfng+9og9gPan6l5TuXIwP+Q0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740137656; c=relaxed/simple;
	bh=XQ7i0IZBYta+l8hAFKKUD5LN00tvTMqxo7kOdnYlEXg=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lSWIpvYC+laDzEJ7hJ1YgA9pfIOPyG7Ljlwl5m3nK4QBF6/Wreq113FugORNVxA/ThPks3gHcxc78EYy2+SGmJymJWVVWj0Wlx4luN8wbOWVSEKoe0eORfbbxuOc0GnQb9rKY2CXuzN4uD9Hn2Sidd7JSbrE6NTzmbP/x4fSSTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Yznzp0ClGzWyN1;
	Fri, 21 Feb 2025 19:32:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0B014140158;
	Fri, 21 Feb 2025 19:34:11 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 19:34:10 +0800
Message-ID: <8cdea7c7-6b56-4554-850f-6939327221a1@huawei.com>
Date: Fri, 21 Feb 2025 19:34:09 +0800
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
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/6] net: hibmcge: Add rx checksum offload
 supported in this module
To: Jakub Kicinski <kuba@kernel.org>
References: <20250218085829.3172126-1-shaojijie@huawei.com>
 <20250218085829.3172126-3-shaojijie@huawei.com>
 <20250220151136.2cb46929@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20250220151136.2cb46929@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/21 7:11, Jakub Kicinski wrote:
> Do you need this? Why would the stack try to set features you don't 
> support/advertize? Also you may clear SW features unnecessarily this way.

Thanks,
I will remove this in v3

Thanks,
Jijie Shao


