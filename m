Return-Path: <netdev+bounces-144325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F0B9C68FF
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F38928421B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB09176AB6;
	Wed, 13 Nov 2024 05:59:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2412D1714CB;
	Wed, 13 Nov 2024 05:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731477580; cv=none; b=owwaGzLoBbgGJBM4oV+qBYrcj6vwSHDhmxXlH7W2Kcjanw+X1MP8RFGzLzYEAlHfpj/27kai+5hu7Tz57LXgZl2Lq3YJccIT5AOp1ofccMZsGS3dNcq+jjIbKySfUCeicy+kPQWUZs3fkEgST9tWnjPozLR3l3RzV/u3aHGbNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731477580; c=relaxed/simple;
	bh=BvH+rf27snhmMbNmo02DnMcPVzFrRKFNI8pLL6jfPCI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CF/NJEdJtinKP46bKPvHhqb3FUQhE/CQvCyOyIXQ/sLz3E0RAfrgoVVBsDoEb6yBK0BqeuttcoZLJ5OZblbvccE+bKk5D+bDhffYdGjxXxC94GNlPY1nDFC49pvqFv/bQrCqaAImHVTxe4FqyIUDqAm6lGb8XWkmIfx/AeSdJQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XpCHR4mj9z10V8n;
	Wed, 13 Nov 2024 13:57:39 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id B627E1800F2;
	Wed, 13 Nov 2024 13:59:33 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 13 Nov 2024 13:59:32 +0800
Message-ID: <e4396ecc-7874-4caf-b25d-870a9d897eb1@huawei.com>
Date: Wed, 13 Nov 2024 13:59:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shenjian15@huawei.com>, <salil.mehta@huawei.com>, <liuyonglong@huawei.com>,
	<wangpeiyang1@huawei.com>, <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the
 debugfs query result is inconsistent.
To: Jakub Kicinski <kuba@kernel.org>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
 <20241107133023.3813095-4-shaojijie@huawei.com>
 <20241111172511.773c71df@kernel.org>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20241111172511.773c71df@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2024/11/12 9:25, Jakub Kicinski wrote:
> On Thu, 7 Nov 2024 21:30:19 +0800 Jijie Shao wrote:
>> Subject: [PATCH RESEND net 3/7] net: hns3: Resolved the issue that the debugfs query result is inconsistent.
>> Date: Thu, 7 Nov 2024 21:30:19 +0800
>> X-Mailer: git-send-email 2.30.0
>>
>> From: Hao Lan <lanhao@huawei.com>
>>
>> This patch modifies the implementation of debugfs:
>> When the user process stops unexpectedly, not all data of the file system
>> is read. In this case, the save_buf pointer is not released. When the user
>> process is called next time, save_buf is used to copy the cached data
>> to the user space. As a result, the queried data is inconsistent. To solve
>> this problem, determine whether the function is invoked for the first time
>> based on the value of *ppos. If *ppos is 0, obtain the actual data.
> What do you mean by "inconsistent" ?
> What if two processes read the file at once?

inconsistent：
Before this modification,
if the previous read operation is stopped before complete, the buffer is not released.
In the next read operation (perhaps after a long time), the driver does not read again.
Instead, the driver returns the bufffer content, which causes outdated data to be obtained.
As a result, the obtained data is inconsistent with the actual data.

In this patch, ppos is used to determine whether a new read operation is performed.
If yes, the driver updates the data in the buffer to ensure that the queried data is fresh.
But, if two processes read the same file at once, The read operation that ends first releases the buffer.
As a result, the other read operation re-alloc buffer memory. However, because the value of ppos is not 0,
the data is not updated again. As a result, the queried data is truncated.

This is a bug and I will fix it in the next version.

Thanks
Jijie Shao




