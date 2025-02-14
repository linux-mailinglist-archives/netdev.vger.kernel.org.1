Return-Path: <netdev+bounces-166275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB812A354FF
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 03:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EBA18913E6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 02:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7597139D1B;
	Fri, 14 Feb 2025 02:46:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293CF77F11;
	Fri, 14 Feb 2025 02:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739501199; cv=none; b=fxxk8Sg+EcVZA6pCXTaUJBtv7vtk22sJ/zHNKBx+yGR0hwoy6xFYMv9L5GT+4ziUv37VoXm79rMpDcfnokcaImbVhU/fVARMMf7DiwkkRTfiWmh2XfFaMaHdJCL0QVDnhvYpWN1Am+hy3N7sv57aB1tpelyE8mqxPFpImqGA9gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739501199; c=relaxed/simple;
	bh=r6tl0D5Ohz++OnApacxTTWWCjiyFXxwaFc8dAcN1aS0=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=l2To77wVKoj0S6iol7V5HW3Acjg18f6ALWTOEHE87KKaED09thgNjgMbBhNNXmynTLf0XALw0aVqiEXGR06BPpfOJE7MBLcXQBrhmiMSV4GVSHHDGcV15D0Jkc9WzwPMsYsr0mO9p23XlCYUdvd1SwXPTHV6Y7bUxwr9MPlznHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YvGZf4SvzzRmdp;
	Fri, 14 Feb 2025 10:43:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 72ECE180087;
	Fri, 14 Feb 2025 10:46:33 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:46:32 +0800
Message-ID: <842c3542-95a6-4112-9c50-70226b0caadc@huawei.com>
Date: Fri, 14 Feb 2025 10:46:31 +0800
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
Subject: Re: [PATCH net-next 2/7] net: hibmcge: Add self test supported in
 this module
To: Andrew Lunn <andrew@lunn.ch>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-3-shaojijie@huawei.com>
 <6501012c-fecf-42b3-a70a-2c8a968b6fbd@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <6501012c-fecf-42b3-a70a-2c8a968b6fbd@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/14 3:59, Andrew Lunn wrote:
> On Thu, Feb 13, 2025 at 11:55:24AM +0800, Jijie Shao wrote:
>> This patch supports many self test: Mac, SerDes and Phy.
>>
>> To implement self test, this patch implements a simple packet sending and
>> receiving function in the driver. By sending a packet in a specific format,
>> driver considers that the test is successful if the packet is received.
>> Otherwise, the test fails.
>>
>> The SerDes hardware is on the BMC side, Therefore, when the SerDes loopback
>> need enabled, driver notifies the BMC through an event message.
>>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Please take a look at the work Gerhard Engleder is doing, and try not
> to reinvent net/core/selftest.c
>
>      Andrew

I actually knew about this, but after browsing the source code, I gave up using it.

I have an additional requirement: serdes loopback and mac loopback.
However, they are not supported in net/core/selftest.c.

Thanks,
Jijie Shao


