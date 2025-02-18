Return-Path: <netdev+bounces-167142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF410A39033
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 02:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72243AE958
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561621DFF0;
	Tue, 18 Feb 2025 01:13:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788CD182BD;
	Tue, 18 Feb 2025 01:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739841187; cv=none; b=f219k0/k+5q07+JjTX9j7EqAY9MOKxo3KHKtBzXQXlj4l7IX6DZzhFU8KDARfTIq0qfj7xmGIgUs1xCi26qTpTLyC+0DAusGn8QsiG49Vsf18RzOQzrsy2yt4X8X3J/+knhis7s30sZ+6gvkRVRsNDQaZ7tS0OLJvLjaNsyW4AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739841187; c=relaxed/simple;
	bh=xKSunbQDy+ZdHopNpEGMjfWuv5Bb9bZaGtaJDqZHGus=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eerUO/MkJHnAo50DLfDasxw8zYmTIGKSbbVRW5Pxccbvsf6FvCa257y5l2YkX+qUJH1S4o38BzI+5ys3MqmvlSBxSuScAfhgAevpetWDjHWKWyTz2i57nuMmkelrQ8JxDUPjGTHAeij9mxl8vNUpf+rC1Jty+1CasFjYQQYqd58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YxhGy6nSPzgcB2;
	Tue, 18 Feb 2025 09:08:26 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 764FA1403A2;
	Tue, 18 Feb 2025 09:13:01 +0800 (CST)
Received: from [10.67.120.192] (10.67.120.192) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 09:12:59 +0800
Message-ID: <3c0861b7-c999-4202-b5c9-12ca714107f6@huawei.com>
Date: Tue, 18 Feb 2025 09:12:58 +0800
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
 <842c3542-95a6-4112-9c50-70226b0caadc@huawei.com>
 <9bc6a8b9-2d78-4aef-801d-21425426d3a1@lunn.ch>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <9bc6a8b9-2d78-4aef-801d-21425426d3a1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemk100013.china.huawei.com (7.202.194.61)


on 2025/2/14 21:53, Andrew Lunn wrote:
> On Fri, Feb 14, 2025 at 10:46:31AM +0800, Jijie Shao wrote:
>> on 2025/2/14 3:59, Andrew Lunn wrote:
>>> On Thu, Feb 13, 2025 at 11:55:24AM +0800, Jijie Shao wrote:
>>>> This patch supports many self test: Mac, SerDes and Phy.
>>>>
>>>> To implement self test, this patch implements a simple packet sending and
>>>> receiving function in the driver. By sending a packet in a specific format,
>>>> driver considers that the test is successful if the packet is received.
>>>> Otherwise, the test fails.
>>>>
>>>> The SerDes hardware is on the BMC side, Therefore, when the SerDes loopback
>>>> need enabled, driver notifies the BMC through an event message.
>>>>
>>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>>> Please take a look at the work Gerhard Engleder is doing, and try not
>>> to reinvent net/core/selftest.c
>>>
>>>       Andrew
>> I actually knew about this, but after browsing the source code, I gave up using it.
>>
>> I have an additional requirement: serdes loopback and mac loopback.
>> However, they are not supported in net/core/selftest.c.
> Which is why i pointed you toward Gerhard. He found similar
> limitations in the code, wanting to add in extra tests, same as you.
> Two developers wanting to do that same things, suggests the core
> should be extended to support that, not two different copies hidden
> away in drivers.
>
> Maybe my initial advice about not exporting the helpers was bad? I
> don't know. Please chat with Gerhard and come up with a design that
> makes the core usable for both your uses cases, and anybody else
> wanting to embed similar self tests in their driver.
>
> 	Andrew

OK, this patch will be removed from this patchset in v2.
I will re-send it as RFC to discuss it.

Thanks，
Jijie Shao


