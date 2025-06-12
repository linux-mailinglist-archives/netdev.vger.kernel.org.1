Return-Path: <netdev+bounces-196946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB1AD706A
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 14:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D3D7ACEE1
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07172E62C;
	Thu, 12 Jun 2025 12:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BF222571;
	Thu, 12 Jun 2025 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749731417; cv=none; b=mmDL58nqxfe6DRtWhlIS54NoEPd1/kl2yoWrDk4dFe0erspcDs09U3j9n5aeCC0J1OXtBag9e+6z9STajEL8MTFplhR0nToLBfKwPOmP9ZcyABsAiFDs9FohXaLOofUwxvVgTE3YwQOhJM4OVRC3zzqUkCQa9pFKdUwD7mT42lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749731417; c=relaxed/simple;
	bh=j69Dnf1y/6nSiAAiJLBB05fVyOzl17WJ50+9HmwlJbw=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YJq7775wWxrzTM4y46H5lr4Ug2HXzyUlICVQNAtHnhB2AlDD3QwNNPmU8poGvKhy+fwa+YV+GiPknb+ENCJg/6H6tkE3R/pIGh3qcYl/XUKbA5ASKvNVtlQlRC9Ehy0THz0y1xNlCgY0yIUL61hsTep6KcCcA3+vugCAySjqEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4bJ1yc2HDMz1GDmy;
	Thu, 12 Jun 2025 20:28:08 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F12D14020C;
	Thu, 12 Jun 2025 20:30:12 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Jun 2025 20:30:11 +0800
Message-ID: <19e6f273-7bf1-489b-b1e7-c80e85d80641@huawei.com>
Date: Thu, 12 Jun 2025 20:30:10 +0800
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
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 3/8] net: hns3: add the hns3_get_ops() helper
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20250612021317.1487943-1-shaojijie@huawei.com>
 <20250612021317.1487943-4-shaojijie@huawei.com>
 <aEq4Hvg4aaxnn7m0@mev-dev.igk.intel.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <aEq4Hvg4aaxnn7m0@mev-dev.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/6/12 19:21, Michal Swiatkowski wrote:
> On Thu, Jun 12, 2025 at 10:13:12AM +0800, Jijie Shao wrote:
>> This patch introduces a hns3_get_ops() helper to reduce the unnecessary
>> middle layer conversion. Apply it to the whole HNS3 driver.
>> The former discusstion can be checked from the link.
>>
>> Link: https://patchwork.kernel.org/project/netdevbpf/patch/20230310081404.947-1-lanhao@huawei.com/
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Like with previous patch, not introducing, but using. Still the linked
> discussion is about sth else. If you can, please rephrase commit message
> to reflect what it is really doing.
>
> Thanks
>
> [...]

ok

>

